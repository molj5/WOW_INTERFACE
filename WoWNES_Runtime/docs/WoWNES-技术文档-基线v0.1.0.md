# WoWNES 技术文档（初版代码基线 v0.1.0）

> **基线声明**
> 本文档描述的是 **2026-10-25 部署并通过真实客户端验收** 的代码版本，作为 WoWNES 项目的**初版代码基线（v0.1.0）**。此后所有改动都应以本文档描述的架构、数据格式、契约与验证标准为参照。
>
> 基线以 **D 盘游戏目录为唯一真源**，`F:\WOW_INTERFACE` 下为单向同步副本。文中出现的路径、哈希与计数均取自该基线状态。

---

## 1. 基线清单

### 1.1 代码与产物

| 类别 | 位置 | 文件数 | 说明 |
| --- | --- | --- | --- |
| 转换器 | `F:\WOW_INTERFACE\NES\wow_nes.py` | 1（804 行） | ROM 解析 / 分析 / 图集 / 块生成 / 导出 / 校验 / CLI |
| 运行时生成器 | `F:\WOW_INTERFACE\NES\wow_nes_runtime.py` | 1（1381 行） | 生成 8 个 Lua 运行时文件 + 闭包指令表 + 基本块代码 |
| 测试 | `F:\WOW_INTERFACE\NES\test_wow_nes.py` | 1（455 行，23 项用例） | 契约、分片、校验、代码生成、模板 |
| Runtime 插件 | `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Runtime\` | 8 个 `.lua` + `.toc` + `checksums.json` | 公共运行时 |
| 游戏插件 | `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_0b79e04375c0\` | 145 个 `.lua` + `.toc` + `conversion-report.json` + `textures/` | 魂斗罗数据与块函数 |

### 1.2 关键哈希（SHA-256 前 16 位，基线指纹）

| 文件 | 指纹 |
| --- | --- |
| `wow_nes.py` | `71AC6AC76F7705B0` |
| `wow_nes_runtime.py` | `3A5BE110B8F227AD` |
| `test_wow_nes.py` | `124C3667F74223B2` |
| `bootstrap.lua` | `C88305B68D501700` |
| `bus.lua` | `EC76AE9535A64794` |
| `cpu-interpreter.lua` | `6D5AE43476F38F80` |
| `ppu.lua` | `2855B094D3B540C1` |
| `apu.lua` | `A885E80DE76ECD46` |
| `controller.lua` | `17A5E92A6AC2984B` |
| `renderer.lua` | `5ACA0C21B94DE5B6` |
| `scheduler.lua` | `2872EE9EB8494B0D` |
| `manifest.lua`（游戏包） | `1595AF9515EE85B9` |
| `register.lua`（游戏包） | `E64049D14773B9EF` |
| `chr-map.lua`（游戏包） | `9EF915D2E4B6BB1B` |

### 1.3 目标 ROM（魂斗罗）

| 字段 | 值 |
| --- | --- |
| `rom_id` | `0b79e04375c0` |
| `sha256` | `0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5` |
| 格式 / Mapper | iNES / **23（VRC4，variant 运行时识别为 vrc2b/vrc4e）** |
| PRG / CHR | 131,072 B / 131,072 B |
| Trainer / PRG RAM | 0 B / 8,192 B |
| 镜像 | horizontal |
| 向量 | NMI=`$F889`(63625)、RESET=`$F80D`(63501)、IRQ=`$F8E1`(63713) |
| 静态基本块 | **866**（61 个 `translated-blocks-*.lua`） |
| CHR 唯一图块 | 5,200（图集 1024×1024×3 层，gutter 1） |

### 1.4 游戏包文件构成（145 个 `.lua`）

| 分片族 | 数量 | 单片内容 |
| --- | --- | --- |
| `manifest.lua` | 1 | 元数据 + 初始化 `G.prg/G.blocks/G.chr/G.tiles` |
| `prg-data-N.lua` | 32 | 4 KiB PRG 字节串，`G.prg[N]=` |
| `fallback-ir-0.lua` | 1 | `G.ir={}` 占位（历史 IR 路径保留） |
| `translated-blocks-N.lua` | 61 | 基本块函数，按 64 KiB 阈值切分 |
| `chr-data-N.lua` | 32 | 4 KiB CHR 字节串，`G.chr[N]=` |
| `tiles-data-N.lua` | 16 | 512 条 tile→atlas UV，`G.tiles[N]=` |
| `chr-map.lua` | 1 | 仅 `G.trainer`（28 B） |
| `register.lua` | 1 | `WoWNES_Runtime:Register(G)` |

包体合计约 **5,834 KB**（含 3 张 1024×1024 TGA）。

---

## 2. 系统总览

```
            魂斗罗.zip / .nes
                   │
        ┌──────────▼──────────┐
        │  wow_nes.py 转换器   │  parse → analyze → atlas → blocks → export/validate
        └──────────┬──────────┘
                   │ 生成 145 文件游戏包 + 8 文件运行时
        ┌──────────▼──────────┐
        │ D:\...\AddOns\      │  ← 唯一真源
        │  WoWNES_Runtime     │
        │  WoWNES_Game_*      │
        └──────────┬──────────┘
                   │ 单向 robocopy
        ┌──────────▼──────────┐
        │ F:\WOW_INTERFACE\   │  ← 文档 + 源码副本（不在此编辑）
        └─────────────────────┘
                   │ 无限工坊（MCP wuxian）load / run / call
        ┌──────────▼──────────┐
        │ 游戏客户端 5.5.4    │  Lua 5.1.4 沙箱
        └─────────────────────┘
