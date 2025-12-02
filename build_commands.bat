@echo off
REM Windows Batch Build Script for Voltworks Garage Firmware
REM Usage: build_commands.bat [PROJECT]

set "MAKE_EXE=C:\Program Files\Microchip\MPLABX\v6.20\gnuBins\GnuWin32\bin\make.exe"
set "ARDUINO_CLI=C:\Scripts\arduino-cli_1.3.1_Windows_64bit\arduino-cli.exe"

if /i "%~1"=="BMS_APP" goto BMS_APP
if /i "%~1"=="BMS_BOOT" goto BMS_BOOT
if /i "%~1"=="MCU_APP" goto MCU_APP
if /i "%~1"=="MCU_BOOT" goto MCU_BOOT
if /i "%~1"=="DBC" goto DBC
if /i "%~1"=="BLE_APP" goto BLE_APP
if /i "%~1"=="BLE_UPLOAD" goto BLE_UPLOAD
if /i "%~1"=="BLE_BUILD_UPLOAD" goto BLE_BUILD_UPLOAD
if /i "%~1"=="ALL" goto ALL
goto HELP

:BMS_APP
echo Building BMS Application...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\Projects\BMS_App_02.X"
"%MAKE_EXE%" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
"%MAKE_EXE%" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
echo BMS Application build complete!
goto END

:BMS_BOOT
echo Building BMS Bootloader...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\Projects\BMS_Bootloader_02.X"
"%MAKE_EXE%" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT clean
"%MAKE_EXE%" -f nbproject/Makefile-DEFAULT.mk CONF=DEFAULT
echo BMS Bootloader build complete!
goto END

:MCU_APP
echo Building MCU Application...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\Projects\MCU_App.X"
"%MAKE_EXE%" -f nbproject/Makefile-default.mk CONF=default clean
"%MAKE_EXE%" -f nbproject/Makefile-default.mk CONF=default
echo MCU Application build complete!
goto END

:MCU_BOOT
echo Building MCU Bootloader...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\Projects\MCU_Bootloader.X"
"%MAKE_EXE%" -f nbproject/Makefile-default.mk CONF=default clean
"%MAKE_EXE%" -f nbproject/Makefile-default.mk CONF=default
echo MCU Bootloader build complete!
goto END

:DBC
echo Generating DBC files from JSON...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\CAN"
call GenerateDBCs.bat
echo DBC generation complete!
goto END

:BLE_APP
echo Building BLE Application (ESP32-S3)...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\Projects\BLE_Display\BLE_Display"
"%ARDUINO_CLI%" compile --fqbn esp32:esp32:esp32s3:DebugLevel=debug --verbose BLE_Display.ino
echo BLE Application build complete!
goto END

:BLE_UPLOAD
echo Uploading BLE Application (ESP32-S3)...
cd /d "C:\REPOS\Voltworks_Garage\Firmware\Projects\BLE_Display\BLE_Display"

REM Auto-detect ESP32-S3 port (look for Serial Port USB)
for /f "tokens=1" %%a in ('"%ARDUINO_CLI%" board list ^| findstr /i "Serial Port (USB)"') do set PORT=%%a

if "%PORT%"=="" (
    echo Error: ESP32-S3 not found. Please connect the board and try again.
    echo Available ports:
    "%ARDUINO_CLI%" board list
    exit /b 1
)

echo Detected ESP32-S3 on port: %PORT%
"%ARDUINO_CLI%" upload -p "%PORT%" --fqbn esp32:esp32:esp32s3:DebugLevel=debug --verbose BLE_Display.ino
echo BLE Application upload complete!
goto END

:BLE_BUILD_UPLOAD
echo Building and uploading BLE Application (ESP32-S3)...
call "%~f0" BLE_APP
call "%~f0" BLE_UPLOAD
goto END

:ALL
echo Building all projects...
call "%~f0" BMS_APP
call "%~f0" BMS_BOOT
call "%~f0" MCU_APP
call "%~f0" MCU_BOOT
echo All builds complete!
goto END

:HELP
echo Usage: build_commands.bat [PROJECT]
echo Available projects: BMS_APP, BMS_BOOT, MCU_APP, MCU_BOOT, BLE_APP, BLE_UPLOAD, BLE_BUILD_UPLOAD, DBC, ALL
echo.
echo Examples:
echo   build_commands.bat BMS_APP           # Build BMS Application
echo   build_commands.bat MCU_BOOT          # Build MCU Bootloader
echo   build_commands.bat BLE_APP           # Build BLE Application (ESP32-S3)
echo   build_commands.bat BLE_UPLOAD        # Upload BLE Application (auto-detect port)
echo   build_commands.bat BLE_BUILD_UPLOAD  # Build and upload BLE Application
echo   build_commands.bat DBC               # Generate DBC files from JSON
echo   build_commands.bat ALL               # Build all main projects
goto END

:END
