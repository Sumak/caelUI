local _, caelDataFeeds = ...

local pixelScale = caelUI.config.pixelScale

caelDataFeeds.createModule = function(name)

    -- Create module frame.
    local module = CreateFrame("Frame", format("caelDataFeedsModule%s", name), caelPanel_DataFeed)

    -- Create module text.
    module.text = caelPanel_DataFeed:CreateFontString(nil, "OVERLAY")
    module.text:SetFont(caelUI.media.fonts.NORMAL, 11)

    -- Setup module.
    module:SetAllPoints(module.text)
    module:EnableMouse(true)
    module:SetScript("OnLeave", function() GameTooltip:Hide() end)

    return module
end
