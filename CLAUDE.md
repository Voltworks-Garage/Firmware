# Claude Build Commands

## Environment Detection
**IMPORTANT:** Before executing ANY build commands:
1. Check the actual OS using `uname -a` or `cmd.exe /c ver`
2. Detect environment type:
   - **Windows Native (cmd/PowerShell)**: Use Windows paths like `C:\path\to\file`
   - **MinGW/Git Bash**: Running on Windows but in MSYS environment - use Windows paths (NOT /mnt/c)
   - **WSL**: Linux subsystem on Windows - use `/mnt/c/` paths
   - **Native Linux/Mac**: Use standard Unix paths

**Current typical environment:** MinGW64 on Windows 10/11
- Use Windows-style paths: `c:/REPOS/...` or `C:\REPOS\...`
- Do NOT use `/mnt/c/` prefix (that's for WSL only)
- Git Bash understands both forward slashes and backslashes in paths

## Quick Build Script (Recommended)
Use the automated build script for easy project building:
```bash
# Build specific projects
./build_commands.sh BMS_APP           # Build BMS Application
./build_commands.sh BMS_BOOT          # Build BMS Bootloader
./build_commands.sh MCU_APP           # Build MCU Application
./build_commands.sh MCU_BOOT          # Build MCU Bootloader
./build_commands.sh BLE_APP           # Build BLE Application (ESP32-S3)
./build_commands.sh BLE_UPLOAD        # Upload BLE Application (auto-detect port)
./build_commands.sh BLE_BUILD_UPLOAD  # Build and upload BLE Application
./build_commands.sh DBC               # Generate DBC files from JSON
./build_commands.sh ALL               # Build all main projects

# Show help
./build_commands.sh help
```

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

### BLE_Display (Arduino ESP32-S3) Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BLE_Display/BLE_Display"
"/mnt/c/Scripts/arduino-cli_1.3.1_Windows_64bit/arduino-cli.exe" compile --fqbn esp32:esp32:esp32s3 BLE_Display.ino
```

### BLE_Display Upload (with auto-detect)
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BLE_Display/BLE_Display"
PORT=$("/mnt/c/Scripts/arduino-cli_1.3.1_Windows_64bit/arduino-cli.exe" board list | grep -i "esp32" | head -n 1 | awk '{print $1}')
"/mnt/c/Scripts/arduino-cli_1.3.1_Windows_64bit/arduino-cli.exe" upload -p "$PORT" --fqbn esp32:esp32:esp32s3 BLE_Display.ino
```

## Notes
- Uses MPLAB X v6.20 build tools
- Full path to make.exe required in WSL environment
- Clean step removes previous build artifacts

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