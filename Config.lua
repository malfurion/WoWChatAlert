-- ChatAlert Config.lua
-- Settings UI using AceConfig

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

function ChatAlert:GetOptionsTable()
    local options = {
        type = "group",
        name = "ChatAlert",
        icon = "Interface\\Icons\\INV_Misc_Horn_01",
        childGroups = "tab",
        args = {
            rules = {
                type = "group",
                name = "Rules",
                order = 1,
                args = {
                    header = {
                        type = "header",
                        name = "ChatAlert Settings",
                        order = 1
                    },
                    currentZone = {
                        type = "description",
                        name = function()
                            local zoneId = C_Map.GetBestMapForUnit("player")
                            local mapInfo = zoneId and C_Map.GetMapInfo(zoneId)
                            local zoneName = mapInfo and mapInfo.name or "Unknown"
                            return string.format("|cff00ff00Current Zone:|r %s |cff888888(ID: %s)|r", zoneName, zoneId or "?")
                        end,
                        fontSize = "medium",
                        order = 2
                    },
                    rulesHeader = {
                        type = "header",
                        name = "Pattern Rules",
                        order = 10
                    },
                    addRule = {
                        type = "execute",
                        name = "Add New Rule",
                        desc = "Add a new pattern matching rule",
                        func = function()
                            ChatAlert:AddNewRule()
                        end,
                        order = 11
                    }
                }
            },
            channels = {
                type = "group",
                name = "Channels",
                order = 2,
                childGroups = "tab",
                args = {
                    channelsDesc = {
                        type = "description",
                        name = "Select which chat channels should be monitored for pattern matches.",
                        order = 1
                    }
                }
            },
            general = {
                type = "group",
                name = "General",
                order = 3,
                args = {
                    useFallbackSound = {
                        type = "toggle",
                        name = "Use Fallback Sound",
                        desc = "If the custom sound file cannot be played, use WoW's built-in READY_CHECK sound",
                        get = function() return self.db.global.useFallbackSound end,
                        set = function(_, value)
                            self.db.global.useFallbackSound = value
                        end,
                        order = 1
                    },
                    debug = {
                        type = "toggle",
                        name = "Debug Mode",
                        desc = "Enable debug messages (shows when chat monitoring is enabled/disabled)",
                        get = function() return self.db.global.debug end,
                        set = function(_, value)
                            self.db.global.debug = value
                        end,
                        order = 2
                    }
                }
            }
        }
    }

    -- Add rule configurations dynamically
    local ruleOrder = 20
    for i, rule in ipairs(self.db.global.rules) do
        local ruleKey = "rule" .. i

        options.args.rules.args[ruleKey] = {
            type = "group",
            name = "Rule " .. i .. (rule.enabled and "" or " (Disabled)"),
            inline = true,
            order = ruleOrder,
            args = {
                enabled = {
                    type = "toggle",
                    name = "Enabled",
                    desc = "Enable or disable this rule",
                    get = function() return rule.enabled end,
                    set = function(_, value)
                        rule.enabled = value
                        AceConfigRegistry:NotifyChange("ChatAlert")
                    end,
                    order = 1
                },
                pattern = {
                    type = "input",
                    name = "Pattern",
                    desc = "The text pattern to match in chat messages",
                    get = function() return rule.pattern end,
                    set = function(_, value)
                        rule.pattern = value
                    end,
                    width = "full",
                    order = 2
                },
                matchType = {
                    type = "select",
                    name = "Match Type",
                    desc = "How to match the pattern",
                    values = {
                        contains = "Contains (substring match)",
                        exact = "Exact match"
                    },
                    get = function() return rule.matchType end,
                    set = function(_, value)
                        rule.matchType = value
                    end,
                    order = 3
                },
                zoneId = {
                    type = "input",
                    name = "Zone ID (Optional)",
                    desc = "Restrict this rule to a specific zone. Leave empty for all zones.",
                    get = function() return rule.zoneId and tostring(rule.zoneId) or "" end,
                    set = function(_, value)
                        if value == "" then
                            rule.zoneId = nil
                        else
                            local num = tonumber(value)
                            if num then
                                rule.zoneId = num
                            end
                        end
                    end,
                    order = 4
                },
                soundFile = {
                    type = "input",
                    name = "Sound File Path",
                    desc = "Path to the sound file to play",
                    get = function() return rule.soundFile end,
                    set = function(_, value)
                        rule.soundFile = value
                    end,
                    width = "full",
                    order = 5
                },
                delete = {
                    type = "execute",
                    name = "Delete Rule",
                    desc = "Delete this rule",
                    confirm = true,
                    confirmText = "Are you sure you want to delete this rule?",
                    func = function()
                        ChatAlert:DeleteRule(i)
                    end,
                    order = 6
                }
            }
        }

        ruleOrder = ruleOrder + 1
    end

    -- Add channel toggles organized by tabs
    local channelCategories = {
        playerChat = {
            name = "Player Chat",
            order = 1,
            channels = {
                SAY = "Say",
                YELL = "Yell",
                EMOTE = "Emote (/me)",
                TEXT_EMOTE = "Text Emote",
                GUILD = "Guild",
                OFFICER = "Officer",
                PARTY = "Party",
                PARTY_LEADER = "Party Leader",
                RAID = "Raid",
                RAID_LEADER = "Raid Leader",
                RAID_WARNING = "Raid Warning",
                INSTANCE_CHAT = "Instance Chat",
                INSTANCE_CHAT_LEADER = "Instance Chat Leader",
                WHISPER = "Whisper",
                BN_WHISPER = "Battle.net Whisper",
                CHANNEL = "Channels (General/Trade/etc.)"
            }
        },
        systemAndAchievements = {
            name = "System & Achievements",
            order = 2,
            channels = {
                SYSTEM = "System Messages",
                ACHIEVEMENT = "Achievement",
                GUILD_ACHIEVEMENT = "Guild Achievement"
            }
        },
        npcsAndMonsters = {
            name = "NPCs & Monsters",
            order = 3,
            channels = {
                MONSTER_SAY = "Monster Say",
                MONSTER_YELL = "Monster Yell",
                MONSTER_WHISPER = "Monster Whisper",
                MONSTER_EMOTE = "Monster Emote"
            }
        },
        combatAndProgression = {
            name = "Combat & Progression",
            order = 4,
            channels = {
                COMBAT_XP_GAIN = "XP Gain",
                COMBAT_HONOR_GAIN = "Honor Gain",
                COMBAT_FACTION_CHANGE = "Reputation Change",
                SKILL = "Skill Up"
            }
        },
        lootAndEconomy = {
            name = "Loot & Economy",
            order = 5,
            channels = {
                LOOT = "Loot",
                CURRENCY = "Currency",
                MONEY = "Money"
            }
        },
        pvpAndBattlegrounds = {
            name = "PvP & Battlegrounds",
            order = 6,
            channels = {
                BG_SYSTEM_NEUTRAL = "BG System (Neutral)",
                BG_SYSTEM_ALLIANCE = "BG System (Alliance)",
                BG_SYSTEM_HORDE = "BG System (Horde)"
            }
        },
        miscellaneous = {
            name = "Miscellaneous",
            order = 7,
            channels = {
                AFK = "AFK Auto-Reply",
                DND = "DND Auto-Reply",
                TRADESKILLS = "Tradeskills",
                OPENING = "Opening (Chests/Containers)",
                PET_INFO = "Pet Info",
                TARGETICONS = "Target Icons",
                BN_INLINE_TOAST_ALERT = "Battle.net Toast Alerts"
            }
        }
    }

    -- Create tabs for each category
    for categoryKey, category in pairs(channelCategories) do
        options.args.channels.args[categoryKey] = {
            type = "group",
            name = category.name,
            order = category.order + 10,
            args = {}
        }

        local channelOrder = 1
        for channelKey, channelName in pairs(category.channels) do
            options.args.channels.args[categoryKey].args["channel_" .. channelKey] = {
                type = "toggle",
                name = channelName,
                desc = "Monitor " .. channelName .. " messages",
                get = function()
                    return self.db.global.enabledChannels[channelKey]
                end,
                set = function(_, value)
                    self.db.global.enabledChannels[channelKey] = value
                    -- Re-register events
                    self:RegisterChatEvents()
                end,
                order = channelOrder
            }
            channelOrder = channelOrder + 1
        end
    end

    return options
end

function ChatAlert:SetupConfig()
    -- Register options table
    AceConfig:RegisterOptionsTable("ChatAlert", function()
        return self:GetOptionsTable()
    end)

    -- Add to Blizzard Interface Options
    -- The icon is defined in the options table
    AceConfigDialog:AddToBlizOptions("ChatAlert", "ChatAlert")
end

-- Initialize config when addon loads
ChatAlert:SetupConfig()
