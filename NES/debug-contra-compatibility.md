# 魂斗罗 ROM 兼容性调试记录

状态：[IMPLEMENTED-WORKSPACE-ONLY]
会话：contra-compatibility
症状：待识别 `F:\WOW_INTERFACE\NES` 中的魂斗罗 ROM，并验证当前 WOW_NES 转换器及 WoW Runtime 的实际兼容性。

## 假设

1. ROM 不是 Mapper 0，当前转换器会在导出前以明确原因拒绝。
2. ROM 可转换，但使用了当前 CPU 未正确实现的指令、中断或内存映射行为。
3. CPU 能持续运行，但 PPU 滚动、精灵合成或调色板行为导致画面异常。
4. 标题画面正常，但控制器锁存或组合键行为导致无法进入游戏。
5. ROM 与当前 Runtime 兼容，问题仅来自部署状态或客户端加载了旧 Runtime。

## 采集计划

- 只读识别 ROM 文件、SHA-256、iNES/NES 2.0、Mapper、PRG/CHR、mirroring 和 region。
- 使用现有 `inspect`、`export`、`validate` 建立转换前证据。
- 使用无限工坊检查、热加载并采集 CPU cycles、PPU frame、renderedFrame、错误和截图。
- 在确认具体失败点后，才添加最小诊断插桩或修改业务逻辑。
- 修复后对比修复前后证据，并由用户确认后清理本记录。

## 2026-10-17 实现证据

- ZIP 唯一 NES 成员 SHA-256：`0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5`；iNES Mapper23；PRG/CHR 各 128 KiB；初始 mirroring horizontal。
- reset vector：`$F80D`，位于 VRC4 最后固定 8 KiB bank；上电布局按 `[0,1,second-last,last]` 实现。
- `inspect-zip` compatible；临时目录 `export` 后 `validate` 通过，生成游戏包 43 个文件。
- Mapper23 报告 translation 为 `static_blocks=0`、`ir_instructions=0`、`fallback_prg_bytes=131072`；这是有意的 raw interpreter 边界，不代表全 ROM 已静态分析。
- Python 3.11 `unittest`：20 项通过。

## 2026-10-17 译码修复与工坊证据

- Mapper23 runtime 已从固定 4 KiB 区域译码改为 VRC2b/VRC4e 地址线变体锁定：首次非公共寄存器地址分别识别 `$x001/$x002/$x003` 或 `$x004/$x008/$x00C`；CHR 槽位按寄存器编号更新低/高 nibble。
- `unittest`：20 项通过；真实 ROM 重新导出并通过 `validate`。
- 临时导出的 `WoWNES_Runtime` 通过无限工坊 `check`：8 个 Lua 文件，errors/warnings 均为空；随后成功热加载运行时文件。
- 依赖游戏包热加载在工坊提交阶段超时，尚未获得 ROM 游戏注册、CPU/PPU/frame 或截图证据。

## 2026-10-17 控制流确认与脏标记修复

- 从 reset `$F80D` 开始的保守 CFG 找到 750 条指令、无冲突；魂斗罗实际写入 `$8000`、`$A000`、`$B000-$B003`、`$C000-$C003`、`$D000-$D003`、`$E000-$E003` 和 `$9000`。
- 该 ROM 的地址使用是 `$x000-$x003` 组，运行时按 VRC2b/VRC4f 类译码处理；不是 A2/A3 的 VRC4e 地址组。当时 VRC4 IRQ 尚未实现，已由 2026-10-18 的实现与验证取代。
- Mapper 23 寄存器写入现在会设置 `ppu.dirty=true`，保证 PRG/CHR/mirroring 切换后下一帧重新提交渲染缓存。
- 新增 Mapper 23 控制流寄存器写入回归断言；Python `unittest` 20 项全部通过；真实 ROM 重新导出并通过 `validate`。
- 再次尝试通过无限工坊加载 43 文件游戏包，仍在 daemon 提交阶段超时；未产生客户端运行证据。

## 2026-10-18 VRC4 IRQ 实现与验证

