
local R=WoWNES_Runtime
function R.NewPad() return {state={0,0},latch={0,0},index={0,0},strobe=false} end
function R.padWrite(c,v)
 local p=c.pad;local was=p.strobe;p.strobe=v%2==1
 if p.strobe or was then
  p.latch[1]=p.state[1];p.latch[2]=p.state[2];p.index[1]=0;p.index[2]=0
 end
end
function R.padRead(c,port)
 local p=c.pad;local v;local index=p.index[port]
 if p.strobe then v=p.state[port]%2
 elseif index>=8 then v=1
 else v=math.floor(p.latch[port]/2^index)%2;p.index[port]=index+1 end
 return bit.bor(bit.band(c.open,224),v)
end
function R.release(c,reason)
 c.running=false;c.pad=R.NewPad()
 if c.view then
  c.view:EnableKeyboard(false);c.view:SetPropagateKeyboardInput(true)
  if c.view.hint then c.view.hint:Hide() end
  if c.view.fps then c.view.fps:Hide() end
 end
end
