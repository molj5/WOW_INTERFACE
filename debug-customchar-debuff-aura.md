# customChar Debuff Aura 调试记录

状态：[OPEN]

目标：为目标框 Debuff 图标增加紧凑的持续时间可视化，并基于客户端真实可用字段评估重要 Debuff 高亮方案。

待验证假设：
1. 当前 Aura 数据没有稳定的 `isImportant` 字段，不能直接依赖该字段。
2. 当前图标只更新图标、层数和持续时间文本，尚未建立持续时间进度层。
3. Aura 返回值中的 `duration` 与 `expirationTime` 可用于 MoP Classic 持续时间进度计算。
4. 目标框 Debuff 刷新生命周期需要额外处理进度层的创建、更新和隐藏。

验证方式：检查源码、通过无限工坊 checkpoint/check/load/logs/snap 采集运行时证据。
