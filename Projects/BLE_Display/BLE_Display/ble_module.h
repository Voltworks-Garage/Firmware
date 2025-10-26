#ifndef BLE_MODULE_H
#define BLE_MODULE_H

#include <Arduino.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLE2902.h>

// Initialize BLE module
void BLE_Init(void);

// Send UART data over BLE
void BLE_SendUartData(String message);

// Check if device is connected
bool BLE_IsConnected(void);

// Update battery level (0-100%)
void BLE_UpdateBatteryLevel(uint8_t level);

#endif // BLE_MODULE_H
