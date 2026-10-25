"""Offline Lua 5.1 package generator; installing game source requires workshop."""

BOOTSTRAP = r'''
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
'''
BUS = r'''
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
'''
CPU = r'''
local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local function has(p,m) return band(p,m)~=0 end
function R.interrupt(c,vector,brk)
 if not brk then R.read(c,c.pc);R.read(c,c.pc) end
 R.push(c,math.floor(c.pc/256));R.push(c,c.pc%256)
 R.push(c,R.flag(bor(c.p,32),16,brk));c.p=bor(c.p,4)
 c.pc=R.word(c,vector);return 7
end
function R.execute(c,op,operand)
 local m=R.ops[op]
 if not m then error(string.format("Unsupported unofficial opcode %02X at %04X",op,c.pc)) end
 local name,mode,len,cycles,page=m[1],m[2],m[3],m[4],m[5]
 -- Operand reads occur in every backend, preserving CPU bus side effects.
 local pc=c.pc
 if name=="JSR" then
  local lo=R.read(c,(pc+1)%65536);local ret=(pc+2)%65536
  R.read(c,256+c.s);R.push(c,math.floor(ret/256));R.push(c,ret%256)
  local hi=R.read(c,ret);c.pc=lo+256*hi;return cycles
 end
 if mode=="imp" or mode=="acc" then
  if name~="BRK" then R.read(c,(pc+1)%65536) end
 end
 if operand==nil then
  operand=0
  if len>1 then operand=R.read(c,(pc+1)%65536) end
  if len>2 then operand=operand+256*R.read(c,(pc+2)%65536) end
 else
  if len>1 then R.read(c,(pc+1)%65536) end
  if len>2 then R.read(c,(pc+2)%65536) end
 end
 c.pc=(pc+len)%65536
 local addr,base,value
 if mode=="zp" then addr=operand
 elseif mode=="zpx" then R.read(c,operand);addr=(operand+c.x)%256
 elseif mode=="zpy" then R.read(c,operand);addr=(operand+c.y)%256
 elseif mode=="abs" then addr=operand
 elseif mode=="abx" then base=operand;addr=(base+c.x)%65536
 elseif mode=="aby" then base=operand;addr=(base+c.y)%65536
 elseif mode=="izx" then
  R.read(c,operand);local z=(operand+c.x)%256
  addr=R.read(c,z)+256*R.read(c,(z+1)%256)
 elseif mode=="izy" then
  base=R.read(c,operand)+256*R.read(c,(operand+1)%256);addr=(base+c.y)%65536
 elseif mode=="ind" then addr=R.read(c,operand)+256*R.read(c,math.floor(operand/256)*256+(operand+1)%256) end
 if base then
  local crossed=math.floor(base/256)~=math.floor(addr/256)
  if page and crossed then cycles=cycles+1 end
  if crossed or not page then R.read(c,math.floor(base/256)*256+addr%256) end
 end
 local store=name=="STA" or name=="STX" or name=="STY"
 local flow=name=="JMP" or name=="JSR"
 if mode=="imm" then value=operand
 elseif mode=="acc" then value=c.a
 elseif addr and not store and not flow then value=R.read(c,addr) end
 local function nz(v) v=v%256;c.p=R.nz(c.p,v);return v end
 local function compare(a,b) c.p=R.flag(c.p,1,a>=b);nz((a-b)%256) end
 if name=="LDA" then c.a=nz(value)
 elseif name=="LDX" then c.x=nz(value)
 elseif name=="LDY" then c.y=nz(value)
 elseif name=="STA" then R.write(c,addr,c.a)
 elseif name=="STX" then R.write(c,addr,c.x)
 elseif name=="STY" then R.write(c,addr,c.y)
 elseif name=="ORA" then c.a=nz(bor(c.a,value))
 elseif name=="AND" then c.a=nz(band(c.a,value))
 elseif name=="EOR" then c.a=nz(bxor(c.a,value))
 elseif name=="ADC" or name=="SBC" then
  local b=value;if name=="SBC" then b=255-b end
  local sum=c.a+b+(has(c.p,1) and 1 or 0);local result=sum%256
  c.p=R.flag(c.p,1,sum>255)
  c.p=R.flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0)
  c.a=nz(result)
 elseif name=="CMP" then compare(c.a,value)
 elseif name=="CPX" then compare(c.x,value)
 elseif name=="CPY" then compare(c.y,value)
 elseif name=="BIT" then
  c.p=R.flag(R.flag(R.flag(c.p,2,band(c.a,value)==0),64,has(value,64)),128,has(value,128))
 elseif name=="ASL" or name=="LSR" or name=="ROL" or name=="ROR" or name=="INC" or name=="DEC" then
  local old=value;local carry=has(c.p,1) and 1 or 0
  if name=="ASL" or name=="ROL" then
   c.p=R.flag(c.p,1,value>=128);value=value*2+(name=="ROL" and carry or 0)
  elseif name=="LSR" or name=="ROR" then
   c.p=R.flag(c.p,1,value%2==1);value=math.floor(value/2)+(name=="ROR" and carry*128 or 0)
  elseif name=="INC" then value=value+1 else value=value-1 end
  value=nz(value)
  if mode=="acc" then c.a=value else R.write(c,addr,old);R.write(c,addr,value) end
 elseif mode=="rel" then
  local mask=({BPL=128,BMI=128,BVC=64,BVS=64,BCC=1,BCS=1,BNE=2,BEQ=2})[name]
  local positive=name=="BMI" or name=="BVS" or name=="BCS" or name=="BEQ"
  if has(c.p,mask)==positive then
   local target=(c.pc+(operand<128 and operand or operand-256))%65536
   R.read(c,c.pc);cycles=cycles+1
   if math.floor(target/256)~=math.floor(c.pc/256) then
    R.read(c,math.floor(c.pc/256)*256+target%256);cycles=cycles+1
   end
   c.pc=target
  end
 elseif name=="JMP" then c.pc=addr
 elseif name=="RTS" then
  R.read(c,256+c.s);local lo=R.pop(c);local hi=R.pop(c)
  local ret=lo+256*hi;R.read(c,ret);c.pc=(ret+1)%65536
 elseif name=="RTI" then
  R.read(c,256+c.s);c.p=bor(band(R.pop(c),239),32)
  local lo=R.pop(c);local hi=R.pop(c);c.pc=lo+256*hi
 elseif name=="BRK" then R.read(c,c.pc);c.pc=(c.pc+1)%65536;return R.interrupt(c,65534,true)
 elseif name=="PHA" then R.push(c,c.a)
 elseif name=="PHP" then R.push(c,bor(c.p,48))
 elseif name=="PLA" then R.read(c,256+c.s);c.a=nz(R.pop(c))
 elseif name=="PLP" then R.read(c,256+c.s);c.p=bor(band(R.pop(c),239),32)
 elseif name=="TAX" then c.x=nz(c.a)
 elseif name=="TAY" then c.y=nz(c.a)
 elseif name=="TXA" then c.a=nz(c.x)
 elseif name=="TYA" then c.a=nz(c.y)
 elseif name=="TSX" then c.x=nz(c.s)
 elseif name=="TXS" then c.s=c.x
 elseif name=="INX" then c.x=nz(c.x+1)
 elseif name=="INY" then c.y=nz(c.y+1)
 elseif name=="DEX" then c.x=nz(c.x-1)
 elseif name=="DEY" then c.y=nz(c.y-1)
 elseif name=="CLC" then c.p=R.flag(c.p,1,false)
 elseif name=="SEC" then c.p=R.flag(c.p,1,true)
 elseif name=="CLI" then c.p=R.flag(c.p,4,false)
 elseif name=="SEI" then c.p=R.flag(c.p,4,true)
 elseif name=="CLD" then c.p=R.flag(c.p,8,false)
 elseif name=="SED" then c.p=R.flag(c.p,8,true)
 elseif name=="CLV" then c.p=R.flag(c.p,64,false) end
 return cycles
end
function R.step(c,backend)
 local n
 if c.nmi then c.nmi=false;n=R.interrupt(c,65530,false)
 elseif c.irqAny and band(c.p,4)==0 then n=R.interrupt(c,65534,false)
 else
  local pc=c.pc
  if backend ~= "interpreter" and pc >= 32768 then
   local f=c.g.blocks[c.prgB[math.floor(pc/8192)-3]+band(pc,8191)]
   if f then
    -- Block chain: blockTick drives cycles/PPU/peripherals per block and the
    -- chain unwinds to the scheduler when the slice budget is exhausted.
    -- R.slice (cycles) bounds chain latency; tests shrink it to align the
    -- block path with the per-instruction closure path.
    c.tickFinish=c.cycles+(R.slice or 2048);c.stats.block=c.stats.block+1
    return f(c)
   end
  end
  local op
  if pc>=32768 then
   op=string.byte(c.g.prg,c.prgB[math.floor(pc/8192)-3]+band(pc,0x1FFF)+1);c.open=op
  else op=R.read(c,pc) end
  local f=R.exec[op]
  if f then n=f(c);c.stats.ir=c.stats.ir+1
  else n=R.execute(c,op);c.stats.fallback=c.stats.fallback+1 end
 end
 n=n+c.stall;c.stall=0;c.cycles=c.cycles+n
 R.ppuTick(c,n*3);R.periphTick(c,n);return n
end
'''
PPU = r'''
local R=WoWNES_Runtime
local band,bor=bit.band,bit.bor
function R.NewPPU(g)
 local p={g=g,ctrl=0,mask=0,status=0,oamAddr=0,v=0,t=0,x=0,w=0,buffer=0,
  latch=0,nt={},pal={},oam={},dot=0,scanline=0,frame=0,dirty=true,rendering=false}
 for i=0,2047 do p.nt[i]=0 end
 for i=0,31 do p.pal[i]=0 end
 for i=0,255 do p.oam[i]=0 end
 return p
end
local function ntIndex(p,a)
 local off=(a-8192)%4096;local tableId=math.floor(off/1024)
 local mirroring=p.mapper.mirroring
 local bank=mirroring=="vertical" and tableId%2 or mirroring=="horizontal" and math.floor(tableId/2) or (mirroring=="one-screen-b" and 1 or 0)
 return bank*1024+off%1024
end
local function palIndex(a)
 local i=a%32;if i>=16 and i%4==0 then i=i-16 end;return i
end
function R.chrTile(p,t,table)
 if p.g.manifest.mapper~=23 then return table*256+t end
 return (p.mapper.chr[table*4+math.floor(t/64)+1]%128)*64+(t%64)
end
function R.ppuMemory(p,a)
 a=a%16384
 if a<8192 then
  local bank=math.floor(a/1024)+1
  if p.g.manifest.mapper==23 then a=(p.mapper.chr[bank]%128)*1024+(a%1024) end
  return string.byte(p.g.chr,a+1)
 elseif a<16128 then return p.nt[ntIndex(p,a)]
 else return p.pal[palIndex(a)] end
end
function R.ppuStore(p,a,v)
 a=a%16384
 if a>=16128 then p.pal[palIndex(a)]=band(v,63)
 elseif a>=8192 then p.nt[ntIndex(p,a)]=v end
 p.dirty=true
end
function R.ppuRead(c,r)
 local p=c.ppu;local v=p.latch
 if r==2 then
  v=bor(band(p.status,224),band(p.latch,31));p.status=band(p.status,127);p.w=0
 elseif r==4 then v=p.oam[p.oamAddr]
 elseif r==7 then
  local a=p.v%16384;local sample=R.ppuMemory(p,a)
  if a>=16128 then v=bor(sample,band(p.latch,192));p.buffer=R.ppuMemory(p,a-4096)
  else v=p.buffer;p.buffer=sample end
  p.v=(p.v+(band(p.ctrl,4)~=0 and 32 or 1))%32768
 end
 p.latch=v;return v
end
function R.ppuWrite(c,r,v)
 local p=c.ppu;p.latch=v;p.dirty=true
 if r==0 then
  local old=p.ctrl;p.ctrl=v;p.t=bor(band(p.t,29695),band(v,3)*1024)
  if band(old,128)==0 and band(v,128)~=0 and band(p.status,128)~=0 then c.nmi=true end
 elseif r==1 then p.mask=v;p.rendering=band(v,24)==24
 elseif r==3 then p.oamAddr=v
 elseif r==4 then p.oam[p.oamAddr]=v;p.oamAddr=(p.oamAddr+1)%256
 elseif r==5 then
  if p.w==0 then p.x=v%8;p.t=bor(band(p.t,32736),math.floor(v/8));p.w=1
  else p.t=bor(band(p.t,3103),math.floor(v/8)*32,(v%8)*4096);p.w=0 end
 elseif r==6 then
  if p.w==0 then p.t=bor(band(p.t,255),band(v,63)*256);p.w=1
  else p.t=bor(band(p.t,32512),v);p.v=p.t;p.w=0 end
 elseif r==7 then R.ppuStore(p,p.v,v);p.v=(p.v+(band(p.ctrl,4)~=0 and 32 or 1))%32768 end
end
function R.backgroundPixel(p,x,y)
 local sx=x+p.x+(p.t%32)*8
 local sy=y+math.floor(p.t/32)%32*8+math.floor(p.t/4096)%8
 local tableId=math.floor(p.t/1024)%4
 tableId=(tableId%2+math.floor(sx/256))%2+2*((math.floor(tableId/2)+math.floor(sy/240))%2)
 sx=sx%256;sy=sy%240
 local tx,ty=math.floor(sx/8),math.floor(sy/8)
 local base=8192+tableId*1024
 local tile=R.ppuMemory(p,base+ty*32+tx)
 local row=sy%8;local pattern=(band(p.ctrl,16)~=0 and 4096 or 0)+tile*16
 local lo,hi=R.ppuMemory(p,pattern+row),R.ppuMemory(p,pattern+row+8)
 local shift=7-sx%8
 local pixel=math.floor(lo/2^shift)%2+2*(math.floor(hi/2^shift)%2)
 local attr=R.ppuMemory(p,base+960+math.floor(ty/4)*8+math.floor(tx/4))
 local palette=math.floor(attr/2^((math.floor(ty/2)%2)*4+(math.floor(tx/2)%2)*2))%4
 return pixel,palette,tile
end
function R.spriteZero(p,line,fromDot,toDot)
 if band(p.mask,24)~=24 or band(p.status,64)~=0 then return end
 local y=p.oam[0]+1;local row=line-y
 local tall=band(p.ctrl,32)~=0
 if row<0 or row>(tall and 15 or 7) then return end
 local tile,attr,x=p.oam[1],p.oam[2],p.oam[3]
 if band(attr,128)~=0 then row=(tall and 15 or 7)-row end
 local tableId,pattern
 if tall then
  tableId=tile%2;tile=band(tile,254)+math.floor(row/8);row=row%8
  pattern=tableId*4096+tile*16
 else
  pattern=(band(p.ctrl,8)~=0 and 4096 or 0)+tile*16
 end
 for col=0,7 do
  local px=x+col;local dot=px+1
  if px<255 and dot>=fromDot and dot<=toDot and (px>=8 or band(p.mask,6)==6) then
   local shift=band(attr,64)~=0 and col or 7-col
   local value=math.floor(R.ppuMemory(p,pattern+row)/2^shift)%2+2*(math.floor(R.ppuMemory(p,pattern+row+8)/2^shift)%2)
   if value~=0 and R.backgroundPixel(p,px,line)~=0 then p.status=bor(p.status,64);return end
  end
 end
end
function R.ppuTick(c,dots)
 local p=c.ppu
 local target=p.dot+dots
 if target<=340 then
  -- Fast path: cannot cross a scanline boundary; events behave identically.
  if p.rendering and p.scanline<240 and band(p.status,64)==0 then R.spriteZero(p,p.scanline,p.dot+1,target) end
  if p.dot<1 and target>=1 then
   if p.scanline==241 then p.status=bor(p.status,128);if band(p.ctrl,128)~=0 then c.nmi=true end
   elseif p.scanline==261 then p.status=band(p.status,31) end
  end
  p.dot=target;return
 end
 while dots>0 do
  local endDot=math.min(340,p.dot+dots)
  if p.rendering and p.scanline<240 and band(p.status,64)==0 then R.spriteZero(p,p.scanline,p.dot+1,endDot) end
  if p.dot<1 and endDot>=1 then
   if p.scanline==241 then p.status=bor(p.status,128);if band(p.ctrl,128)~=0 then c.nmi=true end
   elseif p.scanline==261 then p.status=band(p.status,31) end
  end
  local used=math.min(dots,341-p.dot);p.dot=p.dot+used;dots=dots-used
  if p.dot==341 then p.dot=0;p.scanline=p.scanline+1
   if p.scanline==262 then p.scanline=0;p.frame=p.frame+1 end
  end
 end
end
'''
APU = r'''
local R=WoWNES_Runtime
local band=bit.band
local lengths={10,254,20,2,40,4,80,6,160,8,60,10,14,12,26,14,12,16,24,18,48,20,96,22,192,24,72,26,16,28,32,30}
function R.NewAPU() return {reg={},length={0,0,0,0},enable=0,clock=0,five=false,inhibit=false,irq=false,dmcIRQ=false,dmcStall=0} end
function R.apuWrite(c,a,v)
 local p=c.apu;p.reg[a]=v
 if a==16405 then
  p.enable=v;p.dmcIRQ=false
  for i=1,4 do if band(v,2^(i-1))==0 then p.length[i]=0 end end
 elseif a==16407 then
  p.five=band(v,128)~=0;p.inhibit=band(v,64)~=0;p.clock=0
  if p.inhibit then p.irq=false;c.irqAny=c.mapper.irq.pending or false end
 elseif a==16387 or a==16391 or a==16395 or a==16399 then
  local i=math.floor((a-16384)/4)+1
  if band(p.enable,2^(i-1))~=0 then p.length[i]=lengths[math.floor(v/8)+1] end
 end
end
function R.apuRead(c)
 local p=c.apu;local v=0
 for i=1,4 do if p.length[i]>0 then v=v+2^(i-1) end end
 if p.irq then v=v+64 end;if p.dmcIRQ then v=v+128 end
 p.irq=false;c.irqAny=c.mapper.irq.pending or false;return v
end
function R.apuTick(c,n)
 local p=c.apu;local old=p.clock;p.clock=p.clock+n
 local period=p.five and 37282 or 29830
 local function half()
  for i=1,4 do
   local reg=p.reg[16384+(i-1)*4] or 0
   local halt=band(reg,i==3 and 128 or 32)~=0
   if not halt and p.length[i]>0 then p.length[i]=p.length[i]-1 end
  end
 end
 if old<14913 and p.clock>=14913 then half() end
 if p.clock>=period then
  half();p.clock=p.clock-period
  if not p.five and not p.inhibit then p.irq=true;c.irqAny=true end
 end
 -- DMC DMA hook; sample playback and DMC IRQ timing are future work.
 if p.dmcStall>0 then c.stall=c.stall+p.dmcStall;p.dmcStall=0 end
end
'''
CONTROLLER = r'''
local R=WoWNES_Runtime
function R.NewPad() return {state={0,0},latch={0,0},index={0,0},strobe=false} end
function R.padWrite(c,v)
 local p=c.pad;local was=p.strobe;p.strobe=v%2==1
 if p.strobe or was then
  p.latch[1]=p.state[1];p.latch[2]=p.state[2];p.index[1]=0;p.index[2]=0
 end
end
function R.padRead(c,port)
 local p=c.pad;local v;local index=p.index[port]
 if p.strobe then v=p.state[port]%2
 elseif index>=8 then v=1
 else v=math.floor(p.latch[port]/2^index)%2;p.index[port]=index+1 end
 return bit.bor(bit.band(c.open,224),v)
end
function R.release(c,reason)
 c.running=false;c.pad=R.NewPad()
 if c.view then
  c.view:EnableKeyboard(false);c.view:SetPropagateKeyboardInput(true)
  if c.view.hint then c.view.hint:Hide() end
  if c.view.fps then c.view.fps:Hide() end
 end
end
'''
RENDERER = r'''
local R=WoWNES_Runtime
local band=bit.band
-- Fixed pool: 33*31 background and 64 sprites, three mask layers each.
local palette={0x666666,0x002A88,0x1412A7,0x3B00A4,0x5C007E,0x6E0040,0x6C0600,0x561D00,0x333500,0x0B4800,0x005200,0x004F08,0x00404D,0,0,0,
0xADADAD,0x155FD9,0x4240FF,0x7527FE,0xA01ACC,0xB71E7B,0xB53120,0x994E00,0x6B6D00,0x388700,0x0C9300,0x008F32,0x007C8D,0,0,0,
0xFFFEFF,0x64B0FF,0x9290FF,0xC676FF,0xF36AFF,0xFE6ECC,0xFE8170,0xEA9E22,0xBCBE00,0x88D800,0x5CE430,0x45E082,0x48CDDE,0x4F4F4F,0,0,
0xFFFEFF,0xC0DFFF,0xD3D2FF,0xE8C8FF,0xFBC2FF,0xFEC4EA,0xFECCC5,0xF7D8A5,0xE4E594,0xCFEF96,0xBDF4AB,0xB3F3CC,0xB5EBF2,0xB8B8B8,0,0}
local function color(index)
 local v=palette[index%64+1];return math.floor(v/65536)/255,math.floor(v/256)%256/255,v%256/255
end
function R.NewView(c)
 local f=CreateFrame("Frame",nil,UIParent);f:SetSize(512,480);f:SetPoint("CENTER")
 f:SetClipsChildren(false);f:EnableKeyboard(false);f:SetPropagateKeyboardInput(true)
 local bg=f:CreateTexture(nil,"BACKGROUND");bg:SetAllPoints();f.bg=bg
 f.hint=f:CreateFontString(nil,"OVERLAY")
 f.hint:SetFont("Fonts\\FRIZQT__.TTF",14,"OUTLINE")
 f.hint:SetPoint("TOP",f,"BOTTOM",0,-8)
 f.hint:SetText("Z=A  X=B  ENTER=START  ARROWS=MOVE  ESC=EXIT")
 f.hint:SetTextColor(1,0.82,0.2,1);f.hint:SetShadowColor(0,0,0,1);f.hint:SetShadowOffset(1,-1);f.hint:Show()
 f.fps=f:CreateFontString(nil,"OVERLAY")
 f.fps:SetFont("Fonts\\FRIZQT__.TTF",12,"OUTLINE")
 f.fps:SetPoint("TOPLEFT",f,"TOPLEFT",6,-6)
 f.fps:SetText("");f.fps:SetTextColor(0.3,1,0.3,1)
 f.fps:SetShadowColor(0,0,0,1);f.fps:SetShadowOffset(1,-1);f.fps:Show()
 f.pool={};f.cache={}
 local probe=f:CreateTexture(nil,"ARTWORK")
 probe:SetTexture("Interface\\AddOns\\"..c.g.name.."\\textures\\chr-mask-1.tga")
 f.pixelFallback=not probe:GetTexture();probe:Hide()
 f.pixelPool={};f.pixelCache={};f.nextPixelRender=0
 f.pixelStats={renders=0,totalMs=0,maxMs=0,lastMs=0,segments=0}
 if not f.pixelFallback then
 for i=1,1215 do
  local slot={}
  for layer=1,3 do
   local t=f:CreateTexture(nil,i<=1023 and "ARTWORK" or "OVERLAY",nil,layer)
   t:SetSize(16,16);t:SetTexture("Interface\\AddOns\\"..c.g.name.."\\textures\\chr-mask-"..layer..".tga")
   t:SetHorizTile(false);t:SetVertTile(false);t:Hide();slot[layer]=t
  end
  f.pool[i]=slot
 end
 end
 local keys={Z=1,X=2,RSHIFT=4,ENTER=8,UP=16,DOWN=32,LEFT=64,RIGHT=128}
 f:SetScript("OnKeyDown",function(self,key)
  if key=="ESCAPE" then R.inputLog("keyDown key=ESCAPE");R.release(c,"escape");return end
  local mask=keys[key];if mask then local old=c.pad.state[1];local new=bit.bor(old,mask);c.pad.state[1]=new;R.inputLog(string.format("keyDown key=%s mask=%d old=%d new=%d",key,mask,old,new)) end
 end)
 f:SetScript("OnKeyUp",function(self,key)
  local mask=keys[key];if mask then local old=c.pad.state[1];local new=band(old,255-mask);c.pad.state[1]=new;R.inputLog(string.format("keyUp key=%s mask=%d old=%d new=%d",key,mask,old,new)) end
 end)
 f:SetScript("OnHide",function(self) self.hint:Hide();R.release(c,"hide") end)
 f:RegisterEvent("PLAYER_REGEN_DISABLED");f:SetScript("OnEvent",function() R.release(c,"combat") end)
 c.view=f;return f
end
local function submit(c,index,tile,pal,x,y,flipX,flipY,visible,behind)
 local f=c.view;local map=c.g.tiles[tile+1]
 if not map then visible=false end
 local p=c.ppu;local colors={}
 for layer=1,3 do colors[layer]=R.ppuMemory(p,16128+pal*4+layer) end
 local key=table.concat({tile,pal,x,y,flipX and 1 or 0,flipY and 1 or 0,visible and 1 or 0,behind and 1 or 0,colors[1],colors[2],colors[3]},":")
 if f.cache[index]==key then return end;f.cache[index]=key
 for layer=1,3 do
  local t=f.pool[index][layer]
  if not visible or band(map.empty,2^(layer-1))~=0 then t:Hide()
  else
   local uv=map.uv;local l,r,top,bottom=uv[1],uv[2],uv[3],uv[4]
   if flipX then l,r=r,l end;if flipY then top,bottom=bottom,top end
   t:SetTexCoord(l,r,top,bottom);t:ClearAllPoints();t:SetPoint("TOPLEFT",f,"TOPLEFT",x*2,-y*2)
   t:SetVertexColor(color(colors[layer]));t:SetDrawLayer(behind and "BORDER" or (index<=1023 and "ARTWORK" or "OVERLAY"),layer);t:Show()
  end
 end
end
function R.renderPixels(c)
 local p,f=c.ppu,c.view;local stats=f.pixelStats;local now=GetTime()
 if now<f.nextPixelRender then return end
 f.nextPixelRender=now+0.1
 local started=debugprofilestop()
 local pixels,solid,claimed=f.pixelPixels or {},f.pixelSolid or {},f.pixelClaimed or {}
 f.pixelPixels=pixels;f.pixelSolid=solid;f.pixelClaimed=claimed
 local backdrop=R.ppuMemory(p,16128)
 local background=band(p.mask,8)~=0;local left=band(p.mask,2)~=0
 local scrollX=p.x+(p.t%32)*8
 local scrollY=math.floor(p.t/32)%32*8+math.floor(p.t/4096)%8
 local tableId=math.floor(p.t/1024)%4
 local patternBase=band(p.ctrl,16)~=0 and 4096 or 0
 for y=0,239 do
  local sy=y+scrollY;local ty=math.floor(sy%240/8)
  local tableY=2*((math.floor(tableId/2)+math.floor(sy/240))%2)
  local row=sy%240%8;local x=0
  while x<256 do
   local sx=x+scrollX;local offset=sx%8
   local last=math.min(256,x+8-offset)
   local lo,hi,pal=0,0,0
   if background then
    local tx=math.floor(sx%256/8)
    local base=8192+((tableId%2+math.floor(sx/256))%2+tableY)*1024
    local tile=R.ppuMemory(p,base+ty*32+tx)
    local pattern=patternBase+tile*16+row
    lo=R.ppuMemory(p,pattern);hi=R.ppuMemory(p,pattern+8)
    local attr=R.ppuMemory(p,base+960+math.floor(ty/4)*8+math.floor(tx/4))
    pal=math.floor(attr/2^((math.floor(ty/2)%2)*4+(math.floor(tx/2)%2)*2))%4
   end
   for px=x,last-1 do
    local i=y*256+px+1;local v=0
    if background and (px>=8 or left) then
     local shift=7-offset-(px-x)
     v=math.floor(lo/2^shift)%2+2*(math.floor(hi/2^shift)%2)
    end
    solid[i]=v~=0;claimed[i]=false
    pixels[i]=v==0 and backdrop or R.ppuMemory(p,16128+pal*4+v)
   end
   x=last
  end
 end
 local tall=band(p.ctrl,32)~=0;local height=tall and 16 or 8
 if band(p.mask,16)~=0 then for s=0,63 do
  local o=s*4;local sy=p.oam[o]+1;local sx=p.oam[o+3]
  local tile,attr=p.oam[o+1],p.oam[o+2]
  if sx<256 and sy<240 and sy+height>0 then
   for y=math.max(0,sy),math.min(239,sy+height-1) do
    local row=y-sy;if band(attr,128)~=0 then row=height-1-row end
    local pattern
    if tall then pattern=tile%2*4096+(band(tile,254)+math.floor(row/8))*16+row%8
    else pattern=(band(p.ctrl,8)~=0 and 4096 or 0)+tile*16+row end
    local lo,hi=R.ppuMemory(p,pattern),R.ppuMemory(p,pattern+8)
    for x=math.max(0,sx),math.min(255,sx+7) do
     local shift=band(attr,64)~=0 and x-sx or 7-(x-sx)
     local v=math.floor(lo/2^shift)%2+2*(math.floor(hi/2^shift)%2)
     local i=y*256+x+1
     if v~=0 and not claimed[i] and (x>=8 or band(p.mask,4)~=0) then
      claimed[i]=true
      if band(attr,32)==0 or not solid[i] then pixels[i]=R.ppuMemory(p,16144+band(attr,3)*4+v) end
     end
    end
   end
  end
 end end
 local count=0
 for y=0,239 do
  local x=0
  while x<256 do
   local value=pixels[y*256+x+1];local last=x+1
   while last<256 and pixels[y*256+last+1]==value do last=last+1 end
   count=count+1;local key=x..":"..y..":"..last..":"..value
   local t=f.pixelPool[count]
   if not t then t=f:CreateTexture(nil,"ARTWORK");f.pixelPool[count]=t end
   if f.pixelCache[count]~=key then
    t:ClearAllPoints();t:SetPoint("TOPLEFT",f,"TOPLEFT",x*2,-y*2)
    t:SetSize((last-x)*2,2);t:SetColorTexture(color(value));t:Show();f.pixelCache[count]=key
   end
   x=last
  end
 end
 for i=count+1,(f.pixelCount or 0) do f.pixelPool[i]:Hide();f.pixelCache[i]=nil end
 f.pixelCount=count;f.pixelFrame=p.frame;f.pixelRenders=(f.pixelRenders or 0)+1
 p.dirty=false
 local elapsed=debugprofilestop()-started
 stats.renders=stats.renders+1;stats.totalMs=stats.totalMs+elapsed
 stats.lastMs=elapsed;stats.maxMs=math.max(stats.maxMs,elapsed);stats.segments=count
end
function R.render(c)
 local p=c.ppu;if not c.view or not p.dirty then return end
 local f=c.view
 if f.pixelFallback then return R.renderPixels(c) end
 f.bg:SetColorTexture(color(R.ppuMemory(p,16128)))
 for row=0,30 do for col=0,32 do
  local _,pal,tile=R.backgroundPixel(p,col*8-p.x,row*8)
  tile=R.chrTile(p,tile,band(p.ctrl,16)~=0 and 1 or 0)
  submit(c,row*33+col+1,tile,pal,col*8-p.x,row*8,false,false,band(p.mask,8)~=0,false)
 end end
 for i=0,63 do
  local offset=i*4;local attr=p.oam[offset+2];local rawTile=p.oam[offset+1]
  local pal=4+band(attr,3);local x=p.oam[offset+3];local y=p.oam[offset]+1
  local flipX=band(attr,64)~=0;local flipY=band(attr,128)~=0
  local visible=band(p.mask,16)~=0;local behind=band(attr,32)~=0
  if band(p.ctrl,32)==0 then
   submit(c,1024+i,R.chrTile(p,rawTile,band(p.ctrl,8)~=0 and 1 or 0),pal,x,y,flipX,flipY,visible,behind)
  else
   local tableId=rawTile%2;local base=band(rawTile,254)
   local top=flipY and base+1 or base;local bottom=flipY and base or base+1
   submit(c,1024+i,R.chrTile(p,top,tableId),pal,x,y,flipX,flipY,visible,behind)
   submit(c,1088+i,R.chrTile(p,bottom,tableId),pal,x,y+8,flipX,flipY,visible,behind)
  end
 end
 p.dirty=false
end
'''
SCHEDULER = r'''
local R=WoWNES_Runtime
function R.Start(romId)
 if InCombatLockdown() then return false,"combat" end
 local g=R.games[romId];if not g then return false,"unknown ROM" end
 if R.active then R.release(R.active,"restart");if R.active.view then R.active.view:Hide() end end
 local c=R:New(g);R.active=c;R.NewView(c);c.running=true;c.debt=0;c.target=c.cycles;c.renderedFrame=-1
 c.view.fpsSample={t=GetTime(),frames=c.ppu.frame}
 c.view:EnableKeyboard(true);c.view:SetPropagateKeyboardInput(false)
 c.view:SetScript("OnUpdate",function(self,elapsed)
  if not c.running then return end
  c.debt=math.min(c.debt+elapsed,3/60.0988)
  local work=math.floor(c.debt*1789773);if work<=0 then return end
  local finish=c.cycles+work;local start=debugprofilestop();local before=c.cycles
  local ok,err=pcall(function()
   while c.cycles<finish and c.cycles-before<89342 and debugprofilestop()-start<12 do R.step(c) end
  end)
  if not ok then R.release(c);c.error=err;return end
  c.debt=math.max(0,c.debt-(c.cycles-before)/1789773)
  if c.ppu.frame~=c.renderedFrame then
   local now=GetTime()
   if now-(c.lastRenderAt or 0)>=0.03 then
    local rt=debugprofilestop();R.render(c);c.view.lastRenderMs=debugprofilestop()-rt
    c.renderedFrame=c.ppu.frame;c.lastRenderAt=now
   end
  end
  local s=c.view.fpsSample;local now=GetTime()
  if now-s.t>=0.5 then
   c.view.fps:SetText(string.format("%.1f FPS  %.1fms render",(c.ppu.frame-s.frames)/(now-s.t),c.view.lastRenderMs or 0))
   s.t=now;s.frames=c.ppu.frame
  end
 end)
 return true
end
function R.OnUnload()
 if R.active then R.release(R.active);if R.active.view then R.active.view:SetScript("OnUpdate",nil);R.active.view:Hide() end end
end
SLASH_WOWNES1="/wownes"
SlashCmdList.WOWNES=function(id)
 if id=="stop" then if R.active then R.release(R.active) end;return end
 if id=="" then for key in pairs(R.games) do print("WOW_NES: /wownes "..key) end;return end
 local ok,err=R.Start(id);if not ok then print("WOW_NES: "..tostring(err)) end
end
'''


