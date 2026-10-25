-- 消耗品快捷工具
local addonName, ns = ...
WoWBridgeNS = WoWBridgeNS or {}
WoWBridgeNS[addonName] = ns
local WB = WoWBridge and WoWBridge.Bind and WoWBridge.Bind(addonName) or {
    Emit = function() end,
    Expose = function() end,
}
ns.WB = WB

local categories = {
    { name = "药水", icon = "Interface\\Icons\\INV_Potion_54" },
    { name = "药剂", icon = "Interface\\Icons\\INV_Potion_97" },
    { name = "食物", icon = "Interface\\Icons\\INV_Misc_Food_15" },
    { name = "其他", icon = "Interface\\Icons\\INV_Misc_Bag_10" },
}

local function Print(text)
    print("|cffd8a85a消耗品快捷工具|r " .. text)
end
ns.Print = Print

local function Background(frame)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    frame:SetBackdropColor(0.5, 0.5, 0.5, 0.5)
    frame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
end

local function IconButton(button, icon)
    button:SetSize(36, 36)
    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetAllPoints()
    button.icon:SetTexture(icon)
    button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2")
    local normal = button:GetNormalTexture()
    normal:ClearAllPoints()
    normal:SetPoint("CENTER")
    normal:SetSize(60, 60)
    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    button.count = button:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    button.count:SetPoint("BOTTOMRIGHT", -2, 2)
    button.cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
    button.cooldown:SetAllPoints(button.icon)
    button.cooldown:SetSwipeColor(0, 0, 0, 0.8)
    button.cooldown:SetHideCountdownNumbers(true)
end

local function Classify(name, classID, subclassID, spell)
    if not spell then return nil end
    if classID ~= 0 then
        if name:find("炉石") or name:find("传送") or name:find("信标")
            or name:find("战旗") or name:find("灵魂石") or name:find("治疗石")
            or name:find("法力宝石") then
            return 4
        end
        return nil
    end
    if subclassID == 5 then return 3 end
    if subclassID == 1 then return 1 end
    if subclassID == 2 or subclassID == 3 or subclassID == 6
        or name:find("合剂") or name:find("药剂") then
        return 2
    end
    if name:find("灵魂石") or name:find("治疗石") or name:find("法力宝石")
        or name:find("法力翡翠") or name:find("法力红宝石")
        or name:find("法力黄水晶") or name:find("法力玛瑙") then
        return 1
    end
    return 4
end

local function TooltipItem(button)
    if not button.data then return end
    GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink("item:" .. button.data.itemID)
    GameTooltip:Show()
end

local function IsMouseOver(frame)
    return frame and frame:IsShown() and frame:IsMouseOver()
end

local function ScheduleHide(index)
    local group = ns.groups and ns.groups[index]
    if not group then return end
    group.hideToken = (group.hideToken or 0) + 1
    local token = group.hideToken
    C_Timer.After(0.25, function()
        if not InCombatLockdown() and group.hideToken == token
            and not IsMouseOver(group.outer) and not IsMouseOver(group.menu) then
            group.menu:Hide()
        end
    end)
end

local function ShowMenu(index)
    if InCombatLockdown() then return end
    local group = ns.groups[index]
    group.hideToken = (group.hideToken or 0) + 1
    group.menu:Show()
end

local UpdateButtonVisual

local function SetDefault(index, itemID)
    local selected
    for _, item in ipairs(ns.items[index]) do
        if item.itemID == itemID then selected = item break end
    end
    if not selected then return end
    ns.db.defaults[index] = itemID
    if InCombatLockdown() then
        ns.pending = true
        return
    end
    ns.groups[index].main:SetAttribute("item", "item:" .. itemID)
    ns.groups[index].main.data = selected
    ns.groups[index].main.icon:SetTexture(selected.icon or categories[index].icon)
    UpdateButtonVisual(ns.groups[index].main)
    Print(categories[index].name .. "默认物品已设置")
end

