-- 自定义玩家与目标头像
-- 用无限工坊开发：AGENTS.md 写了 Agent 怎么热加载、看报错、截图。
local addonName, ns = ...
WoWBridgeNS = WoWBridgeNS or {}
WoWBridgeNS[addonName] = ns

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

local BAR_TEXTURE = "Interface\\Buttons\\WHITE8X8"
local PANEL_COLOR = { 0.03, 0.04, 0.05, 0.94 }
local BORDER_COLOR = { 0.55, 0.58, 0.62, 1 }
local DEFAULT_CLASS_COLOR = { 0.25, 0.65, 0.95 }
local POWER_COLOR = { 0.15, 0.35, 0.95 }
local SPECIAL_POWER_COLORS = {
	CHI = { 0.25, 0.85, 0.55 },
	COMBO_POINTS = { 1, 0.8, 0.15 },
	HOLY_POWER = { 1, 0.85, 0.2 },
	SOUL_SHARDS = { 0.55, 0.25, 0.9 },
	ARCANE_CHARGES = { 0.45, 0.7, 1 },
	ECLIPSE = { 0.9, 0.55, 0.15 },
	MAELSTROM = { 0.2, 0.75, 1 },
	FURY = { 0.7, 0.2, 0.9 },
	PAIN = { 0.9, 0.25, 0.15 },
	INSANITY = { 0.5, 0.15, 0.8 },
	ESSENCE = { 0.3, 0.9, 0.8 },
}
local SPECIAL_POWER_TYPES = {
	CHI = _G.SPELL_POWER_CHI or 12,
	COMBO_POINTS = _G.SPELL_POWER_COMBO_POINTS or 4,
	HOLY_POWER = _G.SPELL_POWER_HOLY_POWER or 9,
	SOUL_SHARDS = _G.SPELL_POWER_SOUL_SHARDS or 7,
	ARCANE_CHARGES = _G.SPELL_POWER_ARCANE_CHARGES or 16,
	ECLIPSE = _G.SPELL_POWER_ECLIPSE or 8,
	MAELSTROM = _G.SPELL_POWER_MAELSTROM or 11,
	FURY = _G.SPELL_POWER_FURY or 17,
	PAIN = _G.SPELL_POWER_PAIN or 18,
	INSANITY = _G.SPELL_POWER_INSANITY or 13,
	ESSENCE = _G.SPELL_POWER_ESSENCE or 19,
}
local PANEL_WIDTH = 284
local PANEL_HEIGHT = 118
local PORTRAIT_SIZE = 76
local CONTENT_WIDTH = 190
local MAX_TARGET_DEBUFFS = 6
local DEFAULT_POSITIONS = {
	player = { point = "BOTTOMLEFT", relativePoint = "BOTTOMLEFT", x = 261.25, y = 163.24 },
	target = { point = "TOP", relativePoint = "TOP", x = -17.03, y = -18.77 },
}

local function EnsureDB()
	customCharDB = customCharDB or {}
	customCharDB.logins = customCharDB.logins or 0
	customCharDB.positions = customCharDB.positions or {}
	ns.db = customCharDB
end

local function SetBackdrop(frame, color)
	return frame, color
end

local function CreateBar(parent, height)
	local bar = CreateFrame("StatusBar", nil, parent)
	bar:SetHeight(height)
	bar:SetStatusBarTexture(BAR_TEXTURE)
	bar:SetMinMaxValues(0, 1)
	bar:SetValue(0)
	bar.bg = bar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints()
	bar.bg:SetTexture(BAR_TEXTURE)
	bar.bg:SetVertexColor(0.05, 0.06, 0.07, 1)
	return bar
end

