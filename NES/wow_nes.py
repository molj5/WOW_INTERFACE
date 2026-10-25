"""WOW_NES standalone offline converter. Python 3.11+, standard library only."""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import re
import shutil
import signal
import struct
import tempfile
import uuid
import zipfile
from dataclasses import dataclass
from typing import Callable

VERSION = "0.1.0"
MAX_ROM = 8 * 1024 * 1024


def object_schema(properties: dict, required=None) -> dict:
    return dict(type="object", properties=properties,
                required=list(properties) if required is None else required,
                additionalProperties=False)


UINT = dict(type="integer", minimum=0)
ADDRESS = dict(type="integer", minimum=0, maximum=65535)
SHA = dict(type="string", pattern=r"^[0-9a-f]{64}$")
STRINGS = dict(type="array", items=dict(type="string"))
COMMON_REPORT = dict(schema_version=dict(const=1), converter_version=dict(type="string", const=VERSION),
                     compatible=dict(type="boolean"), reason_codes=STRINGS, sha256=SHA,
                     rom_id=dict(type="string", pattern=r"^[0-9a-f]{12}$"),
                     audio_output=dict(const="none"))
DIAGNOSTIC_SCHEMA = {"oneOf": [dict(type="null"), object_schema(dict(
    format=dict(enum=["iNES", "NES2"]), submapper=UINT, prg_bytes=UINT,
    chr_bytes=UINT, mirroring=dict(enum=["horizontal", "vertical"])))]}
ROM_REPORT = dict(format=dict(enum=["iNES", "NES2"]), mapper=dict(enum=[0, 23]), submapper=dict(const=0),
                  mirroring=dict(enum=["horizontal", "vertical", "one-screen-a", "one-screen-b"]),
                  region=dict(const="NTSC"), prg_bytes=dict(type="integer", minimum=16384),
                  chr_bytes=dict(type="integer", minimum=8192), trainer_bytes=dict(enum=[0, 512]),
                  prg_ram_bytes=dict(type="integer", minimum=0, maximum=8192),
                  vectors=object_schema(dict(nmi=ADDRESS, reset=ADDRESS, irq=ADDRESS)))
TRANSLATION_SCHEMA = object_schema(dict(
    static_blocks=UINT, ir_instructions=UINT, analyzed_bytes=UINT, fallback_prg_bytes=UINT,
    stops=dict(type="array", items=object_schema(dict(pc=ADDRESS, reason=dict(enum=[
        "OUTSIDE_ROM", "UNOFFICIAL_OPCODE", "WRAPPED_INSTRUCTION", "OVERLAPPING_CODE", "INDIRECT_JUMP"])))),
    ambiguous_addresses=dict(type="array", items=ADDRESS),
    block_key=dict(enum=["bank0_physical_prg_offset", "mapper23_physical_prg_offset"]), physical_bank_key_pending=dict(const=False)))
ATLAS_SCHEMA = object_schema(dict(tiles=dict(type="integer", minimum=512),
    unique_tiles=dict(type="integer", minimum=1, maximum=8192),
    width=dict(type="integer", minimum=16, maximum=2048),
    height=dict(type="integer", minimum=16, maximum=2048), layers=dict(const=3), gutter=dict(const=1)))
CHECKSUMS_SCHEMA = dict(type="object", additionalProperties=dict(
    type="object", additionalProperties=SHA))
# JSON Schema subset implemented below; inspect, rejection and export are distinct variants.
REPORT_SCHEMA = {"$schema": "https://json-schema.org/draft/2020-12/schema", "oneOf": [
    object_schema(dict(COMMON_REPORT, compatible=dict(const=False),
                       reason_codes=dict(type="array", minItems=1, items=dict(type="string", pattern=r"^[A-Z][A-Z0-9_]*$")),
                       mapper=dict(type=["integer", "null"], minimum=0, maximum=4095),
                       diagnostic=DIAGNOSTIC_SCHEMA)),
    object_schema(dict(COMMON_REPORT, **ROM_REPORT, compatible=dict(const=True), reason_codes=dict(const=[]))),
    object_schema(dict(COMMON_REPORT, **ROM_REPORT, compatible=dict(const=True), reason_codes=dict(const=[]),
                       translation=TRANSLATION_SCHEMA, atlas=ATLAS_SCHEMA,
                       output_directories=dict(type="array", minItems=2, maxItems=2,
                                               items=dict(type="string", pattern=r"^[A-Za-z0-9_]+$")),
                       warnings=dict(type="array", minItems=1, items=dict(type="string")),
                       checksums=CHECKSUMS_SCHEMA),
                  list(COMMON_REPORT) + list(ROM_REPORT) + ["translation", "atlas", "output_directories", "warnings"])
]}


