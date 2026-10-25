-- 我的第一个插件
-- 用无限工坊开发：AGENTS.md 写了 Agent 怎么热加载、看报错、截图。
local addonName, ns = ...
WoWBridgeNS = WoWBridgeNS or {}                -- 让无限工坊热加载时把这个插件自己的命名空间交给文件
WoWBridgeNS[addonName] = ns
-- 和 Agent 对话（无限工坊）：WB:Emit(主题, 数据) 发事件给 Agent，WB:Expose(名字, 函数, 说明) 公开函数给 Agent 调用；
-- 玩家没装无限工坊时 WB 是个空壳：发事件、公开函数什么也不做，提问（WB:Request）马上回调 (nil, "unavailable")
local WB = WoWBridge and WoWBridge.Bind and WoWBridge.Bind(addonName) or {
	Emit = function() end,
	Expose = function() end,
	Request = function(_, _, _, callback) C_Timer.After(0, function() callback(nil, "unavailable") end) end,
}
ns.WB = WB

local function Print(...)
	print("|cffd8a85a" .. addonName .. "|r", ...)
end
ns.Print = Print

-- 事件：热加载会把文件再跑一遍，所以事件框体只建一次，留在 ns 里
local events = ns.events or CreateFrame("Frame")
ns.events = events
events:UnregisterAllEvents()
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("INSPECT_READY")
events:RegisterEvent("GET_ITEM_INFO_RECEIVED")

-- 物品提示里的「物品等级 N」是升级后的等级（装备链接里的只是基础等级），所以逐格读提示来算。
local itemLevelLabel = "物品等级"
do
	local tmpl = rawget(_G, "ITEM_LEVEL")               -- 形如「物品等级 %d」
	if type(tmpl) == "string" then
		local prefix = tmpl:match("^(.-)%%d")
		if prefix and prefix ~= "" then itemLevelLabel = prefix:gsub("%s+$", "") end
	end
end

local function EnsureTooltip()
	local tip = ns.tooltip
	if not tip then
		tip = CreateFrame("GameTooltip", "MyFirstAddonTooltip", UIParent, "GameTooltipTemplate")
		tip:SetOwner(UIParent, "ANCHOR_NONE")
		ns.tooltip, ns.tooltipName = tip, tip:GetName()
	end
	return tip
end

-- 从提示里取该格装备的「物品等级」（含升级）；取不到返回 nil
local function TooltipItemLevel(unit, slot)
	local tip = EnsureTooltip()
	tip:ClearLines()
	tip:SetInventoryItem(unit, slot)
	for i = 1, tip:NumLines() do
		local fs = _G[ns.tooltipName .. "TextLeft" .. i]
		local text = fs and fs:GetText()
		if text and text:find(itemLevelLabel, 1, true) then
			local lvl = text:match("(%d+)")
			if lvl then return tonumber(lvl) end
		end
	end
	return nil
end

-- 逐格读取某单位的平均装备等级：忽略衬衫(4)和战袍(19)，双手武器占主手+副手两格。
local function ReadUnitItemLevel(unit)
	local total, count = 0, 0
	local notReady = false
	for slot = 1, 19 do
		if slot ~= 4 and slot ~= 19 then
			local link = GetInventoryItemLink(unit, slot)
			if link then
				local name, _, _, baseIL, _, _, _, _, equipLoc = C_Item.GetItemInfo(link)
				if not name then
					notReady = true                           -- 该装备的物品数据还没缓存好
				else
					local ilvl = TooltipItemLevel(unit, slot) or baseIL
					if ilvl and ilvl > 0 then
						total = total + ilvl
						count = count + 1
						if slot == 16 and equipLoc == "INVTYPE_2HWEAPON" then
							total = total + ilvl
							count = count + 1
						end
					end
				end
			end
		end
	end
	if notReady or count == 0 then return nil end
	return total / count
end
ns.ReadUnitItemLevel = ReadUnitItemLevel

-- 请求查看某单位装备：INSPECT 有冷却，做点节流，别一直发
local function RequestInspect(unit)
	local guid = UnitGUID(unit)
	if not guid then return end
	local now = GetTime()
	if ns.inspectGUID == guid and now - (ns.inspectAt or 0) < 3 then return end
	ns.inspectGUID, ns.inspectAt = guid, now
	NotifyInspect(unit)
end

-- 请求某单位装备的物品数据（数据到了会触发 GET_ITEM_INFO_RECEIVED）
local function RequestTargetItems(unit)
	local now = GetTime()
	if ns.itemsRequestAt and now - ns.itemsRequestAt < 1 then return end
	ns.itemsRequestAt = now
	for slot = 1, 19 do
		local link = GetInventoryItemLink(unit, slot)
		if link and not C_Item.GetItemInfo(link) then
			C_Item.RequestLoadItemDataByID(link)
		end
	end