_BRANCH = dict(BPL=(128, "=="), BMI=(128, "~="), BVC=(64, "=="), BVS=(64, "~="),
               BCC=(1, "=="), BCS=(1, "~="), BNE=(2, "=="), BEQ=(2, "~="))


def _shift(name):
    if name == "ASL":
        return "c.p=flag(c.p,1,value>=128);value=value*2;"
    if name == "ROL":
        return "c.p=flag(c.p,1,value>=128);value=value*2+carry;"
    if name == "LSR":
        return "c.p=flag(c.p,1,value%2==1);value=floor(value/2);"
    if name == "ROR":
        return "c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;"
    if name == "INC":
        return "value=value+1;"
    return "value=value-1;"


def _semantics(name, mode):
    if name in ("LDA", "LDX", "LDY"):
        reg = {"LDA": "c.a", "LDX": "c.x", "LDY": "c.y"}[name]
        return "value=value%256;c.p=nz(c.p,value);" + reg + "=value"
    if name in ("STA", "STX", "STY"):
        reg = {"STA": "c.a", "STX": "c.x", "STY": "c.y"}[name]
        return "write(c,addr," + reg + ")"
    if name == "ORA":
        return "c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a)"
    if name == "AND":
        return "c.a=band(c.a,value)%256;c.p=nz(c.p,c.a)"
    if name == "EOR":
        return "c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a)"
    if name == "ADC":
        return ("local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;"
                "c.p=flag(c.p,1,sum>255);"
                "c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);"
                "c.p=nz(c.p,result);c.a=result")
    if name == "SBC":
        return ("local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;"
                "c.p=flag(c.p,1,sum>255);"
                "c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);"
                "c.p=nz(c.p,result);c.a=result")
    if name in ("CMP", "CPX", "CPY"):
        reg = {"CMP": "c.a", "CPX": "c.x", "CPY": "c.y"}[name]
        return "c.p=flag(c.p,1," + reg + ">=value);local d=(" + reg + "-value)%256;c.p=nz(c.p,d)"
    if name == "BIT":
        return ("c.p=flag(flag(flag(c.p,2,band(c.a,value)==0),64,band(value,64)~=0),"
                "128,band(value,128)~=0)")
    if name in ("ASL", "LSR", "ROL", "ROR", "INC", "DEC"):
        if mode == "acc":
            return ("local carry=band(c.p,1)~=0 and 1 or 0;" + _shift(name) +
                    "value=value%256;c.p=nz(c.p,value);c.a=value")
        return ("local old=value;local carry=band(c.p,1)~=0 and 1 or 0;" + _shift(name) +
                "value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value)")
    if name == "PHA":
        return "push(c,c.a)"
    if name == "PHP":
        return "push(c,bor(c.p,48))"
    if name == "PLA":
        return "read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a)"
    if name == "PLP":
        return "read(c,256+c.s);c.p=bor(band(pop(c),239),32)"
    if name == "TAX":
        return "c.x=c.a%256;c.p=nz(c.p,c.x)"
    if name == "TAY":
        return "c.y=c.a%256;c.p=nz(c.p,c.y)"
    if name == "TXA":
        return "c.a=c.x%256;c.p=nz(c.p,c.a)"
    if name == "TYA":
        return "c.a=c.y%256;c.p=nz(c.p,c.a)"
    if name == "TSX":
        return "c.x=c.s%256;c.p=nz(c.p,c.x)"
    if name == "TXS":
        return "c.s=c.x"
    if name == "INX":
        return "c.x=(c.x+1)%256;c.p=nz(c.p,c.x)"
    if name == "INY":
        return "c.y=(c.y+1)%256;c.p=nz(c.p,c.y)"
    if name == "DEX":
        return "c.x=(c.x-1)%256;c.p=nz(c.p,c.x)"
    if name == "DEY":
        return "c.y=(c.y-1)%256;c.p=nz(c.p,c.y)"
    if name == "CLC":
        return "c.p=flag(c.p,1,false)"
    if name == "SEC":
        return "c.p=flag(c.p,1,true)"
    if name == "CLI":
        return "c.p=flag(c.p,4,false)"
    if name == "SEI":
        return "c.p=flag(c.p,4,true)"
    if name == "CLD":
        return "c.p=flag(c.p,8,false)"
    if name == "SED":
        return "c.p=flag(c.p,8,true)"
    if name == "CLV":
        return "c.p=flag(c.p,64,false)"
    if name == "NOP":
        return ""
    if name == "LAX":
        return "value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value"
    if name == "SAX":
        return "write(c,addr,band(c.a,c.x))"
    if name == "DCP":
        return ("local old=value;value=(value-1)%256;"
                "c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);"
                "write(c,addr,old);write(c,addr,value)")
    if name == "ISB":
        return ("local old=value;value=(value+1)%256;local b=255-value;"
                "local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;"
                "c.p=flag(c.p,1,sum>255);"
                "c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);"
                "c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value)")
    if name == "SLO":
        return ("local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;"
                "c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);"
                "write(c,addr,old);write(c,addr,value)")
    if name == "RLA":
        return ("local old=value;local carry=band(c.p,1)~=0 and 1 or 0;"
                "c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;"
                "c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);"
                "write(c,addr,old);write(c,addr,value)")
    if name == "SRE":
        return ("local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);"
                "c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);"
                "write(c,addr,old);write(c,addr,value)")
    if name == "RRA":
        return ("local old=value;local carry=band(c.p,1)~=0 and 1 or 0;"
                "c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;"
                "local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;"
                "c.p=flag(c.p,1,sum>255);"
                "c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);"
                "c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value)")
    if name == "RTS":
        return ("read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;"
                "read(c,ret);c.pc=(ret+1)%65536")
    if name == "RTI":
        return ("read(c,256+c.s);c.p=bor(band(pop(c),239),32);"
                "local lo=pop(c);local hi=pop(c);c.pc=lo+256*hi")
    raise ValueError("UNSUPPORTED_OPNAME " + name)


