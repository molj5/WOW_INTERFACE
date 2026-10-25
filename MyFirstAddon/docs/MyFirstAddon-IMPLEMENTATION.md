# MyFirstAddon 实现文档

> 插件：`MyFirstAddon`　｜　**客户端：怀旧服 · 熊猫人之谜（MoP Classic）国服「无限」客户端，5.5.4.70268，`## Interface: 50504`，界面代码基线为正式服 Mainline 12.x，游戏类型 `camelot`，Lua 5.1.4**
> 源码：`D:\World of Warcraft\_classic_\Interface\AddOns\MyFirstAddon\MyFirstAddon.lua`

---

## 1. 文件清单

### 1.1 `MyFirstAddon.toc`

```ini
## Interface: 50504
## Title: 我的第一个插件
## Notes:
## Author:
## Version: 0.1.0
## SavedVariables: MyFirstAddonDB
## OptionalDeps: WoWBridge
## X-Made-With: 无限工坊

MyFirstAddon.lua
```

要点：
- `## Interface: 50504` —— 怀旧服熊猫人之谜客户端要求的接口号，写错会被当作过期插件不加载。
- `## OptionalDeps: WoWBridge` —— 保证无限工坊的开发组件（`WB`）先加载；**不能删**。
- `## SavedVariables: MyFirstAddonDB` —— 存档变量，登出 / `/reload` 时写盘。
- 新增文件或改 toc 需要**完全重启游戏**才被发现；热加载（`load`）不受此限制。

### 1.2 `MyFirstAddon.lua`

单文件实现，约 229 行，见文末「附录 A：完整源码」。

---

## 2. 代码逐段说明

> 行号对应 `MyFirstAddon.lua` 当前版本。

### 2.1 命名空间与 WoWBridge 绑定（L1–L18）

```lua
local addonName, ns = ...
WoWBridgeNS = WoWBridgeNS or {}
WoWBridgeNS[addonName] = ns
local WB = WoWBridge and WoWBridge.Bind and WoWBridge.Bind(addonName) or { ... }
```

- 热加载时文件被重新执行，`ns` 始终是同一个表，可作为跨热加载的“状态容器”。
- 玩家没装无限工坊时，`WB` 退化为**空壳**（`Emit/Expose` 空函数，`Request` 立即回调 `(nil,"unavailable")`），插件照常运行。
- `Print` 统一为带插件名前缀的输出。

### 2.2 事件注册（L20–L27）

```lua
local events = ns.events or CreateFrame("Frame")
ns.events = events
events:UnregisterAllEvents()          -- 热加载时先清空，避免重复注册
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("INSPECT_READY")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")
```

| 事件 | 用途 |
| --- | --- |
| `ADDON_LOADED` | 初始化存档变量 `MyFirstAddonDB` |
| `PLAYER_LOGIN` | 登录提示、写登录计数、`WB:Emit("login")`（热加载不会触发，由 `OnReload` 兜底） |
| `INSPECT_READY` | 目标 inspect 数据就绪 → 刷新提示 |
| `GET_ITEM_INFO_RECEIVED` | 物品数据缓存到达 → 刷新提示 |

### 2.3 物品等级标签（L29–L37）

```lua
local itemLevelLabel = "物品等级"
local tmpl = rawget(_G, "ITEM_LEVEL")   -- 形如「物品等级 %d」
local prefix = tmpl:match("^(.-)%%d")
```

- 用全局 `ITEM_LEVEL` 反推「物品等级」这一本地化标签，避免硬编码（本客户端 `ITEM_LEVEL == "物品等级 %d"`）。

### 2.4 隐藏提示与“有效装等”读取（L39–L63）

```lua
local function EnsureTooltip()                       -- 只创建一次，存 ns.tooltip
    tip = CreateFrame("GameTooltip", "MyFirstAddonTooltip", UIParent, "GameTooltipTemplate")
    tip:SetOwner(UIParent, "ANCHOR_NONE")            -- 不显示、不干扰布局
end

local function TooltipItemLevel(unit, slot)
    tip:ClearLines()
    tip:SetInventoryItem(unit, slot)                 -- 生成该格装备提示
    -- 逐行找「物品等级 N」，命中则 tonumber 返回
end
```

- 这是本项目**最关键**的一段：装备链接只含基础等级，**有效装等（含升级）只在提示里**。