end

-- 取某单位的“职业 + 天赋专精”：自己用 C_SpecializationInfo，其他玩家用观察数据（需要 inspect）
local function GetUnitClassSpec(unit)
	local ok, className, specName = pcall(function()
		local cName = UnitClass(unit)
		local sName
		if UnitIsUnit(unit, "player") then
			local index = C_SpecializationInfo.GetSpecialization()
			if index then
				local _, name = C_SpecializationInfo.GetSpecializationInfo(index)
				sName = name
			end
		else
			local specID = GetInspectSpecialization(unit)
			if specID and specID > 0 then
				local _, name = GetSpecializationInfoForSpecID(specID)
				sName = name
			end
		end
		return cName, sName
	end)
	if not ok then return nil, nil end
	return className, specName
end

-- 鼠标提示（GameTooltip）：悬停玩家时加一行装备等级。钩子只挂一次，热加载靠 ns.OnUnitTooltip 转发。
if not ns.tooltipHooked then
	ns.tooltipHooked = true
	GameTooltip:HookScript("OnTooltipSetUnit", function(self)
		if ns.OnUnitTooltip then ns.OnUnitTooltip(self) end
	end)
end

ns.OnUnitTooltip = function(self)
	local _, unit = self:GetUnit()
	if not unit or not UnitIsPlayer(unit) then return end

	-- 职业 + 天赋专精（职业已在系统的等级行里，这里补上专精）
	local className, specName = GetUnitClassSpec(unit)
	local specText = (className and specName) and (className .. " · " .. specName) or (specName or className)
	if specText then
		self:AddLine("职业天赋  " .. specText, 0.4, 0.8, 1.0)
	end

	local level = ReadUnitItemLevel(unit)
	if level and level > 0 then
		self:AddLine(("装备等级  %.1f"):format(level), 0.25, 1.0, 0.25)
	else
		self:AddLine("装备等级  读取中…", 0.6, 0.6, 0.6)
		if CanInspect(unit) then
			RequestInspect(unit)
			RequestTargetItems(unit)
		end
	end
end

-- 装备数据是异步到达的：正在显示该单位的提示就重建一次，把「读取中」换成真实值
local function RefreshUnitTooltip()
	if not GameTooltip:IsShown() then return end
	local now = GetTime()
	if ns.tooltipRefreshAt and now - ns.tooltipRefreshAt < 0.25 then return end
	local _, unit = GameTooltip:GetUnit()
	if not unit or not UnitIsPlayer(unit) then return end
	ns.tooltipRefreshAt = now
	GameTooltip:SetUnit(unit)
end

events:SetScript("OnEvent", function(_, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		MyFirstAddonDB = MyFirstAddonDB or { logins = 0 }         -- 存档变量：登出或 /reload 时写盘
		ns.db = MyFirstAddonDB
	elseif event == "PLAYER_LOGIN" and ns.db then
		ns.db.logins = ns.db.logins + 1
		Print(("已加载（第 %d 次登录），把鼠标移到玩家身上可看到其装备等级"):format(ns.db.logins))
		WB:Emit("login", { logins = ns.db.logins })      -- Agent 用 events 看得到
	elseif event == "INSPECT_READY" or event == "GET_ITEM_INFO_RECEIVED" then
		RefreshUnitTooltip()
	end
end)

-- 斜杠命令 /myfirstaddon（别名 /mfa）：打印当前单位（默认目标）的装备等级，便于自查
SLASH_MYFIRSTADDON1 = "/myfirstaddon"
SLASH_MYFIRSTADDON2 = "/mfa"
SlashCmdList["MYFIRSTADDON"] = function(msg)
	local unit = (msg ~= "" and msg or "target")
	if not UnitExists(unit) then
		Print("没有选中单位。把鼠标移到玩家身上就能在提示里看到装备等级。")
		return
	end
	local level = ns.ReadUnitItemLevel(unit)
	Print(("%s 的装备等级：%s"):format(UnitName(unit) or unit, level and ("%.1f"):format(level) or "读取中…"))
end

-- 给 Agent 调用的入口（无限工坊的 call：addon MyFirstAddon，name itemLevel，args 例如 {"unit":"target"}）
WB:Expose("itemLevel", function(args)
	local unit = (args and args.unit) or "target"
	return {
		unit = unit,
		name = UnitName(unit),
		isPlayer = UnitIsPlayer(unit) and true or false,
		equipped = ns.ReadUnitItemLevel(unit),
	}
end, "返回某单位（默认 target）的装备等级")

-- 热加载：无限工坊再跑这个文件之前调用 OnUnload，跑完调用 OnReload，并把 OnUnload 的返回值交给它
function ns.OnUnload()
	return { db = ns.db }
end

function ns.OnReload(state)
	ns.db = (state and state.db) or MyFirstAddonDB
	Print("已热加载")
end