def _exec_body(name, mode, length, cycles, page):
    if name == "JSR":
        return ("local pc=c.pc;local lo=read(c,(pc+1)%65536);local ret=(pc+2)%65536;"
                "read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);"
                "local hi=read(c,ret);c.pc=lo+256*hi;return 6")
    if name == "BRK":
        return ("local pc=c.pc;c.pc=(pc+1)%65536;read(c,c.pc);c.pc=(c.pc+1)%65536;"
                "return R.interrupt(c,65534,true)")
    if mode == "rel":
        mask, cmp = _BRANCH[name]
        return ("local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;"
                "if band(c.p," + str(mask) + ")" + cmp + "0 then "
                "local target=(c.pc+(operand<128 and operand or operand-256))%65536;"
                "read(c,c.pc);"
                "if floor(target/256)~=floor(c.pc/256) then "
                "read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;"
                "c.pc=target;return 3 end;return 2")
    body = ["local pc=c.pc"]
    if length > 1:
        body.append("local operand=read(c,(pc+1)%65536)")
        if length > 2:
            body.append("operand=operand+256*read(c,(pc+2)%65536)")
    if mode in ("imp", "acc"):
        body.append("read(c,(pc+1)%65536)")
    body.append("c.pc=(pc+" + str(length) + ")%65536")
    ret = "return " + str(cycles)
    if mode == "acc":
        body.append("local value=c.a")
    elif mode == "imm":
        body.append("local value=operand")
    elif mode == "zp":
        body.append("local addr=operand")
    elif mode == "zpx":
        body.append("read(c,operand);local addr=(operand+c.x)%256")
    elif mode == "zpy":
        body.append("read(c,operand);local addr=(operand+c.y)%256")
    elif mode == "abs":
        if name == "JMP":
            body.append("c.pc=operand;return 3")
            return ";".join(body)
        body.append("local addr=operand")
    elif mode == "ind":
        body.append("local addr=read(c,operand)+256*read(c,floor(operand/256)*256+(operand+1)%256);"
                    "c.pc=addr;return 5")
        return ";".join(body)
    elif mode in ("abx", "aby"):
        reg = "c.x" if mode == "abx" else "c.y"
        body.append("local base=operand;local addr=(base+" + reg + ")%65536")
        if page:
            body.append("local cyc=" + str(cycles) +
                        ";if floor(base/256)~=floor(addr/256) then cyc=cyc+1;"
                        "read(c,floor(base/256)*256+addr%256) end")
            ret = "return cyc"
        else:
            body.append("read(c,floor(base/256)*256+addr%256)")
    elif mode == "izx":
        body.append("read(c,operand);local z=(operand+c.x)%256;"
                    "local addr=read(c,z)+256*read(c,(z+1)%256)")
    elif mode == "izy":
        body.append("local base=read(c,operand)+256*read(c,(operand+1)%256);"
                    "local addr=(base+c.y)%65536")
        if page:
            body.append("local cyc=" + str(cycles) +
                        ";if floor(base/256)~=floor(addr/256) then cyc=cyc+1;"
                        "read(c,floor(base/256)*256+addr%256) end")
            ret = "return cyc"
        else:
            body.append("read(c,floor(base/256)*256+addr%256)")
    store = name in ("STA", "STX", "STY", "SAX")
    if mode not in ("imp", "acc", "imm") and not store and name != "JMP":
        body.append("local value=read(c,addr)")
    body.append(_semantics(name, mode))
    body.append(ret)
    return ";".join(part for part in body if part)


