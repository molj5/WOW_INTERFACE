# 实施任务清单 — add-nes-wow-addon-converter

状态：`[ ]` 待办 / `[~]` 部分完成 / `[x]` 完成。工程名 WOW_NES。当前独立 Python 3.11 标准库 CLI，尚无 Electron/catalog/HTTP/SSE 宿主。仅 Mapper 0 PoC，未通过性能门槛不得扩展 Mapper。

## 私有 ROM 客户端验证（2026-10-15）

- 来源仅为用户本地容器 `F:\roms-r36s\nes\大金刚1.zip`，包内成员名 `144.nes`；未复制 ROM，且不得纳入公开 fixture 或发布物。
- ROM SHA-256：`6060e087239ed301916e59a56b3756c25eb5552c4b8bb76a9b22fb1906383803`；ROM ID：`6060e087239e`；格式为 iNES、Mapper 0、NROM-128、NTSC。
- `export` 产出的两个包均通过 `validate` 与 checksum 校验。游戏真源 `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_6060e087239e` 与工作区副本 `F:\WOW_INTERFACE\WoWNES_Game_6060e087239e` 各 25 个文件，内容一致。
- 客户端已热加载最新修复版；CPU/PPU 持续推进至至少 `cycles=29207566`、`frame=980`、`renderedFrame=980`，无运行时错误。
- 当前画面为黑色，不能标记视觉通过。根因证据：新增 TGA 在 WoW 进程启动后才部署，Texture `GetTexture()` 返回 `nil`；必须完整退出并重启客户端后再做视觉复验。
- 程序化输入 `Start` / `Right` / `A` 分别对应 latch `8` / `128` / `1`；`$4016` 读取累计增长，并引发 RAM、OAM、nametable 差异，其中 `A` 后 nametable 差异为 `403`，最终 `pad=0`。这仅验证程序模拟输入，不是真实硬件键盘。
- 工坊最终状态为 link offline。临时 `padRead` 计数包装仅存在于当前会话，重载或重启后消失。
- 保留待办：完整重启后的视觉复验、10 分钟稳定性、性能门槛，以及真实硬件键盘输入验收。

## Mapper 0 可视 ROM 验证（2026-10-15）

- 自制 CC0 ROM：`F:\WOW_INTERFACE\NES\wownes_visual_test.nes`；构造脚本：`F:\WOW_INTERFACE\NES\build_visual_test_rom.py`。
- SHA-256：`b54f90e68ebf569a1f715742006373170af309d25340ffecfea20fc8585a5383`；ROM ID：`b54f90e68ebf`。
- `inspect`、`export`、`validate` 均通过；Python `unittest` 18 项全部通过。
- 新游戏包 `WoWNES_Game_b54f90e68ebf` 已部署到 D 盘游戏目录并同步到 F 盘工作区，16 个文件逐文件比对 `missing=0 / extra=0 / changed=0`。
- 客户端运行已修复 scheduler 渲染饥饿，以及 bootstrap 热加载后旧 Frame 残留灰框。最终截图：`C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-205545-690.png`，可见棋盘、边框、星形和中央精灵；采样状态 `frame/renderedFrame=160/160`、`cycles=4777715`、`shown=1982`。
- 程序化 `Right` 输入可移动中央精灵；这不是硬件键盘验收，实际键盘流程仍待完成。
- 修复版运行时目前只在客户端会话热加载，F 盘工作区副本已更新；D 盘运行时因执行环境 allowlist 未覆盖而未更新，客户端重启后会回退。D 盘新游戏包已部署。

## 本地素材检查（2026-10-14）

`F:\WOW_INTERFACE\NES\恶魔城.zip` 只读检查，无解压、无生成商业 ROM 包。

