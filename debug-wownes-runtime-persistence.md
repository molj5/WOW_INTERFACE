# Debug WoWNES Runtime Persistence

Status: [OPEN]

## Symptom
跨工坊调用后 `WoWNES_Runtime.active/games` 状态疑似消失；重复加载可能触发 bootstrap 清空和 Register 原地变换，F813FF 的长度/物理字节原因尚未证实。

## Hypotheses
1. `run` 每次调用创建新的 Lua 执行环境，因此同一 addon 的全局状态不会跨调用保留。
2. `run` 保留环境，但 bootstrap 每次执行主动清空 `WoWNES_Runtime`，覆盖了旧 `games/active`。
3. Runtime 与 Game 分属 namespace，跨 addon 的传递参数/源码执行方式使旧 `g` 与新 namespace 混用。
4. `Register` 的 `table.concat(g.prg)` 和 `g.blocks={[0]=g.blocks}` 在重复执行时非幂等，导致程序/块索引损坏。
5. F813FF 来自实际 `c.g.prg` 长度或读取物理字节异常，而非单纯输入/渲染问题。

## Evidence Log
- `mcp_wuxian.run` on addon `WoWNES_Game_0b79e04375c0` returned `probe=1`, then `probe=2`; the same run namespace persists state.
- The Runtime probe returned `exists=true`, `version=0.1.0`, and `games=1`. Therefore `/run` does not inherently rebuild the Lua namespace.
- The source bootstrap did replace `WoWNES_Runtime` and discard `previous.games`; this is confirmed as the reset mechanism when bootstrap is executed again.
- Before the fix, the registered game was `6060e087239e:string:16384` with `blocks[0]` a table. After the fix and Runtime `load`, the same registration remained valid. A fresh `Start("6060e087239e")` returned `ok=true`, `active=true`, `pc=51102`, `prg=16384`.
- Physical reads from that active old package were captured: `$FFFC=158`, `$FFFD=199`, `$FFFE=240`, `$FFFF=255`. This is concrete client evidence; no F813FF claim was made for the unrelated old package.
- `inspect` showed a visible 512x480 Runtime frame at `[587,210,745,699]`; `snap` produced `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-225503-338.png`. The screenshot was the WoW world, not Contra, because the target `0b79...` package was not present after the daemon timeout.
- Runtime `load` after the fix succeeded for all 8 files, jobs `2335111673` through `2335111689`, with no errors/warnings. Target game `load` then failed with `daemon_unreachable`; later status showed link recovery, but the game was not in a frame state and the target package directory was absent.
- Local regression commands were attempted twice but the machine Python launcher failed before execution (`Python310` missing, then `Python312` process creation failure). No test assertion result was produced.

## Changes
- `F:\WOW_INTERFACE\NES\wow_nes_runtime.py` now preserves an existing `WoWNES_Runtime` table and `games/active` across repeated bootstrap execution.
- `Register` now concatenates PRG only when it is still a table, wraps blocks only when not already wrapped, and builds `irIndex` only when absent.
- The corresponding true-source file `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Runtime\bootstrap.lua` was updated and copied to the workspace Runtime replica. Existing implementation documentation was updated.

## Status
- Root cause confirmed and minimal fix applied.
- Persistent real-client Runtime canvas verified.
- Contra target package registration, F813FF mapped read, real screenshot, and physical Enter/Right/Z/X input remain unverified because the target package submission was interrupted by daemon/link loss and the target package is no longer present.
