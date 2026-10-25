local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[213]=function(c)
 local k=0
 do local addr=48;local value=read(c,addr);k=k+3 end
 do local value=160;c.open=160;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=32;push(c,bor(c.p,48));k=k+3 end
  local ret=(c.pc+7)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=235
 c.pc=60313;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[125849](c)
end
P[221]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
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
 if band(c.pc,8191)==225 then return P[225](c) end
 return P[223](c)
end
P[223]=function(c)
 local k=0
 do c.open=96;c.p=flag(c.p,1,true);k=k+2 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[225]=function(c)
 local k=0
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
P[1817]=function(c)
 local k=0
  c.open=135;c.pc=34772;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[2004]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=137
 c.pc=35113;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[2007]=function(c)
 local k=0
  c.open=231;c.pc=59240;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124776](c)
end
P[2345]=function(c)
 local k=0
 do c.open=5;local base=1384;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do c.open=137;local base=35145;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=3;local base=778;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=64;c.open=64;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local base=1480;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 local pc0=(c.pc+16)%65536
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
 if band(c.pc,8191)==2363 then return P[2363](c) end
 return P[2361](c)
end
P[2361]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[2363](c)
end
P[2363]=function(c)
 local k=0
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 local pc0=(c.pc+5)%65536
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
 if band(c.pc,8191)==2373 then return P[2373](c) end
 return P[2368](c)
end
P[2368]=function(c)
 local k=0
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 do local value=8;c.open=8;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[2373](c)
end
P[2373]=function(c)
 local k=0
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
P[4511]=function(c)
 local k=0
 do local addr=240;local value=read(c,addr);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[8192]=function(c)
 local k=0
 do local addr=176;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=125;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=4;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=76;local value=read(c,addr);k=k+3 end
 do c.open=253;local addr=64928;local value=read(c,addr);k=k+4 end
 do c.open=4;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do local addr=157;local value=read(c,addr);k=k+3 end
 do c.open=96;local base=24579;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=105;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do local value=106;c.open=106;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do c.open=107;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
  c.pc=(c.pc+20)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[8405]=function(c)
 local k=0
 do local value=109;c.open=109;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do c.open=3;local base=778;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  local ret=(c.pc+7)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=231
 c.pc=59240;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124776](c)
end
P[8413]=function(c)
 local k=0
 do c.open=5;local base=1496;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=20;c.open=20;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(63))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==291 then return P[8483](c) end
 return P[8420](c)
end
P[8420]=function(c)
 local k=0
 do c.open=5;local base=1368;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(58))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==291 then return P[8483](c) end
 return P[8425](c)
end
P[8425]=function(c)
 local k=0
 do local value=8;c.open=8;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local base=1368;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=5;local base=1496;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
  local ret=(c.pc+10)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=234
 c.pc=60053;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[125589](c)
end
P[8436]=function(c)
 local k=0
 do c.open=5;local base=1480;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=10;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+7)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=243
 c.pc=62336;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127872](c)
end
P[8444]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(37))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==291 then return P[8483](c) end
 return P[8446](c)
end
P[8446]=function(c)
 local k=0
 do c.open=5;local base=1448;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=3;c.open=3;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=5;local base=1448;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=161;local base=41252;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=4;local base=1272;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=161;local base=41253;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=4;local base=1256;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=161;local base=41264;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=5;local base=1304;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=161;local base=41265;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=5;local base=1288;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+37)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[8483](c)
end
P[8483]=function(c)
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
P[9190]=function(c)
 local k=0
 do c.open=4;local base=1272;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=254;c.open=254;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=4;local base=1256;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.open=230;c.pc=59071;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124607](c)
end
P[9988]=function(c)
 local k=0
  c.open=230;c.pc=59068;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124604](c)
end
P[10009]=function(c)
 local k=0
 do c.open=3;local base=830;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do c.open=167;local base=42817;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=165;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local addr=0;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
  local ret=(c.pc+17)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63972;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129508](c)
end
P[10027]=function(c)
 local k=0
 do local addr=131;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do c.open=5;local base=1336;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(9))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1851 then return P[10043](c) end
 return P[10034](c)
end
P[10034]=function(c)
 local k=0
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=96;c.open=96;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+9)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-55))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1796 then return P[9988](c) end
 return P[10043](c)
end
P[10043]=function(c)
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
P[17376]=function(c)
 local k=0
 do local value=4;c.open=4;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==1003 then return P[17387](c) end
 return P[17380](c)
