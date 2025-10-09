# Claude Build Commands

## Quick Build Script (Recommended - Cross-Platform)
The build_commands.sh script automatically detects your platform and sets appropriate paths. Supports:
- **WSL** (Windows Subsystem for Linux)
- **Git Bash/MINGW** (Windows)
- **Cygwin** (Windows)
- **macOS**
- **Linux**

Use the automated build script for easy project building:
```bash
# Build specific projects
./build_commands.sh BMS_APP      # Build BMS Application
./build_commands.sh BMS_BOOT     # Build BMS Bootloader
./build_commands.sh MCU_APP      # Build MCU Application
./build_commands.sh MCU_BOOT     # Build MCU Bootloader
./build_commands.sh ALL          # Build all main projects

# Power on devices
./build_commands.sh POWER BMS            # Power BMS at 3.3V
./build_commands.sh POWER MCU            # Power MCU at 3.3V
./build_commands.sh POWER P33EP32GP502   # Power dsPIC33EP32GP502 at 3.3V

# Program devices
./build_commands.sh PROGRAM BMS_APP      # Program BMS Application
./build_commands.sh PROGRAM BMS_BOOT     # Program BMS Bootloader
./build_commands.sh PROGRAM MCU_APP      # Program MCU Application
./build_commands.sh PROGRAM MCU_BOOT     # Program MCU Bootloader

# Show help
./build_commands.sh
```

### Environment Variable Overrides
You can override the default tool paths using environment variables:
```bash
# Override make executable path
export MPLAB_MAKE="/path/to/custom/make"

# Override pk3cmd executable path
export MPLAB_PK3CMD="/path/to/custom/pk3cmd"

# Then run the build script
./build_commands.sh BMS_APP
```

### Platform-Specific Notes
- **WSL**: Uses `/mnt/c/Program Files/...` paths
- **Git Bash/MINGW**: Uses `/c/Program Files/...` paths
- **Cygwin**: Uses `/cygdrive/c/Program Files/...` paths
- **macOS**: Uses `/Applications/microchip/mplabx/...` paths
- **Linux**: Uses `/opt/microchip/mplabx/...` paths
- **DBC Generation**: Works on all platforms (requires Python 3 or Python 2)

## Manual Build Commands (Alternative)

### BMS_App_02.X Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BMS_App_02.X"
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
```

### BMS_Bootloader_02.X Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BMS_Bootloader_02.X"
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
```

### MCU_App.X Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/MCU_App.X"
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-default.mk CONF=default clean
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-default.mk CONF=default
```

### MCU_Bootloader.X Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/MCU_Bootloader.X"
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-default.mk CONF=default clean
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-default.mk CONF=default
```

## PICkit3 Hardware Programming

### PICkit3 Tool Path
```bash
PK3CMD="/mnt/c/Program Files/Microchip/MPLABX/v6.20/mplab_platform/mplab_ipe/pk3cmd.exe"
```

### BMS_App_02.X Programming (dsPIC33EP256MC506)
```bash
# Program BMS Application and release from reset
"$PK3CMD" -P33EP256MC506 -F"Projects/BMS_App_02.X/dist/DEFAULT/production/BMS_App_02.X.production.hex" -M -E -L

# Verify programming
"$PK3CMD" -P33EP256MC506 -F"Projects/BMS_App_02.X/dist/DEFAULT/production/BMS_App_02.X.production.hex" -Y -L
```

### BMS_Bootloader_02.X Programming (dsPIC33EP256MC506)
```bash
# Program BMS Bootloader and release from reset
"$PK3CMD" -P33EP256MC506 -F"Projects/BMS_Bootloader_02.X/dist/DEFAULT/production/BMS_Bootloader_02.X.production.hex" -M -E -L

# Verify programming
"$PK3CMD" -P33EP256MC506 -F"Projects/BMS_Bootloader_02.X/dist/DEFAULT/production/BMS_Bootloader_02.X.production.hex" -Y -L
```

### MCU_App.X Programming (dsPIC33EP512MU810)
```bash
# Program MCU Application and release from reset
"$PK3CMD" -P33EP512MU810 -F"Projects/MCU_App.X/dist/default/production/MCU_App.X.production.hex" -M -E -L

# Verify programming
"$PK3CMD" -P33EP512MU810 -F"Projects/MCU_App.X/dist/default/production/MCU_App.X.production.hex" -Y -L
```

### MCU_Bootloader.X Programming (dsPIC33EP512MU810)
```bash
# Program MCU Bootloader and release from reset
"$PK3CMD" -P33EP512MU810 -F"Projects/MCU_Bootloader.X/dist/default/production/MCU_Bootloader.X.production.hex" -M -E -L

# Verify programming
"$PK3CMD" -P33EP512MU810 -F"Projects/MCU_Bootloader.X/dist/default/production/MCU_Bootloader.X.production.hex" -Y -L
```