### 2.5 平均装备等级算法（L65–L92）

```lua
local function ReadUnitItemLevel(unit)
    for slot = 1, 19 do
        if slot ~= 4 and slot ~= 19 then               -- 跳过衬衫、战袍
            local link = GetInventoryItemLink(unit, slot)
            if link then
                local name, _, _, baseIL, _, _, _, _, equipLoc = C_Item.GetItemInfo(link)
                if not name then notReady = true       -- 物品数据还没缓存
                else
                    local ilvl = TooltipItemLevel(unit, slot) or baseIL   -- 优先有效装等
                    total = total + ilvl; count = count + 1
                    if slot == 16 and equipLoc == "INVTYPE_2HWEAPON" then
                        total = total + ilvl; count = count + 1            -- 双手武器占两格
                    end
                end
            end
        end
    end
    if notReady or count == 0 then return nil end
    return total / count
end
```

- 只要有任一格数据未就绪就返回 `nil`（保持「读取中」），避免显示残缺的错误平均值。
- 结果缓存于调用处使用；本函数每次调用都会重新计算（在提示/事件驱动的低频率下开销可接受）。

### 2.6 请求 inspect 与物品数据（L95–L116）

```lua
local function RequestInspect(unit)       -- GUID 维度节流 3 秒
    ... NotifyInspect(unit)
end
local function RequestTargetItems(unit)   -- 全局节流 1 秒
    for slot = 1, 19 do
        local link = GetInventoryItemLink(unit, slot)
        if link and not C_Item.GetItemInfo(link) then
            C_Item.RequestLoadItemDataByID(link)   -- 主动拉取物品数据
        end
    end
end
```

### 2.7 职业/专精与鼠标提示钩子（L118–L171）——热加载安全模式

```lua
-- 取某单位的“职业 + 天赋专精”：自己用 C_SpecializationInfo，其他玩家用观察数据（需要 inspect）
local function GetUnitClassSpec(unit)
    local ok, className, specName = pcall(function()
        local cName = UnitClass(unit)
        local sName
        if UnitIsUnit(unit, "player") then
            local index = C_SpecializationInfo.GetSpecialization()
            if index then
                local _, name = C_SpecializationInfo.GetSpecializationInfo(index)
                sName = name
            end
        else
            local specID = GetInspectSpecialization(unit)
            if specID and specID > 0 then
                local _, name = GetSpecializationInfoForSpecID(specID)
                sName = name
            end
        end
        return cName, sName
    end)
    if not ok then return nil, nil end
    return className, specName
end

if not ns.tooltipHooked then
    ns.tooltipHooked = true
    GameTooltip:HookScript("OnTooltipSetUnit", function(self)
        if ns.OnUnitTooltip then ns.OnUnitTooltip(self) end   -- 转发到“最新实现”
    end)
end

ns.OnUnitTooltip = function(self)
    local _, unit = self:GetUnit()
    if not unit or not UnitIsPlayer(unit) then return end

    -- 职业 + 天赋专精（职业已在系统的等级行里，这里补上专精）
    local className, specName = GetUnitClassSpec(unit)
    local specText = (className and specName) and (className .. " · " .. specName) or (specName or className)
    if specText then
        self:AddLine("职业天赋  " .. specText, 0.4, 0.8, 1.0)   -- 淡蓝
    end

    local level = ReadUnitItemLevel(unit)
    if level and level > 0 then
        self:AddLine(("装备等级  %.1f"):format(level), 0.25, 1.0, 0.25)   -- 绿
    else
        self:AddLine("装备等级  读取中…", 0.6, 0.6, 0.6)
        if CanInspect(unit) then
            RequestInspect(unit); RequestTargetItems(unit)
        end
    end
end
```

- **职业天赋行**：`UnitClass(unit)` 取职业名；专精自己走 `C_SpecializationInfo`、其他玩家走 `GetInspectSpecialization` + `GetSpecializationInfoForSpecID`（见设计文档 §5.2）。整段 `pcall` 包住，防受限状态下身份类 API 返回机密值报错。专精未就绪时只显示职业，`INSPECT_READY` 后刷新补全。
- **只挂一次钩子**：因为本客户端 `HookScript` 不能解除、`TooltipDataProcessor.RemoveTooltipPostCall` 为 nil。回调写死转发到 `ns.OnUnitTooltip`，这样每次热加载都会换成新实现，不会叠加多行。
- `GameTooltip:GetUnit()` 返回 `(name, unit)`，`unit` 是单位标记（如 `player` / `target` / `party1`）。

