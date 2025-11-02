#ifndef BLE_MODULE_H
#define BLE_MODULE_H

#include <NimBLEDevice.h>

// Initialize BLE module
void BLE_Init(void);

// Send UART data over BLE (Nordic UART Service)
void BLE_SendUartData(String message);

// Send Begode frame over BLE (HM-10 Service 0xFFE0/0xFFE1)
// Only sends if streaming is active (after 'V' command received)
void BLE_SendBegodeFrame(const uint8_t* frame, uint16_t len);

// Check if device is connected
bool BLE_IsConnected(void);

// Check if Begode streaming is active (after 'V' command)
bool BLE_IsBegodeStreaming(void);

// Get number of bonded devices
int BLE_GetBondedDeviceCount(void);

// Clear all bonded devices
void BLE_ClearAllBonds(void);

// Print list of bonded devices
void BLE_PrintBondedDevices(void);

// Allow new devices to bond (disable whitelist)
void BLE_AllowNewDevices(void);

// Restrict to bonded devices only (enable whitelist)
void BLE_RestrictToBonded(void);

// Manually populate whitelist from bonded devices
void BLE_PopulateWhitelist(void);

#endif // BLE_MODULE_H
