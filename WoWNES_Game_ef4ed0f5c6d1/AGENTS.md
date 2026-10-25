# WoWNES_Game_ef4ed0f5c6d1 交接规则

- 游戏真源：`D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_ef4ed0f5c6d1\`
- 工作区副本：`F:\WOW_INTERFACE\WoWNES_Game_ef4ed0f5c6d1\`；源码只从游戏真源单向同步，不在副本直接编辑。
- 客户端：无限国服 MoP Classic，build 5.5.4.70268，Interface 50504，Lua 5.1.4，game type `camelot`。
- 本包依赖 `WoWNES_Runtime`，由 TOC 加载 manifest、PRG 分片、fallback/translated 数据、CHR mapping 和 register；三张 TGA 位于 `textures`。
- 开发循环：先部署/同步完整包，再对真实目录执行工坊 `check`，随后按 TOC `load`。短时运行可做黄金 trace、静态资源和显示基础检查；不以此宣称 10 分钟稳定性或完整可玩性。
- 关键限制：当前为自制 Mapper 0 单 ROM PoC，静音 APU、基础 PPU/渲染和输入语义；完整逐周期、性能、滚动/优先级、DMC 与长时间验收尚未完成。
- 本目录的源码副本必须与游戏真源逐文件校验和一致；项目设计和实现记录位于 `F:\WOW_INTERFACE\NES\`。
