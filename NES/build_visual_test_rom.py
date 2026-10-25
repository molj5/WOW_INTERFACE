"""Build the self-authored WoW_NES visual/input test ROM.

Code, graphics, and resulting ROM are dedicated to the public domain under CC0 1.0.
No third-party or commercial game material is included.
"""
from __future__ import annotations

import argparse
import hashlib
from pathlib import Path
import struct


ORIGIN = 0x8000
PRG_SIZE = 16 * 1024
CHR_SIZE = 8 * 1024


class Assembler:
    def __init__(self) -> None:
        self.code = bytearray()
        self.labels: dict[str, int] = {}
        self.fixups: list[tuple[int, str, str]] = []

    @property
    def pc(self) -> int:
        return ORIGIN + len(self.code)

    def label(self, name: str) -> None:
        if name in self.labels:
            raise ValueError(f"duplicate label: {name}")
        self.labels[name] = self.pc

    def emit(self, *values: int) -> None:
        self.code.extend(value & 0xFF for value in values)

    def absolute(self, opcode: int, target: int | str) -> None:
        self.emit(opcode)
        if isinstance(target, str):
            self.fixups.append((len(self.code), target, "absolute"))
            self.emit(0, 0)
        else:
            self.emit(target, target >> 8)

    def branch(self, opcode: int, target: str) -> None:
        self.emit(opcode)
        self.fixups.append((len(self.code), target, "relative"))
        self.emit(0)

    def finish(self) -> bytes:
        for offset, label, kind in self.fixups:
            target = self.labels[label]
            if kind == "absolute":
                self.code[offset:offset + 2] = struct.pack("<H", target)
            else:
                source_after_operand = ORIGIN + offset + 1
                delta = target - source_after_operand
                if not -128 <= delta <= 127:
                    raise ValueError(f"branch to {label} is out of range")
                self.code[offset] = delta & 0xFF
        return bytes(self.code)


def make_program() -> tuple[bytes, dict[str, int]]:
    a = Assembler()

    # Zero-page state: $00 frame flag, $01 sprite X, $02 sprite Y.
    a.label("reset")
    a.emit(0x78, 0xD8)                    # SEI; CLD
    a.emit(0xA2, 0xFF, 0x9A, 0xE8)        # LDX #$FF; TXS; INX
    a.absolute(0x8E, 0x2000)               # STX PPUCTRL
    a.absolute(0x8E, 0x2001)               # STX PPUMASK
    a.absolute(0x2C, 0x2002)               # BIT PPUSTATUS
    a.label("wait_vblank")
    a.absolute(0x2C, 0x2002)
    a.branch(0x10, "wait_vblank")          # BPL wait_vblank

    # Upload 32-byte palette.
    a.emit(0xA9, 0x3F)
    a.absolute(0x8D, 0x2006)
    a.emit(0xA9, 0x00)
    a.absolute(0x8D, 0x2006)
    a.emit(0xA2, 0x00)
    a.label("palette_loop")
    a.absolute(0xBD, "palette_data")       # LDA palette_data,X
    a.absolute(0x8D, 0x2007)
    a.emit(0xE8, 0xE0, 0x20)               # INX; CPX #$20
    a.branch(0xD0, "palette_loop")

    # Fill one complete nametable. Tiles 1..4 form a vivid repeating field;
    # the final 64 writes also produce valid, varied attribute bytes.
    a.emit(0xA9, 0x20)
    a.absolute(0x8D, 0x2006)
    a.emit(0xA9, 0x00)
    a.absolute(0x8D, 0x2006)
    a.emit(0xA0, 0x04, 0xA2, 0x00)         # LDY #4; LDX #0
    a.label("nametable_loop")
    a.emit(0x8A, 0x29, 0x03, 0x18, 0x69, 0x01)  # TXA; AND #3; CLC; ADC #1
    a.absolute(0x8D, 0x2007)
    a.emit(0xE8)
    a.branch(0xD0, "nametable_loop")
    a.emit(0x88)
    a.branch(0xD0, "nametable_loop")

    # Sprite 0 uses custom tile 5. Remaining OAM entries use blank tile 0.
    a.emit(0xA9, 112)
    a.emit(0x85, 0x02)                     # sprite Y
    a.emit(0xA9, 120)
    a.emit(0x85, 0x01)                     # sprite X
    a.absolute(0x20, "write_sprite")

    # Explicit zero scroll is important for the approximate current renderer.
    a.emit(0xA9, 0x00)
    a.absolute(0x8D, 0x2005)
    a.absolute(0x8D, 0x2005)
    a.emit(0xA9, 0x80)
    a.absolute(0x8D, 0x2000)               # NMI on, 8x8, pattern table 0
    a.emit(0xA9, 0x1E)
    a.absolute(0x8D, 0x2001)               # show background and sprites

    a.label("main")
    a.emit(0xA5, 0x00)
    a.branch(0xF0, "main")                 # wait for NMI frame flag
    a.emit(0xA9, 0x00, 0x85, 0x00)

    # Latch controller 1 and discard A/B/Select/Start.
    a.emit(0xA9, 0x01)
    a.absolute(0x8D, 0x4016)
    a.emit(0xA9, 0x00)
    a.absolute(0x8D, 0x4016)
    for _ in range(4):
        a.absolute(0x20, "read_button")

    # Up.
    a.absolute(0x20, "read_button")
    a.branch(0xF0, "not_up")
    a.emit(0xA5, 0x02, 0xC9, 17)
    a.branch(0x90, "not_up")
    a.emit(0xC6, 0x02)
    a.label("not_up")

    # Down.
    a.absolute(0x20, "read_button")
    a.branch(0xF0, "not_down")
    a.emit(0xA5, 0x02, 0xC9, 224)
    a.branch(0xB0, "not_down")
    a.emit(0xE6, 0x02)
    a.label("not_down")

    # Left.
    a.absolute(0x20, "read_button")
    a.branch(0xF0, "not_left")
    a.emit(0xA5, 0x01, 0xC9, 9)
    a.branch(0x90, "not_left")
    a.emit(0xC6, 0x01)
    a.label("not_left")

    # Right.
    a.absolute(0x20, "read_button")
    a.branch(0xF0, "not_right")
    a.emit(0xA5, 0x01, 0xC9, 248)
    a.branch(0xB0, "not_right")
    a.emit(0xE6, 0x01)
    a.label("not_right")
    a.absolute(0x20, "write_sprite")
    a.absolute(0x4C, "main")

    a.label("read_button")
    a.absolute(0xAD, 0x4016)
    a.emit(0x29, 0x01, 0x60)               # AND #1; RTS

    a.label("write_sprite")
    a.emit(0xA9, 0x00)
    a.absolute(0x8D, 0x2003)
    a.emit(0xA5, 0x02)
    a.absolute(0x8D, 0x2004)
    a.emit(0xA9, 0x05)
    a.absolute(0x8D, 0x2004)
    a.emit(0xA9, 0x00)
    a.absolute(0x8D, 0x2004)
    a.emit(0xA5, 0x01)
    a.absolute(0x8D, 0x2004)
    a.emit(0x60)

    a.label("nmi")
    a.emit(0x48, 0x8A, 0x48, 0x98, 0x48)  # preserve A/X/Y
    a.emit(0xE6, 0x00)                     # INC frame flag
    a.emit(0x68, 0xA8, 0x68, 0xAA, 0x68, 0x40)

    a.label("irq")
    a.emit(0x40)                            # RTI

    a.label("palette_data")
    a.emit(
        0x0F, 0x21, 0x11, 0x30,  0x0F, 0x27, 0x17, 0x37,
        0x0F, 0x2A, 0x1A, 0x30,  0x0F, 0x2C, 0x1C, 0x30,
        0x0F, 0x16, 0x27, 0x30,  0x0F, 0x19, 0x29, 0x30,
        0x0F, 0x12, 0x22, 0x30,  0x0F, 0x1C, 0x2C, 0x30,
    )
    return a.finish(), a.labels


