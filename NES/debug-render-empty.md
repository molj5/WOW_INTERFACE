# WoWNES 空白渲染调试记录

状态：[OPEN]
会话：render-empty
症状：用户反馈运行窗口页面渲染未显示。

## 假设

1. R.render 未调用，或 ppu.dirty 一直为 false。
2. PPU 帧增长，但背景/精灵提交被缓存逻辑跳过。
3. 纹理资源路径或纹理加载失败。
4. NES view、背景层尺寸或层级异常，内容被裁剪或遮挡。
5. CPU/PPU 执行异常后运行停止，但窗口仍然存在。

## 采集计划

- 检查 WoWNES Runtime active/running、CPU cycles、PPU frame、renderedFrame、ppu.dirty。
- 检查 view 的显示状态、尺寸、层级和背景 Texture。
- 检查 Texture Pool 的可见数量、纹理对象和资源路径。
- 检查运行时错误字段及工坊日志。

## 约束

第一轮只采集运行时证据，不修改业务逻辑。调试完成并经用户确认后再清理本记录和临时插桩。
