# AGENTS.md · 总工作目录（`f:\WOW_INTERFACE`）

本文件是**总工作目录**的 Agent 规则。这里存放《魔兽世界》怀旧服（熊猫人之谜）插件的文档与**源码副本**。

---

## 一、目录约定

```
f:\WOW_INTERFACE\
├── AGENTS.md                        # 本文件（总规则）
└── <插件名>\                         # 每个插件一个文件夹，文件夹名 = 插件名
    ├── lib\                         # 插件的库代码（放这里）
    ├── <插件名>.lua                  # 插件启动入口
    ├── <插件名>.toc                  # 插件启动入口
    └── docs\                        # 该插件的文档（放这里）
        ├── <插件名>-DESIGN.md        # 设计工程文档
        └── <插件名>-IMPLEMENTATION.md # 实现文档
```

---

## 二、规则（必须遵守）

1. **所有插件源码都复制一份到工作目录同放**
   - 真正的源码在游戏目录：`D:\World of Warcraft\_classic_\Interface\AddOns\<插件名>\`，**以游戏目录为唯一真源**。
   - **每次**改动游戏目录里的插件源码（`.lua` / `.toc` / `.xml` 等）后，**必须把该插件的源码（整份）同步复制一份**到工作目录的同名文件夹 `f:\WOW_INTERFACE\<插件名>\`，与该插件的文档**同放**在一起。
   - 工作目录下的是**副本**：**不要在工作目录里编辑源码**，只从游戏目录往这里复制（单向同步），避免两边不一致。
   - 新增插件时，同样在工作目录建同名文件夹，放入文档与源码副本。
2. **该插件的文档统一放在其 `docs\` 子目录**。`AGENTS.md` 要写清：源码路径、客户端环境、开发循环、关键约束与踩坑。
3. **改功能就要同步文档**：插件源码变了，就把该插件的 `*-DESIGN.md` / `*-IMPLEMENTATION.md` / `AGENTS.md` 一起更新。
4. 开发与调试统一走**无限工坊**（MCP `wuxian`：`status`/`check`/`load`/`try`/`call`/`run`/`snap`/`logs`/`api_search`），不要手改游戏里的文件，不要 `/reload` 能 `load` 的事。

---

## 三、客户端（所有插件通用）

- **类型：怀旧服 · 熊猫人之谜（MoP Classic）国服「无限」客户端**。
- 版本 `5.5.4.70268`；插件 toc 用 `## Interface: 50504`（接口号不对会被当成过期插件不加载）。
- **界面代码基线：正式服 Mainline 12.x**；游戏类型 `camelot`；运行时 **Lua 5.1.4**（无 `io/os/require/utf8/table.unpack/goto`）。

---

## 四、插件清单

| 插件 | 文件夹 | 说明 |
| --- | --- | --- |
| `MyFirstAddon` | `MyFirstAddon\` | 悬停玩家时，在其鼠标提示里显示「职业天赋（职业 · 专精）」与「装备等级」 |
| `WoWNES_Runtime` | `WoWNES_Runtime\` | NES 模拟器公共运行时（总线/CPU/PPU/APU/手柄/渲染/调度 + 基本块引擎）；文档在 `docs\` |
| `WoWNES_Game_0b79e04375c0` | `WoWNES_Game_0b79e04375c0\` | 魂斗罗（Mapper 23）数据与预编译基本块包；生成器为 `NES\wow_nes.py` / `NES\wow_nes_runtime.py` |
