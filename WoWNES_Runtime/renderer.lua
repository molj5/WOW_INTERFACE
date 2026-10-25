
local R=WoWNES_Runtime
local band=bit.band
-- Fixed pool: 33*31 background and 64 sprites, three mask layers each.
local palette={0x666666,0x002A88,0x1412A7,0x3B00A4,0x5C007E,0x6E0040,0x6C0600,0x561D00,0x333500,0x0B4800,0x005200,0x004F08,0x00404D,0,0,0,
0xADADAD,0x155FD9,0x4240FF,0x7527FE,0xA01ACC,0xB71E7B,0xB53120,0x994E00,0x6B6D00,0x388700,0x0C9300,0x008F32,0x007C8D,0,0,0,
0xFFFEFF,0x64B0FF,0x9290FF,0xC676FF,0xF36AFF,0xFE6ECC,0xFE8170,0xEA9E22,0xBCBE00,0x88D800,0x5CE430,0x45E082,0x48CDDE,0x4F4F4F,0,0,
0xFFFEFF,0xC0DFFF,0xD3D2FF,0xE8C8FF,0xFBC2FF,0xFEC4EA,0xFECCC5,0xF7D8A5,0xE4E594,0xCFEF96,0xBDF4AB,0xB3F3CC,0xB5EBF2,0xB8B8B8,0,0}
local function color(index)
 local v=palette[index%64+1];return math.floor(v/65536)/255,math.floor(v/256)%256/255,v%256/255
end
function R.NewView(c)
 local f=CreateFrame("Frame",nil,UIParent);f:SetSize(512,480);f:SetPoint("CENTER")
 f:SetClipsChildren(false);f:EnableKeyboard(false);f:SetPropagateKeyboardInput(true)
 local bg=f:CreateTexture(nil,"BACKGROUND");bg:SetAllPoints();f.bg=bg
 f.hint=f:CreateFontString(nil,"OVERLAY")
 f.hint:SetFont("Fonts\\FRIZQT__.TTF",14,"OUTLINE")
 f.hint:SetPoint("TOP",f,"BOTTOM",0,-8)
 f.hint:SetText("Z=A  X=B  ENTER=START  ARROWS=MOVE  ESC=EXIT")
 f.hint:SetTextColor(1,0.82,0.2,1);f.hint:SetShadowColor(0,0,0,1);f.hint:SetShadowOffset(1,-1);f.hint:Show()
 f.fps=f:CreateFontString(nil,"OVERLAY")
 f.fps:SetFont("Fonts\\FRIZQT__.TTF",12,"OUTLINE")
 f.fps:SetPoint("TOPLEFT",f,"TOPLEFT",6,-6)
 f.fps:SetText("");f.fps:SetTextColor(0.3,1,0.3,1)
 f.fps:SetShadowColor(0,0,0,1);f.fps:SetShadowOffset(1,-1);f.fps:Show()
 f.pool={};f.cache={}
 local probe=f:CreateTexture(nil,"ARTWORK")
 probe:SetTexture("Interface\\AddOns\\"..c.g.name.."\\textures\\chr-mask-1.tga")
 f.pixelFallback=not probe:GetTexture();probe:Hide()
 f.pixelPool={};f.pixelCache={};f.nextPixelRender=0
 f.pixelStats={renders=0,totalMs=0,maxMs=0,lastMs=0,segments=0}
 if not f.pixelFallback then
 for i=1,1215 do
  local slot={}
  for layer=1,3 do
   local t=f:CreateTexture(nil,i<=1023 and "ARTWORK" or "OVERLAY",nil,layer)
   t:SetSize(16,16);t:SetTexture("Interface\\AddOns\\"..c.g.name.."\\textures\\chr-mask-"..layer..".tga")
   t:SetHorizTile(false);t:SetVertTile(false);t:Hide();slot[layer]=t
  end
  f.pool[i]=slot
 end
 end
 local keys={Z=1,X=2,RSHIFT=4,ENTER=8,UP=16,DOWN=32,LEFT=64,RIGHT=128}
 f:SetScript("OnKeyDown",function(self,key)
  if key=="ESCAPE" then R.inputLog("keyDown key=ESCAPE");R.release(c,"escape");return end
  local mask=keys[key];if mask then local old=c.pad.state[1];local new=bit.bor(old,mask);c.pad.state[1]=new;R.inputLog(string.format("keyDown key=%s mask=%d old=%d new=%d",key,mask,old,new)) end
 end)
 f:SetScript("OnKeyUp",function(self,key)
  local mask=keys[key];if mask then local old=c.pad.state[1];local new=band(old,255-mask);c.pad.state[1]=new;R.inputLog(string.format("keyUp key=%s mask=%d old=%d new=%d",key,mask,old,new)) end
 end)
 f:SetScript("OnHide",function(self) self.hint:Hide();R.release(c,"hide") end)
 f:RegisterEvent("PLAYER_REGEN_DISABLED");f:SetScript("OnEvent",function() R.release(c,"combat") end)
 c.view=f;return f