def exec_table(ops):
    """Per-opcode specialized closures replacing R.execute dispatch chains.

    Each closure assumes the opcode byte was already fetched from c.pc by the
    caller (R.step) and performs the remaining bus reads exactly like R.execute.
    """
    parts = ["local band,bor,bxor=bit.band,bit.bor,bit.bxor",
             "local floor=math.floor",
             "local read,write,push,pop=R.read,R.write,R.push,R.pop",
             "local flag,nz=R.flag,R.nz",
             "local E={}"]
    for op in sorted(ops):
        name, mode, length, cycles, page = ops[op]
        parts.append("E[%d]=function(c) %s end" % (op, _exec_body(name, mode, length, cycles, page)))
    parts.append("R.exec=E")
    return "\n".join(parts) + "\n"


# --- Static basic-block compilation (mapper-aware, physical-address keyed) ---
#
# A block is keyed by PRG physical address. Every operand byte baked into the
# block matches the bytes the CPU fetches through the live bank layout, because
# a lookup re-resolves banks whenever a write can hit a PRG bank register and
# whenever control enters a switchable slot. Exits whose target physical
# address is compile-time deterministic (same-bank fall/branch targets, fixed
# slot $C000/$E000 targets) tail-call the next block function directly; every
# other exit goes through R.blockLookup, which re-resolves the layout.

