# WoWNES Runtime 实现记录

> 代码基线（v0.1.0）的完整技术说明见 [WoWNES-技术文档-基线v0.1.0.md](WoWNES-技术文档-基线v0.1.0.md)；本文按时间顺序记录实现与实测过程。

## 2026-10-25 基本块级 Lua 函数方案落地（Mapper 23）

把「每基本块一个 Lua 函数」从设想做成随包投递的真实产物，并在真实客户端实测。

### 生成器与 Runtime

- **块收集与代码生成**（`wow_nes_runtime.py` 的 `collect_blocks` / `block_lua_files`）：对 PRG 全组合布局做 CFG 分析，按 866 个基本块生成 `translated-blocks-0..60.lua`（61 分片）；块键用 **PRG 物理偏移**（`mapper23_physical_prg_offset`），bank 切换不改写块表，规避 VRC4 运行时切换。
- **块函数结构**：块内指令序列内联（操作数常量化、直接 `read/write/push/pop`），周期数累加进局部 `k`；出口统一 `blockTick(c,k)`，返回 1（预算耗尽）/2（需注入中断）时交回 `blockLookup`，否则尾调用下一块 `P[target](c)`。
- **`R.step` 块表优先**：`pc>=0x8000` 时查 `c.g.blocks[c.prgB[...]+band(pc,8191)]`，命中即执行，未命中回退闭包解释器（`fallback` 计数区分）。
- **NMI 松弛**：中断响应延迟到块尾（`blockTick` 返回 2 → `blockLookup` 在块边界注入），等价性标准由「逐指令周期精确」放宽为「帧缓冲级 + 边界移位匹配」。

### 验证

- `test_wow_nes.py`：**23/23 通过**（新增块代码生成、Lua 5.1 语句合法性、分片与物理键等断言）。
- **90 帧等价验证器 v3**（`Temp\wownes_equiv90.py`，三态状态机 strict/resync/locked）：
  - 19,475 个块边界比较、176 次中断注入（88 NMI × 双引擎）全部对齐；
  - 每帧 pattern+nametable+palette+OAM 哈希 **90/90 完全一致** → `90-FRAME EQUIVALENT`。
  - 关键修复：中断包装器必须装在**整个 runtime 之后**（`cpu-interpreter.lua` 重定义 `R.interrupt` 会冲掉早装的包装）；RTI 补写导致的 `dwsum` 跳变可发生在注入点 1 万周期后，`locked-miss` 需回落 `resync` 重锁，否则误报。
- **本地性能**（lupa lua51，30 帧预热 + 60 帧计时）：BLOCK **7.6 FPS / 341K cycles/s** vs CLOSE 3.0 FPS / 135K = **2.53 倍**；`stats` 显示 fallback=0。

### 包体分片（热加载必需）

工坊热加载对单文件大小敏感：原 `chr-map.lua` 1.14MB、拆分后仍 614KB（`G.tiles` 8192 条 UV），单次 `load` 均超时（链路约 6–10 KB/s）。因此把这两块也分片，包体从 44 → **145 文件**：

- `chr-data-0..31.lua`：CHR ROM 按 4 KiB 切片，**显式下标** `G.chr[N]=...`，`Register` 内 `table.concat`。
- `tiles-data-0..15.lua`：tile→atlas UV 映射每片 512 条，**显式下标** `G.tiles[N]=...`。
- `prg-data-0..31.lua` 同样改为显式下标 `G.prg[N]=...`。
- `chr-map.lua` 只剩 `G.trainer`；`manifest.lua` 初始化 `G.prg/G.blocks/G.chr/G.tiles`。
- toc 顺序：manifest → prg-data → fallback-ir → translated-blocks → chr-data → tiles-data → chr-map → register。

> **踩坑（2026-10-25 画面花屏）**：最初分片用 `G.chr[#G.chr+1]=` / `G.tiles[#G.tiles+1]=` 追加，隐含「按顺序执行」假设。工坊批量 `load` 多文件时 job 实际执行顺序并不保证（日志中 `chr-data-4` 比 `chr-data-0` 先执行），结果 CHR 与 UV 表整体错位：CPU 代码（PRG）正常、画面图块错乱。用滚动哈希定位——期望 `chrHash=507240010 / tilesHash=941393793`，实际 `513714402 / 740920852`。改为显式下标后与执行顺序无关，重载后哈希完全一致。**结论：任何热加载分片都必须自带绝对下标，不能依赖加载顺序。**

### 部署与客户端实测（build 5.5.4.70579，已进世界、非战斗）

部署：Python 生成 145 文件写 D 盘真源 → 工坊 `load WoWNES_Runtime`（8 文件）+ 游戏包逐文件热载（97 个整包 `load` 会因超时被中断，改为分批按文件续传）→ `register.lua` 注册成功（prg=131072、chr=131072、blocks=866、tiles=8192、mapper=23）→ `R.Start('0b79e04375c0')`。

三段独立采样（`GetTime()` + `ppu.frame` / `c.cycles` 差值）：