def schema_matches(value, schema: dict) -> bool:
    if "oneOf" in schema:
        return sum(schema_matches(value, part) for part in schema["oneOf"]) == 1
    if "const" in schema and (type(value) is not type(schema["const"]) or value != schema["const"]):
        return False
    if "enum" in schema and not any(type(value) is type(item) and value == item for item in schema["enum"]):
        return False
    kinds = schema.get("type", [])
    kinds = [kinds] if isinstance(kinds, str) else kinds
    types = dict(object=dict, array=list, integer=int, string=str, boolean=bool, null=type(None))
    if kinds and not any(type(value) is types[kind] for kind in kinds):
        return False
    if type(value) is int:
        if value < schema.get("minimum", value) or value > schema.get("maximum", value):
            return False
    if isinstance(value, str) and "pattern" in schema and not re.fullmatch(schema["pattern"], value):
        return False
    if isinstance(value, list):
        if not schema.get("minItems", 0) <= len(value) <= schema.get("maxItems", len(value)):
            return False
        if "items" in schema and not all(schema_matches(item, schema["items"]) for item in value):
            return False
    if isinstance(value, dict):
        properties = schema.get("properties", {})
        if not set(schema.get("required", [])) <= value.keys():
            return False
        for key, item in value.items():
            rule = properties.get(key, schema.get("additionalProperties", True))
            if rule is False or (isinstance(rule, dict) and not schema_matches(item, rule)):
                return False
    return True


def validate_report(report: dict) -> dict:
    if not schema_matches(report, REPORT_SCHEMA):
        raise ConversionError("INVALID_REPORT_SCHEMA")
    if report["rom_id"] != report["sha256"][:12]:
        raise ConversionError("INVALID_REPORT_IDENTITY")
    if "output_directories" in report:
        names = ["WoWNES_Runtime", "WoWNES_Game_" + report["rom_id"]]
        if report["output_directories"] != names or ("checksums" in report and set(report["checksums"]) != set(names)):
            raise ConversionError("INVALID_REPORT_IDENTITY")
    return report


class ConversionError(ValueError):
    def __init__(self, code: str, message: str = ""):
        self.code = code
        super().__init__(message or code)


class Cancelled(ConversionError):
    def __init__(self):
        super().__init__("CANCELLED")


