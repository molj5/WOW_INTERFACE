local R=WoWNES_Runtime;R.ops={[0]={"BRK","imp",1,7,false},[1]={"ORA","izx",2,6,false},[5]={"ORA","zp",2,3,false},[6]={"ASL","zp",2,5,false},[8]={"PHP","imp",1,3,false},[9]={"ORA","imm",2,2,false},[10]={"ASL","acc",1,2,false},[13]={"ORA","abs",3,4,false},[14]={"ASL","abs",3,6,false},[16]={"BPL","rel",2,2,false},[17]={"ORA","izy",2,5,true},[21]={"ORA","zpx",2,4,false},[22]={"ASL","zpx",2,6,false},[24]={"CLC","imp",1,2,false},[25]={"ORA","aby",3,4,true},[29]={"ORA","abx",3,4,true},[30]={"ASL","abx",3,7,false},[32]={"JSR","abs",3,6,false},[33]={"AND","izx",2,6,false},[36]={"BIT","zp",2,3,false},[37]={"AND","zp",2,3,false},[38]={"ROL","zp",2,5,false},[40]={"PLP","imp",1,4,false},[41]={"AND","imm",2,2,false},[42]={"ROL","acc",1,2,false},[44]={"BIT","abs",3,4,false},[45]={"AND","abs",3,4,false},[46]={"ROL","abs",3,6,false},[48]={"BMI","rel",2,2,false},[49]={"AND","izy",2,5,true},[53]={"AND","zpx",2,4,false},[54]={"ROL","zpx",2,6,false},[56]={"SEC","imp",1,2,false},[57]={"AND","aby",3,4,true},[61]={"AND","abx",3,4,true},[62]={"ROL","abx",3,7,false},[64]={"RTI","imp",1,6,false},[65]={"EOR","izx",2,6,false},[69]={"EOR","zp",2,3,false},[70]={"LSR","zp",2,5,false},[72]={"PHA","imp",1,3,false},[73]={"EOR","imm",2,2,false},[74]={"LSR","acc",1,2,false},[76]={"JMP","abs",3,3,false},[77]={"EOR","abs",3,4,false},[78]={"LSR","abs",3,6,false},[80]={"BVC","rel",2,2,false},[81]={"EOR","izy",2,5,true},[85]={"EOR","zpx",2,4,false},[86]={"LSR","zpx",2,6,false},[88]={"CLI","imp",1,2,false},[89]={"EOR","aby",3,4,true},[93]={"EOR","abx",3,4,true},[94]={"LSR","abx",3,7,false},[96]={"RTS","imp",1,6,false},[97]={"ADC","izx",2,6,false},[101]={"ADC","zp",2,3,false},[102]={"ROR","zp",2,5,false},[104]={"PLA","imp",1,4,false},[105]={"ADC","imm",2,2,false},[106]={"ROR","acc",1,2,false},[108]={"JMP","ind",3,5,false},[109]={"ADC","abs",3,4,false},[110]={"ROR","abs",3,6,false},[112]={"BVS","rel",2,2,false},[113]={"ADC","izy",2,5,true},[117]={"ADC","zpx",2,4,false},[118]={"ROR","zpx",2,6,false},[120]={"SEI","imp",1,2,false},[121]={"ADC","aby",3,4,true},[125]={"ADC","abx",3,4,true},[126]={"ROR","abx",3,7,false},[129]={"STA","izx",2,6,false},[132]={"STY","zp",2,3,false},[133]={"STA","zp",2,3,false},[134]={"STX","zp",2,3,false},[136]={"DEY","imp",1,2,false},[138]={"TXA","imp",1,2,false},[140]={"STY","abs",3,4,false},[141]={"STA","abs",3,4,false},[142]={"STX","abs",3,4,false},[144]={"BCC","rel",2,2,false},[145]={"STA","izy",2,6,false},[148]={"STY","zpx",2,4,false},[149]={"STA","zpx",2,4,false},[150]={"STX","zpy",2,4,false},[152]={"TYA","imp",1,2,false},[153]={"STA","aby",3,5,false},[154]={"TXS","imp",1,2,false},[157]={"STA","abx",3,5,false},[160]={"LDY","imm",2,2,false},[161]={"LDA","izx",2,6,false},[162]={"LDX","imm",2,2,false},[164]={"LDY","zp",2,3,false},[165]={"LDA","zp",2,3,false},[166]={"LDX","zp",2,3,false},[168]={"TAY","imp",1,2,false},[169]={"LDA","imm",2,2,false},[170]={"TAX","imp",1,2,false},[172]={"LDY","abs",3,4,false},[173]={"LDA","abs",3,4,false},[174]={"LDX","abs",3,4,false},[176]={"BCS","rel",2,2,false},[177]={"LDA","izy",2,5,true},[180]={"LDY","zpx",2,4,false},[181]={"LDA","zpx",2,4,false},[182]={"LDX","zpy",2,4,false},[184]={"CLV","imp",1,2,false},[185]={"LDA","aby",3,4,true},[186]={"TSX","imp",1,2,false},[188]={"LDY","abx",3,4,true},[189]={"LDA","abx",3,4,true},[190]={"LDX","aby",3,4,true},[192]={"CPY","imm",2,2,false},[193]={"CMP","izx",2,6,false},[196]={"CPY","zp",2,3,false},[197]={"CMP","zp",2,3,false},[198]={"DEC","zp",2,5,false},[200]={"INY","imp",1,2,false},[201]={"CMP","imm",2,2,false},[202]={"DEX","imp",1,2,false},[204]={"CPY","abs",3,4,false},[205]={"CMP","abs",3,4,false},[206]={"DEC","abs",3,6,false},[208]={"BNE","rel",2,2,false},[209]={"CMP","izy",2,5,true},[213]={"CMP","zpx",2,4,false},[214]={"DEC","zpx",2,6,false},[216]={"CLD","imp",1,2,false},[217]={"CMP","aby",3,4,true},[221]={"CMP","abx",3,4,true},[222]={"DEC","abx",3,7,false},[224]={"CPX","imm",2,2,false},[225]={"SBC","izx",2,6,false},[228]={"CPX","zp",2,3,false},[229]={"SBC","zp",2,3,false},[230]={"INC","zp",2,5,false},[232]={"INX","imp",1,2,false},[233]={"SBC","imm",2,2,false},[234]={"NOP","imp",1,2,false},[236]={"CPX","abs",3,4,false},[237]={"SBC","abs",3,4,false},[238]={"INC","abs",3,6,false},[240]={"BEQ","rel",2,2,false},[241]={"SBC","izy",2,5,true},[245]={"SBC","zpx",2,4,false},[246]={"INC","zpx",2,6,false},[248]={"SED","imp",1,2,false},[249]={"SBC","aby",3,4,true},[253]={"SBC","abx",3,4,true},[254]={"INC","abx",3,7,false},[4]={"NOP","zp",2,3,false},[68]={"NOP","zp",2,3,false},[100]={"NOP","zp",2,3,false},[12]={"NOP","abs",3,4,false},[20]={"NOP","abx",3,4,true},[52]={"NOP","abx",3,4,true},[84]={"NOP","abx",3,4,true},[116]={"NOP","abx",3,4,true},[212]={"NOP","abx",3,4,true},[244]={"NOP","abx",3,4,true},[128]={"NOP","imm",2,2,false},[130]={"NOP","imm",2,2,false},[137]={"NOP","imm",2,2,false},[194]={"NOP","imm",2,2,false},[26]={"NOP","imp",1,2,false},[58]={"NOP","imp",1,2,false},[90]={"NOP","imp",1,2,false},[122]={"NOP","imp",1,2,false},[218]={"NOP","imp",1,2,false},[250]={"NOP","imp",1,2,false},[163]={"LAX","izx",2,6,false},[167]={"LAX","zp",2,3,false},[175]={"LAX","abs",3,4,false},[179]={"LAX","izy",2,5,true},[183]={"LAX","zpy",2,4,false},[191]={"LAX","aby",3,4,true},[131]={"SAX","izx",2,6,false},[135]={"SAX","zp",2,3,false},[143]={"SAX","abs",3,4,false},[151]={"SAX","zpy",2,4,false},[199]={"DCP","zp",2,5,false},[207]={"DCP","abs",3,6,false},[211]={"DCP","izy",2,8,false},[215]={"DCP","zpx",2,6,false},[219]={"DCP","aby",3,7,false},[223]={"DCP","abx",3,7,false},[231]={"ISB","zp",2,5,false},[239]={"ISB","abs",3,6,false},[243]={"ISB","izy",2,8,false},[247]={"ISB","zpx",2,6,false},[251]={"ISB","aby",3,7,false},[255]={"ISB","abx",3,7,false},[7]={"SLO","zp",2,5,false},[15]={"SLO","abs",3,6,false},[19]={"SLO","izy",2,8,false},[23]={"SLO","zpx",2,6,false},[27]={"SLO","aby",3,7,false},[31]={"SLO","abx",3,7,false},[39]={"RLA","zp",2,5,false},[47]={"RLA","abs",3,6,false},[51]={"RLA","izy",2,8,false},[55]={"RLA","zpx",2,6,false},[59]={"RLA","aby",3,7,false},[63]={"RLA","abx",3,7,false},[71]={"SRE","zp",2,5,false},[79]={"SRE","abs",3,6,false},[83]={"SRE","izy",2,8,false},[87]={"SRE","zpx",2,6,false},[91]={"SRE","aby",3,7,false},[95]={"SRE","abx",3,7,false},[103]={"RRA","zp",2,5,false},[111]={"RRA","abs",3,6,false},[115]={"RRA","izy",2,8,false},[119]={"RRA","zpx",2,6,false},[123]={"RRA","aby",3,7,false},[127]={"RRA","abx",3,7,false}}

