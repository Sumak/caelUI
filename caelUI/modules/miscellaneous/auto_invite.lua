﻿local AutoInvite = unpack(select(2, ...)).NewModule("AutoInvite")

--[[    Auto accept some invites    ]]

-- Settings for automatically accepting invites from other players.
local blacklist = {
    ["Earthen Ring"] = {
        "Kreinium",
        "Bojay",
        "Nikoh",
    }
}
local whitelist = {
    ["Earthen Ring"] = {
        -- Sephi
        "Scyanne",
        "Sephirah",

        -- Say
        "Sayori",
        "Sariyah",
    }
}

local accept = {
    ["friend"]  = false, -- Auto accept from friends.
    ["guild"]   = true, -- Auto acecpt from guild members.
    ["whisper"] = true, -- Auto invite on whisper.
}

local invite_words = {
    "invite",
}

--------------------------------------------
-- DO NOT CHANGE ANYTHING BELOW THIS LINE --
--------------------------------------------
-- This feature only works for current realm right now.
-- TODO: Explore the BNet user list invites and possible cross-realm invites (not a feature yet but probably soon).
local realm = GetRealmName()

-----------------
-- AUTO ACCEPT --
-----------------
local function auto_accept (name)
    for _, current in pairs(blacklist[realm]) do
        if current == name then
            return false
        end
    end

    for _, current in pairs(whitelist[realm]) do
        if name == current then
            return true
        end
    end

    if accept.friends then
        for index = 1, GetNumFriends() do
            if GetFriendInfo(index) == name then
                return true
            end
        end
    end

    if IsInGuild() and accept.guild then
        for index = 1, GetNumGuildMembers() do
            if GetGuildRosterInfo(index) == name then
                return true
            end
        end
    end

    return false
end

-- Auto accept invites that we recieve if they pass the acceptance check.
AutoInvite:RegisterEvent("PARTY_INVITE_REQUEST", function(_, _, name)
    if auto_accept(name) then
        for index = 1, STATICPOPUP_NUMDIALOGS do
            local frame = _G["StaticPopup" .. index]

            if frame:IsVisible() and frame.which == "PARTY_INVITE" then
                StaticPopup_OnClick(frame, 1)
            end
        end
    else
        SendWho(string.join("", "n-\"", name, "\""))
    end
end)



-----------------
-- AUTO INVITE --
-----------------
if accept.whisper then
    local function can_invite ()
        if IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() or not UnitExists("party1") then
            return true
        end

        return false
    end

    -- Auto send invites for those who message with the right keyword.
    AutoInvite:RegisterEvent("CHAT_MSG_WHISPER", function(_, _, message, name)
        if can_invite() then
            for _, word in next, invite_words do
                if message:len() == word:len() and message:lower() == word:lower() then
                    InviteUnit(name)
                end
            end
        end
    end)
end
