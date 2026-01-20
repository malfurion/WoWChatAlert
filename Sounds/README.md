# Sound Files

## Airhorn Sound File

Place your airhorn sound file here as `airhorn.ogg` or `airhorn.mp3`.

### Where to Get Free Airhorn Sounds

1. **Freesound.org**
   - https://freesound.org/search/?q=airhorn
   - Requires free account
   - Choose Creative Commons licensed sounds

2. **Zapsplat**
   - https://www.zapsplat.com/sound-effect-category/air-horns/
   - Free with account
   - High-quality sound effects

3. **YouTube Audio Library**
   - Search for airhorn sound effects
   - Download and convert to .ogg

### Converting Audio Files

**Online Converters:**
- https://convertio.co/mp3-ogg/
- https://online-audio-converter.com/

**Desktop Software:**
- **Audacity** (Free, Open Source)
  1. Open audio file
  2. File → Export → Export as OGG
  3. Save as `airhorn.ogg`

### File Format Requirements

- **Supported formats**: .ogg (recommended), .mp3
- **Recommended settings**:
  - Sample rate: 44100 Hz
  - Bitrate: 128-192 kbps
  - Duration: 1-3 seconds (short and punchy)

### Testing Your Sound

1. Place the sound file in this folder
2. Load WoW and the addon
3. Open ChatAlert settings (`/ca`)
4. Create a test rule with pattern "test"
5. Type `/say test` in chat
6. The sound should play

### Fallback Sound

If no custom sound file is found, the addon will use WoW's built-in READY_CHECK sound (if "Use Fallback Sound" is enabled in settings).

### Multiple Sound Files

You can create multiple sound files and specify different ones for each rule:
- `airhorn.ogg` (default)
- `alert1.ogg`
- `alert2.ogg`
- etc.

Then update the "Sound File Path" in each rule to use the desired sound.
