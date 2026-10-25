local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[37443]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37445](c)
end
P[37445]=function(c)
 local k=0
 do c.open=1;local base=416;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37448]=function(c)
 local k=0
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4688 then return P[37456](c) end
 return P[37453](c)
end
P[37453]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=146
 c.pc=37482;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37456]=function(c)
 local k=0
 do c.open=7;local base=1968;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=176;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(5))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4699 then return P[37467](c) end
 return P[37462](c)
end
P[37462]=function(c)
 local k=0
 do local value=244;c.open=244;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37467](c)
end
P[37467]=function(c)
 local k=0
 do c.open=24;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=105;c.p=flag(c.p,1,false);k=k+2 end
 do local value=196;c.open=196;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do c.open=198;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=7;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+9)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4711 then return P[37479](c) end
 return P[37476](c)
end
P[37476]=function(c)
 local k=0
 do c.open=16;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-101))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4610 then return P[37378](c) end
 return P[37479](c)
end
P[37479]=function(c)
 local k=0
 do local addr=4;write(c,addr,c.x);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37482]=function(c)
 local k=0
 do local addr=90;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=169;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
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
 if band(c.pc,8191)==4723 then return P[37491](c) end
 return P[37489](c)
end
P[37489]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37491](c)
end
P[37491]=function(c)
 local k=0
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=7;local base=1968;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=254;c.open=254;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=0;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=7;local base=1968;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+12)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37503]=function(c)
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
P[37508]=function(c)
 local k=0
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=176;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(11))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4755 then return P[37523](c) end
 return P[37512](c)
end
P[37512]=function(c)
 local k=0
 do c.open=147;local base=37848;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=147;local base=37849;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
  c.open=146;c.pc=37531;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37523]=function(c)
 local k=0
 do c.open=148;local base=38104;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=148;local base=38105;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37531](c)
end
P[37531]=function(c)
 local k=0
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(-36))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4735 then return P[37503](c) end
 return P[37539](c)
end
P[37539]=function(c)
 local k=0
 do c.open=201;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local value=254;c.open=254;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4779 then return P[37547](c) end
 return P[37544](c)
end
P[37544]=function(c)
 local k=0
  c.open=147;c.pc=37699;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37547]=function(c)
 local k=0
 do local addr=3;write(c,addr,c.a);k=k+3 end
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=200;c.open=200;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=11;write(c,addr,c.a);k=k+3 end
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=162;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=252;c.open=252;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local value=35;c.open=35;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+19)%65536
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
 if band(c.pc,8191)==4802 then return P[37570](c) end
 return P[37566](c)
end
P[37566]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local value=32;c.open=32;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37570](c)
end
P[37570]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do local addr=13;write(c,addr,c.x);k=k+3 end
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37578](c)
end
P[37578]=function(c)
 local k=0
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=128;c.open=128;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(22))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4838 then return P[37606](c) end
 return P[37584](c)
end
P[37584]=function(c)
 local k=0
 do local addr=11;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=247;c.open=247;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=11;write(c,addr,c.a);k=k+3 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=6;write(c,addr,c.a);k=k+3 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do local addr=6;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+22)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37606](c)
end
P[37606]=function(c)
 local k=0
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do local addr=11;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=16;c.open=16;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+11)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4851 then return P[37619](c) end
 return P[37617](c)
end
P[37617]=function(c)
 local k=0
 do local addr=12;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37619](c)
end
P[37619]=function(c)
 local k=0
 do local addr=12;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(7))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4862 then return P[37630](c) end
 return P[37623](c)
end
P[37623]=function(c)
 local k=0
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do local value=240;c.open=240;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=12;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
  c.pc=(c.pc+7)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37630](c)
end
P[37630]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=2;local base=513;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=13;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=0;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=11;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=2;local base=514;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=11;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=177;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 local pc0=(c.pc+32)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(7))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4901 then return P[37669](c) end
 return P[37662](c)
end
P[37662]=function(c)
 local k=0
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do local value=248;c.open=248;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=12;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=48;c.p=flag(c.p,1,false);k=k+2 end
  c.pc=(c.pc+7)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37669](c)
end
P[37669]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(22))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4925 then return P[37693](c) end
 return P[37671](c)
end
P[37671]=function(c)
 local k=0
 do local addr=2;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4917 then return P[37685](c) end
 return P[37675](c)
end
P[37675]=function(c)
 local k=0
 do c.open=2;local base=515;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local addr=7;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=24;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=16;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=200;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
  c.pc=(c.pc+10)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37685](c)
end
P[37685]=function(c)
 local k=0
 do c.open=198;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=3;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-112))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4810 then return P[37578](c) end
 return P[37690](c)
