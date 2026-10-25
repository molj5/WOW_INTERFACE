local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[117031]=function(c)
 local k=0
 do c.open=16;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-22))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2324 then return P[117012](c) end
 return P[117034](c)
end
P[117034]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
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
 if band(c.pc,8191)==2351 then return P[117039](c) end
 return P[117036](c)
end
P[117036]=function(c)
 local k=0
  c.open=0;c.pc=0;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[117039]=function(c)
 local k=0
 do local value=24;c.open=24;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63881;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129417](c)
end
P[117044]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=201
 c.pc=51514;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117050](c)
end
P[117047]=function(c)
 local k=0
  c.open=249;c.pc=63895;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129431](c)
end
P[117050]=function(c)
 local k=0
 do c.open=201;local base=51633;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=201;local base=51634;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+12)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63814;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129350](c)
end
P[117063]=function(c)
 local k=0
 do local addr=33;write(c,addr,c.a);k=k+3 end
 do local addr=252;write(c,addr,c.a);k=k+3 end
 do local addr=253;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117069](c)
end
P[117069]=function(c)
 local k=0
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=177;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  local ret=(c.pc+22)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=199
 c.pc=50989;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116525](c)
end
P[117092]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=255;c.open=255;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(66))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2478 then return P[117166](c) end
 return P[117100](c)
end
P[117100]=function(c)
 local k=0
 do local value=127;c.open=127;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(52))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2468 then return P[117156](c) end
 return P[117104](c)
end
P[117104]=function(c)
 local k=0
 do c.open=16;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
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
 if band(c.pc,8191)==2450 then return P[117138](c) end
 return P[117107](c)
end
P[117107]=function(c)
 local k=0
 do local value=127;c.open=127;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117113](c)
end
P[117113]=function(c)
 local k=0
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
 do local addr=2;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+9)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2437 then return P[117125](c) end
 return P[117122](c)
end
P[117122]=function(c)
 local k=0
 do c.open=208;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
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
 if band(c.pc,8191)==2425 then return P[117113](c) end
 return P[117125](c)
end
P[117125]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=2;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117130](c)
end
P[117130]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=199
 c.pc=50989;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116525](c)
end
P[117135]=function(c)
 local k=0
  c.open=201;c.pc=51556;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117092](c)
end
P[117138]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117146](c)
end
P[117146]=function(c)
 local k=0
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
 do c.open=208;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2458 then return P[117146](c) end
 return P[117152](c)
end
P[117152]=function(c)
 local k=0
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-26))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2442 then return P[117130](c) end
 return P[117156](c)
end
P[117156]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=199
 c.pc=50989;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116525](c)
end
P[117163]=function(c)
 local k=0
  c.open=201;c.pc=51533;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117069](c)
end
P[117166]=function(c)
 local k=0
  c.open=249;c.pc=63766;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129302](c)
end
P[117445]=function(c)
 local k=0
 do c.open=169;push(c,c.a);k=k+3 end
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=3;write(c,addr,c.a);k=k+3 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+9)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=203
 c.pc=52002;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117538](c)
end
P[117455]=function(c)
 local k=0
 do c.open=133;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
 do c.open=170;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=189;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=245;local base=62840;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=245;local base=62841;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+19)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117474](c)
end
P[117474]=function(c)
 local k=0
 do local base=read(c,0)+256*read(c,(0+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=201;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local value=255;c.open=255;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(63))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2856 then return P[117544](c) end
 return P[117481](c)
end
P[117481]=function(c)
 local k=0
 do local value=254;c.open=254;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(25))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2822 then return P[117510](c) end
 return P[117485](c)
end
P[117485]=function(c)
 local k=0
 do local value=253;c.open=253;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(25))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2826 then return P[117514](c) end
 return P[117489](c)
end
P[117489]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(11))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2819 then return P[117507](c) end
 return P[117496](c)
end
P[117496]=function(c)
 local k=0
 do local addr=3;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==2817 then return P[117505](c) end
 return P[117500](c)
end
P[117500]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 local pc0=(c.pc+5)%65536
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
 if band(c.pc,8191)==2819 then return P[117507](c) end
 return P[117505](c)
end
P[117505]=function(c)
 local k=0
 do local addr=3;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117507](c)
end
P[117507]=function(c)
 local k=0
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
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
 if band(c.pc,8191)==2786 then return P[117474](c) end
 return P[117510](c)
end
P[117510]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(26))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2852 then return P[117540](c) end
 return P[117514](c)
end
P[117514]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=203
 c.pc=52004;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117540](c)
end
P[117519]=function(c)
 local k=0
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=3;write(c,addr,c.a);k=k+3 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+8)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=203
 c.pc=52004;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117540](c)
end
P[117528]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-56))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2786 then return P[117474](c) end
 return P[117530](c)
end
P[117530]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==2850 then return P[117538](c) end
 return P[117534](c)