BLOCK_HEADER = ("local _,G=...;local R=WoWNES_Runtime\n"
                "local band,bor,bxor=bit.band,bit.bor,bit.bxor\n"
                "local floor=math.floor\n"
                "local read,write,push,pop=R.read,R.write,R.push,R.pop\n"
                "local flag,nz=R.flag,R.nz\n"
                "local interrupt=R.interrupt\n"
                "local blockTick,blockLookup=R.blockTick,R.blockLookup\n"
                "local P=G.blocks\n")


def _prg_bank_write(name, mode, operand):
    """True when the instruction may write a VRC4 PRG bank register ($8000-$8FFF/$A000-$AFFF)."""
    if name not in ("STA", "STX", "STY", "SAX", "ASL", "LSR", "ROL", "ROR", "INC", "DEC",
                    "DCP", "ISB", "SLO", "RLA", "SRE", "RRA"):
        return False
    if mode in ("zp", "zpx", "zpy", "izx", "acc", "imp", "imm"):
        return False
    if mode in ("izy", "aby"):
        return True  # effective address is fully runtime-defined
    if mode in ("abs", "abx"):
        lo, hi = operand, operand + 255
        return any(not (hi < a or lo > b) for a, b in ((0x8000, 0x8FFF), (0xA000, 0xAFFF)))
    return False


