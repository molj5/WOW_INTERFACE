local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[129269]=function(c)
 local k=0
 do local value=18;c.open=18;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63887;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129423](c)
end
P[129274]=function(c)
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
P[129277]=function(c)
 local k=0
 do c.open=168;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=32;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63887;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129423](c)
end
P[129282]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63795;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129331](c)
end
P[129285]=function(c)
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
P[129288]=function(c)
 local k=0
  c.open=248;c.pc=63707;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129243](c)
end
P[129291]=function(c)
 local k=0
 do local value=15;c.open=15;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=64;local addr=16405;write(c,addr,c.a);k=k+4 end
 do local value=192;c.open=192;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=64;local addr=16407;write(c,addr,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129302]=function(c)
 local k=0
 do local value=5;c.open=5;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=32;write(c,addr,c.a);k=k+3 end
 do local value=176;c.open=176;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=255;write(c,addr,c.a);k=k+3 end
 do c.open=32;local addr=8192;write(c,addr,c.a);k=k+4 end
 do local value=5;c.open=5;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=32;write(c,addr,c.a);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129318]=function(c)
 local k=0
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=32;c.open=32;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+13)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129331](c)
end
P[129331]=function(c)
 local k=0
 do c.open=32;local addr=8194;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=253;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=32;local addr=8197;write(c,addr,c.a);k=k+4 end
 do local addr=252;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=32;local addr=8197;write(c,addr,c.a);k=k+4 end
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
P[129350]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=32;local addr=8198;write(c,addr,c.a);k=k+4 end
 do c.open=32;local addr=8192;write(c,addr,c.a);k=k+4 end
 do c.open=32;local addr=8193;write(c,addr,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129365]=function(c)
 local k=0
 do local addr=1;write(c,addr,c.a);k=k+3 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129371](c)
end
P[129371]=function(c)
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
P[129373]=function(c)
 local k=0
 do c.open=192;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local value=255;c.open=255;c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+5)%65536
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
 if band(c.pc,8191)==6491 then return P[129371](c) end
 return P[129378](c)
end
P[129378]=function(c)
 local k=0
 do local addr=1;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=16;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-12))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==6491 then return P[129371](c) end
 return P[129383](c)
end
P[129383]=function(c)
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
P[129417]=function(c)
 local k=0
 do c.open=128;local addr=32768;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local addr=2028;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129423](c)
end
P[129423]=function(c)
 local k=0
 do c.open=128;local addr=32768;write(c,addr,c.y);k=k+4 end
  c.pc=(c.pc+3)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129426]=function(c)
 local k=0
 do c.open=140;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=160;local addr=40960;write(c,addr,c.y);k=k+4 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129430]=function(c)
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
P[129431]=function(c)
 local k=0
 do c.open=7;local addr=2028;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
  c.open=249;c.pc=63887;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129423](c)
end
P[129437]=function(c)
 local k=0
 do c.open=152;push(c,c.a);k=k+3 end
 do c.open=72;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=173;push(c,c.a);k=k+3 end
 do c.open=128;local addr=32768;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=7;local addr=2029;write(c,addr,c.a);k=k+4 end
 do local value=18;c.open=18;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+13)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63887;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129423](c)
end
P[129451]=function(c)
 local k=0
 do c.open=168;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=104;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=96;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129455]=function(c)
 local k=0
 do c.open=152;push(c,c.a);k=k+3 end
 do c.open=72;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=172;push(c,c.a);k=k+3 end
 do c.open=7;local addr=2029;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
  local ret=(c.pc+8)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63887;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129423](c)
end
P[129464]=function(c)
 local k=0
 do c.open=168;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=104;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=96;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129468]=function(c)
 local k=0
 do c.open=165;push(c,c.a);k=k+3 end
 do local addr=27;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=128;c.open=128;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=27;write(c,addr,c.a);k=k+3 end
 do c.open=32;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
  local ret=(c.pc+10)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63901;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129437](c)
end
P[129479]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=135
 c.pc=34722;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129482]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63919;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129455](c)
end
P[129485]=function(c)
 local k=0
 do local addr=27;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=127;c.open=127;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local addr=27;write(c,addr,c.a);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129492]=function(c)
 local k=0
 do local addr=247;write(c,addr,c.y);k=k+3 end
 do local value=18;c.open=18;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63901;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129437](c)
end
P[129499]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=135
 c.pc=34585;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129502]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63919;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129455](c)
end
P[129505]=function(c)
 local k=0
 do local addr=247;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129508]=function(c)
 local k=0
 do local addr=243;write(c,addr,c.a);k=k+3 end
 do local addr=247;write(c,addr,c.y);k=k+3 end
 do local value=22;c.open=22;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  local ret=(c.pc+8)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63881;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129417](c)
end
P[129517]=function(c)
 local k=0
 do local addr=243;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=247;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+3 end
  local ret=(c.pc+6)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=195
 c.pc=50129;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115665](c)
end
P[129524]=function(c)
 local k=0
  c.open=249;c.pc=63895;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129431](c)
end
P[129666]=function(c)
 local k=0
 do local value=24;c.open=24;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
 do c.open=32;push(c,c.a);k=k+3 end
  local ret=(c.pc+5)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=249
 c.pc=63881;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129417](c)
end
P[129672]=function(c)
 local k=0
 do c.open=76;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
  c.open=145;c.pc=37337;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[129742]=function(c)
 local k=0
 do c.open=7;local addr=2032;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=176;local addr=45056;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=176;local addr=45057;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2033;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=176;local addr=45058;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=176;local addr=45059;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2034;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=192;local addr=49152;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=192;local addr=49153;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2035;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=192;local addr=49154;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=192;local addr=49155;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2036;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=208;local addr=53248;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=208;local addr=53249;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2037;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=208;local addr=53250;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=208;local addr=53251;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2038;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=224;local addr=57344;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=224;local addr=57345;write(c,addr,c.a);k=k+4 end
 do c.open=7;local addr=2039;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=224;local addr=57346;write(c,addr,c.a);k=k+4 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=74;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=141;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=224;local addr=57347;write(c,addr,c.a);k=k+4 end
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=144;local addr=36864;write(c,addr,c.a);k=k+4 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