@dataclass(frozen=True)
class Rom:
    sha256: str
    format: str
    mapper: int
    submapper: int
    mirroring: str
    region: str
    prg: bytes
    chr: bytes
    trainer: bytes
    prg_ram: int

    def physical(self, address: int, state=None) -> int:
        if not 0x8000 <= address <= 0xffff:
            raise ConversionError("ADDRESS_OUTSIDE_PRG")
        if self.mapper == 0:
            return (address - 0x8000) % len(self.prg)
        # Mapper 23 VRC4 power-on layout: 8000/ A000 switchable, C000 second-last, E000 last.
        banks = [0, 1, len(self.prg) // 8192 - 2, len(self.prg) // 8192 - 1]
        if state:
            banks[0], banks[1] = state.get("prg0", 0), state.get("prg1", 1)
        slot = (address - 0x8000) // 0x2000
        return (banks[slot] % (len(self.prg) // 8192)) * 8192 + (address & 0x1fff)

    def read(self, address: int, state=None) -> int:
        return self.prg[self.physical(address, state)]

    def chr_physical(self, address: int, state=None) -> int:
        if not 0 <= address < 0x2000:
            raise ConversionError("ADDRESS_OUTSIDE_CHR")
        if self.mapper == 0:
            return address % len(self.chr)
        regs = (state or {}).get("chr", [i for i in range(8)])
        return (regs[address // 0x400] % (len(self.chr) // 0x400)) * 0x400 + (address & 0x3ff)

    def chr_tile(self, tile: int, table: int, state=None) -> int:
        return self.chr_physical(table * 0x1000 + (tile & 0xff) * 16, state) // 16

    @property
    def vectors(self) -> dict:
        return {name: self.read(addr) | self.read(addr + 1) << 8
                for name, addr in (("nmi", 0xfffa), ("reset", 0xfffc), ("irq", 0xfffe))}

    def report(self) -> dict:
        return dict(schema_version=1, converter_version=VERSION, compatible=True,
                    reason_codes=[], sha256=self.sha256, rom_id=self.sha256[:12],
                    format=self.format, mapper=self.mapper, submapper=self.submapper,
                    mirroring=self.mirroring, region=self.region,
                    prg_bytes=len(self.prg), chr_bytes=len(self.chr),
                    trainer_bytes=len(self.trainer), prg_ram_bytes=self.prg_ram,
                    vectors=self.vectors, audio_output="none")


def parse(data: bytes) -> Rom:
    if len(data) > MAX_ROM:
        raise ConversionError("ROM_TOO_LARGE")
    if len(data) < 16 or data[:4] != b"NES\x1a":
        raise ConversionError("INVALID_HEADER")
    h = data[:16]
    marker = h[7] & 0x0c
    if marker not in (0, 8):
        raise ConversionError("INVALID_HEADER")
    nes2 = marker == 8
    mapper = (h[6] >> 4) | (h[7] & 0xf0) | ((h[8] & 15) << 8 if nes2 else 0)
    submapper = h[8] >> 4 if nes2 else 0
    if h[6] & 2:
        raise ConversionError("BATTERY_UNSUPPORTED")
    if nes2 and h[10] >> 4:
        raise ConversionError("PRG_RAM_PERSISTENCE_UNSUPPORTED")
    if mapper not in (0, 23):
        raise ConversionError("UNSUPPORTED_MAPPER")
    if submapper:
        raise ConversionError("UNSUPPORTED_SUBMAPPER")
    if h[7] & 3:
        raise ConversionError("UNSUPPORTED_CONSOLE")
    if nes2:
        if h[12] & 0xfc or h[14] or h[15] or h[13]:
            raise ConversionError("UNSUPPORTED_HEADER_FEATURE")
        if h[12] & 3:
            raise ConversionError("UNSUPPORTED_REGION")
        if (h[9] & 15) == 15 or h[9] >> 4 == 15:
            raise ConversionError("UNSUPPORTED_ROM_SIZE")
        prg_size = (h[4] | (h[9] & 15) << 8) * 16384
        chr_size = (h[5] | (h[9] >> 4) << 8) * 8192
        if h[11]:
            raise ConversionError("CHR_RAM_UNSUPPORTED")
        prg_ram = 64 << (h[10] & 15) if h[10] & 15 else 0
    else:
        if any(h[12:16]) or h[9] & 0xfe or h[10] & 0xcc or h[11]:
            raise ConversionError("INVALID_HEADER")
        if h[9] & 1 or h[10] & 3:
            raise ConversionError("UNSUPPORTED_REGION")
        prg_size, chr_size = h[4] * 16384, h[5] * 8192
        prg_ram = (h[8] or 1) * 8192
    if chr_size == 0:
        raise ConversionError("CHR_RAM_UNSUPPORTED")
    if mapper == 0 and (prg_size not in (16384, 32768) or chr_size != 8192):
        raise ConversionError("UNSUPPORTED_ROM_SIZE")
    if mapper == 23 and (prg_size % 8192 or chr_size % 1024 or prg_size < 32768 or chr_size < 8192):
        raise ConversionError("UNSUPPORTED_ROM_SIZE")
    if prg_ram > 8192:
        raise ConversionError("UNSUPPORTED_PRG_RAM_SIZE")
    if h[6] & 8:
        raise ConversionError("UNSUPPORTED_MIRRORING")
    start = 16 + (512 if h[6] & 4 else 0)
    expected = start + prg_size + chr_size
    if len(data) < expected:
        raise ConversionError("TRUNCATED_ROM")
    if len(data) != expected:
        raise ConversionError("TRAILING_DATA_UNSUPPORTED")
    return Rom(hashlib.sha256(data).hexdigest(), "NES2" if nes2 else "iNES", mapper,
               submapper, "vertical" if h[6] & 1 else "horizontal", "NTSC",
               data[start:start + prg_size], data[start + prg_size:],
               data[16:start], prg_ram)


def inspect_bytes(data: bytes) -> dict:
    try:
        return validate_report(parse(data).report())
    except ConversionError as exc:
        h = data[:16]
        digest = hashlib.sha256(data).hexdigest()
        valid_header = len(h) == 16 and h[:4] == b"NES\x1a"
        nes2 = valid_header and h[7] & 12 == 8
        return validate_report(dict(schema_version=1, converter_version=VERSION,
                    compatible=False, reason_codes=[exc.code], audio_output="none",
                    sha256=digest, rom_id=digest[:12],
                    mapper=((h[6] >> 4) | (h[7] & 0xf0) |
                            ((h[8] & 15) << 8 if nes2 else 0)) if valid_header else None,
                    diagnostic=dict(
                        format="NES2" if nes2 else "iNES",
                        submapper=h[8] >> 4 if nes2 else 0,
                        prg_bytes=h[4] * 16384,
                        chr_bytes=h[5] * 8192,
                        mirroring="vertical" if h[6] & 1 else "horizontal")
                    if valid_header else None))


def read_rom(path: Path) -> bytes:
    with path.open("rb") as stream:
        data = stream.read(MAX_ROM + 1)
    if len(data) > MAX_ROM:
        raise ConversionError("ROM_TOO_LARGE")
    return data


def inspect_zip(path: Path) -> dict:
    results = []
    with zipfile.ZipFile(path, "r") as archive:
        for member in archive.infolist():
            if member.is_dir() or not member.filename.lower().endswith(".nes"):
                continue
            if member.file_size > MAX_ROM or member.flag_bits & 1:
                results.append(dict(member=member.filename, compatible=False,
                                    reason_codes=["UNSAFE_ZIP_MEMBER"]))
                continue
            with archive.open(member, "r") as stream:
                data = stream.read(MAX_ROM + 1)
            results.append(dict(member=member.filename, **inspect_bytes(data)))
    return dict(archive_sha256=hashlib.sha256(path.read_bytes()).hexdigest(), members=results)


# All 151 official NMOS 6502 opcodes; 2A03 ignores decimal arithmetic.
# opcode mnemonic addressing base-cycle optional-read-page-penalty
OPCODE_TEXT = """
00 BRK imp 7;01 ORA izx 6;05 ORA zp 3;06 ASL zp 5;08 PHP imp 3;09 ORA imm 2;0A ASL acc 2;0D ORA abs 4;0E ASL abs 6
10 BPL rel 2;11 ORA izy 5 p;15 ORA zpx 4;16 ASL zpx 6;18 CLC imp 2;19 ORA aby 4 p;1D ORA abx 4 p;1E ASL abx 7
20 JSR abs 6;21 AND izx 6;24 BIT zp 3;25 AND zp 3;26 ROL zp 5;28 PLP imp 4;29 AND imm 2;2A ROL acc 2;2C BIT abs 4;2D AND abs 4;2E ROL abs 6
30 BMI rel 2;31 AND izy 5 p;35 AND zpx 4;36 ROL zpx 6;38 SEC imp 2;39 AND aby 4 p;3D AND abx 4 p;3E ROL abx 7
40 RTI imp 6;41 EOR izx 6;45 EOR zp 3;46 LSR zp 5;48 PHA imp 3;49 EOR imm 2;4A LSR acc 2;4C JMP abs 3;4D EOR abs 4;4E LSR abs 6
50 BVC rel 2;51 EOR izy 5 p;55 EOR zpx 4;56 LSR zpx 6;58 CLI imp 2;59 EOR aby 4 p;5D EOR abx 4 p;5E LSR abx 7
60 RTS imp 6;61 ADC izx 6;65 ADC zp 3;66 ROR zp 5;68 PLA imp 4;69 ADC imm 2;6A ROR acc 2;6C JMP ind 5;6D ADC abs 4;6E ROR abs 6
70 BVS rel 2;71 ADC izy 5 p;75 ADC zpx 4;76 ROR zpx 6;78 SEI imp 2;79 ADC aby 4 p;7D ADC abx 4 p;7E ROR abx 7
81 STA izx 6;84 STY zp 3;85 STA zp 3;86 STX zp 3;88 DEY imp 2;8A TXA imp 2;8C STY abs 4;8D STA abs 4;8E STX abs 4
90 BCC rel 2;91 STA izy 6;94 STY zpx 4;95 STA zpx 4;96 STX zpy 4;98 TYA imp 2;99 STA aby 5;9A TXS imp 2;9D STA abx 5
A0 LDY imm 2;A1 LDA izx 6;A2 LDX imm 2;A4 LDY zp 3;A5 LDA zp 3;A6 LDX zp 3;A8 TAY imp 2;A9 LDA imm 2;AA TAX imp 2;AC LDY abs 4;AD LDA abs 4;AE LDX abs 4
B0 BCS rel 2;B1 LDA izy 5 p;B4 LDY zpx 4;B5 LDA zpx 4;B6 LDX zpy 4;B8 CLV imp 2;B9 LDA aby 4 p;BA TSX imp 2;BC LDY abx 4 p;BD LDA abx 4 p;BE LDX aby 4 p
C0 CPY imm 2;C1 CMP izx 6;C4 CPY zp 3;C5 CMP zp 3;C6 DEC zp 5;C8 INY imp 2;C9 CMP imm 2;CA DEX imp 2;CC CPY abs 4;CD CMP abs 4;CE DEC abs 6
D0 BNE rel 2;D1 CMP izy 5 p;D5 CMP zpx 4;D6 DEC zpx 6;D8 CLD imp 2;D9 CMP aby 4 p;DD CMP abx 4 p;DE DEC abx 7
E0 CPX imm 2;E1 SBC izx 6;E4 CPX zp 3;E5 SBC zp 3;E6 INC zp 5;E8 INX imp 2;E9 SBC imm 2;EA NOP imp 2;EC CPX abs 4;ED SBC abs 4;EE INC abs 6
F0 BEQ rel 2;F1 SBC izy 5 p;F5 SBC zpx 4;F6 INC zpx 6;F8 SED imp 2;F9 SBC aby 4 p;FD SBC abx 4 p;FE INC abx 7
"""
# Stable unofficial opcodes (semantics per Mesen/FCEUX): NOP read family, LAX,
# SAX, and the combined RMW families DCP/ISB/SLO/RLA/SRE/RRA. RMW (zp),Y /
# abs,X / abs,Y variants are fixed-cycle (no page penalty) but always dummy-read.
OPCODE_TEXT_UNOFFICIAL = """
04 NOP zp 3;44 NOP zp 3;64 NOP zp 3;0C NOP abs 4
14 NOP abx 4 p;34 NOP abx 4 p;54 NOP abx 4 p;74 NOP abx 4 p;D4 NOP abx 4 p;F4 NOP abx 4 p
80 NOP imm 2;82 NOP imm 2;89 NOP imm 2;C2 NOP imm 2
1A NOP imp 2;3A NOP imp 2;5A NOP imp 2;7A NOP imp 2;DA NOP imp 2;FA NOP imp 2
A3 LAX izx 6;A7 LAX zp 3;AF LAX abs 4;B3 LAX izy 5 p;B7 LAX zpy 4;BF LAX aby 4 p
83 SAX izx 6;87 SAX zp 3;8F SAX abs 4;97 SAX zpy 4
C7 DCP zp 5;CF DCP abs 6;D3 DCP izy 8;D7 DCP zpx 6;DB DCP aby 7;DF DCP abx 7
E7 ISB zp 5;EF ISB abs 6;F3 ISB izy 8;F7 ISB zpx 6;FB ISB aby 7;FF ISB abx 7
07 SLO zp 5;0F SLO abs 6;13 SLO izy 8;17 SLO zpx 6;1B SLO aby 7;1F SLO abx 7
27 RLA zp 5;2F RLA abs 6;33 RLA izy 8;37 RLA zpx 6;3B RLA aby 7;3F RLA abx 7
47 SRE zp 5;4F SRE abs 6;53 SRE izy 8;57 SRE zpx 6;5B SRE aby 7;5F SRE abx 7
67 RRA zp 5;6F RRA abs 6;73 RRA izy 8;77 RRA zpx 6;7B RRA aby 7;7F RRA abx 7
"""
LENGTHS = dict(imp=1, acc=1, imm=2, zp=2, zpx=2, zpy=2, rel=2, izx=2, izy=2,
               abs=3, abx=3, aby=3, ind=3)
OPS = {}
for entry in (OPCODE_TEXT + OPCODE_TEXT_UNOFFICIAL).replace("\n", ";").split(";"):
    parts = entry.split()
    if parts:
        op, name, mode, cycles, *penalty = parts
        OPS[int(op, 16)] = (name, mode, LENGTHS[mode], int(cycles), bool(penalty))


@dataclass(frozen=True)
class Instruction:
    pc: int
    opcode: int
    operand: int

    @property
    def meta(self):
        return OPS[self.opcode]


def analyze(rom: Rom, cancel: Callable[[], bool] = lambda: False, state=None) -> dict:
    instructions: dict[int, Instruction] = {}
    owner: dict[int, int] = {}
    entries: set[int] = set()
    conflicts: set[int] = set()
    pending = list(rom.vectors.values())
    stops = []
    while pending:
        if cancel():
            raise Cancelled()
        pc = pending.pop()
        entries.add(pc)
        if pc < 0x8000 or pc > 0xffff:
            stops.append(dict(pc=pc, reason="OUTSIDE_ROM"))
            continue
        if pc in instructions:
            continue
        opcode = rom.read(pc, state)
        meta = OPS.get(opcode)
        if not meta:
            stops.append(dict(pc=pc, reason="UNOFFICIAL_OPCODE"))
            continue
        name, mode, length, _, _ = meta
        if pc + length > 0x10000:
            stops.append(dict(pc=pc, reason="WRAPPED_INSTRUCTION"))
            continue
        offsets = [rom.physical(pc + n, state) for n in range(length)]
        # A mirrored instruction is a distinct CPU address but shares boundaries.
        collision = [owner[o] for o in offsets if o in owner and
                     rom.physical(owner[o], state) != rom.physical(pc, state)]
        if collision:
            conflicts.add(pc)
            conflicts.update(collision)
            stops.append(dict(pc=pc, reason="OVERLAPPING_CODE"))
            continue
        operand = sum(rom.read(pc + n, state) << (8 * (n - 1)) for n in range(1, length))
        instructions[pc] = Instruction(pc, opcode, operand)
        for offset in offsets:
            owner[offset] = pc
        nxt = (pc + length) & 0xffff
        if mode == "rel":
            pending.extend([nxt, (nxt + (operand if operand < 128 else operand - 256)) & 0xffff])
        elif name == "JSR":
            pending.extend([nxt, operand])
        elif name == "JMP":
            if mode == "abs":
                pending.append(operand)
            else:
                stops.append(dict(pc=pc, reason="INDIRECT_JUMP"))
        elif name not in ("BRK", "RTS", "RTI"):
            pending.append(nxt)
    # Ambiguity invalidates optimization globally, retaining original PRG fallback.
    if conflicts:
        instructions.clear()
    return dict(instructions=instructions, stops=stops, conflicts=sorted(conflicts),
                entries=sorted(entries))


def atlas(chr_data: bytes, cancel: Callable[[], bool] = lambda: False) -> tuple[list[bytes], list[dict], dict]:
    unique = {}
    ids = []
    for start in range(0, len(chr_data), 16):
        tile = chr_data[start:start + 16]
        ids.append(unique.setdefault(tile, len(unique)))
    side = 1
    while side < math.ceil(math.sqrt(len(unique))) * 10:
        side *= 2
    masks = [bytearray(side * side * 4) for _ in range(3)]
    positions = []
    cols = side // 10
    for tile, index in unique.items():
        if cancel():
            raise Cancelled()
        x, y = (index % cols) * 10 + 1, (index // cols) * 10 + 1
        empty = 7
        for row in range(8):
            for col in range(8):
                pixel = ((tile[row] >> (7 - col)) & 1) | (((tile[row + 8] >> (7 - col)) & 1) << 1)
                if pixel:
                    empty &= ~(1 << (pixel - 1))
                    pos = ((y + row) * side + x + col) * 4
                    masks[pixel - 1][pos:pos + 4] = b"\xff\xff\xff\xff"
        positions.append(dict(uv=[x / side, (x + 8) / side, y / side, (y + 8) / side], empty=empty))
    header = struct.pack("<BBBHHBHHHHBB", 0, 0, 2, 0, 0, 0, 0, 0, side, side, 32, 0x28)
    return [header + bytes(mask) for mask in masks], [positions[i] for i in ids], dict(
        tiles=len(ids), unique_tiles=len(unique), width=side, height=side, layers=3, gutter=1)


def lua_value(value) -> str:
    if isinstance(value, dict):
        return "{" + ",".join("[" + lua_value(k) + "]=" + lua_value(v) for k, v in value.items()) + "}"
    if isinstance(value, (list, tuple)):
        return "{" + ",".join(map(lua_value, value)) + "}"
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=True)
    if isinstance(value, bool):
        return "true" if value else "false"
    if value is None:
        return "nil"
    return str(value)


def lua_bytes(data: bytes) -> str:
    return '"' + ''.join('\\%03d' % b for b in data) + '"'


CHR_SHARD = 4096


def chr_shard_files(chr_data: bytes) -> dict[str, str]:
    """Split CHR ROM like PRG: one 4 KiB string per file, concatenated on load.

    Each shard writes an explicit index so a batch of hot-loaded files lands
    correctly whatever order the workshop executes them in.
    """
    return {f"chr-data-{index}.lua":
            "local _,G=...; G.chr[%d]=" % (index + 1)
            + lua_bytes(chr_data[start:start + CHR_SHARD]) + "\n"
            for index, start in enumerate(range(0, len(chr_data), CHR_SHARD))}


def chr_map_file(trainer: bytes) -> str:
    return "local _,G=...;G.trainer=" + lua_bytes(trainer) + "\n"


TILE_SHARD = 512


def tile_shard_files(mapping) -> dict[str, str]:
    """Split the tile→atlas UV map: 512 entries per file, explicit indices."""
    return {f"tiles-data-{index}.lua":
            "local _,G=...\n" + "".join("G.tiles[%d]=" % (start + offset + 1)
                                        + lua_value(entry) + "\n"
                                        for offset, entry in enumerate(mapping[start:start + TILE_SHARD]))
            for index, start in enumerate(range(0, len(mapping), TILE_SHARD))}


def manifest_file(manifest: dict) -> str:
    return ("local _,G=...;G.manifest=" + lua_value(manifest)
            + ";G.prg={};G.blocks={};G.chr={};G.tiles={}\n")


def executable_data(rom: Rom, cfg: dict) -> tuple[dict[str, str], dict]:
    files = {}
    for index, start in enumerate(range(0, len(rom.prg), 4096)):
        files[f"prg-data-{index}.lua"] = (
            "local _,G=...; G.prg[%d]=" % (index + 1)
            + lua_bytes(rom.prg[start:start + 4096]) + "\n")
    files.update(chr_shard_files(rom.chr))
    files["fallback-ir-0.lua"] = "local _,G=...;G.ir=G.ir or {}\n"
    from wow_nes_runtime import collect_blocks, block_lua_files
    blocks = collect_blocks(rom)
    files.update(block_lua_files(rom, blocks, OPS))
    return files, dict(static_blocks=len(blocks), ir_instructions=0,
                       analyzed_bytes=len(cfg["instructions"]),
                       fallback_prg_bytes=len(rom.prg), stops=cfg["stops"],
                       ambiguous_addresses=cfg["conflicts"],
                       block_key="mapper23_physical_prg_offset" if rom.mapper == 23 else "bank0_physical_prg_offset",
                       physical_bank_key_pending=False)


def contained(child: Path, parent: Path) -> bool:
    try:
        return os.path.normcase(os.path.commonpath([str(child.resolve()), str(parent.resolve())])) == os.path.normcase(str(parent.resolve()))
    except ValueError:
        return False


def no_links(path: Path):
    for item in (path, *path.parents):
        reparse = os.name == "nt" and item.exists() and bool(os.lstat(item).st_file_attributes & 0x400)
        if item.is_symlink() or reparse:
            raise ConversionError("UNSAFE_PATH")


def validate(package: Path) -> dict:
    try:
        return validate_package(package)
    except (json.JSONDecodeError, UnicodeError, TypeError, KeyError) as exc:
        raise ConversionError("INVALID_PACKAGE_DATA", str(exc)) from exc


def validate_package(package: Path) -> dict:
    no_links(package)
    checksum_file = package / "checksums.json"
    no_links(checksum_file)
    expected = json.loads(checksum_file.read_text("utf-8"))
    if not schema_matches(expected, dict(type="object", additionalProperties=SHA)):
        raise ConversionError("INVALID_FILE_MANIFEST")
    actual_names = {p.relative_to(package).as_posix() for p in package.rglob("*") if p.is_file()} - {"checksums.json"}
    if actual_names != set(expected):
        raise ConversionError("INVALID_FILE_MANIFEST")
    for name, digest in expected.items():
        path = package / name
        if ".." in Path(name).parts or not contained(path, package):
            raise ConversionError("UNSAFE_PATH")
        no_links(path)
        if hashlib.sha256(path.read_bytes()).hexdigest() != digest:
            raise ConversionError("CHECKSUM_MISMATCH", name)
    tocs = list(package.glob("*.toc"))
    if len(tocs) != 1:
        raise ConversionError("INVALID_TOC")
    toc = tocs[0]
    lines = toc.read_text("utf-8").splitlines()
    if "## Interface: 50504" not in lines:
        raise ConversionError("INVALID_TOC")
    for name in lines:
        if name and not name.startswith("#") and (name not in expected or not (package / name).is_file()):
            raise ConversionError("INVALID_TOC_REFERENCE")
    if toc.stem.startswith("WoWNES_Game_") or "conversion-report.json" in expected or "manifest.lua" in expected:
        def text(name):
            if name not in expected:
                raise ConversionError("INVALID_FILE_MANIFEST", name)
            return (package / name).read_text("utf-8")

        metadata = validate_report(json.loads(text("conversion-report.json")))
        if "translation" not in metadata or "checksums" in metadata:
            raise ConversionError("INVALID_REPORT_SCHEMA")
        if toc.stem != metadata["output_directories"][1]:
            raise ConversionError("INVALID_REPORT_IDENTITY")

        def shards(prefix):
            names = [name for name in expected if name.startswith(prefix)]
            if not names or any(not re.fullmatch(re.escape(prefix) + r"[0-9]+\.lua", name) for name in names):
                raise ConversionError("INVALID_SHARDS")
            names.sort(key=lambda name: int(name[len(prefix):-4]))
            if names != [f"{prefix}{i}.lua" for i in range(len(names))]:
                raise ConversionError("INVALID_SHARDS")
            return names

        prg_names, ir_names, block_names, chr_names, tile_names = [shards(prefix) for prefix in
                                                                  ("prg-data-", "fallback-ir-", "translated-blocks-",
                                                                   "chr-data-", "tiles-data-")]
        order = (["manifest.lua"] + prg_names + ir_names + block_names + chr_names
                 + tile_names + ["chr-map.lua", "register.lua"])
        if ([line for line in lines if line and not line.startswith("#")] != order or
                {name for name in expected if name.endswith(".lua")} != set(order) or
                "## Dependencies: WoWNES_Runtime" not in lines):
            raise ConversionError("INVALID_TOC_ORDER")

        def decode_bytes(encoded):
            if not re.fullmatch(r"(?:\\[0-9]{3})*", encoded):
                raise ConversionError("INVALID_LUA_DATA")
            values = [int(encoded[i + 1:i + 4]) for i in range(0, len(encoded), 4)]
            if any(value > 255 for value in values):
                raise ConversionError("INVALID_LUA_DATA")
            return bytes(values)

        prg = b""
        for index, name in enumerate(prg_names):
            match = re.fullmatch(r'local _,G=\.\.\.; G\.prg\[(\d+)\]="(.*?)"\n', text(name))
            if not match or int(match[1]) != index + 1:
                raise ConversionError("INVALID_LUA_DATA", name)
            prg += decode_bytes(match[2])
        if len(prg) != metadata["prg_bytes"]:
            raise ConversionError("INVALID_PRG_LENGTH")
        chr_data = b""
        for index, name in enumerate(chr_names):
            match = re.fullmatch(r'local _,G=\.\.\.; G\.chr\[(\d+)\]="(.*?)"\n', text(name))
            if not match or int(match[1]) != index + 1:
                raise ConversionError("INVALID_LUA_DATA", name)
            chr_data += decode_bytes(match[2])
        chr_text = text("chr-map.lua")
        match = re.fullmatch(r'local _,G=\.\.\.;G\.trainer="(.*?)"\n', chr_text)
        if not match:
            raise ConversionError("INVALID_LUA_DATA", "chr-map.lua")
        trainer = decode_bytes(match[1])
        if len(chr_data) != metadata["chr_bytes"] or len(trainer) != metadata["trainer_bytes"]:
            raise ConversionError("INVALID_CHR_DATA")
        rom = Rom(metadata["sha256"], metadata["format"], metadata["mapper"], metadata["submapper"],
                  metadata["mirroring"], metadata["region"], prg, chr_data, trainer, metadata["prg_ram_bytes"])
        if rom.vectors != metadata["vectors"]:
            raise ConversionError("INVALID_VECTOR")
        manifest = dict(metadata, runtime_version=VERSION)
        if text("manifest.lua") != manifest_file(manifest):
            raise ConversionError("INVALID_MANIFEST")
        if text("register.lua") != "local name,G=...;G.name=name;WoWNES_Runtime:Register(G)\n":
            raise ConversionError("INVALID_REGISTRATION")
        generated, stats = executable_data(rom, analyze(rom))
        if stats != metadata["translation"]:
            raise ConversionError("INVALID_TRANSLATION_STATS")
        if set(generated) != set(prg_names + ir_names + block_names + chr_names):
            raise ConversionError("INVALID_SHARDS")
        for name, content in generated.items():
            if text(name) != content:
                raise ConversionError("INVALID_EXECUTABLE_DATA", name)
        masks, mapping, atlas_stats = atlas(chr_data)
        if json.loads(text("chr-map.json")) != mapping:
            raise ConversionError("INVALID_UV")
        expected_tiles = tile_shard_files(mapping)
        if list(expected_tiles) != tile_names or any(text(name) != content for name, content in expected_tiles.items()):
            raise ConversionError("INVALID_UV")
        if metadata["atlas"] != atlas_stats:
            raise ConversionError("INVALID_ATLAS")
        for index, mask in enumerate(masks, 1):
            name = f"textures/chr-mask-{index}.tga"
            if name not in expected or (package / name).read_bytes() != mask:
                raise ConversionError("INVALID_ATLAS", name)
    return expected


def export(data: bytes, dest: Path, repository: Path, overwrite: bool = False,
           cancel: Callable[[], bool] = lambda: False,
           progress: Callable[[dict], None] = lambda p: None) -> dict:
    rom = parse(data)
    if not dest.is_absolute() or ".." in dest.parts:
        raise ConversionError("UNSAFE_PATH")
    no_links(dest)
    root = dest.resolve(strict=True)
    if not root.is_dir() or contained(root, repository):
        raise ConversionError("TARGET_INSIDE_REPOSITORY")
    # Offline generation must never bypass the game-source workshop development loop.
    if any(part.lower() == "addons" for part in root.parts):
        raise ConversionError("GAME_INSTALL_REQUIRES_WORKSHOP")
    job = uuid.uuid4().hex
    names = ["WoWNES_Runtime", f"WoWNES_Game_{rom.sha256[:12]}"]
    for name in names:
        final = root / name
        no_links(final)
        if final.exists() and not overwrite:
            raise ConversionError("OUTPUT_EXISTS")
        if final.exists() and not final.is_dir():
            raise ConversionError("INVALID_OUTPUT_TARGET")
    temp = Path(tempfile.mkdtemp(prefix=f".wow-nes-{job}-", suffix=".tmp", dir=root))
    backups = {}
    published = []
    def checkpoint(done):
        if cancel():
            raise Cancelled()
        progress(dict(done=done, total=5))
    try:
        checkpoint(0)
        cfg = analyze(rom, cancel)
        files, stats = executable_data(rom, cfg)
        checkpoint(1)
        masks, mapping, atlas_stats = atlas(rom.chr, cancel)
        report = rom.report()
        report.update(translation=stats, atlas=atlas_stats,
                      output_directories=names, warnings=[
                          "Prototype: not a general ROM compatibility claim; WoW performance gates unverified.",
                          "Audio output disabled; PPU/APU timing is approximate; 8x16 sprites unsupported.",
                          "Generated content may remain subject to original ROM copyright."])
        validate_report(report)
        manifest = dict(report, runtime_version=VERSION)
        files["manifest.lua"] = manifest_file(manifest)
        files["chr-map.lua"] = chr_map_file(rom.trainer)
        files.update(tile_shard_files(mapping))
        files["chr-map.json"] = json.dumps(mapping, indent=2)
        files["register.lua"] = "local name,G=...;G.name=name;WoWNES_Runtime:Register(G)\n"
        shard_order = lambda prefix: sorted((k for k in files if k.startswith(prefix)), key=lambda k: int(k.rsplit("-", 1)[1].split(".")[0]))
        order = (["manifest.lua"] + shard_order("prg-data-") + shard_order("fallback-ir-")
                 + shard_order("translated-blocks-") + shard_order("chr-data-")
                 + shard_order("tiles-data-") + ["chr-map.lua", "register.lua"])
        files[names[1] + ".toc"] = "## Interface: 50504\n## Title: WOW_NES Game\n## Dependencies: WoWNES_Runtime\n## Version: " + VERSION + "\n" + "\n".join(order) + "\n"
        files["conversion-report.json"] = json.dumps(report, indent=2)
        from wow_nes_runtime import runtime_files
        packages = {names[0]: runtime_files(OPS, VERSION), names[1]: files}
        checkpoint(2)
        checksum_result = {}
        for name, content in packages.items():
            package = temp / name
            package.mkdir()
            for relative, value in content.items():
                checkpoint(2)
                target = package / relative
                if not contained(target, temp):
                    raise ConversionError("UNSAFE_PATH")
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(value.encode("utf-8") if isinstance(value, str) else value)
            if name == names[1]:
                (package / "textures").mkdir()
                for index, mask in enumerate(masks, 1):
                    (package / f"textures/chr-mask-{index}.tga").write_bytes(mask)
            checksums = {p.relative_to(package).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
                         for p in sorted(package.rglob("*")) if p.is_file()}
            (package / "checksums.json").write_text(json.dumps(checksums, indent=2), "utf-8")
            checksum_result[name] = validate(package)
        report["checksums"] = checksum_result
        validate_report(report)
        checkpoint(3)
        # Cross-directory commit has rollback, not a filesystem-wide atomic transaction.
        for name in names:
            final = root / name
            no_links(final)
            if not contained(final, root):
                raise ConversionError("UNSAFE_PATH")
            if final.exists():
                if not overwrite:
                    raise ConversionError("OUTPUT_EXISTS")
                backup = root / f".wow-nes-{job}-{name}.backup"
                final.rename(backup)
                backups[name] = backup
        checkpoint(4)
        for name in names:
            (temp / name).rename(root / name)
            published.append(name)
        for backup in backups.values():
            shutil.rmtree(backup)
        report["checksums"] = checksum_result
        progress(dict(done=5, total=5))
        return report
    except BaseException:
        for name in published:
            shutil.rmtree(root / name)
        for name, backup in backups.items():
            if backup.exists():
                backup.rename(root / name)
        raise
    finally:
        shutil.rmtree(temp, ignore_errors=True)


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(prog="WOW_NES")
    sub = parser.add_subparsers(dest="command", required=True)
    for command in ("inspect", "inspect-zip", "validate", "export"):
        cmd = sub.add_parser(command)
        cmd.add_argument("input", type=Path)
        if command == "export":
            cmd.add_argument("--dest", required=True, type=Path)
            cmd.add_argument("--repository", required=True, type=Path)
            cmd.add_argument("--overwrite", action="store_true")
    args = parser.parse_args(argv)
    cancelled = False
    def stop(signum, frame):
        nonlocal cancelled
        cancelled = True
    signal.signal(signal.SIGINT, stop)
    try:
        if args.command == "inspect-zip":
            result = inspect_zip(args.input)
        elif args.command == "inspect":
            result = inspect_bytes(read_rom(args.input))
        elif args.command == "validate":
            result = dict(checksums=validate(args.input))
        else:
            source = args.input.resolve(strict=True)
            repo = args.repository.resolve(strict=True)
            if source.suffix.lower() != ".nes" or not contained(source, repo):
                raise ConversionError("INPUT_OUTSIDE_REPOSITORY")
            no_links(args.input)
            result = export(read_rom(source), args.dest, repo, args.overwrite, lambda: cancelled,
                            lambda p: print(json.dumps(p), file=__import__("sys").stderr))
        print(json.dumps(result, indent=2, ensure_ascii=False))
        return 0
    except (ConversionError, OSError, zipfile.BadZipFile) as exc:
        print(json.dumps(dict(error=getattr(exc, "code", "IO_ERROR"), detail=str(exc)), ensure_ascii=False))
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
