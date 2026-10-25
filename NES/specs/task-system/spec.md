# 异步任务体系（task-system）增量规范

## MODIFIED Requirements

### Requirement: 长任务统一提交为作业

所有长任务端点统一返回 202 与 job_id，即时接口不进入队列。

#### Scenario: 长任务提交返回 202
- **WHEN** 渲染层调用任一长任务端点（repository/scan、load-names、import-ra-rom、import-rom-dir、import-gamelists、mappings/save、entries/{id}/move、bulk-delete、identify、covers、cn-names、export（含 format 参数）、media/format、gamelists/generate、bios/download、duplicates、entries/{catalog_id}/wow-addon/export）
- **THEN** 响应状态码为 202，Body 为 `{"job_id": "<唯一标识>"}`

#### Scenario: 即时接口不创建作业
- **WHEN** 调用打开仓库、列表/详情/摘要/目录树查询、修改中文名、设置读写、BIOS 状态查询或 `POST /api/entries/{catalog_id}/wow-addon/inspect`
- **THEN** 同步返回业务结果，不产生 job；兼容性检查也不写出文件

### Requirement: 任务分类与互斥边界

全部长任务按资源影响分为四类，互斥与排队策略由类别决定：**R 只读文件类**（扫描 scan、重复检测 duplicates、加载识别名 load-names、保存映射 save-mappings——不改动 ROM 与媒体文件，仅读取仓库文件、可写索引/数据库）、**N 网络获取类**（识别 identify、封面 covers、中文名 cn-names、BIOS 下载 bios/download——联网获取并写索引/媒体，不移动删除 ROM）、**M 文件变更类**（批量删除 bulk-delete、移动 move、媒体格式化 media/format、三种导入 import-*——移动/删除/写入 ROM 与媒体文件，破坏性）、**X 复制导出类**（统一导出 export、清单生成 gamelists/generate、NES 转 WoW AddOn 导出 nes-wow-addon-export——只读源仓库，写外部目标或清单文件）。

#### Scenario: R/N/X 类任务可排队
- **WHEN** 任一 R/N/X 类任务提交时队列中已有其他任务运行或排队
- **THEN** 新任务正常进入队列（status=queued），排队状态对渲染层可见

#### Scenario: M 类任务运行期间提交新任务
- **WHEN** 任一 M 类任务处于 running 时用户提交另一任务
- **THEN** 新任务同样进入队列串行等待（后端不并行执行）；渲染层按 [../../../../../specs/desktop-ui/spec.md](../../../../../specs/desktop-ui/spec.md) 的冲突交互约束，在 M 类任务运行期间禁用其余 M 类任务入口（用户须等待完成或先取消当前任务）

#### Scenario: 任务类别清单
- **WHEN** 查看任一任务的 kind
- **THEN** kind 与类别的映射固定为：scan、duplicates、load-names、save-mappings → R；identify、covers、cn-names、bios → N；delete、move、media-format、import-ra-rom、import-rom-dir、import-gamelists → M；export-library、export-pegasus、gamelists、nes-wow-addon-export → X；任一 kind 都属于且仅属于一类，该清单为权威映射，新增 kind 须经变更提案登记类别后方可扩展

### Requirement: 同类任务防重复提交

同一 kind 的任务已处于 running 或 queued 时，再次提交该 kind 的任务被服务端拒绝（409），返回已存在任务的 job_id；这是按钮防重复的服务端权威依据。

#### Scenario: 重复提交同类任务被拒绝
- **WHEN** identify 任务处于 running，渲染层再次提交 `POST /api/entries/identify`
- **THEN** 响应 409 与 `{"detail": "相同任务正在进行中", "job_id": "<已存在任务 id>"}`，不创建新 job

#### Scenario: 排队中的任务同样阻止重复提交
- **WHEN** covers 任务处于 queued，渲染层再次提交 `POST /api/entries/covers`
- **THEN** 响应 409 并返回排队中任务的 job_id

#### Scenario: 重复提交 NES 转换任务被拒绝
- **WHEN** kind 为 `nes-wow-addon-export` 的任务处于 running 或 queued，客户端再次调用任一 ROM 的 WoW AddOn export 端点
- **THEN** 响应 409 与 `{"detail": "相同任务正在进行中", "job_id": "<已存在任务 id>"}`，不创建新 job

#### Scenario: 终态后可重新提交
- **WHEN** 前一个 identify 或 `nes-wow-addon-export` 任务已到达 completed、failed 或 cancelled
- **THEN** 再次提交相同 kind 正常创建新 job 并返回 202

### Requirement: 上报数值进度

支持数值进度的任务在运行中实时上报 `{done, total}`；任务不得以阶段名、嵌套阶段对象或其他结构替代该结构。

#### Scenario: 数值进度任务清单
- **WHEN** 扫描、识别、封面下载、中文名获取、媒体格式化、游戏库导出、天马 G 导出、BIOS 下载、导入 RA-ROM、导入 ROM 目录、导入 gamelist 或 `nes-wow-addon-export` 中的任一任务能够确定工作总量并运行
- **THEN** 该任务的 `progress` 字段为 `{done, total}` 并随执行实时更新，同时产生 data 为 `{done,total}` 的 progress 事件

#### Scenario: 进度数值语义
- **WHEN** 任一 progress 事件到达
- **THEN** 满足 `0 <= done <= total`，渲染层可直接渲染 done/total 计数与百分比

### Requirement: 无数值进度任务使用不定进度

无法给出数值进度的任务 progress 为 null，由 UI 显示不定进度。

#### Scenario: 不定进度任务
- **WHEN** 加载识别名（load-names）、移动（move）、批量删除（bulk-delete）、保存映射（save-mappings）、重复检测（duplicates）、gamelist 生成中的任一任务运行，或 `nes-wow-addon-export` 当前无法确定可验证的 total
- **THEN** 该任务的 `progress` 为 null，任务栏显示不定进度指示；不发送包含阶段名或嵌套阶段对象的 progress 事件

### Requirement: 完成时返回统计摘要

任务完成后 result 携带可展示的统计摘要。

#### Scenario: 封面下载统计
- **WHEN** 封面下载任务 completed
- **THEN** `result` 含 `{requested, matched, existing, local, downloaded, failed}` 统计字段

#### Scenario: 其他任务的统计字段
- **WHEN** 识别 / 中文名获取 / 加载识别名 / 保存映射 / BIOS 下载 / 批量删除 / 导入 gamelist / 扫描任务 completed
- **THEN** `result` 分别包含 `identified` / `fetched` / `updated` / `saved` / `ok`+`failed` / `deleted`+`removed_ids` / `imported` / 仓库摘要（`revision`、`rom_count`、`platforms`、`root_name`）等统计字段

#### Scenario: NES 转换任务返回报告摘要
- **WHEN** `nes-wow-addon-export` 任务 completed
- **THEN** `result` 包含 `rom_id`、相对 `dest_root` 的输出目录、静态块/IR/fallback 统计、图集统计、warnings 与 checksums，且不包含源 ROM 或输出目录的绝对路径