def _build_block(rom, phys, entry_set, instr_set, limit=128):
    """Linear scan from block entry `phys` until a block terminator.

    Terminators: flow instructions (rel/JSR/JMP/RTS/RTI/BRK), possible PRG bank
    register writes, the next block entry, an unreachable instruction, the
    8 KiB bank window edge (one spare byte is kept so every dummy fetch stays
    inside the same bank), or the block length limit (keeps per-block tick
    latency bounded; the cut successor is returned so the caller can register
    it as a new entry). Returns (block_or_None, cut_successor_or_None).
    """
    from wow_nes import OPS
    bank_base = phys & ~0x1FFF
    off = phys & 0x1FFF
    prg = rom.prg
    instrs = []
    total = 0
    exit_ = None
    cut = None
    while True:
        p = phys + total
        if (p & ~0x1FFF) != bank_base or p not in instr_set:
            exit_ = ("fall", None)
            break
        op = prg[p]
        meta = OPS.get(op)
        if meta is None:
            exit_ = ("fall", None)
            break
        name, mode, length, cycles, page = meta
        if off + total + length > 8191:
            exit_ = ("fall", None)
            break
        if total and total + length > limit:
            # Length cap: cut here; the caller registers the successor as a new
            # entry so the runtime keeps a direct call instead of a lookup.
            cut = phys + total
            exit_ = ("fall", cut)
            break
        if mode == "rel":
            disp = prg[p + 1]
            disp = disp if disp < 128 else disp - 256
            t_pos = off + total + 2 + disp
            t_phys = bank_base + t_pos if 0 <= t_pos < 8192 else None
            if t_phys is not None and t_phys not in entry_set:
                t_phys = None
            f_phys = phys + total + 2
            exit_ = ("branch", _BRANCH[name][0], _BRANCH[name][1], disp, t_phys,
                     f_phys if f_phys in entry_set else None)
            total += 2
            break
        operand = prg[p + 1] if length > 1 else 0
        if length > 2:
            operand |= prg[p + 2] << 8
        fixed_from = 0x8000 if rom.mapper == 0 else 0xC000
        if name == "JSR":
            t_phys = None
            if operand >= fixed_from:
                tp = rom.physical(operand)
                if tp in entry_set:
                    t_phys = tp
            exit_ = ("jsr", operand, t_phys)
            total += 3
            break
        if name == "JMP":
            if mode == "abs":
                t_phys = None
                if operand >= fixed_from:
                    tp = rom.physical(operand)
                    if tp in entry_set:
                        t_phys = tp
                exit_ = ("jmp", operand, t_phys)
            else:
                exit_ = ("jmpind", operand)
            total += 3
            break
        if name in ("RTS", "RTI", "BRK"):
            exit_ = (name.lower(),)
            total += length
            break
        instrs.append((total, op, operand))
        total += length
        if _prg_bank_write(name, mode, operand):
            exit_ = ("fall", None)
            break
        if phys + total in entry_set:
            exit_ = ("fall", phys + total)
            break
    if not instrs and exit_[0] == "fall" and exit_[1] is None:
        return None, cut
    return dict(instrs=instrs, exit=exit_, total=total, entry_off=off,
                bank_base=bank_base), cut


