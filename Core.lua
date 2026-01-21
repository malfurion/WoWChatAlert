-- ChatAlert Core.lua
-- Main addon logic: event handling, pattern matching, sound playback

ChatAlert = LibStub("AceAddon-3.0"):NewAddon("ChatAlert", "AceEvent-3.0", "AceConsole-3.0")

-- Default database structure
local defaults = {
    global = {
        rules = {
            {
                pattern = "inv",
                matchType = "contains",
                zoneId = nil,
                enabled = true,
                soundFile = "Interface\\AddOns\\ChatAlert\\Sounds\\airhorn.ogg"
            }
        },
        enabledChannels = {
            SAY = true,
            YELL = true,
            EMOTE = true,
            TEXT_EMOTE = true,
            GUILD = true,
            OFFICER = true,
            PARTY = true,
            PARTY_LEADER = true,
            RAID = true,
            RAID_LEADER = true,
            RAID_WARNING = true,
            INSTANCE_CHAT = true,
            INSTANCE_CHAT_LEADER = true,
            WHISPER = true,
            BN_WHISPER = true,
            CHANNEL = true
        },
        useFallbackSound = true
    }
}

-- Chat event types mapping
local CHAT_EVENTS = {
    "CHAT_MSG_SAY",
    "CHAT_MSG_YELL",
    "CHAT_MSG_EMOTE",
    "CHAT_MSG_TEXT_EMOTE",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_OFFICER",
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_RAID",
    "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_RAID_WARNING",
    "CHAT_MSG_INSTANCE_CHAT",
    "CHAT_MSG_INSTANCE_CHAT_LEADER",
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_BN_WHISPER",
    "CHAT_MSG_CHANNEL"
}

function ChatAlert:OnInitialize()
    -- Initialize database
    self.db = LibStub("AceDB-3.0"):New("ChatAlertDB", defaults, true)

    -- Register slash command
    self:RegisterChatCommand("chatalert", "SlashCommand")
    self:RegisterChatCommand("ca", "SlashCommand")

    self:Print("ChatAlert loaded. Use /chatalert or /ca to open settings.")
end

function ChatAlert:OnEnable()
    -- Register all chat events
    self:RegisterChatEvents()

    -- Register zone change event
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "OnZoneChanged")

    -- Cache current zone
    self.currentZone = self:GetCurrentZoneId()
end

function ChatAlert:OnDisable()
    -- Unregister all events
    self:UnregisterAllEvents()
end

function ChatAlert:RegisterChatEvents()
    -- Unregister all chat events first
    for _, event in ipairs(CHAT_EVENTS) do
        self:UnregisterEvent(event)
    end

    -- Register enabled chat events
    for _, event in ipairs(CHAT_EVENTS) do
        local channelType = event:match("CHAT_MSG_(.+)")
        if channelType and self.db.global.enabledChannels[channelType] then
            self:RegisterEvent(event, "OnChatMessage")
        end
    end
end

function ChatAlert:OnChatMessage(event, message, sender, ...)
    local channelType = event:match("CHAT_MSG_(.+)")

    if not channelType or not self.db.global.enabledChannels[channelType] then
        return
    end

    self:ProcessChatMessage(message)
end

function ChatAlert:ProcessChatMessage(message)
    if not message or message == "" then
        return
    end

    local currentZone = self.currentZone or self:GetCurrentZoneId()

    -- Check all rules
    for _, rule in ipairs(self.db.global.rules) do
        if rule.enabled and rule.pattern and rule.pattern ~= "" then
            -- Zone check
            if rule.zoneId == nil or rule.zoneId == currentZone then
                -- Pattern check
                local matches = false
                local lowerMessage = message:lower()
                local lowerPattern = rule.pattern:lower()

                if rule.matchType == "exact" then
                    matches = (lowerMessage == lowerPattern)
                elseif rule.matchType == "contains" then
                    matches = lowerMessage:find(lowerPattern, 1, true) ~= nil
                end

                if matches then
                    self:PlayMatchSound(rule.soundFile)
                    return  -- Only one sound per message
                end
            end
        end
    end
end

function ChatAlert:PlayMatchSound(soundFile)
    -- Try to play custom sound file
    local willPlay = PlaySoundFile(soundFile, "Master")

    -- Fallback to WoW internal sound if custom file fails
    if not willPlay and self.db.global.useFallbackSound then
        PlaySound(SOUNDKIT.READY_CHECK, "Master")
    end
end

function ChatAlert:GetCurrentZoneId()
    return C_Map.GetBestMapForUnit("player")
end

function ChatAlert:OnZoneChanged()
    self.currentZone = self:GetCurrentZoneId()
end

function ChatAlert:AddNewRule()
    table.insert(self.db.global.rules, {
        pattern = "",
        matchType = "contains",
        zoneId = nil,
        enabled = true,
        soundFile = "Interface\\AddOns\\ChatAlert\\Sounds\\airhorn.ogg"
    })

    -- Notify config system to refresh
    LibStub("AceConfigRegistry-3.0"):NotifyChange("ChatAlert")
end

function ChatAlert:DeleteRule(index)
    if index and self.db.global.rules[index] then
        table.remove(self.db.global.rules, index)
        LibStub("AceConfigRegistry-3.0"):NotifyChange("ChatAlert")
    end
end

function ChatAlert:SlashCommand(input)
    if not input or input:trim() == "" then
        -- Open settings
        LibStub("AceConfigDialog-3.0"):Open("ChatAlert")
    else
        self:Print("Unknown command. Use /chatalert to open settings.")
    end
end
