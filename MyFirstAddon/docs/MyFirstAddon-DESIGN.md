# MyFirstAddon 设计工程文档

> 插件：`MyFirstAddon`（“我的第一个插件”）
> 位置：`D:\World of Warcraft\_classic_\Interface\AddOns\MyFirstAddon\`
> 开发方式：无限工坊（MCP `wuxian`）+ WoWBridge 热加载

---

## 0. 客户端环境（重要）

- **客户端类型：怀旧服 · 熊猫人之谜（World of Warcraft: Mists of Pandaria Classic）**，国服「无限」客户端。
- 客户端版本：`5.5.4.70268`；插件 toc 声明 `## Interface: 50504`。
- **界面代码基线：正式服 Mainline（12.x）UI**。因此本客户端同时具备“熊猫人之谜”的内容与“现代正式服”的界面框架，可使用 `C_Item`、`BackdropTemplate`、`TooltipDataProcessor`、`Enum.TooltipDataType` 等现代 API。
- 游戏类型（GameType）：`camelot`（插件必须能被该类型加载，否则游戏不加载）。
- 运行时：**Lua 5.1.4**。没有 `io` / `os` / `require` / `utf8` / `table.unpack` / `goto` / 位运算符；文件 UTF-8；全局表 `_G`。
- API 手册版本：`2026.10.08.2`（手册基于客户端自带文档 + exe Usage 字符串 + 无限图鉴）。

> 结论：写本插件时“按熊猫人之谜的玩法/装备体系，按正式服 12.x 的界面 API”来写。

---

## 1. 目标与最终形态

**功能**：把鼠标移到某个**玩家**身上时，在该单位的鼠标提示（`GameTooltip`）末尾追加两行：

```
职业天赋  牧师 · 戒律
装备等级  564.0
```

- **职业天赋**：该玩家的职业与**天赋专精**（形如「职业 · 专精」）；
- **装备等级**：该玩家的**平均装备等级**（含装备升级后的有效装等）。

非玩家单位（NPC / 怪物）**不追加**这两行。

**形态决策**：不使用独立窗口，直接并入系统鼠标提示，避免占用界面。

---

## 2. 需求演进（决策记录）

| 版本 | 形态 | 说明 |
| --- | --- | --- |
| v1 | 独立小窗口，显示**自己**的装备等级 | 初版，`GetAverageItemLevel()` |
| v2 | 独立小窗口，显示**选中玩家目标**的装备等级 | 仅当 `target` 是玩家时显示，否则隐藏 |
| v3 | **并入鼠标提示** | 去掉独立窗口；悬停玩家时在 `GameTooltip` 加一行装备等级 |
| v4 | **提示里再加「职业天赋」**（当前） | 悬停玩家时展示其职业 + 天赋专精 |

---

## 3. 系统架构

单文件插件：

```
MyFirstAddon/
├── MyFirstAddon.toc      # 插件信息 + 文件列表
├── MyFirstAddon.lua      # 全部实现
└── AGENTS.md             # 给 Agent 的开发说明（无限工坊模板）
```

- **命名空间**：文件头 `local addonName, ns = ...`；`WoWBridgeNS[addonName] = ns`。热加载时文件被重新执行，拿到的是**同一个 `ns`**。
- **热加载复用对象**（放在 `ns` 里，避免重复创建）：
  - `ns.events`：事件框体（只 `CreateFrame` 一次）。
  - `ns.tooltip` / `ns.tooltipName`：用于读取装备提示的隐藏 `GameTooltip`。
  - `ns.tooltipHooked`：提示钩子是否已挂（只挂一次）。
  - `ns.inspectAt` / `ns.itemsRequestAt` / `ns.tooltipRefreshAt`：各类节流时间戳。
- **与 Agent 通信**：`WB:Emit`（发事件）、`WB:Expose`（暴露函数给 `call`）、`WB:Request`（提问）。

---

## 4. 数据流

```
用户在游戏里把鼠标移到某玩家单位上
        │
        ▼
系统 UI 调用 GameTooltip:SetUnit(unit)
        │
        ▼
触发 GameTooltip 的 "OnTooltipSetUnit"
        │
        ▼
ns.OnUnitTooltip(self)
   ├─ local _, unit = self:GetUnit()
   ├─ if not UnitIsPlayer(unit) then return end     -- NPC 不显示
   ├─ className, specName = GetUnitClassSpec(unit)   -- 职业 + 专精
   │     └─ self:AddLine("职业天赋  职业 · 专精", 淡蓝)   -- 专精没取到则只显示职业
   ├─ level = ReadUnitItemLevel(unit)               -- 计算平均装等
   ├─ 有值  → self:AddLine("装备等级 %.1f", 绿色)
   └─ 无值  → self:AddLine("装备等级  读取中…", 灰色)
              + NotifyInspect(unit) / 请求物品数据
        │
        ▼
物品/专精数据异步到达（INSPECT_READY / GET_ITEM_INFO_RECEIVED）
        │
        ▼
RefreshUnitTooltip(): 若提示仍显示该玩家 → GameTooltip:SetUnit(unit) 重建
        （节流 0.25s，把「读取中…」/「职业」替换成真实值）
```

---

## 5. 平均装备等级算法

口径对齐暴雪内置 `GetAverageItemLevel()`：

1. 遍历装备栏 `slot = 1..19`；
2. **跳过 4（衬衫）与 19（战袍）**；
3. 每格取该装备的**有效物品等级**（含升级）；
4. 主手（`slot == 16`）若为双手武器（本地化装备位字符串 `INVTYPE_2HWEAPON`），则**主手+副手占两格**：数值累加两次、格数 +2；
5. **平均 = 数值总和 / 格数**。