end
P[17380]=function(c)
 local k=0
 do local addr=239;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17382](c)
end
P[17382]=function(c)
 local k=0
 do local addr=238;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+5)%65536
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
 if band(c.pc,8191)==992 then return P[17376](c) end
 return P[17387](c)
end
P[17387]=function(c)
 local k=0
 do c.open=1;local addr=288;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
 do local value=2;c.open=2;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(23))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1033 then return P[17417](c) end
 return P[17394](c)
end
P[17394]=function(c)
 local k=0
 do c.open=1;local base=376;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(18))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1033 then return P[17417](c) end
 return P[17399](c)
end
P[17399]=function(c)
 local k=0
 do local addr=238;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=1;local base=380;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=1;local base=292;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=16;c.open=16;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+12)%65536
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
 if band(c.pc,8191)==1030 then return P[17414](c) end
 return P[17411](c)
end
P[17411]=function(c)
 local k=0
 do c.open=1;local base=380;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17414](c)
end
P[17414]=function(c)
 local k=0
 do c.open=1;local addr=288;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17417](c)
end
P[17417]=function(c)
 local k=0
 do c.open=1;local base=292;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=16;c.open=16;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
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
 if band(c.pc,8191)==1046 then return P[17430](c) end
 return P[17424](c)
end
P[17424]=function(c)
 local k=0
 do local addr=238;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
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
 if band(c.pc,8191)==1046 then return P[17430](c) end
 return P[17428](c)
end
P[17428]=function(c)
 local k=0
 do local addr=239;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17430](c)
end
P[17430]=function(c)
 local k=0
 do local addr=239;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=2;c.open=2;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(23))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1075 then return P[17459](c) end
 return P[17436](c)
end
P[17436]=function(c)
 local k=0
 do local value=5;c.open=5;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(17))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1073 then return P[17457](c) end
 return P[17440](c)
end
P[17440]=function(c)
 local k=0
 do c.open=1;local base=268;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+5)%65536
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
 if band(c.pc,8191)==1075 then return P[17459](c) end
 return P[17445](c)
end
P[17445]=function(c)
 local k=0
 do c.open=1;local base=292;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(7))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1073 then return P[17457](c) end
 return P[17450](c)
end
P[17450]=function(c)
 local k=0
 do c.open=1;local base=334;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=16;c.open=16;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(15))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1088 then return P[17472](c) end
 return P[17457](c)
end
P[17457]=function(c)
 local k=0
 do local addr=239;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17459](c)
end
P[17459]=function(c)
 local k=0
 do c.open=1;local base=268;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=8;c.open=8;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
  local ret=(c.pc+7)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=134
 c.pc=34359;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[17467]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1088 then return P[17472](c) end
 return P[17469](c)
end
P[17469]=function(c)
 local k=0
 do c.open=64;local base=16387;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17472](c)
end
P[17472]=function(c)
 local k=0
 do local addr=238;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=1;local addr=288;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
 do local value=2;c.open=2;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+9)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1100 then return P[17484](c) end
 return P[17481](c)
end
P[17481]=function(c)
 local k=0
 do c.open=1;local base=370;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17484](c)
end
P[17484]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=134
 c.pc=34359;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[17487]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1108 then return P[17492](c) end
 return P[17489](c)
end
P[17489]=function(c)
 local k=0
 do c.open=64;local base=16386;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[17492](c)
end
P[17492]=function(c)
 local k=0
 do c.open=1;local addr=288;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
 do c.open=152;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=24;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=224;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=1;local base=274;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=225;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=1;local base=280;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24576]=function(c)
 local k=0
 do local base=read(c,176)+256*read(c,(176+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[24578](c)
end
P[24578]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-2))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==2 then return P[24578](c) end
 return P[24580](c)
end
P[24580]=function(c)
 local k=0
 do local addr=0;local value=read(c,addr);k=k+3 end
 do local value=226;c.open=226;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do read(c,32);local z=(32+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+6 end
  local ret=(c.pc+8)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=4
 c.pc=1278;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24589]=function(c)
 local k=0
 do local addr=160;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+5 end
 do read(c,64);local z=(64+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+6 end
 read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)
 c.pc=lo+256*hi;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24789]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(48))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==263 then return P[24839](c) end
 return P[24791](c)
end
P[24791]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(48))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==265 then return P[24841](c) end
 return P[24793](c)
