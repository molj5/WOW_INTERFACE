# 设计文档 — add-nes-wow-addon-converter

## 当前实现状态（2026-10-15）

本轮另以用户本地私有 ROM 做客户端验证。来源仅为 `F:\roms-r36s\nes\大金刚1.zip`，包内成员名可记录为 `144.nes`；没有复制 ROM，也不得将其纳入公开 fixture 或发布物。ROM SHA-256 为 `6060e087239ed301916e59a56b3756c25eb5552c4b8bb76a9b22fb1906383803`，ROM ID 为 `6060e087239e`，检查结果为 iNES、Mapper 0、NROM-128、NTSC。`export` 生成的运行时包与游戏包均通过 `validate` 和 checksum 校验；游戏真源 `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_6060e087239e` 与工作区副本 `F:\WOW_INTERFACE\WoWNES_Game_6060e087239e` 各含 25 个文件且一致。

客户端热加载最新修复版后，CPU/PPU 持续推进至至少 `cycles=29207566`、`frame=980`、`renderedFrame=980`，未出现运行时错误。当前黑屏不能判定为视觉通过：新增 TGA 是在 WoW 进程启动后部署，Texture `GetTexture()` 返回 `nil`，须完整退出并重启客户端后视觉复验。程序化 `Start`、`Right`、`A` 输入分别得到 latch `8`、`128`、`1`；`$4016` 读取累计增长，并造成 RAM、OAM、nametable 差异，`A` 后 nametable 差异为 `403`，最终 `pad=0`。这些证据仅证明程序模拟输入链路，不代表真实硬件键盘验收。工坊最终 link offline；临时 `padRead` 计数包装只属于当前会话，重载或重启即消失。10 分钟稳定性、性能门槛、重启后视觉复验和硬件输入仍为待办。

工程 WOW_NES 当前以 `wow_nes.py` 标准库 Python 3.11 离线核心/CLI 落地，无 Electron/catalog/HTTP/SSE 宿主。CLI 提供 inspect、只读 inspect-zip、export、validate；未来 API 仍必须遵循 catalog_id 契约。本轮使用 `build_visual_test_rom.py` 构造自制 CC0 Mapper 0 ROM `F:\WOW_INTERFACE\NES\wownes_visual_test.nes`，SHA-256 为 `b54f90e68ebf569a1f715742006373170af309d25340ffecfea20fc8585a5383`，ROM ID 为 `b54f90e68ebf`；inspect/export/validate 均通过。新游戏包 `WoWNES_Game_b54f90e68ebf` 已部署至 D 盘游戏目录并同步至 F 盘工作区，16文件差异0。

转换器已实现严格Header边界、Mapper0镜像/vectors、保守CFG、物理bank0/offset键、单指令局部寄存器Block、扁平分片IR、原PRG兜底、三层TGA图集/UV/去重、manifest/TOC/report/checksums、外部临时生成与失败/取消rollback。覆盖两个目录采用备份和回滚，不声明跨目录全局原子性；崩溃恢复和并发路径竞争仍待加强。

Lua5.1 Interface50504模板包含Bus/CPU三级/PPU/APU/controller/scheduler/Texture池。本轮修复 scheduler 渲染饥饿及 bootstrap 热加载生命周期，18项 Python unittest 全部通过；新外部导出的 runtime/game 包通过完整 validate 和工坊 check/load。最终截图 `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-205545-690.png` 可见原创棋盘、边框、星形及中央精灵，运行状态 `frame/renderedFrame=160/160`、`cycles=4777715`、`shown=1982`。程序化 `Right` 可移动精灵，但不构成硬件键盘验收。修复版运行时仅在客户端会话热加载，F盘工作区副本已更新；D盘运行时因执行环境allowlist未覆盖而未更新，重启会回退。

当前报告定义 Draft 2020-12 Schema 字典及所用子集校验，区分拒绝/inspect/export 并约束类型、范围、必填/额外字段及身份；尚待独立发布、通用标准校验器验证和宿主类型集成。包校验可重建并交叉检查 manifest、TOC 顺序/依赖、PRG/vectors、IR/Block、CHR mapping/UV/empty 与 TGA 精确内容，重算 SHA 后的篡改测试通过；这不是任意 Lua 的通用语义证明。运行时 bootstrap 在替换全局运行时表前会停止并隐藏旧 active view，防止工坊热加载遗留的灰色 Frame 覆盖新渲染画面。

