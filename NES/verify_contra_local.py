"""Run the exported Contra package in a minimal WoW UI mock on Lua 5.1."""
import contextlib
import hashlib
import io
import json
import tempfile
import zipfile
from pathlib import Path

from lupa.lua51 import LuaRuntime
from PIL import Image

import verify_runtime
import wow_nes as n

ROOT = Path(__file__).resolve().parent
ZIP_PATH = ROOT / "魂斗罗.zip"
ROM_SHA = "0b79e04375c00b4e65c0dd8e3bc610b02f31eaf45966ebc4441f2688161840f5"

# Lua 5.1 mock bit operations use byte lookup tables, without changing runtime logic.
MOCK = r'''
local lut={}
for a=0,255 do for b=0,255 do
 local x,y,v,p=a,b,0,1
 for i=1,8 do if x%2==1 and y%2==1 then v=v+p end;x=math.floor(x/2);y=math.floor(y/2);p=p*2 end
 lut[a*256+b]=v
end end
local function op(a,b,mode)
 a=a%4294967296;b=b%4294967296;local out,p=0,1
 while a>0 or b>0 do
  local x,y=a%256,b%256;local both=lut[x*256+y]
  local v=both;if mode==2 then v=x+y-both elseif mode==3 then v=x+y-2*both end
  out=out+v*p;a=math.floor(a/256);b=math.floor(b/256);p=p*256
 end
 if out>=2147483648 then return out-4294967296 end;return out
end
bit={band=function(a,b,...) local v=op(a,b,1);for i=1,select('#',...) do v=op(v,select(i,...),1) end;return v end,
 bor=function(a,b,...) local v=op(a,b,2);for i=1,select('#',...) do v=op(v,select(i,...),2) end;return v end,
 bxor=function(a,b,...) local v=op(a,b,3);for i=1,select('#',...) do v=op(v,select(i,...),3) end;return v end,
 bnot=function(a) return 4294967295-(a%4294967296) end,
 lshift=function(a,n) return (a*2^n)%4294967296 end,
 rshift=function(a,n) return math.floor((a%4294967296)/2^n) end}
local objects={}
local function object(kind)
 local o={kind=kind,shown=true,texcoord={0,1,0,1},point={0,0}}
 function o:SetSize(w,h) self.w=w;self.h=h end
 function o:SetPoint(_,_,_,x,y) self.point={x or 0,y or 0} end
 function o:ClearAllPoints() end
 function o:SetAllPoints() end
 function o:SetTexture(v) self.texture=v end
 function o:GetTexture() if WoWMock_missingAtlas then return nil end;return self.texture end
 function o:SetTexCoord(...) self.texcoord={...} end
 function o:SetVertexColor(...) self.color={...} end
 function o:SetColorTexture(...) self.color={...} end
 function o:SetDrawLayer(a,b) self.draw=a;self.sublevel=b end
 function o:SetHorizTile() end;function o:SetVertTile() end
 function o:Show() self.shown=true end;function o:Hide() self.shown=false end
 function o:SetFont() end;function o:SetText(v) self.text=v end
 function o:SetTextColor() end;function o:SetShadowColor() end;function o:SetShadowOffset() end
 function o:SetScript(k,v) self.scripts=self.scripts or {};self.scripts[k]=v end
 function o:RegisterEvent() end;function o:EnableKeyboard() end;function o:SetPropagateKeyboardInput() end
 function o:SetClipsChildren() end
 function o:CreateTexture(_,layer,_,sub) local t=object('texture');t.draw=layer;t.sublevel=sub;return t end
 function o:CreateFontString() return object('font') end
 objects[#objects+1]=o;return o
end
UIParent=object('parent');SlashCmdList={}
function CreateFrame() return object('frame') end
function InCombatLockdown() return false end
local clock=0
local wallTime=0
function debugprofilestop() clock=clock+0.0005;return clock end
function GetTime() return wallTime end
local nativePcall=pcall
function pcall(fn,...)
 local args={...}
 return xpcall(function() return fn(unpack(args)) end,debug.traceback)
end
function WoWMock_restorePcall() pcall=nativePcall end
local function copyTable(source,seen)
 if type(source)~="table" then return source end
 seen=seen or {};if seen[source] then return seen[source] end
 local out={};seen[source]=out
 for key,value in pairs(source) do out[copyTable(key,seen)]=copyTable(value,seen) end
 return out
end
function WoWMock_checkpoint()
 local c=WoWNES_Runtime.active;local state={}
 for _,key in ipairs({"a","x","y","s","p","pc","cycles","open","nmi","stall","running","debt","target","renderedFrame","error"}) do state[key]=c[key] end
 for _,key in ipairs({"ram","sram","mapper","ppu","apu","pad","stats"}) do state[key]=copyTable(c[key]) end
 state.ppu.g=nil;state.ppu.mapper=nil;return state
end
function WoWMock_restore(state)
 local c=WoWNES_Runtime.active
 for _,key in ipairs({"a","x","y","s","p","pc","cycles","open","nmi","stall","running","debt","target","renderedFrame","error"}) do c[key]=state[key] end
 for _,key in ipairs({"ram","sram","mapper","ppu","apu","pad","stats"}) do c[key]=copyTable(state[key]) end
 c.ppu.g=c.g;c.ppu.mapper=c.mapper;c.ppu.dirty=true;c.view.cache={}
end
function WoWMock_objects() return objects end
function WoWMock_readCount() local n=0;for _ in pairs(WoWMock_reads or {}) do n=n+1 end;return n end
function WoWMock_key(kind,key) local f=WoWNES_Runtime.active.view;f.scripts[kind](f,key) end
function WoWMock_tick(dt) wallTime=wallTime+dt;local f=WoWNES_Runtime.active.view;f.scripts.OnUpdate(f,dt) end
function WoWMock_state()
 local c=WoWNES_Runtime.active
 return {pc=c.pc,cycles=c.cycles,frame=c.ppu.frame,renderedFrame=c.renderedFrame,
  pad=c.pad.state[1],padIndex=c.pad.index[1],error=tostring(c.error),running=c.running,
  irqPending=c.mapper.irq.pending,mapperVariant=tostring(c.mapper.variant),
  ppuDirty=c.ppu.dirty,ppuCtrl=c.ppu.ctrl,ppuStatus=c.ppu.status,nmi=c.nmi,
  stack=c.s,stack1=c.ram[256+(c.s+1)%256],stack2=c.ram[256+(c.s+2)%256],
  stack3=c.ram[256+(c.s+3)%256],stack4=c.ram[256+(c.s+4)%256],
  prg0=c.mapper.prg0,prg1=c.mapper.prg1}
end
function print() end
'''