```

### 2.1 插件职责

- **WoWNES_Runtime**：与具体游戏无关的 NES 运行时（总线、CPU、PPU、APU、手柄、渲染、调度）。对外暴露全局表 `WoWNES_Runtime`（简称 `R`）。
- **WoWNES_Game_\<rom_id\>**：单个 ROM 的**数据 + 预编译基本块函数**。通过 `...` 取得插件私有表 `G`，最后由 `register.lua` 调用 `R:Register(G)` 进入 `R.games[rom_id]`。

### 2.2 运行时对外接口

| 接口 | 说明 |
| --- | --- |
| `R:Register(g)` | 收编游戏表：拼接 `g.prg`/`g.chr` 分片，建立 `g.irIndex`，写入 `R.games[g.manifest.rom_id]` |
| `R:New(g)` | 创建主机实例 `c`（CPU/PPU/APU/Pad/Mapper 状态） |
| `R.Start(romId)` | 创建窗口与输入，注册 `OnUpdate`；战斗锁定/未知 ROM 返回 `false, reason` |
| `R.step(c, backend?)` | 推进一条指令或一个基本块；`backend="interpreter"` 强制走闭包路径（测试用） |
| `R.render(c)` | 把当前 PPU 状态提交到 UI |
| `R.release(c, reason)` | 停止并清理输入/提示/FPS 文本 |
| `/wownes [romId\|stop]` | 无参列出已注册 ROM |

---

## 3. 客户端环境与硬约束

| 项 | 值 / 约束 |
| --- | --- |
| 客户端 | 怀旧服·熊猫人之谜 国服「无限」，实测 `5.5.4.70579`（历史基线 5.5.4.70268） |
| 插件接口号 | `## Interface: 50504`（不匹配会被判为过期插件） |
| Lua | **5.1.4**：无 `loadstring`/`load`、`io`、`os`、`require`、`utf8`、`table.unpack`、`goto` |
| 执行限制 | 代码在受限环境运行；`run` 注入代码为 tainted，不得操作 Blizzard 面板/聊天 |
| 战斗限制 | `InCombatLockdown()` 为真时 `R.Start` 拒绝启动，运行中进入战斗立即释放 |
| 帧预算 | UI `OnUpdate` 每帧可用时间有限；单帧模拟预算 12 ms、债务上限 3 帧、单帧最多 89,342 CPU 周期 |
| 热加载 | 工坊 `load` 单文件过大（> 约 100 KB）或整包文件过多（> 约 50 个）会超时/中断；批量执行顺序不保证 |
| 真源规则 | 只改 D 盘，改后整份同步到 F 盘副本；不在 F 盘编辑源码 |

**由此产生的设计约束**

1. 不能运行时编译 → 基本块必须由 Python **静态生成**并随包投递。
2. 分片必须**自带绝对下标**，不能依赖加载顺序（见 §8.3 事故记录）。
3. 单文件必须小（CHR 4 KiB/片、UV 512 条/片、块 64 KiB/片）。

---

## 4. 转换器（`wow_nes.py`）

### 4.1 ROM 解析 `parse()`

- 上限 8 MiB；校验 `NES\x1a` magic、NES2 标记位、trainer 标志、电池存档（拒绝）、CHR RAM（拒绝）。
- 支持 Mapper **0** 与 **23**，submapper 必须为 0，区域必须 NTSC。
- Mapper 0：PRG 必须 16/32 KiB、CHR 必须 8 KiB。
- Mapper 23：PRG 按 8 KiB 整除且 ≥ 32 KiB；CHR 按 1 KiB 整除且 ≥ 8 KiB。
- 尾部多余字节拒绝（保证 `sha256` 与实际内容一一对应）。
- 产出 `Rom` 数据类：`sha256 / format / mapper / submapper / mirroring / region / prg / chr / trainer / prg_ram`。

**物理地址映射**（Mapper 23，上电布局）

```python
banks = [prg0, prg1, nb-2, nb-1]          # $8000/$A000 可切换，$C000/$E000 固定
physical(a) = (banks[(a-0x8000)//0x2000] % nb) * 8192 + (a & 0x1FFF)
```

`physical(address, state)` 支持传入运行期 bank 状态，供全布局分析使用。

### 4.2 静态分析 `analyze(rom, cancel, state)`

- 从三个向量出发做**线性扫描式 CFG 发现**（不区分可达性，按指令边界推进）。
- 记录：`instructions{pc→Instruction}`、`entries`、`stops`、`conflicts`。
- 停止原因：`OUTSIDE_ROM`、`UNOFFICIAL_OPCODE`、`WRAPPED_INSTRUCTION`、`OVERLAPPING_CODE`、`INDIRECT_JUMP`。
- **重叠代码（同一物理字节被两个不同逻辑地址当作指令边界）触发全局降级**：`instructions.clear()`，即放弃块优化、保留原始 PRG 解释执行。

### 4.3 图集 `atlas(chr_data)`