local R=WoWNES_Runtime
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local function has(p,m) return band(p,m)~=0 end
function R.interrupt(c,vector,brk)
 if not brk then R.read(c,c.pc);R.read(c,c.pc) end
 R.push(c,math.floor(c.pc/256));R.push(c,c.pc%256)
 R.push(c,R.flag(bor(c.p,32),16,brk));c.p=bor(c.p,4)
 c.pc=R.word(c,vector);return 7
end
function R.execute(c,op,operand)
 local m=R.ops[op]
 if not m then error(string.format("Unsupported unofficial opcode %02X at %04X",op,c.pc)) end
 local name,mode,len,cycles,page=m[1],m[2],m[3],m[4],m[5]
 -- Operand reads occur in every backend, preserving CPU bus side effects.
 local pc=c.pc
 if name=="JSR" then
  local lo=R.read(c,(pc+1)%65536);local ret=(pc+2)%65536
  R.read(c,256+c.s);R.push(c,math.floor(ret/256));R.push(c,ret%256)
  local hi=R.read(c,ret);c.pc=lo+256*hi;return cycles
 end
 if mode=="imp" or mode=="acc" then
  if name~="BRK" then R.read(c,(pc+1)%65536) end
 end
 if operand==nil then
  operand=0
  if len>1 then operand=R.read(c,(pc+1)%65536) end
  if len>2 then operand=operand+256*R.read(c,(pc+2)%65536) end
 else
  if len>1 then R.read(c,(pc+1)%65536) end
  if len>2 then R.read(c,(pc+2)%65536) end
 end
 c.pc=(pc+len)%65536
 local addr,base,value
 if mode=="zp" then addr=operand
 elseif mode=="zpx" then R.read(c,operand);addr=(operand+c.x)%256
 elseif mode=="zpy" then R.read(c,operand);addr=(operand+c.y)%256
 elseif mode=="abs" then addr=operand
 elseif mode=="abx" then base=operand;addr=(base+c.x)%65536
 elseif mode=="aby" then base=operand;addr=(base+c.y)%65536
 elseif mode=="izx" then
  R.read(c,operand);local z=(operand+c.x)%256
  addr=R.read(c,z)+256*R.read(c,(z+1)%256)
 elseif mode=="izy" then
  base=R.read(c,operand)+256*R.read(c,(operand+1)%256);addr=(base+c.y)%65536
 elseif mode=="ind" then addr=R.read(c,operand)+256*R.read(c,math.floor(operand/256)*256+(operand+1)%256) end
 if base then
  local crossed=math.floor(base/256)~=math.floor(addr/256)
  if page and crossed then cycles=cycles+1 end
  if crossed or not page then R.read(c,math.floor(base/256)*256+addr%256) end
 end
 local store=name=="STA" or name=="STX" or name=="STY"
 local flow=name=="JMP" or name=="JSR"
 if mode=="imm" then value=operand
 elseif mode=="acc" then value=c.a
 elseif addr and not store and not flow then value=R.read(c,addr) end
 local function nz(v) v=v%256;c.p=R.nz(c.p,v);return v end
 local function compare(a,b) c.p=R.flag(c.p,1,a>=b);nz((a-b)%256) end
 if name=="LDA" then c.a=nz(value)
 elseif name=="LDX" then c.x=nz(value)
 elseif name=="LDY" then c.y=nz(value)
 elseif name=="STA" then R.write(c,addr,c.a)
 elseif name=="STX" then R.write(c,addr,c.x)
 elseif name=="STY" then R.write(c,addr,c.y)
 elseif name=="ORA" then c.a=nz(bor(c.a,value))
 elseif name=="AND" then c.a=nz(band(c.a,value))
 elseif name=="EOR" then c.a=nz(bxor(c.a,value))
 elseif name=="ADC" or name=="SBC" then
  local b=value;if name=="SBC" then b=255-b end
  local sum=c.a+b+(has(c.p,1) and 1 or 0);local result=sum%256
  c.p=R.flag(c.p,1,sum>255)
  c.p=R.flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0)
  c.a=nz(result)
 elseif name=="CMP" then compare(c.a,value)
 elseif name=="CPX" then compare(c.x,value)
 elseif name=="CPY" then compare(c.y,value)
 elseif name=="BIT" then
  c.p=R.flag(R.flag(R.flag(c.p,2,band(c.a,value)==0),64,has(value,64)),128,has(value,128))
 elseif name=="ASL" or name=="LSR" or name=="ROL" or name=="ROR" or name=="INC" or name=="DEC" then
  local old=value;local carry=has(c.p,1) and 1 or 0
  if name=="ASL" or name=="ROL" then
   c.p=R.flag(c.p,1,value>=128);value=value*2+(name=="ROL" and carry or 0)
  elseif name=="LSR" or name=="ROR" then
   c.p=R.flag(c.p,1,value%2==1);value=math.floor(value/2)+(name=="ROR" and carry*128 or 0)
  elseif name=="INC" then value=value+1 else value=value-1 end
  value=nz(value)
  if mode=="acc" then c.a=value else R.write(c,addr,old);R.write(c,addr,value) end
 elseif mode=="rel" then
  local mask=({BPL=128,BMI=128,BVC=64,BVS=64,BCC=1,BCS=1,BNE=2,BEQ=2})[name]
  local positive=name=="BMI" or name=="BVS" or name=="BCS" or name=="BEQ"
  if has(c.p,mask)==positive then
   local target=(c.pc+(operand<128 and operand or operand-256))%65536
   R.read(c,c.pc);cycles=cycles+1
   if math.floor(target/256)~=math.floor(c.pc/256) then
    R.read(c,math.floor(c.pc/256)*256+target%256);cycles=cycles+1
   end
   c.pc=target
  end
 elseif name=="JMP" then c.pc=addr
 elseif name=="RTS" then
  R.read(c,256+c.s);local lo=R.pop(c);local hi=R.pop(c)
  local ret=lo+256*hi;R.read(c,ret);c.pc=(ret+1)%65536
 elseif name=="RTI" then
  R.read(c,256+c.s);c.p=bor(band(R.pop(c),239),32)
  local lo=R.pop(c);local hi=R.pop(c);c.pc=lo+256*hi
 elseif name=="BRK" then R.read(c,c.pc);c.pc=(c.pc+1)%65536;return R.interrupt(c,65534,true)
 elseif name=="PHA" then R.push(c,c.a)
 elseif name=="PHP" then R.push(c,bor(c.p,48))
 elseif name=="PLA" then R.read(c,256+c.s);c.a=nz(R.pop(c))
 elseif name=="PLP" then R.read(c,256+c.s);c.p=bor(band(R.pop(c),239),32)
 elseif name=="TAX" then c.x=nz(c.a)
 elseif name=="TAY" then c.y=nz(c.a)
 elseif name=="TXA" then c.a=nz(c.x)
 elseif name=="TYA" then c.a=nz(c.y)
 elseif name=="TSX" then c.x=nz(c.s)
 elseif name=="TXS" then c.s=c.x
 elseif name=="INX" then c.x=nz(c.x+1)
 elseif name=="INY" then c.y=nz(c.y+1)
 elseif name=="DEX" then c.x=nz(c.x-1)
 elseif name=="DEY" then c.y=nz(c.y-1)
 elseif name=="CLC" then c.p=R.flag(c.p,1,false)
 elseif name=="SEC" then c.p=R.flag(c.p,1,true)
 elseif name=="CLI" then c.p=R.flag(c.p,4,false)
 elseif name=="SEI" then c.p=R.flag(c.p,4,true)
 elseif name=="CLD" then c.p=R.flag(c.p,8,false)
 elseif name=="SED" then c.p=R.flag(c.p,8,true)
 elseif name=="CLV" then c.p=R.flag(c.p,64,false) end
 return cycles