def parse_toc(path):
    return [line.strip() for line in path.read_text("utf-8").splitlines()
            if line.strip() and not line.startswith("#") and line.endswith(".lua")]


def load_package(lua, package):
    toc = next(package.glob("*.toc"))
    addon_env = lua.table()
    for relative in parse_toc(toc):
        source = (package / relative).read_text("utf-8")
        lua.execute(source, toc.stem, addon_env)


def render_png(lua, game_package, out_path):
    view = lua.globals().WoWNES_Runtime.active.view
    if view.pixelFallback:
        lua.execute('''
local c=WoWNES_Runtime.active
c.view.nextPixelRender=0
c.ppu.dirty=true
WoWNES_Runtime.render(c)
''')
        canvas = Image.new("RGB", (512, 480))
        from PIL import ImageDraw
        draw = ImageDraw.Draw(canvas)
        for i in range(1, view.pixelCount + 1):
            t = view.pixelPool[i]
            x, y = round(t.point[1]), round(-t.point[2])
            rgb = tuple(round(t.color[j] * 255) for j in (1, 2, 3))
            draw.rectangle((x, y, x + round(t.w) - 1, y + round(t.h) - 1), fill=rgb)
        canvas.save(out_path)
        return hashlib.sha256(Path(out_path).read_bytes()).hexdigest()
    textures = lua.globals().WoWMock_objects()
    atlases = [Image.open(game_package / "textures" / f"chr-mask-{i}.tga").convert("RGBA") for i in range(1, 4)]
    bg = lua.globals().WoWNES_Runtime.active.view.bg.color
    canvas = Image.new("RGB", (512, 480), tuple(round(bg[i] * 255) for i in (1, 2, 3)))
    # Background, behind-sprites, normal sprites; Lua texture state supplies all geometry/UV/color.
    entries = []
    for i in range(1, len(textures) + 1):
        t = textures[i]
        if t.kind == "texture" and t.shown and t.texture:
            entries.append(t)
    def ordering(t):
        layer = t.draw or "ARTWORK"
        return (0 if layer == "BACKGROUND" else 1 if layer == "BORDER" else 2 if layer == "ARTWORK" else 3,
                t.sublevel or 0)
    for t in sorted(entries, key=ordering):
        if not t.texture or "chr-mask-" not in t.texture: continue
        layer = int(t.texture.rsplit("chr-mask-",1)[1].split(".",1)[0])
        atlas = atlases[layer-1]
        uv=t.texcoord
        x=int(round(t.point[1])); y=int(round(-t.point[2]))
        # SetTexCoord uses normalized atlas coordinates; crop the exact source tile.
        left,right,top,bottom=[float(uv[i]) for i in range(1,5)]
        box=(max(0,min(atlas.width,int(round(min(left,right)*atlas.width)))),
             max(0,min(atlas.height,int(round(min(top,bottom)*atlas.height)))),
             max(0,min(atlas.width,int(round(max(left,right)*atlas.width)))),
             max(0,min(atlas.height,int(round(max(top,bottom)*atlas.height)))))
        if box[2]<=box[0] or box[3]<=box[1]: continue
        tile=atlas.crop(box).resize((16,16),Image.Resampling.NEAREST)
        if right<left: tile=tile.transpose(Image.Transpose.FLIP_LEFT_RIGHT)
        if bottom<top: tile=tile.transpose(Image.Transpose.FLIP_TOP_BOTTOM)
        color=t.color or (1,1,1)
        rgb=tuple(max(0,min(255,round(color[i]*255))) for i in (1,2,3))
        mask=tile.getchannel("A")
        colored=Image.new("RGBA",(16,16),rgb+(0,));colored.putalpha(mask)
        canvas.paste(colored.convert("RGB"),(x,y),mask)
    canvas.save(out_path)
    return hashlib.sha256(Path(out_path).read_bytes()).hexdigest()


