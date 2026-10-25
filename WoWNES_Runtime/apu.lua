
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