def collect_blocks(rom, cancel=lambda: False):
    """Discover every runtime-reachable block entry across all bank layouts.

    Mapper 23 switchable slots ($8000/$A000) can map any bank at runtime, so
    the analyzer runs once per (prg0, prg1) layout combination and the union
    of control-flow entry points is taken in physical address space. Blocks
    are keyed by physical address, so distinct layouts reaching the same
    physical byte sequence share one block function.

    Only necessary entries become block starts: vectors, branch targets (both
    ways), JSR/JMP targets, JSR return points, and the successors of PRG bank
    writes and window-edge instructions (where a block would be cut). Plain
    fall-through successors stay inside the preceding block via direct calls.
    """
    from wow_nes import Cancelled, ConversionError, analyze
    layouts = [None]
    if rom.mapper == 23:
        nb = len(rom.prg) // 8192
        layouts = [{"prg0": a, "prg1": b} for a in range(nb) for b in range(nb)]
    entry_phys = set()
    instr_phys = set()
    for state in layouts:
        if cancel():
            raise Cancelled()
        cfg = analyze(rom, cancel, state)
        entry_pcs = set(rom.vectors.values())
        for pc, ins in cfg["instructions"].items():
            name, mode, length = ins.meta[0], ins.meta[1], ins.meta[2]
            nxt = (pc + length) & 0xffff
            if mode == "rel":
                disp = ins.operand if ins.operand < 128 else ins.operand - 256
                entry_pcs.add(nxt)
                entry_pcs.add((nxt + disp) & 0xffff)
            elif name == "JSR":
                entry_pcs.add(ins.operand)
                entry_pcs.add(nxt)
            elif name == "JMP":
                if mode == "abs":
                    entry_pcs.add(ins.operand)
            elif name not in ("RTS", "RTI", "BRK"):
                # Fall-through stays inside the block unless the block is cut
                # right after this instruction (bank write or window edge).
                if _prg_bank_write(name, mode, ins.operand) or (pc & 0x1FFF) + length > 8191:
                    entry_pcs.add(nxt)
        for pc in entry_pcs:
            try:
                entry_phys.add(rom.physical(pc, state))
            except ConversionError:
                pass  # OUTSIDE_ROM entry: no physical block
        for pc in cfg["instructions"]:
            instr_phys.add(rom.physical(pc, state))
    blocks = {}
    queue = sorted(entry_phys)
    while queue:
        if cancel():
            raise Cancelled()
        phys = queue.pop()
        if phys in blocks:
            continue
        blk, cut = _build_block(rom, phys, entry_phys, instr_phys)
        if blk is not None:
            blocks[phys] = blk
        if cut is not None and cut not in entry_phys:
            entry_phys.add(cut)
            queue.append(cut)
    # An entry whose bytes are not valid instructions yields no block function;
    # direct tail-calls to such entries must degrade to runtime lookups.
    for blk in blocks.values():
        exit_ = blk["exit"]
        kind = exit_[0]
        if kind in ("fall", "jmp", "jsr"):
            if exit_[-1] is not None and exit_[-1] not in blocks:
                blk["exit"] = exit_[:-1] + (None,)
        elif kind == "branch":
            mask, cmp_, disp, t_phys, f_phys = exit_[1], exit_[2], exit_[3], exit_[4], exit_[5]
            if (t_phys is not None and t_phys not in blocks) or \
               (f_phys is not None and f_phys not in blocks):
                blk["exit"] = ("branch", mask, cmp_, disp,
                               t_phys if t_phys is None or t_phys in blocks else None,
                               f_phys if f_phys is None or f_phys in blocks else None)
    return blocks


def _block_lua(rom, phys, blk, ops):
    """Render one block function for physical address `phys`."""
    prg = rom.prg
    lines = ["P[%d]=function(c)" % phys, " local k=0"]
    for delta, op, operand in blk["instrs"]:
        lines.append(" " + _block_stmt_inline(ops[op], operand, prg, phys + delta))
    lines.append(_block_exit_lua(blk, prg, phys))
    lines.append("end")
    return "\n".join(lines) + "\n"


