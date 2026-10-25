# WoWNES Game 实现记录

- 来源包：`C:\Users\MOLANG~1\AppData\Local\Temp\WOW_NES_verify_8ghegoni\WoWNES_Game_ef4ed0f5c6d1\`
- 真源：`D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_ef4ed0f5c6d1\`
- TOC Interface 50504，依赖 `WoWNES_Runtime`；本包包含 16 个文件，部署后真实目录与工作区源码副本逐文件 SHA-256 一致。
- 生成内容包括 4 个 PRG 分片、fallback/translated 数据、manifest、register、CHR map、conversion report、checksums 及 3 个 TGA Mask。
- 本轮部署不覆盖既有目录，因为目标不存在；若未来目标存在，必须先保留备份，再替换并重新同步。
- 工坊 `check`/`load` 结果必须按本轮实际返回记录；一次成功的短运行也不能宣称 10 分钟稳定性或完整显示验收。