1. 以 16 B 为一 tile 去重，得到 `ids[]`（tile → unique 索引）。
2. `side` 为 ≥ `ceil(sqrt(unique))*10` 的 2 的幂（本 ROM 为 1024）。
3. 每个唯一 tile 按 10 px 网格（含 1 px gutter）放置，生成 **3 层 RGBA 掩码 TGA**（每层 1 个颜色通道），并计算 `uv=[x/s, (x+8)/s, y/s, (y+8)/s]` 与 `empty` 位（哪几层全透明）。
4. 返回 `(masks, mapping, stats)`；`mapping` 长度 = tile 数（8192），`stats` 写入报告 `atlas` 字段。

### 4.4 基本块收集 `collect_blocks(rom)`

| 步骤 | 说明 |
| --- | --- |
| 全布局分析 | Mapper 23 对 **16×16 = 256 种** `(prg0, prg1)` 组合各跑一次 `analyze`，结果并入**物理地址空间**的并集 |
| 必要入口 | 向量、分支双目标、`JSR` 目标与返回点、`JMP abs` 目标、**可能写 PRG bank 寄存器**的指令后继、**银行窗口边界**后的后继 |
| 切块规则（`_build_block`） | 从入口线性扫描；终止于：流程指令、可能写 bank 寄存器、遇到下一入口、不可达指令、8 KiB 银行窗口边缘（保留 1 字节余量）、长度上限 **128 B** |
| 切块后继 | 因长度上限被切断时返回 `cut` 后继，加入入口队列 |
| 退化 | 入口字节不是合法指令 → 不生成块；指向缺失块的直接尾调用被降级为 `blockLookup` |

**关键设计**：块以 **PRG 物理偏移** 为键，因此 256 种 bank 布局中相同的物理字节序列**共享同一个块函数**，天然规避 VRC4 运行期 bank 切换。

### 4.5 块代码生成

块函数骨架（`_block_lua`）：

```lua
P[213]=function(c)
 local k=0
 do local addr=48;local value=read(c,addr);k=k+3 end
 do local value=160;c.open=160;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 ...
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[125849](c)
end
```

- **指令内联**：操作数取自 PRG 立即数，编译期常量化；`c.open` 与 dummy read 保留总线副作用；每条指令包在 `do ... end` 中以规避 Lua 5.1 **200 局部变量上限**。
- **周期**：累加进块级 `k`，页交叉惩罚按 `page` 标志 +1。
- **八类出口**（`_block_exit_lua`）：

| 出口 | 语义 | 后续分派 |
| --- | --- | --- |
| `fall` | 顺序落入下一地址 | 已知目标直接尾调用，否则 `blockLookup` |
| `branch` | 相对跳转（8 种条件） | 命中/不命中分别尾调用或 `blockLookup`（按 `band(c.pc,8191)` 判定） |
| `jsr` | 压栈 + 跳转 | 目标可静态确定则尾调用 |
| `jmp` | 绝对跳转 | 同上 |
| `jmpind` | 间接跳转（含 6502 页内回绕 bug） | 必走 `blockLookup` |
| `rts` / `rti` / `brk` | 返回/中断 | `blockLookup` |

- **统一收尾 `_tick_then`**：先 `blockTick(c,k)`，`st==1` 表示预算耗尽回调度器，`st==2` 交 `blockLookup` 注入中断后继续链，否则直接尾调用下一块。
- **分片**：`block_lua_files(..., shard=65536)` 按 64 KiB 阈值切分，每片带 `BLOCK_HEADER`（预取 `R.read/write/push/pop/flag/nz/interrupt/blockTick/blockLookup` 与 `P=G.blocks`）。

### 4.6 分片导出协议

| 文件 | 内容格式 | 备注 |
| --- | --- | --- |
| `manifest.lua` | `local _,G=...;G.manifest=<lua table>;G.prg={};G.blocks={};G.chr={};G.tiles={}` | 元数据 + 清空容器 |
| `prg-data-N.lua` | `local _,G=...; G.prg[N+1]="\ddd..."` | 4 KiB/片 |
| `chr-data-N.lua` | `local _,G=...; G.chr[N+1]="\ddd..."` | 4 KiB/片 |
| `tiles-data-N.lua` | `local _,G=...` + 512 行 `G.tiles[K]={["uv"]={...},["empty"]=E}` | 512 条/片 |
| `translated-blocks-N.lua` | `P[phys]=function(c) ... end` | 61 片 |
| `chr-map.lua` | `local _,G=...;G.trainer="\ddd..."` | 仅 trainer |
| `register.lua` | `local name,G=...;G.name=name;WoWNES_Runtime:Register(G)` | **必须最后加载** |

**toc 顺序**：`manifest → prg-data-* → fallback-ir-* → translated-blocks-* → chr-data-* → tiles-data-* → chr-map → register`。

> ⚠️ **强制约定**：所有分片写**显式绝对下标**。见 §8.3。

### 4.7 包校验 `validate_package(path)`

校验是**重算式**的，逐文件与生成器输出比对：

1. `checksums.json` 全量 SHA-256；toc 身份与报告一致。
2. toc 行序严格等于约定顺序，且 `.lua` 集合完全匹配。
3. 解码 `prg-data-*`/`chr-data-*`：正则 + **下标必须等于分片序号** + 长度等于报告字段。
4. `chr-map.json` 与重算 `atlas()` 的 `mapping` 一致；`tiles-data-*` 文本与重算结果逐字节一致。
5. `manifest.lua`/`register.lua` 文本与模板逐字节一致。
6. 重跑 `executable_data()`，所有块分片内容与统计字段（`translation`）一致。
7. `chr-mask-*.tga` 与重算掩码一致；`atlas` 统计一致。

