# WoWNES Game 设计记录

## PoC 范围

`WoWNES_Game_ef4ed0f5c6d1` 是由自制 Mapper 0 fixture 生成的独立游戏包，不包含商业 ROM。它依赖公共 `WoWNES_Runtime`，提供 manifest、PRG 分片、静态 Block/IR/fallback、CHR 映射、注册入口和三层 TGA Mask 资源。

## 资源与执行

TOC 先加载 manifest 与 PRG/执行数据，再加载 CHR 映射和 register。register 将 ROM 注册到运行时；运行时渲染器使用 `textures/chr-mask-1.tga` 到 `chr-mask-3.tga` 复用 Texture 池，输入由 `/wownes <rom_id>` 显式启动。

## 限制

只声明 Mapper 0 PoC 能力，不能据此推断 Mapper 2/商业 ROM/存档/完整音频或完整 NTSC 兼容。三张 Mask 是资源验证的一部分，但画面、滚动、sprite 优先级、性能和长时间状态稳定性仍未完成正式门槛。