end
function R.step(c,backend)
 local n
 if c.nmi then c.nmi=false;n=R.interrupt(c,65530,false)
 elseif c.irqAny and band(c.p,4)==0 then n=R.interrupt(c,65534,false)
 else
  local pc=c.pc
  if backend ~= "interpreter" and pc >= 32768 then
   local f=c.g.blocks[c.prgB[math.floor(pc/8192)-3]+band(pc,8191)]
   if f then
    -- Block chain: blockTick drives cycles/PPU/peripherals per block and the
    -- chain unwinds to the scheduler when the slice budget is exhausted.
    -- R.slice (cycles) bounds chain latency; tests shrink it to align the
    -- block path with the per-instruction closure path.
    c.tickFinish=c.cycles+(R.slice or 2048);c.stats.block=c.stats.block+1
    return f(c)
   end
  end
  local op
  if pc>=32768 then
   op=string.byte(c.g.prg,c.prgB[math.floor(pc/8192)-3]+band(pc,0x1FFF)+1);c.open=op
  else op=R.read(c,pc) end
  local f=R.exec[op]
  if f then n=f(c);c.stats.ir=c.stats.ir+1
  else n=R.execute(c,op);c.stats.fallback=c.stats.fallback+1 end
 end
 n=n+c.stall;c.stall=0;c.cycles=c.cycles+n
 R.ppuTick(c,n*3);R.periphTick(c,n);return n