### 2.8 异步刷新（L173–L182）

```lua
local function RefreshUnitTooltip()
    if not GameTooltip:IsShown() then return end
    ... 节流 0.25s ...
    local _, unit = GameTooltip:GetUnit()
    if not unit or not UnitIsPlayer(unit) then return end
    GameTooltip:SetUnit(unit)     -- 重建提示 → 再次触发 OnTooltipSetUnit
end
```

- 物品/专精数据陆续到达时，如果提示**正显示某个玩家**，就用 `SetUnit` 重建，把「读取中…」/只显示职业的行替换为真实值。

### 2.9 事件处理（L184–L195）

```lua
ADDON_LOADED  → MyFirstAddonDB = MyFirstAddonDB or { logins = 0 }; ns.db = ...
PLAYER_LOGIN  → ns.db.logins++ ; Print(...) ; WB:Emit("login", {...})
INSPECT_READY / GET_ITEM_INFO_RECEIVED → RefreshUnitTooltip()
```

### 2.10 斜杠命令与 Agent 接口（L197–L219）

- `/myfirstaddon`（别名 `/mfa`）`[unit]`：打印某单位（默认 `target`）的装备等级，便于自查。
- `WB:Expose("itemLevel", fn)`：`call` 调用，`args.unit` 指定单位，返回 `{ unit, name, isPlayer, equipped }`。

### 2.11 热加载回调（L221–L229）

```lua
function ns.OnUnload() return { db = ns.db } end        -- 重跑前：交出要保留的状态
function ns.OnReload(state) ns.db = state.db or MyFirstAddonDB ; Print("已热加载") end
```

---

## 3. 使用的 API 与窗体函数清单

### 3.1 事件

| 事件 | 说明 |
| --- | --- |
| `ADDON_LOADED` | 插件数据加载完成（初始化存档变量） |
| `PLAYER_LOGIN` | 进入游戏世界 |
| `INSPECT_READY` | 观察数据就绪，参数 `inspecteeGUID` |
| `GET_ITEM_INFO_RECEIVED` | 某物品数据到达，参数 `itemID, success` |

### 3.2 客户端函数（`C_` 命名空间与全局）

| 函数 | 签名 / 用途 |
| --- | --- |
| `GetInventoryItemLink(unit, slot)` | 取某单位某装备栏的物品链接（**FrameXML 全局**，手册未收录但运行可用） |
| `C_Item.GetItemInfo(itemInfo)` | 取物品信息；第 4 个返回值为 `itemLevel`（**基础等级**）；`name` 为 nil 表示数据未缓存 |
| `C_Item.RequestLoadItemDataByID(itemInfo)` | 主动请求加载某物品数据（可由 ID / 链接） |
| `NotifyInspect(unit)` | 发起观察请求 |
| `CanInspect(unit)` | 是否可观察 |
| `GetAverageItemLevel()` | 自身平均装等（总 / 装备）。**仅用于自校验**；对 5.5.4/MoP 客户端有效，但不服务其他单位 |
| `UnitExists(unit)` / `UnitIsPlayer(unit)` / `UnitIsUnit(a, b)` / `UnitName(unit)` / `UnitGUID(unit)` | 单位判定与取值 |
| `UnitClass(unit)` | 职业：返回 `(className 本地化, classFilename, classID)` |
| `GetInspectSpecialization(unit)` | **全局**；取被观察单位的专精 ID（对自己返回 0，对他人需先 inspect） |
| `C_SpecializationInfo.GetSpecialization()` | **自己**当前天赋专精的索引 |
| `C_SpecializationInfo.GetSpecializationInfo(index)` | 由索引取 `(specId, name, description, icon, role, …)` |
| `GetSpecializationInfoForSpecID(specID)` | 由专精 ID 取 `(id, name, …)`，用于他人专精 ID → 名称 |
| `GetTime()` | 秒级时间，用于节流 |
| `C_Timer.After(sec, fn)` | 定时（仅 `WB` 空壳回退用） |