错误码统一抛 `ConversionError(code)`。

### 4.8 CLI

```
WOW_NES inspect <rom>            # 仅解析并输出报告（不可用 ROM 也返回 compatible=false）
WOW_NES inspect-zip <zip>        # 从压缩包内取第一个 .nes
WOW_NES validate <package-dir>   # 校验已生成插件目录
WOW_NES export <rom> --dest D --repository F [--overwrite]
```

`export` 额外规则：源文件必须在 `--repository` 内、拒绝符号链接/重解析点、**目标路径含 `addons` 时拒绝**（安装必须走工坊）、先写临时目录再发布、失败回滚。

---

## 5. 运行时（8 个 Lua 文件）

### 5.1 `bootstrap.lua` — 运行时骨架

- 兼容式取用全局 `WoWNES_Runtime`（重复加载不丢状态）。
- 位运算：`bit.band/bor/bxor`（客户端提供）；标志工具 `R.flag(p,mask,on)`、`R.nz(p,v)`。
- `R:Register(g)`：
  - `g.prg` / `g.chr` 若为表则 `table.concat`（分片收集）；
  - 建立 `g.irIndex`（历史 IR 索引，块引擎下不参与执行）；
  - 注册到 `R.games[g.manifest.rom_id]`。
- `R:New(g)` 初始状态：

| 字段 | 初值 |
| --- | --- |
| A/X/Y/S/P | `0/0/0/253/36`（P 的 bit5 常 1） |
| PC / cycles | `vectors.reset` / `7` |
| `mapper` | `prg0=0,prg1=1,chr={0..7},mirroring=manifest.mirroring,irq={latch=0,counter=0,prescaler=341,...}` |
| `prgB` | `{prg0*8192, prg1*8192, (nb-2)*8192, (nb-1)*8192}`（slot→物理基址缓存） |
| 内存 | RAM 2 KiB / SRAM 8 KiB（trainer 拷入 SRAM 尾部） |
| `stats` | `{block=0, ir=0, fallback=0}` |

### 5.2 `bus.lua` — 总线、Mapper 23、块引擎 tick

**CPU 内存映射**

| 地址 | 行为 |
| --- | --- |
| `$0000-$1FFF` | 2 KiB RAM（镜像） |
| `$2000-$3FFF` | PPU 寄存器（8 字节镜像） |
| `$4000-$4017` | APU / `$4014` OAM DMA / `$4016` 手柄 |
| `$4020-$5FFF` | open bus |
| `$6000-$7FFF` | PRG RAM 8 KiB |
| `$8000-$FFFF` | PRG ROM（经 `prgB` 解析） |

- **open bus**：`c.open` 记录最近一次总线值；未映射读返回它，手柄读保留高 5 位。
- **OAM DMA**：`$4014` 写触发 256 字节搬运，`c.stall += 513 + c.cycles%2`。
- **Mapper 23 写寄存器**（按 `a//4096` 分区）：
  - `$8000` → `prg0`，同步 `prgB[1]`；`$A000` → `prg1`，同步 `prgB[2]`；
  - `$9000` → 镜像模式；
  - `$B000-$E000` → 8 个 1 KiB CHR bank（高低半字节选择）；
  - `$F000` → IRQ latch / control / ack。
  - `variant` 首次写时按低半字节识别 `vrc2b` / `vrc4e`。
- `R.mapperTick(c,n)`：VRC4 IRQ 递减/重装（可 cycle 模式）；`c.irqAny` 由 APU IRQ 与 mapper pending 合成。
- `R.periphTick(c,n)`：一次调用完成 `apuTick + mapperTick`。
- **块引擎 tick**：
  - `R.blockTick(c,k)`：`k += stall`；累加 cycles；`ppuTick(3k)` + `periphTick(k)`；返回 `1`（预算耗尽）/`2`（需注入中断）/`false`。
  - `R.blockLookup(c)`：先注入 NMI/IRQ（含其周期与 PPU/外设推进），再按当前 `prgB` 查块表，命中执行，未命中回退 `R.step`。

### 5.3 `cpu-interpreter.lua` — 指令语义与双引擎分派

- `R.ops`：**217 条**操作码元数据（151 条官方 + 66 条 unofficial），由 `lua_value(OPS)` 内联。
- `R.interrupt(c, vector, brk)`：标准 7 周期序列（`brk` 时多一次 dummy read、P 的 B 位置位）。
- `R.execute(c, op, operand)`：通用解释器，逐指令精确移植（含页交叉惩罚、izy/izx dummy read、间接跳转页内回绕）。
- **闭包表 `R.exec`**：`exec_table(OPS)` 为每条操作码生成 **217 个** `E[op]=function(c) ... end`，按值捕获 `read/write/push/pop/flag/nz`；比 `R.execute` 少一次大 if-链分派。
- **`R.step(c, backend)` 分派优先级**：

