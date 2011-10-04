--[[    $Id$    ]]

if not oUF then return end

local _, oUF_Caellian = ...

local smoothing = {}
local Smooth = function(self, value)
    if value ~= self:GetValue() or value == 0 then
        smoothing[self] = value
    else
        smoothing[self] = nil
    end
end

local SmoothBar = function(self, bar)
    bar.SetValue_ = bar.SetValue
    bar.SetValue = Smooth
end

local hook = function(frame)
    frame.SmoothBar = SmoothBar
    if frame.Health and frame.Health.Smooth then
        frame:SmoothBar(frame.Health)
    end
    if frame.Power and frame.Power.Smooth then
        frame:SmoothBar(frame.Power)
    end
end

for i, frame in ipairs(oUF.objects) do hook(frame) end
oUF:RegisterInitCallback(hook)

local f, min, max = CreateFrame('Frame'), math.min, math.max
f:SetScript('OnUpdate', function()
    local rate = GetFramerate()
    local limit = 30/rate
    for bar, value in pairs(smoothing) do
        local cur = bar:GetValue()
        local new = cur + min((value-cur)/3, max(value-cur, limit))
        if new ~= new then
            -- Mad hax to prevent QNAN.
            new = value
        end
        bar:SetValue_(new)
        if cur == value or abs(new - value) < 2 then
            bar:SetValue_(value)
            smoothing[bar] = nil
        end
    end
end)