- ZIP SHA-256：`e71f7cf4467d67364efcaf942a3cf899eac64fea1c694cc134688be17f1dfcb7`
- 包内唯一 NES SHA-256：`7a60fedbef65e6dec681525c17681e1e940f55534ff62e765d0ec15842eab422`
- Mapper：2；结果 `compatible=false / UNSUPPORTED_MAPPER`。ZIP 文件名原始编码显示乱码，未改名。
- 用户本地商业素材不得纳入 fixtures 或公开分发。

## P0 — 契约与测试基线

- [ ] T0.1 合入未来宿主规范：当前 4 份增量 spec 保留，不虚构 openspec 宿主。
- [~] T0.4 Mapper23 工作区实现：PRG/CHR/mirroring、VRC2b/VRC4e 地址变体译码、raw interpreter、VRC4 IRQ、runtime contract、工坊 Lua 行为验证、真实 ROM export/validate，以及本地 Lua 5.1 mock 的 Contra 标题至 gameplay/输入验证已完成；真实客户端部署与完整兼容性仍待办。
- [x] T0.2 自制 CC0-1.0 fixture：`test_wow_nes.py::fixture` 内存生成，无商业内容。
- [~] T0.3 报告 schema_version=1：已定义 Draft 2020-12 JSON Schema 字典，区分拒绝/inspect/export，内置所用子集校验器检查类型、范围、必填/额外字段及 rom_id/输出目录身份；契约及篡改测试通过。Schema 独立发布、通用标准校验器验证与宿主类型集成待办。

## P1 — ROM 检查器

- [x] T1.1 iNES/NES2 Header、trainer、PRG/CHR、Mapper/Submapper、mirroring、battery、region。
- [x] T1.2 Mapper0 加载、16KiB 镜像与三个 vectors。
- [x] T1.3 严格 NTSC/16或32KiB PRG/8KiB CHR-ROM；battery 与 PRG-NVRAM 分别拒绝；易失 PRG-RAM 至多8KiB，不因普通易失容量声明拒绝持久化。其他 submapper、console、four-screen、CHR-RAM、额外尾部数据拒绝。
- [x] T1.4 坏头、截断、trainer、映射、持久化拒绝、SHA 自动化测试。
- [x] T1.5 Mapper23 iNES 128 KiB PRG/CHR 检查、上电 vectors 与 Python physical/read/CHR bank lookup。

## P2 — 6502 混合执行

- [~] T2.1 151 官方 Opcode 长度/模式/基础cycles/跨页元数据与行为已实现；完整 flags 元数据及独立权威 CPU trace 待补。
- [x] T2.2 vectors 起点，branch/JSR/直接 JMP，间接跳转停止；重叠歧义全局关闭优化并保留原PRG。
- [~] T2.3 有局部寄存器与统一写回的单指令安全 Block；不访问IO，每条检查中断。NOP 空表达式仅在非空时追加分号，避免 Lua5.1 连续空语句；新增回归断言通过。多指令高收益块待办。
- [x] T2.4 扁平数值 IR，每1024条分片；Block每256条分片，PRG每4096字节分片；键为 bank0/physical offset，支持NROM镜像。
- [~] T2.5 Bus、官方指令解释器、三级分派、RAM执行、栈/中断、跨页/分支/RMW/DMA基本语义已实现；非法opcode明确失败。当前模板已补 JSR 低字节→栈 dummy→返回地址入栈→高字节顺序、RTS/RTI、PHA/PHP/PLA/PLP、BRK/NMI/IRQ 及隐含/累加器 dummy read；完整逐cycle边界、DMC及独立权威验证仍待办。
- [~] T2.6 历史客户端三级6步程序寄存器、cycle、有序读写差分及151官方opcode各一例IR/解释差分通过。已生成16组独立字面量总线/状态黄金用例×3后端（预期48次），覆盖上述栈/中断及INX/TAX/累加器移位；共用执行函数差分不能代替独立参考模拟器或公开权威测试ROM，独立CPU/PPU参考trace仍待完成。

## P3 — CHR与包生成

