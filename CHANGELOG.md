# ChatAlert Changelog

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