CPU模板已补齐 JSR 的低字节读取→栈 dummy read→返回地址入栈→高字节读取，RTS/RTI、PHA/PHP/PLA/PLP、BRK/NMI/IRQ 和隐含/累加器指令 dummy read；生成脚本包含16组独立字面量总线/状态黄金用例×3后端（预期48次）。CPU共用执行内核差分不是独立参考正确性证明；完整 CPU权威trace、逐cycle边界、PPU滚动/逐dot/priority/APU/DMC仍待补齐，且10分钟稳定性、NTSC实时/30FPS与p50/p95/p99性能门槛尚未验收。当前结论仅限自制 Mapper 0 可视技术演示，不扩展 Mapper。

详细测试证据、命令、SHA、真实完成/部分完成及完整待办见 `tasks.md`。用户恶魔城ZIP只读检查为Mapper2并拒绝。

## 1. 目标与非目标

### 1.1 首期目标

- 输入：仓库内一个经 `catalog_id` 定位的 `.nes` 文件。
- 范围：NTSC、Mapper 0、NROM-128/NROM-256、CHR-ROM、flags 6 battery 位为 0；若为 NES 2.0 格式，则 PRG-NVRAM shift count 还必须为 0；仅支持 8×8 Sprite。
- 输出：独立游戏 AddOn、版本化公共运行时、转换报告和文件清单。
- 执行：静态 Lua Basic Block 优先，预解码 IR 次之，解释器兜底。
- 显示：CHR Mask Atlas 驱动的 Tile/Sprite 渲染；必要时保留后续 RLE 回退接口。
- 音频：实现游戏逻辑所需的最小 APU 寄存器/IRQ语义，首期不输出声音。

### 1.2 非目标

- 不支持插件运行时读取 `.nes`、联网下载 ROM 或调用外部进程。
- 不承诺任意 ROM、PAL/Dendy、Mapper 1/2/3/4、CHR-RAM、flags 6 battery 位为 1 的 ROM、NES 2.0 PRG-NVRAM shift count 非 0 的 ROM、Zapper、扩展音频。
- 不把转换结果定义为版权清除或可公开分发的内容。
- 不在首期实现近似音效、完整逐 Dot PPU 或逐像素 60 FPS 输出。

## 2. 架构

```text
Renderer
  └─ 选择 catalog_id / 目标目录 / 选项
              │ HTTP + SSE
Python Sidecar│
  ├─ ROM Inspector
  ├─ Mapper 0 Loader
  ├─ Conservative CFG Analyzer
  ├─ Hybrid Code Generator
  │   ├─ Lua Basic Blocks
  │   ├─ Predecoded IR
  │   └─ Raw PRG fallback data
  ├─ CHR Mask Atlas Generator
  ├─ AddOn Packager
  └─ Validator / Report
              │
              ▼
目标目录
  ├─ WoWNES_Runtime/
  └─ WoWNES_Game_<rom_id>/
```

转换是业务逻辑，只能位于 Sidecar。Electron Main 仅返回目标目录；Renderer 不访问文件系统。

## 3. 生成物

```text
<dest>/
├─ WoWNES_Runtime/
│  ├─ WoWNES_Runtime.toc
│  ├─ bootstrap.lua
│  ├─ scheduler.lua
│  ├─ cpu-interpreter.lua
│  ├─ bus.lua
│  ├─ ppu.lua
│  ├─ apu.lua
│  ├─ mapper-000.lua
│  ├─ renderer.lua
│  └─ controller.lua
└─ WoWNES_Game_<rom_id>/
   ├─ WoWNES_Game_<rom_id>.toc
   ├─ manifest.lua
   ├─ prg-data-*.lua
   ├─ translated-blocks-*.lua
   ├─ fallback-ir-*.lua
   ├─ chr-map.lua
   ├─ conversion-report.json
   ├─ checksums.json
   └─ textures/
      ├─ chr-mask-1.tga
      ├─ chr-mask-2.tga
      └─ chr-mask-3.tga
```