end
P[37690]=function(c)
 local k=0
 do local addr=4;write(c,addr,c.x);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37693]=function(c)
 local k=0
 do local addr=2;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-22))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4907 then return P[37675](c) end
 return P[37697](c)
end
P[37697]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(-14))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4917 then return P[37685](c) end
 return P[37699](c)
end
P[37699]=function(c)
 local k=0
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=248;c.open=248;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=1;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=2;local base=513;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=0;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=2;local base=514;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=233;c.p=flag(c.p,1,true);k=k+2 end
 do local value=4;c.open=4;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 local pc0=(c.pc+30)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(11))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4972 then return P[37740](c) end
 return P[37729](c)
end
P[37729]=function(c)
 local k=0
 do c.open=2;local base=515;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local addr=7;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=24;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=16;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=4;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+11)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37740](c)
end
P[37740]=function(c)
 local k=0
 do c.open=96;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37742]=function(c)
 local k=0
 do local addr=34;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=28;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4982 then return P[37750](c) end
 return P[37748](c)
end
P[37748]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37750](c)
end
P[37750]=function(c)
 local k=0
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37754](c)
end
P[37754]=function(c)
 local k=0
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=28;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(21))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5013 then return P[37781](c) end
 return P[37760](c)
end
P[37760]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do c.open=0;local base=56;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do c.open=176;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+10)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(11))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5013 then return P[37781](c) end
 return P[37770](c)
end
P[37770]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do c.open=0;local base=50;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local value=4;c.open=4;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+11)%65536
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
 if band(c.pc,8191)==5015 then return P[37783](c) end
 return P[37781](c)
end
P[37781]=function(c)
 local k=0
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37783](c)
end
P[37783]=function(c)
 local k=0
 do local addr=1;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37785](c)
end
P[37785]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(38))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5059 then return P[37827](c) end
 return P[37789](c)
end
P[37789]=function(c)
 local k=0
 do local value=16;c.open=16;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=147;local base=37834;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=2;local base=513;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=2;local base=514;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=185;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=147;local base=37842;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+22)%65536
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
 if band(c.pc,8191)==5045 then return P[37813](c) end
 return P[37811](c)
end
P[37811]=function(c)
 local k=0
 do local value=175;c.open=175;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37813](c)
end
P[37813]=function(c)
 local k=0
 do c.open=2;local base=515;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local addr=7;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=24;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=16;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=200;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=76;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
  c.open=147;c.pc=37785;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37827]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-77))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4986 then return P[37754](c) end
 return P[37831](c)
end
P[37831]=function(c)
 local k=0
 do local addr=4;write(c,addr,c.x);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[40960]=function(c)
 local k=0
 do local addr=3;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.open=0;c.pc=(c.pc+4)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[41958]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(43))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1043 then return P[42003](c) end
 return P[41960](c)
end
P[41960]=function(c)
 local k=0
 do read(c,3);local addr=(3+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-128))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[42003]=function(c)
 local k=0
 do read(c,60);local addr=(60+c.y)%256;write(c,addr,band(c.a,c.x));k=k+4 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[49152]=function(c)
 local k=0
 do read(c,2);local addr=(2+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[50150]=function(c)
 local k=0
 do read(c,151);local addr=(151+c.y)%256;write(c,addr,c.x);k=k+4 end
 do local addr=38;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+5 end
 do read(c,150);local addr=(150+c.y)%256;write(c,addr,band(c.a,c.x));k=k+4 end
 do local addr=35;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=36;local value=read(c,addr);c.p=flag(flag(flag(c.p,2,band(c.a,value)==0),64,band(value,64)~=0),128,band(value,128)~=0);k=k+3 end
 do local addr=32;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do read(c,33);local z=(33+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+6 end
  c.pc=(c.pc+14)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[50969]=function(c)
 local k=0
 do c.open=204;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=255;local addr=65535;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);k=k+4 end
 do c.open=255;local base=65484;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=204;local base=52479;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local addr=65484;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);k=k+4 end
 do c.open=0;local base=255;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do read(c,85);local addr=(85+c.x)%256;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do read(c,80);local addr=(80+c.x)%256;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=170;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=170;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=170;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=0;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
  c.open=226;c.pc=(c.pc+26)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[53641]=function(c)
 local k=0
 do c.open=238;local base=61165;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[53663]=function(c)
 local k=0
 do c.open=205;local base=52682;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=218;local addr=56011;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 do c.open=219;local base=56286;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 do c.open=239;local addr=61389;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+14)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(-36))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4489 then return P[53641](c) end
 return P[53677](c)
