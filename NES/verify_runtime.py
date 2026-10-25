"""Generate CC0 self-authored PoC package and an external workshop test script."""
import json
import tempfile
from pathlib import Path
import wow_nes as n
from wow_nes_runtime import runtime_files
from test_wow_nes import fixture


def build():
    root=Path(tempfile.mkdtemp(prefix="WOW_NES_verify_"))
    report=n.export(fixture(),root,Path(__file__).parent)
    rom=n.parse(fixture());cfg=n.analyze(rom)
    files,stats=n.executable_data(rom,cfg)
    runtime=runtime_files(n.OPS,n.VERSION)
    code="\n".join(runtime[name] for name in runtime if name.endswith(".lua"))
    code+='\nlocal G={prg={},blocks={},manifest='+n.lua_value(rom.report())+',trainer="",chr='+n.lua_bytes(rom.chr)+',tiles={}}\n'
    code+='local function inject(...)\n'
    code+='\n'.join(files[name] for name in files if name.endswith(".lua"))
    code+='\nend\ninject("WoWNES_Game_fixture",G);WoWNES_Runtime:Register(G)\n'
    # Each case uses the real exporter; expected bus events below are independent literals.
    programs = {"jsr": b"\x20\x34\x12", "rts": b"\x60\xea", "rti": b"\x40\xea",
                "pha": b"\x48\xea", "php": b"\x08\xea", "pla": b"\x68\xea",
                "plp": b"\x28\xea", "inx": b"\xe8\xea", "tax": b"\xaa\xea",
                "asl": b"\x0a\xea", "lsr": b"\x4a\xea", "rol": b"\x2a\xea",
                "ror": b"\x6a\xea", "brk": b"\x00\xea"}
    code+='\nlocal traceGames={}\n'
    for name, program in programs.items():
        sample = n.parse(fixture(program=program))
        sample_cfg = n.analyze(sample)
        sample_cfg["instructions"] = {32768: sample_cfg["instructions"][32768]}
        generated, _ = n.executable_data(sample, sample_cfg)
        code+='do local G={prg={},blocks={},manifest='+n.lua_value(sample.report())+',trainer="",chr='+n.lua_bytes(sample.chr)+',tiles={}}\nlocal function inject(...)\n'
        code+='\n'.join(text for path, text in generated.items() if path.endswith('.lua'))
        code+='\nend\ninject("trace",G);WoWNES_Runtime:Register(G);traceGames["'+name+'"]=G end\n'
    code+=r'''
local R=WoWNES_Runtime
local golden={
 {"jsr","R8000:20,R8001:34,R01FD:00,W01FD:80,W01FC:02,R8002:12",4660,129,251,33,6},
 {"rts","R8000:60,R8001:EA,R01FB:00,R01FC:02,R01FD:80,R8002:EA",32771,129,253,33,6},
 {"rti","R8000:40,R8001:EA,R01FA:00,R01FB:FF,R01FC:34,R01FD:12",4660,129,253,239,6},
 {"pha","R8000:48,R8001:EA,W01FD:81",32769,129,252,33,3},
 {"php","R8000:08,R8001:EA,W01FD:31",32769,129,252,33,3},
 {"pla","R8000:68,R8001:EA,R01FC:00,R01FD:80",32769,128,253,161,4},
 {"plp","R8000:28,R8001:EA,R01FC:00,R01FD:FF",32769,129,253,239,4},
 {"inx","R8000:E8,R8001:EA",32769,129,253,33,2},
 {"tax","R8000:AA,R8001:EA",32769,129,253,161,2},
 {"asl","R8000:0A,R8001:EA",32769,2,253,33,2},
 {"lsr","R8000:4A,R8001:EA",32769,64,253,33,2},
 {"rol","R8000:2A,R8001:EA",32769,3,253,33,2},
 {"ror","R8000:6A,R8001:EA",32769,192,253,161,2},
 {"brk","R8000:00,R8001:EA,W01FD:80,W01FC:02,W01FB:31,RFFFE:00,RFFFF:80",32768,129,250,37,7},
 {"nmi","R8000:E8,R8000:E8,W01FD:80,W01FC:00,W01FB:21,RFFFA:00,RFFFB:80",32768,129,250,37,7},
 {"irq","R8000:E8,R8000:E8,W01FD:80,W01FC:00,W01FB:21,RFFFE:00,RFFFF:80",32768,129,250,37,7}
}
local goldenCount=0;local routes={block=0,ir=0,fallback=0}
for _,test in ipairs(golden) do
 for _,backend in ipairs({"block","ir","interpreter"}) do
  local name=test[1];local cpu=R:New(traceGames[name] or traceGames.inx)
  cpu.a=129;cpu.p=33
  if name=="rts" then cpu.s=251;cpu.ram[508]=2;cpu.ram[509]=128
  elseif name=="rti" then cpu.s=250;cpu.ram[507]=255;cpu.ram[508]=52;cpu.ram[509]=18
  elseif name=="pla" or name=="plp" then cpu.s=252;cpu.ram[509]=name=="pla" and 128 or 255
  elseif name=="nmi" then cpu.nmi=true
  elseif name=="irq" then cpu.apu.irq=true end
  local events={};local originalRead,originalWrite=R.read,R.write
  R.read=function(c,a) local v=originalRead(c,a);events[#events+1]=string.format("R%04X:%02X",a%65536,v);return v end
  R.write=function(c,a,v) events[#events+1]=string.format("W%04X:%02X",a%65536,v%256);return originalWrite(c,a,v) end
  local ok,cycles=pcall(R.step,cpu,backend)
  R.read,R.write=originalRead,originalWrite
  assert(ok,cycles)
  local trace=table.concat(events,",")
  assert(trace==test[2],name.." "..backend.." bus: "..trace)
  assert(cpu.pc==test[3] and cpu.a==test[4] and cpu.s==test[5] and cpu.p==test[6] and cycles==test[7] and cpu.cycles==7+test[7],name.." "..backend.." state")
  local expectedX=name=="tax" and 129 or (name=="inx" and 1 or 0)
  assert(cpu.x==expectedX and cpu.y==0,name.." "..backend.." X/Y state")
  if name~="nmi" and name~="irq" then
   local route="fallback"
   assert(cpu.stats[route]==1,name.." "..backend.." dispatch")
   routes[route]=routes[route]+1
  end
  goldenCount=goldenCount+1
 end
end
local states={}
for _,backend in ipairs({"block","ir","interpreter"}) do
 local c=R:New(G);local reads,writes={},{}
 local originalRead,originalWrite=R.read,R.write
 R.read=function(cpu,a) local v=originalRead(cpu,a);reads[#reads+1]=a..":"..v;return v end
 R.write=function(cpu,a,v) writes[#writes+1]=a..":"..v;return originalWrite(cpu,a,v) end
 for i=1,6 do R.step(c,backend) end
 R.read,R.write=originalRead,originalWrite
 states[#states+1]=table.concat({c.pc,c.a,c.x,c.y,c.s,c.p,c.cycles,c.ram[16],table.concat(reads,","),table.concat(writes,",")},"|")
end
assert(states[1]==states[2] and states[2]==states[3],"backend trace mismatch")
local c=R:New(G)
R.write(c,0,42);assert(R.read(c,2048)==42,"RAM mirror")
R.write(c,8198,63);R.write(c,8198,0);R.write(c,8199,17)
assert(R.ppuMemory(c.ppu,16144)==17,"palette mirror")
R.write(c,8198,32);R.write(c,8198,0);R.write(c,8199,7)
assert(R.ppuMemory(c.ppu,9216)==7,"horizontal CIRAM")
R.write(c,8198,32);R.write(c,8198,0)
assert(R.read(c,8199)==0 and R.read(c,8199)==7,"PPU read buffer")
c.pad.state[1]=165;R.write(c,16406,1);R.write(c,16406,0)
local bits=0;for i=0,7 do bits=bits+(R.read(c,16406)%2)*2^i end
assert(bits==165 and R.read(c,16406)%2==1,"controller serial")
R.write(c,16405,1);R.write(c,16387,0);assert(R.read(c,16405)%2==1,"APU length status")
R.apuTick(c,29830);assert(c.apu.irq,"APU frame IRQ")
R.read(c,16405);assert(not c.apu.irq,"APU IRQ clear")
c.ppu.mask=30;c.ppu.ctrl=0;c.ppu.scanline=1;c.ppu.dot=0
c.ppu.v=0;c.ppu.t=0;c.ppu.x=0;c.ppu.w=0
c.ppu.oam[0]=0;c.ppu.oam[1]=0;c.ppu.oam[2]=0;c.ppu.oam[3]=0
c.ppu.nt[0]=0;c.ppu.chr=string.char(128,128)..string.rep(string.char(0),8190)
local originalChr=c.ppu.g.chr;c.ppu.g.chr=c.ppu.chr
R.ppuTick(c,6);c.ppu.g.chr=originalChr
assert(bit.band(c.ppu.status,64)~=0,"sprite-zero pattern address")
R.write(c,8192,128);c.ppu.scanline=241;c.ppu.dot=0;R.ppuTick(c,3)
assert(c.nmi and bit.band(c.ppu.status,128)~=0,"vblank NMI")
local cycle=c.cycles;R.step(c,"interpreter");assert(c.cycles==cycle+7 and not c.nmi,"NMI entry")
R.write(c,16404,0);assert(c.stall==513+c.cycles%2,"OAM DMA stall")
c.running=true;c.pad.state[1]=255;R.release(c);assert(not c.running and c.pad.state[1]==0,"input release")
local mirrored=R:New(G);mirrored.pc=49152;R.step(mirrored,"block")
assert(mirrored.pc==49154 and mirrored.a==1 and mirrored.stats.fallback==1,"physical bank mirror fallback")
local arithmetic=R:New(G);arithmetic.pc=0;arithmetic.ram[1]=1;arithmetic.a=127;arithmetic.p=32
assert(R.execute(arithmetic,105)==2 and arithmetic.a==128 and bit.band(arithmetic.p,64)~=0,"ADC overflow")
arithmetic.pc=0;arithmetic.a=0;arithmetic.p=33
R.execute(arithmetic,233);assert(arithmetic.a==255 and bit.band(arithmetic.p,1)==0,"SBC borrow")
local indexed=R:New(G);indexed.pc=0;indexed.ram[1]=255;indexed.ram[2]=0;indexed.x=1
assert(R.execute(indexed,189)==5,"indexed page crossing")
local branch=R:New(G);branch.pc=253;branch.ram[254]=2;branch.p=32
assert(R.execute(branch,208)==4 and branch.pc==257,"branch page crossing")
local jump=R:New(G);jump.pc=0;jump.ram[1]=255;jump.ram[2]=2;jump.ram[767]=52;jump.ram[512]=18
R.execute(jump,108);assert(jump.pc==4660,"NMOS indirect JMP wrap")
local ram=R:New(G);ram.pc=0;ram.ram[0]=169;ram.ram[1]=77;R.step(ram)
assert(ram.a==77 and ram.stats.fallback==1,"RAM execution fallback")
local tested=0
for opcode,m in pairs(R.ops) do
 local traces={}
 for backend=1,2 do
  local cpu=R:New(G);cpu.pc=512;cpu.ram[512]=opcode;cpu.ram[513]=16;cpu.ram[514]=0
  cpu.ram[16]=3;cpu.ram[17]=0;cpu.a=85;cpu.x=2;cpu.y=1
  local reads,writes={},{};local originalRead,originalWrite=R.read,R.write
  R.read=function(state,a) local v=originalRead(state,a);reads[#reads+1]=a..":"..v;return v end
  R.write=function(state,a,v) writes[#writes+1]=a..":"..v;return originalWrite(state,a,v) end
  local operand=nil;if backend==2 then operand=m[3]>1 and 16 or 0 end
  local cycles=R.execute(cpu,R.read(cpu,512),operand)
  R.read,R.write=originalRead,originalWrite
  traces[backend]=table.concat({cpu.pc,cpu.a,cpu.x,cpu.y,cpu.s,cpu.p,cycles,table.concat(reads,","),table.concat(writes,",")},"|")
 end
 assert(traces[1]==traces[2],"official opcode IR differential "..opcode);tested=tested+1
end
WoWNES_Verification={passed=true,backends=3,steps=6,trace=states[1],checks=17,official_opcodes=tested,golden_cases=#golden,golden_runs=goldenCount,golden_routes=routes}
return WoWNES_Verification
'''
    runner=root/"runtime-test.lua";runner.write_text(code,"utf-8")
    irq_code=r'''local R=WoWNES_Runtime
assert(R,"runtime not loaded")
local prg=string.rep(string.char(234),32762)..string.char(0,144,0,128,0,160)
local G={prg={prg},blocks={},ir={},manifest={rom_id="irq-test",mapper=23,mirroring="horizontal",vectors={reset=32768}},trainer="",chr=string.rep(string.char(0),8192),tiles={}}
R:Register(G)
local function cpu() return R:New(G) end
local c=cpu()
R.write(c,32768,6);assert(R.read(c,32768)==234,"PRG bank high bits wrap")
R.write(c,61440,11);R.write(c,61441,10);R.write(c,61442,7)
assert(c.mapper.variant=="vrc2b" and c.mapper.irq.latch==171 and c.mapper.irq.counter==171,"VRC2b latch/control")
R.mapperTick(c,84);assert(c.mapper.irq.counter==255 and not c.mapper.irq.pending,"cycle pre-overflow")
R.mapperTick(c,1);assert(c.mapper.irq.counter==171 and c.mapper.irq.pending,"cycle overflow")
R.write(c,61443,0);assert(not c.mapper.irq.pending and c.mapper.irq.enabled and c.mapper.irq.counter==171,"ack")
R.write(c,61440,14);R.write(c,61441,15);R.write(c,61442,3)
R.mapperTick(c,113);assert(c.mapper.irq.counter==254 and c.mapper.irq.prescaler==2,"scanline partial")
R.mapperTick(c,1);assert(c.mapper.irq.counter==255 and c.mapper.irq.prescaler==340,"scanline tick")
R.mapperTick(c,113);R.mapperTick(c,1);assert(c.mapper.irq.counter==254 and c.mapper.irq.pending and c.mapper.irq.prescaler==339,"scanline overflow")
R.write(c,61442,0);R.write(c,61443,0);assert(not c.mapper.irq.enabled and not c.mapper.irq.pending,"disabled ack")
local e=cpu();R.write(e,61440,5);R.write(e,61444,12);R.write(e,61448,7)
assert(e.mapper.variant=="vrc4e" and e.mapper.irq.latch==197 and e.mapper.irq.enabled,"VRC4e decode")
local n=cpu();n.p=32;n.mapper.irq.pending=true;n.nmi=true;n.mapper.irq.enabled=false
R.step(n,"interpreter");assert(n.pc==36864 and n.mapper.irq.pending,"NMI priority/pending")
local i=cpu();i.p=32;i.mapper.irq.pending=true
R.step(i,"interpreter");assert(i.pc==40960 and i.mapper.irq.pending and bit.band(i.p,4)~=0,"mapper IRQ")
local masked=cpu();masked.p=36;masked.mapper.irq.pending=true
R.step(masked,"interpreter");assert(masked.pc==32769,"I mask")
local apu=cpu();apu.p=32;apu.apu.irq=true
R.step(apu,"interpreter");assert(apu.pc==40960,"APU IRQ merge")
local dma=cpu();dma.p=36;dma.mapper.irq.enabled=true;dma.mapper.irq.cycleMode=true;dma.mapper.irq.latch=0;dma.mapper.irq.counter=0
R.write(dma,16404,0);local cycles=R.step(dma,"interpreter")
assert(cycles==516 and dma.mapper.irq.counter==4 and dma.mapper.irq.pending,"DMA mapper cycles")
return {passed=true,checks=15,cycle_counter=c.mapper.irq.counter,scanline_prescaler=c.mapper.irq.prescaler,dma_cycles=cycles,variant=e.mapper.variant}
'''
    irq_runner=root/"irq-behavior-test.lua";irq_runner.write_text(irq_code,"utf-8")
    print(json.dumps(dict(root=str(root),runner=str(runner),irq_runner=str(irq_runner),
                         rom_sha256=rom.sha256,report=report),indent=2))


if __name__=="__main__":build()