```lua
1) c.nmi                      → R.interrupt(c, $FFFA)
2) c.irqAny and I 标志为 0     → R.interrupt(c, $FFFE)
3) backend ~= "interpreter" 且 pc >= $8000
     → 查 c.g.blocks[prgB[pc>>13 - 3] + (pc & $1FFF)]
      命中：c.tickFinish = c.cycles + (R.slice or 2048); stats.block++; 执行块函数
4) pc >= $8000 → 从 PRG 直接取指令字节（不经 read）
5) R.exec[op] 命中 → 闭包（stats.ir++）；否则 R.execute（stats.fallback++）
6) 统一收尾：cycles += n + stall；ppuTick(3n)；periphTick(n)
```

`R.slice` 是**测试钩子**：缩小它可让块路径与逐指令闭包路径在相同周期粒度上对齐比较。

### 5.4 `ppu.lua` — PPU

- 寄存器模型：`ctrl/mask/status/oamAddr/v/t/x/w/buffer/latch`；`nt[0..2047]`、`pal[0..31]`、`oam[0..255]`；`dot/scanline/frame/dirty/rendering`。
- **Loopy 寄存器**：`$2005` 两次写更新 `t` 的 coarse/fine X/Y；`$2006` 两次写更新 `t` 后 `v=t`；`$2000` 写更新 `t` 的命名表位。
- **CHR 映射**：Mapper 23 下 `ppuMemory` 先按 1 KiB bank 换算 `(chr[bank]%128)*1024`；`chrTile` 类似处理 8×8 图块编号。
- **PPU 读缓冲**：`$2007` 读返回缓冲，缓冲区随后填充；调色板区读直接返回（**高 2 位**与 latch 合并）。
- **`ppuTick(c, dots)`**：`target<=340` 走快速路径（不可能跨扫描线）；否则逐段推进，处理 341 dot/行、262 行/帧、`scanline 241` 置 VBlank 并**触发 NMI**、`scanline 261` 清 VBlank/溢出/命中。
- **Sprite-0 命中**：`spriteZero` 在渲染行逐像素比对，命中置 `status` bit6。
- **背景像素**：`backgroundPixel` 按 `v/t/x`、镜像、属性表 quadrant 计算 tile 与调色板。

### 5.5 `apu.lua` — 音频（静音）

- 只实现**寄存器与 IRQ 时序**：4 通道长度计数器、`$4015` 使能、`$4017` frame counter（4/5 分频、IRQ inhibit）、`$4015` 读状态。
- `apuTick` 按 29,830 / 37,282 周期推进 frame sequencer，必要时置 `c.irqAny`。
- DMC：仅保留 `dmcStall` 注入点，**无采样播放、无 DMC IRQ**。

### 5.6 `controller.lua` — 手柄与释放

- 标准 strobe/latch/移位；`padRead(port)` 保留 `c.open` 高 5 位。
- `R.release(c, reason)`：停止运行、复位手柄、关闭键盘捕获、隐藏提示与 FPS 文本。

### 5.7 `renderer.lua` — 渲染

两条路径，按 TGA 是否可用自动选择：

| 路径 | 条件 | 实现 |
| --- | --- | --- |
| **Atlas**（默认） | `probe:GetTexture()` 非空 | 固定槽池 **1215 个**（背景用 `33×31=1023` 个，索引 1..1023；精灵用 1025..1152，8×16 时上下半各占一槽），每槽 3 层 Texture；按 `G.tiles` 的 UV 提交 8×8 区域；`cache[key]` 去重 |
| **Pixel fallback** | TGA 不可用 | 逐像素读 PPU 合成 512×480（256×240 ×2），同色 run 合并为矩形，Texture 池 + cache 复用 |

- 固定 64 色调色板常量表（NES 实际色）；`color(index)` 转 0..1 浮点。
- 精灵：支持翻转、8×16、背景优先级、OAM 顺序、左边缘裁剪（`mask` bit2/bit1）。
- 每帧结束置 `p.dirty=false`。

### 5.8 `scheduler.lua` — 调度、FPS 显示、生命周期

```lua
c.debt = min(c.debt + elapsed, 3/60.0988)      -- 最多 3 帧债务
work   = floor(c.debt * 1789773)               -- NTSC CPU 时钟
while c.cycles < finish
  and c.cycles - before < 89342                -- 单帧周期上限（≈3 帧）
  and debugprofilestop() - start < 12 do       -- 12 ms 时间预算
  R.step(c)
end
```

- 渲染节流：PPU 帧号变化且距上次渲染 ≥ 0.03 s（约 30 Hz）才 `R.render`，并记录 `lastRenderMs`。
- FPS 文本每 0.5 s 刷新：`"%.1f FPS  %.1fms render"`（模拟 FPS = 帧号差 / 墙钟）。
- 异常：`pcall` 捕获后 `R.release` 并记录 `c.error`。
- 生命周期：`OnHide` / `PLAYER_REGEN_DISABLED`（进战斗）/ 重启 / `/wownes stop` 均释放。
- 键位：`Z=A`、`X=B`、`RSHIFT`、`ENTER=START`、方向键；`ESCAPE` 退出。

---

## 6. 执行模型与正确性契约

### 6.1 双引擎

| 引擎 | 触发 | 计数 |
| --- | --- | --- |
| 基本块 | `pc >= $8000` 且块表命中 | `c.stats.block` |
| 闭包指令 | 块未命中，`R.exec[op]` 命中 | `c.stats.ir` |
| 通用解释器 | 闭包未命中（未定义/极少见） | `c.stats.fallback` |