end
P[117534]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(0))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2850 then return P[117538](c) end
 return P[117538](c)
end
P[117538]=function(c)
 local k=0
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117540](c)
end
P[117540]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=134;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117544](c)
end
P[117544]=function(c)
 local k=0
 do local addr=33;write(c,addr,c.x);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[117552]=function(c)
 local k=0
 do local addr=35;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2871 then return P[117559](c) end
 return P[117556](c)
end
P[117556]=function(c)
 local k=0
  c.open=203;c.pc=52160;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117696](c)
end
P[117559]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=8;write(c,addr,c.y);k=k+3 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117563](c)
end
P[117563]=function(c)
 local k=0
 do local addr=8;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=63;c.open=63;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(14))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2895 then return P[117583](c) end
 return P[117569](c)
end
P[117569]=function(c)
 local k=0
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+14)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117583](c)
end
P[117583]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(56))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2956 then return P[117644](c) end
 return P[117588](c)
end
P[117588]=function(c)
 local k=0
 do local addr=255;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=24;c.open=24;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=203;local base=52010;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=32;local addr=8192;write(c,addr,c.a);k=k+4 end
 do c.open=173;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=185;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=224;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local value=3;c.open=3;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+34)%65536
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
 if band(c.pc,8191)==2940 then return P[117628](c) end
 return P[117622](c)
end
P[117622]=function(c)
 local k=0
 do local value=4;c.open=4;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(53))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2991 then return P[117679](c) end
 return P[117626](c)
end
P[117626]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(34))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2974 then return P[117662](c) end
 return P[117628](c)
end
P[117628]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117633](c)
end
P[117633]=function(c)
 local k=0
 do c.open=185;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
 do local addr=9;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+11)%65536
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
 if band(c.pc,8191)==2945 then return P[117633](c) end
 return P[117644](c)
end
P[117644]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local addr=1792;write(c,addr,c.a);k=k+4 end
 do local addr=33;write(c,addr,c.a);k=k+3 end
 do local addr=255;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=32;local addr=8192;write(c,addr,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[117657]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117659](c)
end
P[117659]=function(c)
 local k=0
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117662](c)
end
P[117662]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=201;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local value=255;c.open=255;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+8)%65536
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
 if band(c.pc,8191)==2971 then return P[117659](c) end
 return P[117670](c)
end
P[117670]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=6;c.open=6;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-20))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2969 then return P[117657](c) end
 return P[117677](c)
end
P[117677]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(-116))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2875 then return P[117563](c) end
 return P[117679](c)
end
P[117679]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
 do c.open=185;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=141;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117687](c)
end
P[117687]=function(c)
 local k=0
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
 do c.open=208;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2999 then return P[117687](c) end
 return P[117693](c)
end
P[117693]=function(c)
 local k=0
  c.open=203;c.pc=52027;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117563](c)
end
P[117696]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local addr=255;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=24;c.open=24;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=2;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117704](c)
end
P[117704]=function(c)
 local k=0
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(-65))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2956 then return P[117644](c) end
 return P[117709](c)
end
P[117709]=function(c)
 local k=0
 do local addr=2;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=203;local base=52010;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=32;local addr=8192;write(c,addr,c.a);k=k+4 end
 do c.open=189;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=189;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+20)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117729](c)
end
P[117729]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do c.open=189;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=189;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+16)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117745](c)
end
P[117745]=function(c)
 local k=0
 do c.open=189;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
 do c.open=208;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+10)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==3057 then return P[117745](c) end
 return P[117755](c)
end
P[117755]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-30))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==3041 then return P[117729](c) end
 return P[117759](c)
end
P[117759]=function(c)
 local k=0
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-58))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==3016 then return P[117704](c) end
 return P[117762](c)
end
P[117762]=function(c)
 local k=0
 do local addr=54;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(50))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==3128 then return P[117816](c) end
 return P[117766](c)
end
P[117766]=function(c)
 local k=0
 do local addr=33;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=71;c.open=71;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(44))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==3128 then return P[117816](c) end
 return P[117772](c)
end
P[117772]=function(c)
 local k=0
 do local addr=255;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=24;c.open=24;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=32;local addr=8192;write(c,addr,c.a);k=k+4 end
 do local value=63;c.open=63;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
  c.pc=(c.pc+18)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117790](c)
end
P[117790]=function(c)
 local k=0
 do c.open=7;local base=1984;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=32;local addr=8199;write(c,addr,c.a);k=k+4 end
 do c.open=202;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=208;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+10)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==3102 then return P[117790](c) end
 return P[117800](c)
end
P[117800]=function(c)
 local k=0
 do local value=63;c.open=63;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.x);k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.x);k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.x);k=k+4 end
 do local addr=54;write(c,addr,c.x);k=k+3 end
  c.pc=(c.pc+16)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117816](c)
