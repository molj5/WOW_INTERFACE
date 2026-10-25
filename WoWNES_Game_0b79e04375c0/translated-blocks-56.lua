local _,G=...;local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local interrupt=R.interrupt
local blockTick,blockLookup=R.blockTick,R.blockLookup
local P=G.blocks
P[114308]=function(c)
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
 return P[114434](c)
end
P[114434]=function(c)
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
 return P[114560](c)
end
P[114560]=function(c)
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
 return blockLookup(c)
end
P[114689]=function(c)
 local k=0
 do local addr=26;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do local addr=24;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==14 then return P[114702](c) end
 return P[114695](c)
end
P[114695]=function(c)
 local k=0
 do local value=3;c.open=3;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+2 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==14 then return P[114702](c) end
 return P[114699](c)
end
P[114699]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=194
 c.pc=49694;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115230](c)
end
P[114702]=function(c)
 local k=0
 do local addr=24;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=198
 c.pc=50930;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[116466](c)
end
P[114901]=function(c)
 local k=0
 do local addr=42;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
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
 if band(c.pc,8191)==219 then return P[114907](c) end
 return P[114905](c)
end
P[114905]=function(c)
 local k=0
 do local addr=42;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[114907](c)
end
P[114907]=function(c)
 local k=0
 do local addr=40;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 local pc0=(c.pc+4)%65536
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
 if band(c.pc,8191)==238 then return P[114926](c) end
 return P[114911](c)
end
P[114911]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=250
 c.pc=64130;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[129666](c)
end
P[114916]=function(c)
 local k=0
  c.open=193;c.pc=49503;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115039](c)
end
P[114926]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=101;c.p=flag(c.p,1,false);k=k+2 end
 do local addr=34;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;k=k+3 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do local value=8;c.open=8;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=26;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=10;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do c.open=5;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=0;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
  c.open=202;c.pc=51909;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[117445](c)
end
P[115039]=function(c)
 local k=0
 do local addr=25;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115048]=function(c)
 local k=0
 do local value=0;c.open=0;value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=31;write(c,addr,c.a);k=k+3 end
 do local addr=25;write(c,addr,c.a);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115055]=function(c)
 local k=0
 do local addr=24;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+4)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=193
 c.pc=49546;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115082](c)
end
P[115060]=function(c)
 local k=0
  c.open=193;c.pc=49512;k=k+3
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115048](c)
end
P[115082]=function(c)
 local k=0
 do local value=64;c.open=64;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local addr=42;write(c,addr,c.x);k=k+3 end
 do local value=2;c.open=2;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do local addr=43;write(c,addr,c.x);k=k+3 end
 read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret)
 c.pc=(ret+1)%65536;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return blockLookup(c)
end
P[115133]=function(c)
 local k=0
  local ret=(c.pc+2)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=193
 c.pc=49657;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115193](c)
end
P[115136]=function(c)
 local k=0
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=0;write(c,addr,c.a);k=k+3 end
 do local addr=5;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=1;write(c,addr,c.a);k=k+3 end
  local ret=(c.pc+10)%65536
 read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);c.open=193
 c.pc=49657;k=k+6
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115193](c)
end
P[115147]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115149](c)
end
P[115149]=function(c)
 local k=0
 do read(c,4);local addr=(4+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do read(c,0);local addr=(0+c.x)%256;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);k=k+4 end
 local pc0=(c.pc+6)%65536
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
 if band(c.pc,8191)==471 then return P[115159](c) end
 return P[115155](c)
end
P[115155]=function(c)
 local k=0
 do read(c,249);local addr=(249+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do read(c,4);local addr=(4+c.x)%256;write(c,addr,c.a);k=k+4 end
  c.pc=(c.pc+4)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115159](c)
end
P[115159]=function(c)
 local k=0
 do c.open=16;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+3)%65536
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
 if band(c.pc,8191)==461 then return P[115149](c) end
 return P[115162](c)
end
P[115162]=function(c)
 local k=0
 do local addr=29;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local value=4;c.open=4;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+2 end
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
 if band(c.pc,8191)==486 then return P[115174](c) end
 return P[115168](c)
end
P[115168]=function(c)
 local k=0
 do local addr=4;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+3 end
 do local addr=5;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do local addr=4;write(c,addr,c.a);k=k+3 end
  c.pc=(c.pc+6)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115174](c)
end
P[115174]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
  c.pc=(c.pc+2)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115176](c)
end
P[115176]=function(c)
 local k=0
 do read(c,4);local addr=(4+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do c.open=85;c.y=c.a%256;c.p=nz(c.p,c.y);k=k+2 end
 do read(c,249);local addr=(249+c.x)%256;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do read(c,4);local addr=(4+c.x)%256;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);k=k+4 end
 do read(c,245);local addr=(245+c.x)%256;write(c,addr,c.a);k=k+4 end
 do read(c,241);local addr=(241+c.x)%256;write(c,addr,c.y);k=k+4 end
 do read(c,249);local addr=(249+c.x)%256;write(c,addr,c.y);k=k+4 end
 do c.open=16;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 local pc0=(c.pc+16)%65536
 read(c,pc0)
 if band(c.p,128)==0 then
  local t=(pc0+(-16))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==488 then return P[115176](c) end
 return P[115192](c)
end
P[115192]=function(c)
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
P[115193]=function(c)
 local k=0
 do local value=1;c.open=1;value=value%256;c.p=nz(c.p,value);c.x=value;k=k+2 end
 do c.open=64;local addr=16406;write(c,addr,c.x);k=k+4 end
 do c.open=142;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);k=k+2 end
 do c.open=64;local addr=16406;write(c,addr,c.x);k=k+4 end
 do local value=8;c.open=8;value=value%256;c.p=nz(c.p,value);c.y=value;k=k+2 end
  c.pc=(c.pc+11)%65536
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 return P[115204](c)
end
P[115204]=function(c)
 local k=0
 do c.open=64;local addr=16406;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=7;write(c,addr,c.a);k=k+3 end
 do c.open=5;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=7;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=4;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=64;local addr=16407;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+4 end
 do local addr=7;write(c,addr,c.a);k=k+3 end
 do c.open=5;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=7;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);k=k+3 end
 do c.open=38;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;k=k+2 end
 do local addr=5;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);k=k+5 end
 do c.open=208;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);k=k+2 end
 local pc0=(c.pc+25)%65536
 read(c,pc0)
 if band(c.p,2)==0 then
  local t=(pc0+(-25))%65536
  if floor(pc0/256)~=floor(t/256) then read(c,floor(pc0/256)*256+t%256);k=k+4 else k=k+3 end
  c.pc=t
 else c.pc=pc0;k=k+2 end
 local st=blockTick(c,k)
 if st then
  if st==1 then return end
  return blockLookup(c)
 end
 if band(c.pc,8191)==516 then return P[115204](c) end
 return P[115229](c)
end
