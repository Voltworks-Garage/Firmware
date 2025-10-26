#include "ble_module.h"

// Battery Service (Standard)
#define BATTERY_SERVICE_UUID        0x180F
#define BATTERY_LEVEL_CHAR_UUID     0x2A19

// UART Service (Nordic UART Service)
#define UART_SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define UART_RX_CHAR_UUID           "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"  // Receive (write)
#define UART_TX_CHAR_UUID           "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"  // Transmit (notify)

// Module-level variables
static BLECharacteristic *pBatteryCharacteristic = nullptr;
static BLECharacteristic *pUartTxCharacteristic = nullptr;
static bool deviceConnected = false;

// Connection callbacks
class MyServerCallbacks: public BLEServerCallbacks {
  void onConnect(BLEServer* pServer) {
    deviceConnected = true;
    Serial.println("BLE: Device connected");
  }

  void onDisconnect(BLEServer* pServer) {
    deviceConnected = false;
    Serial.println("BLE: Device disconnected");
    BLEDevice::startAdvertising();  // Restart advertising
  }
};

// UART RX callback (receive data from phone)
class UartCallbacks: public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {
    String rxValue = pCharacteristic->getValue();

    if (rxValue.length() > 0) {
      Serial.print("BLE: Received: ");
      Serial.println(rxValue.c_str());

      // Echo back (optional)
      BLE_SendUartData("Echo: " + String(rxValue.c_str()));
    }
  }
};

void BLE_Init(void) {
  Serial.println("BLE: Starting setup...");

  // Initialize BLE
  BLEDevice::init("ESP32-S3");

  // Create BLE Server
  BLEServer *pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // ===== Battery Service =====
  BLEService *pBatteryService = pServer->createService(BLEUUID((uint16_t)BATTERY_SERVICE_UUID));

  pBatteryCharacteristic = pBatteryService->createCharacteristic(
    BLEUUID((uint16_t)BATTERY_LEVEL_CHAR_UUID),
    BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY
  );
  pBatteryCharacteristic->addDescriptor(new BLE2902());

  // Set initial battery level
  uint8_t batteryLevel = 100;
  pBatteryCharacteristic->setValue(&batteryLevel, 1);

  pBatteryService->start();

  // ===== UART Service =====
  BLEService *pUartService = pServer->createService(UART_SERVICE_UUID);

  // TX Characteristic (ESP32 transmits to phone)
  pUartTxCharacteristic = pUartService->createCharacteristic(
    UART_TX_CHAR_UUID,
    BLECharacteristic::PROPERTY_NOTIFY
  );
  pUartTxCharacteristic->addDescriptor(new BLE2902());

  // RX Characteristic (ESP32 receives from phone)
  BLECharacteristic *pUartRxCharacteristic = pUartService->createCharacteristic(
    UART_RX_CHAR_UUID,
    BLECharacteristic::PROPERTY_WRITE
  );
  pUartRxCharacteristic->setCallbacks(new UartCallbacks());

  pUartService->start();

  // ===== Start Advertising =====
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(BLEUUID((uint16_t)BATTERY_SERVICE_UUID));
  pAdvertising->addServiceUUID(UART_SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);  // Fast connection
  pAdvertising->setMaxPreferred(0x12);

  BLEDevice::startAdvertising();
  Serial.println("BLE: Device advertising. Ready to connect!");
}

void BLE_SendUartData(String message) {
  if (deviceConnected && pUartTxCharacteristic != nullptr) {
    pUartTxCharacteristic->setValue(message.c_str());
    pUartTxCharacteristic->notify();
    Serial.println("BLE: Sent: " + message);
  }
}

bool BLE_IsConnected(void) {
  return deviceConnected;
}

void BLE_UpdateBatteryLevel(uint8_t level) {
  if (pBatteryCharacteristic != nullptr) {
    if (level > 100) level = 100;
    pBatteryCharacteristic->setValue(&level, 1);
    pBatteryCharacteristic->notify();
  }
}