`rom_id` 取 SHA-256 前 12 个小写十六进制字符。AddOn 目录名只允许 `[A-Za-z0-9_]`。生成过程先写 `<dest>/.wow-nes-<job_id>.tmp`，验证成功后再移动为最终目录；失败或取消时删除临时目录，不覆盖既有最终目录。用户明确选择覆盖时，先生成并验证新目录，再替换旧目录。

## 4. ROM 检查

检查器解析：

- iNES/NES 2.0 magic 与 header；
- trainer、PRG/CHR 大小、Mapper/Submapper；
- mirroring、battery、region；
- PRG 长度与 RESET/NMI/IRQ vectors；
- SHA-256。

首期接受条件：

- Mapper 为 0；
- region 为 NTSC 或 header 未指定且按 NTSC 处理；
- PRG-ROM 为 16 KiB 或 32 KiB；
- CHR-ROM 为 8 KiB；
- 无需 CHR-RAM；
- iNES/NES 2.0 flags 6 的 battery 标志未设置；
- 对 NES 2.0 格式，Header byte 10 高半字节的 PRG-NVRAM shift count 为 0；
- 文件结构完整。

检查失败返回稳定原因码，如 `UNSUPPORTED_MAPPER`、`UNSUPPORTED_REGION`、`CHR_RAM_UNSUPPORTED`、`BATTERY_UNSUPPORTED`、`PRG_RAM_PERSISTENCE_UNSUPPORTED`、`INVALID_HEADER`、`TRUNCATED_ROM`。首期以 Header 作为确定性边界：iNES/NES 2.0 flags 6 的 battery 位为 1 时返回 `BATTERY_UNSUPPORTED`；NES 2.0 byte 10 高半字节的 PRG-NVRAM shift count 非 0 时返回 `PRG_RAM_PERSISTENCE_UNSUPPORTED`。普通易失 PRG-RAM 容量不单独触发持久化拒绝。

## 5. 混合转译

### 5.1 保守控制流分析

入口为 RESET、NMI、IRQ/BRK vectors。分析器跟随：

- 顺序执行；
- 条件分支的目标与 fallthrough；
- 绝对 `JMP`；
- `JSR` 目标与返回后继。

遇到间接跳转、无法证明的目标、代码/数据歧义时停止静态扩展，不猜测指令边界。未分析字节保留在原始 PRG 数据中。

### 5.2 三级执行

1. **Lua Basic Block**：可证明边界且收益足够的 ROM 代码块；块内使用局部寄存器，末尾统一写回。
2. **预解码 IR**：已确认指令边界但不适合生成专用函数的路径；使用扁平数值数组或二进制字符串，禁止“一字段一嵌套 table”。
3. **解释器 fallback**：未知入口、间接跳转目标、RAM 执行和未预解码路径。

运行时按 `(physical_prg_bank, offset)` 查找执行单元。Mapper 0 中映射固定，但键结构保留物理 Bank，为后续 Mapper 扩展避免重做协议。

### 5.3 时序

每条执行路径必须产生相同的：

- 寄存器、Flags、PC、SP；
- 访存读写顺序；
- 基础 Cycle、Page Crossing、Branch Cycle；
- 中断检查点；
- OAM DMA 和后续 DMC Stall 接口。

Basic Block 不能跨越可能访问 PPU/APU/控制器/Mapper 的指令，也不能跨越需要响应 NMI/IRQ 的最大检查边界。运行时使用 NES Cycle Budget 和 `debugprofilestop()` Wall-Time Budget 双重切片；落后时跳过显示提交，不跳过模拟逻辑，且限制最大追帧数。

## 6. PPU 与渲染

### 6.1 语义层

首期实现 CPU 可见的 `$2000-$2007`、`v/t/x/w`、PPU Read Buffer、CIRAM/mirroring、Palette RAM、OAM/OAM DMA、VBlank/NMI、Sprite 0 Hit 所需语义。显示优化不得改变这些可见状态。

### 6.2 CHR Mask Atlas

每个 8×8 2bpp Tile 解码为索引 0～3。转换器为非零索引生成三张互斥 Alpha Mask：