local function CreateUnitPanel(unit, side)
	local panel = CreateFrame("Button", nil, UIParent)
	panel:SetSize(PANEL_WIDTH, PANEL_HEIGHT)
	panel:SetFrameStrata("HIGH")
	panel:RegisterForClicks("AnyUp")
	SetBackdrop(panel, PANEL_COLOR)
	local panelBackground = panel:CreateTexture(nil, "BACKGROUND")
	panelBackground:SetAllPoints()
	panelBackground:SetTexture(BAR_TEXTURE)
	panelBackground:SetVertexColor(unpack(PANEL_COLOR))
	panel.background = panelBackground

	local portrait = panel:CreateTexture(nil, "ARTWORK")
	portrait:SetSize(PORTRAIT_SIZE, PORTRAIT_SIZE)
	portrait:SetPoint(side == "LEFT" and "TOPLEFT" or "TOPRIGHT", panel, side == "LEFT" and "TOPLEFT" or "TOPRIGHT", side == "LEFT" and 8 or -8, -8)
	portrait:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	panel.portrait = portrait

	local portraitBorder = panel:CreateTexture(nil, "OVERLAY")
	portraitBorder:SetAllPoints(portrait)
	portraitBorder:SetTexture(BAR_TEXTURE)
	portraitBorder:SetVertexColor(0.75, 0.58, 0.2, 0.18)
	panel.portraitBorder = portraitBorder

	local content = CreateFrame("Frame", nil, panel)
	content:SetSize(CONTENT_WIDTH, 70)
	content:SetPoint(side == "LEFT" and "TOPRIGHT" or "TOPLEFT", panel, side == "LEFT" and "TOPRIGHT" or "TOPLEFT", side == "LEFT" and -8 or 8, -11)
	panel.content = content

	local name = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	name:SetJustifyH(side == "LEFT" and "LEFT" or "RIGHT")
	name:SetPoint(side == "LEFT" and "TOPLEFT" or "TOPRIGHT", content, side == "LEFT" and "TOPLEFT" or "TOPRIGHT")
	name:SetWidth(CONTENT_WIDTH)
	name:SetTextColor(1, 0.82, 0.15)
	panel.name = name

	local level = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	level:SetJustifyH(side == "LEFT" and "LEFT" or "RIGHT")
	level:SetPoint(side == "LEFT" and "TOPLEFT" or "TOPRIGHT", name, side == "LEFT" and "BOTTOMLEFT" or "BOTTOMRIGHT", 0, -2)
	level:SetTextColor(0.8, 0.8, 0.8)
	panel.level = level

	local health = CreateBar(content, 16)
	health:SetPoint(side == "LEFT" and "TOPLEFT" or "TOPRIGHT", content, side == "LEFT" and "TOPLEFT" or "TOPRIGHT", 0, -34)
	health:SetWidth(190)
	health:SetStatusBarColor(0.1, 0.78, 0.16, 1)
	panel.health = health

	local power = CreateBar(content, 10)
	power:SetPoint(side == "LEFT" and "TOPLEFT" or "TOPRIGHT", health, side == "LEFT" and "BOTTOMLEFT" or "BOTTOMRIGHT", 0, -4)
	power:SetWidth(190)
	power:SetStatusBarColor(unpack(POWER_COLOR))
	panel.power = power

	local specialPower = CreateBar(content, 8)
	specialPower:SetPoint(side == "LEFT" and "TOPLEFT" or "TOPRIGHT", power, side == "LEFT" and "BOTTOMLEFT" or "BOTTOMRIGHT", 0, -3)
	specialPower:SetWidth(CONTENT_WIDTH)
	specialPower:SetStatusBarColor(0.25, 0.85, 0.55, 1)
	specialPower:Hide()
	panel.specialPower = specialPower

	local debuffs = CreateFrame("Frame", nil, panel)
	debuffs:SetSize(CONTENT_WIDTH, 24)
	debuffs:SetPoint(side == "LEFT" and "BOTTOMLEFT" or "BOTTOMRIGHT", panel, side == "LEFT" and "BOTTOMLEFT" or "BOTTOMRIGHT", side == "LEFT" and 92 or -92, 5)
	if unit ~= "target" then debuffs:Hide() end
	panel.debuffs = debuffs
	panel.debuffIcons = {}
	for index = 1, MAX_TARGET_DEBUFFS do
		local icon = CreateFrame("Frame", nil, debuffs)
		icon:SetSize(22, 22)
		icon:SetPoint(side == "LEFT" and "LEFT" or "RIGHT", debuffs, side == "LEFT" and "LEFT" or "RIGHT", side == "LEFT" and (index - 1) * 25 or -(index - 1) * 25, 0)
		icon.texture = icon:CreateTexture(nil, "ARTWORK")
		icon.texture:SetAllPoints()
		icon.texture:SetTexture(BAR_TEXTURE)
		icon.count = icon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		icon.count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
		icon.count:SetTextColor(1, 1, 1)
		icon.duration = icon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
		icon.duration:SetPoint("TOP", icon, "BOTTOM", 0, -1)
		icon.duration:SetTextColor(1, 0.85, 0.2)
		icon.cooldown = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate")
		icon.cooldown:SetAllPoints(icon)
		icon.cooldown:SetDrawEdge(false)
		icon.cooldown:SetDrawSwipe(true)
		icon.cooldown:SetSwipeColor(0.05, 0.05, 0.05, 0.72)
		icon.cooldown:SetReverse(true)
		icon.progress = icon:CreateTexture(nil, "OVERLAY")
		icon.progress:SetPoint("BOTTOMLEFT", icon, "BOTTOMLEFT")
		icon.progress:SetHeight(2)
		icon.progress:SetTexture(BAR_TEXTURE)
		icon.progress:SetVertexColor(1, 0.72, 0.12, 0.95)
		icon:Hide()
		panel.debuffIcons[index] = icon
	end

	panel.unit = unit
	panel.side = side
	return panel
end