end
local function submit(c,index,tile,pal,x,y,flipX,flipY,visible,behind)
 local f=c.view;local map=c.g.tiles[tile+1]
 if not map then visible=false end
 local p=c.ppu;local colors={}
 for layer=1,3 do colors[layer]=R.ppuMemory(p,16128+pal*4+layer) end
 local key=table.concat({tile,pal,x,y,flipX and 1 or 0,flipY and 1 or 0,visible and 1 or 0,behind and 1 or 0,colors[1],colors[2],colors[3]},":")
 if f.cache[index]==key then return end;f.cache[index]=key
 for layer=1,3 do
  local t=f.pool[index][layer]
  if not visible or band(map.empty,2^(layer-1))~=0 then t:Hide()
  else
   local uv=map.uv;local l,r,top,bottom=uv[1],uv[2],uv[3],uv[4]
   if flipX then l,r=r,l end;if flipY then top,bottom=bottom,top end
   t:SetTexCoord(l,r,top,bottom);t:ClearAllPoints();t:SetPoint("TOPLEFT",f,"TOPLEFT",x*2,-y*2)
   t:SetVertexColor(color(colors[layer]));t:SetDrawLayer(behind and "BORDER" or (index<=1023 and "ARTWORK" or "OVERLAY"),layer);t:Show()
  end
 end
