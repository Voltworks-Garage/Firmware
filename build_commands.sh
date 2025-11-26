#\!/bin/bash
MAKE_EXE="/mnt/c/Program Files/Microchip/MPLABX/v6.20/gnuBins/GnuWin32/bin/make.exe"
ARDUINO_CLI="/mnt/c/Scripts/arduino-cli_1.3.1_Windows_64bit/arduino-cli.exe"

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

elif [ "$1" = "DBC" ] || [ "$1" = "dbc" ]; then
    echo "Generating DBC files from JSON..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/CAN"
    cmd.exe /c GenerateDBCs.bat
    echo "DBC generation complete\!"

elif [ "$1" = "BLE_APP" ] || [ "$1" = "ble_app" ]; then
    echo "Building BLE Application (ESP32-S3)..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BLE_Display/BLE_Display"
    "$ARDUINO_CLI" compile --fqbn esp32:esp32:esp32s3:DebugLevel=debug --verbose BLE_Display.ino
    echo "BLE Application build complete\!"

elif [ "$1" = "BLE_UPLOAD" ] || [ "$1" = "ble_upload" ]; then
    echo "Uploading BLE Application (ESP32-S3)..."
    cd "/mnt/c/REPOS/Voltworks_Garage/Firmware/Projects/BLE_Display/BLE_Display"

    # Auto-detect ESP32-S3 port (look for Serial Port USB)
    PORT=$("$ARDUINO_CLI" board list | grep -i "Serial Port (USB)" | head -n 1 | awk '{print $1}')

    if [ -z "$PORT" ]; then
        echo "Error: ESP32-S3 not found. Please connect the board and try again."
        echo "Available ports:"
        "$ARDUINO_CLI" board list
        exit 1
    fi

    echo "Detected ESP32-S3 on port: $PORT"
    "$ARDUINO_CLI" upload -p "$PORT" --fqbn esp32:esp32:esp32s3:DebugLevel=debug --verbose BLE_Display.ino
    echo "BLE Application upload complete\!"

elif [ "$1" = "BLE_BUILD_UPLOAD" ] || [ "$1" = "ble_build_upload" ]; then
    echo "Building and uploading BLE Application (ESP32-S3)..."
    "$0" BLE_APP
    "$0" BLE_UPLOAD

elif [ "$1" = "ALL" ] || [ "$1" = "all" ]; then
    echo "Building all projects..."
    "$0" BMS_APP
    "$0" BMS_BOOT
    "$0" MCU_APP
    "$0" MCU_BOOT
    echo "All builds complete\!"

else
    echo "Usage: bash build_commands.sh [PROJECT]"
    echo "Available projects: BMS_APP, BMS_BOOT, MCU_APP, MCU_BOOT, BLE_APP, BLE_UPLOAD, BLE_BUILD_UPLOAD, DBC, ALL"
    echo "Examples:"
    echo "  bash build_commands.sh BMS_APP           # Build BMS Application"
    echo "  bash build_commands.sh MCU_BOOT          # Build MCU Bootloader"
    echo "  bash build_commands.sh BLE_APP           # Build BLE Application (ESP32-S3)"
    echo "  bash build_commands.sh BLE_UPLOAD        # Upload BLE Application (auto-detect port)"
    echo "  bash build_commands.sh BLE_BUILD_UPLOAD  # Build and upload BLE Application"
    echo "  bash build_commands.sh DBC               # Generate DBC files from JSON"
    echo "  bash build_commands.sh ALL               # Build all main projects"
fi