基线实测（`R.Start` 后约 30 s）：`stats.block≈3.2 万` 次块调用、`stats.ir≈65 万` 条闭包指令、`fallback=0`。按块均长约 10 条指令估算，块路径覆盖约 1/3 执行指令，其余走闭包解释器（多为块表未覆盖的路径）——这是后续提频的主要空间。

### 6.2 预算与链式执行

- `R.step` 进入块前设 `c.tickFinish = c.cycles + (R.slice or 2048)`（默认 2048 周期）。
- 块尾 `blockTick` 在超过 `tickFinish` 时返回 `1`，链式执行展开回调度器 → 保证单次 `R.step` 延迟有界（避免长链卡住一帧）。
- 返回 `2` 时由 `blockLookup` 注入中断并继续链。

### 6.3 NMI/IRQ 松弛（**重要设计取舍**）

- 块内不响应中断，**延迟到块尾**（`blockTick` 检查 `c.nmi` / `c.irqAny`）。
- 后果：块尾可能多执行若干迭代（若中断原本发生在块中间），导致**指令流整体时间平移**、压栈垃圾不同、个别写操作落点前移。
- 语义仍然等价：被延迟的中断处理完成后，两条流在写序列与最终状态上汇合。
- 因此**等价性标准从「逐指令周期精确」放宽为「帧缓冲级 + 边界移位匹配」**。

### 6.4 等价性验证契约（v3 状态机）

| 模式 | 行为 |
| --- | --- |
| `strict` | 中断窗口之外：BLOCK 边界必须与 CLOSE 边界**同周期、全字段一致**（含写校验和 `wsum`） |
| `resync` | 注入窗口内：按**核心状态** `(pc,a,x,y,s,p,prg0,prg1,ctrl,mask)` 重锁，要求连续 12 次匹配且 `(dcyc,dwsum)` 稳定 |
| `locked` | 锁定后按 `(dcyc,dwsum)` 移位匹配；允许 ±128 周期的 `dcyc` 漂移重导；失败回 `resync` |

- `wsum = (wsum + (a%65536)*131 + (v%256)*37) % 1000000007`（写地址/值滚动校验和）。
- **终验**：每帧 `pattern(0..12287) + palette(16128..16159) + OAM(0..255)` 滚动哈希逐帧比对。
- 已知允许的偏移来源：块尾响应 NMI 时多跑自旋循环 → `dcyc=+10`、`dwsum=10845`；RTI 后补写使 `dwsum` 变为 1961（纯压栈垃圾差异），需 `resync` 重锁而非报错。

---

## 7. 验证体系

### 7.1 单元测试（23 项，全绿）

覆盖：操作码元数据、ROM 解析拒绝矩阵、报告契约、CFG（分支/JSR/间接跳转）、映射/向量/trainer/sha、NES2 持久化区域、导出/校验/取消/覆盖、发布失败回滚、分片与物理键、块代码生成（Mapper 23、Lua 5.1 语句合法、NOP 空块）、闭包表、Mapper 23 运行时契约、跨语义重算校验、渲染调度、FPS 显示模板、输入诊断模板、图集黄金样本等。

运行：`py -3.11 -m unittest test_wow_nes -v`（约 22 s）。

### 7.2 90 帧等价验证（`wownes_equiv90.py`）

| 指标 | 结果 |
| --- | --- |
| 比较的块边界 | **19,475** |
| 中断注入 | **176**（88 次 NMI × 双引擎） |
| 模式收尾 | `resync`/`locked` 全程无 mismatch |
| 帧缓冲哈希 | **90/90 完全一致** |
| 结论 | `90-FRAME EQUIVALENT` |

关键修复记录：

1. 中断包装器必须安装在**整个 runtime 之后**（`cpu-interpreter.lua` 会重定义 `R.interrupt`，早装会被覆盖，导致注入列表为空）。
2. `locked-miss` 需回落 `resync`：RTI 补写引起的 `dwsum` 跳变可发生在注入点 1 万周期之后，超出 `INJECT_WINDOW=4096`。
3. 记录批量导出用 `table.concat`，避免逐条 `lua.eval` 的数量级开销；每个 chunk 后重置 `injLog`。

### 7.3 本地性能基准（lupa Lua 5.1，30 帧预热 + 60 帧计时）

| 引擎 | 60 帧耗时 | FPS | cycles/s | 相对实时 |
| --- | --- | --- | --- | --- |
| BLOCK | 7.86 s | 7.6 | 341,070 | 0.19× |
| CLOSE | 19.87 s | 3.0 | 134,917 | 0.08× |
| **加速比** | — | — | **2.53×** | — |

### 7.4 客户端实测（build 5.5.4.70579，已进世界、非战斗）

| 窗口 | 时长 | 模拟帧 | FPS | cycles/s | 相对实时 | 渲染 |
| --- | --- | --- | --- | --- | --- | --- |
| W1 | 24.07 s | 519 | 21.6 | 641 K | 0.36× | 16.5 ms |
| W2 | 28.43 s | 873 | 30.7 | 914 K | 0.51× | 11.8 ms |
| W3 | 27.84 s | 1144 | 41.1 | 1223 K | 0.68× | 10.8 ms |
| **合计** | 80.34 s | 2536 | **31.6** | **939 K** | 0.52× | 10.7–16.5 ms |