def lua_table(value):
    if hasattr(value, "items"):
        return {key: lua_table(item) for key, item in value.items()}
    return value


def run_runtime_regressions():
    output = io.StringIO()
    with contextlib.redirect_stdout(output):
        verify_runtime.build()
    paths = json.loads(output.getvalue())
    lua = LuaRuntime(unpack_returned_tuples=True)
    lua.execute(MOCK)
    lua.globals().WoWMock_restorePcall()
    runtime_result = lua.execute(Path(paths["runner"]).read_text("utf-8"))
    irq_result = lua.execute(Path(paths["irq_runner"]).read_text("utf-8"))
    return {"runtime": lua_table(runtime_result), "irq": lua_table(irq_result)}


def main():
    out = ROOT / "contra-local-evidence"
    out.mkdir(exist_ok=True)
    for path in out.iterdir():
        if path.is_file():
            path.unlink()
    with zipfile.ZipFile(ZIP_PATH) as zf:
        names=[name for name in zf.namelist() if name.lower().endswith(".nes")]
        assert len(names)==1, names
        rom=zf.read(names[0])
    assert hashlib.sha256(rom).hexdigest()==ROM_SHA
    package_root = Path(tempfile.mkdtemp(prefix="wownes-contra-package-"))
    n.export(rom,package_root,ROOT)
    runtime_pkg=package_root/"WoWNES_Runtime"
    print(f"Evidence: {out}", flush=True)
    print(f"Package: {package_root}", flush=True)
    game_pkg=package_root/f"WoWNES_Game_{ROM_SHA[:12]}"
    lua=LuaRuntime(unpack_returned_tuples=True)
    assert lua.eval("_VERSION")=="Lua 5.1"
    lua.execute(MOCK)
    import sys
    lua.globals().WoWMock_missingAtlas = "--fallback" in sys.argv
    load_package(lua,runtime_pkg)
    load_package(lua,game_pkg)
    rid=ROM_SHA[:12]
    assert lua.eval("WoWNES_Runtime.Start")(rid) is True
    if "--fallback" in sys.argv:
        lua.globals().WoWMock_tick(1/60)
        lua.execute('local c=WoWNES_Runtime.active;c.view.nextPixelRender=0.1;c.ppu.dirty=true;WoWNES_Runtime.render(c)')
        first = render_png(lua, game_pkg, out / "fallback-first.png")
        pool_size = lua.globals().WoWNES_Runtime.active.view.pixelCount
        lua.globals().WoWNES_Runtime.active.view.nextPixelRender = 0
        second = render_png(lua, game_pkg, out / "fallback-second.png")
        assert first == second
        assert lua.globals().WoWNES_Runtime.active.view.pixelCount == pool_size
        print(json.dumps({"fallback_frames": 1, "fallback_renders": 2,
                          "png_sha256": second}))
        return
    lua.execute('''
local R=WoWNES_Runtime
local read=R.padRead
WoWMock_reads={}
R.padRead=function(c,port)
 local index=c.pad.index[port];local latch=c.pad.latch[port]
 local v=read(c,port)
 if port==1 and index<8 and not c.pad.strobe then
  local key=latch..":"..index..":"..(v%2)
  WoWMock_reads[key]=(WoWMock_reads[key] or 0)+1
 end
 return v
end
''')
    snapshots={}
    artifacts={}
    def advance(count, quiet=False):
        for i in range(count):
            lua.globals().WoWMock_tick(1/60)
            if not quiet and i % 60 == 0:
                state = dict(lua.globals().WoWMock_state())
                assert state["running"] and state["error"] == "nil", state
                print(f"Frame {state['frame']}, cycles {state['cycles']}, PC {state['pc']:04X}", flush=True)
    advance(360)
    def snapshot(label):
        state = dict(lua.globals().WoWMock_state())
        c = lua.globals().WoWNES_Runtime.active
        for name, size in (("ram", 2048),):
            data = bytes(c[name][i] for i in range(size))
            artifacts[(label, name)] = data
            (out / f"{label}-{name}.bin").write_bytes(data)
            state[name + "_sha256"] = hashlib.sha256(data).hexdigest()
        oam = bytes(c.ppu.oam[i] for i in range(256))
        artifacts[(label, "oam")] = oam
        state["oam_sha256"] = hashlib.sha256(oam).hexdigest()
        state["visible_sprites"] = [list(oam[i:i + 4]) for i in range(0, 256, 4)
                                    if oam[i] < 240]
        state["png_sha256"] = render_png(lua, game_pkg, out / f"contra-{label}.png")
        snapshots[label] = state
        return state
    snapshot("title")
    inputs = {}
    def press(key, mask, count, label=None):
        label = label or key.lower()
        lua.execute("WoWMock_reads={}")
        lua.globals().WoWMock_key("OnKeyDown", key)
        assert lua.globals().WoWNES_Runtime.active.pad.state[1] == mask
        advance(count)
        reads = dict(lua.globals().WoWMock_reads)
        index = mask.bit_length() - 1
        assert reads.get(f"{mask}:{index}:1", 0) > 0, (key, reads)
        inputs[label] = reads
        snapshot(label)
        lua.globals().WoWMock_key("OnKeyUp", key)
        assert lua.globals().WoWNES_Runtime.active.pad.state[1] == 0
        advance(8)
    press("ENTER", 8, 4, "start")
    advance(180)
    snapshot("started")
    press("ENTER", 8, 4, "skip_intro")
    advance(180)
    snapshot("stage")
    lua.execute("WoWMock_reads={}")
    advance(600)
    if lua.globals().WoWMock_readCount() == 0:
        state = dict(lua.globals().WoWMock_state())
        raise AssertionError(f"controller was not polled during stage intro: {state}")
    snapshot("ready")
    advance(180)
    snapshot("spawned")
    checkpoint = lua.globals().WoWMock_checkpoint()
    comparisons = {}
    def controlled_input(key, mask, frames, label):
        settle = 30
        lua.globals().WoWMock_restore(checkpoint)
        advance(frames + settle)
        baseline_label = label + "_idle"
        snapshot(baseline_label)
        lua.globals().WoWMock_restore(checkpoint)
        lua.execute("WoWMock_reads={}")
        lua.globals().WoWMock_key("OnKeyDown", key)
        assert lua.globals().WoWNES_Runtime.active.pad.state[1] == mask
        advance(frames)
        reads = dict(lua.globals().WoWMock_reads)
        index = mask.bit_length() - 1
        assert reads.get(f"{mask}:{index}:1", 0) > 0, (key, reads)
        lua.globals().WoWMock_key("OnKeyUp", key)
        assert lua.globals().WoWNES_Runtime.active.pad.state[1] == 0
        advance(settle)
        inputs[label] = reads
        snapshot(label)
        pixel_diff = sum(a != b for a, b in zip(
            Image.open(out / f"contra-{baseline_label}.png").convert("RGB").tobytes(),
            Image.open(out / f"contra-{label}.png").convert("RGB").tobytes()))
        comparison = {
            "ram_byte_diff": sum(a != b for a, b in zip(artifacts[(baseline_label, "ram")], artifacts[(label, "ram")])),
            "oam_byte_diff": sum(a != b for a, b in zip(artifacts[(baseline_label, "oam")], artifacts[(label, "oam")])),
            "pixel_channel_diff": pixel_diff,
        }
        assert any(comparison.values()), (label, comparison)
        comparisons[label] = comparison
    controlled_input("RIGHT", 128, 60, "right")
    controlled_input("Z", 1, 18, "a_attack")
    controlled_input("X", 2, 18, "b_jump")
    lua.globals().WoWMock_restore(checkpoint)
    press("RIGHT", 128, 60, "game_pressed")
    assert lua.globals().WoWNES_Runtime.active.pad.state[1] == 0
    snapshot("game")
    assert snapshots["game"]["error"]=="nil", snapshots["game"]
    assert snapshots["game"]["cycles"]>snapshots["title"]["cycles"]
    assert snapshots["game"]["frame"]>snapshots["title"]["frame"]
    assert snapshots["game"]["pad"]==0
    assert snapshots["game"]["png_sha256"]!=snapshots["title"]["png_sha256"]
    lua.globals().WoWMock_restorePcall()
    regressions = run_runtime_regressions()
    assert regressions["runtime"]["passed"] and regressions["irq"]["passed"]
    result={"lua_version":lua.eval("_VERSION"),"lupa":__import__("lupa").__version__,
            "rom_sha256":ROM_SHA,"evidence_root":str(out),"package_root":str(package_root),
            "runtime_lua_files":len(parse_toc(runtime_pkg/"WoWNES_Runtime.toc")),
            "game_lua_files":len(parse_toc(game_pkg/f"{game_pkg.name}.toc")),
            "regressions":regressions,"inputs":inputs,"comparisons":comparisons,"snapshots":snapshots}
    (out/"evidence.json").write_text(json.dumps(result,indent=2),"utf-8")
    print(json.dumps(result,indent=2))

if __name__=="__main__": main()
