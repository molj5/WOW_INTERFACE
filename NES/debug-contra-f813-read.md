# Debug Session: contra-f813-read

Status: [OPEN]

## Symptom

真实 WoW 客户端魂斗罗包在第二次启动时报告 `$F813` 取指 `0xFF`；当时曾以固定 bank 对应字节 `0x08` 作为对照，但该前提已被当前 ROM 实际 mapping 证据否定。首轮完整 load 后 Start 约 142 帧黑画面；第二次 Start 报 `Unsupported unofficial opcode FF at F813`。本地 Lua 5.1 mock/runtime 回归通过。

## Hypotheses

1. PRG 分块索引、manifest 或 PRG 版本错位，导致客户端拼接出的字节在 `0xF813` 附近为 `0xFF`。
2. 全局 `g.prg`、raw/decode caches 或旧对象引用在热 load、Stop/Start、原 New 闭包之间残留。
3. 缺失 chunk 或 unloaded read 的 `0xFF` 默认值覆盖/遮蔽了真实已加载 PRG 数据。
4. Mapper 23 bank swap 后 CPU `0xF813` 实际映射到错误 PRG offset；静态固定 bank 对照不足以排除运行时映射错误。
5. Lua local-upvalue、环境差异、bit 库或 string 字节编码使客户端解码/取指与本地实现不一致。

## Evidence Log

### 2026-10-18 source and local evidence

- `wow_nes.py:439-442` emits PRG shards in source order, 4096 bytes per shard; `validate_package()` at `wow_nes.py:513-545` requires numeric shard names to be contiguous and reconstructs exactly `manifest.prg_bytes`. The generated Contra package validates successfully with 32 PRG shards and 131072 PRG bytes.
- `wow_nes_runtime.py:16-20` concatenates the loaded shard list once at registration. Local Lua 5.1 execution of the real Contra package reaches title, stage and player spawn; Mapper 23 bank state changes are observed (`prg0=20/24`, `prg1=21/25`) with no interpreter error. Python unittest: 20/20 passed.
- The local ROM SHA-256 is `0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5`; at relative offset `0x1813`, 8 KiB bank 0 and bank 4 contain `08`, while fixed last bank 15 contains `FB`. Therefore `F813=08` is bank-state-dependent and is not evidence of a linear PRG offset.

### 2026-10-18 client evidence

- Wuxian `status`: daemon online, game build `5.5.4.70449`, link online, 1743 slots remaining at first inspection. Current client `R.games` contains exactly `6060e087239e:16384:mapper0:sha256=6060e087239ed301916e59a56b3756c25eb5552c4b8bb76a9b22fb1906383803`.
- The real client files confirm the same object: `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_6060e087239e\manifest.lua` declares Mapper 0 and 16 KiB PRG; its TOC has only `prg-data-0.lua` through `prg-data-3.lua`. `WoWNES_Runtime\bootstrap.lua` is also an older runtime without Mapper state (`R:New` has no `mapper`).
- A newly generated target package at `C:\Users\MOLANG~1\AppData\Local\Temp\wownes-contra-package-oky4rl85` passed Wuxian `check`: runtime 8 files and game 37 files, both with zero errors/warnings. Runtime `load` succeeded for all 8 files (jobs `2308398062` through `2308398076`).
- Target game `load` was attempted twice with 60-second timeouts and failed before reaching the game with `daemon_unreachable`; immediately afterward the minimal `run` also did not reach the game. `history` for `WoWNES_Game_0b79e04375c0` remains empty, and no target-package Lua error exists in the log. Consequently the target package never produced a client registration or CPU/mapper read.

### Findings

- Confirmed current deployment/registration mismatch: the client is running the old registered 16 KiB Mapper 0 object (`6060e087239e`), not the Contra Mapper 23 object (`0b79e04375c0`). This establishes the current client state, but does not directly prove that the historical `$F813=FF` error was caused by this same old object. That historical cause requires evidence from the same error, including `rom_id`/SHA, mapper, and the PRG byte at the mapped `$F813` address.
- The ROM evidence does not support a fixed `F813=08` premise: at relative offset `0x1813`, fixed last 8 KiB bank 15 contains `0xFB`, while `0x08` occurs in banks 0 and 4. `$F813` must therefore be evaluated using the actual runtime bank mapping. Current evidence does not exclude a bank-mapping, encoding, cache, or partial-load issue in the client.
- Local PRG concatenation and Lua 5.1 mock execution pass their local checks, and no fallback-to-`0xFF` or Mapper change was made. Those results do not exclude client-specific caching or partial loading. The unresolved delivery failure occurs before target-package registration/history and therefore provides no target client CPU/mapper read evidence.