end
function R.renderPixels(c)
 local p,f=c.ppu,c.view;local stats=f.pixelStats;local now=GetTime()
 if now<f.nextPixelRender then return end
 f.nextPixelRender=now+0.1
 local started=debugprofilestop()
 local pixels,solid,claimed=f.pixelPixels or {},f.pixelSolid or {},f.pixelClaimed or {}
 f.pixelPixels=pixels;f.pixelSolid=solid;f.pixelClaimed=claimed
 local backdrop=R.ppuMemory(p,16128)
 local background=band(p.mask,8)~=0;local left=band(p.mask,2)~=0
 local scrollX=p.x+(p.t%32)*8
 local scrollY=math.floor(p.t/32)%32*8+math.floor(p.t/4096)%8
 local tableId=math.floor(p.t/1024)%4
 local patternBase=band(p.ctrl,16)~=0 and 4096 or 0
 for y=0,239 do
  local sy=y+scrollY;local ty=math.floor(sy%240/8)
  local tableY=2*((math.floor(tableId/2)+math.floor(sy/240))%2)
  local row=sy%240%8;local x=0
  while x<256 do
   local sx=x+scrollX;local offset=sx%8
   local last=math.min(256,x+8-offset)
   local lo,hi,pal=0,0,0
   if background then
    local tx=math.floor(sx%256/8)
    local base=8192+((tableId%2+math.floor(sx/256))%2+tableY)*1024
    local tile=R.ppuMemory(p,base+ty*32+tx)
    local pattern=patternBase+tile*16+row
    lo=R.ppuMemory(p,pattern);hi=R.ppuMemory(p,pattern+8)
    local attr=R.ppuMemory(p,base+960+math.floor(ty/4)*8+math.floor(tx/4))
    pal=math.floor(attr/2^((math.floor(ty/2)%2)*4+(math.floor(tx/2)%2)*2))%4
   end
   for px=x,last-1 do
    local i=y*256+px+1;local v=0
    if background and (px>=8 or left) then
     local shift=7-offset-(px-x)
     v=math.floor(lo/2^shift)%2+2*(math.floor(hi/2^shift)%2)
    end
    solid[i]=v~=0;claimed[i]=false
    pixels[i]=v==0 and backdrop or R.ppuMemory(p,16128+pal*4+v)
   end
   x=last
  end
 end
 local tall=band(p.ctrl,32)~=0;local height=tall and 16 or 8
 if band(p.mask,16)~=0 then for s=0,63 do
  local o=s*4;local sy=p.oam[o]+1;local sx=p.oam[o+3]
  local tile,attr=p.oam[o+1],p.oam[o+2]
  if sx<256 and sy<240 and sy+height>0 then
   for y=math.max(0,sy),math.min(239,sy+height-1) do
    local row=y-sy;if band(attr,128)~=0 then row=height-1-row end
    local pattern
    if tall then pattern=tile%2*4096+(band(tile,254)+math.floor(row/8))*16+row%8
    else pattern=(band(p.ctrl,8)~=0 and 4096 or 0)+tile*16+row end
    local lo,hi=R.ppuMemory(p,pattern),R.ppuMemory(p,pattern+8)
    for x=math.max(0,sx),math.min(255,sx+7) do
     local shift=band(attr,64)~=0 and x-sx or 7-(x-sx)
     local v=math.floor(lo/2^shift)%2+2*(math.floor(hi/2^shift)%2)
     local i=y*256+x+1
     if v~=0 and not claimed[i] and (x>=8 or band(p.mask,4)~=0) then
      claimed[i]=true
      if band(attr,32)==0 or not solid[i] then pixels[i]=R.ppuMemory(p,16144+band(attr,3)*4+v) end
     end
    end
   end
  end
 end end
 local count=0
 for y=0,239 do
  local x=0
  while x<256 do
   local value=pixels[y*256+x+1];local last=x+1
   while last<256 and pixels[y*256+last+1]==value do last=last+1 end
   count=count+1;local key=x..":"..y..":"..last..":"..value
   local t=f.pixelPool[count]
   if not t then t=f:CreateTexture(nil,"ARTWORK");f.pixelPool[count]=t end
   if f.pixelCache[count]~=key then
    t:ClearAllPoints();t:SetPoint("TOPLEFT",f,"TOPLEFT",x*2,-y*2)
    t:SetSize((last-x)*2,2);t:SetColorTexture(color(value));t:Show();f.pixelCache[count]=key
   end
   x=last
  end
 end
 for i=count+1,(f.pixelCount or 0) do f.pixelPool[i]:Hide();f.pixelCache[i]=nil end
 f.pixelCount=count;f.pixelFrame=p.frame;f.pixelRenders=(f.pixelRenders or 0)+1
 p.dirty=false
 local elapsed=debugprofilestop()-started
 stats.renders=stats.renders+1;stats.totalMs=stats.totalMs+elapsed
 stats.lastMs=elapsed;stats.maxMs=math.max(stats.maxMs,elapsed);stats.segments=count
end
function R.render(c)
 local p=c.ppu;if not c.view or not p.dirty then return end
 local f=c.view
 if f.pixelFallback then return R.renderPixels(c) end
 f.bg:SetColorTexture(color(R.ppuMemory(p,16128)))
 for row=0,30 do for col=0,32 do
  local _,pal,tile=R.backgroundPixel(p,col*8-p.x,row*8)
  tile=R.chrTile(p,tile,band(p.ctrl,16)~=0 and 1 or 0)
  submit(c,row*33+col+1,tile,pal,col*8-p.x,row*8,false,false,band(p.mask,8)~=0,false)
 end end
 for i=0,63 do
  local offset=i*4;local attr=p.oam[offset+2];local rawTile=p.oam[offset+1]
  local pal=4+band(attr,3);local x=p.oam[offset+3];local y=p.oam[offset]+1
  local flipX=band(attr,64)~=0;local flipY=band(attr,128)~=0
  local visible=band(p.mask,16)~=0;local behind=band(attr,32)~=0
  if band(p.ctrl,32)==0 then
   submit(c,1024+i,R.chrTile(p,rawTile,band(p.ctrl,8)~=0 and 1 or 0),pal,x,y,flipX,flipY,visible,behind)
  else
   local tableId=rawTile%2;local base=band(rawTile,254)
   local top=flipY and base+1 or base;local bottom=flipY and base or base+1
   submit(c,1024+i,R.chrTile(p,top,tableId),pal,x,y,flipX,flipY,visible,behind)
   submit(c,1088+i,R.chrTile(p,bottom,tableId),pal,x,y+8,flipX,flipY,visible,behind)
  end
 end
 p.dirty=false
end
