
local R=WoWNES_Runtime
local band=bit.band
local floor=math.floor
local function prgOffset(c,a)
 return c.prgB[math.floor(a/8192)-3]+band(a,0x1FFF)
end
local function mapperRegister(c,low)
 local m=c.mapper;local nibble=low%16
 if m.variant==nil then
  if nibble==0 then return 0 end
  if nibble==1 or nibble==2 or nibble==3 then m.variant="vrc2b";return nibble end
  if nibble==4 or nibble==8 or nibble==12 then m.variant="vrc4e";return math.floor(nibble/4) end
  return nil
 elseif m.variant=="vrc2b" then
  return nibble<4 and nibble or nil
 else
  return nibble%4==0 and math.floor(nibble/4) or nil
 end
end
local function mapperWrite(c,a,v)
 if c.g.manifest.mapper~=23 then return false end
 local region=math.floor(a/4096);local low=a%4096
 local reg=mapperRegister(c,low)
 if reg==nil then return false end
 if region==8 then c.mapper.prg0=v;local nb=#c.g.prg/8192;c.prgB[1]=(v%nb)*8192
 elseif region==9 then c.mapper.mirroring=({[0]="vertical",[1]="horizontal",[2]="one-screen-a",[3]="one-screen-b"})[v%4]
 elseif region==10 then c.mapper.prg1=v;local nb=#c.g.prg/8192;c.prgB[2]=(v%nb)*8192
 elseif region>=11 and region<=14 then
  -- B/C/D/E each expose two 1 KiB CHR banks; reg 0/1 selects low/high nibble.
  local slot=(region-11)*2+math.floor(reg/2)+1
  local old=c.mapper.chr[slot]%256
  if reg%2==0 then c.mapper.chr[slot]=math.floor(old/16)*16+(v%16)
  else c.mapper.chr[slot]=(v%16)*16+old%16 end
 elseif region==15 then
  local q=c.mapper.irq
  if reg==0 then q.latch=math.floor(q.latch/16)*16+v%16
  elseif reg==1 then q.latch=(v%16)*16+q.latch%16
  elseif reg==2 then
   q.pending=false;q.enableAfterAck=v%2~=0;q.enabled=math.floor(v/2)%2~=0;q.cycleMode=math.floor(v/4)%2~=0
   if q.enabled then q.counter=q.latch;q.prescaler=341 end
   c.irqAny=c.apu.irq or false
  elseif reg==3 then q.pending=false;q.enabled=q.enableAfterAck;c.irqAny=c.apu.irq or false end
 end
 c.ppu.dirty=true
 return true
end
function R.mapperTick(c,n)
 if not c.m23 then return end
 local q=c.mapper.irq
 if not q.enabled then return end
 local ticks=n
 if not q.cycleMode then
  q.prescaler=q.prescaler-n*3;ticks=0
  while q.prescaler<=0 do q.prescaler=q.prescaler+341;ticks=ticks+1 end
 end
 for i=1,ticks do
  if q.counter==255 then q.counter=q.latch;q.pending=true;c.irqAny=true else q.counter=q.counter+1 end
 end
end
-- Combined per-instruction tick: one Lua call instead of two per step.
function R.periphTick(c,n)
 R.apuTick(c,n);R.mapperTick(c,n)
end
function R.read(c,a)
 a=a%65536
 local v
 if a<8192 then v=c.ram[a%2048]
 elseif a>=32768 then v=string.byte(c.g.prg,prgOffset(c,a)+1)
 elseif a<16384 then v=R.ppuRead(c,a%8)
 elseif a==16405 then v=R.apuRead(c)
 elseif a==16406 or a==16407 then v=R.padRead(c,a-16405)
 elseif a>=24576 then v=c.sram[a-24576]
 else v=c.open end
 c.open=v;return v
end
function R.write(c,a,v)
 a=a%65536;v=v%256;c.open=v
 if a<8192 then c.ram[a%2048]=v
 elseif a<16384 then R.ppuWrite(c,a%8,v)
 elseif a>=32768 and mapperWrite(c,a,v) then return
 elseif a==16404 then
  for i=0,255 do c.ppu.oam[(c.ppu.oamAddr+i)%256]=R.read(c,(v*256+i)%65536) end
  c.stall=c.stall+513+c.cycles%2;c.ppu.dirty=true
 elseif a==16406 then R.padWrite(c,v)
 elseif a>=16384 and a<=16407 then R.apuWrite(c,a,v)
 elseif a>=24576 and a<32768 then c.sram[a-24576]=v end
end
function R.push(c,v) R.write(c,256+c.s,v);c.s=(c.s-1)%256 end
function R.pop(c) c.s=(c.s+1)%256;return R.read(c,256+c.s) end
function R.word(c,a) return R.read(c,a)+256*R.read(c,(a+1)%65536) end
-- Block-engine tick: one call per basic block replaces the per-instruction
-- step tail. Returns 1 when the scheduler slice budget is exhausted, 2 when
-- an interrupt must be injected before the next fetch, false otherwise.
function R.blockTick(c,k)
 k=k+c.stall;c.stall=0
 c.cycles=c.cycles+k
 R.ppuTick(c,k*3);R.periphTick(c,k)
 if c.cycles>=c.tickFinish then return 1 end
 if c.nmi or (c.irqAny and band(c.p,4)==0) then return 2 end
 return false
end
-- Re-resolve the current bank layout, inject a pending interrupt, then keep
-- executing blocks; falls back to the closure interpreter on a table miss.
function R.blockLookup(c)
 if c.nmi then
  c.nmi=false;local n=R.interrupt(c,65530,false)
  n=n+c.stall;c.stall=0;c.cycles=c.cycles+n;R.ppuTick(c,n*3);R.periphTick(c,n)
 elseif c.irqAny and band(c.p,4)==0 then
  local n=R.interrupt(c,65534,false)
  n=n+c.stall;c.stall=0;c.cycles=c.cycles+n;R.ppuTick(c,n*3);R.periphTick(c,n)
 end
 if c.cycles>=c.tickFinish then return end
 local pc=c.pc
 if pc>=32768 then
  local f=c.g.blocks[c.prgB[floor(pc/8192)-3]+band(pc,8191)]
  if f then return f(c) end
 end
 return R.step(c)
end
