#\!/bin/bash

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_BASE="$SCRIPT_DIR"

# Detect platform
PLATFORM=$(uname -s)

# Detect WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    DETECTED_PLATFORM="WSL"
    MPLABX_BASE="/mnt/c/Program Files/Microchip/MPLABX/v6.20"
# Detect Git Bash on Windows (MINGW/MSYS)
elif [[ "$PLATFORM" == MINGW* ]] || [[ "$PLATFORM" == MSYS* ]]; then
    DETECTED_PLATFORM="MINGW"
    MPLABX_BASE="/c/Program Files/Microchip/MPLABX/v6.20"
# Detect Cygwin
elif [[ "$PLATFORM" == CYGWIN* ]]; then
    DETECTED_PLATFORM="CYGWIN"
    MPLABX_BASE="/cygdrive/c/Program Files/Microchip/MPLABX/v6.20"
# Detect macOS
elif [[ "$PLATFORM" == "Darwin" ]]; then
    DETECTED_PLATFORM="MACOS"
    MPLABX_BASE="/Applications/microchip/mplabx/v6.20"
# Linux or other Unix
else
    DETECTED_PLATFORM="LINUX"
    MPLABX_BASE="/opt/microchip/mplabx/v6.20"
fi

# Set tool paths based on platform
if [[ "$DETECTED_PLATFORM" == "MACOS" ]]; then
    MAKE_EXE="$MPLABX_BASE/gnuBins/GnuWin32/bin/make"
    PK3CMD="$MPLABX_BASE/mplab_platform/mplab_ipe/pk3cmd"
elif [[ "$DETECTED_PLATFORM" == "LINUX" ]]; then
    MAKE_EXE="$MPLABX_BASE/gnuBins/GnuWin32/bin/make"
    PK3CMD="$MPLABX_BASE/mplab_platform/mplab_ipe/pk3cmd"
else
    # Windows-based (WSL, MINGW, CYGWIN)
    MAKE_EXE="$MPLABX_BASE/gnuBins/GnuWin32/bin/make.exe"
    PK3CMD="$MPLABX_BASE/mplab_platform/mplab_ipe/pk3cmd.exe"
fi

# Allow override via environment variables
MAKE_EXE="${MPLAB_MAKE:-$MAKE_EXE}"
PK3CMD="${MPLAB_PK3CMD:-$PK3CMD}"

if [ "$1" = "BMS_APP" ] || [ "$1" = "bms_app" ]; then
    echo "Building BMS Application..."
    cd "$PROJECT_BASE/Projects/BMS_App_02.X"
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
    echo "BMS Application build complete\!"

elif [ "$1" = "BMS_BOOT" ] || [ "$1" = "bms_boot" ]; then
    echo "Building BMS Bootloader..."
    cd "$PROJECT_BASE/Projects/BMS_Bootloader_02.X"
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
    "$MAKE_EXE" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
    echo "BMS Bootloader build complete\!"

elif [ "$1" = "MCU_APP" ] || [ "$1" = "mcu_app" ]; then
    echo "Building MCU Application..."
    cd "$PROJECT_BASE/Projects/MCU_App.X"
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default clean
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default
    echo "MCU Application build complete\!"

elif [ "$1" = "MCU_BOOT" ] || [ "$1" = "mcu_boot" ]; then
    echo "Building MCU Bootloader..."
    cd "$PROJECT_BASE/Projects/MCU_Bootloader.X"
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default clean
    "$MAKE_EXE" -f nbproject/Makefile-default.mk CONF=default
    echo "MCU Bootloader build complete\!"

elif [ "$1" = "DBC" ] || [ "$1" = "dbc" ]; then
    echo "Generating DBC files from JSON..."
    cd "$PROJECT_BASE/CAN"

    # Check if Python is available
    if ! command -v python &> /dev/null && ! command -v python3 &> /dev/null; then
        echo "Error: Python is required for DBC generation but not found"
        exit 1
    fi

    # Use python3 if available, otherwise python
    PYTHON_CMD="python3"
    if ! command -v python3 &> /dev/null; then
        PYTHON_CMD="python"
    fi

    # Run DBC generation scripts
    $PYTHON_CMD dbc_json_to_C_refactored.py
    $PYTHON_CMD dbc_json_to_DBF.py

    echo "DBC generation complete\!"

elif [ "$1" = "ALL" ] || [ "$1" = "all" ]; then
    echo "Building all projects..."
    "$0" BMS_APP
    "$0" BMS_BOOT
    "$0" MCU_APP
    "$0" MCU_BOOT
    echo "All builds complete\!"