- `$F000/$F001` latch nibble、`$F002` control、`$F003` acknowledge 已实现；control/ack 清 pending，cycle/scanline 两种计数模式分别按 CPU cycle 与 3 dots/cycle 推进，341-dot prescaler 保留连续余数，counter 从 `$FF` 溢出后重载 latch 并置 pending。
- CPU IRQ 已合并 APU 与 mapper pending，保留 NMI 优先及 I 标志屏蔽；中断入口不清 mapper pending。mapper tick 使用包含 OAM DMA stall 的最终周期数。现有 VRC2b/VRC4e 地址变体锁定逻辑未改。
- Python 3.11 `unittest` 20 项通过。`verify_runtime.py` 现在额外生成独立 `irq-behavior-test.lua`，避免依赖字符串断言或提交完整大包才能验证 IRQ。
- 无限工坊客户端 build `5.5.4.70449`：新 runtime 8 个 Lua 文件 `check` 无错误/警告并成功 `load`；小请求真实执行 14 项 Lua IRQ 行为断言通过，返回 `passed=true`、`cycle_counter=254`、`scanline_prescaler=339`、`dma_cycles=516`、`variant=vrc4e`，耗时 5.4 ms。
- `魂斗罗.zip` 唯一 ROM 保持 SHA-256 `0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5`。本轮从 ZIP 内存重新导出，43 文件游戏包 `validate` 通过；工坊 `check` 37 个 Lua 文件无错误/警告。唯一一次游戏包 `load` 在 30 秒后 `daemon_unreachable`，随后 `status` 显示 daemon、游戏与 link 仍在线；未重复提交。

## 2026-10-18 `$F813` 客户端排查结论

- 真实客户端 `R.games` 只有 `6060e087239e`：16 KiB PRG、Mapper 0、SHA-256 `6060e087239ed301916e59a56b3756c25eb5552c4b8bb76a9b22fb1906383803`。D 盘对应 manifest/TOC 也只有 4 个 PRG shard；当前 runtime 是旧版 `R:New`，没有 Mapper state。已证实的是当前部署/注册不一致，不是历史 `$F813=FF` 原因已经证实。
- 目标魂斗罗包 `0b79e04375c0` 在本地重新导出后为 37 个 Lua 文件，`validate` 和工坊 `check` 均通过；runtime 8 文件可成功 `load`。目标 game 包两次 `load` 均在 daemon 提交阶段超时，history 没有生成该 addon 版本，客户端没有执行 `register.lua`。
- 不能把真实客户端的 `$F813=FF` 直接归因于错误/旧游戏对象。要确认历史错误原因，必须取得同一次错误的 `rom_id`/SHA、`c.mapper`/mapper 状态及按实际映射读取的 PRG 字节证据。当前本地路径加载正确，只说明本地路径流程，不排除客户端特殊缓存或部分加载。
- 当前 ROM 的实际字节也否定了固定 `F813=08` 前提：相对偏移 `0x1813` 在固定最后 bank 15 为 `0xFB`，`0x08` 只出现在 bank 0/4。因此 `$F813` 必须按当前实际 mapping 计算；现有证据不能宣称已排除 bank 映射故障、编码问题或缓存/部分加载问题。未添加无依据的 `0xFF` fallback，也未改 PRG shard 合并或 Mapper 映射。
- 目标包在客户端成功注册前，`g.prg`、`R:New(g)`、mapper state 和 `$F800-$F820` 的真实读取仍是未决项；下一次验证必须先确认 `R.games["0b79e04375c0"]` 存在且 `#g.prg==131072`。

## 未验证与限制

- 本地 Lua 5.1 mock 已按 TOC 加载 8 个 runtime 与 37 个 game Lua 文件，真实 ROM 到达标题、stage 和玩家生成流程；Start、Right、A、B 输入均经 `$4016` 轮询并产生 RAM/OAM/像素差异。详细截图及 `evidence.json` 位于 `F:\WOW_INTERFACE\NES\contra-local-evidence`。
- 本地运行回归通过：48 golden runs、151 official opcodes、17 runtime checks、15 IRQ checks；Python `unittest` 20 项通过。该结果验证此 ROM/生成包的 mock 流程，不等同于全 Mapper23 或全游戏兼容声明。
- 尚未验证真实 WoW 客户端部署/冷启动、物理键盘、声音输出、10 分钟稳定性、性能分位数、cycle/dot 精确 PPU 时序。当前阻塞点是无限工坊对 37 文件目标 game 包的 daemon 提交超时，而不是已证实的 Lua 逻辑错误。
- 本轮未将 AddOn 持久化到 D 盘，也未修改 `F:\WOW_INTERFACE` 下的 AddOn 源码副本。

## 约束

插件开发与运行验证统一通过无限工坊；游戏目录仍为唯一真源。
