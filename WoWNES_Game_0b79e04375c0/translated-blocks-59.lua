local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[124856]=function(c)
 local k=0
 do c.open=4;local base=1224;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=4;local base=1272;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=4;local base=1224;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=4;local base=1256;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do local value=232;c.open=232;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+23)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(-50))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==1949 then return P[124829](c) end
 return P[124879](c)
end
P[124879]=function(c)
 local k=0
  c.open=231;c.pc=59194;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[124730](c)
end
P[125589]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=24;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do c.open=24;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[125849]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=3;local base=830;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 do local addr=19;write(c,addr,c.a);k=k+3 end
 do c.open=24;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=125;c.p=flag(c.p,1,false);k=k+2 end
 do c.open=3;local base=804;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 local pc0=(c.pc+15)%65536
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
 if band(c.pc,8191)==2988 then return P[125868](c) end
 return P[125864](c)
end
P[125864]=function(c)
 local k=0
 do c.open=76;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
  c.open=223;c.pc=57326;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[122862](c)
end
P[125868]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[127872]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=243
 c.pc=62391;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127927](c)
end
P[127875]=function(c)
 local k=0
  c.open=243;c.pc=62345;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127881](c)
end
P[127881]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
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
 if band(c.pc,8191)==5041 then return P[127921](c) end
 return P[127883](c)
end
P[127883]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
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
 if band(c.pc,8191)==5019 then return P[127899](c) end
 return P[127885](c)
end
P[127885]=function(c)
 local k=0
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=6;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+10)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(17))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5032 then return P[127912](c) end
 return P[127895](c)
end
P[127895]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5029 then return P[127909](c) end
 return P[127899](c)
end
P[127899]=function(c)
 local k=0
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(8))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5032 then return P[127912](c) end
 return P[127904](c)
end
P[127904]=function(c)
 local k=0
 do local addr=6;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=233;c.p=flag(c.p,1,true);k=k+2 end
 do local value=1;c.open=1;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127909](c)
end
P[127909]=function(c)
 local k=0
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127912](c)
end
P[127912]=function(c)
 local k=0
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=12;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+7)%65536
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
 if band(c.pc,8191)==5041 then return P[127921](c) end
 return P[127919](c)
end
P[127919]=function(c)
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
P[127921]=function(c)
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
P[127927]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=15;write(c,addr,c.a);k=k+3 end
 do local addr=10;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5065 then return P[127945](c) end
 return P[127935](c)
end
P[127935]=function(c)
 local k=0
 do local addr=12;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=10;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=244
 c.pc=62660;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128196](c)
end
P[127942]=function(c)
 local k=0
  c.open=243;c.pc=62412;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127948](c)
end
P[127945]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=244
 c.pc=62610;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128146](c)
end
P[127948]=function(c)
 local k=0
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do local addr=15;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=169;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=6;c.open=6;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=12;c.open=12;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 local pc0=(c.pc+11)%65536
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
 if band(c.pc,8191)==5083 then return P[127963](c) end
 return P[127959](c)
end
P[127959]=function(c)
 local k=0
 do local value=12;c.open=12;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=24;c.open=24;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127963](c)
end
P[127963]=function(c)
 local k=0
 do local addr=5;write(c,addr,c.a);k=k+3 end
 do local addr=6;write(c,addr,c.y);k=k+3 end
 do local addr=7;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=2;c.open=2;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+10)%65536
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
 if band(c.pc,8191)==5100 then return P[127980](c) end
 return P[127973](c)
end
P[127973]=function(c)
 local k=0
 do local addr=5;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=12;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+7)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127980](c)
end
P[127980]=function(c)
 local k=0
 do local addr=7;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(13))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5117 then return P[127997](c) end
 return P[127984](c)
end
P[127984]=function(c)
 local k=0
 do local addr=6;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=12;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=6;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+9)%65536
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
 if band(c.pc,8191)==5115 then return P[127995](c) end
 return P[127993](c)
end
P[127993]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127995](c)
end
P[127995]=function(c)
 local k=0
 do local addr=12;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[127997](c)
end
P[127997]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=14;write(c,addr,c.a);k=k+3 end
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=5;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=6;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+14)%65536
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
 if band(c.pc,8191)==5135 then return P[128015](c) end
 return P[128011](c)
