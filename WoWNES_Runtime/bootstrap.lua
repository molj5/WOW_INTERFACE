
local R=WoWNES_Runtime or {version="0.1.0",games={},debugInput=false}
WoWNES_Runtime=R
R.games=R.games or {}
local band,bor,bxor=bit.band,bit.bor,bit.bxor
function R.setInputDebug(on) R.debugInput=on and true or false;print("[WoWNES][input] debug="..tostring(R.debugInput)) end
function R.inputLog(message) if R.debugInput then print("[WoWNES][input] "..message) end end
function R.flag(p,mask,on) if on then return bor(p,mask) end return band(p,255-mask) end
function R.nz(p,v) return R.flag(R.flag(p,2,v==0),128,v>=128) end
function R:Register(g)
 if type(g.prg)=="table" then g.prg=table.concat(g.prg) end
 if type(g.chr)=="table" then g.chr=table.concat(g.chr) end
 if not g.irIndex then
  g.irIndex={[0]={}}
  for i=1,#g.ir,3 do g.irIndex[0][g.ir[i]]=i end
 end
 self.games[g.manifest.rom_id]=g
end
function R:New(g)
 local c={a=0,x=0,y=0,s=253,p=36,pc=g.manifest.vectors.reset,cycles=7,
  g=g,ram={},sram={},open=0,nmi=false,stall=0,
  mapper={prg0=0,prg1=1,chr={0,1,2,3,4,5,6,7},mirroring=g.manifest.mirroring,variant=nil,irq={latch=0,counter=0,prescaler=341,enabled=false,enableAfterAck=false,cycleMode=false,pending=false}},
  stats={block=0,ir=0,fallback=0}}
 c.m23=g.manifest.mapper==23
 if c.m23 then c.mapper.prg0=0;c.mapper.prg1=1 end
 -- Cached PRG bank bases: slot->physical base offset, updated on mapper bank writes.
 local nb=#g.prg/8192;local m=c.mapper
 c.prgB={(m.prg0%nb)*8192,(m.prg1%nb)*8192,(nb-2)*8192,(nb-1)*8192}
 c.irqAny=false
 c.tickFinish=0
 for i=0,2047 do c.ram[i]=0 end
 for i=0,8191 do c.sram[i]=0 end
 for i=1,#g.trainer do c.sram[4095+i]=string.byte(g.trainer,i) end
 c.ppu=self.NewPPU(g);c.ppu.mapper=c.mapper;c.apu=self.NewAPU();c.pad=self.NewPad()
 return c
end