local function SavePanelPosition(panel)
	local point, _, relativePoint, x, y = panel:GetPoint(1)
	if point and relativePoint then
		ns.db.positions[panel.unit] = {
			point = point,
			relativePoint = relativePoint,
			x = x or 0,
			y = y or 0,
		}
	end
end

local function ConfigurePanelDragging(panel)
	panel:SetMovable(true)
	panel:SetClampedToScreen(true)
	panel:RegisterForDrag("LeftButton")
	panel:SetScript("OnDragStart", function(self)
		if not InCombatLockdown or not InCombatLockdown() then
			self:StartMoving()
		end
	end)
	panel:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		SavePanelPosition(self)
	end)
end

local function ApplyPanelPosition(panel)
	local position = ns.db.positions[panel.unit] or DEFAULT_POSITIONS[panel.unit]
	panel:ClearAllPoints()
	panel:SetPoint(position.point, UIParent, position.relativePoint, position.x, position.y)
end

local function GetClassColor(unit)
	local _, classToken = UnitClass(unit)
	if RAID_CLASS_COLORS and classToken and RAID_CLASS_COLORS[classToken] then
		local color = RAID_CLASS_COLORS[classToken]
		return color.r, color.g, color.b
	end
	return unpack(DEFAULT_CLASS_COLOR)
end

local CLASS_SPECIAL_POWER = {
	MONK = "CHI", ROGUE = "COMBO_POINTS", DRUID = "COMBO_POINTS", PALADIN = "HOLY_POWER",
	WARLOCK = "SOUL_SHARDS", MAGE = "ARCANE_CHARGES", SHAMAN = "MAELSTROM",
	DEMONHUNTER = "FURY", PRIEST = "INSANITY", EVOKER = "ESSENCE",
}

local function UpdateSpecialPower(panel)
	local _, classToken = UnitClass(panel.unit)
	local powerName = classToken and CLASS_SPECIAL_POWER[classToken]
	local powerType = powerName and SPECIAL_POWER_TYPES[powerName]
	local powerMax = powerType and UnitPowerMax(panel.unit, powerType) or 0
	if not powerType or not powerMax or powerMax <= 0 then
		panel.specialPower:Hide()
		return
	end
	panel.specialPower:SetMinMaxValues(0, powerMax)
	panel.specialPower:SetValue(UnitPower(panel.unit, powerType) or 0)
	panel.specialPower:SetStatusBarColor(unpack(SPECIAL_POWER_COLORS[powerName]))
	panel.specialPower:Show()
end

local function UpdateTargetDebuffs(panel)
	if panel.unit ~= "target" or not UnitExists("target") or not C_UnitAuras or not C_UnitAuras.GetUnitAuras then
		for _, icon in ipairs(panel.debuffIcons) do icon:Hide() end
		return
	end
	local auras = C_UnitAuras.GetUnitAuras("target", "HARMFUL", MAX_TARGET_DEBUFFS)
	local auraIndex = 0
	for _, aura in ipairs(auras or {}) do
		auraIndex = auraIndex + 1
		local icon = panel.debuffIcons[auraIndex]
		if icon then
			icon.texture:SetTexture(aura.iconFileID or aura.icon or BAR_TEXTURE)
			icon.count:SetText(aura.applications and aura.applications > 1 and aura.applications or "")
			local duration = aura.duration
			local expirationTime = aura.expirationTime
			if duration and duration > 0 and expirationTime and expirationTime > 0 then
				local remaining = expirationTime - GetTime()
				local clampedRemaining = math.max(0, math.min(duration, remaining))
				icon.duration:SetText(clampedRemaining > 0 and tostring(math.ceil(clampedRemaining)) or "")
				icon.cooldown:SetCooldown(expirationTime - duration, duration)
				icon.progress:SetWidth(math.max(1, icon:GetWidth() * clampedRemaining / duration))
				icon.progress:Show()
			else
				icon.duration:SetText("")
				icon.cooldown:Clear()
				icon.progress:Hide()
			end
			icon:Show()
		end
	end
	for index = auraIndex + 1, MAX_TARGET_DEBUFFS do panel.debuffIcons[index]:Hide() end
end

local function UpdatePanel(panel)
	local unit = panel.unit
	if not UnitExists(unit) then
		panel:Hide()
		return
	end

	panel:Show()
	local unitName = UnitName(unit) or unit
	panel.name:SetText(unitName)
	panel.level:SetText("等级 " .. tostring(UnitLevel(unit) or "--"))
	SetPortraitTexture(panel.portrait, unit)

	local r, g, b = GetClassColor(unit)
	panel.name:SetTextColor(r, g, b)
	panel.health:SetStatusBarColor(0.1, 0.78, 0.16, 1)

	local healthMax = UnitHealthMax(unit) or 1
	panel.health:SetMinMaxValues(0, healthMax)
	panel.health:SetValue(UnitHealth(unit) or 0)

	local powerType = UnitPowerType(unit)
	local powerMax = UnitPowerMax(unit, powerType) or 1
	panel.power:SetMinMaxValues(0, powerMax)
	panel.power:SetValue(UnitPower(unit, powerType) or 0)
	UpdateSpecialPower(panel)
	UpdateTargetDebuffs(panel)
