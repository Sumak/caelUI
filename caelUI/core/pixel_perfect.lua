local private = unpack(select(2, ...))

--[[
The following section handles all of our UI pixel perfection that we need to make sure everything scales
like we want it when we build the UI for all user screen sizes.
--]]

-- Our screen width and height.
local screen_width    = string.match((({GetScreenResolutions()})[GetCurrentResolution()] or ""), "%d+x(%d+)")
local screen_height   = string.match((({GetScreenResolutions()})[GetCurrentResolution()] or ""), "(%d+)x+%d")

-- This is our scales database. We only need this inside this file because we only reference it here.
local scales = {
    ["720"]     = { ["576"]  = 0.65  },
    ["800"]     = { ["600"]  = 0.70  },
    ["960"]     = { ["600"]  = 0.84  },
    ["1024"]    = { ["600"]  = 0.89, ["768"]  = 0.7},
    ["1152"]    = { ["864"]  = 0.70  },
    ["1176"]    = { ["664"]  = 0.93  },
    ["1280"]    = { ["800"]  = 0.84, ["720"]  = 0.93, ["768"]  = 0.87, ["960"] = 0.7, ["1024"] = 0.65},
    ["1360"]    = { ["768"]  = 0.93  },
    ["1366"]    = { ["768"]  = 0.93  },
    ["1440"]    = { ["900"]  = 0.84  },
    ["1600"]    = { ["1200"] = 0.70, ["1024"] = 0.82, ["900"]  = 0.93},
    ["1680"]    = { ["1050"] = 0.84  },
    ["1768"]    = { ["992"]  = 0.93  },
    ["1920"]    = { ["1440"] = 0.70, ["1200"] = 0.84, ["1080"] = 0.93},
    ["2048"]    = { ["1536"] = 0.70  },
    ["2560"]    = { ["1440"] = 0.93, ["1600"] = 0.84},
}

-- Our scale offset to screen resolution.
local scale_fix = 1

-- Used to set our scale when the ADDON_LOADED event is triggered.
function private.set_scale (...)
    local ui_scale = select("#", ...)

    if ui_scale == 1 then
        ui_scale = ...
    elseif ui_scale == 2 then
        screen_width = select(1, ...) or screen_width
        screen_height = select(2, ...) or screen_height

        if scales[screen_width] and scales[screen_width][screen_height] then
            ui_scale = scales[screen_width][screen_height]
        else
            SetCVar("useUiScale", 0)
            print("your resolution is not supported, UI Scale has been disabled.")
            ui_scale = -1
        end
    else
        ui_scale = 1
    end

    if ui_scale ~= -1 then
        SetCVar("useUiScale", 1)
        SetCVar("uiScale", ui_scale)

        WorldFrame:SetUserPlaced(false)
        WorldFrame:ClearAllPoints()
        WorldFrame:SetHeight(GetScreenHeight() * ui_scale)
        WorldFrame:SetWidth(GetScreenWidth() * ui_scale)
        WorldFrame:SetPoint("BOTTOM", UIParent)
    end

    scale_fix = (768/tonumber(GetCVar("gxResolution"):match("%d+x(%d+)"))) / ui_scale
end

-- This will scale our given value to our scale offset.
function private.pixel_scale (value)
    return scale_fix * math.floor(value / scale_fix + 0.5)
end



for _, event in pairs{"PLAYER_LEAVING_WORLD", "PLAYER_LOGOUT", "UPDATE_FLOATING_CHAT_WINDOWS"} do
    private.events:RegisterEvent(event, function(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            if cael_user.scale then
                private.set_scale(cael_user.scale)
            else
                private.set_scale()
            end
        end

        cael_user.scale = math.floor(GetCVar("uiScale") * 100 + 0.5) / 100
    end)
end
