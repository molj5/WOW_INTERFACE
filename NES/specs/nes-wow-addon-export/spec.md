# NES 转 WoW 插件（nes-wow-addon-export）增量规范

## ADDED Requirements

### Requirement: 检查 NES ROM 转换兼容性

系统必须在写出任何生成物前检查仓库内目标 ROM，并返回格式、Mapper、PRG/CHR、region、mirroring、vectors、SHA-256 和兼容性原因码。

#### Scenario: Mapper 0 ROM 通过首期检查
- **WHEN** `catalog_id` 对应结构完整的 NTSC NROM-128 或 NROM-256，PRG-ROM 为 16 KiB 或 32 KiB，CHR-ROM 为 8 KiB，iNES/NES 2.0 flags 6 的 battery 位为 0，且该 ROM 为 iNES 格式或其 NES 2.0 PRG-NVRAM shift count 为 0
- **THEN** 检查结果为 `compatible=true`，Mapper 为 0，并返回三个中断 Vector 与 ROM SHA-256

#### Scenario: 带 battery 标志的 ROM 被拒绝
- **WHEN** ROM 的 iNES/NES 2.0 flags 6 battery 位为 1
- **THEN** 检查结果为 `compatible=false` 且原因码为 `BATTERY_UNSUPPORTED`，不创建转换任务或 AddOn 文件

#### Scenario: 声明 PRG-NVRAM 的 ROM 被拒绝
- **WHEN** NES 2.0 Header byte 10 高半字节的 PRG-NVRAM shift count 非 0
- **THEN** 检查结果为 `compatible=false` 且原因码为 `PRG_RAM_PERSISTENCE_UNSUPPORTED`，不创建转换任务或 AddOn 文件

#### Scenario: 不支持的 Mapper 被拒绝
- **WHEN** ROM Mapper 不是 0
- **THEN** 检查结果为 `compatible=false` 且原因码为 `UNSUPPORTED_MAPPER`，不创建任何 AddOn 文件

#### Scenario: CHR-RAM ROM 被拒绝
- **WHEN** ROM 的 CHR-ROM 大小为 0 且需要 CHR-RAM
- **THEN** 检查结果为 `compatible=false` 且原因码为 `CHR_RAM_UNSUPPORTED`

#### Scenario: 损坏 ROM 被拒绝
- **WHEN** Header magic 无效、声明长度超过实际文件或 Vector 不可读取
- **THEN** 检查结果为 `compatible=false`，原因码为 `INVALID_HEADER` 或 `TRUNCATED_ROM`，且不执行转译

### Requirement: 仅通过 catalog_id 选择输入 ROM

转换接口必须只接受当前仓库内稳定 `catalog_id`，由 Sidecar 解析实际文件；不得接受客户端提交的任意输入文件绝对路径。

#### Scenario: 仓库内条目作为输入
- **WHEN** 用户提交当前仓库内存在且指向 `.nes` 文件的 `catalog_id`
- **THEN** Sidecar 从仓库上下文解析该 ROM 并执行检查或转换，响应不返回 ROM 的绝对路径

#### Scenario: 不存在的条目被拒绝
- **WHEN** `catalog_id` 不存在、属于旧仓库上下文或文件已越出仓库根目录
- **THEN** 请求被拒绝，不读取该路径且不创建转换任务

### Requirement: 使用保守控制流分析

转换器必须从 RESET、NMI、IRQ/BRK vectors 构建控制流图，只跟随可证明的顺序后继、条件分支、直接 JMP 和 JSR，不得把不确定数据强制解释为代码。

#### Scenario: 直接控制流被发现
- **WHEN** 已发现代码包含条件分支、绝对 JMP 或 JSR
- **THEN** 控制流图包含可达目标和合法 fallthrough，且每个确认指令边界只归属一个基本块

#### Scenario: 间接跳转保守停止
- **WHEN** 已发现代码执行 `JMP ($xxxx)` 且静态分析不能证明目标
- **THEN** 当前基本块在该指令结束，目标留给运行时 fallback，不从猜测地址继续反汇编

