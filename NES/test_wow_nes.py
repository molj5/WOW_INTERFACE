"""Self-authored fixtures: CC0-1.0; no commercial ROM contents."""
import hashlib
import json
from pathlib import Path
import struct
import tempfile
import unittest
import zipfile
from unittest.mock import patch

import wow_nes as n
import wow_nes_runtime as runtime


def fixture(prg_size=16384, trainer=False, nes2=False, program=b"\xa9\x01\xaa\xe8\x85\x10\x4c\x06\x80"):
    h = bytearray(b"NES\x1a" + bytes(12))
    h[4] = prg_size // 16384
    h[5] = 1
    h[6] = 4 if trainer else 0
    h[7] = 8 if nes2 else 0
    prg = bytearray([0xea] * prg_size)
    prg[:len(program)] = program
    prg[-6:] = struct.pack("<HHH", 0x8000, 0x8000, 0x8000)
    return bytes(h) + (bytes([0x55]) * 512 if trainer else b"") + bytes(prg) + bytes(8192)


class ConverterTests(unittest.TestCase):
    def test_opcode_metadata(self):
        self.assertEqual(len(n.OPS), 217)
        self.assertEqual(n.OPS[0xbd], ("LDA", "abx", 3, 4, True))
        self.assertEqual(n.OPS[0x9d][3:], (5, False))
        self.assertEqual(n.OPS[0x04], ("NOP", "zp", 2, 3, False))
        self.assertEqual(n.OPS[0xb3], ("LAX", "izy", 2, 5, True))
        self.assertEqual(n.OPS[0x87][0], "SAX")
        self.assertEqual(n.OPS[0xd3], ("DCP", "izy", 2, 8, False))

    def test_mapping_vectors_trainer_sha(self):
        for size in (16384, 32768):
            data = fixture(size, trainer=True)
            rom = n.parse(data)
            self.assertEqual(rom.sha256, hashlib.sha256(data).hexdigest())
            self.assertEqual(rom.vectors, dict(nmi=32768, reset=32768, irq=32768))
            self.assertEqual(len(rom.trainer), 512)
            self.assertEqual(rom.read(0x8000), 0xa9)
            self.assertEqual(rom.physical(0xc000), 0 if size == 16384 else 16384)

    def test_rejections(self):
        cases = [(6, 2, "BATTERY_UNSUPPORTED"), (6, 16, "UNSUPPORTED_MAPPER"),
                 (9, 1, "UNSUPPORTED_REGION"), (5, 0, "CHR_RAM_UNSUPPORTED"),
                 (4, 3, "UNSUPPORTED_ROM_SIZE"), (6, 8, "UNSUPPORTED_MIRRORING"),
                 (7, 4, "INVALID_HEADER"), (7, 1, "UNSUPPORTED_CONSOLE")]
        for index, value, code in cases:
            data = bytearray(fixture());data[index] = value
            self.assertEqual(n.inspect_bytes(data)["reason_codes"], [code])
        invalid = n.inspect_bytes(b"bad")
        self.assertEqual(invalid["reason_codes"], ["INVALID_HEADER"])
        self.assertIsNone(invalid["diagnostic"])
        mapper23 = bytearray(fixture(prg_size=131072))
        mapper23[5:9] = bytes((16, 0x70, 0x10, 0))
        mapper23.extend(bytes(15 * 8192))
        report = n.inspect_bytes(mapper23)
        self.assertTrue(report["compatible"])
        self.assertEqual(report["reason_codes"], [])
        self.assertEqual(report["mapper"], 23)
        rom = n.parse(mapper23)
        state = {"prg0": 3, "prg1": 4, "chr": list(range(8, 16))}
        self.assertEqual(rom.physical(0x8000, state), 3 * 8192)
        self.assertEqual(rom.physical(0xa000, state), 4 * 8192)
        self.assertEqual(rom.physical(0xc000, state), 14 * 8192)
        self.assertEqual(rom.physical(0xe000, state), 15 * 8192)
        self.assertEqual(rom.chr_physical(0x0000, state), 8 * 1024)
        self.assertEqual(rom.chr_tile(0x12, 0, state), (8 * 1024 // 16) + 0x12)
        self.assertEqual(report["mirroring"], "horizontal")
        mapper_program = bytes((
            0x8c, 0x00, 0x80, 0x8c, 0x00, 0xa0,
            0x8d, 0x00, 0xb0, 0x8d, 0x01, 0xb0,
            0x8d, 0x02, 0xb0, 0x8d, 0x03, 0xb0,
            0x60,
        ))
        mapper_rom = bytearray(fixture(prg_size=131072, program=mapper_program))
        mapper_rom[6:8] = bytes((0x70, 0x10))
        mapper_cfg = n.analyze(n.parse(mapper_rom))
        writes = {
            ins.operand for ins in mapper_cfg["instructions"].values()
            if ins.meta[0] in ("STA", "STX", "STY") and ins.meta[1] == "abs"
        }
        self.assertTrue({0x8000, 0xa000, 0xb000, 0xb001, 0xb002, 0xb003} <= writes)
        self.assertEqual(n.inspect_bytes(fixture()[:-1])["reason_codes"], ["TRUNCATED_ROM"])
        self.assertEqual(n.inspect_bytes(fixture()+b"x")["reason_codes"], ["TRAILING_DATA_UNSUPPORTED"])

    def test_nes2_persistence_region(self):
        data = bytearray(fixture(nes2=True));data[10] = 7
        self.assertEqual(n.parse(data).prg_ram, 8192)
        data[10] = 0x17
        self.assertEqual(n.inspect_bytes(data)["reason_codes"], ["PRG_RAM_PERSISTENCE_UNSUPPORTED"])
        data[10] = 0;data[6] |= 2
        self.assertEqual(n.inspect_bytes(data)["reason_codes"], ["BATTERY_UNSUPPORTED"])
        data[6] = 0
        for region in (1,2,3):
            data[12] = region
            self.assertEqual(n.inspect_bytes(data)["reason_codes"], ["UNSUPPORTED_REGION"])

    def test_cfg_branch_jsr_indirect(self):
        code = b"\xd0\x03\x20\x08\x80\x6c\x00\x02\x60"
        cfg = n.analyze(n.parse(fixture(program=code)))
        self.assertEqual(set(cfg["instructions"]), {0x8000,0x8002,0x8005,0x8008})
        self.assertIn(dict(pc=0x8005,reason="INDIRECT_JUMP"), cfg["stops"])
        conflict = n.analyze(n.parse(fixture(program=b"\xd0\x01\xa9\x00\x60")))
        self.assertTrue(conflict["conflicts"])
        self.assertFalse(conflict["instructions"])

    def test_atlas_golden(self):
        tile = bytearray(16);tile[0]=0x50;tile[8]=0x30
        masks,mapping,stats=n.atlas(bytes(tile)+bytes(8176))
        self.assertEqual(stats["unique_tiles"],2)
        self.assertEqual(mapping[0]["empty"],0)
        x=int(mapping[0]["uv"][0]*stats["width"])
        y=int(mapping[0]["uv"][2]*stats["height"])
        for col,pixel in enumerate((0,1,2,3,0,0,0,0)):
            for layer in range(3):
                alpha=masks[layer][18+((y*stats["width"]+x+col)*4)+3]
                self.assertEqual(alpha,255 if pixel==layer+1 else 0)
        self.assertEqual(mapping[1],mapping[511])
        self.assertEqual(mapping[1]["empty"],7)
        self.assertEqual(masks[0][18+((y*stats["width"]+x-1)*4)+3],0)

    def test_scheduler_renders_when_emulation_is_behind(self):
        files = runtime.runtime_files(n.OPS, n.VERSION)
        self.assertIn('local R=WoWNES_Runtime or ', files["bootstrap.lua"])
        self.assertIn('R.games=R.games or {}', files["bootstrap.lua"])
        self.assertNotIn('previous.active.view:Hide()', files["bootstrap.lua"])
        self.assertIn("c.renderedFrame=-1", files["scheduler.lua"])
        self.assertIn("local rt=debugprofilestop();R.render(c);c.view.lastRenderMs=debugprofilestop()-rt",
                      files["scheduler.lua"])
        self.assertNotIn("if c.debt<1/60.0988 then R.render(c) end",
                         files["scheduler.lua"])

    def test_fps_display_template(self):
        files = runtime.runtime_files(n.OPS, n.VERSION)
        renderer = files["renderer.lua"]
        controller = files["controller.lua"]
        scheduler = files["scheduler.lua"]
        self.assertIn('f.fps=f:CreateFontString(nil,"OVERLAY")', renderer)
        self.assertIn('f.fps:SetPoint("TOPLEFT",f,"TOPLEFT",6,-6)', renderer)
        self.assertIn("if c.view.fps then c.view.fps:Hide() end", controller)
        self.assertIn("c.view.fpsSample={t=GetTime(),frames=c.ppu.frame}", scheduler)
        self.assertIn("%.1f FPS  %.1fms render", scheduler)
        self.assertIn("c.view.fps:SetText", scheduler)

    def test_input_debug_runtime_template(self):
        files = runtime.runtime_files(n.OPS, n.VERSION)
        bootstrap = files["bootstrap.lua"]
        controller = files["controller.lua"]
        renderer = files["renderer.lua"]
        self.assertIn("debugInput=false", bootstrap)
        self.assertIn("function R.setInputDebug(on)", bootstrap)
        self.assertIn("[WoWNES][input]", bootstrap)
        self.assertNotIn("padRead port=", controller)
        self.assertNotIn("after-8=", controller)
        self.assertNotIn("readLogCount", controller)
        self.assertNotIn("readSuppressed", controller)
        self.assertNotIn("R.inputLog", controller)
        self.assertNotIn("padWrite value=", controller)
        self.assertNotIn("latch-reset", controller)
        self.assertNotIn("padRead port=", controller)
        self.assertNotIn("release reason=", controller)
        self.assertIn('f.hint=f:CreateFontString(nil,"OVERLAY")', renderer)
        self.assertIn('Z=A  X=B  ENTER=START  ARROWS=MOVE  ESC=EXIT', renderer)
        self.assertIn('f.hint:Show()', renderer)
        self.assertIn('self.hint:Hide()', renderer)
        self.assertIn('R.release(c,"escape")', renderer)
        self.assertIn('R.release(c,"hide")', renderer)
        self.assertIn('R.release(c,"combat")', renderer)
        self.assertIn("keyDown key=%s mask=%d old=%d new=%d", renderer)
        self.assertIn("keyUp key=%s mask=%d old=%d new=%d", renderer)
        self.assertIn('R.inputLog("keyDown key=ESCAPE")', renderer)
        self.assertNotIn("io.", "\\n".join(files.values()))
        self.assertNotIn("os.", "\\n".join(files.values()))

    def test_zip_readonly(self):
        with tempfile.TemporaryDirectory() as directory:
            path=Path(directory)/"input.zip"
            with zipfile.ZipFile(path,"w") as z:
                z.writestr("../fixture.nes",fixture())
            before=path.read_bytes()
            report=n.inspect_zip(path)
            self.assertTrue(report["members"][0]["compatible"])
            self.assertEqual(before,path.read_bytes())
            self.assertEqual(list(Path(directory).iterdir()),[path])

    def test_export_validate_cancel_overwrite(self):
        with tempfile.TemporaryDirectory() as repo, tempfile.TemporaryDirectory() as out:
            root=Path(out);data=fixture();progress=[]
            result=n.export(data,root,Path(repo),progress=progress.append)
            self.assertEqual(progress[-1],dict(done=5,total=5))
            game=root/result["output_directories"][1]
            self.assertTrue(n.validate(game))
            before={p.relative_to(root):p.read_bytes() for p in root.rglob("*") if p.is_file()}
            with self.assertRaises(n.ConversionError) as ctx:
                n.export(data,root,Path(repo))
            self.assertEqual(ctx.exception.code,"OUTPUT_EXISTS")
            count=0
            def cancel():
                nonlocal count
                count+=1
                return count>20
            with self.assertRaises(n.Cancelled):
                n.export(data,root,Path(repo),overwrite=True,cancel=cancel)
            self.assertEqual(before,{p.relative_to(root):p.read_bytes() for p in root.rglob("*") if p.is_file()})
            n.export(data,root,Path(repo),overwrite=True)
            self.assertFalse(list(root.glob(".wow-nes-*")))
            path=game/"prg-data-0.lua";path.write_text("bad",encoding="utf-8")
            with self.assertRaises(n.ConversionError) as ctx:n.validate(game)
            self.assertEqual(ctx.exception.code,"CHECKSUM_MISMATCH")

    def test_nop_block_lua51_statement(self):
        rom=n.parse(fixture(program=b"\xea\x00"))
        files,stats=n.executable_data(rom,n.analyze(rom))
        block=files["translated-blocks-0.lua"]
        self.assertEqual(stats["static_blocks"],1)
        self.assertEqual(stats["ir_instructions"],0)
        self.assertIn("P[0]=function(c)",block)
        self.assertIn("local k=0",block)  # block-level cycle accumulator
        self.assertIn("do c.open=0;k=k+2 end",block)  # NOP cycles in its own scope
        self.assertIn("interrupt(c,65534,true)",block)  # BRK exit semantics

    def test_sharding_and_physical_keys(self):
        rom=n.parse(fixture(program=bytes([0xea])*3000+b"\x00"))
        files,stats=n.executable_data(rom,n.analyze(rom))
        self.assertEqual(len([x for x in files if x.startswith("fallback-ir-")]),1)
        # 24 blocks at ~3KB each (do-end scoped statements) span two 64KB shards.
        self.assertEqual(len([x for x in files if x.startswith("translated-blocks-")]),2)
        self.assertIn("WoWNES_Runtime",files["translated-blocks-0.lua"])
        # 3000 NOPs are cut into length-capped blocks of 128 bytes.
        self.assertEqual(stats["static_blocks"],24)
        self.assertEqual(stats["ir_instructions"],0)
        self.assertEqual(stats["block_key"],"bank0_physical_prg_offset")
        block=files["translated-blocks-0.lua"]
        self.assertIn("P[0]=function(c)",block)
        self.assertIn("P[128]=function(c)",block)
        self.assertIn("blockTick",block)

    def test_mapper23_runtime_contract(self):
        files = runtime.runtime_files(n.OPS, n.VERSION)
        bus = files["bus.lua"]
        ppu = files["ppu.lua"]
        cpu = files["cpu-interpreter.lua"]
        self.assertIn("prg0=0,prg1=1", files["bootstrap.lua"])
        self.assertIn("local function prgOffset(c,a)", bus)
        self.assertIn("c.prgB[math.floor(a/8192)-3]+band(a,0x1FFF)", bus)
        self.assertIn("c.prgB[1]=(v%nb)*8192", bus)
        self.assertIn("c.prgB[2]=(v%nb)*8192", bus)
        self.assertIn("c.prgB={(m.prg0%nb)*8192,(m.prg1%nb)*8192,(nb-2)*8192,(nb-1)*8192}",
                      files["bootstrap.lua"])
        self.assertIn("mapperRegister", bus)
        self.assertIn('m.variant="vrc2b"', bus)
        self.assertIn('m.variant="vrc4e"', bus)
        self.assertNotIn("VRC4 IRQ latch/control is deliberately unsupported", bus)
        self.assertIn("q.enableAfterAck=v%2~=0", bus)
        self.assertIn("q.prescaler=q.prescaler-n*3", bus)
        self.assertIn("if q.counter==255 then q.counter=q.latch;q.pending=true", bus)
        self.assertIn("region>=11 and region<=14", bus)
        self.assertIn("local slot=(region-11)*2+math.floor(reg/2)+1", bus)
        self.assertIn("c.mapper.chr[slot]=math.floor(old/16)*16+(v%16)", bus)
        self.assertIn("c.ppu.dirty=true", bus)
        self.assertIn("c.irqAny and band(c.p,4)==0", cpu)
        self.assertIn("R.periphTick(c,n)", cpu)
        self.assertIn("function R.periphTick(c,n)", bus)
        self.assertIn("c.irqAny=true", bus)
        self.assertIn("c.irqAny=c.mapper.irq.pending or false", files["apu.lua"])
        self.assertIn("p.rendering=band(v,24)==24", ppu)
        self.assertIn("if target<=340 then", ppu)
        self.assertIn("if not c.m23 then return end", bus)
        self.assertIn("function R.chrTile", ppu)
        self.assertIn("p.mapper.chr[bank]", ppu)
        self.assertIn("p.g.manifest.mapper==23", ppu)
        self.assertIn("R.ppuMemory(p,pattern+row)", ppu)
        self.assertNotIn("R.ppuMemory(p,base+row)", ppu)
        # Block-engine contracts: physical-keyed dispatch plus per-block tick.
        self.assertIn("function R.blockTick(c,k)", bus)
        self.assertIn("function R.blockLookup(c)", bus)
        self.assertIn("c.tickFinish=c.cycles+(R.slice or 2048)", cpu)
        self.assertIn("c.g.blocks[c.prgB[math.floor(pc/8192)-3]+band(pc,8191)]", cpu)
        self.assertIn("c.tickFinish=0", files["bootstrap.lua"])
        self.assertNotIn("g.blocks={[0]=g.blocks}", files["bootstrap.lua"])

    def test_block_codegen_mapper23(self):
        # LDA #5 / STA $8000 (bank write) / JSR $C000 / BNE -8; INC $10; RTS at $C000.
        program = bytes((0xA9, 0x05, 0x8D, 0x00, 0x80, 0x20, 0x00, 0xC0, 0xD0, 0xF8))
        data = bytearray(fixture(prg_size=131072, program=program))
        data[6:8] = bytes((0x70, 0x10))
        data[16 + 114688:16 + 114691] = bytes((0xE6, 0x10, 0x60))
        rom = n.parse(bytes(data))
        files, stats = n.executable_data(rom, n.analyze(rom))
        src = "".join(files[k] for k in sorted(files) if k.startswith("translated-blocks-"))
        self.assertGreater(stats["static_blocks"], 900)  # all-layout entry union
        self.assertEqual(stats["block_key"], "mapper23_physical_prg_offset")
        # Entry block: immediate operand baked in, falls through directly.
        self.assertIn("P[0]=function(c)", src)
        self.assertIn("local value=5;c.open=5", src)
        # Bank-write block terminates into a runtime lookup (layout may change).
        self.assertIn("local addr=32768;write(c,addr,c.a)", src)
        # JSR to fixed slot $C000 resolves statically and tail-calls the target.
        self.assertIn("c.pc=49152;k=k+6", src)
        self.assertIn("return P[114688](c)", src)
        # Branch exit inlines both directions and dispatches on pc low bits.
        self.assertIn("if band(c.p,2)==0 then", src)
        self.assertIn("if band(c.pc,8191)==2 then return P[2](c) end", src)
        # RTS keeps Lua 5.1 modulo (single %, not a format escape).
        self.assertIn("c.pc=(ret+1)%65536;k=k+6", src)

    def test_exec_table_closures(self):
        files = runtime.runtime_files(n.OPS, n.VERSION)
        cpu = files["cpu-interpreter.lua"]
        self.assertIn("local f=R.exec[op]", cpu)
        self.assertIn("op=string.byte(c.g.prg,c.prgB[math.floor(pc/8192)-3]+band(pc,0x1FFF)+1)", cpu)
        self.assertIn("n=R.execute(c,op)", cpu)
        self.assertIn("R.exec=E", cpu)
        self.assertIn("E[165]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return 3 end", cpu)
        self.assertIn("E[32]=function(c) local pc=c.pc;local lo=read(c,(pc+1)%65536);local ret=(pc+2)%65536;read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);local hi=read(c,ret);c.pc=lo+256*hi;return 6 end", cpu)
        self.assertIn("E[185]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return cyc end", cpu)
        self.assertIn("E[157]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);return 5 end", cpu)
        self.assertIn("R.chrTile(p,rawTile", files["renderer.lua"])


    def test_cancel_after_backup_restores_existing(self):
        with tempfile.TemporaryDirectory() as repo,tempfile.TemporaryDirectory() as out:
            root=Path(out);n.export(fixture(),root,Path(repo))
            before={p.relative_to(root):p.read_bytes() for p in root.rglob("*") if p.is_file()}
            cancelled=False
            def progress(value):
                nonlocal cancelled
                if value["done"]==3:cancelled=True
            with self.assertRaises(n.Cancelled):
                n.export(fixture(),root,Path(repo),overwrite=True,cancel=lambda:cancelled,progress=progress)
            self.assertEqual(before,{p.relative_to(root):p.read_bytes() for p in root.rglob("*") if p.is_file()})
            self.assertFalse(list(root.glob(".wow-nes-*")))

    def test_validator_semantic_damage(self):
        with tempfile.TemporaryDirectory() as repo,tempfile.TemporaryDirectory() as out:
            root=Path(out);result=n.export(fixture(),root,Path(repo))
            game=root/result["output_directories"][1]
            path=game/"chr-map.json";mapping=json.loads(path.read_text("utf-8"))
            mapping[0]["uv"][0]=2;path.write_text(json.dumps(mapping),"utf-8")
            checks=json.loads((game/"checksums.json").read_text("utf-8"))
            checks[path.name]=hashlib.sha256(path.read_bytes()).hexdigest()
            (game/"checksums.json").write_text(json.dumps(checks),"utf-8")
            with self.assertRaises(n.ConversionError) as ctx:n.validate(game)
            self.assertEqual(ctx.exception.code,"INVALID_UV")

    def test_report_contract(self):
        for data in (fixture(), fixture(nes2=True), b"bad"):
            report=n.inspect_bytes(data)
            self.assertIs(n.validate_report(report),report)
            self.assertEqual(report["converter_version"],n.VERSION)
            self.assertEqual(report["rom_id"],report["sha256"][:12])
        report=n.inspect_bytes(fixture())
        for key,value in (("schema_version",True),("prg_bytes",True),("vectors",{}),
                          ("sha256","bad"),("extra",1),("reason_codes",["INVALID_HEADER"])):
            with self.subTest(key=key):
                damaged=dict(report);damaged[key]=value
                with self.assertRaises(n.ConversionError) as ctx:n.validate_report(damaged)
                self.assertEqual(ctx.exception.code,"INVALID_REPORT_SCHEMA")
        damaged=dict(report,rom_id="0"*12)
        with self.assertRaises(n.ConversionError) as ctx:n.validate_report(damaged)
        self.assertEqual(ctx.exception.code,"INVALID_REPORT_IDENTITY")

    def test_cross_semantics_after_rechecksum(self):
        with tempfile.TemporaryDirectory() as repo,tempfile.TemporaryDirectory() as out:
            result=n.export(fixture(trainer=True),Path(out),Path(repo))
            self.assertIs(n.validate_report(result),result)
            game=Path(out)/result["output_directories"][1]
            originals={p.relative_to(game).as_posix():p.read_bytes() for p in game.rglob("*") if p.is_file()}
            report=json.loads(originals["conversion-report.json"])
            mapping=json.loads(originals["chr-map.json"])
            mapping[0]["empty"]=0
            mask=bytearray(originals["textures/chr-mask-1.tga"]);mask[-1]=255
            cases=[
                ("manifest.lua",originals["manifest.lua"].replace(b'"audio_output"]="none"',b'"audio_output"]="sound"'),"INVALID_MANIFEST"),
                (game.name+".toc",originals[game.name+".toc"].replace(b"prg-data-1.lua\n",b""),"INVALID_TOC_ORDER"),
                (game.name+".toc",originals[game.name+".toc"].replace(b"prg-data-1.lua",b"prg-data-0.lua"),"INVALID_TOC_ORDER"),
                ("prg-data-0.lua",originals["prg-data-0.lua"]+b"G.prg={}\n","INVALID_LUA_DATA"),
                ("fallback-ir-0.lua",originals["fallback-ir-0.lua"]+b"-- damaged\n","INVALID_EXECUTABLE_DATA"),
                ("translated-blocks-0.lua",originals["translated-blocks-0.lua"]+b"-- damaged\n","INVALID_EXECUTABLE_DATA"),
                ("tiles-data-0.lua",originals["tiles-data-0.lua"].replace(b'["empty"]=7',b'["empty"]=0',1),"INVALID_UV"),
                ("chr-map.json",json.dumps(mapping).encode(),"INVALID_UV"),
                ("textures/chr-mask-1.tga",bytes(mask),"INVALID_ATLAS"),
                ("textures/chr-mask-1.tga",b"short","INVALID_ATLAS"),
                ("conversion-report.json",b"{}","INVALID_REPORT_SCHEMA"),
                ("conversion-report.json",b"{","INVALID_PACKAGE_DATA"),
            ]
            for name,content,code in cases:
                with self.subTest(name=name,code=code):
                    self.assertNotEqual(content,originals[name])
                    path=game/name;path.write_bytes(content)
                    checks=json.loads(originals["checksums.json"])
                    checks[name]=hashlib.sha256(content).hexdigest()
                    (game/"checksums.json").write_text(json.dumps(checks),"utf-8")
                    with self.assertRaises(n.ConversionError) as ctx:n.validate(game)
                    self.assertEqual(ctx.exception.code,code)
                    path.write_bytes(originals[name])
                    (game/"checksums.json").write_bytes(originals["checksums.json"])
            toc=game/(game.name+".toc")
            renamed=game/"renamed.toc"
            toc.rename(renamed)
            checks=json.loads(originals["checksums.json"])
            checks[renamed.name]=checks.pop(toc.name)
            (game/"checksums.json").write_text(json.dumps(checks),"utf-8")
            with self.assertRaises(n.ConversionError) as ctx:n.validate(game)
            self.assertEqual(ctx.exception.code,"INVALID_REPORT_IDENTITY")
            renamed.rename(toc)
            (game/"checksums.json").write_bytes(originals["checksums.json"])
            report["translation"]["static_blocks"]+=1
            (game/"conversion-report.json").write_text(json.dumps(report),"utf-8")
            manifest=dict(report,runtime_version=n.VERSION)
            (game/"manifest.lua").write_text(n.manifest_file(manifest),"utf-8")
            checks=json.loads(originals["checksums.json"])
            for name in ("conversion-report.json","manifest.lua"):
                checks[name]=hashlib.sha256((game/name).read_bytes()).hexdigest()
            (game/"checksums.json").write_text(json.dumps(checks),"utf-8")
            with self.assertRaises(n.ConversionError) as ctx:n.validate(game)
            self.assertEqual(ctx.exception.code,"INVALID_TRANSLATION_STATS")

    def test_validate_full_shards_and_mirrored_cfg(self):
        with tempfile.TemporaryDirectory() as repo,tempfile.TemporaryDirectory() as out:
            for data in (fixture(32768,program=bytes([0xea])*3000+b"\x00"),
                         fixture(program=b"\x4c\x00\xc0"),
                         fixture(program=b"\xd0\x01\xa9\x00\x60")):
                result=n.export(data,Path(out),Path(repo),overwrite=True)
                self.assertTrue(n.validate(Path(out)/result["output_directories"][1]))

    def test_target_safety(self):
        with tempfile.TemporaryDirectory() as repo:
            root=Path(repo)
            with self.assertRaises(n.ConversionError):n.export(fixture(),root,root)
            with self.assertRaises(n.ConversionError):n.export(fixture(),root/"..",root)
            with self.assertRaises(n.ConversionError):n.export(fixture(),Path("relative"),root)

    def test_publish_failure_rollback(self):
        with tempfile.TemporaryDirectory() as repo,tempfile.TemporaryDirectory() as out:
            root=Path(out);result=n.export(fixture(),root,Path(repo))
            before={p.relative_to(root):p.read_bytes() for p in root.rglob("*") if p.is_file()}
            original=Path.rename
            def fail(path,target):
                if path.parent.name.endswith(".tmp") and path.name.startswith("WoWNES_Game"):
                    raise OSError("injected commit failure")
                return original(path,target)
            with patch.object(Path,"rename",fail):
                with self.assertRaises(OSError):n.export(fixture(),root,Path(repo),overwrite=True)
            self.assertEqual(before,{p.relative_to(root):p.read_bytes() for p in root.rglob("*") if p.is_file()})
            self.assertFalse(list(root.glob(".wow-nes-*")))


if __name__=="__main__":
    unittest.main()