end
P[53677]=function(c)
 local k=0
 do c.open=219;local base=56286;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 do c.open=206;local addr=52941;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);k=k+4 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[57344]=function(c)
 local k=0
 do read(c,4);local z=(4+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[57557]=function(c)
 local k=0
  c.open=113;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[61855]=function(c)
 local k=0
  c.open=0;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[65536]=function(c)
 local k=0
 do c.open=0;c.p=flag(c.p,1,false);k=k+2 end
  c.open=32;c.pc=(c.pc+3)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[65749]=function(c)
 local k=0
 do local value=12;c.open=12;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
  c.open=136;c.pc=(c.pc+4)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[67353]=function(c)
 local k=0
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=23;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do read(c,37);local addr=(37+c.x)%256;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+6 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(31))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1854 then return P[67390](c) end
 return P[67359](c)
end
P[67359]=function(c)
 local k=0
 do c.open=33;local base=8467;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);k=k+4 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[67390]=function(c)
 local k=0
 do local base=read(c,28)+256*read(c,(28+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+8 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[67392]=function(c)
 local k=0
 do c.open=30;local addr=7693;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+6 end
 do c.open=0;local addr=14;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+6 end
 do c.open=7;local addr=1827;local value=read(c,addr);k=k+4 end
 do c.open=31;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=15;local base=3863;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=11;local addr=2834;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=10;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=29;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=21;local base=5413;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do local base=read(c,30)+256*read(c,(30+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+8 end
  c.pc=(c.pc+24)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[70047]=function(c)
 local k=0
  c.open=0;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[73728]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==12 then return P[73740](c) end
 return P[73730](c)
end
P[73730]=function(c)
 local k=0
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=64;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==10 then return P[73738](c) end
 return P[73736](c)
end
P[73736]=function(c)
 local k=0
 do local value=13;c.open=13;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[73738](c)
end
P[73738]=function(c)
 local k=0
 do local addr=45;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[73740](c)
end
P[73740]=function(c)
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
P[73941]=function(c)
 local k=0
 do read(c,7);local addr=(7+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 do local addr=42;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do local addr=67;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=24;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=8;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=161;local base=41276;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=3;local addr=771;write(c,addr,c.a);k=k+4 end
 do local addr=42;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=3;c.open=3;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+28)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(5))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==246 then return P[73974](c) end
 return P[73969](c)
end
P[73969]=function(c)
 local k=0
 do local addr=8;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do c.open=161;local base=41294;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[73974](c)
end
P[73974]=function(c)
 local k=0
 do c.open=3;local addr=769;write(c,addr,c.a);k=k+4 end
 do local addr=42;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=3;c.open=3;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=2;c.open=2;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+11)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==260 then return P[73988](c) end
 return P[73985](c)
end
P[73985]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=163
 c.pc=41958;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[73988]=function(c)
 local k=0
 do local addr=42;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=2;c.open=2;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=161;local base=41280;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=161;local base=41281;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
 do local addr=69;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=69;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=24;c.open=24;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+23)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==289 then return P[74017](c) end
 return P[74011](c)
end
P[74011]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=69;write(c,addr,c.a);k=k+3 end
 do local addr=68;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[74017](c)
end
P[74017]=function(c)
 local k=0
 do local addr=68;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=4;c.open=4;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==297 then return P[74025](c) end
 return P[74023](c)
end
P[74023]=function(c)
 local k=0
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[74025](c)
end
P[74025]=function(c)
 local k=0
 do c.open=177;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=3;local addr=770;write(c,addr,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[74726]=function(c)
 local k=0
 do local value=15;c.open=15;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[74728](c)
end
P[74728]=function(c)
 local k=0
 do c.open=4;local base=1208;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(4))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1009 then return P[74737](c) end
 return P[74733](c)
end
P[74733]=function(c)
 local k=0
 do c.open=16;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-8))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1000 then return P[74728](c) end
 return P[74736](c)
end
P[74736]=function(c)
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
P[74737]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=4;local base=1208;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=4;local base=1272;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=4;local base=1256;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=64;c.open=64;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local base=1304;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local base=1288;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=4;local base=1224;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=4;local base=1240;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=80;c.open=80;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=64;c.open=64;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=221;c.open=221;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=3;local base=778;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=3;local base=856;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[75319]=function(c)
 local k=0
 do c.open=224;local base=57567;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
  c.open=0;c.pc=(c.pc+5)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[75545]=function(c)
 local k=0
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=170;local base=43622;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=66;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=165;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=65;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+28)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[75573](c)
end
P[75573]=function(c)
 local k=0
 do c.open=177;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=255;c.open=255;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1858 then return P[75586](c) end
 return P[75580](c)
end
P[75580]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=208;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-13))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1845 then return P[75573](c) end
 return P[75586](c)
end
