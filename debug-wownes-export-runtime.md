# WoWNES export/runtime debugging

- Session: `wownes-export-runtime`
- Status: [OPEN]
- Scope: export, validate/checksum, safe deployment/sync, and in-client runtime evidence.
- Constraint: no business-logic modification before runtime evidence; no unknown-work overwrite.

## Falsifiable hypotheses

1. The current converter exports ROM ID `b54f90e68ebf` and passes validation/checksum.
2. The target AddOns package can be deployed without overwriting unknown work.
3. The existing runtime is compatible and does not require replacement.
4. The ROM starts through a public runtime entry point and exposes advancing emulator state without Lua errors.
5. Safe input inspection/injection is available; otherwise no real-keyboard claim will be made.

## Evidence log

- Python 3.11 unittest: 17/17 pre-change and 18/18 post-fix passed.
- Export root: `C:\Users\molangjie\AppData\Local\Temp\WoWNES-delivery-b54f90e68ebf`.
- ROM SHA-256: `b54f90e68ebf569a1f715742006373170af309d25340ffecfea20fc8585a5383`; both packages validate.
- Initial generated/runtime hash comparison: identical, so runtime was not overwritten before evidence.
- Game package target was absent, then deployed and synced; export/game/workspace relative-file hash differences: 0.
- Pre-fix runtime evidence: emulator advanced to frame 224 / 6,690,035 cycles with no Lua error, but `debt` remained about 0.0493 (> 1/60) and all 3,261 tile textures stayed hidden (`shown=0`), leaving only the gray background. Programmatic pad-right still changed sprite X from 120 to 248, proving CPU/controller execution despite missing render submission.
- Confirmed root cause: scheduler rendered only when `debt < 1/60.0988`; sustained lag permanently starved rendering.
- Fix: render once per newly completed PPU frame (`renderedFrame`) while retaining bounded catch-up work.
- Post-fix hot-load: after 5 seconds, no errors; frame/renderedFrame = 58/58, dirty=false, shown textures=1982 while debt remained about 0.0493. Programmatic pad-right changed X 120 -> 173; this is injected pad state, not real keyboard input.
- Persistent runtime deployment to AddOns was blocked by the execution environment allowlist, despite explicit approval; the fixed runtime was hot-loaded from the validated external package and synced to `F:\WOW_INTERFACE\WoWNES_Runtime`, but the on-disk game runtime remains the pre-fix version.
