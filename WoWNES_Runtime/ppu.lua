
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
