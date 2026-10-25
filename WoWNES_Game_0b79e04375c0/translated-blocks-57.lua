local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[115229]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115230]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=194
 c.pc=49781;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115317](c)
end
P[115233]=function(c)
 local k=0
 do local addr=245;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=48;c.open=48;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(48))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==599 then return P[115287](c) end
 return P[115239](c)
end
P[115239]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=193
 c.pc=49546;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115082](c)
end
P[115242]=function(c)
 local k=0
 do local addr=24;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=1;c.open=1;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(40))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==600 then return P[115288](c) end
 return P[115248](c)
end
P[115248]=function(c)
 local k=0
 do local addr=25;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(48))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==612 then return P[115300](c) end
 return P[115252](c)
end
P[115252]=function(c)
 local k=0
 do c.open=208;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(33))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==600 then return P[115288](c) end
 return P[115255](c)
end
P[115255]=function(c)
 local k=0
 do local value=32;c.open=32;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(17))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==588 then return P[115276](c) end
 return P[115259](c)
end
P[115259]=function(c)
 local k=0
 do local addr=241;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=192;c.open=192;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=192;c.open=192;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(4))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==583 then return P[115271](c) end
 return P[115267](c)
end
P[115267]=function(c)
 local k=0
 do local value=7;c.open=7;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==585 then return P[115273](c) end
 return P[115271](c)
end
P[115271]=function(c)
 local k=0
 do local value=3;c.open=3;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115273](c)
end
P[115273]=function(c)
 local k=0
  c.open=193;c.pc=49519;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115055](c)
end
P[115276]=function(c)
 local k=0
 do local addr=34;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=34;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+9)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==599 then return P[115287](c) end
 return P[115285](c)
end
P[115285]=function(c)
 local k=0
 do local addr=34;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115287](c)
end
P[115287]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115288]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=35;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=199
 c.pc=51011;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116547](c)
end
P[115295]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=193
 c.pc=49519;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115055](c)
end
P[115300]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=64;write(c,addr,c.y);k=k+3 end
 do c.open=132;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=65;write(c,addr,c.y);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115317]=function(c)
 local k=0
 do local addr=26;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-36))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==599 then return P[115287](c) end
 return P[115323](c)
end
P[115323]=function(c)
 local k=0
 do local addr=40;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(-40))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==599 then return P[115287](c) end
 return P[115327](c)
end
P[115327]=function(c)
 local k=0
 do local addr=40;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115463]=function(c)
 local k=0
 do local value=40;c.open=40;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115467](c)
end
P[115467]=function(c)
 local k=0
 do read(c,0);local addr=(0+c.x)%256;write(c,addr,c.a);k=k+4 end
 do c.open=224;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=240;c.open=240;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-7))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==779 then return P[115467](c) end
 return P[115474](c)
end
P[115474]=function(c)
 local k=0
 do local value=7;c.open=7;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local value=3;c.open=3;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=1;write(c,addr,c.y);k=k+3 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+10)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115484](c)
end
P[115484]=function(c)
 local k=0
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115486]=function(c)
 local k=0
 do c.open=208;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-5))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==796 then return P[115484](c) end
 return P[115489](c)
end
P[115489]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=1;local value=read(c,addr);c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-11))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==796 then return P[115484](c) end
 return P[115495](c)
end
P[115495]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115664]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115665]=function(c)
 local k=0
 do local addr=17;write(c,addr,c.a);k=k+3 end
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=64;c.open=64;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-9))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==976 then return P[115664](c) end
 return P[115673](c)
end
P[115673]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=198
 c.pc=50774;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116310](c)
end
P[115676]=function(c)
 local k=0
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local addr=48;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=64;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==998 then return P[115686](c) end
 return P[115684](c)
end
P[115684]=function(c)
 local k=0
 do local value=8;c.open=8;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115686](c)
end
P[115686]=function(c)
 local k=0
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=197;local base=50542;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=22;write(c,addr,c.a);k=k+3 end
 do c.open=197;local base=50543;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=23;write(c,addr,c.a);k=k+3 end
 do local addr=15;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+17)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(25))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1040 then return P[115728](c) end
 return P[115703](c)
end
P[115703]=function(c)
 local k=0
 do c.open=197;local base=50544;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=14;write(c,addr,c.a);k=k+3 end
 do c.open=197;local base=50545;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=15;write(c,addr,c.a);k=k+3 end
 do local addr=16;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+16)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(100))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1131 then return P[115819](c) end
 return P[115719](c)
end
P[115719]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=198
 c.pc=50903;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116439](c)
