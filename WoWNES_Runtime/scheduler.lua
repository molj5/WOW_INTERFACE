
local R=WoWNES_Runtime
function R.Start(romId)
 if InCombatLockdown() then return false,"combat" end
 local g=R.games[romId];if not g then return false,"unknown ROM" end
 if R.active then R.release(R.active,"restart");if R.active.view then R.active.view:Hide() end end
 local c=R:New(g);R.active=c;R.NewView(c);c.running=true;c.debt=0;c.target=c.cycles;c.renderedFrame=-1
 c.view.fpsSample={t=GetTime(),frames=c.ppu.frame}
 c.view:EnableKeyboard(true);c.view:SetPropagateKeyboardInput(false)
 c.view:SetScript("OnUpdate",function(self,elapsed)
  if not c.running then return end
  c.debt=math.min(c.debt+elapsed,3/60.0988)
  local work=math.floor(c.debt*1789773);if work<=0 then return end
  local finish=c.cycles+work;local start=debugprofilestop();local before=c.cycles
  local ok,err=pcall(function()
   while c.cycles<finish and c.cycles-before<89342 and debugprofilestop()-start<12 do R.step(c) end
  end)
  if not ok then R.release(c);c.error=err;return end
  c.debt=math.max(0,c.debt-(c.cycles-before)/1789773)
  if c.ppu.frame~=c.renderedFrame then
   local now=GetTime()
   if now-(c.lastRenderAt or 0)>=0.03 then
    local rt=debugprofilestop();R.render(c);c.view.lastRenderMs=debugprofilestop()-rt
    c.renderedFrame=c.ppu.frame;c.lastRenderAt=now
   end
  end
  local s=c.view.fpsSample;local now=GetTime()
  if now-s.t>=0.5 then
   c.view.fps:SetText(string.format("%.1f FPS  %.1fms render",(c.ppu.frame-s.frames)/(now-s.t),c.view.lastRenderMs or 0))
   s.t=now;s.frames=c.ppu.frame
  end
 end)
 return true
end
function R.OnUnload()
 if R.active then R.release(R.active);if R.active.view then R.active.view:SetScript("OnUpdate",nil);R.active.view:Hide() end end
end
SLASH_WOWNES1="/wownes"
SlashCmdList.WOWNES=function(id)
 if id=="stop" then if R.active then R.release(R.active) end;return end
 if id=="" then for key in pairs(R.games) do print("WOW_NES: /wownes "..key) end;return end
 local ok,err=R.Start(id);if not ok then print("WOW_NES: "..tostring(err)) end
end
