#ifndef BLE_MODULE_H
#define BLE_MODULE_H

#include <NimBLEDevice.h>

// Initialize BLE module
void BLE_Init(void);

// Send UART data over BLE
void BLE_SendUartData(String message);

// Check if device is connected
bool BLE_IsConnected(void);

// Update battery level (0-100%)
void BLE_UpdateBatteryLevel(uint8_t level);

// Get number of bonded devices
int BLE_GetBondedDeviceCount(void);

// Clear all bonded devices
void BLE_ClearAllBonds(void);

// // Print list of bonded devices
// void BLE_PrintBondedDevices(void);

#endif // BLE_MODULE_H
