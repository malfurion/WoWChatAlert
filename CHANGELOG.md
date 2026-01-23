# ChatAlert Changelog

## [1.0.6] - 2026-01-23

### Added
- Automatic instance detection: Chat monitoring is now automatically disabled when entering instances (dungeons, raids, scenarios, arenas, battlegrounds)
- Debug mode: Optional setting to display monitoring status messages (enable in General settings)
- `DebugPrint()` function for conditional debug output

### Changed
- Event registration now updates dynamically based on instance status
- Monitoring status messages only shown when debug mode is enabled

### Fixed
- Prevented potential API access issues in instances by disabling chat monitoring in instanced content

## [1.0.5] - 2026-01-22

### Added
- Comprehensive support for all chat event types organized by category
- UI tabs for better organization of channel settings

### Changed
- Reorganized channel settings into categorized tabs (Player Chat, System & Achievements, NPCs & Monsters, Combat & Progression, Loot & Economy, PvP & Battlegrounds, Miscellaneous)

## [1.0.4] - 2026-01-21

### Added
- Support for Emote (/me) chat events
- Support for Text Emote chat events
- Support for Instance Chat and Instance Chat Leader
- Support for Battle.net Whisper messages

### Fixed
- Missing chat event handlers preventing emotes and instance chat from being monitored

## [1.0.3] - 2026-01-20

### Changes
- Updated for WoW 12.0.0 (Midnight Pre-Patch)
- Compatible with latest game version

## [1.0.2] - 2026-01-20

### Changes
- Added CurseForge project ID to .toc file for automated uploads
- Updated game version to 11.2.7 (WoW Patch 11.2.7)
- Included default airhorn sound in release package

## [1.0.1] - 2026-01-20

### Changes
- Enabled automated CurseForge deployment
- Improved CI/CD pipeline

## [1.0.0] - 2026-01-20

### Initial Release

#### Features
- Pattern matching for chat messages
  - Support for "contains" and "exact match" types
  - Case-insensitive matching
- Custom sound support with fallback to WoW built-in sounds
- Zone-specific rule filtering
- Multi-channel monitoring:
  - Say, Yell, Guild, Officer
  - Party, Party Leader
  - Raid, Raid Leader, Raid Warning
  - Whisper
  - Channels (General/Trade/etc.)
- Comprehensive settings UI with Ace3
  - Add/delete rules dynamically
  - Enable/disable individual rules
  - Toggle channels on/off
  - Current zone display
- Horn icon in addon list
- Categorized under "Chat" in addon manager

#### Technical
- Built with Ace3 framework
- Clean, modular code structure
- Proper event handling and registration
- SavedVariables for persistent settings

#### Commands
- `/chatalert` or `/ca` - Open settings panel

---

## Version History

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