| 窗口 | 时长 | 模拟帧 | 模拟FPS | cycles/s | 相对实时 | 渲染 |
|---|---|---|---|---|---|---|
| W1 | 24.07s | 519 | 21.6 | 641K | 0.36x | 16.5ms |
| W2 | 28.43s | 873 | 30.7 | 914K | 0.51x | 11.8ms |
| W3 | 27.84s | 1144 | 41.1 | 1223K | 0.68x | 10.8ms |
| **合计** | 80.34s | 2536 | **31.6** | **939K** | 0.52x | 10.7–16.5ms |

**优化前后对比**（同一 FPS 显示、同一 atlas 渲染路径、同为标题画面）：

| 指标 | 闭包分派（优化前） | 基本块（优化后） | 变化 |
|---|---|---|---|
| 模拟 FPS | 15.6–17.5 | 21.6–41.1（均值 31.6） | **约 1.9 倍** |
| 吞吐 | 486–521K cycles/s | 641K–1223K（均值 939K） | 约 1.9 倍 |
| 渲染耗时 | 9.6–15.7ms | 10.7–16.5ms | 基本不变（未改渲染） |

差距来源：本地 2.53 倍的收益在客户端被未优化的渲染耗时（10–16ms/帧）摊薄；`stats` 显示约 2/3 执行指令仍走闭包解释器（块表未覆盖的代码路径），继续提频需提高块覆盖率与渲染优化。

## 2026-10-25 闭包分派优化（Mapper 23 性能）

目标：让魂斗罗接近 60 FPS。分析后放弃转换器侧静态翻译块（WoW 无 `loadstring`，静态块无法应对 VRC4 运行时 bank 切换，且需重投 14MB 游戏包），改为纯 Runtime 侧优化，游戏包零改动。

### 改动清单（全部在 `wow_nes_runtime.py` 生成器）

- **按操作码闭包分派**：Python 生成 151 个专用闭包 `E[op]=function(c)...end` 拼入 cpu-interpreter.lua，`R.exec=E`；`R.step` 快速路径 `local f=R.exec[op]`，命中即执行，未命中回退 `R.execute`。语义（ADC/SBC 溢出、BIT、CMP、页交叉惩罚、总线读序）逐指令精确移植自 `R.execute`。
- **Mapper 23 PRG bank 基址缓存**：`c.prgB={[1]=prg0,[2]=prg1,[3]=nb-2,[4]=nb-1}`（1 基索引）；`prgOffset` 与 `R.step` 快速取指用 `c.prgB[floor(a/8192)-3]` 直查，bank 写寄存器（$8000/$A000）时同步更新。注意索引是 `-3`（0x8000→1、0xC000→3），初版 `-4` 是 off-by-one，导致 90 帧等价性全不一致，已修复。
- **ppuTick 快速路径**：`target=dot+dots<=340` 时不进 while 循环直通；PPU mask 渲染使能缓存为 `p.rendering`（ppuWrite $2001 时更新）；扫描行内 sprite 0 守卫内联。
- **IRQ 合并位**：`c.irqAny` 缓存 `apu.irq or mapper.irq.pending`，在 6 个 setter 点（mapperWrite reg2/reg3、apuWrite $4007 inhibit、apuRead、apuTick、mapperTick）同步；`R.step` 检查降为单次表访问。
- **periphTick 合并**：`R.periphTick(c,n)` 一次调用完成 apuTick+mapperTick，每指令省一次 Lua 调用。
- **read 分支重排**：PRG 分支（`a>=32768`）提前到第二位（RAM 之后），匹配实际访问频率。
- **渲染 30Hz 节流**：`now-(c.lastRenderAt or 0)>=0.03` 才调 `R.render`，省出的时间给模拟预算。

### 验证

- `py -3.11 -m unittest test_wow_nes`：21 项全过（`test_mapper23_runtime_contract` 断言更新为闭包/prgB/irqAny/periphTick/rendering 新契约）。
- **等价性**（`Temp\wownes_equiv_check.py`）：旧 Runtime（12ms+FPS 版）与新 Runtime 各跑魂斗罗 90 帧，逐帧 CPU/PPU/RAM/nametable/OAM/palette/mapper 全状态滚动哈希 → **90/90 帧全一致**。
- **本地性能**（lupa，`Temp\wownes_perf_check.py`）：旧 803–825K cycles/s → 新 945–954K（+16%）；阶段消融显示 CPU 核心 74%、ppuTick 20%。

### 部署与实测（真实客户端 build 70579）

- `wownes_deploy_runtime2.py` 生成 9 文件写 D 盘并重算 checksums.json；工坊 `load WoWNES_Runtime` 8 文件全部成功；`R.Start('0b79e04375c0')` 启动。
- 实测（标题画面，atlas 路径 pixelFallback=false）：
  - **模拟 FPS 15.6–17.5**（优化前 6.0–8.0，约 2.7 倍）
  - 闭包命中 100%：block≈240 万步、fallback=0、err=nil
  - 吞吐 486–521K cycles/s（墙钟）；打满 12ms 预算墙（60Hz UI × 12ms → 上限 17.6 FPS）
  - 渲染 9.6–15.7ms/帧（30Hz 节流）
  - 截图：标题地球/星空/2631 高分画面正常（`C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-134205-157.png`）
