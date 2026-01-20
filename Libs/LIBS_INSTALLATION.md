# Ace3 Libraries Installation

ChatAlert requires the following Ace3 libraries to function. You need to download and install them in the `Libs/` directory.

## Required Libraries

1. **LibStub**
2. **CallbackHandler-1.0**
3. **AceAddon-3.0**
4. **AceEvent-3.0**
5. **AceDB-3.0**
6. **AceDBOptions-3.0**
7. **AceConsole-3.0**
8. **AceConfig-3.0** (includes AceConfigRegistry-3.0 and AceConfigDialog-3.0)
9. **AceGUI-3.0**

## Installation Methods

### Method 1: Download from WoWAce (Recommended)

Visit [WoWAce](https://www.wowace.com/projects/ace3) and download the standalone Ace3 libraries package.

Extract the contents to the `Libs/` directory so you have:
```
ChatAlert/
  Libs/
    LibStub/
      LibStub.lua
    CallbackHandler-1.0/
      CallbackHandler-1.0.lua
    AceAddon-3.0/
      AceAddon-3.0.lua
    AceEvent-3.0/
      AceEvent-3.0.lua
    AceDB-3.0/
      AceDB-3.0.lua
    AceDBOptions-3.0/
      AceDBOptions-3.0.lua
    AceConsole-3.0/
      AceConsole-3.0.lua
    AceConfig-3.0/
      AceConfig-3.0.lua
      AceConfigRegistry-3.0/
        AceConfigRegistry-3.0.lua
      AceConfigDialog-3.0/
        AceConfigDialog-3.0.lua
    AceGUI-3.0/
      AceGUI-3.0.lua
      (and widget files)
```

### Method 2: Download Individual Libraries from GitHub

Each library can be downloaded separately:

- LibStub: https://github.com/wowace/LibStub
- CallbackHandler-1.0: https://github.com/wowace/CallbackHandler-1.0
- AceAddon-3.0: https://github.com/wowace/AceAddon-3.0
- AceEvent-3.0: https://github.com/wowace/AceEvent-3.0
- AceDB-3.0: https://github.com/wowace/AceDB-3.0
- AceDBOptions-3.0: https://github.com/wowace/AceDBOptions-3.0
- AceConsole-3.0: https://github.com/wowace/AceConsole-3.0
- AceConfig-3.0: https://github.com/wowace/AceConfig-3.0
- AceGUI-3.0: https://github.com/wowace/AceGUI-3.0

### Method 3: Use CurseForge Client

If you use the CurseForge client, it can automatically manage library dependencies for you.

## Verification

After installing the libraries, your `Libs/` directory should contain all the folders listed above. The addon will not load if any required libraries are missing.

## Alternative: Pre-packaged Ace3

You can also download a pre-packaged version of Ace3 libraries from:
https://www.wowace.com/projects/ace3/files

This includes all necessary libraries in one download.