- [x] T3.1 2bpp解码与16字节Tile去重。
- [x] T3.2 三层互斥BGRA TGA，顶向下、1像素留白、UV、空层bitmap；逐像素黄金测试。
- [~] T3.3 `wow_nes_runtime.py` 生成Interface50504 Lua5.1运行时模板；Mapper23 runtime 已加入每 CPU mapper state、PRG/CHR lookup、VRC aliases、动态 mirroring 和 VRC4 IRQ。runtime 工坊 check/load 及 14 项 Lua IRQ 行为断言通过；43 文件真实游戏包 check 通过，但 load 超时，尚无客户端游戏流程证据。
- [x] T3.4 游戏TOC依赖、manifest、PRG、IR、Block、CHR map、report/checksums及注册文件；Mapper23 生成 raw-only IR/Block 空 shard，validator 重建一致。
- [~] T3.5 外部目标临时生成、验证后目录rename、覆盖备份和异常/取消rollback已测试；两目录提交不是全文件系统原子事务。崩溃恢复、并发竞争/TOCTOU加固待办。
- [~] T3.6 已检查文件清单/SHA，并重建交叉核对报告/manifest身份、TOC顺序/依赖、PRG长度/vectors、IR/Block生成内容、CHR Lua/JSON mapping/UV/empty、TGA精确内容及统计。重算SHA后的篡改与多分片/镜像/歧义测试通过；范围是确定性生成格式，不是任意Lua通用语义分析，独立执行语义证明待办。

## P4 — PPU与WoW渲染PoC

- [~] T4.1 寄存器、v/t/x/w、buffer、CIRAM、palette、OAM/DMA、vblank/NMI已实现基础断言；逐dot滚动拷贝、odd-frame、race待办。
- [~] T4.2 固定33×31背景+64sprite×3层Mask池，缓存属性避免重复UI提交；模拟dirty仍全局扫描，精确脏tile/palette/oam索引待办。已修复 scheduler 渲染饥饿及 bootstrap 热加载替换运行时表时旧 active view 未释放、灰色旧 Frame 覆盖新画面的问题；修复版外部包经 check/load 后仅剩一个可见且带 OnUpdate 的512×480视图，MEDIUM/1 下截图可见原创棋盘、边框、星形和中央精灵。当前为会话热加载；F盘副本已更新，D盘运行时未持久化。
- [~] T4.3 翻转、draw-layer优先级、数据驱动sprite0 hit基础实现；背景零像素与behind sprite精确合成、左边裁剪、fine-Y、多sprite优先级/overflow及画面验收待办。8×16未实现。
- [~] T4.4 1789773 CPU cycles/秒、4ms切片、最多约3帧债务、落后跳显示；已修复 debt 阈值导致的渲染饥饿，本次采样 `frame/renderedFrame=160/160`、`cycles=4777715`、`shown=1982`。10分钟稳定性、真实帧率及p50/p95/p99仍未验收。
- [~] T4.5 `/wownes <rom_id>`显式捕获输入、Escape/隐藏/战斗暂停清空；隐藏路径已实测，程序化 `Right` 可移动精灵，但不等同于硬件键盘验收；实际键盘/战斗流程待验收。
- [~] T4.6 静音APU寄存器/length/status/frameIRQ及DMC stall钩子；完整frame-counter精度、DMC/IRQ/声道逻辑待办。

## P5 — 宿主集成及验收（全部待办）

- [ ] T5.1 X类任务、202/SSE、同kind409、协作取消适配。
- [ ] T5.2 catalog_id-only inspect/export HTTP端点及job result。
- [ ] T5.3 Electron目录选择/preload/Renderer任务入口。
- [ ] T5.4 完整pytest/typecheck/lint/Vitest/build；目前仅标准库unittest与工坊检查执行，不声称这些宿主工具通过。
- [ ] T5.5 WoW 10分钟稳定性、NTSC实时/30FPS、p50/p95/p99、脏region和持续内存验收。
- [ ] T5.6 设计§10.3所有门槛通过后才提Mapper3。

## 本轮部署与客户端验证记录（2026-10-15）