- 满预算满速推算约 675K cycles/s（解释器 525K，1.29 倍）。

### 距离 60 FPS 的剩余差距

60 FPS 需 1789K cycles/s，当前满速约 675K，还差约 2.65 倍。剩余手段（按 ROI）：

1. 渲染优化（当前 9.6–15.7ms×30Hz ≈ 0.3–0.47s/s，砍半可让预算利用率 +20%）。
2. 基本块级 Lua 函数（每基本块一个函数、共享取指流、块级 tick）：需生成器侧静态生成（WoW 无 loadstring）、bank 切换用块内 slot 相对基址、NMI 响应延迟到块尾（等价性标准需放宽为帧缓冲级），并重新生成/投递游戏包。
3. 提高模拟预算（12ms→14ms 需先解决渲染耗时）。

## 2026-10-25 真实客户端验收与 FPS 显示

生成来源 `F:\WOW_INTERFACE\NES\wow_nes_runtime.py`。本轮完成 D 盘真源部署、客户端重启加载、atlas 路径首次激活与实测，并新增画面左上角 FPS 显示。

### FPS 显示实现

- renderer：`NewView` 创建 `f.fps` FontString（FRIZQT 12 OUTLINE，绿色，TOPLEFT 偏移 6,-6）。
- controller：`R.release` 同步隐藏 fps 文本。
- scheduler：Start 记录 `fpsSample={t,frames}`；OnUpdate 渲染处包裹 `debugprofilestop()` 记 `c.view.lastRenderMs`（覆盖 fallback 与 atlas 两路径）；每 0.5 秒 `SetText("%.1f FPS  %.1fms render")`。

### 部署与加载

- 临时包 `wownes-verified-xuesm0eo` 校验（Runtime 9 文件与生成器逐字节一致、SHA-256 全过、游戏包 validate 通过）后经 Python copytree 部署 D 盘（Runtime 10 文件 + 魂斗罗包 44 文件含 3 张 TGA）。
- 工坊 `check` 两插件零错误；`load` Runtime 8 文件成功；游戏包 38 文件全部在游戏内执行成功（chr-map.lua 1.1MB 拆 308 段，约 4 分钟），注册数据核实：prg=131072、chr=131072、mapper=23、tiles=8192。
- 客户端重启（pid 17832，build 5.5.4.70579）后游戏包从磁盘原生加载，TGA 可探测，`pixelFallback=false`，atlas 路径首次激活。

### 实测数据（真实客户端）

| 配置 | 模拟FPS | 渲染耗时 | WoW FPS | 分辨率 |
|---|---|---|---|---|
| fallback 渲染器 + 4ms 预算（重启前会话） | 5.5 | 50.8ms 均值（max 76.4，4517 色段） | 83.9 | 512×480 |
| atlas 渲染器 + 12ms 预算 + FPS 显示（重启后） | 6.0–8.0 | 10.2–20.5ms | ~30 | 512×480 |

- 渲染耗时 50.8ms → 10.2ms（约 5 倍），分辨率维持 256×240 原生 ×2。
- 解释器基准：525K cycles/s，满负荷上限 17.6 FPS；Mapper 23 强制 raw 解释器，为模拟帧率主要瓶颈。
- 截图证据：`F:\WOW_INTERFACE\NES\runs\2026-10-25-fallback-title.png`（fallback 标题地球/星空）、`2026-10-25-atlas-prologue.png`（atlas 开场剧情文字 + FPS 文本 6.0 FPS 10.2ms render）。
- FPS 文本实测输出 `6.0 FPS  10.2ms render` / `8.0 FPS  10.7ms render`。

### 本地回归

`py -3.11 -m unittest test_wow_nes -q`：21 项全部通过（新增 `test_fps_display_template`；更新 scheduler 渲染计时断言）。

## 2026-10-18 历史记录（fallback 优化，已被 10-25 验收覆盖）

fallback 保留完整256×240 NES像素、2×输出512×480；tile 行复用 nametable/pattern/attribute 读取；水平同色 run、Texture 池与 cache 跨帧复用；dirty/节流语义见设计文档。本地 mock 8 组 491,520 像素新旧路径一致，mock 计时（tile 行 97–110ms vs 逐像素 179–189ms）不代表客户端性能。

## 保留的功能与历史证据

全局入口为WoWNES_Runtime，游戏通过Register注册，Start及/wownes启动。输入诊断默认关闭，可用setInputDebug切换；只记录已知按键的down/up与ESCAPE，不记录padRead/padWrite。隐藏、Escape、战斗进入、重启及异常释放输入。画布下方保留按键提示。

历史自制CC0 Mapper0 ROM `F:\WOW_INTERFACE\NES\wownes_visual_test.nes`（ID b54f90e68ebf）的截图和输入验证只属于此前PoC，不能用于本次魂斗罗性能或视觉验收。