end
P[128011]=function(c)
 local k=0
 do local addr=14;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=6;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128015](c)
end
P[128015]=function(c)
 local k=0
 do local addr=13;write(c,addr,c.a);k=k+3 end
 do local addr=12;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=5;local base=1464;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+9)%65536
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
 if band(c.pc,8191)==5167 then return P[128047](c) end
 return P[128024](c)
end
P[128024]=function(c)
 local k=0
 do local addr=14;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==5158 then return P[128038](c) end
 return P[128028](c)
end
P[128028]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(14))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5164 then return P[128044](c) end
 return P[128030](c)
end
P[128030]=function(c)
 local k=0
 do local addr=13;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
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
 if band(c.pc,8191)==5164 then return P[128044](c) end
 return P[128034](c)
end
P[128034]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==5166 then return P[128046](c) end
 return P[128038](c)
end
P[128038]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5154 then return P[128034](c) end
 return P[128040](c)
end
P[128040]=function(c)
 local k=0
 do local addr=13;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(-10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5154 then return P[128034](c) end
 return P[128044](c)
end
P[128044]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128046](c)
end
P[128046]=function(c)
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
P[128047]=function(c)
 local k=0
 do local value=128;c.open=128;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==5166 then return P[128046](c) end
 return P[128051](c)
end
P[128051]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=234
 c.pc=60053;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[125589](c)
end
P[128054]=function(c)
 local k=0
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=15;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=244
 c.pc=62610;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128146](c)
end
P[128061]=function(c)
 local k=0
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do c.open=5;local base=1496;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local addr=7;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=144;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+11)%65536
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
 if band(c.pc,8191)==5199 then return P[128079](c) end
 return P[128072](c)
end
P[128072]=function(c)
 local k=0
 do local value=32;c.open=32;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=12;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+7)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128079](c)
end
P[128079]=function(c)
 local k=0
 do local addr=7;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(9))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5212 then return P[128092](c) end
 return P[128083](c)
end
P[128083]=function(c)
 local k=0
 do local value=64;c.open=64;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=12;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local value=63;c.open=63;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+9)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128092](c)
end
P[128092]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=14;write(c,addr,c.a);k=k+3 end
 do c.open=5;local base=1288;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=105;c.p=flag(c.p,1,false);k=k+2 end
 do local value=32;c.open=32;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do local value=64;c.open=64;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+14)%65536
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
 if band(c.pc,8191)==5230 then return P[128110](c) end
 return P[128106](c)
end
P[128106]=function(c)
 local k=0
 do local addr=14;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local value=64;c.open=64;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128110](c)
end
P[128110]=function(c)
 local k=0
 do local addr=13;write(c,addr,c.a);k=k+3 end
 do local addr=12;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=5;local base=1288;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+9)%65536
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
 if band(c.pc,8191)==5262 then return P[128142](c) end
 return P[128119](c)
end
P[128119]=function(c)
 local k=0
 do local addr=14;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==5253 then return P[128133](c) end
 return P[128123](c)
end
P[128123]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(14))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5259 then return P[128139](c) end
 return P[128125](c)
end
P[128125]=function(c)
 local k=0
 do local addr=13;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
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
 if band(c.pc,8191)==5259 then return P[128139](c) end
 return P[128129](c)
end
P[128129]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==5261 then return P[128141](c) end
 return P[128133](c)
end
P[128133]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(-6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5249 then return P[128129](c) end
 return P[128135](c)
end
P[128135]=function(c)
 local k=0
 do local addr=13;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+3 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(-10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5249 then return P[128129](c) end
 return P[128139](c)
end
P[128139]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128141](c)
end
P[128141]=function(c)
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
P[128142]=function(c)
 local k=0
 do local value=128;c.open=128;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==5261 then return P[128141](c) end
 return P[128146](c)
end
P[128146]=function(c)
 local k=0
 do local addr=10;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=1;c.open=1;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=0;local base=144;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=1;c.open=1;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+12)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(21))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5299 then return P[128179](c) end
 return P[128158](c)
end
P[128158]=function(c)
 local k=0
 do c.open=73;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=1;c.open=1;c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=0;local base=144;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=1;c.open=1;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+11)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(10))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5299 then return P[128179](c) end
 return P[128169](c)
