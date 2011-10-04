﻿--[[    $Id$    ]]

local _, caelLoot = ...

caelLoot.eventFrame = CreateFrame("Frame", nil, UIParent)

local pixelScale = caelLib.scale
local playerName = caelLib.playerName

local curSlot
local curLootSlots = {}

local destroyLootList = {
    "Sharptooth",
    "Murglesnout",
    "Deepsea Sagefish",
    "Lavascale Catfish",
    "Blackbelly Mudfish"
}

--caelLoot.eventFrame:RegisterEvent"START_LOOT_ROLL"
caelLoot.eventFrame:RegisterEvent"CONFIRM_LOOT_ROLL"
caelLoot.eventFrame:RegisterEvent"LOOT_BIND_CONFIRM"
caelLoot.eventFrame:RegisterEvent"LOOT_SLOT_CLEARED"
caelLoot.eventFrame:RegisterEvent"CONFIRM_DISENCHANT_ROLL"
caelLoot.eventFrame:RegisterEvent"PLAYER_ENTERING_WORLD"
caelLoot.eventFrame:SetScript("OnEvent", function(self, event, id)
    if event == "PLAYER_ENTERING_WORLD" then
        for _, object in pairs({LootFrame:GetRegions()}) do
            object.Show = object.Hide
            object:Hide()
        end

        LootFrame:EnableMouseWheel(true)
        LootFrame:SetHitRectInsets(0, 0, 0, 0)

        LootFrame:SetScale(0.85)
        LootFrame:SetSize(160, 180)

        LootFrame:SetBackdrop(caelMedia.backdropTable)
        LootFrame:SetBackdropColor(0, 0, 0, 0.33)
        LootFrame:SetBackdropBorderColor(0.1, 0.1, 0.1)

        local width = pixelScale(LootFrame:GetWidth() - 6)
        local height = pixelScale(LootFrame:GetHeight() / 5)

        --[[
        local gradientTop = LootFrame:CreateTexture(nil, "BORDER")
        gradientTop:SetTexture(caelMedia.files.bgFile)
        gradientTop:SetSize(width, height)
        gradientTop:SetPoint("TOPLEFT", caelLib.scale(3), caelLib.scale(-3))
        gradientTop:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 0.84, 0.75, 0.65, 0.5)

        local gradientBottom = LootFrame:CreateTexture(nil, "BORDER")
        gradientBottom:SetTexture(caelMedia.files.bgFile)
        gradientBottom:SetSize(width, height)
        gradientBottom:SetPoint("BOTTOMRIGHT", caelLib.scale(-3), caelLib.scale(3))
        gradientBottom:SetGradientAlpha("VERTICAL", 0, 0, 0, 0.75, 0, 0, 0, 0)
        --]]

        LootFrame:SetScript("OnMouseWheel", function(self, direction)
            if LootFrameUpButton:IsShown() then
                LootFrameUpButton:Click()
            elseif LootFrameDownButton:IsShown() then
                LootFrameDownButton:Click()
            end
        end)

        --LootFrame:Hide()

        LootCloseButton:SetPoint("TOPRIGHT", pixelScale(2), pixelScale(2))

        for i = 1, LOOTFRAME_NUMBUTTONS do
            local lootButton = _G[format("LootButton%d", i)]
            local icon = _G[format("LootButton%d%s", i, "IconTexture")]
            local quest =_G[format("LootButton%d%s", i, "IconQuestTexture")]
            local text = _G[format("LootButton%d%s", i, "Text")]
            local background = _G[format("LootButton%d%s", i, "NameFrame")]

            lootButton:ClearAllPoints()
            lootButton:SetHeight(pixelScale(28))
            lootButton:SetWidth(pixelScale(28))

            if i == 1 then
                lootButton:SetPoint("TOPLEFT", pixelScale(10), pixelScale(-25))
            else
                lootButton:SetPoint("TOP", _G[format("LootButton%d", i-1)], "BOTTOM", 0, pixelScale(-10))
            end

            lootButton:SetNormalTexture(caelMedia.files.buttonNormal)
            lootButton:GetNormalTexture():SetPoint("TOPLEFT", pixelScale(-5), pixelScale(5))
            lootButton:GetNormalTexture():SetPoint("BOTTOMRIGHT", pixelScale(5), pixelScale(-5))

            lootButton:SetHighlightTexture(caelMedia.files.buttonHighlight)
            lootButton:GetHighlightTexture():SetPoint("TOPLEFT", pixelScale(-5), pixelScale(5))
            lootButton:GetHighlightTexture():SetPoint("BOTTOMRIGHT", pixelScale(5), pixelScale(-5))

            lootButton:SetPushedTexture(nil)
            lootButton:SetDisabledTexture(nil)

            if not lootButton.doneScript then
                lootButton:HookScript("OnEnter", function(self)
                    GameTooltip:SetOwner(LootFrame, "ANCHOR_NONE")
                    GameTooltip:SetPoint("TOPLEFT", LootFrame, "TOPRIGHT", pixelScale(3), 0)
                    GameTooltip:SetLootItem(self.slot)
                end)
                lootButton.donescript = true
            end

            icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

            quest:SetPoint("TOPLEFT")
            quest:SetPoint("BOTTOMRIGHT", 0, pixelScale(1))
            quest:SetTexCoord(0.05, 0.95, 0.05, 0.95)

            text:SetHeight(lootButton:GetHeight())
            text:SetPoint("TOPLEFT", lootButton, "TOPRIGHT" , pixelScale(5), 0)
            text:SetPoint("RIGHT", self, pixelScale(-5), 0)

            background:SetTexture(nil)

            LootFrameUpButton:SetSize(0.01, 0.01)
            LootFrameDownButton:SetSize(0.01, 0.01)
        end
    elseif event == "START_LOOT_ROLL" then
        if UnitLevel("player") ~= MAX_PLAYER_LEVEL then return end

        local _, instanceType = IsInInstance()

        if instanceType == "party" then
            local _, name, _, quality, BoP, _, _, canDE = GetLootRollItemInfo(id)

            if id then
                if caelLib.myChars then
                    -- Need the Chaos Orb
                    --[[
                    if name == select(1, GetItemInfo(52078)) then
                        RollOnLoot(id, 1)
                    else --]]
                        if (quality == 2 and not BoP) or (quality == 3 and caelLib.iLvl >= 355) then
                            RollOnLoot(id, canDE and 3 or 2)
                        end
                    --end
                else
                    if (quality == 2 and not BoP) then
                        RollOnLoot(id, canDE and 3 or 2)
                    end
                end
            end
        end
    end

    for index = 1, STATICPOPUP_NUMDIALOGS do
        local frame = _G["StaticPopup" .. index]

        if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") then
            StaticPopup_OnClick(frame, 1)
        end
    end

    if GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 then
        if event == "LOOT_BIND_CONFIRM" then
            StaticPopup_Hide("LOOT_BIND")
            curLootSlots[#curLootSlots + 1] = id

            self:SetScript("OnUpdate", function(self)
                for _, v in ipairs(curLootSlots) do
                    curSlot = v
                    ConfirmLootSlot(v)
                    print(format("|cffD7BEA5cael|rLoot: Recieved %s", GetLootSlotLink(v)))
                end
                self:SetScript("OnUpdate", nil)
            end)
        elseif event == "LOOT_SLOT_CLEARED" then
            for i, v in ipairs(curLootSlots) do
                if v == curSlot then
                    curLootSlots[i] = nil
                    curSlot = nil
                end
            end
        end
    end
end)

LootFrame:HookScript("OnShow", function(self)
    self:ClearAllPoints()
    self:SetPoint("LEFT", UIParent, pixelScale(5), 0)

end)

local newOnShow = function(self, ...)
    self:ClearAllPoints()
    if self:GetName() == "GroupLootFrame1" then
        self:SetPoint("BOTTOM", caelPanel_ActionBar1, "TOP", 0, pixelScale(30))
    else
        local _, _, num = self:GetName():find("GroupLootFrame(%d)")
        self:SetPoint("BOTTOM", _G[format("GroupLootFrame%d", num-1)], "TOP", 0, pixelScale(10))
    end
    self:SetScale(.75)

    if self.oldOnShow then
        self:oldOnShow(...)
    end
end

for i = 1, NUM_GROUP_LOOT_FRAMES do
    local frame = _G[format("GroupLootFrame%d", i)]
    frame.oldOnShow = frame:GetScript("OnShow")
    frame:SetScript("OnShow", newOnShow)
end