### 3.3 窗体 / 区域函数

| 函数 | 说明 |
| --- | --- |
| `CreateFrame("Frame"[, name, parent, template])` | 创建事件框体（`ns.events`）；`CreateFrame("GameTooltip", name, parent, "GameTooltipTemplate")` 创建离线提示 |
| `frame:RegisterEvent/UnregisterAllEvents/SetScript` | 事件框体注册与控制 |
| `frame:HookScript("OnTooltipSetUnit", fn)` | 挂接鼠标提示“已设置单位”脚本（**只挂一次**，见 §2.7） |
| `GameTooltip:SetOwner(owner, anchor)` | 设置提示归属与锚点（`"ANCHOR_NONE"` 用于离线读取） |
| `GameTooltip:SetInventoryItem(unit, slot)` | 生成某单位某装备栏的物品提示（用于读取有效装等） |
| `GameTooltip:ClearLines()` / `NumLines()` | 清空 / 行数 |
| `GameTooltip:GetUnit()` | 取当前提示的单位，返回 `(name, unit)` |
| `GameTooltip:SetUnit(unit)` | 重建单位提示（触发 `OnTooltipSetUnit`） |
| `GameTooltip:AddLine(text, r, g, b)` | 追加一行文本 |
| `GameTooltip:IsShown()` / `Hide()` | 显隐 |
| `_G[name.."TextLeft"..i]:GetText()` | 读取 `GameTooltipTemplate` 生成的文本行 |

### 3.4 全局字符串常量

| 常量 | 值（本客户端） | 用途 |
| --- | --- | --- |
| `ITEM_LEVEL` | `"物品等级 %d"` | 反推本地化标签「物品等级」，用于解析提示行 |

### 3.5 无限工坊（WoWBridge）

| 接口 | 用途 |
| --- | --- |
| `WoWBridge.Bind(addonName)` | 取得 `WB` 句柄（`ns.WB`） |
| `WB:Emit(topic, data)` | 向 Agent 发事件（替代 `print` 调试） |
| `WB:Expose(name, fn, doc)` | 暴露函数给 Agent 的 `call` 调用 |
| `WB:Request` | 向 Agent 提问（本插件未用，保留模板） |

> 说明：v1/v2 曾使用 `CreateFrame` + `BackdropTemplate` + `CreateFontString` + `UIPanelCloseButton` + `StartMoving/StopMovingOrSizing` + `SetBackdrop*` 等**窗口类**函数来绘制可拖动小窗；v3 已移除，改用鼠标提示，故不再创建窗口。

---

## 4. 本客户端上“不存在 / 不能用”的 API（避坑）

| 名称 | 情况 | 替代方案 |
| --- | --- | --- |
| `C_PaperDollInfo.GetInspectItemLevel` | 手册有，**运行时为 nil** | 用 `GetInventoryItemLink` + 读提示 |
| `C_TooltipInfo` / `C_TooltipInfo.GetInventoryItem` | **运行时为 nil** | 用 `GameTooltipTemplate` + `SetInventoryItem` |
| `C_Item.GetItemUpgradeInfo` / `ItemUpgradeInfo` | 结构体在手册，**取值函数运行时为 nil** | 读提示「升级：x/y」「物品等级 N」 |
| `C_Item.GetCurrentItemLevel` | 可用，但只吃 `ItemLocation`，**仅限自身装备栏** | 目标用提示法 |
| `ItemLocation.CreateFromItemLink` / `CreateFromItemID` | **不存在** | — |
| `TooltipDataProcessor.RemoveTooltipPostCall` | **不存在** | `ns.tooltipHooked` 只挂一次 |
| `C_SpecializationInfo.GetInspectSpecialization` | 手册有，**运行时为 nil** | 用全局 `GetInspectSpecialization` |
| 全局 `GetSpecialization` / `GetSpecializationInfo` | **运行时为 nil** | 自己改用 `C_SpecializationInfo.GetSpecialization` / `GetSpecializationInfo` |
| `io` / `os` / `require` / `utf8` / `table.unpack` / `goto` | Lua 5.1.4 无 | 用 `C_Timer`、`string` 等 |

---

## 5. 测试与验证记录

> 用无限工坊 MCP 工具，无需手点，逐项验证。命令即 `run_mcp` 的调用。