end
P[117816]=function(c)
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
P[119199]=function(c)
 local k=0
 do c.open=32;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+3)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=23
 c.pc=5888;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[119203]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=0
 c.pc=18;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[119206]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+5 end
 do read(c,32);local addr=(32+c.x)%256;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+6 end
 do read(c,0);local addr=(0+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(40))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4566 then return P[119254](c) end
 return P[119214](c)
end
P[119214]=function(c)
 local k=0
 do read(c,48);local addr=(48+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 do local addr=20;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=23;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=32;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+10)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(0))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4536 then return P[119224](c) end
 return P[119224](c)
end
P[119224]=function(c)
 local k=0
 do local addr=27;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[119254]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=39
 c.pc=10003;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[119257]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=39
 c.pc=10006;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[119260]=function(c)
 local k=0
  c.open=0;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[122862]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=16;write(c,addr,c.a);k=k+3 end
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
 if band(c.pc,8191)==8182 then return P[122870](c) end
 return P[122868](c)
end
P[122868]=function(c)
 local k=0
 do local addr=19;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122870](c)
end
P[122870]=function(c)
 local k=0
 do c.open=133;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=21;write(c,addr,c.a);k=k+3 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=252;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+8)%65536
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
 return blockLookup(c)
end
P[122880]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
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
 if band(c.pc,8191)==4 then return P[122884](c) end
 return P[122882](c)
end
P[122882]=function(c)
 local k=0
 do local value=15;c.open=15;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122884](c)
end
P[122884]=function(c)
 local k=0
 do local addr=17;write(c,addr,c.a);k=k+3 end
 do local addr=19;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=253;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=18;write(c,addr,c.a);k=k+3 end
 do local addr=255;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=16;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+17)%65536
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
 if band(c.pc,8191)==23 then return P[122903](c) end
 return P[122901](c)
end
P[122901]=function(c)
 local k=0
 do local value=1;c.open=1;c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122903](c)
end
P[122903]=function(c)
 local k=0
 do c.open=165;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=17;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=60;c.open=60;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=17;write(c,addr,c.a);k=k+3 end
 do local addr=18;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=18;write(c,addr,c.a);k=k+3 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=17;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=224;local base=57441;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=165;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=18;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=3;c.open=3;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=18;write(c,addr,c.a);k=k+3 end
 do local addr=19;write(c,addr,c.y);k=k+3 end
 do local addr=21;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=224;c.open=224;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+41)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(27))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==91 then return P[122971](c) end
 return P[122944](c)
end
P[122944]=function(c)
 local k=0
 do c.open=6;local base=1664;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=18;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+7)%65536
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
 if band(c.pc,8191)==79 then return P[122959](c) end
 return P[122951](c)
end
P[122951]=function(c)
 local k=0
 do c.open=240;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(7))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==81 then return P[122961](c) end
 return P[122954](c)
end
P[122954]=function(c)
 local k=0
 do c.open=240;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+3)%65536
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
 if band(c.pc,8191)==83 then return P[122963](c) end
 return P[122957](c)
end
P[122957]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==85 then return P[122965](c) end
 return P[122959](c)
end
P[122959]=function(c)
 local k=0
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122961](c)
end
P[122961]=function(c)
 local k=0
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122963](c)
end
P[122963]=function(c)
 local k=0
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122965](c)
end
P[122965]=function(c)
 local k=0
 do local value=3;c.open=3;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=224;local base=57443;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122971](c)
end
P[122971]=function(c)
 local k=0
 do local addr=20;write(c,addr,c.a);k=k+3 end
 do c.open=165;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=20;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[123878]=function(c)
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
P[124604]=function(c)
 local k=0
 do c.open=5;local base=1336;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124607](c)
end
P[124607]=function(c)
 local k=0
 do c.open=4;local base=1208;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(123))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1855 then return P[124735](c) end
 return P[124612](c)
end
P[124612]=function(c)
 local k=0
 do c.open=4;local base=1208;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[124730]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=4;local base=1208;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124735](c)
end
P[124735]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=3;local base=778;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[124776]=function(c)
 local k=0
 do local addr=65;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(50))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1950 then return P[124830](c) end
 return P[124780](c)
end
P[124780]=function(c)
 local k=0
 do c.open=4;local base=1224;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=4;local base=1272;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=4;local base=1224;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=4;local base=1256;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=104;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=232;c.open=232;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+26)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(73))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1999 then return P[124879](c) end
 return P[124806](c)
end
P[124806]=function(c)
 local k=0
 do c.open=4;local base=1240;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=5;local base=1304;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=4;local base=1240;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=5;local base=1288;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=8;c.open=8;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+23)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(50))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1999 then return P[124879](c) end
 return P[124829](c)
end
P[124829]=function(c)
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
P[124830]=function(c)
 local k=0
 do c.open=4;local base=1240;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=5;local base=1304;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=4;local base=1240;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=5;local base=1288;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=104;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=8;c.open=8;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+26)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(23))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1999 then return P[124879](c) end
 return P[124856](c)
end