### Common PICkit3 Commands
```bash
# Show help
"$PK3CMD" -?

# Erase device only
"$PK3CMD" -P[DEVICE] -E

# Blank check device
"$PK3CMD" -P[DEVICE] -C

# Power device from PICkit3 (3.3V) and release from reset
# NOTE: -C (blank check) forces connection to target before powering
"$PK3CMD" -P[DEVICE] -V3.3 -C -L

# Hold device in reset
"$PK3CMD" -P[DEVICE] -H

# Release device from reset
"$PK3CMD" -P[DEVICE] -L

# Read program memory (address range in hex)
"$PK3CMD" -P[DEVICE] -GP0-1FF
```

### PICkit3 Command Options
- `-P[DEVICE]`: Specify target device (e.g., 33EP256MC506, 33EP512MU810)
- `-F[FILE]`: Specify hex file to program
- `-M[region]`: Program device (regions: P=Program, E=EEPROM, I=ID, C=Configuration, B=Boot)
- `-E`: Erase flash device
- `-Y[region]`: Verify device (regions: P=Program, E=EEPROM, I=ID, C=Configuration, B=Boot)
- `-V[VOLTAGE]`: Power target from PICkit3 at specified voltage (e.g., -V3.3)
- `-C`: Blank check device
- `-I`: High voltage MCLR
- `-H`: Hold device in reset
- `-L`: Release device from reset
- `-B`: Batch mode operation
- `-G[Type][range/path]`: Read functions (GP=Program, GE=EEPROM, GI=ID, GC=Config, GB=Boot, GF=to file)
- `-?`: Show help screen

## Notes
- Uses MPLAB X v6.20 build tools
- **build_commands.sh is cross-platform** - automatically detects WSL, Git Bash, Cygwin, macOS, and Linux
- Environment variables MPLAB_MAKE and MPLAB_PK3CMD can override default tool paths
- Full path to make.exe required in WSL environment (handled automatically by script)
- Full path to pk3cmd.exe required for hardware programming (handled automatically by script)
- Clean step removes previous build artifacts
- Always verify programming after upload for production builds
- When powering target with -V, include -C to force connection to target first
- Always include -L flag to release device from reset so target can run after programming/powering

## MPLAB X Makefile Directory Hash Algorithm
MPLAB X generates `_ext/[hash]` directories in Makefiles to avoid filename conflicts. The hash is calculated using Java's String hashCode algorithm on the source directory path, then taking the absolute value:

```python
def mplab_directory_hash(path):
    h = 0
    for c in path:
        h = ((31 * h + ord(c)) % (2**32))
        if h >= 2**31:
            h -= 2**32
    return abs(h)
```

Examples:
- `../../Libraries/PIC33_plib/src` → `_ext/356824117`
- `../../Libraries/Standard` → `_ext/1136797869`
- `../../RTOS/Scheduler` → `_ext/1176946926`

## Git Workflow
- After rebasing a branch, you MUST force push to update the remote branch: `git push --force-with-lease`
- Use `--force-with-lease` instead of `--force` for safety (prevents overwriting other people's work)
- Example workflow:
  ```bash
  git rebase origin/main
  git push --force-with-lease
  ```

## Code Standards
- ALWAYS review and follow the coding standards in `CODING_STANDARDS.md` before generating any new code
- Check for unused variable/function warnings when building projects
- Use proper naming conventions and formatting as specified in the standards document

## Function Renaming Protocol
- When you modify a public function name in a .c file, you MUST:
  1. Update the corresponding .h header file to match
  2. Search the entire codebase for usages of the old function name
  3. Update all calling code to use the new function name
  4. Ask the user to build the project to verify no compilation errors
- This ensures interfaces remain consistent and prevents broken builds

## File Management Protocol
- NEVER rename, move, or delete user files without explicit permission
- NEVER modify file extensions or file paths without explicit user request
- When testing scripts or code generation tools, use temporary files or ask permission first
- If you need to test file operations, create temporary files with clearly temporary names
- Always preserve original files when making modifications
- Example violations to avoid:
  - Renaming `dbc.json` to `dbc_backup.json` for testing purposes
  - Moving files to different directories without permission
  - Changing file extensions during testing
- If file operations fail, use git commands to restore originals when possible

## Include Path Protocol
- NEVER use relative paths in #include statements (e.g., `#include "../../Libraries/Standard/file.h"`)
- Use simple include filenames without paths (e.g., `#include "file.h"`)
- The compiler's include path configuration will locate the files correctly
- This prevents brittle path dependencies and makes code more portable
- Example violations to avoid:
  - `#include "../Libraries/Standard/movingAverageInt.h"` (incorrect)
  - `#include "movingAverageInt.h"` (correct)

## CAN DBC Protocol
- ALWAYS read `CAN/README.md` before modifying `CAN/dbc.json`
- Follow the signal addition guidelines for regular vs multiplexed messages
- For regular messages: ensure total bits < 65
- For multiplexed messages: fill mux groups efficiently, each group limited to 64 - mux_bits
- After DBC changes, regenerate CAN code using the batch file