UpdateButtonVisual = function(button)
    local item = button.data
    if not item then return end
    local count = C_Item.GetItemCount(item.itemID)
    button.count:SetText(count > 1 and count or "")
    local usable = C_Item.IsUsableItem(item.itemID)
    button.icon:SetDesaturated(not usable or count == 0)
    local start, duration, enabled = C_Container.GetContainerItemCooldown(item.bag, item.slot)
    if button.cooldown then
        if enabled == 1 and duration > 0 then
            button.cooldown:SetCooldown(start, duration)
        else
            button.cooldown:Clear()
        end
    end
end

local function UpdateVisuals()
    if not ns.groups then return end
    for _, group in ipairs(ns.groups) do
        UpdateButtonVisual(group.main)
        for _, button in ipairs(group.buttons) do
            UpdateButtonVisual(button)
        end
    end
end

local function BuildItemButton(group, index)
    local button = group.buttons[index]
    if button then return button end
    button = CreateFrame("Button", "XiaohaopingItemV6_" .. group.index .. "_" .. index,
        group.menu, "SecureActionButtonTemplate")
    group.buttons[index] = button
    IconButton(button)
    button:RegisterForClicks("AnyDown", "AnyUp")
    button:SetAttribute("type2", "item")
    button:SetScript("OnEnter", function(self)
        ShowMenu(group.index)
        TooltipItem(self)
    end)
    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
        ScheduleHide(group.index)
    end)
    button:SetScript("PostClick", function(self, mouseButton, down)
        if mouseButton == "LeftButton" and not down and self.data then
            SetDefault(group.index, self.data.itemID)
        end
    end)
    return button
end

local function BuildUI()
    if ns.bar and ns.uiVersion == 6 then return end
    if ns.bar then ns.bar:Hide() end
    ns.positionApplied = false
    local bar = CreateFrame("Frame", "XiaohaopingBarV6", UIParent, "BackdropTemplate")
    ns.bar = bar
    ns.uiVersion = 6
    bar:SetSize(172, 52)
    Background(bar)
    bar:SetFrameStrata("MEDIUM")
    bar:SetClampedToScreen(true)
    bar:SetMovable(true)
    bar:EnableMouse(true)
    bar:RegisterForDrag("LeftButton")
    bar:SetScript("OnDragStart", function(self)
        if not InCombatLockdown() then self:StartMoving() end
    end)
    bar:SetScript("OnDragStop", function(self)
        if InCombatLockdown() then return end
        self:StopMovingOrSizing()
        local point, _, relativePoint, x, y = self:GetPoint()
        ns.db.position = { point, relativePoint, x, y }
    end)
    bar:SetScript("OnEnter", function() GameTooltip:Hide() end)

    ns.groups = {}
    for index, category in ipairs(categories) do
        local group = { index = index, buttons = {} }
        ns.groups[index] = group
        local outer = CreateFrame("Frame", "XiaohaopingOuterV6_" .. index, bar)
        group.outer = outer
        outer:SetSize(40, 52)
        outer:SetPoint("LEFT", bar, "LEFT", 6 + (index - 1) * 40, 0)
        outer:EnableMouse(true)
        -- Drag recipients must be movable even though the callbacks move the bar.
        outer:SetMovable(true)
        outer:RegisterForDrag("LeftButton")
        outer:SetScript("OnDragStart", function()
            if not InCombatLockdown() then bar:StartMoving() end
        end)
        outer:SetScript("OnDragStop", function()
            if InCombatLockdown() then return end
            bar:StopMovingOrSizing()
            local point, _, relativePoint, x, y = bar:GetPoint()
            ns.db.position = { point, relativePoint, x, y }
        end)
        outer:SetScript("OnEnter", function() ShowMenu(index) end)
        outer:SetScript("OnLeave", function() ScheduleHide(index) end)

        local main = CreateFrame("Button", "XiaohaopingMainV6_" .. index, outer, "SecureActionButtonTemplate")
        group.main = main
        main:SetPoint("TOPLEFT", outer, "TOPLEFT", 2, -8)
        IconButton(main, category.icon)
        main:RegisterForClicks("AnyDown", "AnyUp")
        main:SetMovable(true)
        main:RegisterForDrag("LeftButton")
        main:SetAttribute("type2", "item")
        main:SetScript("OnDragStart", function()
            if not InCombatLockdown() then bar:StartMoving() end
        end)
        main:SetScript("OnDragStop", function()
            if InCombatLockdown() then return end
            bar:StopMovingOrSizing()
            local point, _, relativePoint, x, y = bar:GetPoint()
            ns.db.position = { point, relativePoint, x, y }
        end)
        main:SetScript("OnEnter", function(self)
            ShowMenu(index)
            TooltipItem(self)
        end)
        main:SetScript("OnLeave", function()
            GameTooltip:Hide()
            ScheduleHide(index)
        end)
        main:SetScript("PostClick", function(self, mouseButton, down)
            if mouseButton == "LeftButton" and not down and self.data then
                SetDefault(index, self.data.itemID)
            end
        end)

        local label = outer:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        label:SetPoint("TOP", outer, "BOTTOM", 0, -2)
        label:SetText(category.name)
        group.label = label

        local menu = CreateFrame("Frame", "XiaohaopingMenuV6_" .. index, outer, "BackdropTemplate")
        group.menu = menu
        menu:SetFrameStrata("HIGH")
        menu:SetClampedToScreen(true)
        menu:SetSize(52, 52)
        menu:SetPoint("BOTTOMLEFT", outer, "TOPLEFT", -6, 0)
        Background(menu)
        menu:EnableMouse(true)
        menu:SetScript("OnEnter", function() ShowMenu(index) end)
        menu:SetScript("OnLeave", function() ScheduleHide(index) end)
        menu.empty = menu:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        menu.empty:SetPoint("CENTER")
        menu.empty:SetText("没有可使用的该类物品")
        menu:Hide()
    end