- 自制 CC0 可视 ROM `wownes_visual_test.nes` 由 `build_visual_test_rom.py` 构造，SHA-256 为 `b54f90e68ebf569a1f715742006373170af309d25340ffecfea20fc8585a5383`，ROM ID 为 `b54f90e68ebf`；`inspect`、`export`、`validate` 均通过。
- 新游戏包 `WoWNES_Game_b54f90e68ebf` 已部署到 `D:\World of Warcraft\_classic_\Interface\AddOns\`，并整份单向同步到 `F:\WOW_INTERFACE\WoWNES_Game_b54f90e68ebf`。游戏真源与工作区副本共16个文件，逐文件比对 `missing=0 / extra=0 / changed=0`。
- 修复版 `WoWNES_Runtime` 已通过工坊 check/load 并完成会话内运行验证，且 `F:\WOW_INTERFACE\WoWNES_Runtime` 副本已更新；但执行环境 allowlist 未覆盖 D 盘运行时目录，故 `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Runtime` 未更新，客户端重启后会回退到旧运行时。
- scheduler 渲染饥饿与 bootstrap 热加载残留灰框均已修复。最终截图 `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-205545-690.png` 可见棋盘、边框、星形及中央精灵；运行采样为 `frame/renderedFrame=160/160`、`cycles=4777715`、`shown=1982`。
- 程序化 `Right` 输入可移动精灵，但不是硬件键盘验收。10分钟稳定性、性能分位数、真实键盘/战斗流程及精确CPU/PPU事项仍未完成。

## 实际验证证据与使用

源码：`wow_nes.py`、`wow_nes_runtime.py`、`test_wow_nes.py`、`verify_runtime.py`。

```powershell
& "C:\Users\molangjie\AppData\Local\Programs\Python\Python311\python.exe" -m unittest -v test_wow_nes
& "C:\Users\molangjie\AppData\Local\Programs\Python\Python311\python.exe" wow_nes.py inspect-zip "恶魔城.zip"
& "C:\Users\molangjie\AppData\Local\Programs\Python\Python311\python.exe" wow_nes.py inspect "local.nes"
& "C:\Users\molangjie\AppData\Local\Programs\Python\Python311\python.exe" wow_nes.py export "local.nes" --repository "F:\WOW_INTERFACE\NES" --dest "C:\existing_external_destination"
& "C:\Users\molangjie\AppData\Local\Programs\Python\Python311\python.exe" verify_runtime.py
```

`python`默认启动器指向缺失Python310，实际用上述Python311路径。export只读repository内.nes、拒绝目标在仓库内、`..`、符号链接/reparse/junction、AddOns游戏目录；SIGINT协作取消。progress仅`{done,total}`。不把CLI路径输入伪称为未来catalog_id API。

自制fixture SHA：`ef4ed0f5c6d148202f2dd2845382a1536d2ac3477cbf9a13f5fc094c525a801b`，来源本工程测试生成器，CC0-1.0。预期6步：PC32774/A1/X2/Y0/SP253/P36/cycles22/RAM16=1，有序写`16:1`。

本轮 Python unittest：20 项全部通过，exit0；包含自制可视 ROM 构造/身份验证，以及既有 NOP 空表达式 Lua5.1 回归、报告schema/身份、重算SHA后的跨文件语义损坏、多分片/镜像/歧义及取消/发布rollback。可视 ROM 的 `inspect`、`export`、`validate` 均通过。未执行pytest/Vitest/build。

本轮可视 ROM 位于 `F:\WOW_INTERFACE\NES\wownes_visual_test.nes`，构造脚本为 `F:\WOW_INTERFACE\NES\build_visual_test_rom.py`；SHA-256 `b54f90e68ebf569a1f715742006373170af309d25340ffecfea20fc8585a5383`，ROM ID `b54f90e68ebf`。游戏包 `WoWNES_Game_b54f90e68ebf` 已在 D 盘部署并同步至 F 盘，16文件差异0。

本轮无限工坊 check/load 已通过。客户端会话内运行修复版 runtime 后，截图 `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-205545-690.png` 可见棋盘、边框、星形与中央精灵，状态 `frame/renderedFrame=160/160`、`cycles=4777715`、`shown=1982`；程序化 `Right` 可移动精灵，但硬件键盘尚未验收。修复版 runtime 仅热加载且 F 盘副本已更新，D 盘 runtime 因 allowlist 未覆盖仍未更新，重启会回退。

历史记录（非本轮重验）：MoP Classic build70268、Interface50504工坊曾返回 `passed=true,backends=3,steps=6,checks=17,official_opcodes=151`，167.1ms（不是帧性能）；3261 Mask Texture+背景Texture、1087槽位创建，单次21.5443ms，隐藏暂停/清输入通过。该17项结果已由本轮18项 unittest 和可视 ROM 验证取代，不应用作当前测试总数；旧临时路径可能被系统清理。

## Mapper23 本轮交接事项（2026-10-17）

- 真实 ROM 仅从 `魂斗罗.zip` 内存读取，未复制到仓库、未部署到 D 盘；`inspect-zip`、临时目录 `export`、`validate` 均通过。
- 本轮又完成 runtime correctness pass：Mapper23 在 `R.step` 显式强制 raw interpreter，B000-EFFF CHR alias 按 low/high nibble 更新，background/sprite 均使用物理 CHR atlas lookup；20 项 Python 测试通过。
- 从 reset `$F80D` 的 CFG 找到魂斗罗实际使用 `$x000-$x003` 寄存器组；Mapper 写入增加 `ppu.dirty=true`，并新增寄存器写入回归断言。
- 真实 ROM 重新导出并通过 `validate`；43 文件游戏包再次提交工坊仍 daemon 超时。
- VRC4 IRQ 已实现，并在工坊通过 14 项 Lua 行为断言；客户端真实 ROM 运行、视觉、输入、性能和 10 分钟稳定性仍未验证，不得把当前结果写成全功能兼容。

## 本地 Contra ROM mock 验证（2026-10-18）

- ROM 从 `魂斗罗.zip` 直接读取，SHA-256 `0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5`；Mapper 23，PRG/CHR 各 128 KiB。完整 runtime/game TOC 分别加载 8/37 个 Lua 文件，在 Lupa 2.5 的 Lua 5.1 VM 执行。
- 本地 mock 画面证据覆盖标题、Start、intro、stage、玩家出现、Right、A 攻击和 B 跳跃。证据目录：`F:\WOW_INTERFACE\NES\contra-local-evidence`；详细状态和差异见 `evidence.json`。
- `$4016` 控制器轮询已观察到输入，idle 对照的 RAM/OAM/像素差异：Right 60/25/5540，A 77/69/4288，B 118/77/108。runtime 48 golden runs、151 opcode、17 checks、IRQ 15 checks 与 Python unittest 20 项通过。
- 本地 mock 不代表 WoW 客户端实机、硬件键盘或音频验收；工坊完整游戏包 load 曾超时，本轮没有重试。10 分钟稳定性、性能分位数、cycle/dot 精确度及 Mapper23 通用兼容性仍未通过。

## 后续交接事项

1. 待执行环境 allowlist 覆盖 D 盘运行时目录后，将已验证修复版写入 `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Runtime`，再从游戏真源整份单向同步到 `F:\WOW_INTERFACE\WoWNES_Runtime`；完成前必须保留“重启会回退”的限制。
2. 完成10分钟稳定性、NTSC实时/至少30FPS、p50/p95/p99、脏Region和持续内存验收。
3. 使用硬件键盘验收输入，并完成战斗、隐藏、Escape流程。
4. 完成独立CPU/PPU参考trace及精确总线、逐cycle CPU、PPU滚动/逐dot/priority、APU/DMC待办，再进行P5量化门槛，保持恶魔城Mapper2拒绝。
