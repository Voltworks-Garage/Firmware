# Bootloader Download Tool
## Requirements:
### 1. Install PCAN USB Drivers: https://www.peak-system.com/PCAN-USB.199.0.html?&L=1
### 2. Install PCAN-ISO-TP API: https://www.peak-system.com/PCAN-ISO-TP-API.369.0.html?&L=1
### 3. Install Java 8 version 221 (might work with later versions but this seems to always work)

## How to use Bootloader Download Tool (BDT):
### 1. Run the jar file UnifiedHost-1.19.0.jar (aka the BDT)
### 2. Select Device Architecture dsPIC33
### 3. Select Protocol CAN

![image](https://github.com/user-attachments/assets/5e6380b8-0a08-481b-a255-ddc0d6f9afe8)

### 4. Select Settings>CAN to configure the CAN dongle, bus speed, and host ID
#### -Bit Rate = 500kbps
#### -Host to device ID will change based on the target. 0xA1 for the BMS. 0xA3 for the MCU, 0xA5 for the DASH.

![image](https://github.com/user-attachments/assets/fc92f499-dde3-48a8-9b23-3b13a8537d5e)

### 5. Select File>Open Hex to select a firmware image. Navigate to the hex (example Firmware\Projects\BMS_App_02.X\dist\DEFAULT\production)
### 6. Once the ECU is powered on and connected, press the READ DEVICE SETTINGS button to trigger a reset and jump to the bootloader.
### 7. You now have 5 seconds to press the PROGRAM DEVICE button.
### 8. It is optional but recommended to check the box to verify the download.

## How to connect to BUSMaster while using the Bootloader Download Tool (BDT)
If you have a PCANView or Busmaster session connected already, the BDT will fail to connect to the bus. The CAN bus MUST be free before starting.
To use both tools at the same time, there is a tricky sequence required.
1. Open the BDT, PCANView, and BUSMaster.
2. Connect with the BDT and begin a download sequence.
3. While the download is happening, connect to the bus with PCANView. It will give a warning to say that settings cannot be changed. This will create a public CAN net that any program can join.
4. You should see CAN traffic on PCANView, and wait for the hex to download completely.
5. Now you should be able to join with BUSMaster by clicking Connect.
6. You can freely disconnect from PCANView (and close it), but do not do not disconnect from BUSMaster for the remainder of the session.
7. Now Busmaster will be showing all CAN traffic in a live view, and the BDT should be able to connect and download as required.



# UnifiedHost	General information
* Unified Bootloader Host Application 
- Used with the MCC Bootloader Generated Software Library for 8-bit or 16-bit MCU devices, or the 32-bit AN1388 bootloader.
- The graphical front-end of the 8-bit, 16-bit and 32-bit Bootloader project.

# Support
Email: MCC_Support@microchip.com
This application requires the Java 1.8 runtime.
For the required Java FX support, and an alternative source to the legacy Java installer can be found here:
Azul Zulu Community OpenJDK with OpenJFX is recommended; OpenJFX is required for use with UBHA.
https://www.azul.com/downloads/zulu-community/?&version=java-8-lts&package=jdk-fx 

Ensure to select the appropriate operating system, and architecture (32/64 bit).
Additional info: https://www.azul.com/products/zulu-enterprise/jdk-comparison-matrix/

Users of Microchip products can receive assistance through several channels:

 - Distributor or Representative
 - Local Sales Office
 - Field Application Engineer (FAE)
 - Technical Support

Customers should contact their distributor, representative or Field Application Engineer (FAE) for support.
Local sales offices are also available to help customers.
A listing of sales offices and locations may be found on the [Microchip web site][3].

Technical support is available through the [Microchip web site][4].

# CHANGELOG	A detailed changelog, intended for programmers
v 0.1.9:	Added readme, added logger, added checksum support to PIC32; added handling for record type 0x05 (currently ignored)
v 0.1.10:	Internal release
v 0.1.11:	Internal release
v 0.1.14:	Added PIC32 CRC bytes used at end of packets. Added Erase feature to USB PIC32 command chain. Extended Timeouts added support for 24-bit packet length.
v 0.1.15:	Fixed bug in PIC16 erase being half expected length during command chain. Added support for larger PIC18 device checksum commands, appending over previous Access Key bytes.
v 1.0.0:	Release version to support PIC24 family of devices. Added beta support for AVR devices.
v 1.15.0:   Release version to support dsPIC33 family of devices. Release support for AVR devices.
v 1.15.1:   Fixed bugs to support PIC-IOT WG Development Board, phantom byte for degenerate blocks and restrict data packet size to MAX_PACKET_SIZE - HEADER_SIZE.
v 1.16.0:   AVR code protocol modified to handle large future devices.
v 1.16.1:   Updated HID4JAVA library used for USB communication. Updates to AVR support to support MCC generated code. Extended PIC32 timeout(s) to 20s (from 8) UDP, USB
v 1.16.2:   32-bit devices no longer wait for responds from Reset Command. Bug fixes for 16-bit support: 1) Self Verify issue with larger parts with 2) no report, 3) End Address corruption on read properties, 4) Exception thrown on UART disconnect.
v 1.16.3:   Corrects an issue with 16-bit devices where flash data was unable to be written if located at the end of the last flash page.
v 1.17.0:   Add CAN and CAN-FD support for PIC24/dsPIC devices.  Expand console logging capability for PIC24/dsPIC devices.
v 1.17.1:   Improved console logging messages. Added provision to package the dependencies as a hotfix.
v 1.18.0:   Add I2C support for PIC24/dsPIC devices. Added support for select PIC18F Q device families (Q40, Q41, Q43, Q83, Q84).
v 1.19.0:   Add LIN support for PIC24/dsPIC devices. Fix issue causing readback errors when only a partial instruction worth of data is specified in the .hex file.

# NEWS	A basic changelog, intended for users
-Incremented version information; see Changelog
-Added readme file on release of version: 0.1.14
-Added Checksum support for PIC32
-Bug fixes, Added Release Notes v 0.1.15 along with readme file. Added support for up to 32-bit checksum value calculation.
-Added Synch Byte expectation to AVR packet support.
-Fixed Typo in Help-->About text which indicated incorrect Utility version
-Added logger support requires launching from command prompt with below text:
* -Djava.util.logging.config.file="C:\<DirectoryLocation>"
- Bugfix for 16-bit flash write.

# Known Issues
- When using a version of java greater than v1.8.0_251, selecting a UART COM port and selecting "Apply" causes the Unified Bootloader Host Application to crash. In order to avoid this please ensure to use
a version of java at or below version 1.8.0_251. 
- The warning 'Application Offset exist between ROWS/PAGE boundaries' might be shown incorrectly, even though the application offset is at the start of a page. Please make sure that the application start adress is at the beginning of a page by referring to the device datasheet.

# Debug Log
The UBHA supports the ability to view Debug Logger message through use of the packaged logging.properties file.
i.e.: To Launch from Command Prompt
>java -Djava.util.logging.config.file="<Drive: e.g. C>:\<MyDirectory>\<UnifiedHost-version>\logging.properties" -jar UnifiedHost-<version>.jar

# INSTALL	Installation instructions
Installation of Java JRE

# COPYING / LICENSE	Copyright and licensing information
See LICENSE.txt for licensing information.