- Mask 1：`pixel == 1`；
- Mask 2：`pixel == 2`；
- Mask 3：`pixel == 3`。

背景索引 0 由 Universal Background Color 表示；Sprite 索引 0 透明。运行时通过 `SetTexCoord` 选择 Mask，通过 `SetVertexColor` 应用 Palette。图集使用像素边界留白，输出映射包含每个 Tile 的 UV 和空 Mask 位图。

### 6.3 对象池

- 背景槽位以 33×31 为上限，以覆盖细滚动边缘；
- 每槽最多三层 Mask，空层隐藏；
- 64 个 Sprite，每个最多三层 Mask；
- 所有 Texture 在初始化时创建并复用，帧循环不得创建 UI 对象；
- 首期只提交脏 Tile、Palette 和 OAM 变化。

Sprite 0 Hit 由模拟器根据 PPU 数据计算，不读取 WoW UI 合成结果。

## 7. APU

首期没有声音输出，但不能把 APU 地址当作普通 RAM。运行时至少提供：

- `$4000-$4017` 寄存器写入入口；
- `$4015` 状态读取；
- Frame Counter/Frame IRQ 接口；
- DMC DMA/CPU Stall 的扩展点。

PoC 可将完整 APU 精度列为已知限制，但转换报告必须明确 `audio_output=none`，UI 不得显示“完整音画兼容”。

## 8. 输入和存档

- Frame 仅在用户显式进入游戏模式后捕获键盘；
- Escape、窗口隐藏和退出游戏模式必须清空手柄状态；
- 进入战斗自动暂停并释放键盘；
- 首期不实现 SavedVariables 存档桥；flags 6 battery 位为 1，或 NES 2.0 PRG-NVRAM shift count 非 0 的 ROM 在预检阶段拒绝；
- 不把 ROM、Atlas 或大帧缓存写入 SavedVariables。

## 9. API 与任务

拟新增契约：

- `POST /api/entries/{catalog_id}/wow-addon/inspect`：即时返回兼容性报告，不写文件；
- `POST /api/entries/{catalog_id}/wow-addon/export`：提交 X 类长任务，Body 为 `{dest_root, overwrite?}`，其中 `overwrite` 缺省为 `false`；
- 任务完成后的 `result` 包含 `rom_id`、相对 `dest_root` 的输出目录、静态块/IR/fallback 统计、图集统计、警告和 checksums；不新增独立报告查询端点；
- 任务 `progress` 严格复用统一契约，只能为 `{done,total}` 或 `null`，不编码阶段名或嵌套阶段对象。

API 只接受 `catalog_id`，由 Sidecar 解析仓库内 ROM。Renderer 通过 preload 调用 Electron Main 原生目录对话框取得 `dest_root`；Electron Main 不实现转换或路径业务校验。`dest_root` 是允许绝对路径的用户选择根目录边界参数；Sidecar 必须对仓库根、`dest_root`、临时目录和最终目录执行 realpath/commonpath 等价校验，拒绝 `..`、符号链接或目录联接造成的越界，确保目标不在当前仓库内且所有生成路径保持在目标根内。

## 10. 验证策略

### 10.1 转换器

- Header、Mapper、Vector、NROM 镜像、trainer 偏移；
- CFG 对直接分支/调用的覆盖和对间接跳转的保守停止；
- CHR bitplane 到三层 Mask 的逐像素黄金测试；
- 生成目录、TOC 顺序、路径约束、原子替换和取消清理。

### 10.2 执行一致性

同一测试程序分别经 Lua Block、IR、解释器运行，逐指令/逐块比较 PC、A/X/Y、SP、P、Cycle 和内存写入。使用公开授权的 CPU/PPU 测试 ROM；仓库不得包含商业 ROM。

### 10.3 WoW PoC 门槛

进入“常见 ROM”扩展前必须同时满足：

- Mapper 0 测试 ROM连续运行 10 分钟无状态漂移和持续内存增长；
- 模拟逻辑维持 NTSC 实时速度，显示提交至少 30 FPS；
- p95 插件每个 WoW Frame 总耗时不超过 5 ms，p99 不超过 10 ms；
- 约 3000 个常驻 Texture 可创建，1000 个脏 Region 更新 p95 不超过 5 ms；
- 战斗、隐藏、Escape 均立即暂停并释放输入；
- 静态转译、IR 与解释器差分测试全绿。

