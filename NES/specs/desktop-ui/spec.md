# 桌面 UI（desktop-ui）增量规范

## ADDED Requirements

### Requirement: 从 NES 条目发起 WoW AddOn 导出

Renderer 必须在 `.nes` 条目的详情面板提供“导出为 WoW 插件”入口，先调用兼容性检查，再允许用户选择外部目标目录并提交导出任务。Renderer 不得使用 Node API 或直接访问文件系统。

#### Scenario: 非 NES 条目不显示导出入口
- **WHEN** Detail Panel 当前条目的文件扩展名不是 `.nes`
- **THEN** 界面不显示“导出为 WoW 插件”入口

#### Scenario: 先检查兼容性
- **WHEN** 用户在 `.nes` 条目详情中点击“导出为 WoW 插件”
- **THEN** Renderer 先调用 `POST /api/entries/{catalog_id}/wow-addon/inspect`，在响应返回前不调用 export 端点

#### Scenario: 不兼容 ROM 不可提交
- **WHEN** inspect 返回 `compatible=false`
- **THEN** 界面显示稳定原因码及可读说明，不打开目标目录选择器且不调用 export 端点

#### Scenario: 兼容 ROM 选择目标目录
- **WHEN** inspect 返回 `compatible=true` 且用户继续导出
- **THEN** Renderer 经 preload/contextBridge 调用 Electron Main 原生目录对话框；Electron Main 只返回 `{path,cancelled}`，不执行转换或目录业务校验

#### Scenario: 用户取消目录选择
- **WHEN** 原生目录对话框返回 `cancelled=true` 或 `path=null`
- **THEN** Renderer 返回 idle 状态，不调用 export 端点

#### Scenario: 提交导出任务
- **WHEN** 原生目录对话框返回选定路径且用户确认覆盖选项
- **THEN** Renderer 调用 `POST /api/entries/{catalog_id}/wow-addon/export` 并发送 `{dest_root,overwrite}`，不读取、遍历或修改该目录

### Requirement: 呈现 NES 转换任务状态与报告

“导出为 WoW 插件”入口必须复用统一长任务按钮态机、SSE 任务栏和 X 类任务冲突规则。

#### Scenario: 导出按钮防重复提交
- **WHEN** 用户提交导出后请求尚未返回，或对应 `nes-wow-addon-export` job 处于 queued 或 running
- **THEN** 按钮依次处于 submitting 或 tracking 且不可重复点击，任务到达终态后恢复 idle

#### Scenario: 显示数值进度
- **WHEN** 转换任务的 `progress` 为 `{done,total}`
- **THEN** 导出入口与任务栏均显示 done/total 和百分比

#### Scenario: 显示不定进度
- **WHEN** 转换任务的 `progress` 为 `null`
- **THEN** 导出入口与任务栏显示不定进度，不尝试读取阶段名或嵌套进度字段

#### Scenario: 409 跳转已有任务
- **WHEN** export 返回 409 与已有 `job_id`
- **THEN** 界面提示“该任务已在进行中”并高亮任务栏对应任务，不把响应显示为普通失败

#### Scenario: 完成后显示转换报告
- **WHEN** `nes-wow-addon-export` 任务到达 completed
- **THEN** 界面从 job `result` 显示 `rom_id`、相对目标根的输出目录、转译统计、图集统计、warnings 与 checksums，不调用独立报告端点

#### Scenario: 失败或取消反馈
- **WHEN** 转换任务到达 failed 或 cancelled
- **THEN** failed 时显示 job `error`，cancelled 时显示已取消状态，不显示成功报告

#### Scenario: X 类任务不禁用不同 kind 入口
- **WHEN** `nes-wow-addon-export` 任务处于 running
- **THEN** 其他不同 kind 的 R、N、M 或 X 类任务入口保持可提交并在统一单 worker 队列中排队；仅同 kind 转换入口按防重复规则禁用