end
P[115722]=function(c)
 local k=0
 do local base=read(c,14)+256*read(c,(14+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=169;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115728](c)
end
P[115728]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=17;write(c,addr,c.a);k=k+3 end
 do local addr=16;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=17;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=17;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=17;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=22;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=22;write(c,addr,c.a);k=k+3 end
 do local addr=17;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=23;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=23;write(c,addr,c.a);k=k+3 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=169;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=20;write(c,addr,c.a);k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=157;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=160;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+46)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115774](c)
end
P[115774]=function(c)
 local k=0
 do local addr=13;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=12;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=177;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
  c.pc=(c.pc+12)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115786](c)
end
P[115786]=function(c)
 local k=0
 do local base=read(c,22)+256*read(c,(22+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=200;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=152;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=41;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=3;c.open=3;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+12)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-12))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1098 then return P[115786](c) end
 return P[115798](c)
end
P[115798]=function(c)
 local k=0
 do local addr=12;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=105;c.p=flag(c.p,1,false);k=k+2 end
 do local value=32;c.open=32;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do local addr=13;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=0;c.open=0;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do local addr=13;write(c,addr,c.a);k=k+3 end
 do local addr=20;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+17)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-41))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1086 then return P[115774](c) end
 return P[115815](c)
end
P[115815]=function(c)
 local k=0
 do local addr=33;write(c,addr,c.x);k=k+3 end
 do c.open=96;c.p=flag(c.p,1,false);k=k+2 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115819]=function(c)
 local k=0
 do c.open=177;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do local base=read(c,14)+256*read(c,(14+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=134;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=1;write(c,addr,c.x);k=k+3 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(41))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1180 then return P[115868](c) end
 return P[115827](c)
end
P[115827]=function(c)
 local k=0
 do c.open=41;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=51;c.open=51;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=41;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=204;c.open=204;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do c.open=6;local base=1536;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=51;c.open=51;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=8;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=6;local base=1537;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=204;c.open=204;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=9;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
  c.open=197;c.pc=50454;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115990](c)
end
P[115868]=function(c)
 local k=0
 do c.open=208;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(45))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1228 then return P[115916](c) end
 return P[115871](c)
end
P[115871]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local addr=9;write(c,addr,c.x);k=k+3 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=9;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=9;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=9;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=9;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do c.open=6;local base=1536;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=15;c.open=15;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=8;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=6;local base=1544;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=240;c.open=240;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=9;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
  c.open=197;c.pc=50454;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115990](c)
end
P[115916]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local addr=8;write(c,addr,c.x);k=k+3 end
 do local addr=11;write(c,addr,c.x);k=k+3 end
 do c.open=102;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=8;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=102;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=8;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local value=12;c.open=12;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=10;write(c,addr,c.a);k=k+3 end
 do local base=read(c,14)+256*read(c,(14+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=11;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=11;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local value=48;c.open=48;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do c.open=6;local base=1536;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=63;c.open=63;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=8;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=6;local base=1537;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=207;c.open=207;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=9;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do c.open=6;local base=1544;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=243;c.open=243;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=10;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=10;write(c,addr,c.a);k=k+3 end
 do c.open=6;local base=1545;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,70)+256*read(c,(70+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=252;c.open=252;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=11;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=11;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+74)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115990](c)
end
P[115990]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=166;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=185;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=197;local base=50536;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=185;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=197;local base=50537;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=160;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+28)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116018](c)
end
P[116018]=function(c)
 local k=0
 do local addr=21;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=20;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=185;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=0;local base=8;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=2;c.open=2;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+25)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(8))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1363 then return P[116051](c) end
 return P[116043](c)
end
P[116043]=function(c)
 local k=0
 do c.open=185;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=0;local base=8;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116051](c)
end
P[116051]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(14))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1381 then return P[116069](c) end
 return P[116055](c)
end
P[116055]=function(c)
 local k=0
 do c.open=165;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=20;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=105;c.p=flag(c.p,1,false);k=k+2 end
 do local value=8;c.open=8;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do local addr=20;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
 local pc0=(c.pc+14)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(-51))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1330 then return P[116018](c) end
 return P[116069](c)
end
P[116069]=function(c)
 local k=0
  c.open=196;c.pc=50192;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115728](c)
end
P[116310]=function(c)
 local k=0
 do local addr=16;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=128;c.open=128;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=15;write(c,addr,c.a);k=k+3 end
 do local addr=16;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=127;c.open=127;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=16;write(c,addr,c.a);k=k+3 end
 do c.open=24;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=252;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+18)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(4))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1644 then return P[116332](c) end
 return P[116328](c)
