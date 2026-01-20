# ChatAlert - Quick Installation Guide

Follow these steps to install and use ChatAlert.

## Prerequisites

- World of Warcraft (Retail version)
- Basic knowledge of WoW addons

## Step-by-Step Installation

### Step 1: Locate Your AddOns Folder

Find your WoW AddOns directory:

**Windows:**
```
C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\
```

**Mac:**
```
/Applications/World of Warcraft/_retail_/Interface/AddOns/
```

If the `AddOns` folder doesn't exist, create it.

### Step 2: Copy ChatAlert Folder

Copy the entire `ChatAlert` folder into your AddOns directory:

```
World of Warcraft/
  _retail_/
    Interface/
      AddOns/
        ChatAlert/    <-- Copy this entire folder here
```

### Step 3: Install Ace3 Libraries

ChatAlert requires Ace3 libraries. Choose one method:

#### Method A: Download Ace3 Package (Easiest)

1. Go to https://www.wowace.com/projects/ace3/files
2. Download the latest version
3. Extract the ZIP file
4. Copy all library folders (LibStub, AceAddon-3.0, AceEvent-3.0, etc.) into `ChatAlert/Libs/`

Your folder structure should look like:
```
ChatAlert/
  Libs/
    LibStub/
    CallbackHandler-1.0/
    AceAddon-3.0/
    AceEvent-3.0/
    AceDB-3.0/
    AceDBOptions-3.0/
    AceConsole-3.0/
    AceConfig-3.0/
    AceGUI-3.0/
```

#### Method B: Use Another Ace3 Addon

If you already have another addon that includes Ace3 libraries:

1. Find that addon's `Libs` folder
2. Copy the required libraries to ChatAlert's `Libs` folder

### Step 4: Add Airhorn Sound (Optional)

1. Download a free airhorn sound from:
   - https://freesound.org/ (search "airhorn")
   - https://www.zapsplat.com/

2. Convert to .ogg format if needed (using Audacity or online converter)

3. Save as `ChatAlert/Sounds/airhorn.ogg`

**If you skip this step:** The addon will use WoW's built-in READY_CHECK sound instead.

### Step 5: Launch World of Warcraft

1. Start WoW
2. At character selection, click **"AddOns"** button
3. Find **"ChatAlert"** in the list
4. Make sure it's **checked/enabled**
5. Click **"Okay"**
6. Enter the game

### Step 6: Verify Installation

Once in game, type:
```
/chatalert
```
or
```
/ca
```

If the settings window opens, the addon is installed correctly!

## Initial Configuration

### Create Your First Rule

1. Open settings: `/ca`
2. Click **"Add New Rule"**
3. Set pattern to: `inv`
4. Set match type to: `Contains`
5. Leave Zone ID empty
6. Ensure **"Enabled"** is checked
7. Click **"Okay"**

### Test the Rule

Type in chat:
```
/say inv
```

You should hear a sound! If not, see Troubleshooting below.

## Troubleshooting

### "ChatAlert could not be loaded"

**Problem:** Ace3 libraries are missing

**Solution:**
1. Check that `Libs/` folder contains all required libraries
2. Re-download Ace3 from https://www.wowace.com/projects/ace3
3. Verify folder names match exactly (case-sensitive on some systems)

### No sound plays

**Problem:** Sound file missing or path incorrect

**Solution:**
1. Enable "Use Fallback Sound" in General Settings
2. Verify sound file exists at `ChatAlert/Sounds/airhorn.ogg`
3. Check that master volume in WoW is not muted
4. Try using WoW's built-in sound path:
   ```
   Sound\Interface\RaidWarning.ogg
   ```

### Settings window doesn't open

**Problem:** Addon not loading or conflict

**Solution:**
1. Type `/reload` to reload UI
2. Check AddOns list at character selection
3. Install BugSack addon to see error messages
4. Disable other addons to check for conflicts

### Rules not triggering

**Problem:** Channel not monitored or zone mismatch

**Solution:**
1. Check that the chat channel is enabled (scroll down in settings)
2. If Zone ID is set, verify you're in that zone
3. Check that pattern matches (case-insensitive)
4. Ensure rule is enabled (toggle switch)

## Next Steps

- Read the full README.md for advanced features
- Create zone-specific rules
- Configure multiple patterns
- Adjust channel monitoring

## Getting Help

If you encounter issues:

1. Check the main README.md
2. Verify all installation steps
3. Test with a fresh `/reload`
4. Check WoW version matches the addon's Interface version

## Uninstalling

To remove ChatAlert:

1. Exit WoW completely
2. Delete the `ChatAlert` folder from your AddOns directory
3. (Optional) Delete saved settings:
   ```
   WTF\Account\<ACCOUNT>\SavedVariables\ChatAlertDB.lua
   ```

## Updating

To update ChatAlert:

1. Exit WoW completely
2. Replace the old ChatAlert folder with the new version
3. Keep your Ace3 libraries (unless updating those too)
4. Your settings are preserved in SavedVariables
