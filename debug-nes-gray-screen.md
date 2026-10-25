# Debug Session: nes-gray-screen

- Status: [OPEN]
- Symptom: WOW_NES runtime advances and reports shown textures, but workshop screenshot remains a solid gray panel.
- Expected: Original checkerboard, border, star, and sprites are visibly rendered.
- Constraint: Do not directly edit deployed game addon source; use Wuxian Workshop and authorized deployment paths.

## Falsifiable hypotheses

1. Texture files are absent from the deployed addon or Lua texture paths do not resolve in WoW.
2. Generated TGA encoding, origin, channel order, or alpha is incompatible/transparent.
3. Mask, vertex color/alpha, UVs, draw layer, frame strata, or frame level suppresses otherwise valid textures.
4. Background slot coordinates or CHR mapping place all visible pixels outside the panel or sample transparent regions.
5. Hot-loaded Lua and deployed texture resources belong to different package/ROM versions.

## Evidence log

- Deployed package exists at `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Game_b54f90e68ebf`, including all three TGA files.
- Runtime texture probes resolve both `.tga` and extensionless paths: `SetTexture` returns true and resolves mask 1 to file handle `-10196`; direct atlas probes visibly show the expected mask pixels.
- Active renderer state is valid: mask=30, ctrl=128, shown textures=1982, representative textures have alpha=1, nonzero vertex colors, valid UVs, in-bounds points, and are visible.
- Temporarily moving the active view from MEDIUM/1 to TOOLTIP/100 immediately reveals the checkerboard, border, stars and sprites.
- Enumerating frames finds two simultaneously shown 512x480 UIParent children at the same rectangle: the active rendered frame and a stale MEDIUM/1 frame with its own OnUpdate. The stale frame is the solid gray occluder left by hot-loading after `bootstrap.lua` replaces `WoWNES_Runtime` and loses the previous `active` reference.

- Hot-loading the fixed external runtime executes all eight files successfully after a zero-error/zero-warning workshop check. Reloading the game package executes all nine Lua files successfully.
- Post-fix inspection finds exactly one shown 512x480 frame and exactly one such frame with `OnUpdate`; it remains at the normal `MEDIUM/1` strata/level. At the sampled point, frame=160, renderedFrame=160, cycles=4777715, and 1982 mask textures are shown.
- Post-fix screenshot `C:\Users\molangjie\AppData\Local\WuxianWorkshop\snaps\snap-205545-690.png` visibly shows the checkerboard, borders, stars, and center sprite without the earlier `TOOLTIP/100` diagnostic workaround.

## Conclusion

Hypothesis 3 is confirmed specifically as stale-frame occlusion. Hypotheses 1, 2, and 4 are rejected by direct texture probes and the revealed rendered image. Hypothesis 5 contributed through hot-loaded runtime lifecycle: resource versions match, but the prior runtime frame survived table replacement. The bootstrap lifecycle fix is verified by the post-fix single-frame inspection and visible screenshot. The fix is currently hot-loaded only: the deployed `D:\World of Warcraft\_classic_\Interface\AddOns\WoWNES_Runtime\bootstrap.lua` still has the old first line, so a client restart would lose the fix until the runtime package is deployed through an authorized mechanism.