end

local band,bor,bxor=bit.band,bit.bor,bit.bxor
local floor=math.floor
local read,write,push,pop=R.read,R.write,R.push,R.pop
local flag,nz=R.flag,R.nz
local E={}
E[0]=function(c) local pc=c.pc;c.pc=(pc+1)%65536;read(c,c.pc);c.pc=(c.pc+1)%65536;return R.interrupt(c,65534,true) end
E[1]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return 6 end
E[4]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);return 3 end
E[5]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return 3 end
E[6]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 5 end
E[7]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 5 end
E[8]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;push(c,bor(c.p,48));return 3 end
E[9]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return 2 end
E[10]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);c.a=value;return 2 end
E[12]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);return 4 end
E[13]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return 4 end
E[14]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[15]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 6 end
E[16]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,128)==0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[17]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[19]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 8 end
E[20]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);return cyc end
E[21]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return 4 end
E[22]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[23]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 6 end
E[24]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,1,false);return 2 end
E[25]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[26]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[27]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 7 end
E[29]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[30]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 7 end
E[31]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value>=128);value=value*2%256;c.a=bor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 7 end
E[32]=function(c) local pc=c.pc;local lo=read(c,(pc+1)%65536);local ret=(pc+2)%65536;read(c,256+c.s);push(c,floor(ret/256));push(c,ret%256);local hi=read(c,ret);c.pc=lo+256*hi;return 6 end
E[33]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return 6 end
E[36]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.p=flag(flag(flag(c.p,2,band(c.a,value)==0),64,band(value,64)~=0),128,band(value,128)~=0);return 3 end
E[37]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return 3 end
E[38]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 5 end
E[39]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 5 end
E[40]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;read(c,256+c.s);c.p=bor(band(pop(c),239),32);return 4 end
E[41]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return 2 end
E[42]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);c.a=value;return 2 end
E[44]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.p=flag(flag(flag(c.p,2,band(c.a,value)==0),64,band(value,64)~=0),128,band(value,128)~=0);return 4 end
E[45]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return 4 end
E[46]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[47]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 6 end
E[48]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,128)~=0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[49]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[51]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 8 end
E[52]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);return cyc end
E[53]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return 4 end
E[54]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[55]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 6 end
E[56]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,1,true);return 2 end
E[57]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[58]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[59]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 7 end
E[61]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[62]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=value*2+carry;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 7 end
E[63]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value>=128);value=(value*2+carry)%256;c.a=band(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 7 end
E[64]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;read(c,256+c.s);c.p=bor(band(pop(c),239),32);local lo=pop(c);local hi=pop(c);c.pc=lo+256*hi;return 6 end
E[65]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return 6 end
E[68]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);return 3 end
E[69]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return 3 end
E[70]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 5 end
E[71]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 5 end
E[72]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;push(c,c.a);return 3 end
E[73]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return 2 end
E[74]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);c.a=value;return 2 end
E[76]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;c.pc=operand;return 3 end
E[77]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return 4 end
E[78]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[79]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 6 end
E[80]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,64)==0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[81]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[83]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 8 end
E[84]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);return cyc end
E[85]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return 4 end
E[86]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[87]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 6 end
E[88]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,4,false);return 2 end
E[89]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[90]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[91]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 7 end
E[93]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);return cyc end
E[94]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2);value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 7 end
E[95]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;c.p=flag(c.p,1,value%2==1);value=floor(value/2);c.a=bxor(c.a,value)%256;c.p=nz(c.p,c.a);write(c,addr,old);write(c,addr,value);return 7 end
E[96]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;read(c,256+c.s);local lo=pop(c);local hi=pop(c);local ret=lo+256*hi;read(c,ret);c.pc=(ret+1)%65536;return 6 end
E[97]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 6 end
E[100]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);return 3 end
E[101]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 3 end
E[102]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 5 end
E[103]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 5 end
E[104]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;read(c,256+c.s);c.a=pop(c)%256;c.p=nz(c.p,c.a);return 4 end
E[105]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 2 end
E[106]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;local value=c.a;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);c.a=value;return 2 end
E[108]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=read(c,operand)+256*read(c,floor(operand/256)*256+(operand+1)%256);c.pc=addr;return 5 end
E[109]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 4 end
E[110]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[111]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 6 end
E[112]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,64)~=0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[113]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return cyc end
E[115]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 8 end
E[116]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);return cyc end
E[117]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 4 end
E[118]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[119]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 6 end
E[120]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,4,true);return 2 end
E[121]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return cyc end
E[122]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[123]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 7 end
E[125]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;return cyc end
E[126]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=floor(value/2)+carry*128;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 7 end
E[127]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;c.p=flag(c.p,1,value%2==1);value=(floor(value/2)+carry*128)%256;local sum=c.a+value+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(value,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 7 end
E[128]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;return 2 end
E[129]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,c.a);return 6 end
E[130]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;return 2 end
E[131]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);write(c,addr,band(c.a,c.x));return 6 end
E[132]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;write(c,addr,c.y);return 3 end
E[133]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;write(c,addr,c.a);return 3 end
E[134]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;write(c,addr,c.x);return 3 end
E[135]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;write(c,addr,band(c.a,c.x));return 3 end
E[136]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.y=(c.y-1)%256;c.p=nz(c.p,c.y);return 2 end
E[137]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;return 2 end
E[138]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.a=c.x%256;c.p=nz(c.p,c.a);return 2 end
E[140]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;write(c,addr,c.y);return 4 end
E[141]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;write(c,addr,c.a);return 4 end
E[142]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;write(c,addr,c.x);return 4 end
E[143]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;write(c,addr,band(c.a,c.x));return 4 end
E[144]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,1)==0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[145]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);return 6 end
E[148]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;write(c,addr,c.y);return 4 end
E[149]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;write(c,addr,c.a);return 4 end
E[150]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.y)%256;write(c,addr,c.x);return 4 end
E[151]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.y)%256;write(c,addr,band(c.a,c.x));return 4 end
E[152]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.a=c.y%256;c.p=nz(c.p,c.a);return 2 end
E[153]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);return 5 end
E[154]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.s=c.x;return 2 end
E[157]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);write(c,addr,c.a);return 5 end
E[160]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;value=value%256;c.p=nz(c.p,value);c.y=value;return 2 end
E[161]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return 6 end
E[162]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;value=value%256;c.p=nz(c.p,value);c.x=value;return 2 end
E[163]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value;return 6 end
E[164]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;return 3 end
E[165]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return 3 end
E[166]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;return 3 end
E[167]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value;return 3 end
E[168]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.y=c.a%256;c.p=nz(c.p,c.y);return 2 end
E[169]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;value=value%256;c.p=nz(c.p,value);c.a=value;return 2 end
E[170]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.x=c.a%256;c.p=nz(c.p,c.x);return 2 end
E[172]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;return 4 end
E[173]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return 4 end
E[174]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;return 4 end
E[175]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value;return 4 end
E[176]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,1)~=0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[177]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return cyc end
E[179]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value;return cyc end
E[180]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;return 4 end
E[181]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return 4 end
E[182]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.y)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;return 4 end
E[183]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.y)%256;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value;return 4 end
E[184]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,64,false);return 2 end
E[185]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return cyc end
E[186]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.x=c.s%256;c.p=nz(c.p,c.x);return 2 end
E[188]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.y=value;return cyc end
E[189]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;return cyc end
E[190]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.x=value;return cyc end
E[191]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);value=value%256;c.p=nz(c.p,value);c.a=value;c.x=value;return cyc end
E[192]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);return 2 end
E[193]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return 6 end
E[194]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;return 2 end
E[196]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);return 3 end
E[197]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return 3 end
E[198]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 5 end
E[199]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);return 5 end
E[200]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.y=(c.y+1)%256;c.p=nz(c.p,c.y);return 2 end
E[201]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return 2 end
E[202]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.x=(c.x-1)%256;c.p=nz(c.p,c.x);return 2 end
E[204]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.p=flag(c.p,1,c.y>=value);local d=(c.y-value)%256;c.p=nz(c.p,d);return 4 end
E[205]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return 4 end
E[206]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[207]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);return 6 end
E[208]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,2)==0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[209]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return cyc end
E[211]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);return 8 end
E[212]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);return cyc end
E[213]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return 4 end
E[214]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[215]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);return 6 end
E[216]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,8,false);return 2 end
E[217]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return cyc end
E[218]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[219]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);return 7 end
E[221]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);c.p=flag(c.p,1,c.a>=value);local d=(c.a-value)%256;c.p=nz(c.p,d);return cyc end
E[222]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value-1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 7 end
E[223]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value-1)%256;c.p=flag(c.p,1,c.a>=value);c.p=nz(c.p,(c.a-value)%256);write(c,addr,old);write(c,addr,value);return 7 end
E[224]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);return 2 end
E[225]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local z=(operand+c.x)%256;local addr=read(c,z)+256*read(c,(z+1)%256);local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 6 end
E[228]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);return 3 end
E[229]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 3 end
E[230]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 5 end
E[231]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local addr=operand;local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 5 end
E[232]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.x=(c.x+1)%256;c.p=nz(c.p,c.x);return 2 end
E[233]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local value=operand;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 2 end
E[234]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[236]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);c.p=flag(c.p,1,c.x>=value);local d=(c.x-value)%256;c.p=nz(c.p,d);return 4 end
E[237]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 4 end
E[238]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[239]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local addr=operand;local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 6 end
E[240]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;if band(c.p,2)~=0 then local target=(c.pc+(operand<128 and operand or operand-256))%65536;read(c,c.pc);if floor(target/256)~=floor(c.pc/256) then read(c,floor(c.pc/256)*256+target%256);c.pc=target;return 4 end;c.pc=target;return 3 end;return 2 end
E[241]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;local cyc=5;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return cyc end
E[243]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;local base=read(c,operand)+256*read(c,(operand+1)%256);local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 8 end
E[244]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);return cyc end
E[245]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return 4 end
E[246]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 6 end
E[247]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);c.pc=(pc+2)%65536;read(c,operand);local addr=(operand+c.x)%256;local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 6 end
E[248]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;c.p=flag(c.p,8,true);return 2 end
E[249]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return cyc end
E[250]=function(c) local pc=c.pc;read(c,(pc+1)%65536);c.pc=(pc+1)%65536;return 2 end
E[251]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.y)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 7 end
E[253]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;local cyc=4;if floor(base/256)~=floor(addr/256) then cyc=cyc+1;read(c,floor(base/256)*256+addr%256) end;local value=read(c,addr);local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;return cyc end
E[254]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;local carry=band(c.p,1)~=0 and 1 or 0;value=value+1;value=value%256;c.p=nz(c.p,value);write(c,addr,old);write(c,addr,value);return 7 end
E[255]=function(c) local pc=c.pc;local operand=read(c,(pc+1)%65536);operand=operand+256*read(c,(pc+2)%65536);c.pc=(pc+3)%65536;local base=operand;local addr=(base+c.x)%65536;read(c,floor(base/256)*256+addr%256);local value=read(c,addr);local old=value;value=(value+1)%256;local b=255-value;local sum=c.a+b+(band(c.p,1)~=0 and 1 or 0);local result=sum%256;c.p=flag(c.p,1,sum>255);c.p=flag(c.p,64,band(bxor(c.a,result),bxor(b,result),128)~=0);c.p=nz(c.p,result);c.a=result;write(c,addr,old);write(c,addr,value);return 7 end
R.exec=E