### Requirement: 生成混合执行产物

生成的游戏 AddOn 必须同时支持 Lua Basic Block、预解码 IR 和逐指令解释器 fallback；静态分析覆盖率不得成为正确运行的硬前提。

#### Scenario: 优先执行静态块
- **WHEN** 当前物理 PRG 地址命中已生成的 Lua Basic Block
- **THEN** 运行时执行该 Block，并按实际执行路径返回下一 PC 和消耗 Cycle

#### Scenario: 执行预解码 IR
- **WHEN** 当前地址未命中 Lua Block 但命中预解码 IR
- **THEN** 运行时不重复解码 Opcode，按 IR 执行并产生与解释器一致的寄存器、访存和 Cycle 结果

#### Scenario: 未知入口使用解释器
- **WHEN** PC 到达未静态发现的 ROM 地址或 RAM 执行地址
- **THEN** 运行时从 Bus 读取 Opcode 并使用解释器继续执行，同时增加 fallback 统计而不因未知入口崩溃

#### Scenario: 三种后端执行一致
- **WHEN** 同一确定性测试程序分别由 Lua Block、IR 和解释器执行到同一边界
- **THEN** 三者的 PC、A、X、Y、SP、P、Cycle 和有序内存写入完全一致

### Requirement: 保留 2A03 CPU 时序

转换和运行时必须保留官方 2A03 Opcode 行为、8/16 位回绕、中断、Page Crossing、Branch 和 DMA 时序；生成代码不得以指令数替代 Cycle。

#### Scenario: Page Crossing 增加 Cycle
- **WHEN** 指令的寻址模式规定跨页增加一个 Cycle 且实际有效地址跨页
- **THEN** 该执行路径的 Cycle 比未跨页路径多 1

#### Scenario: 中断在检查点响应
- **WHEN** NMI 或可响应 IRQ 在执行单元边界到达
- **THEN** 运行时在下一个规定检查点压栈并跳转对应 Vector，不跨越无界 Lua Block 延迟响应

### Requirement: 将 CHR-ROM 转换为 Mask Atlas

转换器必须把每个 8×8 2bpp CHR Tile 转换为颜色索引 1、2、3 的三张互斥 Alpha Mask，并生成 Tile 到 Atlas UV 的映射。

#### Scenario: Tile 逐像素转换
- **WHEN** 一个 CHR Tile 的某像素索引分别为 0、1、2、3
- **THEN** 索引 0 在三张 Mask 均透明，索引 1/2/3 仅在各自对应 Mask 不透明

#### Scenario: 相同 Tile 去重
- **WHEN** 多个 CHR Bank 位置包含相同的 16-byte Tile 数据
- **THEN** 它们可以引用同一组 Atlas UV，且运行时呈现结果相同

### Requirement: 生成独立且可验证的 AddOn

转换成功后必须生成版本化 `WoWNES_Runtime` 和 `WoWNES_Game_<rom_id>`，游戏 AddOn 通过 TOC 依赖公共运行时，并包含 manifest、分片执行数据、CHR 映射、转换报告和 checksums。

#### Scenario: 稳定游戏标识
- **WHEN** 对字节完全相同的 ROM 重复转换
- **THEN** `rom_id`、游戏 AddOn 目录名和 manifest 中的 SHA-256 保持一致

#### Scenario: TOC 加载顺序完整
- **WHEN** 验证生成的游戏 AddOn
- **THEN** TOC 声明 `WoWNES_Runtime` 依赖，且所有 Lua 文件在首次引用前已按确定顺序加载

#### Scenario: 生成物校验失败
- **WHEN** 生成文件缺失、checksum 不匹配、PRG 长度错误或 Atlas 映射越界
- **THEN** 任务以 failed 结束，不把临时目录发布为最终 AddOn

### Requirement: 原子写出并保护源仓库

转换不得修改源 ROM；目标目录不得位于当前仓库内；生成过程必须先写临时目录，验证成功后才发布最终目录。

