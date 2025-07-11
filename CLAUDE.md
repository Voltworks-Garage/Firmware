# Claude Build Commands

## BMS_App_02.X Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BMS_App_02.X"
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=default clean
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=default
```

## BMS_Bootloader_02.X Project Build
```bash
cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BMS_Bootloader_02.X"
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=default clean
"/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe" -f nbproject/Makefile-DEFAULT.mk CONF=default
```

## Notes
- Uses MPLAB X v6.20 build tools
- Full path to make.exe required in WSL environment
- Clean step removes previous build artifacts

## Code Standards
- ALWAYS review and follow the coding standards in `CODING_STANDARDS.md` before generating any new code
- Check for unused variable/function warnings when building projects
- Use proper naming conventions and formatting as specified in the standards document