elif [ "$1" = "POWER" ] || [ "$1" = "power" ]; then
    if [ -z "$2" ]; then
        echo "Error: Please specify device to power"
        echo "Available devices: BMS, MCU, P33EP32GP502"
        echo "Example: bash build_commands.sh POWER BMS"
        exit 1
    fi

    if [ "$2" = "BMS" ] || [ "$2" = "bms" ]; then
        echo "Powering BMS (dsPIC33EP256MC506) at 3.3V..."
        "$PK3CMD" -P33EP256MC506 -V3.3 -C -L
    elif [ "$2" = "MCU" ] || [ "$2" = "mcu" ]; then
        echo "Powering MCU (dsPIC33EP512MU810) at 3.3V..."
        "$PK3CMD" -P33EP512MU810 -V3.3 -C -L
    elif [ "$2" = "P33EP32GP502" ] || [ "$2" = "p33ep32gp502" ]; then
        echo "Powering dsPIC33EP32GP502 at 3.3V..."
        "$PK3CMD" -P33EP32GP502 -V3.3 -C -L
    else
        echo "Error: Unknown device '$2'"
        echo "Available devices: BMS, MCU, P33EP32GP502"
        exit 1
    fi
    echo "Device powered on successfully\!"

elif [ "$1" = "PROGRAM" ] || [ "$1" = "program" ]; then
    if [ -z "$2" ]; then
        echo "Error: Please specify project to program"
        echo "Available projects: BMS_APP, BMS_BOOT, MCU_APP, MCU_BOOT"
        echo "Example: bash build_commands.sh PROGRAM BMS_APP"
        exit 1
    fi

    if [ "$2" = "BMS_APP" ] || [ "$2" = "bms_app" ]; then
        echo "Programming BMS Application..."
        "$PK3CMD" -P33EP256MC506 -F"$PROJECT_BASE/Projects/BMS_App_02.X/dist/DEFAULT/production/BMS_App_02.X.production.hex" -M -E -L
        echo "BMS Application programmed successfully\!"
    elif [ "$2" = "BMS_BOOT" ] || [ "$2" = "bms_boot" ]; then
        echo "Programming BMS Bootloader..."
        "$PK3CMD" -P33EP256MC506 -F"$PROJECT_BASE/Projects/BMS_Bootloader_02.X/dist/DEFAULT/production/BMS_Bootloader_02.X.production.hex" -M -E -L
        echo "BMS Bootloader programmed successfully\!"
    elif [ "$2" = "MCU_APP" ] || [ "$2" = "mcu_app" ]; then
        echo "Programming MCU Application..."
        "$PK3CMD" -P33EP512MU810 -F"$PROJECT_BASE/Projects/MCU_App.X/dist/default/production/MCU_App.X.production.hex" -M -E -L
        echo "MCU Application programmed successfully\!"
    elif [ "$2" = "MCU_BOOT" ] || [ "$2" = "mcu_boot" ]; then
        echo "Programming MCU Bootloader..."
        "$PK3CMD" -P33EP512MU810 -F"$PROJECT_BASE/Projects/MCU_Bootloader.X/dist/default/production/MCU_Bootloader.X.production.hex" -M -E -L
        echo "MCU Bootloader programmed successfully\!"
    else
        echo "Error: Unknown project '$2'"
        echo "Available projects: BMS_APP, BMS_BOOT, MCU_APP, MCU_BOOT"
        exit 1
    fi

else
    echo "Usage: bash build_commands.sh [COMMAND] [OPTIONS]"
    echo ""
    echo "Build Commands:"
    echo "  BMS_APP                              # Build BMS Application"
    echo "  BMS_BOOT                             # Build BMS Bootloader"
    echo "  MCU_APP                              # Build MCU Application"
    echo "  MCU_BOOT                             # Build MCU Bootloader"
    echo "  DBC                                  # Generate DBC files from JSON"
    echo "  ALL                                  # Build all main projects"
    echo ""
    echo "Hardware Commands:"
    echo "  POWER [device]                       # Power device at 3.3V and release from reset"
    echo "    Devices: BMS, MCU, P33EP32GP502"
    echo "  PROGRAM [project]                    # Program device with hex file"
    echo "    Projects: BMS_APP, BMS_BOOT, MCU_APP, MCU_BOOT"
    echo ""
    echo "Examples:"
    echo "  bash build_commands.sh BMS_APP       # Build BMS Application"
    echo "  bash build_commands.sh POWER BMS     # Power on BMS at 3.3V"
    echo "  bash build_commands.sh PROGRAM MCU_APP # Program MCU with application"
fi