end
P[116328]=function(c)
 local k=0
 do local value=240;c.open=240;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1646 then return P[116334](c) end
 return P[116332](c)
end
P[116332]=function(c)
 local k=0
 do local value=15;c.open=15;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116334](c)
end
P[116334]=function(c)
 local k=0
 do local value=248;c.open=248;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=18;write(c,addr,c.a);k=k+3 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=2;c.open=2;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=41;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=56;c.open=56;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=20;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=18;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=6;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=18;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=19;write(c,addr,c.a);k=k+3 end
 do local addr=17;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=253;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=17;write(c,addr,c.a);k=k+3 end
 do local addr=255;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+40)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1688 then return P[116376](c) end
 return P[116374](c)
end
P[116374]=function(c)
 local k=0
 do local value=1;c.open=1;c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116376](c)
end
P[116376]=function(c)
 local k=0
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=198;local base=50766;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=3;c.open=3;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=21;write(c,addr,c.a);k=k+3 end
 do c.open=198;local base=50764;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=19;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=19;write(c,addr,c.a);k=k+3 end
 do local addr=13;write(c,addr,c.a);k=k+3 end
 do c.open=198;local base=50768;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
 do local addr=17;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=248;c.open=248;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=170;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=41;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=0;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=74;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=5;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=20;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=3;write(c,addr,c.a);k=k+3 end
 do c.open=105;c.p=flag(c.p,1,false);k=k+2 end
 do local value=192;c.open=192;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do local addr=20;write(c,addr,c.a);k=k+3 end
 do c.open=5;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=18;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=18;write(c,addr,c.a);k=k+3 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=3;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[116439]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=157;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=157;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=21;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=20;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=96;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[116466]=function(c)
 local k=0
 do c.open=132;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=3;write(c,addr,c.y);k=k+3 end
 do c.open=200;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=104;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=133;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=133;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=3;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do local addr=3;write(c,addr,c.a);k=k+3 end
  c.open=0;local addr=read(c,2)+256*read(c,floor(2/256)*256+(2+1)%256)
 c.pc=addr;k=k+5
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[116505]=function(c)
 local k=0
 do local addr=2;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=3;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(4))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1829 then return P[116517](c) end
 return P[116513](c)
end
P[116513]=function(c)
 local k=0
 do local addr=3;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116517](c)
end
P[116517]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=1;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=208;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-19))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1817 then return P[116505](c) end
 return P[116524](c)
end
P[116524]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[116525]=function(c)
 local k=0
 do c.open=117;c.p=flag(c.p,1,false);k=k+2 end
 do read(c,0);local addr=(0+c.x)%256;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do read(c,0);local addr=(0+c.x)%256;write(c,addr,c.a);k=k+4 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1846 then return P[116534](c) end
 return P[116532](c)
end
P[116532]=function(c)
 local k=0
 do read(c,1);local addr=(1+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116534](c)
end
P[116534]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[116547]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=201
 c.pc=51472;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117008](c)
end
P[116550]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63956;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129492](c)
end
P[116553]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=195
 c.pc=49927;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115463](c)
end
P[116556]=function(c)
 local k=0
 do local value=30;c.open=30;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=254;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=55;write(c,addr,c.y);k=k+3 end
 do c.open=132;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=28;write(c,addr,c.y);k=k+3 end
 do local value=11;c.open=11;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+15)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=199
 c.pc=51064;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116600](c)
end
P[116572]=function(c)
 local k=0
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=201
 c.pc=51474;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117010](c)
end
P[116577]=function(c)
 local k=0
 do local value=6;c.open=6;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=202
 c.pc=51909;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117445](c)
end
P[116582]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=64;write(c,addr,c.a);k=k+3 end
  c.open=193;c.pc=49546;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115082](c)
end
P[116600]=function(c)
 local k=0
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=162;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116606](c)
end
P[116606]=function(c)
 local k=0
 do c.open=199;local base=51091;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local base=2032;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=232;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=224;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local value=8;c.open=8;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+12)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-12))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1918 then return P[116606](c) end
 return P[116618](c)
end
P[116618]=function(c)
 local k=0
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[117008]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117010](c)
end
P[117010]=function(c)
 local k=0
 do local value=3;c.open=3;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117012](c)
end
P[117012]=function(c)
 local k=0
 do c.open=41;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=7;local addr=2025;write(c,addr,c.a);k=k+4 end
 do c.open=96;local addr=24576;write(c,addr,c.a);k=k+4 end
 do c.open=96;local addr=24576;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=7;local addr=2025;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+19)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(5))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2348 then return P[117036](c) end
 return P[117031](c)
end
