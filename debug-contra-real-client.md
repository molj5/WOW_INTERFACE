# Debug Contra Real Client

Status: [OPEN]

## Hypotheses
1. The ROM registration exists but the segmented PRG/CHR data is incomplete or checksum-mismatched.
2. Mapper 23 bank switching or fixed bank 15 mapping still causes the F813 read/execute failure.
3. CPU initialization or IRQ delivery is not reaching a stable execution state.
4. The black frame is caused by missing deployed texture assets rather than emulator execution.
5. Keyboard events are injected but are not consumed correctly through 4016.

## Evidence Log

### 2026-10-18 live client probe

- Wuxian status is online (WoW PID 361136, build 5.5.4.70449, 4092 slots). The target addon namespace `WoWNES_Game_0b79e04375c0` was newly created by the probe; it had no registered namespace state. Global `WoWNES_Runtime.games` contains exactly one game: ROM `6060e087239e`, Mapper 0, PRG 16384 bytes, CHR 8192 bytes. Its manifest agrees; the client does not contain Contra `0b79e04375c0`.
- The old game's checksums from a runtime query were PRG rolling checksum `d1592fda` and CHR `b25e5d55`, not sufficient to establish any target ROM identity. No target SHA, PRG/CHR checksum, bank mapping, or target IRQ evidence is available because the target object is absent.
- Starting the only registered old game succeeded (`Start` returned true). Its active emulator state has CPU registers/PC/cycles and a view, but this is the unrelated old 16 KiB Mapper 0 ROM. The current bridge exposes `run` and `try` for Lua, but no keyboard event injection API has yet been identified. This is not evidence of Contra execution or input response.
- Previous history records all 32 target PRG shards, full CHR map, and registration Lua returned successful execution in a prior session, but the current client runtime lacks that registration. Thus prior Lua success did not persist through the client's current lifecycle.
- No target F813 error occurred in this session, so no same-error ROM identity/mapped-byte evidence exists. TGA deployment, target screenshot, Contra title/gameplay, and real `$4016` keyboard consumption remain unverified.

### Findings

- Current blocker is conclusive: Contra is not registered in the live client. Do not infer its CPU/IRQ/mapping state from the unrelated ROM.
- Do not invoke Start on the old game as a substitute. No code/source changed and no user game files were written.