end

local function ScanBags()
    if InCombatLockdown() then
        ns.pending = true
        UpdateVisuals()
        return
    end
    ns.pending = false
    local lists, seen = { {}, {}, {}, {} }, {}
    for bag = 0, (NUM_BAG_SLOTS or 4) do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info and info.itemID and not seen[info.itemID] then
                local id = info.itemID
                local name, _, _, _, minLevel, _, _, _, _, icon, _, classID, subclassID = C_Item.GetItemInfo(id)
                if not name then
                    C_Item.RequestLoadItemDataByID(id)
                else
                    local category = Classify(name, classID, subclassID, C_Item.GetItemSpell(id))
                    if category and minLevel <= UnitLevel("player") then
                        local usable, noMana = C_Item.IsUsableItem(id)
                        if usable or noMana then
                            seen[id] = true
                            lists[category][#lists[category] + 1] = {
                                itemID = id, name = name, icon = icon or info.iconFileID,
                                bag = bag, slot = slot,
                            }
                        end
                    end
                end
            end
        end
    end
    ns.items = lists
    for index, list in ipairs(lists) do
        table.sort(list, function(a, b) return a.name < b.name end)
        local group = ns.groups[index]
        group.menu.empty:SetShown(#list == 0)
        local columns = 1
        if #list > 24 then columns = 5
        elseif #list > 18 then columns = 4
        elseif #list > 12 then columns = 3
        elseif #list > 4 then columns = 2 end
        local rows = math.max(1, math.ceil(#list / columns))
        group.menu:SetSize(#list == 0 and 180 or 12 + columns * 40, 12 + rows * 40)
        for itemIndex, item in ipairs(list) do
            local button = BuildItemButton(group, itemIndex)
            button.data = item
            button.icon:SetTexture(item.icon)
            button:SetAttribute("item", "item:" .. item.itemID)
            button:ClearAllPoints()
            button:SetPoint("TOPLEFT", group.menu, "TOPLEFT", 8 + ((itemIndex - 1) % columns) * 40,
                -8 - math.floor((itemIndex - 1) / columns) * 40)
            button:Show()
        end
        for n = #list + 1, #group.buttons do
            group.buttons[n].data = nil
            group.buttons[n]:SetAttribute("item", nil)
            group.buttons[n]:Hide()
        end

        local defaultID = ns.db.defaults[index]
        local defaultItem
        for _, item in ipairs(list) do
            if item.itemID == defaultID then defaultItem = item break end
        end
        defaultItem = defaultItem or list[1]
        if defaultItem then
            group.main.data = defaultItem
            group.main.icon:SetTexture(defaultItem.icon)
            group.main:SetAttribute("item", "item:" .. defaultItem.itemID)
        else
            group.main.data = nil
            group.main.icon:SetTexture(categories[index].icon)
            group.main:SetAttribute("item", nil)
        end
    end
    UpdateVisuals()
end
ns.ScanBags = ScanBags

local function Initialize()
    if InCombatLockdown() then ns.pending = true; return end
    xiaohaopingDB = xiaohaopingDB or {}
    xiaohaopingDB.defaults = xiaohaopingDB.defaults or {}
    ns.db = xiaohaopingDB
    BuildUI()
    if not ns.positionApplied then
        local pos = ns.db.position
        ns.bar:ClearAllPoints()
        if pos then
            ns.bar:SetPoint(pos[1], UIParent, pos[2], pos[3], pos[4])
        else
            ns.bar:SetPoint("CENTER", UIParent, "CENTER", -92, -140)
        end
        ns.positionApplied = true
    end
    ns.bar:Show()
    ScanBags()
end

local events = ns.events or CreateFrame("Frame")
ns.events = events
events:UnregisterAllEvents()
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_LOGIN", "BAG_UPDATE_DELAYED", "GET_ITEM_INFO_RECEIVED",
    "BAG_UPDATE_COOLDOWN", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED", "PLAYER_LEVEL_UP" }) do
    events:RegisterEvent(event)
end
events:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == addonName then Initialize() end
    elseif event == "PLAYER_REGEN_DISABLED" then
        ns.pending = true
    elseif event == "BAG_UPDATE_COOLDOWN" then
        UpdateVisuals()
    elseif not ns.bar or event == "PLAYER_LOGIN" or event == "PLAYER_REGEN_ENABLED" then
        Initialize()
    else
        if not ns.scanScheduled then
            ns.scanScheduled = true
            C_Timer.After(0, function()
                ns.scanScheduled = false
                if ns.bar then ScanBags() end
            end)
        end
    end
end)

SLASH_XIAOHAOPING1 = "/xiaohaoping"
SlashCmdList["XIAOHAOPING"] = function(msg)
    if InCombatLockdown() then Print("战斗中请点击动作框操作，位置与背包更新将在脱战后处理。"); return end
    Initialize()
    if msg == "reset" then
        ns.db.position = nil
        ns.positionApplied = false
        Initialize()
    elseif msg == "hide" then
        ns.bar:Hide()
    elseif msg == "show" then
        ns.bar:Show()
    else
        ns.bar:Show()
    end
end

WB:Expose("status", function()
    local counts = {}
    for n = 1, 4 do counts[categories[n].name] = ns.items and #ns.items[n] or 0 end
    return { counts = counts, pending = ns.pending, shown = ns.bar and ns.bar:IsShown(), items = ns.items }
end, "返回四类消耗品、默认动作与界面状态")
WB:Expose("scan", function() if ns.bar then ScanBags() end; return ns.items end, "重新扫描背包")

function ns.OnUnload()
    if ns.bar and not InCombatLockdown() then ns.bar:Hide() end
    events:UnregisterAllEvents()
    return { db = ns.db }
end
function ns.OnReload(state)
    ns.db = state and state.db or xiaohaopingDB
    Initialize()
    Print("已热加载；悬停展开物品，左键选择到默认工具条，右键直接使用。")
end