### 2026-10-18 addon-aware split submission

- Submitted the validated package at `C:\Users\MOLANG~1\AppData\Local\Temp\wownes-contra-package-oky4rl85` through the Workshop daemon's `/api/run`, explicitly using addon `WoWNES_Game_0b79e04375c0`. The bridge preserves this addon's namespace across runs; large files were transported in segments and the complete original Lua source was compiled and executed with the same addon name and namespace.
- All eight current Runtime files returned success. Manifest, all 32 PRG shards, fallback IR, translated blocks, the complete 1,138,734-character `chr-map.lua`, and `register.lua` returned success. Final CHR execution job `2310513242` returned source length `1138734`; registration job `2310514078` returned success (daemon log 16:01:54). No NES Start or key simulation was performed.
- A client probe before registration returned `Runtime.active=nil`; registration was completed after that probe. Registration execution success does not substitute for the requested independent manifest/data/mapping queries.
- Local reference Adler-32 values: PRG `3204245079`, CHR `2232853014`, each 131072 bytes. The attempted client checksum query failed with `link_down`, so these values have NOT been matched against client memory.
- Subsequent status reported link offline, same WoW PID `336656`, with 143 message slots left. Screenshot `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-161113-547.png` confirms the character selection screen. Client memory verification, CPU mapped reads, and runtime IRQ verification remain blocked until the player enters the world; registration after re-entry must be queried again rather than assumed to survive logout.
- The target addon directory is absent from the game's AddOns directory. No game source files were changed. Lua execution from the external candidate package did not deploy TGA files. Hidden texture probes returned true from `SetTexture` but no usable `GetTexture` value, so texture readability is not established. Public Workshop `install` only installs its bridge addons, `new_addon` generates templates, and `load` transfers Lua; no supported arbitrary package/TGA deployment endpoint was found in the exposed tools or UI API documentation.
- This session therefore establishes successful split delivery and registration execution before the client left the world, but does not close the historical F813 issue or establish a playable persistent installation.

### 2026-10-18 verified target submission and combat-blocked start

- Re-submitted the complete target package through the Workshop daemon `/api/run`, preserving addon namespace `WoWNES_Game_0b79e04375c0`. Runtime file jobs all succeeded (`2330852575`, `2330853155`, `2330853921`, `2330855638`, `2330856641`, `2330857593`, `2330858159`, `2330859159`); manifest job `2330859913`; all 32 PRG shard jobs from `2330860754` through `2330953100` succeeded.
- CHR source was transported in serialized chunks; final execution job `2331175622` returned `1138734`. Fallback IR job `2331176393`, translated blocks job `2331177163`, and register job `2331178127` succeeded. No concurrent namespace write occurred during the final transfer/execution window.
- Independent client probe job `2331213206` confirmed target registration, manifest `rom_id=0b79e04375c0`, Mapper 23, PRG/CHR each 131072 bytes, concatenated `g.prg` length 131072 and `g.chr` string length 131072; manifest SHA-256 is `0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5`. Adler-32 and runtime mapper-bank mapping were not yet independently measured in the client.
- Start attempt job `2331227657` returned `false, "combat"`. Follow-up job `2331238699` confirmed `InCombatLockdown()==true`; scheduler intentionally refuses to create a view while in combat. Workshop remained online, but screenshot `snap-214726-202.png` shows the active WoW combat scene, not NES output. No key handlers or `$4016` reads were exercised; Start, display, and input validation must be repeated after combat ends.
- No TGA deployment, renderer fallback, or generator change was made because the target renderer could not be started to establish a missing-texture failure. No game-directory source was edited.

## Constraints

- Do not alter business logic before runtime evidence.
- Game client source is the source of truth; synchronize the full addon copy to `F:\WOW_INTERFACE` after any game-directory source change.
- Client: MoP Classic CN Infinite, interface 50504, Lua 5.1.4.
