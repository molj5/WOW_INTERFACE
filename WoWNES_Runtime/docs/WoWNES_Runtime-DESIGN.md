# WoWNES Runtime 设计记录

> 完整架构与接口的权威说明见 [WoWNES-技术文档-基线v0.1.0.md](WoWNES-技术文档-基线v0.1.0.md)；本文只保留设计取舍与部署状态的变更记录。

## 部署状态

这是 WOW_NES 的公共 Lua 5.1.4 运行时 PoC。游戏真源为 `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Runtime\`，工作区同名目录仅保存单向同步副本。TOC 使用 Interface 50504，服务于无限国服 MoP Classic；历史基线为 build 5.5.4.70268，2026-10-25 实际连接观测为 5.5.4.70579。

当前真源为 2026-10-25 部署版：魂斗罗游戏包 `WoWNES_Game_0b79e04375c0`（145 文件，含 3 张 1024×1024 atlas TGA）与 Runtime（12ms 调度预算 + FPS 显示 + 基本块执行引擎）均已落盘 D 盘并同步 F 盘副本。生成器为 `F:\WOW_INTERFACE\NES\wow_nes_runtime.py`。

## 执行引擎（基本块）

`R.step` 优先查块表 `c.g.blocks[物理偏移]`（866 个基本块、61 个 `translated-blocks-*.lua` 分片，键为 PRG 物理偏移以规避 VRC4 bank 切换），命中后块内指令内联执行、周期累加，出口交 `blockTick` 判定预算/中断；未命中回退按操作码闭包解释器。中断响应延迟到块尾（NMI 松弛），等价性以帧缓冲级 + 块边界移位匹配验收（90 帧哈希全同、19,475 边界、176 次注入）。

## 包体分片

工坊热加载单文件过大会超时（链路约 6–10 KB/s），因此 PRG/CHR/块/瓦片映射全部按片投递：`prg-data-0..31`（4 KiB）、`chr-data-0..31`（4 KiB）、`translated-blocks-0..60`、`tiles-data-0..15`（每片 512 条 UV）。**所有分片一律写显式绝对下标**（`G.prg[N]` / `G.chr[N]` / `G.tiles[N]`），因为工坊批量 `load` 的执行顺序不保证，依赖 `#表+1` 追加会造成数据错位（曾导致画面图块全错）。`chr-map.lua` 仅保留 trainer，`manifest.lua` 初始化 `G.prg/G.blocks/G.chr/G.tiles`，`Register` 内 `table.concat` 拼接 PRG/CHR，`register.lua` 最后注册。

## FPS 显示

Start 时在画面左上角创建绿色等宽 FontString，OnUpdate 内每 0.5 秒刷新：模拟 FPS = PPU 帧号差 / wall time；渲染耗时 = scheduler 包裹 `R.render` 的 `debugprofilestop()` 差值（`c.view.lastRenderMs`，覆盖 atlas 与 fallback 两条路径）。release/隐藏时同步隐藏该文本。

## 设计边界

运行时提供 Bus、6502 执行（解释器 + 按操作码闭包分派 `R.exec`）、PPU、静音 APU、手柄、Texture 渲染和按预算调度。Mapper 23 的取指与操作数读走 PRG bank 基址缓存 `c.prgB`（slot→物理基址，bank 写时同步）。显示提交按已模拟 PPU 帧号去重并 30Hz 节流：追帧预算仍受限，但持续欠帧时也会显示最新完成帧。游戏包通过注册表提供 ROM 数据与 CHR 映射，当前魂斗罗目标为 Mapper 23 / VRC4e。客户端内不读取外部 ROM、不启动外部进程，也不联网。

图集可用时保留原 Texture mask 路径；`Texture:GetTexture()` 返回 nil 时启用原生 `SetColorTexture` 实时回退。回退完整采样256×240 NES画面，按整数2×输出512×480。背景按tile行片段复用nametable、pattern两字节及attribute读取，再逐像素解析；精灵从当前OAM/CHR读取，保留翻转、8×16模式、背景优先级、OAM顺序与左边缘裁剪。

每行连续同色像素合并为矩形，像素工作数组、矩形Texture池和属性cache跨帧复用。clean状态跳过绘制；0.1秒节流拦截保留dirty，后续模拟帧继续尝试。显示更新上限为10Hz；renderer记录累计、最大、最近耗时及可见矩形数。Texture复用并未消除全屏合成和run扫描。

调度使用约12ms模拟预算、最多约3帧债务。renderer执行在模拟预算之外，因此不能以12ms保证整帧UI开销。当前保留完整像素分辨率，实际显示帧率由画面左上角 FPS 显示实时读出。

## 已知限制

复杂画面可能产生大量颜色run与Texture，仍有CPU/UI开销；fallback 10Hz只是显示上限，不能宣称实际达到10 FPS或60 FPS，长时间动画会丢弃中间显示帧。APU无声音输出；PPU逐dot、部分显示边界及CPU逐周期精度仍有限制。Mapper 23 自 2026-10-25 基本块引擎落地后走 `c.g.blocks`（866 块，未命中回退闭包解释器），客户实测 21.6–41.1 FPS（三段均值 31.6、约 939K cycles/s），较闭包分派版 15.6–17.5 FPS 约 1.9 倍。60 FPS 需 1789K cycles/s，当前差距来自未优化的渲染耗时（10–16ms/帧）与约 2/3 指令仍走解释器路径。

23项unittest及8组共491,520像素的新旧路径比较通过，bootstrap身份保持、dirty/节流和Texture池复用检查通过。2026-10-25 完成真实客户端验收：fallback 与 atlas 两路径渲染正确（标题地球/星空、开场剧情文字截图确认），实测数据见实现记录。

## 验证循环

对真实游戏目录的改动走工坊，持久源码变更成功后从游戏真源单向同步完整副本。bootstrap重新执行保留Runtime、games和active；局部renderer更新只需执行renderer。分批传输游戏包使用显式持久全局表，调用已编译chunk时显式传入插件名及该表，避免依赖跨调用可能失效的addon namespace。不要将整包提交脚本作为Python模块导入，以免执行其顶层恢复流程。

工坊load用于热加载已有文件；已检查的接口尚未提供任意插件源码持久写入入口，不能把会话执行或load当作落盘证明。后续需客户端进入世界且窗口可见，确认online后完成目标注册、Start、snap和有间隔的计数采样；持久部署受阻时如实保留待部署状态，不绕过规则直接编辑D盘。