end
P[128169]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=10;write(c,addr,c.a);k=k+3 end
 do local value=128;c.open=128;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=11;write(c,addr,c.a);k=k+3 end
 local pc0=(c.pc+10)%65536
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
 if band(c.pc,8191)==5316 then return P[128196](c) end
 return P[128179](c)
end
P[128179]=function(c)
 local k=0
 do local addr=64;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=169;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=176;c.open=176;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+7)%65536
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
 if band(c.pc,8191)==5309 then return P[128189](c) end
 return P[128186](c)
end
P[128186]=function(c)
 local k=0
 do c.open=3;local base=794;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128189](c)
end
P[128189]=function(c)
 local k=0
 do local addr=10;write(c,addr,c.a);k=k+3 end
 do c.open=3;local base=820;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=11;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+7)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128196](c)
end
P[128196]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do local addr=10;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=8;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+9)%65536
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
 if band(c.pc,8191)==5330 then return P[128210](c) end
 return P[128205](c)
end
P[128205]=function(c)
 local k=0
 do local value=255;c.open=255;c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=1;c.open=1;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do c.open=74;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
  c.pc=(c.pc+5)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128210](c)
end
P[128210]=function(c)
 local k=0
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=10;write(c,addr,c.a);k=k+3 end
 do local addr=11;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=229;c.p=flag(c.p,1,true);k=k+2 end
 do local addr=9;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 local pc0=(c.pc+14)%65536
 read(c,pc0)
 if band(c.p,1)~=0 then
  local t=(pc0+(6))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==5350 then return P[128230](c) end
 return P[128224](c)
end
P[128224]=function(c)
 local k=0
 do local value=255;c.open=255;c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=1;c.open=1;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+2 end
 do c.open=200;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=74;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128230](c)
end
P[128230]=function(c)
 local k=0
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=132;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=7;write(c,addr,c.y);k=k+3 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=11;write(c,addr,c.a);k=k+3 end
 do c.open=165;push(c,bor(c.p,48));k=k+3 end
 do local addr=15;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=168;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=245;local base=62738;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=12;write(c,addr,c.a);k=k+3 end
 do c.open=245;local base=62739;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=13;write(c,addr,c.a);k=k+3 end
 do local addr=10;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=101;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=11;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=177;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,12)+256*read(c,(12+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do c.open=176;read(c,256+c.s);c.p=bor(band(pop(c),239),32);k=k+4 end
 local pc0=(c.pc+37)%65536
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
 if band(c.pc,8191)==5391 then return P[128271](c) end
 return P[128267](c)
end
P[128267]=function(c)
 local k=0
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=41;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[128271](c)
end
P[128271]=function(c)
 local k=0
 do local value=15;c.open=15;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129037]=function(c)
 local k=0
 do c.open=120;c.p=flag(c.p,8,false);k=k+2 end
 do c.open=173;c.p=flag(c.p,4,true);k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129039](c)
end
P[129039]=function(c)
 local k=0
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-5))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==6159 then return P[129039](c) end
 return P[129044](c)
end
P[129044]=function(c)
 local k=0
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-5))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==6164 then return P[129044](c) end
 return P[129049](c)
end
P[129049]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=24;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63814;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129350](c)
end
P[129056]=function(c)
 local k=0
 do local value=255;c.open=255;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do c.open=169;c.s=c.x;k=k+2 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local value=191;c.open=191;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+11)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63829;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129365](c)
end
P[129068]=function(c)
 local k=0
 do local value=7;c.open=7;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local value=5;c.open=5;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local value=223;c.open=223;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+8)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63829;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129365](c)
end
P[129077]=function(c)
 local k=0
 do local value=248;c.open=248;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129079](c)
end
P[129079]=function(c)
 local k=0
 do c.open=221;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==6210 then return P[129090](c) end
 return P[129085](c)
end
P[129085]=function(c)
 local k=0
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
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
 if band(c.pc,8191)==6199 then return P[129079](c) end
 return P[129088](c)
end
P[129088]=function(c)
 local k=0
 local pc0=(c.pc+2)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(19))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==6229 then return P[129109](c) end
 return P[129090](c)
end
P[129090]=function(c)
 local k=0
 do local value=248;c.open=248;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129092](c)
