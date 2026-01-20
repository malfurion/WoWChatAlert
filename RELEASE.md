# Release Process

This document explains how to create and publish new releases of ChatAlert.

## Prerequisites

Before you can create releases, you need to:

1. **Create a GitHub repository** for this addon
2. **Set up accounts** on the distribution platforms
3. **Configure API tokens** as GitHub Secrets

## Setup Instructions

### 1. Create GitHub Repository

1. Go to https://github.com/new
2. Create a repository named `ChatAlert`
3. **Do NOT initialize** with README (we already have one)
4. Copy the repository URL

### 2. Update Repository URLs

Replace `YOUR_GITHUB_USERNAME` in the following files with your actual GitHub username:

- `README.md` (lines 3, 4, 5, 12, 33)

### 3. Get API Tokens

You'll need API tokens from the platforms you want to publish to:

#### CurseForge (Required)

1. Go to https://www.curseforge.com/account/api-tokens
2. Click "Generate Token"
3. Copy the token (you won't see it again!)

#### WoWInterface (Optional)

1. Go to https://www.wowinterface.com/downloads/filecpl.php?action=apitokens
2. Generate a new API token
3. Copy the token

#### Wago Addons (Optional)

1. Go to https://addons.wago.io/account
2. Navigate to API tokens section
3. Generate a new token
4. Copy the token

### 4. Configure GitHub Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add the following secrets:

| Secret Name | Required | Description |
|-------------|----------|-------------|
| `CF_API_KEY` | **Yes** | Your CurseForge API token |
| `WOWI_API_TOKEN` | No | Your WoWInterface API token |
| `WAGO_API_TOKEN` | No | Your Wago Addons API token |

**Note:** `GITHUB_TOKEN` is automatically provided by GitHub Actions - you don't need to add it.

### 5. Create CurseForge Project

1. Go to https://www.curseforge.com/project/create/wow-addon
2. Fill in the project details:
   - **Name:** ChatAlert
   - **Summary:** Plays an airhorn sound when chat messages match configured patterns
   - **Category:** Chat & Communication
   - **Icon:** Upload the horn icon (Interface\Icons\INV_Misc_Horn_01)
3. Note the **Project ID** from the URL (e.g., `https://www.curseforge.com/wow/addons/PROJECT_ID`)
4. Update `.pkgmeta` if needed (currently not using project ID)

## Creating a Release

### Method 1: GitHub Web Interface (Recommended)

1. Go to your repository on GitHub
2. Click **Releases** → **Draft a new release**
3. Click **Choose a tag** → Create a new tag:
   - Tag name: `v1.0.0` (or next version number)
   - Target: `main` branch
4. Fill in release details:
   - **Release title:** `ChatAlert 1.0.0`
   - **Description:** Copy from `CHANGELOG.md` for this version
5. Click **Publish release**

The GitHub Action will automatically:
- Package the addon with all dependencies
- Upload to CurseForge
- Upload to WoWInterface (if token configured)
- Upload to Wago (if token configured)
- Attach the packaged addon to the GitHub release

### Method 2: Command Line

```bash
# Make sure you're on the main branch and everything is committed
git checkout main
git pull

# Create and push a new tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# Then create the release on GitHub using the web interface
```

## Version Numbering

Follow [Semantic Versioning](https://semver.org/):

- **Major version (1.x.x):** Breaking changes or major new features
- **Minor version (x.1.x):** New features, backwards compatible
- **Patch version (x.x.1):** Bug fixes, small improvements

Examples:
- `v1.0.0` - Initial release
- `v1.1.0` - Added new feature (e.g., sound volume control)
- `v1.1.1` - Fixed a bug in sound playback
- `v2.0.0` - Major rewrite or breaking changes

## Updating CHANGELOG.md

Before creating a release, update `CHANGELOG.md`:

```markdown
## [1.1.0] - 2026-01-25

### Added
- Volume control slider in settings
- Sound preview button

### Fixed
- Pattern matching case sensitivity issue

### Changed
- Improved settings UI layout
```

## Workflow Details

The `.github/workflows/release.yml` workflow does the following:

1. **Trigger:** Runs when you push a tag (e.g., `v1.0.0`)
2. **Checkout:** Downloads the repository code
3. **Package:** Uses BigWigsMods/packager to:
   - Download Ace3 libraries from WoWAce
   - Create addon package
   - Generate TOC file with version info
4. **Upload:** Uploads to configured platforms
5. **Release:** Attaches ZIP file to GitHub release

### Packager Arguments

Current configuration: `-z -d -l`

- `-z`: Create ZIP file for manual download
- `-d`: Include development files in nolib package
- `-l`: Skip CHANGELOG.md line ending conversion

## Troubleshooting

### Action fails with "Invalid API token"

- Check that you've added the secret correctly in GitHub
- Make sure the token hasn't expired
- Verify the secret name matches exactly (case-sensitive)

### Package doesn't include libraries

- Check `.pkgmeta` file is correct
- Ensure `externals` section lists all required libraries
- The packager downloads libraries from WoWAce automatically

### CurseForge upload fails

- Make sure you've created the CurseForge project first
- Verify your API token has upload permissions
- Check that the addon name in `.pkgmeta` matches your project

### Version number in TOC doesn't update

- The packager automatically updates the version from the git tag
- Make sure you're using tags like `v1.0.0` (with the `v` prefix)

## Testing Before Release

Before creating a release:

1. **Test in-game:** Ensure all features work
2. **Check for errors:** Use BugSack to catch any Lua errors
3. **Update CHANGELOG.md:** Document all changes
4. **Update version in TOC:** Change `## Version:` line if needed
5. **Test with fresh install:** Delete SavedVariables and test fresh

## Post-Release

After creating a release:

1. **Verify uploads:** Check that the addon appears on CurseForge/WoWInterface/Wago
2. **Test download:** Download from CurseForge and verify it works
3. **Monitor for bugs:** Watch for user reports on CurseForge comments
4. **Update documentation:** If you added new features, update README.md

## Rollback

If you need to rollback a release:

1. **Delete the tag:**
   ```bash
   git tag -d v1.0.0
   git push origin :refs/tags/v1.0.0
   ```

2. **Delete the GitHub release:**
   - Go to Releases → Click the release → Delete release

3. **Hide on CurseForge:**
   - Go to your project → Files
   - Mark the file as "Hidden" or delete it

## Additional Resources

- [BigWigsMods Packager Documentation](https://github.com/BigWigsMods/packager)
- [CurseForge API Documentation](https://support.curseforge.com/en/support/solutions/articles/9000197321)
- [WoW Addon Development Guide](https://wowpedia.fandom.com/wiki/Creating_an_addon)
