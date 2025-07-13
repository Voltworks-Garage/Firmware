#\!/bin/bash
MAKE_EXE="/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe"

if [ "$1" = "BMS_APP" ] || [ "$1" = "bms_app" ]; then
    echo "Building BMS Application..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BMS_App_02.X"
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
    echo "BMS Application build complete\!"

elif [ "$1" = "BMS_BOOT" ] || [ "$1" = "bms_boot" ]; then
    echo "Building BMS Bootloader..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BMS_Bootloader_02.X"
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
    echo "BMS Bootloader build complete\!"

elif [ "$1" = "MCU_APP" ] || [ "$1" = "mcu_app" ]; then
    echo "Building MCU Application..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/MCU_App.X"
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default clean
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default
    echo "MCU Application build complete\!"

elif [ "$1" = "MCU_BOOT" ] || [ "$1" = "mcu_boot" ]; then
    echo "Building MCU Bootloader..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/MCU_Bootloader.X"
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default clean
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default
    echo "MCU Bootloader build complete\!"

else
    echo "Usage: bash build_commands.sh [PROJECT]"
    echo "Available projects: BMS_APP, BMS_BOOT, MCU_APP, MCU_BOOT"
    echo "Examples:"
    echo "  bash build_commands.sh BMS_APP"
    echo "  bash build_commands.sh MCU_BOOT"
fi