end
P[129092]=function(c)
 local k=0
 do c.open=157;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=7;local base=1792;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);k=k+5 end
 do c.open=208;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);k=k+2 end
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
 if band(c.pc,8191)==6212 then return P[129092](c) end
 return P[129099](c)
end
P[129099]=function(c)
 local k=0
 do local value=200;c.open=200;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local addr=2016;write(c,addr,c.a);k=k+4 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local addr=2017;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+10)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129109](c)
end
P[129109]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=7;local addr=1792;write(c,addr,c.a);k=k+4 end
  local ret=(c.pc+7)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63755;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129291](c)
end
P[129117]=function(c)
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
P[129120]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63766;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129302](c)
end
P[129123]=function(c)
 local k=0
 do local value=3;c.open=3;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129125](c)
end
P[129125]=function(c)
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
 if band(c.pc,8191)==6269 then return P[129149](c) end
 return P[129144](c)
end
P[129144]=function(c)
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
 if band(c.pc,8191)==6245 then return P[129125](c) end
 return P[129147](c)
end
P[129147]=function(c)
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
 if band(c.pc,8191)==6272 then return P[129152](c) end
 return P[129149](c)
end
P[129149]=function(c)
 local k=0
  c.open=0;c.pc=0;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129152]=function(c)
 local k=0
 do local addr=26;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=52;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=52;write(c,addr,c.a);k=k+3 end
  c.open=248;c.pc=63616;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129152](c)
end
P[129161]=function(c)
 local k=0
 do c.open=72;push(c,bor(c.p,48));k=k+3 end
 do c.open=138;push(c,c.a);k=k+3 end
 do c.open=72;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=152;push(c,c.a);k=k+3 end
 do c.open=72;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=173;push(c,c.a);k=k+3 end
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=27;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 local pc0=(c.pc+13)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(76))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==6370 then return P[129250](c) end
 return P[129174](c)
end
P[129174]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63814;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129350](c)
end
P[129177]=function(c)
 local k=0
 do c.open=32;local addr=8195;write(c,addr,c.a);k=k+4 end
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do c.open=64;local addr=16404;write(c,addr,c.y);k=k+4 end
  local ret=(c.pc+10)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=204
 c.pc=52226;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117762](c)
end
P[129188]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=203
 c.pc=52016;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117552](c)
end
P[129191]=function(c)
 local k=0
 do local addr=254;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=32;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==6323 then return P[129203](c) end
 return P[129197](c)
end
P[129197]=function(c)
 local k=0
 do local addr=32;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==6323 then return P[129203](c) end
 return P[129201](c)
end
P[129201]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129203](c)
end
P[129203]=function(c)
 local k=0
 do c.open=32;local addr=8193;write(c,addr,c.a);k=k+4 end
  local ret=(c.pc+5)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63782;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129318](c)
end
P[129209]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=250
 c.pc=64206;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129742](c)
end
P[129212]=function(c)
 local k=0
 do local addr=27;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local value=18;c.open=18;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63881;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129417](c)
end
P[129219]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=128
 c.pc=32981;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129222]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=193
 c.pc=49597;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115133](c)
end
P[129225]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=192
 c.pc=49153;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[114689](c)
end
P[129228]=function(c)
 local k=0
 do local value=20;c.open=20;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
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
P[129233]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=145
 c.pc=37279;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129236]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=203
 c.pc=51998;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117534](c)
end
P[129239]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=27;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129243](c)
end
P[129243]=function(c)
 local k=0
 do c.open=168;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=104;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=170;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=104;c.x=c.a%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=40;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=64;read(c,256+c.s);c.p=bor(band(pop(c),239),32);k=k+4 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129249](c)
end
P[129249]=function(c)
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
P[129250]=function(c)
 local k=0
 do local addr=254;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=32;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;k=k+3 end
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
 if band(c.pc,8191)==6378 then return P[129258](c) end
 return P[129256](c)
end
P[129256]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129258](c)
end
P[129258]=function(c)
 local k=0
 do c.open=32;local addr=8193;write(c,addr,c.a);k=k+4 end
 do c.open=128;local addr=32768;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=165;push(c,c.a);k=k+3 end
 do local addr=27;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+11)%65536
 read(c,pc0)
 if band(c.p,128)~=0 then
  local t=(pc0+(8))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==6397 then return P[129277](c) end
 return P[129269](c)
end