这些是项目门槛，不是 Blizzard 官方性能配额。未达标时将成果限定为单 ROM 技术演示，不进入 Mapper 1/2/3/4。

## 11. 后续路线

扩展顺序固定为 Mapper 0 → 3 → 1 → 2 → 4：

- Mapper 3：静态 CHR Bank；
- Mapper 1：PRG/CHR Bank、mirroring、PRG-RAM；
- Mapper 2：CHR-RAM profiling、Tile 字典和 Atlas Miss 回退；
- Mapper 4：PPU A12、IRQ、Timed Event、Band/RLE 回退。

每增加一个 Mapper 必须另行提交规范增量，不在首期实现中预埋未经验证的兼容声明。

## 12. 关键决策

- **ADR-1 混合转译而非纯静态转译**：纯静态方案无法可靠覆盖间接跳转、代码/数据混排和 RAM 执行；解释器兜底是正确性边界。
- **ADR-2 独立游戏 AddOn + 公共运行时**：避免每个 ROM 重复运行时代码，并允许运行时版本化验证。
- **ADR-3 Mapper 23 最小支持**：仅接受 iNES Mapper23 的 PRG/CHR-ROM；VRC4 上电 PRG `[0,1,second-last,last]`、8 KiB PRG bank、8×1 KiB CHR bank、VRC2/VRC4 地址别名、动态 mirroring 和 VRC4 IRQ 状态由每个 CPU instance 保存。Mapper23 禁用静态 IR/Block，仅 raw interpreter；支持 latch/control/ack、cycle/scanline counter 与 CPU IRQ 合并，但不据此声明完整游戏兼容。
- **ADR-4 首期静音**：WoW 无实时 PCM 接口；APU 状态语义与声音输出分离。
- **ADR-5 不把 ROM 复制进仓库或数据库**：输入保持只读，生成物仅写用户指定外部目录。

### 12.1 Mapper 23 边界（2026-10-17）

Python `Rom.physical/read` 与 Lua `R.read/step` 共用同一 VRC4 四段 PRG 语义：`$8000/$A000` 可切换，`$C000` 固定倒数第二 bank，`$E000` 固定最后 bank。CHR 通过 PPU 物理地址按 8 个 1 KiB bank 查表，Mapper23 的 B000-EFFF alias 按每个 1 KiB bank 的 low/high nibble 更新；background 和 sprite renderer 都使用当前 CHR bank 将逻辑 tile 转为物理 atlas tile。Mapper 写寄存器按 Mapper23 的 VRC2/VRC4 alias 做区域归一化，mirroring 可变为 vertical/horizontal/one-screen A/B。`R.step` 对 Mapper23 显式跳过静态 block/IR，仅执行 raw interpreter。

VRC4 IRQ 使用 `$F000/$F001` 写 latch 低/高 nibble；`$F002` 设置 enable-after-ack、enabled、cycle mode，清 pending，并在启用时重载 counter 与 341-dot prescaler；`$F003` 清 pending，并按 enable-after-ack 恢复 enabled。cycle mode 每 CPU cycle 计数，scanline mode 每 CPU cycle 累计 3 dots 并保留 341-dot prescaler 余数；counter 从 `$FF` 溢出时重载 latch 并置 pending。CPU 在 NMI 之后合并 APU/mapper IRQ，保留 I 标志屏蔽；中断入口不清 mapper pending。mapper tick 使用包含 OAM DMA stall 的最终 CPU 周期数。2026-10-18 工坊 Lua 行为测试覆盖两种地址变体、两种计数模式、ack、NMI 优先、I 屏蔽、APU 合并、pending 持续与 DMA 周期推进；这仍不是完整 ROM 游戏流程证明。

真实 ROM reset vector 为 `$F80D`，位于固定最后 bank；未对全 PRG 线性扫描当作代码。由于运行时 bank 状态会改变 CPU 地址到物理 PRG 的关系，转换器保留 raw PRG 并禁用静态 CFG/IR/Block。