end

local function HideBlizzardUnitFrames()
	if InCombatLockdown and InCombatLockdown() then
		return
	end
	if PlayerFrame then
		PlayerFrame:Hide()
	end
	if TargetFrame then
		TargetFrame:Hide()
	end
end

local function ApplyCustomLayout()
	HideBlizzardUnitFrames()
	if InCombatLockdown and InCombatLockdown() then
		return
	end

	if ns.playerPanel then ns.playerPanel:Hide() end
	if ns.targetPanel then ns.targetPanel:Hide() end
	ns.playerPanel = CreateUnitPanel("player", "LEFT")
	ns.targetPanel = CreateUnitPanel("target", "RIGHT")
	ConfigurePanelDragging(ns.playerPanel)
	ConfigurePanelDragging(ns.targetPanel)

	-- 原生技能栏和底部菜单保持不变，头像分别放在它们左右两侧。
	ApplyPanelPosition(ns.playerPanel)
	ns.playerPanel:Show()
	ns.playerPanel:SetSize(PANEL_WIDTH, PANEL_HEIGHT)

	ApplyPanelPosition(ns.targetPanel)
	ns.targetPanel:SetSize(PANEL_WIDTH, PANEL_HEIGHT)
	if UnitExists("target") then
		ns.targetPanel:Show()
	else
		ns.targetPanel:Hide()
	end

	UpdatePanel(ns.playerPanel)
	UpdatePanel(ns.targetPanel)
end
ns.ApplyCustomLayout = ApplyCustomLayout

local function UpdateUnit(unit)
	if unit == "player" and ns.playerPanel then
		UpdatePanel(ns.playerPanel)
	elseif unit == "target" and ns.targetPanel then
		UpdatePanel(ns.targetPanel)
	end
end

local events = ns.events or CreateFrame("Frame")
ns.events = events
events:UnregisterAllEvents()
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:RegisterEvent("PLAYER_TARGET_CHANGED")
events:RegisterEvent("UNIT_HEALTH")
events:RegisterEvent("UNIT_MAXHEALTH")
events:RegisterEvent("UNIT_POWER_UPDATE")
events:RegisterEvent("UNIT_MAXPOWER")
events:RegisterEvent("UNIT_NAME_UPDATE")
events:RegisterEvent("GROUP_ROSTER_UPDATE")
events:RegisterEvent("UNIT_AURA")
events:SetScript("OnUpdate", function(_, elapsed)
	ns.auraElapsed = (ns.auraElapsed or 0) + elapsed
	if ns.auraElapsed >= 0.25 then
		ns.auraElapsed = 0
		if ns.targetPanel then UpdateTargetDebuffs(ns.targetPanel) end
	end
end)
events:SetScript("OnEvent", function(_, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		EnsureDB()
	elseif event == "PLAYER_LOGIN" and ns.db then
		EnsureDB()
		ns.db.logins = ns.db.logins + 1
		ApplyCustomLayout()
		Print(("已加载（第 %d 次登录）"):format(ns.db.logins))
		WB:Emit("login", { logins = ns.db.logins })
	elseif event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_REGEN_ENABLED" then
		ApplyCustomLayout()
	elseif event == "PLAYER_TARGET_CHANGED" then
		HideBlizzardUnitFrames()
		UpdateUnit("target")
	elseif event == "UNIT_AURA" then
		if arg1 == "target" and ns.targetPanel then UpdateTargetDebuffs(ns.targetPanel) end
	elseif event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" or event == "UNIT_NAME_UPDATE" then
		UpdateUnit(arg1)
	elseif event == "GROUP_ROSTER_UPDATE" then
		UpdateUnit("player")
	end
end)

SLASH_CUSTOMCHAR1 = "/customchar"
SlashCmdList["CUSTOMCHAR"] = function(msg)
	ApplyCustomLayout()
	Print("自定义头像界面已应用")
end

WB:Expose("hello", function(args)
	return { text = "你好，" .. tostring(args and args.who or "艾泽拉斯") }
end, "打个招呼：args.who 是对谁说")

function ns.OnUnload()
	if ns.playerPanel then ns.playerPanel:Hide() end
	if ns.targetPanel then ns.targetPanel:Hide() end
	return { db = ns.db }
end

function ns.OnReload(state)
	if state and state.db then
		customCharDB = state.db
	end
	EnsureDB()
	ApplyCustomLayout()
	Print("已热加载自定义头像界面")
end