### 5.1 有效装等的来源（本项目最关键的设计点）

- `GetInventoryItemLink(unit, slot)` 拿到的**装备链接只含“基础物品等级”**（例：`528`）。
- **升级后的“有效装等”**（例：`536`）**只有物品提示里才体现**：提示行为「物品等级 536」+「升级：2/2」。
- 做法：用一个**隐藏的 `GameTooltip`** 逐格 `SetInventoryItem(unit, slot)`，从提示行里读取「物品等级 N」。
- **自校验**：对自身用本算法得到 `545.9375`，与 `GetAverageItemLevel()` 的装备装等**完全相等**；对目标玩家「随便德」得到 `564.0`，与其真实装等一致。

### 5.2 职业 / 天赋专精的来源

**职业名**：`UnitClass(unit)` → `(className, classFilename, classID)`，取本地化 `className`。

**天赋专精**（分两条路，因为本客户端没有“任意单位的专精”单一 API）：

| 目标 | 取法 |
| --- | --- |
| 自己（`player`） | `C_SpecializationInfo.GetSpecialization()` → 索引；`C_SpecializationInfo.GetSpecializationInfo(index)` → `(specId, name, …)` |
| 其他玩家 | 全局 `GetInspectSpecialization(unit)` → `specID`；`GetSpecializationInfoForSpecID(specID)` → `(id, name, …)`（**需 inspect**） |

两者拼成「职业 · 专精」显示；专精未就绪时只显示职业，`INSPECT_READY` 后自动补全。整段用 `pcall` 包住。

---

## 6. 关键约束与设计决策

1. **客户端没有“单位平均装等”API**：`GetAverageItemLevel()` 只服务自己；手册里存在的 `C_PaperDollInfo.GetInspectItemLevel` 在本客户端**运行时为 nil（不存在）**。
2. **`C_Item.GetCurrentItemLevel` 只能用于自己**（需要 `ItemLocation:CreateFromEquipmentSlot`），无法用于其他单位；`ItemLocation` 只有 `CreateEmpty / CreateFromBagAndSlot / CreateFromEquipmentSlot`，**没有 `CreateFromItemLink`**。
3. **链接不含升级信息**，因此必须读物品提示才能得到有效装等。
4. **目标装备数据异步到达**：`INSPECT_READY` 到达时往往链接已有、但 `GetItemInfo` 尚未缓存 → 需要「读取中…」占位 + 事件驱动刷新。
5. **提示钩子只能挂一次**：本客户端 `TooltipDataProcessor.RemoveTooltipPostCall` 为 nil，且 `HookScript` 无法解除；若每次热加载都挂就会叠加多条。→ 用 `ns.tooltipHooked` 只挂一次，回调统一转发到每次热加载都会重写的 `ns.OnUnitTooltip`。
6. **专精 API 名称有坑**：全局 `GetInspectSpecialization(unit)` 可用，但 `C_SpecializationInfo.GetInspectSpecialization` 运行时为 nil；自己取专精用 `C_SpecializationInfo.GetSpecialization()` / `C_SpecializationInfo.GetSpecializationInfo(index)`，而全局的 `GetSpecialization` / `GetSpecializationInfo` 为 nil。职业/专精的取用包在 `pcall` 里（受限状态下 `UnitClass` 等可能返回机密值）。
7. **秘密值（secret values）**：怀旧服无限客户端中，战斗中/受限状态下玩家自己的 `UnitHealth`/`UnitPower` 等是机密值（不可比较、运算、拼接）。**本插件不读取这些**；装备等级是从装备提示解析出的本地数值，安全。

---

## 7. 限制

- 若客户端无法获得目标的升级信息（未 `inspect` / 超出距离 / 阵营限制），提示里显示的是**链接基础等级**，可能与对方自己看到的有效装等略有差异。
- **专精同理依赖 `inspect`**：拿不到专精时，「职业天赋」行只显示职业（不含专精）。
- 首次悬停一个从未 `inspect` 过的玩家，可能短暂显示「读取中…」，数据到达后自动刷新；再次悬停即为最终值。

---

## 8. 迭代记录

| 版本 | 日期 | 变更 |
| --- | --- | --- |
| v1 | — | 独立窗口显示自身装备等级（`GetAverageItemLevel`） |
| v2 | — | 改为显示选中玩家目标装等；引入 `GetInventoryItemLink` 逐格求和算法 |
| v3 | — | 去掉独立窗口，改为在鼠标提示追加一行；修正为读取物品提示的“有效装等”；加入异步刷新与热加载安全的钩子模式 |
| v4 | — | 鼠标提示再加一行「职业天赋（职业 · 专精）」：自己用 `C_SpecializationInfo`，其他玩家用 `GetInspectSpecialization` + `GetSpecializationInfoForSpecID` |

---

## 9. 验证结论（摘要，详见实现文档）

- 自身：算法值 `545.9375` == `GetAverageItemLevel()` 装备装等；专精 `GetSpecializationInfoForSpecID(256)` → `戒律`。
- 自身提示实测（`SetUnit("player")`）：末两行为 `职业天赋  牧师 · 戒律`、`装备等级  545.9`。
- 目标玩家「随便德」：`564.0`，与真实一致。
- NPC 目标：不追加这两行（正确）。
- `check` 0 error（1 warning：全局 `GetInspectSpecialization` 手册未收录，但 C_ 版运行时为 nil，故用全局）；`load` 成功；`logs` 无本插件报错。