与上一版（闭包分派，15.6–17.5 FPS / 486–521 K cycles/s）相比约 **1.9 倍**；本地 2.53 倍的收益被未优化的渲染耗时（10–16 ms/帧）摊薄。

### 7.5 数据完整性自检（客户端内）

注册后可在游戏内用滚动哈希与期望值比对，作为**热加载是否错位**的快速判据：

| 数据 | 公式 | 期望值 |
| --- | --- | --- |
| CHR | `h=(h*33+b)%2147483647`，遍历 `g.chr` | **507240010** |
| tiles | `h=(h*33+Σround(uv[i]*1e6)*w_i+empty*19)%2147483647`，权重 1/7/13/17 | **941393793** |

基线复验：`chrHash=507240010 / tilesHash=941393793`，与期望一致。

---

## 8. 开发与部署循环

### 8.1 标准流程

1. 改生成器（`wow_nes.py` / `wow_nes_runtime.py`）或运行时模板。
2. `py -3.11 -m unittest test_wow_nes` 全绿。
3. 重新生成 145 文件包并**整体替换** D 盘游戏包目录；Runtime 文件覆盖写入。
4. 工坊 `load WoWNES_Runtime`（8 文件，一次可完成）。
5. 游戏包**分批按文件**热载：`load <插件>/<文件>`；全量整包 `load` 会超时中断。
6. `load .../register.lua` 注册；用 §7.5 哈希自检；`R.Start(romId)`。
7. `snap` 截图 + 间隔采样 `GetTime()`/`ppu.frame`/`c.cycles` 验收。
8. **单向同步** D→F（robocopy `/MIR`），更新文档。

### 8.2 工坊工具用法（MCP `wuxian`）

| 工具 | 用途 |
| --- | --- |
| `status` | 链路/会话/槽位；`link.state=online` 才可继续 |
| `load {target, reset, timeout_ms}` | 热加载插件或单文件；返回每文件结果 |
| `run {code, addon?}` | 执行 Lua 片段；`addon` 时 `...` 为该插件命名空间表 |
| `call {addon, name, args}` | 调用 `WB:Expose` 暴露的函数（需玩家授权） |
| `logs {since, kinds}` | 读 ERR/OUT/RUN/SNAP 等 |
| `snap {region?, max_width?}` | 截图 |

### 8.3 事故记录：分片乱序导致花屏（必修课）

- **现象**：块引擎部署后 CPU 运行正常（帧数正常、无 Lua 错误），但画面图块全错。
- **根因**：`chr-data`/`tiles-data` 分片最初用 `G.chr[#G.chr+1]=` / `G.tiles[#G.tiles+1]=` **追加**，依赖执行顺序；工坊批量 `load` 的执行顺序不保证（日志中 `chr-data-4` 先于 `chr-data-0` 执行）。
- **定位**：滚动哈希与期望值比对（`513714402/740920852` vs 期望 `507240010/941393793`）。
- **修复**：全部改为**显式绝对下标**（`G.prg[N]`/`G.chr[N]`/`G.tiles[N]`），校验器同步强制「下标 == 分片序号」。
- **结论**：任何热加载分片都必须自带绝对下标；`table.concat` 依赖 1..n 连续键，显式下标同时保证了这一点。

**其他已记录坑**

| 问题 | 结论 |
| --- | --- |
| 整包 `load` 97 文件 | 约 48 个文件处被 daemon 超时中断；必须分批 |
| 单文件 > 约 100 KB | 传输超时；CHR 拆 4 KiB、UV 拆 512 条 |
| `R.interrupt` 包装被覆盖 | 包装必须装在整个 runtime 之后 |
| 块内 NMI | 只能块尾响应，等价性按帧缓冲级验收 |
| 战斗锁定 | `InCombatLockdown()` 时无法启动，需先脱战 |

---

## 9. 已知限制与未实现项

### 9.1 精度与兼容性

- APU **无音频输出**；DMC 无采样播放、无 DMC IRQ；APU IRQ 时序近似。
- PPU 逐 dot 近似：`spriteZero` 在快速路径中按区间判定；部分边界行为（如精确的 `$2007` 读写缓冲细节）为近似实现。
- 仅支持 **Mapper 0 / 23**、NTSC、无电池存档、无 CHR RAM、submapper 0。
- 8×16 精灵、背景优先级等已实现；**未实现**：MMC3、扩展音频、4 屏 VRAM、精确的 OAM 溢出时序。
- 静态分析遇**重叠代码**或**间接跳转**会停止推进（间接跳转不生成块，运行时经 `blockLookup`/解释器执行）。

### 9.2 性能

- 60 FPS 需 1,789 K cycles/s；基线客户端约 939 K（0.52×）。
- 主要瓶颈：① 渲染 10–16 ms/帧（30 Hz 节流）；② 约 2/3 执行指令仍走闭包解释器（块覆盖不足）。
- 已知可提升方向：提高块覆盖率（消除块表未命中路径）、渲染批量化/降低 Texture 数量、适当上调模拟预算（需先降渲染耗时）。

### 9.3 工程约束

