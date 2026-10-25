---
slug: "add-nes-wow-addon-converter"
createdAt: "2026-10-14T00:00:00.000Z"
---

## Why

WOW_NES 当前仓库仅有本提案相关文档和用户本地 ZIP，没有 Electron、catalog、HTTP API 或任务系统宿主。2026-10-14 已新增独立 Python 离线核心与 CLI，后续宿主集成仍为待办。技术验证希望增加一个离线转换能力：用户选择本地 NES ROM 后，由 Python Sidecar 分析 iNES/NES 2.0、转译可证明的 6502 基本块、打包回退执行数据、转换 CHR 图形，并生成一个依赖公共运行时的《魔兽世界》AddOn。

该能力用于验证“ROM 静态/混合转译 + WoW Lua 运行时”路线，不承诺把任意 NES ROM 转成原生 Lua 游戏，也不绕过 WoW AddOn 沙箱。首期只支持 Mapper 0（NROM）、NTSC、CHR-ROM、无 battery 且不声明 PRG-NVRAM 的 ROM，以及静音输出；iNES/NES 2.0 flags 6 的 battery 位为 1，或 NES 2.0 byte 10 高半字节的 PRG-NVRAM shift count 非 0 时必须拒绝。普通易失 PRG-RAM 容量不单独触发持久化拒绝。

## What Changes

- 新增 `nes-wow-addon-export` 能力，提供 NES ROM 到 WoW AddOn 的离线转换。
- 转换器位于 Python Sidecar，作为 X 类长任务运行；渲染层只负责选择仓库内 ROM、目标目录和展示报告。
- 首期支持 iNES/NES 2.0 中可映射为 Mapper 0 的 NROM-128/NROM-256：
  - 解析 PRG-ROM、CHR-ROM、mirroring、trainer、vectors；
  - 从 RESET/NMI/IRQ 入口构建保守控制流图；
  - 采用“Lua Basic Block + 预解码 IR + 6502 解释器 fallback”的混合执行模型；
  - 将 CHR-ROM 转换为三层 one-hot Alpha Mask 图集和映射表；
  - 生成独立游戏 AddOn，并依赖版本化的 `WoWNES_Runtime` 公共运行时。
- 公共运行时负责 CPU 调度、内存总线、Mapper 0、PPU 可见语义、Tile/Sprite 渲染、控制器和最小 APU 语义；首期不输出声音。
- 转换前执行兼容性预检；不受支持的 Mapper、PAL、CHR-RAM、iNES/NES 2.0 flags 6 battery 位为 1，或 NES 2.0 byte 10 高半字节 PRG-NVRAM shift count 非 0 的输入以结构化报告拒绝，不生成声称可运行的产物。
- 生成物以 ROM SHA-256 派生稳定 ID，不修改、重命名或复制覆盖源 ROM。
- 项目与发布包不携带商业 ROM；转换器只处理用户本地输入，生成物默认只写入用户指定目录。

## Capabilities

### New Capabilities

- `nes-wow-addon-export`：检查并转换 NES ROM，生成 WoW AddOn 游戏包、公共运行时、兼容性报告和可验证清单。

### Modified Capabilities

- `task-system`：登记 `nes-wow-addon-export` 为 X 类长任务。
- `http-api`：新增即时兼容性检查与异步转换提交契约；转换报告通过任务状态的 `result` 返回，不新增独立报告查询端点。
- `desktop-ui`：实施阶段新增“导出为 WoW 插件”入口和任务反馈；不在本提案中定义具体视觉样式。

## Impact

- **Sidecar**：新增 NES 格式解析、6502 分析/转译、Lua 代码生成、纹理图集生成和 AddOn 模板输出模块。
- **数据层**：首期不修改 SQLite schema；转换报告随导出目录保存，不写 catalog 数据库。
- **API**：新增 `POST /api/entries/{catalog_id}/wow-addon/inspect` 即时检查接口和 `POST /api/entries/{catalog_id}/wow-addon/export` 异步转换接口；目标目录由 Renderer 经 preload 调用 Electron Main 原生目录对话框选择，Sidecar 只校验和使用请求中的 `dest_root`。
- **任务系统**：新增 X 类 `nes-wow-addon-export` kind，沿用 202 + job_id + SSE、同 kind 防重复和协作取消；`progress` 只允许 `{done,total}` 或 `null`。
- **安全**：输入必须是当前仓库内已登记的 `catalog_id`；输出目标不得位于源仓库内；所有生成路径必须约束在目标根目录。
- **性能风险**：WoW Texture 数量、Lua 执行吞吐和 PPU 时序尚需 PoC 实测；未通过门槛前不得宣称常见 ROM 兼容。
- **法律风险**：生成代码和图形仍可能是原 ROM 的衍生内容；工具不附带 ROM，不提供商业游戏生成包分发功能。
