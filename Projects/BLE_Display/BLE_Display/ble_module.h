#ifndef BLE_MODULE_H
#define BLE_MODULE_H

#include <NimBLEDevice.h>

// Initialize BLE module
void BLE_Init(void);

// Send UART data over BLE (Nordic UART Service)
void BLE_SendUartData(String message);

// Register a callback function to be called when UART data is received
// Callback receives pointer to data and length
// User can copy/queue the data in their callback as needed
void BLE_SetUartCallback(void (*callback)(const uint8_t* data, uint16_t len));

// Send data over BLE (HM-10 Service 0xFFE0/0xFFE1)
// Only sends if streaming is active (after 'V' command received)
void BLE_SendHM10Data(const uint8_t* data, uint16_t len);

// Register a callback function to be called when HM-10 data is received
// Callback receives pointer to data and length
// User can copy/queue the data in their callback as needed
void BLE_SetHM10Callback(void (*callback)(const uint8_t* data, uint16_t len));

// Check if device is connected
bool BLE_IsConnected(void);

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
