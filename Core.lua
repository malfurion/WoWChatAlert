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
            -- Player Chat
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
            CHANNEL = true,
            -- System Messages
            SYSTEM = true,
            ACHIEVEMENT = true,
            GUILD_ACHIEVEMENT = true,
            -- NPC/Monster
            MONSTER_SAY = true,
            MONSTER_YELL = true,
            MONSTER_WHISPER = true,
            MONSTER_EMOTE = true,
            -- Combat & Progression
            COMBAT_XP_GAIN = true,
            COMBAT_HONOR_GAIN = true,
            COMBAT_FACTION_CHANGE = true,
            SKILL = true,
            -- Loot & Money
            LOOT = true,
            CURRENCY = true,
            MONEY = true,
            -- Battlegrounds/PvP
            BG_SYSTEM_NEUTRAL = true,
            BG_SYSTEM_ALLIANCE = true,
            BG_SYSTEM_HORDE = true,
            -- Auto-Replies
            AFK = true,
            DND = true,
            -- Other
            TRADESKILLS = true,
            OPENING = true,
            PET_INFO = true,
            TARGETICONS = true,
            BN_INLINE_TOAST_ALERT = true
        },
        useFallbackSound = true
    }
}

-- Chat event types mapping
local CHAT_EVENTS = {
    -- Player Chat
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
    "CHAT_MSG_CHANNEL",
    -- System Messages
    "CHAT_MSG_SYSTEM",
    "CHAT_MSG_ACHIEVEMENT",
    "CHAT_MSG_GUILD_ACHIEVEMENT",
    -- NPC/Monster
    "CHAT_MSG_MONSTER_SAY",
    "CHAT_MSG_MONSTER_YELL",
    "CHAT_MSG_MONSTER_WHISPER",
    "CHAT_MSG_MONSTER_EMOTE",
    -- Combat & Progression
    "CHAT_MSG_COMBAT_XP_GAIN",
    "CHAT_MSG_COMBAT_HONOR_GAIN",
    "CHAT_MSG_COMBAT_FACTION_CHANGE",
    "CHAT_MSG_SKILL",
    -- Loot & Money
    "CHAT_MSG_LOOT",
    "CHAT_MSG_CURRENCY",
    "CHAT_MSG_MONEY",
    -- Battlegrounds/PvP
    "CHAT_MSG_BG_SYSTEM_NEUTRAL",
    "CHAT_MSG_BG_SYSTEM_ALLIANCE",
    "CHAT_MSG_BG_SYSTEM_HORDE",
    -- Auto-Replies
    "CHAT_MSG_AFK",
    "CHAT_MSG_DND",
    -- Other
    "CHAT_MSG_TRADESKILLS",
    "CHAT_MSG_OPENING",
    "CHAT_MSG_PET_INFO",
    "CHAT_MSG_TARGETICONS",
    "CHAT_MSG_BN_INLINE_TOAST_ALERT"
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
