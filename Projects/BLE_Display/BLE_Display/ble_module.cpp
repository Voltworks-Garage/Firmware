#include "ble_module.h"
#include "esp_log.h"

static const char* TAG = "BLE";

// UART Service (Nordic UART Service)
#define UART_SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define UART_RX_CHAR_UUID           "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"  // Receive (write)
#define UART_TX_CHAR_UUID           "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"  // Transmit (notify)

// Begode/HM-10 Service (for EUC app compatibility)
#define BEGODE_SERVICE_UUID         "FFE0"
#define BEGODE_CHAR_UUID            "FFE1"

// Module-level variables
static NimBLECharacteristic *pUartTxCharacteristic = nullptr;
static NimBLECharacteristic *pBegodeCharacteristic = nullptr;
static bool deviceConnected = false;
static uint16_t currentConnHandle = 0;
static bool whitelistEnabled = false;  // Track whitelist state
static bool begodeStreaming = false;   // Track if Begode streaming is active

//Helpers
static bool isConnectionEncrypted(void);
static void populateWhitelistFromBonds(void);

// Connection callbacks
class MyServerCallbacks: public NimBLEServerCallbacks {
  void onConnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo) {
    deviceConnected = true;
    currentConnHandle = connInfo.getConnHandle();
    ESP_LOGI(TAG, "Device connected (handle: %d)", currentConnHandle);
    ESP_LOGI(TAG, "Connected to address: %s", connInfo.getAddress().toString().c_str());
  }

  void onMTUChange(uint16_t MTU, NimBLEConnInfo& connInfo) {
    ESP_LOGI(TAG, "MTU updated to: %d bytes", MTU);
  }

  void onDisconnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo, int reason) {
    deviceConnected = false;
    currentConnHandle = 0;
    begodeStreaming = false;  // Reset streaming on disconnect
    ESP_LOGI(TAG, "Device disconnected (reason: %d)", reason);

    // Use the last whitelist setting instead of auto-enabling
    NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();

    if (whitelistEnabled) {
      // Repopulate whitelist (addresses may have been lost)
      populateWhitelistFromBonds();
      pAdvertising->setScanFilter(false, true);  // Only bonded devices can connect
      ESP_LOGI(TAG, "Advertising to bonded devices only (whitelist mode)");
    } else {
      pAdvertising->setScanFilter(false, false);  // All devices can connect
      ESP_LOGI(TAG, "Advertising to all devices (open mode)");
    }

    NimBLEDevice::startAdvertising();  // Restart advertising
  }

  void onAuthenticationComplete(NimBLEConnInfo& connInfo) {
    if (connInfo.isEncrypted()) {
      ESP_LOGI(TAG, "Device paired and bonded successfully!");
      ESP_LOGI(TAG, "Bonded to: %s", connInfo.getAddress().toString().c_str());
    } else {
      ESP_LOGW(TAG, "Pairing failed or was cancelled");
    }
  }

  uint32_t onPassKeyRequest() {
    ESP_LOGI(TAG, "PassKey Request (SHOULD NOT BE CALLED WITH DISPLAY_YESNO) - returning 123456");
    return 123456;
  }

  void onConfirmPIN(NimBLEConnInfo& connInfo, uint32_t pass_key) {
    ESP_LOGI(TAG, "========================================");
    ESP_LOGI(TAG, "PAIRING CODE: %06d", pass_key);
    ESP_LOGI(TAG, "Confirm this code on your phone");
    ESP_LOGI(TAG, "========================================");
    // Auto-confirm on ESP32 side
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


// Begode RX callback (receive commands from EUC apps)
class BegodeCallbacks: public NimBLECharacteristicCallbacks {
  void onWrite(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo& connInfo) {
    std::string rxValue = pCharacteristic->getValue();

    if (rxValue.length() > 0) {
      ESP_LOGI(TAG, "[Begode] RX: ");
      for (size_t i = 0; i < rxValue.length(); i++) {
        ESP_LOGI(TAG, "0x%02X ", (uint8_t)rxValue[i]);
      }

      // Handle single-byte commands
      if (rxValue.length() == 1) {
        uint8_t cmd = rxValue[0];
        if (cmd == 'V' || cmd == 'v') {
          ESP_LOGI(TAG, "[Begode] Start streaming command received");
          begodeStreaming = true;

          // Send initial response sequence like nRF52840 code
          // 1. Send immediate data frame (will be sent by user code loop)
          const uint8_t frame[24] = {};
          pCharacteristic->setValue(frame, 12);
          pCharacteristic->notify();

          pCharacteristic->setValue(frame, 12);
          pCharacteristic->notify();
          
          // 2. Send firmware string
          const char* fw = "GW2002001";
          pCharacteristic->setValue((uint8_t*)fw, strlen(fw));
          pCharacteristic->notify();

          // 3. Echo 'V'
          uint8_t ack = 'V';
          pCharacteristic->setValue(&ack, 1);
          pCharacteristic->notify();

        } else if (cmd == 'N' || cmd == 'n') {
          ESP_LOGI(TAG, "[Begode] Name request received");
          const char* name = "ESP32-S3 (Begode)\r\n";
          pCharacteristic->setValue((uint8_t*)name, strlen(name));
          pCharacteristic->notify();
        }
      }
    }
  }

  void onSubscribe(NimBLECharacteristic* pCharacteristic, NimBLEConnInfo& connInfo, uint16_t subValue) {
    if (subValue == 0) {
      ESP_LOGI(TAG, "[Begode] Client UNSUBSCRIBED from notifications");
    } else if (subValue == 1) {
      ESP_LOGI(TAG, "[Begode] Client SUBSCRIBED to notifications");
    } else if (subValue == 2) {
      ESP_LOGI(TAG, "[Begode] Client SUBSCRIBED to indications");
    } else if (subValue == 3) {
      ESP_LOGI(TAG, "[Begode] Client SUBSCRIBED to notifications AND indications");
    }
  }
};

void BLE_Init(void) {
  ESP_LOGI(TAG, "Starting setup...");

  // Initialize BLE
  NimBLEDevice::init("ESP32-S3 (Begode)");

  // Set MTU to support 24-byte Begode frames (need at least 27 bytes: 24 data + 3 overhead)
  NimBLEDevice::setMTU(256);
  ESP_LOGI(TAG, "MTU set to 256 bytes");

  // Configure security for bonding with numeric comparison
  // DISABLED FOR HM-10 COMPATIBILITY - DarknessBot expects open connection
  // NimBLEDevice::setSecurityAuth(true, true, true);  // bonding=true, MITM=true, secure connections=true
  // NimBLEDevice::setSecurityIOCap(BLE_HS_IO_DISPLAY_YESNO);  // Display passkey, user confirms yes/no on both devices
  // NimBLEDevice::setSecurityInitKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);
  // NimBLEDevice::setSecurityRespKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);

  // ESP_LOGI(TAG, "Security enabled - numeric comparison mode (display passkey + confirm)");

  // Create BLE Server
  NimBLEServer *pServer = NimBLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // ===== Device Information Service =====
  NimBLEService *pDevInfoService = pServer->createService("180A");  // Device Information Service

  NimBLECharacteristic *pManufacturerChar = pDevInfoService->createCharacteristic(
    "2A29",  // Manufacturer Name String
    NIMBLE_PROPERTY::READ
  );
  pManufacturerChar->setValue("Begode");

  NimBLECharacteristic *pModelChar = pDevInfoService->createCharacteristic(
    "2A24",  // Model Number String
    NIMBLE_PROPERTY::READ
  );
  pModelChar->setValue("X-Way");

  pDevInfoService->start();
  ESP_LOGI(TAG, "Device Information Service created");

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
  

  // ===== Begode/HM-10 Service =====
  NimBLEService *pBegodeService = pServer->createService(BEGODE_SERVICE_UUID);

  // Begode characteristic (RW/Notify like HM-10 - no encryption required)
  pBegodeCharacteristic = pBegodeService->createCharacteristic(
    BEGODE_CHAR_UUID,
    NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::WRITE_NR | NIMBLE_PROPERTY::NOTIFY | NIMBLE_PROPERTY::INDICATE
  );
  pBegodeCharacteristic->setCallbacks(new BegodeCallbacks());

  pBegodeService->start();

  ESP_LOGI(TAG, "Begode/HM-10 service (0xFFE0) created");

  // ===== Start Advertising =====
  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  // Only advertise Begode service - UART service available via service discovery
  pAdvertising->addServiceUUID(BEGODE_SERVICE_UUID);
  pAdvertising->setName("ESP32-S3 (Begode)");  // Shortened name to fit in advertising packet

  // If we have bonded devices, enable whitelist for auto-reconnect
  // int bondCount = NimBLEDevice::getNumBonds();
  // if (bondCount > 0) {
  //   ESP_LOGI(TAG, "Found %d bonded device(s)", bondCount);

  //   // Populate whitelist with bonded device addresses
  //   populateWhitelistFromBonds();

  //   // Enable whitelist filtering for connections
  //   pAdvertising->setScanFilter(false, true);  // scanRequestWhitelistOnly=false, connectWhitelistOnly=true
  //   whitelistEnabled = true;
  //   ESP_LOGI(TAG, "Whitelist enabled - only bonded devices can connect");
  // } else {
  //   ESP_LOGI(TAG, "No bonded devices - advertising to all");
  //   pAdvertising->setScanFilter(false, false);  // No whitelist filtering
  //   whitelistEnabled = false;
  // }

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

void BLE_SendBegodeFrame(const uint8_t* frame, uint16_t len) {
  if (deviceConnected && pBegodeCharacteristic != nullptr && begodeStreaming) {
    pBegodeCharacteristic->setValue(frame, len/2);
    pBegodeCharacteristic->notify();
    pBegodeCharacteristic->setValue(frame + len/2, len/2);
    bool result = pBegodeCharacteristic->notify();
    ESP_LOGI(TAG, "[Begode] Sent frame (%d bytes) - notify returned: %d", len, result);
  }
}

bool BLE_IsConnected(void) {
  return deviceConnected;
}

bool BLE_IsBegodeStreaming(void) {
  return begodeStreaming;
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

static void populateWhitelistFromBonds(void) {
  int bondCount = NimBLEDevice::getNumBonds();

  if (bondCount == 0) {
    ESP_LOGD(TAG, "No bonded devices to add to whitelist");
    return;
  }

  ESP_LOGI(TAG, "Populating whitelist with %d bonded device(s)", bondCount);

  for (int i = 0; i < bondCount; i++) {
    NimBLEAddress bondedAddr = NimBLEDevice::getBondedAddress(i);

    if (NimBLEDevice::whiteListAdd(bondedAddr)) {
      ESP_LOGI(TAG, "  Added to whitelist: %s", bondedAddr.toString().c_str());
    } else {
      ESP_LOGW(TAG, "  Failed to add to whitelist: %s", bondedAddr.toString().c_str());
    }
  }
}

static bool isConnectionEncrypted(void) {
  if (!deviceConnected || currentConnHandle == 0) {
    return false;
  }

  NimBLEServer* pServer = NimBLEDevice::getServer();
  if (pServer != nullptr) {
    // Use the stored connection handle instead of getPeerDevices
    NimBLEConnInfo connInfo = pServer->getPeerInfoByHandle(currentConnHandle);

    bool bonded = connInfo.isBonded();
    bool encrypted = connInfo.isEncrypted();
    bool authenticated = connInfo.isAuthenticated();

    ESP_LOGD(TAG, "Security state (handle %d) - Bonded: %s, Encrypted: %s, Authenticated: %s",
             currentConnHandle,
             bonded ? "YES" : "NO",
             encrypted ? "YES" : "NO",
             authenticated ? "YES" : "NO");

    // Return true only if encrypted
    return encrypted;
  }

  ESP_LOGD(TAG, "Connection encrypted check failed - no server");
  return false;
}


void BLE_PrintBondedDevices(void) {
  int bondCount = NimBLEDevice::getNumBonds();
  ESP_LOGI(TAG, "Number of bonded devices: %d", bondCount);

  if (bondCount > 0) {
    ESP_LOGI(TAG, "Bonded device addresses:");
    for (int i = 0; i < bondCount; i++) {
      NimBLEAddress bondedAddr = NimBLEDevice::getBondedAddress(i);
      ESP_LOGI(TAG, "  %d: %s", i + 1, bondedAddr.toString().c_str());
    }
  } else {
    ESP_LOGI(TAG, "No bonded devices");
  }
}

void BLE_AllowNewDevices(void) {
  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  pAdvertising->stop();
  pAdvertising->setScanFilter(false, false);  // Disable whitelist
  whitelistEnabled = false;  // Update flag
  pAdvertising->start();
  ESP_LOGI(TAG, "Whitelist disabled - accepting all devices");
}

void BLE_RestrictToBonded(void) {
  int bondCount = NimBLEDevice::getNumBonds();
  if (bondCount == 0) {
    ESP_LOGW(TAG, "No bonded devices - cannot enable whitelist");
    return;
  }

  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  pAdvertising->stop();

  // Populate whitelist before enabling
  populateWhitelistFromBonds();

  pAdvertising->setScanFilter(false, true);  // Enable connect whitelist
  whitelistEnabled = true;  // Update flag
  pAdvertising->start();
  ESP_LOGI(TAG, "Whitelist enabled - only bonded devices can connect");
}

void BLE_PopulateWhitelist(void) {
  populateWhitelistFromBonds();
}
