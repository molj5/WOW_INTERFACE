# Debug Session: contra-local-verification

Status: [LOCAL-MOCK-VERIFIED; REAL CLIENT TITLE AND GAME CAPTURED; CLIENT INPUT SESSION-BOUNDARY LIMIT]

## Objective

Load the exported Contra addon package in a local Lua 5.1-compatible mock, reproduce WoW frame/input/update callbacks, render the real TGA atlas to PNG, and verify title plus actual gameplay controls with distinguishable evidence.

## Hypotheses

1. The existing mock lacks required WoW APIs or frame lifecycle behavior, preventing a complete TOC load.
2. The selected Lua VM differs from Lua 5.1 semantics required by the generated runtime.
3. CPU/PPU execution succeeds but atlas decoding or texture-coordinate composition is incorrect.
4. Keyboard callbacks fire but do not reach NES controller latching, so frame changes do not prove actual input.

## Evidence Log

- Baseline export and TOC load succeeded under Lupa 2.5 using Lua 5.1.
- At PPU frame 9 and CPU cycle 281734, execution stopped with `attempt to perform arithmetic on global 'base'`.
- Added traceback-only mock instrumentation and reproduced the same state. Stack: `spriteZero -> ppuTick -> step -> OnUpdate`.
- Source inspection confirmed `spriteZero` computed `pattern` but read `base+row`; `base` is undefined in that function.
- Minimal fix changes those reads to `pattern+row` and adds regression coverage before rerunning the real ROM.

## 2026-10-18 Local Lua 5.1 Mock Verification

- `verify_contra_local.py` read the sole `.nes` member directly from `F:\WOW_INTERFACE\NES\魂斗罗.zip` and verified SHA-256 `0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5`; Mapper 23, PRG/CHR 128 KiB each.
- Exported package was loaded in TOC order in Lupa 2.5 / Lua 5.1: 8 runtime Lua files and 37 game Lua files. Mocked only WoW UI, callbacks, scheduling, and texture presentation; CPU/mapper/PPU/game logic ran from the generated package.
- Captured title, Start, intro, stage, spawned-player, movement, attack, and jump PNG/RAM/OAM snapshots under `F:\WOW_INTERFACE\NES\contra-local-evidence`. The title reached frame 299; the stage was visible by frame 615 and player state was captured at frame 1256.
- Start and gameplay inputs traversed key callbacks, controller serial reads at `$4016`, and the game loop. Against idle branches from the same checkpoint, Right changed 60 RAM bytes, 25 OAM bytes, and 5540 pixel channels; A changed 77/69/4288; B changed 118/77/108. These are state-difference counts, not claims of hardware keyboard input.
- `evidence.json` records ROM identity, package file counts, controller reads, snapshots, hashes, and comparisons. Runtime regressions passed: 48 golden runs, 151 official opcodes, 17 checks across 3 backends. IRQ regressions passed 15 checks. `py -3.11 -m unittest test_wow_nes.py -v` passed all 20 tests.
- Reproduce with `py -3.11 verify_contra_local.py`; Python 3.11, Lupa 2.5, and Pillow are required. The stable evidence directory is `F:\WOW_INTERFACE\NES\contra-local-evidence`.

## 2026-10-18 Real Client Title and Session Boundary

- Regenerated the complete target package from the original ZIP with Python 3.11 at `C:\Users\MOLANG~1\AppData\Local\Temp\wownes-contra-package-ai9ufrup`. The normal local verification completed with exit code 0 and the same identity/input/regression results above.
- Executed all eight current runtime files, manifest, 32 PRG shards, fallback IR, translated blocks, complete CHR source and register in the real client. CHR execution job `2336095290` returned `1138734`; register job `2336096049` succeeded.
- Independent client query `2336193327` confirmed target ID/SHA, Mapper 23, PRG and CHR each 131072 bytes; client Adler-32 values matched local values exactly: PRG `3204245079`, CHR `2232853014`.
- Target Start job `2336198887` returned true. Probe `2336212646` confirmed active target `0b79e04375c0`, running true, no error, PPU frame 72, cycles 2145278, `pixelFallback=true`, 1562 visible color segments and 41 renders.
- Real game-window screenshot `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-231020-657.png` shows KONAMI, the Contra title and two character portraits inside the WoW client. Text has visibly incomplete small strokes at the fallback's 128x120 sampling resolution; this is not an atlas-rendered screenshot.
- Before input setup, probe `2336295127` returned only the old registered ROM and no active instance; the addon namespace was newly allocated. Subsequent status showed the same game process but a changed bridge session (`57963` to `10697`). Thus the previous target state did not survive this observed session boundary. No old ROM Start was issued. A second full transfer was started with input instrumentation immediately following target registration/Start.
- These are hot-execution results. No persistent game-source or TGA deployment was performed during this run.

## 2026-10-18 Second Hot Execution and Input Boundary

- Rebuilt/transferred the package again from the original ZIP using Python 3.11. All runtime files, manifest, 32 PRG shards, 1,138,734-character CHR source, fallback IR, translated blocks, and register returned successful `run` results. The combined final Start/instrumentation call was rejected by WoW with `combat`; this was a gameplay lock, not a transfer or registration failure.
- After combat, an independent query in bridge session `10697` confirmed target ID/SHA, Mapper 23, PRG/CHR 131072 bytes, with no ROM active. A separate target `Start` then returned true and reported `running=true`, `pixelFallback=true`.
- Invoking the registered `OnKeyDown`/`OnKeyUp` scripts directly through Lua changed pad masks to 8/128/1/2 and released each back to 0 (8 callbacks total). This did not constitute physical keyboard input. Calling `OnUpdate` directly did not advance gameplay; instrumentation recorded no controller reads, so those direct callback calls do not prove `$4016` consumption or gameplay response.
- A subsequent `try` started the target and allowed real WoW UI updates for four seconds. Its screenshot showed the KONAMI/Contra title screen and the on-screen `Z=A X=B ENTER=START ARROWS=MOVE ESC=EXIT` prompt. A later screenshot at `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-232310-236.png` showed the client back in the WoW world while the NES frame counter had reached 105; a probe confirmed `running=true`, no Lua error, and pixel fallback enabled. This confirms the title renderer and real UI scheduler executed, though this later screen is not itself a Contra stage capture.
- After that screenshot/probe, the bridge session changed from `10697` to `41031`. The next addon-scoped call reported that the namespace was newly allocated; runtime instrumentation and the active target no longer survive this boundary. No further large transfer was attempted. No physical-keyboard delivery, real `$4016` input reads, or input-caused gameplay changes are established.

## Remaining Limits

- Local input comparisons prove the generated package in a Lua 5.1/WoW-API mock, including controller serial reads and state/graphics differences. In the real client, only direct callback mask set/release was observed; it did not yield serial-read evidence. Physical keyboard delivery and real-client input-driven gameplay remain unverified.
- No real audio output, 10-minute stability run, performance percentile measurement, cycle/dot-accurate PPU verification, or broad Mapper 23 compatibility claim is established.