#### Scenario: 目标位于仓库内
- **WHEN** `dest_root` 经 realpath 解析后等于当前仓库根目录或位于其子目录
- **THEN** 请求返回 400 且 detail 为 `导出目标目录不能在源仓库内`，不创建转换任务

#### Scenario: 生成路径逃逸目标根
- **WHEN** 临时目录或最终目录经 realpath/commonpath 等价校验后不再位于 `dest_root` 内，包括由 `..`、符号链接或目录联接造成的越界
- **THEN** 任务以 failed 结束并清理已创建的临时内容，不写入目标根之外的路径

#### Scenario: 转换失败或取消
- **WHEN** 任务在转译、Atlas 生成或验证阶段失败或被取消
- **THEN** 临时目录被清理，源 ROM 和既有最终 AddOn 保持不变

#### Scenario: 成功发布
- **WHEN** 全部生成文件通过验证
- **THEN** 临时目录被移动为最终 AddOn 目录，任务结果返回相对目标根的目录、统计和 checksums

### Requirement: 公共运行时执行 Mapper 0 游戏

公共运行时必须提供 Mapper 0 CPU Bus、PPU 可见语义、控制器、固定步长调度和 Tile/Sprite 对象池；帧循环不得创建 UI Region。

#### Scenario: NROM-128 PRG 镜像
- **WHEN** 16 KiB PRG-ROM 游戏读取 `$8000-$BFFF` 与对应的 `$C000-$FFFF`
- **THEN** 两段地址映射到同一物理 PRG-ROM 内容

#### Scenario: 脏 Tile 更新
- **WHEN** 一帧内只有部分 Nametable、Palette 或 OAM 状态变化
- **THEN** 渲染器只更新受影响的预创建 Texture，未变化槽位不重复提交属性

#### Scenario: 调度落后
- **WHEN** 模拟累计时间超过最大追帧预算
- **THEN** 运行时限制追帧次数并允许跳过显示提交，不进入无限追帧循环

### Requirement: 首期静音并显式报告限制

首期运行时不得宣称支持实时 NES 音频；它必须保留最小 APU 寄存器和时序接口，并在 manifest 与转换报告中标记 `audio_output=none`。

#### Scenario: APU 写入不会破坏 Bus
- **WHEN** 游戏写入 `$4000-$4017` 或读取 `$4015`
- **THEN** 请求由 APU 模块处理而不是写入普通 RAM，游戏继续执行且报告保持静音标记

### Requirement: 安全管理游戏输入

运行时只能在用户显式进入游戏模式后捕获键盘，并在 Escape、窗口隐藏、退出模式或进入战斗时暂停及清空控制器状态。

#### Scenario: 进入战斗释放输入
- **WHEN** 游戏模式运行中触发 `PLAYER_REGEN_DISABLED`
- **THEN** 模拟暂停、键盘捕获关闭且所有 NES 按键状态归零

### Requirement: 转换作为 X 类异步任务

转换必须使用 kind `nes-wow-addon-export` 进入统一任务体系，类别为 X；支持进度、SSE、同 kind 防重复和协作取消。

#### Scenario: 提交转换任务
- **WHEN** 兼容 ROM 通过检查后提交转换
- **THEN** API 返回 202 和唯一 `job_id`，任务的 `progress` 仅为 `{done,total}` 或 `null`，数值进度满足 `0 <= done <= total`

#### Scenario: 重复提交被拒绝
- **WHEN** `nes-wow-addon-export` 已处于 running 或 queued 时再次提交同 kind 任务
- **THEN** 返回 409 和已有 `job_id`，不创建第二个转换任务

### Requirement: 不分发 ROM 内容

项目发行物和自动化测试不得附带无明确再分发许可的 ROM；转换器只处理用户本地输入，报告必须提示生成物可能仍受原内容版权约束。

#### Scenario: 测试资产许可证可追溯
- **WHEN** 自动化测试使用 NES ROM fixture
- **THEN** fixture 具有自制或明确许可记录、SHA-256 和来源说明；缺少许可记录的 ROM 不进入仓库