def encode_tile(rows: list[list[int]]) -> bytes:
    if len(rows) != 8 or any(len(row) != 8 for row in rows):
        raise ValueError("tile must be 8x8")
    low = bytearray(8)
    high = bytearray(8)
    for y, row in enumerate(rows):
        for x, pixel in enumerate(row):
            low[y] |= (pixel & 1) << (7 - x)
            high[y] |= ((pixel >> 1) & 1) << (7 - x)
    return bytes(low + high)


def make_chr() -> bytes:
    blank = [[0] * 8 for _ in range(8)]
    checker = [[1 + ((x + y) & 1) for x in range(8)] for y in range(8)]
    frame = [[3 if x in (0, 7) or y in (0, 7) else 1 for x in range(8)] for y in range(8)]
    diagonal = [[2 if x == y or x == 7 - y else 1 for x in range(8)] for y in range(8)]
    star = [
        [0, 0, 0, 3, 3, 0, 0, 0],
        [0, 0, 0, 3, 3, 0, 0, 0],
        [0, 3, 3, 3, 3, 3, 3, 0],
        [3, 3, 3, 2, 2, 3, 3, 3],
        [0, 3, 3, 3, 3, 3, 3, 0],
        [0, 0, 3, 0, 0, 3, 0, 0],
        [0, 3, 0, 0, 0, 0, 3, 0],
        [3, 0, 0, 0, 0, 0, 0, 3],
    ]
    player = [
        [0, 0, 3, 3, 3, 3, 0, 0],
        [0, 3, 2, 2, 2, 2, 3, 0],
        [3, 2, 3, 2, 2, 3, 2, 3],
        [3, 2, 2, 2, 2, 2, 2, 3],
        [3, 2, 3, 2, 2, 3, 2, 3],
        [3, 2, 2, 3, 3, 2, 2, 3],
        [0, 3, 2, 2, 2, 2, 3, 0],
        [0, 0, 3, 3, 3, 3, 0, 0],
    ]
    data = b"".join(encode_tile(tile) for tile in (blank, checker, frame, diagonal, star, player))
    return data + bytes(CHR_SIZE - len(data))


def build_rom() -> tuple[bytes, dict[str, int]]:
    program, labels = make_program()
    if len(program) > PRG_SIZE - 6:
        raise ValueError("program does not fit NROM-128")
    prg = bytearray([0xEA] * PRG_SIZE)
    prg[:len(program)] = program
    prg[-6:] = struct.pack("<HHH", labels["nmi"], labels["reset"], labels["irq"])
    # iNES 1.0: 1x16 KiB PRG, 1x8 KiB CHR, Mapper 0, horizontal mirroring.
    header = b"NES\x1A" + bytes((1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    return header + bytes(prg) + make_chr(), labels


def main() -> int:
    parser = argparse.ArgumentParser(description="Build the CC0 WoW_NES visual test ROM")
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).with_name("wownes_visual_test.nes"))
    args = parser.parse_args()
    rom, labels = build_rom()
    args.output.write_bytes(rom)
    vectors = {name: labels[name] for name in ("nmi", "reset", "irq")}
    print(f"output={args.output.resolve()}")
    print(f"bytes={len(rom)}")
    print(f"sha256={hashlib.sha256(rom).hexdigest()}")
    print("vectors=" + ",".join(f"{name}=0x{address:04X}" for name, address in vectors.items()))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
