# ChatAlert

[![GitHub release](https://img.shields.io/github/v/release/malfurion/WoWChatAlert)](https://github.com/malfurion/WoWChatAlert/releases)
[![CurseForge](https://img.shields.io/badge/CurseForge-Download-orange)](https://www.curseforge.com/wow/addons/chatalert)
[![License](https://img.shields.io/github/license/malfurion/WoWChatAlert)](LICENSE)

A World of Warcraft addon that monitors chat messages and plays an airhorn sound when messages match configured patterns.

## Download

- **[CurseForge](https://www.curseforge.com/wow/addons/chatalert)** (Recommended - auto-updates with CurseForge client)
- **[GitHub Releases](https://github.com/malfurion/WoWChatAlert/releases)**
- **[Wago Addons](https://addons.wago.io/addons/chatalert)**

## Features

- Monitor multiple chat channels (Say, Yell, Guild, Whisper, etc.)
- Create multiple pattern matching rules
- Support for exact match or substring (contains) matching
- Zone-specific rules (optional)
- Custom sound file support with fallback to WoW sounds
- Easy-to-use configuration interface
- Real-time zone ID display

## Installation

### Automatic (Recommended)

Use the **CurseForge client** or **Wago** app - they will automatically download and keep the addon updated.

### Manual Installation

1. Download the latest release from [CurseForge](https://www.curseforge.com/wow/addons/chatalert) or [GitHub Releases](https://github.com/malfurion/WoWChatAlert/releases)
2. Extract the ZIP file
3. Copy the `ChatAlert` folder to your World of Warcraft AddOns directory:

**Windows:**
```
C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\
```

**Mac:**
```
/Applications/World of Warcraft/_retail_/Interface/AddOns/
```

**Note:** If downloading from GitHub or building from source, you'll need to install Ace3 libraries separately. See `Libs/LIBS_INSTALLATION.md` for details. Downloads from CurseForge already include all required libraries.

### 3. Add Custom Sound File (Optional)

To use a custom airhorn sound:

1. Obtain a royalty-free airhorn sound file (`.ogg` or `.mp3` format)
2. Place it in `ChatAlert/Sounds/` directory
3. Name it `airhorn.ogg` (or update the path in settings)

**Recommended sources for free sounds:**
- https://freesound.org/
- https://www.zapsplat.com/

**Converting to .ogg:**
- Use Audacity or online converters to convert MP3 to OGG format
- WoW supports both .ogg and .mp3, but .ogg is recommended

### 4. Load WoW

1. Start World of Warcraft
2. At the character selection screen, click "AddOns"
3. Ensure "ChatAlert" is checked
4. Enter the game

## Usage

### Opening Settings

Use one of these commands:
```
/chatalert
/ca
```

Or navigate to: **ESC → Interface → AddOns → ChatAlert**

### Creating Rules

1. Open ChatAlert settings
2. Click "Add New Rule"
3. Configure the rule:
   - **Pattern**: The text to match (e.g., "inv", "LFG healer")
   - **Match Type**:
     - "Contains" - matches if pattern appears anywhere in message
     - "Exact match" - matches only if entire message equals pattern
   - **Zone ID**: Leave empty for all zones, or enter specific zone ID
   - **Sound File Path**: Path to custom sound (default is the airhorn)
   - **Enabled**: Toggle to enable/disable the rule

4. Click "Okay" to save

### Finding Your Current Zone ID

The settings panel displays your current zone name and ID at the top. Use this to configure zone-specific rules.

### Enabling/Disabling Channels

Scroll down in the settings to find the "Enabled Channels" section. Toggle which chat channels you want to monitor:

- Say
- Yell
- Guild
- Officer
- Party
- Party Leader
- Raid
- Raid Leader
- Raid Warning
- Whisper
- Channels (General/Trade/etc.)

## Examples

### Example 1: Alert on Group Invites
- Pattern: `inv`
- Match Type: Contains
- Zone ID: (empty - all zones)

This will alert when someone types "inv", "invite", "inviting", etc. in any monitored channel.

### Example 2: Alert on LFG in Specific Zone
- Pattern: `LFG`
- Match Type: Contains
- Zone ID: `1519` (Stormwind City)

This will only alert when "LFG" appears in chat while you're in Stormwind.

### Example 3: Exact Match for Your Name
- Pattern: `YourCharacterName`
- Match Type: Exact match
- Zone ID: (empty)

This will only alert when someone types exactly your character name.

## Troubleshooting

### Sound Not Playing

1. **Check sound file path**: Ensure the path in the rule is correct
2. **Enable fallback sound**: In General Settings, enable "Use Fallback Sound"
3. **Check master volume**: Ensure WoW's master volume is not muted
4. **Verify file format**: Sound file should be .ogg or .mp3
5. **Test with default sound**: Try using WoW's built-in sounds:
   ```
   Interface\AddOns\YourAddon\Sounds\airhorn.ogg
   ```

### Addon Not Loading

1. **Check Ace3 libraries**: Verify all required libraries are in `Libs/` folder
2. **Check .toc file**: Ensure `ChatAlert.toc` interface version matches your WoW version
3. **Enable at login**: Make sure addon is enabled at character selection
4. **Check for errors**: Install BugSack addon to see Lua errors

### Rules Not Working

1. **Check if rule is enabled**: Toggle switch should be ON
2. **Check channel monitoring**: Ensure the chat channel is enabled
3. **Check zone restrictions**: If zone ID is set, you must be in that zone
4. **Pattern case**: Patterns are case-insensitive
5. **Test with `/say`**: Type `/say test` to verify your pattern works

## Configuration File

Settings are stored in:
```
World of Warcraft\_retail_\WTF\Account\<ACCOUNT>\SavedVariables\ChatAlertDB.lua
```

You can manually edit this file if needed (make sure WoW is closed).

## Commands

- `/chatalert` or `/ca` - Open settings panel

## Technical Details

- **Addon Structure**: Built with Ace3 framework
- **Database**: AceDB for saved variables
- **Config UI**: AceConfig for settings interface
- **Events**: Monitors CHAT_MSG_* events
- **Pattern Matching**: Case-insensitive string matching

## Known Limitations

- Only one sound plays per message (first matching rule)
- Zone detection uses map ID (not sub-zones)
- Channel filter applies to all rules (not per-rule)

## License

This addon is provided as-is for personal use.

## Credits

- Built with Ace3 libraries
- Airhorn sound: (add your source here if using custom sound)

## Support

For issues or questions, please visit:
- [GitHub Issues](https://github.com/malfurion/WoWChatAlert/issues)

## Version History

### 1.0.0
- Initial release
- Multiple pattern rules
- Zone-specific matching
- Channel filtering
- Custom sound support