### 5.1 静态检查与热加载

- `check {target:"MyFirstAddon"}` → `errors: []`，1 条 warning（全局 `GetInspectSpecialization` 手册未收录；其 C_ 版运行时为 nil，故用全局）。`GetInventoryItemLink` 属手册未收录的 FrameXML 全局，为 `unresolved`，运行时实测存在。
- `load {target:"MyFirstAddon"}` → `ok: true`，每个文件 `ok: true`；返回里带 `kept.id`（可 `restore` 回退）。

### 5.2 算法自校验与专精映射

```
run (addon=MyFirstAddon):
  ns.ReadUnitItemLevel("player")  vs  select(2, GetAverageItemLevel())
→ 545.9375 == 545.9375 (equal: true)

run:
  GetSpecializationInfoForSpecID(256)                    → 256, "戒律"
  C_SpecializationInfo.GetSpecialization()               → 1
  C_SpecializationInfo.GetSpecializationInfo(1)          → 256, "戒律", role=HEALER
  GetInspectSpecialization("player")                     → 0   （对自己无效，故自己走 C_SpecializationInfo 路）
```

### 5.3 目标玩家

```
call {addon:"MyFirstAddon", name:"itemLevel", args:{unit:"target"}}
→ { name:"随便德", isPlayer:true, equipped:564 }   -- 与该玩家真实装等一致
```

### 5.4 鼠标提示

```
run: GameTooltip:SetUnit("player")  然后读 GameTooltipTextLeft1..N
→

  1  魔法筋肉人, 奥格瑞玛征服者
  2  干柴烈火门
  3  等级 90 人类 牧师（玩家）
  4  联盟
  5  职业天赋  牧师 · 戒律      ← 本插件追加的行 1
  6  装备等级  545.9            ← 本插件追加的行 2
```

- 非玩家（NPC 拍卖师巴克尔）验证：**不追加**这两行。
- 截图（`try` 的 `snap`）确认提示末尾显示这两行。

### 5.5 报错检查

```
logs {kinds:"ERR,BLOCKED"}
→ 无 MyFirstAddon 相关条目（仅其它插件 WeakAuras / TUnitFrame 的历史报错）
```

---

## 6. 运维：热加载与回退

- **热加载**：改完 `MyFirstAddon.lua` → `check` → `load`（`load` 自己也会先查语法）。不需要 `/reload`。
- **需要完整重启游戏**的情况：新增文件、改 `.toc`。
- **回退**：`history` 列出历史版本，`restore {id:...}` 回退，然后 `load`。
- **改别人的插件前**先 `checkpoint`。

---

## 7. 使用说明（游戏内）

- 把鼠标移到**玩家**单位上（目标、队友、团队、自己），鼠标提示末尾会多出两行：`职业天赋  牧师 · 戒律`（淡蓝）、`装备等级  564.0`（绿）。
- 从未观察过的玩家首次悬停可能短暂只显示「职业」（未含专精）与 `装备等级  读取中…`，数据到达后自动刷新；再次悬停即为最终值。
- 命令 `/mfa` 或 `/myfirstaddon [unit]`：在聊天框打印该单位装备等级（默认 `target`），用于自查。

---

## 附录 A：完整源码 `MyFirstAddon.lua`

