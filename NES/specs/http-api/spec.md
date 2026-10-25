# REST API 契约（http-api）增量规范

## ADDED Requirements

### Requirement: 检查 NES ROM 的 WoW AddOn 兼容性

Sidecar 必须提供 `POST /api/entries/{catalog_id}/wow-addon/inspect` 即时接口。接口只按当前仓库的稳定 `catalog_id` 定位输入，不接受 ROM 路径，不写文件且不创建 job。

#### Scenario: 检查兼容 ROM
- **WHEN** `catalog_id` 存在、属于当前仓库、对应仓库内 `.nes` 文件且满足首期兼容条件
- **THEN** 返回 200 与兼容性报告，其中 `compatible=true`，报告包含格式、Mapper、PRG/CHR、region、mirroring、vectors 与 SHA-256，且不含 ROM 绝对路径

#### Scenario: 检查不兼容 ROM
- **WHEN** `catalog_id` 对应 `.nes` 文件的 iNES/NES 2.0 flags 6 battery 位为 1，或 NES 2.0 byte 10 高半字节的 PRG-NVRAM shift count 非 0
- **THEN** 返回 200 且 `compatible=false`，原因码分别为 `BATTERY_UNSUPPORTED` 或 `PRG_RAM_PERSISTENCE_UNSUPPORTED`，不创建 job 或文件

#### Scenario: 检查不存在的条目
- **WHEN** `catalog_id` 在当前仓库中不存在或属于已经切换离开的旧仓库上下文
- **THEN** 返回 404 与 `{"detail":"ROM 不存在"}`，不读取文件且不返回绝对路径

#### Scenario: 检查非法输入条目
- **WHEN** `catalog_id` 对应条目的扩展名不是 `.nes`，或其规范化路径越出当前仓库根目录
- **THEN** 返回 400 与统一 `detail` 错误响应，不读取仓库外文件且不返回绝对路径

### Requirement: 提交 NES ROM 的 WoW AddOn 导出

Sidecar 必须提供 `POST /api/entries/{catalog_id}/wow-addon/export` 长任务端点，请求 Body 为 `{dest_root, overwrite?}`，其中 `overwrite` 缺省为 `false`。该端点提交 kind 为 `nes-wow-addon-export` 的 X 类任务。

#### Scenario: 提交兼容 ROM 导出
- **WHEN** `catalog_id` 存在并解析到当前仓库内兼容的 `.nes` 文件，`dest_root` 为非空外部目录，且请求 Body 只包含合法的 `dest_root` 与可选布尔值 `overwrite`
- **THEN** 返回 202 与 `{"job_id":"<唯一标识>"}`，任务 kind 为 `nes-wow-addon-export`

#### Scenario: 提交前拒绝不兼容 ROM
- **WHEN** export 请求引用的 ROM 未通过与 inspect 相同的兼容性检查
- **THEN** 同步返回 400 与包含稳定兼容性原因码的 detail，不创建 job

#### Scenario: 提交前拒绝仓库内目标
- **WHEN** `dest_root` 为空，或其 realpath 等于当前仓库根目录或位于当前仓库根目录内
- **THEN** 返回 400，detail 分别为 `导出目标目录不能为空` 或 `导出目标目录不能在源仓库内`，不创建 job

#### Scenario: 拒绝重复转换任务
- **WHEN** kind 为 `nes-wow-addon-export` 的 job 已处于 queued 或 running 且再次提交 export
- **THEN** 返回 409 与 `{"detail":"相同任务正在进行中","job_id":"<已存在任务 id>"}`，不创建第二个 job

#### Scenario: 拒绝非法请求字段
- **WHEN** export 请求缺少 `dest_root`、`overwrite` 不是布尔值，或包含 ROM 绝对路径字段
- **THEN** 返回 422 请求校验错误，不创建 job

### Requirement: 通过统一任务接口返回转换报告

NES 转换任务必须复用 `GET /api/jobs/{job_id}`、`DELETE /api/jobs/{job_id}` 与 `GET /api/jobs/{job_id}/events`，不得新增独立转换报告查询端点。

#### Scenario: 查询完成报告
- **WHEN** `GET /api/jobs/{job_id}` 查询 completed 的 `nes-wow-addon-export` 任务
- **THEN** `result` 包含 `rom_id`、相对 `dest_root` 的输出目录、静态块/IR/fallback 统计、图集统计、warnings 与 checksums，不包含源 ROM 或输出目录绝对路径

#### Scenario: 查询或订阅转换进度
- **WHEN** 客户端查询转换 job 或订阅其 SSE 事件
- **THEN** `progress` 仅为 `{done,total}` 或 `null`；SSE 的 progress 事件 data 仅为 `{done,total}`，不包含阶段名或嵌套阶段对象

#### Scenario: 取消转换任务
- **WHEN** 客户端对 queued 或 running 的转换 job 调用 `DELETE /api/jobs/{job_id}`
- **THEN** 任务按统一协作式取消契约转为 cancelled，且 `result=null`

### Requirement: 将外部目标限制为用户选择的根目录

`dest_root` 是由 Renderer 经 preload 调用 Electron Main 原生目录对话框取得的外部根目录边界参数，可以是绝对路径；所有业务校验和文件写入必须由 Sidecar 完成。

#### Scenario: 生成路径保持在目标根内
- **WHEN** Sidecar 创建临时目录或最终 AddOn 目录
- **THEN** 每个路径经 realpath/commonpath 等价校验后仍位于 `dest_root` 内，`..`、符号链接或目录联接不能使写入越出目标根

#### Scenario: 路径逃逸被阻止
- **WHEN** 任一待写路径解析后越出 `dest_root`
- **THEN** 任务以 failed 结束，清理已创建的临时内容，且不写入目标根之外的文件