def _block_stmt_inline(meta, operand, prg, i_phys):
    """One non-flow instruction wrapped in do..end.

    Every instruction gets its own lexical scope so Lua recycles the local
    slots (blocks may otherwise exceed the 200-local limit). Cycles
    accumulate directly into the block-level `k`. Operand fetches from PRG
    become compile-time constants (the block never crosses a bank window);
    bus reads with side effects (RAM/PPU/pad) stay as read() calls exactly
    like the closure interpreter.
    """
    name, mode, length, cycles, page = meta
    parts = []
    add = str(cycles)
    if mode == "imm":
        v = prg[i_phys + 1]
        parts.append("local value=%d;c.open=%d" % (v, v))
    elif mode in ("imp", "acc"):
        v = prg[i_phys + 1]
        parts.append("c.open=%d" % v)
        if mode == "acc":
            parts.append("local value=c.a")
    else:
        if mode == "zp":
            parts.append("local addr=%d" % operand)
        elif mode in ("zpx", "zpy"):
            reg = "c.x" if mode == "zpx" else "c.y"
            parts.append("read(c,%d);local addr=(%d+%s)%%256" % (operand, operand, reg))
        elif mode == "abs":
            parts.append("c.open=%d;local addr=%d" % (prg[i_phys + 2], operand))
        elif mode in ("abx", "aby"):
            reg = "c.x" if mode == "abx" else "c.y"
            parts.append("c.open=%d;local base=%d;local addr=(base+%s)%%65536" %
                         (prg[i_phys + 2], operand, reg))
        elif mode == "izx":
            parts.append("read(c,%d);local z=(%d+c.x)%%256;"
                         "local addr=read(c,z)+256*read(c,(z+1)%%256)" % (operand, operand))
        elif mode == "izy":
            parts.append("local base=read(c,%d)+256*read(c,(%d+1)%%256);local addr=(base+c.y)%%65536" %
                         (operand, operand))
        if mode in ("abx", "aby", "izy") and page:
            parts.append("if floor(base/256)~=floor(addr/256) then "
                         "read(c,floor(base/256)*256+addr%256);k=k+1 end")
        elif mode in ("abx", "aby", "izy") and not page:
            parts.append("read(c,floor(base/256)*256+addr%256)")
        store = name in ("STA", "STX", "STY", "SAX")
        if not store:
            parts.append("local value=read(c,addr)")
    # Semantics apply to EVERY mode: imm/acc reference the `value` local their
    # fetch path defines; imp instructions only touch registers/flags. Missing
    # this for imm/imp/acc silently turned LDA #/INX/SEC into bare cycle no-ops.
    parts.append(_semantics(name, mode))
    # Lua 5.1 rejects ';;' (empty statement); NOP-style empty semantics drop out.
    body = ";".join(p for p in parts if p)
    if body:
        return "do %s;k=k+%s end" % (body, add)
    return "do k=k+%s end" % add


def _tick_then(direct):
    """Slice-budget + interrupt check shared by every block exit.

    st==1: slice budget exhausted, unwind to the scheduler; st==2: interrupt
    pending, blockLookup injects it and continues the chain; otherwise the
    deterministic target (when known) is tail-called directly.
    """
    tail = direct if direct else "blockLookup(c)"
    return (" local st=blockTick(c,k)\n"
            " if st then\n"
            "  if st==1 then return end\n"
            "  return blockLookup(c)\n"
            " end\n"
            " return " + tail)


def _block_exit_lua(blk, prg, phys):
    """Block tail: pc update, flow-instruction semantics, tick, then dispatch."""
    exit_ = blk["exit"]
    kind = exit_[0]
    total = blk["total"]
    off = blk["entry_off"]
    if kind == "fall":
        nxt = exit_[1]
        head = " c.pc=(c.pc+%d)%%65536" % total
        return " " + head + "\n" + _tick_then("P[%d](c)" % nxt if nxt is not None else None)
    if kind == "branch":
        mask, cmp_, disp, t_phys, f_phys = exit_[1], exit_[2], exit_[3], exit_[4], exit_[5]
        taken = "P[%d](c)" % t_phys if t_phys is not None else None
        fall = "P[%d](c)" % f_phys if f_phys is not None else None
        if taken is None and fall is None:
            dispatch = _tick_then(None)
        else:
            t_low = (off + total + disp) % 8192
            dispatch = (_tick_then(None).rsplit(" return ", 1)[0] +
                        " if band(c.pc,8191)==%d then return %s end\n"
                        " return %s" % (t_low, taken or "blockLookup(c)", fall or "blockLookup(c)"))
        return (" local pc0=(c.pc+%d)%%65536\n"
                " read(c,pc0)\n"
                " if band(c.p,%d)%s0 then\n"
                "  local t=(pc0+(%d))%%65536\n"
                "  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%%256);k=k+4 else k=k+3 end\n"
                "  c.pc=t\n"
                " else c.pc=pc0;k=k+2 end\n" % (total, mask, cmp_, disp)) + dispatch
    if kind == "jsr":
        t_logic, t_phys = exit_[1], exit_[2]
        hi = prg[phys + total - 1]
        body = (" local ret=(c.pc+%d)%%65536\n"
                " read(c,256+c.s);push(c,floor(ret/256));push(c,ret%%256);c.open=%d\n"
                " c.pc=%d;k=k+6" % (total - 1, hi, t_logic))
        return " " + body + "\n" + _tick_then("P[%d](c)" % t_phys if t_phys is not None else None)
    if kind == "jmp":
        t_logic, t_phys = exit_[1], exit_[2]
        hi = prg[phys + total - 1]
        body = " c.open=%d;c.pc=%d;k=k+3" % (hi, t_logic)
        return " " + body + "\n" + _tick_then("P[%d](c)" % t_phys if t_phys is not None else None)
    if kind == "jmpind":
        operand = exit_[1]
        hi = prg[phys + total - 1]
        body = (" c.open=%d;local addr=read(c,%d)+256*read(c,floor(%d/256)*256+(%d+1)%%256)\n"
                " c.pc=addr;k=k+5" % (hi, operand, operand, operand))
        return " " + body + "\n" + _tick_then(None)
    if kind == "rts":
        return (" read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)\n"
                " c.pc=(ret+1)%65536;k=k+6\n" + _tick_then(None))
    if kind == "rti":
        return (" read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)\n"
                " c.pc=lo+256*hi;k=k+6\n" + _tick_then(None))
    if kind == "brk":
        body = (" c.open=%d;c.pc=(c.pc+%d)%%65536;k=k+interrupt(c,65534,true)"
                % (prg[phys + total], total + 1))
        return " " + body + "\n" + _tick_then(None)
    raise ValueError("BAD_EXIT " + kind)


def block_lua_files(rom, blocks, ops, shard=65536):
    """Render collected blocks into translated-blocks-N.lua shard files."""
    files = {}
    parts = []
    size = 0
    index = 0

    def flush():
        nonlocal parts, size, index
        if parts:
            files["translated-blocks-%d.lua" % index] = "".join(parts)
            index += 1
            parts = []
            size = 0

    for phys in sorted(blocks):
        source = _block_lua(rom, phys, blocks[phys], ops)
        if size == 0:
            parts.append(BLOCK_HEADER)
            size = len(BLOCK_HEADER)
        parts.append(source)
        size += len(source)
        if size >= shard:
            flush()
    flush()
    if not files:
        files["translated-blocks-0.lua"] = BLOCK_HEADER
    return files


def runtime_files(ops, version):
    from wow_nes import lua_value
    files = {"bootstrap.lua": BOOTSTRAP, "bus.lua": BUS,
             "cpu-interpreter.lua": ("local R=WoWNES_Runtime;R.ops=" + lua_value(ops) + "\n" +
                                     CPU + "\n" + exec_table(ops)),
             "ppu.lua": PPU, "apu.lua": APU, "controller.lua": CONTROLLER,
             "renderer.lua": RENDERER, "scheduler.lua": SCHEDULER}
    files["WoWNES_Runtime.toc"] = "## Interface: 50504\n## Title: WOW_NES Runtime\n## Version: " + version + "\n" + "\n".join(files) + "\n"
    return files