```lua
-- 我的第一个插件
-- 用无限工坊开发：AGENTS.md 写了 Agent 怎么热加载、看报错、截图。
local addonName, ns = ...
WoWBridgeNS = WoWBridgeNS or {}                -- 让无限工坊热加载时把这个插件自己的命名空间交给文件
WoWBridgeNS[addonName] = ns
-- 和 Agent 对话（无限工坊）：WB:Emit(主题, 数据) 发事件给 Agent，WB:Expose(名字, 函数, 说明) 公开函数给 Agent 调用；
-- 玩家没装无限工坊时 WB 是个空壳：发事件、公开函数什么也不做，提问（WB:Request）马上回调 (nil, "unavailable")
local WB = WoWBridge and WoWBridge.Bind and WoWBridge.Bind(addonName) or {
	Emit = function() end,
	Expose = function() end,
	Request = function(_, _, _, callback) C_Timer.After(0, function() callback(nil, "unavailable") end) end,
}
ns.WB = WB

local function Print(...)
	print("|cffd8a85a" .. addonName .. "|r", ...)
end
ns.Print = Print

-- 事件：热加载会把文件再跑一遍，所以事件框体只建一次，留在 ns 里
local events = ns.events or CreateFrame("Frame")
ns.events = events
events:UnregisterAllEvents()
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("INSPECT_READY")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")

-- 物品提示里的「物品等级 N」是升级后的等级（装备链接里的只是基础等级），所以逐格读提示来算。
local itemLevelLabel = "物品等级"
do
	local tmpl = rawget(_G, "ITEM_LEVEL")               -- 形如「物品等级 %d」
	if type(tmpl) == "string" then
		local prefix = tmpl:match("^(.-)%%d")
		if prefix and prefix ~= "" then itemLevelLabel = prefix:gsub("%s+$", "") end
	end
end

local function EnsureTooltip()
	local tip = ns.tooltip
	if not tip then
		tip = CreateFrame("GameTooltip", "MyFirstAddonTooltip", UIParent, "GameTooltipTemplate")
		tip:SetOwner(UIParent, "ANCHOR_NONE")
		ns.tooltip, ns.tooltipName = tip, tip:GetName()
	end
	return tip
end

-- 从提示里取该格装备的「物品等级」（含升级）；取不到返回 nil
local function TooltipItemLevel(unit, slot)
	local tip = EnsureTooltip()
	tip:ClearLines()
	tip:SetInventoryItem(unit, slot)
	for i = 1, tip:NumLines() do
		local fs = _G[ns.tooltipName .. "TextLeft" .. i]
		local text = fs and fs:GetText()
		if text and text:find(itemLevelLabel, 1, true) then
			local lvl = text:match("(%d+)")
			if lvl then return tonumber(lvl) end
		end
	end
	return nil
end

-- 逐格读取某单位的平均装备等级：忽略衬衫(4)和战袍(19)，双手武器占主手+副手两格。
local function ReadUnitItemLevel(unit)
	local total, count = 0, 0
	local notReady = false
	for slot = 1, 19 do
		if slot ~= 4 and slot ~= 19 then
			local link = GetInventoryItemLink(unit, slot)
			if link then
				local name, _, _, baseIL, _, _, _, _, equipLoc = C_Item.GetItemInfo(link)
				if not name then
					notReady = true                           -- 该装备的物品数据还没缓存好
				else
					local ilvl = TooltipItemLevel(unit, slot) or baseIL
					if ilvl and ilvl > 0 then
						total = total + ilvl
						count = count + 1
						if slot == 16 and equipLoc == "INVTYPE_2HWEAPON" then
							total = total + ilvl
							count = count + 1
						end
					end
				end
			end
		end
	end
	if notReady or count == 0 then return nil end
	return total / count
end
ns.ReadUnitItemLevel = ReadUnitItemLevel

-- 请求查看某单位装备：INSPECT 有冷却，做点节流，别一直发
local function RequestInspect(unit)
	local guid = UnitGUID(unit)
	if not guid then return end
	local now = GetTime()
	if ns.inspectGUID == guid and now - (ns.inspectAt or 0) < 3 then return end
	ns.inspectGUID, ns.inspectAt = guid, now
	NotifyInspect(unit)
end

-- 请求某单位装备的物品数据（数据到了会触发 GET_ITEM_INFO_RECEIVED）
local function RequestTargetItems(unit)
	local now = GetTime()
	if ns.itemsRequestAt and now - ns.itemsRequestAt < 1 then return end
	ns.itemsRequestAt = now
	for slot = 1, 19 do
		local link = GetInventoryItemLink(unit, slot)
		if link and not C_Item.GetItemInfo(link) then
			C_Item.RequestLoadItemDataByID(link)
		end
	end
end

-- 取某单位的“职业 + 天赋专精”：自己用 C_SpecializationInfo，其他玩家用观察数据（需要 inspect）
local function GetUnitClassSpec(unit)
	local ok, className, specName = pcall(function()
		local cName = UnitClass(unit)
		local sName
		if UnitIsUnit(unit, "player") then
			local index = C_SpecializationInfo.GetSpecialization()
			if index then
				local _, name = C_SpecializationInfo.GetSpecializationInfo(index)
				sName = name
			end
		else
			local specID = GetInspectSpecialization(unit)
			if specID and specID > 0 then
				local _, name = GetSpecializationInfoForSpecID(specID)
				sName = name
			end
		end
		return cName, sName
	end)
	if not ok then return nil, nil end
	return className, specName
end

-- 鼠标提示（GameTooltip）：悬停玩家时加一行装备等级。钩子只挂一次，热加载靠 ns.OnUnitTooltip 转发。
if not ns.tooltipHooked then
	ns.tooltipHooked = true
	GameTooltip:HookScript("OnTooltipSetUnit", function(self)
		if ns.OnUnitTooltip then ns.OnUnitTooltip(self) end
	end)
end

ns.OnUnitTooltip = function(self)
	local _, unit = self:GetUnit()
	if not unit or not UnitIsPlayer(unit) then return end

	-- 职业 + 天赋专精（职业已在系统的等级行里，这里补上专精）
	local className, specName = GetUnitClassSpec(unit)
	local specText = (className and specName) and (className .. " · " .. specName) or (specName or className)
	if specText then
		self:AddLine("职业天赋  " .. specText, 0.4, 0.8, 1.0)
	end

	local level = ReadUnitItemLevel(unit)
	if level and level > 0 then
		self:AddLine(("装备等级  %.1f"):format(level), 0.25, 1.0, 0.25)
	else
		self:AddLine("装备等级  读取中…", 0.6, 0.6, 0.6)
		if CanInspect(unit) then
			RequestInspect(unit)
			RequestTargetItems(unit)
		end
	end
end

-- 装备数据是异步到达的：正在显示该单位的提示就重建一次，把「读取中」换成真实值
local function RefreshUnitTooltip()
	if not GameTooltip:IsShown() then return end
	local now = GetTime()
	if ns.tooltipRefreshAt and now - ns.tooltipRefreshAt < 0.25 then return end
	local _, unit = GameTooltip:GetUnit()
	if not unit or not UnitIsPlayer(unit) then return end
	ns.tooltipRefreshAt = now
	GameTooltip:SetUnit(unit)
end

events:SetScript("OnEvent", function(_, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		MyFirstAddonDB = MyFirstAddonDB or { logins = 0 }         -- 存档变量：登出或 /reload 时写盘
		ns.db = MyFirstAddonDB
	elseif event == "PLAYER_LOGIN" and ns.db then
		ns.db.logins = ns.db.logins + 1
		Print(("已加载（第 %d 次登录），把鼠标移到玩家身上可看到其装备等级"):format(ns.db.logins))
		WB:Emit("login", { logins = ns.db.logins })      -- Agent 用 events 看得到
	elseif event == "INSPECT_READY" or event == "GET_ITEM_INFO_RECEIVED" then
		RefreshUnitTooltip()
	end
end)

-- 斜杠命令 /myfirstaddon（别名 /mfa）：打印当前单位（默认目标）的装备等级，便于自查
SLASH_MYFIRSTADDON1 = "/myfirstaddon"
SLASH_MYFIRSTADDON2 = "/mfa"
SlashCmdList["MYFIRSTADDON"] = function(msg)
	local unit = (msg ~= "" and msg or "target")
	if not UnitExists(unit) then
		Print("没有选中单位。把鼠标移到玩家身上就能在提示里看到装备等级。")
		return
	end
	local level = ns.ReadUnitItemLevel(unit)
	Print(("%s 的装备等级：%s"):format(UnitName(unit) or unit, level and ("%.1f"):format(level) or "读取中…"))
end

-- 给 Agent 调用的入口（无限工坊的 call：addon MyFirstAddon，name itemLevel，args 例如 {"unit":"target"}）
WB:Expose("itemLevel", function(args)
	local unit = (args and args.unit) or "target"
	return {
		unit = unit,
		name = UnitName(unit),
		isPlayer = UnitIsPlayer(unit) and true or false,
		equipped = ns.ReadUnitItemLevel(unit),
	}
end, "返回某单位（默认 target）的装备等级")

-- 热加载：无限工坊再跑这个文件之前调用 OnUnload，跑完调用 OnReload，并把 OnUnload 的返回值交给它
function ns.OnUnload()
	return { db = ns.db }
end

function ns.OnReload(state)
	ns.db = (state and state.db) or MyFirstAddonDB
	Print("已热加载")
end
```
