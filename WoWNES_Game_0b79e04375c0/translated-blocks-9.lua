local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[81767]=function(c)
 local k=0
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
  c.pc=(c.pc+30)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[81797](c)
end
P[81797]=function(c)
 local k=0
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
  c.pc=(c.pc+120)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[81920]=function(c)
 local k=0
 do c.open=165;k=k+2 end
 do local addr=245;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=48;c.open=48;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+7)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(107))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==114 then return P[82034](c) end
 return P[81927](c)
end
P[81927]=function(c)
 local k=0
 do local addr=46;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
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
 if band(c.pc,8191)==13 then return P[81933](c) end
 return P[81931](c)
end
P[81931]=function(c)
 local k=0
 do local addr=46;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[81933](c)
end
P[81933]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[81935](c)
end
P[81935]=function(c)
 local k=0
 do local addr=26;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=144;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 local pc0=(c.pc+5)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(46))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==66 then return P[81986](c) end
 return P[81940](c)
end
P[81940]=function(c)
 local k=0
 do read(c,108);local addr=(108+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==64 then return P[81984](c) end
 return P[81944](c)
end
P[81944]=function(c)
 local k=0
 do local addr=48;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=133;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=10;c.a=c.x%256;c.p=nz(c.p,c.a);k=k+2 end
 do c.open=101;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=8;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do c.open=185;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=128;local base=32885;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=8;write(c,addr,c.a);k=k+3 end
 do c.open=128;local base=32886;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=9;write(c,addr,c.a);k=k+3 end
 do read(c,94);local addr=(94+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;k=k+4 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do local value=255;c.open=255;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+29)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(61))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==114 then return P[82034](c) end
 return P[81973](c)
end
P[81973]=function(c)
 local k=0
 do read(c,110);local addr=(110+c.x)%256;write(c,addr,c.a);k=k+4 end
 do c.open=177;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do local base=read(c,8)+256*read(c,(8+1)%256);local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+5 end
 do read(c,108);local addr=(108+c.x)%256;write(c,addr,c.a);k=k+4 end
 do c.open=152;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);k=k+2 end
 do c.open=149;c.a=c.y%256;c.p=nz(c.p,c.a);k=k+2 end
 do read(c,94);local addr=(94+c.x)%256;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+11)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[81984](c)
end
P[81984]=function(c)
 local k=0
 do read(c,108);local addr=(108+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[81986](c)
end
P[81986]=function(c)
 local k=0
 do read(c,110);local addr=(110+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do read(c,245);local addr=(245+c.x)%256;write(c,addr,c.a);k=k+4 end
 do read(c,241);local addr=(241+c.x)%256;write(c,addr,c.a);k=k+4 end
 do local addr=46;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=80;c.open=80;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+12)%65536
 read(c,pc0)
 if band(c.p,1)==0 then
  local t=(pc0+(32))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==110 then return P[82030](c) end
 return P[81998](c)
end
P[81998]=function(c)
 local k=0
 do read(c,170);local addr=(170+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=15;c.open=15;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do local value=1;c.open=1;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+8)%65536
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
 if band(c.pc,8191)==90 then return P[82010](c) end
 return P[82006](c)
end
P[82006]=function(c)
 local k=0
 do local value=4;c.open=4;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(8))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==98 then return P[82018](c) end
 return P[82010](c)
end
P[82010]=function(c)
 local k=0
 do read(c,241);local addr=(241+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=64;c.open=64;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do read(c,241);local addr=(241+c.x)%256;write(c,addr,c.a);k=k+4 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(12))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==110 then return P[82030](c) end
 return P[82018](c)
end
P[82018]=function(c)
 local k=0
 do local addr=26;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=7;c.open=7;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==110 then return P[82030](c) end
 return P[82024](c)
end
P[82024]=function(c)
 local k=0
 do read(c,245);local addr=(245+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local value=64;c.open=64;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
 do read(c,245);local addr=(245+c.x)%256;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[82030](c)
end
P[82030]=function(c)
 local k=0
 do c.open=16;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-98))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==15 then return P[81935](c) end
 return P[82033](c)
end
P[82033]=function(c)
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
P[82034]=function(c)
 local k=0
 do local addr=31;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[82133]=function(c)
 local k=0
  c.open=0;c.pc=(c.pc+2)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[82846]=function(c)
 local k=0
 do local addr=45;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[82918]=function(c)
 local k=0
 do read(c,32);local addr=(32+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 do c.open=249;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);k=k+4 end
 do c.open=42;local base=10950;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+4 end
 local pc0=(c.pc+8)%65536
 read(c,pc0)
 if band(c.p,2)~=0 then
  local t=(pc0+(-80))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==926 then return P[82846](c) end
 return P[82926](c)
end
P[82926]=function(c)
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
P[83737]=function(c)
 local k=0
 do read(c,88);local addr=(88+c.y)%256;write(c,addr,band(c.a,c.x));k=k+4 end
 do c.open=87;local base=22358;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do read(c,92);local addr=(92+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 do c.open=90;local base=23135;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+7 end
 do read(c,86);local addr=(86+c.x)%256;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+6 end
 do read(c,88);local addr=(88+c.x)%256;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);k=k+6 end
 do c.open=89;local base=22872;local addr=(base+c.y)%65536;if floor(base/256)~=floor(addr/256) then read(c,floor(base/256)*256+addr%256);k=k+1 end;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do read(c,151);local addr=(151+c.y)%256;write(c,addr,c.x);k=k+4 end
 do read(c,0);local addr=(0+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+6 end
 do local value=160;c.open=160;k=k+2 end
 do local value=4;c.open=4;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.open=132;c.pc=(c.pc+27)%65536;k=k+interrupt(c,65534,true)
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[86431]=function(c)
 local k=0
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
  c.pc=(c.pc+126)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[86557](c)
end
P[86557]=function(c)
 local k=0
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
 do c.open=255;local base=65535;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);k=k+7 end
  c.pc=(c.pc+126)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[86683](c)
end
