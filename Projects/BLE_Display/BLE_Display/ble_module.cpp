#include "ble_module.h"
#include "esp_log.h"

static const char* TAG = "BLE";

// Battery Service (Standard)
#define BATTERY_SERVICE_UUID        "180F"
#define BATTERY_LEVEL_CHAR_UUID     "2A19"

// UART Service (Nordic UART Service)
#define UART_SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define UART_RX_CHAR_UUID           "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"  // Receive (write)
#define UART_TX_CHAR_UUID           "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"  // Transmit (notify)

// Module-level variables
static NimBLECharacteristic *pBatteryCharacteristic = nullptr;
static NimBLECharacteristic *pUartTxCharacteristic = nullptr;
static bool deviceConnected = false;

//Helpers
static bool isConnectionEncrypted(void);

// Connection callbacks
class MyServerCallbacks: public NimBLEServerCallbacks {
  void onConnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo) {
    deviceConnected = true;
    ESP_LOGI(TAG, "Device connected");
    ESP_LOGI(TAG, "Connected to address: %s", connInfo.getAddress().toString().c_str());
  }

  void onDisconnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo, int reason) {
    deviceConnected = false;
    ESP_LOGI(TAG, "Device disconnected (reason: %d)", reason);
    NimBLEDevice::startAdvertising();  // Restart advertising
  }

  void onAuthenticationComplete(NimBLEConnInfo& connInfo) {
    if (connInfo.isEncrypted()) {
      ESP_LOGI(TAG, "Device paired and bonded successfully!");
      ESP_LOGI(TAG, "Bonded to: %s", connInfo.getAddress().toString().c_str());
    } else {
      ESP_LOGW(TAG, "Encryption failed - not bonded");

      // If this device was previously bonded but encryption failed, remove the stale bond
      if (NimBLEDevice::isBonded(connInfo.getAddress())) {
        ESP_LOGW(TAG, "Removing stale bond for: %s", connInfo.getAddress().toString().c_str());
        NimBLEDevice::deleteBond(connInfo.getAddress());
      }
    }
  }

  uint32_t onPassKeyRequest() {
    ESP_LOGI(TAG, "PassKey Request - using static key: 123456");
    return 123456;
  }

  void onConfirmPIN(NimBLEConnInfo& connInfo, uint32_t pass_key) {
    ESP_LOGI(TAG, "Confirm passkey: %06d", pass_key);
    // Auto-confirm for now - you could add button press logic here
    NimBLEDevice::injectConfirmPasskey(connInfo, true);
  }
};

// UART RX callback (receive data from phone)
class UartCallbacks: public NimBLECharacteristicCallbacks {
  void onWrite(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo& connInfo) {
    String rxValue = pCharacteristic->getValue().c_str();

    if (rxValue.length() > 0) {
      ESP_LOGI(TAG, "Received: %s", rxValue.c_str());

      // Echo back (optional)
      BLE_SendUartData("Echo: " + String(rxValue.c_str()));
    }
  }
};

void BLE_Init(void) {
  ESP_LOGI(TAG, "Starting setup...");

  // Initialize BLE
  NimBLEDevice::init("ESP32-S3");

  // Configure security for bonding
  NimBLEDevice::setSecurityAuth(true, true, true);  // bonding, MITM, secure connections
  NimBLEDevice::setSecurityIOCap(BLE_HS_IO_DISPLAY_YESNO);  // Display with yes/no capability
  NimBLEDevice::setSecurityInitKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);
  NimBLEDevice::setSecurityRespKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);

  ESP_LOGI(TAG, "Security enabled - bonding supported");

  // Create BLE Server
  NimBLEServer *pServer = NimBLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // ===== Battery Service =====
  NimBLEService *pBatteryService = pServer->createService(BATTERY_SERVICE_UUID);

  pBatteryCharacteristic = pBatteryService->createCharacteristic(
    BATTERY_LEVEL_CHAR_UUID,
    NIMBLE_PROPERTY::READ_ENC | NIMBLE_PROPERTY::NOTIFY
  );

  // Set initial battery level
  uint8_t batteryLevel = 100;
  pBatteryCharacteristic->setValue(&batteryLevel, 1);

  pBatteryService->start();

  // ===== UART Service =====
  NimBLEService *pUartService = pServer->createService(UART_SERVICE_UUID);

  // TX Characteristic (ESP32 transmits to phone) - requires encryption
  pUartTxCharacteristic = pUartService->createCharacteristic(
    UART_TX_CHAR_UUID,
    NIMBLE_PROPERTY::NOTIFY | NIMBLE_PROPERTY::READ_ENC
  );

  // RX Characteristic (ESP32 receives from phone) - requires encryption
  NimBLECharacteristic *pUartRxCharacteristic = pUartService->createCharacteristic(
    UART_RX_CHAR_UUID,
    NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::WRITE_ENC
  );
  pUartRxCharacteristic->setCallbacks(new UartCallbacks());

  pUartService->start();

  // ===== Start Advertising =====
  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(UART_SERVICE_UUID);
  pAdvertising->setName("ESP32-S3");
  pAdvertising->start();

  ESP_LOGI(TAG, "Device advertising. Ready to connect!");
}

void BLE_SendUartData(String message) {
  if (deviceConnected && pUartTxCharacteristic != nullptr && isConnectionEncrypted()) {
    pUartTxCharacteristic->setValue(message.c_str());
    pUartTxCharacteristic->notify();
    ESP_LOGI(TAG, "Sent: %s", message.c_str());
  }
}

bool BLE_IsConnected(void) {
  return deviceConnected;
}
void BLE_UpdateBatteryLevel(uint8_t level) {
  if (pBatteryCharacteristic != nullptr) {
    if (level > 100) level = 100;
    pBatteryCharacteristic->setValue(&level, 1);
    if (deviceConnected && isConnectionEncrypted()) {
      pBatteryCharacteristic->notify();
    }
  }
}

int BLE_GetBondedDeviceCount(void) {
  return NimBLEDevice::getNumBonds();
}

void BLE_ClearAllBonds(void) {
  int bondCount = NimBLEDevice::getNumBonds();
  ESP_LOGI(TAG, "Clearing %d bonded device(s)...", bondCount);
  NimBLEDevice::deleteAllBonds();
  ESP_LOGI(TAG, "All bonds cleared!");
}

static bool isConnectionEncrypted(void) {
  NimBLEServer* pServer = NimBLEDevice::getServer();
  if (pServer != nullptr) {
    std::vector<uint16_t> connIds = pServer->getPeerDevices();
    if (!connIds.empty()) {
      NimBLEConnInfo connInfo = pServer->getPeerInfo(connIds[0]);
      return connInfo.isEncrypted();
    }
  }
  return false;
}


// void BLE_PrintBondedDevices(void) {
//   int bondCount = NimBLEDevice::getNumBonds();
//   Serial.printf("BLE: Number of bonded devices: %d\n", bondCount);

//   if (bondCount > 0) {
//     Serial.println("BLE: Bonded device addresses:");
//     for (int i = 0; i < bondCount; i++) {
//       NimBLEAddress bondedAddr = NimBLEDevice::getBondedAddress(i);
//       Serial.printf("  %d: %s\n", i + 1, bondedAddr.toString().c_str());
//     }
//   } else {
//     Serial.println("BLE: No bonded devices");
//   }
// }