end
P[24793]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(32))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==251 then return P[24827](c) end
 return P[24795](c)
end
P[24795]=function(c)
 local k=0
  c.open=48;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24827]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(48))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==301 then return P[24877](c) end
 return P[24829](c)
end
P[24829]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(32))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==287 then return P[24863](c) end
 return P[24831](c)
end
P[24831]=function(c)
 local k=0
  c.open=48;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24839]=function(c)
 local k=0
  c.open=32;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24841]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=0
 c.pc=64;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24844]=function(c)
 local k=0
 read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)
 c.pc=lo+256*hi;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24863]=function(c)
 local k=0
 read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)
 c.pc=lo+256*hi;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[24877]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(0))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==303 then return P[24879](c) end
 return P[24879](c)
end
P[24879]=function(c)
 local k=0
 read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)
 c.pc=lo+256*hi;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[26393]=function(c)
 local k=0
 do read(c,16);local z=(16+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+6 end
 do read(c,32);local addr=(32+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[29081]=function(c)
 local k=0
 do read(c,16);local z=(16+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[29083](c)
end
P[29083]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(16))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4525 then return P[29101](c) end
 return P[29085](c)
end
P[29085]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(16))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4527 then return P[29103](c) end
 return P[29087](c)
end
P[29087]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(16))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4529 then return P[29105](c) end
 return P[29089](c)
end
P[29089]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(16))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4531 then return P[29107](c) end
 return P[29091](c)
end
P[29091]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(16))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4533 then return P[29109](c) end
 return P[29093](c)
end
P[29093]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(64))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4583 then return P[29159](c) end
 return P[29095](c)
end
P[29095]=function(c)
 local k=0
 read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)
 c.pc=lo+256*hi;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[29101]=function(c)
 local k=0
 do read(c,47);local addr=(47+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[29103](c)
end
P[29103]=function(c)
 local k=0
  c.open=232;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[29105]=function(c)
 local k=0
 do read(c,96);local z=(96+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[29107](c)
end
P[29107]=function(c)
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
P[29109]=function(c)
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
P[29159]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-80))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4505 then return P[29081](c) end
 return P[29161](c)
end
P[29161]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-80))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4507 then return P[29083](c) end
 return P[29163](c)
end
P[29163]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(96))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4685 then return P[29261](c) end
 return P[29165](c)
end
P[29165]=function(c)
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
P[29261]=function(c)
 local k=0
 read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c)
 c.pc=lo+256*hi;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[32768]=function(c)
 local k=0
 do c.open=128;local base=32797;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,64)==0 then
  local t=(pc0+(-128))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==8069 then return blockLookup(c) end
 return P[32773](c)
end
P[32773]=function(c)
 local k=0
 do local addr=128;write(c,addr,band(c.a,c.x));k=k+3 end
 do c.open=233;local base=59776;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=23;c.open=23;k=k+2 end
 do read(c,71);local z=(71+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);k=k+6 end
 do read(c,114);local z=(114+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);k=k+6 end
 do read(c,155);local z=(155+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);k=k+6 end
 do read(c,201);local z=(201+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);k=k+6 end
 do read(c,244);local z=(244+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);k=k+6 end
 do read(c,29);local z=(29+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);k=k+6 end
 do local value=67;c.open=67;k=k+2 end
 do local value=29;c.open=29;k=k+2 end
 do local value=33;c.open=33;k=k+2 end
  local ret=(c.pc+27)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=43
 c.pc=11041;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[32981]=function(c)
 local k=0
 do local value=55;c.open=55;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[33766]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,64)==0 then
  local t=(pc0+(94))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1094 then return blockLookup(c) end
 return P[33768](c)
end
P[33768]=function(c)
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
P[34585]=function(c)
 local k=0
 do local addr=135;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37223]=function(c)
 local k=0
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=16;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local addr=4;write(c,addr,c.x);k=k+3 end
  c.pc=(c.pc+8)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37231](c)
end
P[37231]=function(c)
 local k=0
 do local value=26;c.open=26;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(30))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4497 then return P[37265](c) end
 return P[37235](c)
end
P[37235]=function(c)
 local k=0
 do c.open=3;local base=768;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(22))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4494 then return P[37262](c) end
 return P[37240](c)
