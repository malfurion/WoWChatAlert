# ChatAlert - Project Structure

This document shows the complete file structure of the ChatAlert addon.

## Current Structure

```
ChatAlert/
├── ChatAlert.toc              # Addon manifest and load order
├── Core.lua                   # Main logic: events, pattern matching, sound playback
├── Config.lua                 # Settings UI using AceConfig
├── README.md                  # Main documentation
├── INSTALL.md                 # Step-by-step installation guide
├── PROJECT_STRUCTURE.md       # This file
├── .gitignore                 # Git ignore rules
│
├── Libs/                      # Ace3 libraries (must be installed separately)
│   ├── LIBS_INSTALLATION.md   # Instructions for installing Ace3
│   ├── LibStub/               # [Download required]
│   ├── CallbackHandler-1.0/   # [Download required]
│   ├── AceAddon-3.0/          # [Download required]
│   ├── AceEvent-3.0/          # [Download required]
│   ├── AceDB-3.0/             # [Download required]
│   ├── AceDBOptions-3.0/      # [Download required]
│   ├── AceConsole-3.0/        # [Download required]
│   ├── AceConfig-3.0/         # [Download required]
│   └── AceGUI-3.0/            # [Download required]
│
└── Sounds/                    # Custom sound files
    ├── README.md              # Sound file instructions
    └── airhorn.ogg            # [User must provide]
```

## File Descriptions

### Core Files

- **ChatAlert.toc**: Defines the addon for WoW. Specifies interface version, dependencies, load order, and saved variables.

- **Core.lua**: Main addon logic including:
  - Addon initialization with AceAddon
  - Database setup with defaults
  - Chat event registration and handling
  - Pattern matching logic (exact and contains)
  - Zone detection and filtering
  - Sound playback with fallback
  - Rule management (add/delete)

- **Config.lua**: Configuration UI using AceConfig framework:
  - Dynamic options table generation
  - Current zone display
  - Rule editor (pattern, match type, zone, enabled, delete)
  - Channel toggles
  - General settings

### Documentation

- **README.md**: Complete addon documentation:
  - Features overview
  - Installation instructions
  - Usage guide
  - Examples
  - Troubleshooting
  - Technical details

- **INSTALL.md**: Quick step-by-step installation guide for new users

- **PROJECT_STRUCTURE.md**: This file - explains the file structure

### Dependencies

- **Libs/**: Contains Ace3 framework libraries
  - **LIBS_INSTALLATION.md**: Instructions for downloading and installing Ace3
  - Libraries must be downloaded separately from WoWAce

### Assets

- **Sounds/**: Directory for audio files
  - **README.md**: Instructions for obtaining and using sound files
  - Users must provide their own airhorn.ogg file (or use fallback sound)

## Installation Checklist

To use this addon, you need:

- [x] Core files (ChatAlert.toc, Core.lua, Config.lua) ✅ Created
- [ ] Ace3 libraries in Libs/ folder ⚠️ Download required
- [ ] airhorn.ogg sound file ⚠️ Optional (fallback available)

## Download Requirements

### Required: Ace3 Libraries

Download from: https://www.wowace.com/projects/ace3/files

Extract these folders into `ChatAlert/Libs/`:
- LibStub
- CallbackHandler-1.0
- AceAddon-3.0
- AceEvent-3.0
- AceDB-3.0
- AceDBOptions-3.0
- AceConsole-3.0
- AceConfig-3.0
- AceGUI-3.0

### Optional: Airhorn Sound

Download from: https://freesound.org/ or https://www.zapsplat.com/

Convert to .ogg format and save as `ChatAlert/Sounds/airhorn.ogg`

## Load Order (from ChatAlert.toc)

1. LibStub
2. CallbackHandler-1.0
3. Ace3 libraries
4. Core.lua (addon initialization, event handling)
5. Config.lua (settings UI setup)

## Saved Variables

Settings are stored in:
```
World of Warcraft/_retail_/WTF/Account/<ACCOUNT>/SavedVariables/ChatAlertDB.lua
```

Structure:
```lua
ChatAlertDB = {
    global = {
        rules = { ... },
        enabledChannels = { ... },
        useFallbackSound = true
    }
}
```

## Development Notes

- Pattern matching is case-insensitive
- Only one sound plays per message (first matching rule)
- Zone detection uses C_Map.GetBestMapForUnit("player")
- Events are dynamically registered based on enabled channels
- Config uses functional options table for dynamic updates

## Next Steps

1. Download Ace3 libraries (see Libs/LIBS_INSTALLATION.md)
2. Optionally add airhorn.ogg sound file (see Sounds/README.md)
3. Copy ChatAlert folder to WoW AddOns directory
4. Enable addon in WoW
5. Configure rules with `/ca` command

## Support Files

- **.gitignore**: Excludes libraries and sound files from version control
- **README files**: Provide context-specific documentation in each directory