- 无法在运行时编译代码 → 任何翻译层都必须离线生成并随包投递。
- 客户端 UI 线程内运行，帧预算硬限制；`R.step` 的链长必须由 `R.slice` 约束。
- **部署产物 ≠ `export` 完整产物**：当前 D 盘目录由部署脚本按 toc 清单重写（145 个 `.lua` + `.toc` + `conversion-report.json`，外加 `textures/`），**不含** `chr-map.json` 与 `checksums.json`。因此 D 盘目录不能直接跑 `WOW_NES validate`；完整校验以转换器 `export` 生成的临时包为准（它在 `validate()` 内部执行）。如需对已部署目录做完整校验，需先补齐这两个文件。

---

## 10. 性能优化史（摘要）

| 阶段 | 关键改动 | 客户端 FPS | 客户端吞吐 |
| --- | --- | --- | --- |
| fallback 渲染器 + 4 ms 预算 | 像素回退、10 Hz 显示上限 | 5.5 | — |
| atlas 渲染器 + 12 ms 预算 + FPS 显示 | Texture 图集路径激活 | 6.0–8.0 | — |
| 闭包分派全量优化 | `R.exec` 151 闭包、`prgB` 缓存、`ppuTick` 快速路径、`irqAny` 合并、`periphTick` 合并、30 Hz 渲染 | **15.6–17.5** | 486–521 K |
| **基本块引擎（本基线）** | 866 块 / 61 分片、块尾中断、`blockTick` 预算、CHR+UV 分片 | **21.6–41.1（均值 31.6）** | 641 K–1223 K（均值 939 K） |

---

## 11. 附录

### 11.1 转换错误码（节选）

`INVALID_HEADER`、`ROM_TOO_LARGE`、`TRUNCATED_ROM`、`TRAILING_DATA_UNSUPPORTED`、`BATTERY_UNSUPPORTED`、`CHR_RAM_UNSUPPORTED`、`UNSUPPORTED_MAPPER`、`UNSUPPORTED_SUBMAPPER`、`UNSUPPORTED_CONSOLE`、`UNSUPPORTED_REGION`、`UNSUPPORTED_MIRRORING`、`UNSUPPORTED_ROM_SIZE`、`UNSUPPORTED_PRG_RAM_SIZE`、`PRG_RAM_PERSISTENCE_UNSUPPORTED`、`UNSUPPORTED_HEADER_FEATURE`、`OUTPUT_EXISTS`、`INVALID_OUTPUT_TARGET`、`UNSAFE_PATH`、`TARGET_INSIDE_REPOSITORY`、`INPUT_OUTSIDE_REPOSITORY`、`GAME_INSTALL_REQUIRES_WORKSHOP`、`INVALID_SHARDS`、`INVALID_TOC_ORDER`、`INVALID_LUA_DATA`、`INVALID_CHR_DATA`、`INVALID_PRG_LENGTH`、`INVALID_MANIFEST`、`INVALID_REGISTRATION`、`INVALID_UV`、`INVALID_ATLAS`、`INVALID_TRANSLATION_STATS`、`INVALID_EXECUTABLE_DATA`、`INVALID_REPORT_SCHEMA`、`INVALID_REPORT_IDENTITY`、`INVALID_PACKAGE_DATA`。

### 11.2 游戏表 `G` 结构（注册后）

```lua
G.name       = "WoWNES_Game_0b79e04375c0"
G.manifest   = { schema_version, converter_version, sha256, rom_id, format, mapper,
                 mirroring, region, prg_bytes, chr_bytes, trainer_bytes, prg_ram_bytes,
                 vectors={nmi,reset,irq}, translation={...}, atlas={...}, ... }
G.prg        = <131072 字节字符串>          -- Register 内 table.concat
G.chr        = <131072 字节字符串>          -- Register 内 table.concat
G.tiles      = { [1..8192] = {uv={x1,x2,y1,y2}, empty=N} }
G.trainer    = ""
G.blocks     = { [物理偏移] = function(c) ... end }   -- 866 项
G.ir         = {}                            -- 历史 IR 占位
G.irIndex    = { [0] = {...} }               -- Register 建立
```

### 11.3 主机实例 `c` 关键字段

| 字段 | 说明 |
| --- | --- |
| `a,x,y,s,p,pc,cycles` | CPU 状态 |
| `ram/sram/ppu/apu/pad/mapper` | 各子系统状态 |
| `prgB` | slot→PRG 物理基址（bank 写时更新） |
| `nmi` / `irqAny` | 中断待处理标志 |
| `stall` | DMA/APU 附加停顿，下一次 tick 消化 |
| `tickFinish` | 块链周期上限（`R.slice`） |
| `open` | open bus 值 |
| `stats` | `block / ir / fallback` 计数 |
| `debt / target / running / renderedFrame / lastRenderAt` | 调度状态 |
| `view` | 渲染窗口（`pool/cache/pixelPool/hint/fps/lastRenderMs`） |

### 11.4 相关文档

- [WoWNES_Runtime-DESIGN.md](WoWNES_Runtime-DESIGN.md) — 设计记录与部署状态
- [WoWNES_Runtime-IMPLEMENTATION.md](WoWNES_Runtime-IMPLEMENTATION.md) — 实现与实测记录（含逐次优化细节）
- [WoWNES_Game 转换规格](../../NES/specs/nes-wow-addon-export/spec.md)