end
P[37240]=function(c)
 local k=0
 do c.open=3;local base=846;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=0;write(c,addr,c.y);k=k+3 end
 do c.open=3;local base=794;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=1;write(c,addr,c.y);k=k+3 end
 do c.open=3;local base=820;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=2;write(c,addr,c.y);k=k+3 end
 do local addr=5;write(c,addr,c.x);k=k+3 end
  local ret=(c.pc+19)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=146
 c.pc=37508;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37260]=function(c)
 local k=0
 do local addr=5;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37262](c)
end
P[37262]=function(c)
 local k=0
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-34))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4463 then return P[37231](c) end
 return P[37265](c)
end
P[37265]=function(c)
 local k=0
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=244;c.open=244;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37269](c)
end
P[37269]=function(c)
 local k=0
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=232;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=232;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=232;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+9)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-9))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4501 then return P[37269](c) end
 return P[37278](c)
end
P[37278]=function(c)
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
P[37279]=function(c)
 local k=0
 do c.open=7;local addr=2027;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=144;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+6)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(-62))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4455 then return P[37223](c) end
 return P[37285](c)
end
P[37285]=function(c)
 local k=0
 do local value=196;c.open=196;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=16;write(c,addr,c.a);k=k+3 end
 do local addr=53;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=105;c.p=flag(c.p,1,false);k=k+2 end
 do local value=76;c.open=76;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do local addr=53;write(c,addr,c.a);k=k+3 end
 do local addr=4;write(c,addr,c.a);k=k+3 end
 do local value=63;c.open=63;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=7;write(c,addr,c.y);k=k+3 end
 do local addr=55;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+21)%65536
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
 if band(c.pc,8191)==4541 then return P[37309](c) end
 return P[37306](c)
end
P[37306]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=147
 c.pc=37742;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37309]=function(c)
 local k=0
 do local value=25;c.open=25;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37311](c)
end
P[37311]=function(c)
 local k=0
 do local addr=5;write(c,addr,c.x);k=k+3 end
 do c.open=3;local base=768;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(18))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4568 then return P[37336](c) end
 return P[37318](c)
end
P[37318]=function(c)
 local k=0
 do c.open=3;local base=846;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=0;write(c,addr,c.y);k=k+3 end
 do c.open=3;local base=794;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=1;write(c,addr,c.y);k=k+3 end
 do c.open=3;local base=820;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=2;write(c,addr,c.y);k=k+3 end
  local ret=(c.pc+17)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=146
 c.pc=37508;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37336]=function(c)
 local k=0
 do local addr=7;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(27))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4599 then return P[37367](c) end
 return P[37340](c)
end
P[37340]=function(c)
 local k=0
 do local addr=5;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do c.open=16;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-34))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4543 then return P[37311](c) end
 return P[37345](c)
end
P[37345]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=145
 c.pc=37368;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37348]=function(c)
 local k=0
 do local addr=7;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(15))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4599 then return P[37367](c) end
 return P[37352](c)
end
P[37352]=function(c)
 local k=0
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37354](c)
end
P[37354]=function(c)
 local k=0
 do local value=244;c.open=244;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=2;local base=512;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=24;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=16;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=136;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=16;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+13)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-13))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4586 then return P[37354](c) end
 return P[37367](c)
end
P[37367]=function(c)
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
P[37368]=function(c)
 local k=0
 do local addr=48;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=4;c.open=4;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==4599 then return P[37367](c) end
 return P[37374](c)
end
P[37374]=function(c)
 local k=0
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do local value=15;c.open=15;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[37378](c)
end
P[37378]=function(c)
 local k=0
 do local addr=8;write(c,addr,c.y);k=k+3 end
 do local addr=9;write(c,addr,c.x);k=k+3 end
 do local value=97;c.open=97;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=2;local base=513;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=2;local base=514;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=7;local base=1968;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=190;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=146;local base=37504;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+4 end
 do local addr=0;write(c,addr,c.x);k=k+3 end
 do c.open=146;local base=37506;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=104;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
 do local addr=8;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 do local addr=9;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 do c.open=1;local base=432;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=1;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=1;local base=432;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+47)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[37425]=function(c)
 local k=0
 do c.open=2;local base=515;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(3))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==4665 then return P[37433](c) end
 return P[37430](c)
end
P[37430]=function(c)
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
P[37433]=function(c)
 local k=0
 do c.open=1;local base=416;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=0;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local value=238;c.open=238;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+10)%65536
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
 if band(c.pc,8191)==4677 then return P[37445](c) end
 return P[37443](c)
end
