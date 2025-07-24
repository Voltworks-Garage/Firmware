# Claude Build Commands

## Quick Build Script (Recommended)
Use the automated build script for easy project building:
```bash
# Build specific projects
./build_commands.sh BMS_APP      # Build BMS Application
./build_commands.sh BMS_BOOT     # Build BMS Bootloader
./build_commands.sh MCU_APP      # Build MCU Application  
./build_commands.sh MCU_BOOT     # Build MCU Bootloader
./build_commands.sh ALL          # Build all main projects

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

## Notes
- Uses MPLAB X v6.20 build tools
- Full path to make.exe required in WSL environment
- Clean step removes previous build artifacts

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