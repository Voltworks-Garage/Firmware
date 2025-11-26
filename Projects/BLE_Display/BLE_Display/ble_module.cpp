#include "ble_module.h"

#include "src/msg/messaging.h"
#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/semphr.h"

#define LOG_LOCAL_LEVEL ESP_LOG_DEBUG
#include "esp_log.h"

static const char* TAG = "BLE";

// UART Service (Nordic UART Service)
#define UART_SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define UART_RX_CHAR_UUID           "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"  // Receive (write)
#define UART_TX_CHAR_UUID           "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"  // Transmit (notify)

// HM-10 Service (for EUC app compatibility)
#define HM10_SERVICE_UUID           "FFE0"
#define HM10_CHAR_UUID              "FFE1"

// UART TX Queue configuration
#define UART_TX_QUEUE_SIZE          10
#define UART_TX_MAX_MESSAGE_LEN     512

// UART TX message structure
typedef struct {
  char message[UART_TX_MAX_MESSAGE_LEN];  // Storage for the message
  const char* data_pointer;                // Pointer to current position
  uint16_t length;                         // Remaining bytes to send
} UartTxMessage_t;

// Module-level variables
static NimBLECharacteristic *pUartTxCharacteristic = nullptr;
static NimBLECharacteristic *pHM10Characteristic = nullptr;
static bool deviceConnected = false;
static uint16_t currentConnHandle = 0;
static bool whitelistEnabled = false;  // Track whitelist state
static void (*uartCallback)(const uint8_t* data, uint16_t len) = nullptr;  // Callback when UART data received
static void (*hm10Callback)(const uint8_t* data, uint16_t len) = nullptr;  // Callback when HM-10 data received
static uint16_t mtuSize = 23;  // Default MTU size before negotiation

// UART TX Queue variables
static QueueHandle_t uartTxQueue = nullptr;
static UartTxMessage_t currentTxMessage;
static SemaphoreHandle_t txSemaphore = nullptr;

//Helpers
static bool isConnectionEncrypted(void);
static void populateWhitelistFromBonds(void);
static void ble_sendUartPacket(void);

// Connection callbacks
class MyServerCallbacks: public NimBLEServerCallbacks {
  void onConnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo) {
    deviceConnected = true;
    currentConnHandle = connInfo.getConnHandle();
    mtuSize = connInfo.getMTU();
    ESP_LOGI(TAG, "Device connected (handle: %d)", currentConnHandle);
    ESP_LOGI(TAG, "Connected to address: %s", connInfo.getAddress().toString().c_str());
    ESP_LOGI(TAG, "Current MTU: %d bytes", mtuSize);

    xQueueReset(uartTxQueue);  // Clear TX queue on connect
    // Take semaphore if available, then give it back to reset state
    xSemaphoreTake(txSemaphore, 0);
    xSemaphoreGive(txSemaphore);  // Ensure semaphore is available

    // Try to initiate MTU exchange from server side
    // This requests the client to increase MTU to support 24-byte frames
    // int rc = ble_gattc_exchange_mtu(connInfo.getConnHandle(), NULL, NULL);
    // if (rc == 0) {
    //   ESP_LOGI(TAG, "MTU exchange initiated from server");
    // } else {
    //   ESP_LOGW(TAG, "MTU exchange failed: %d", rc);
    // }
    const Message_t connect_message = {
      .source = MODULE_BLE,
      .destination = MODULE_UI,   // MODULE_BROADCAST for pub-sub
      .payload = {BLE_CONNECTION, 1},
    };
    MsgBus_Send(&connect_message);
  }

  void onMTUChange(uint16_t MTU, NimBLEConnInfo& connInfo) {
    mtuSize = MTU;
    ESP_LOGI(TAG, "MTU updated to: %d bytes", MTU);
  }

  void onDisconnect(NimBLEServer* pServer, NimBLEConnInfo& connInfo, int reason) {
    deviceConnected = false;
    currentConnHandle = 0;
    xQueueReset(uartTxQueue);  // Clear TX queue on disconnect
    xSemaphoreGive(txSemaphore);  // Release semaphore in case waiting
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

    const Message_t connect_message = {
      .source = MODULE_BLE,
      .destination = MODULE_UI,   // MODULE_BROADCAST for pub-sub
      .payload = {BLE_CONNECTION, 0},
    };
    MsgBus_Send(&connect_message);
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

// UART TX callback (for tracking notification sent status)
class UartTxCallbacks: public NimBLECharacteristicCallbacks {
  void onStatus(NimBLECharacteristic* pCharacteristic, int code) {
    // Code 0 = success for notifications
    if (code == 0) {
      ESP_LOGD(TAG, "[UART TX] Notification sent successfully");
      // Give semaphore to signal we can send the next chunk
      ble_sendUartPacket();
    } else {
      ESP_LOGW(TAG, "[UART TX] Notification failed: %d (%s)",
               code, NimBLEUtils::returnCodeToString(code));
      // Still give semaphore to avoid getting stuck
      if (txSemaphore != nullptr) {
        xSemaphoreGiveFromISR(txSemaphore, NULL);
      }
    }
  }
};

// UART RX callback (receive data from phone)
class UartRxCallbacks: public NimBLECharacteristicCallbacks {
  void onWrite(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo& connInfo) {
    std::string rxValue = pCharacteristic->getValue();

    if (rxValue.length() > 0) {
      ESP_LOGI(TAG, "[UART] RX %d bytes", rxValue.length());

      // Call user callback if registered - they can queue/process the data as needed
      if (uartCallback != nullptr) {
        uartCallback((const uint8_t*)rxValue.data(), rxValue.length());
      }
    }
  }
};


// HM-10 RX callback (receive commands from EUC apps)
class HM10Callbacks: public NimBLECharacteristicCallbacks {
  void onWrite(NimBLECharacteristic *pCharacteristic, NimBLEConnInfo& connInfo) {
    std::string rxValue = pCharacteristic->getValue();

    if (rxValue.length() > 0) {
      ESP_LOGI(TAG, "[HM10] RX: ");
      for (size_t i = 0; i < rxValue.length(); i++) {
        ESP_LOGI(TAG, "0x%02X ", (uint8_t)rxValue[i]);
      }

      // Call user callback if registered - they can queue/process the data as needed
      if (hm10Callback != nullptr) {
        hm10Callback((const uint8_t*)rxValue.data(), rxValue.length());
      }
    }
  }

  void onSubscribe(NimBLECharacteristic* pCharacteristic, NimBLEConnInfo& connInfo, uint16_t subValue) {
    if (subValue == 0) {
      ESP_LOGI(TAG, "[HM10] Client UNSUBSCRIBED from notifications");
    } else if (subValue == 1) {
      ESP_LOGI(TAG, "[HM10] Client SUBSCRIBED to notifications");
    } else if (subValue == 2) {
      ESP_LOGI(TAG, "[HM10] Client SUBSCRIBED to indications");
    } else if (subValue == 3) {
      ESP_LOGI(TAG, "[HM10] Client SUBSCRIBED to notifications AND indications");
    }
  }
};

void BLE_Init(void) {
  esp_log_level_set(TAG, ESP_LOG_INFO);
  ESP_LOGI(TAG, "Starting setup...");

  // Initialize BLE
  NimBLEDevice::init("ESP32-S3(Begode)");  // Device name (pretend to be KingSong 18L)

  // Set MTU to support 24-byte frames (need at least 27 bytes: 24 data + 3 overhead)
  NimBLEDevice::setMTU(256);
  ESP_LOGI(TAG, "MTU set to 256 bytes");

  // Configure security for bonding with numeric comparison
  // HM-10 service remains open (no _ENC flags), UART service requires encryption
  NimBLEDevice::setSecurityAuth(true, true, true);  // bonding=true, MITM=true, secure connections=true
  NimBLEDevice::setSecurityIOCap(BLE_HS_IO_DISPLAY_YESNO);  // Display passkey, user confirms yes/no on both devices
  NimBLEDevice::setSecurityInitKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);
  NimBLEDevice::setSecurityRespKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);

  ESP_LOGI(TAG, "Security enabled - numeric comparison mode (display passkey + confirm)");

  // Create BLE Server
  NimBLEServer *pServer = NimBLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // ===== GAP Service (0x1800) - REQUIRED FOR KINGSONG DETECTION =====
  NimBLEService *pGapService = pServer->createService("1800");

  NimBLECharacteristic *pDeviceNameChar = pGapService->createCharacteristic(
    "2A00",  // Device Name
    NIMBLE_PROPERTY::READ
  );
  pDeviceNameChar->setValue("ESP32-S3(Begode)");

  NimBLECharacteristic *pAppearanceChar = pGapService->createCharacteristic(
    "2A01",  // Appearance
    NIMBLE_PROPERTY::READ
  );
  uint16_t appearance = 0x0000;  // Unknown appearance
  pAppearanceChar->setValue((uint8_t*)&appearance, 2);

  NimBLECharacteristic *pPeriphPrivacyChar = pGapService->createCharacteristic(
    "2A02",  // Peripheral Privacy Flag
    NIMBLE_PROPERTY::READ
  );
  uint8_t privacyFlag = 0x00;
  pPeriphPrivacyChar->setValue(&privacyFlag, 1);

  NimBLECharacteristic *pReconnAddrChar = pGapService->createCharacteristic(
    "2A03",  // Reconnection Address
    NIMBLE_PROPERTY::WRITE
  );

  NimBLECharacteristic *pConnParamsChar = pGapService->createCharacteristic(
    "2A04",  // Peripheral Preferred Connection Parameters
    NIMBLE_PROPERTY::READ
  );

  pGapService->start();
  ESP_LOGI(TAG, "GAP Service (0x1800) created");

  // ===== GATT Service (0x1801) - REQUIRED FOR KINGSONG DETECTION =====
  NimBLEService *pGattService = pServer->createService("1801");

  NimBLECharacteristic *pServiceChangedChar = pGattService->createCharacteristic(
    "2A05",  // Service Changed
    NIMBLE_PROPERTY::INDICATE
  );

  pGattService->start();
  ESP_LOGI(TAG, "GATT Service (0x1801) created");

  // ===== Device Information Service (0x180A) - REQUIRED FOR KINGSONG DETECTION =====
  NimBLEService *pDevInfoService = pServer->createService("180A");

  // Add all the characteristics that KingSong wheels typically have
  NimBLECharacteristic *pSystemIdChar = pDevInfoService->createCharacteristic(
    "2A23",  // System ID
    NIMBLE_PROPERTY::READ
  );

  NimBLECharacteristic *pModelChar = pDevInfoService->createCharacteristic(
    "2A24",  // Model Number String
    NIMBLE_PROPERTY::READ
  );
  pModelChar->setValue("ESP32-S3(Begode)");

  NimBLECharacteristic *pSerialChar = pDevInfoService->createCharacteristic(
    "2A25",  // Serial Number String
    NIMBLE_PROPERTY::READ
  );
  pSerialChar->setValue("KS123456789");

  NimBLECharacteristic *pFirmwareChar = pDevInfoService->createCharacteristic(
    "2A26",  // Firmware Revision String
    NIMBLE_PROPERTY::READ
  );
  pFirmwareChar->setValue("2.15");

  NimBLECharacteristic *pHardwareChar = pDevInfoService->createCharacteristic(
    "2A27",  // Hardware Revision String
    NIMBLE_PROPERTY::READ
  );
  pHardwareChar->setValue("1.0");

  NimBLECharacteristic *pSoftwareChar = pDevInfoService->createCharacteristic(
    "2A28",  // Software Revision String
    NIMBLE_PROPERTY::READ
  );
  pSoftwareChar->setValue("2.15");

  NimBLECharacteristic *pManufacturerChar = pDevInfoService->createCharacteristic(
    "2A29",  // Manufacturer Name String
    NIMBLE_PROPERTY::READ
  );
  pManufacturerChar->setValue("King Song");

  NimBLECharacteristic *pRegCertChar = pDevInfoService->createCharacteristic(
    "2A2A",  // IEEE 11073-20601 Regulatory Certification Data List
    NIMBLE_PROPERTY::READ
  );

  NimBLECharacteristic *pPnpIdChar = pDevInfoService->createCharacteristic(
    "2A50",  // PnP ID
    NIMBLE_PROPERTY::READ
  );

  pDevInfoService->start();
  ESP_LOGI(TAG, "Device Information Service (0x180A) created");

  // ===== UART Service =====
  uartTxQueue = xQueueCreate(UART_TX_QUEUE_SIZE, sizeof(UartTxMessage_t));
  txSemaphore = xSemaphoreCreateBinary();
  xSemaphoreGive(txSemaphore);  // Initialize semaphore as available
  NimBLEService *pUartService = pServer->createService(UART_SERVICE_UUID);

  // TX Characteristic (ESP32 transmits to phone) - requires encryption
  pUartTxCharacteristic = pUartService->createCharacteristic(
    UART_TX_CHAR_UUID,
    NIMBLE_PROPERTY::NOTIFY | NIMBLE_PROPERTY::READ_ENC
  );
  pUartTxCharacteristic->setCallbacks(new UartTxCallbacks());

  // RX Characteristic (ESP32 receives from phone) - requires encryption
  NimBLECharacteristic *pUartRxCharacteristic = pUartService->createCharacteristic(
    UART_RX_CHAR_UUID,
    NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::WRITE_ENC
  );
  pUartRxCharacteristic->setCallbacks(new UartRxCallbacks());

  pUartService->start();
  

  // ===== HM-10 Service =====
  NimBLEService *pHM10Service = pServer->createService(HM10_SERVICE_UUID);

  // HM-10 characteristic (RW/Notify like HM-10 - no encryption required)
  pHM10Characteristic = pHM10Service->createCharacteristic(
    HM10_CHAR_UUID,
    NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::WRITE_NR | NIMBLE_PROPERTY::NOTIFY | NIMBLE_PROPERTY::INDICATE
  );
  pHM10Characteristic->setCallbacks(new HM10Callbacks());

  // Set max value length to support 24-byte HM-10 frames
  pHM10Characteristic->setValue((uint8_t*)"", 0);  // Initialize empty

  pHM10Service->start();

  ESP_LOGI(TAG, "HM-10 service (0xFFE0) created");

  // ===== Start Advertising =====
  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  // Only advertise HM-10 service - UART service available via service discovery
  pAdvertising->addServiceUUID(HM10_SERVICE_UUID);
  pAdvertising->setName("ESP32-S3(Begode)");  // KingSong 18L for Wheellog compatibility

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
    //create message struct
    UartTxMessage_t newMessage;
    size_t len = message.length();
    if (len >= UART_TX_MAX_MESSAGE_LEN) {
      len = UART_TX_MAX_MESSAGE_LEN - 1;
      ESP_LOGW(TAG, "Message truncated to %d bytes", len);
    }
    memcpy(newMessage.message, message.c_str(), len);
    newMessage.message[len] = '\0';
    newMessage.length = len;
    newMessage.data_pointer = newMessage.message;

    //enqueue message
    xQueueSend(uartTxQueue, &newMessage, 0);

    // try to take semaphore to start sending
    if (xSemaphoreTake(txSemaphore, 0) == pdTRUE) {

      // Send first chunk immediately
      if(xQueueReceive(uartTxQueue, &currentTxMessage, 0)) {
        currentTxMessage.data_pointer = currentTxMessage.message;  // Fix pointer after queue copy
        // Send message in chunks based on MTU size
        ble_sendUartPacket();
      }
      
    } else {
      ESP_LOGD(TAG, "[UART] Transmission in progress, message queued");
    }
  }
}

static void ble_sendUartPacket(void) {
  if (deviceConnected && pUartTxCharacteristic != nullptr && isConnectionEncrypted()) {
    // Check if there's data to send
    if (currentTxMessage.length == 0) {
      // Try to get next message from queue
      if (xQueueReceive(uartTxQueue, &currentTxMessage, 0) == pdTRUE) {
        currentTxMessage.data_pointer = currentTxMessage.message;  // Fix pointer after queue copy
      } else {
        // No more messages in queue, release semaphore
        xSemaphoreGiveFromISR(txSemaphore, NULL);
        ESP_LOGD(TAG, "[UART] All messages sent");
        return;
      }
    }

    // Calculate chunk size and get data pointer
    uint16_t chunkSize = currentTxMessage.length > mtuSize - 3 ? mtuSize - 3 : currentTxMessage.length;
    uint8_t* chunkData = (uint8_t*)currentTxMessage.data_pointer;

    // Update state BEFORE notify (so onStatus sees correct state)
    currentTxMessage.data_pointer += chunkSize;
    currentTxMessage.length -= chunkSize;

    // Now send the chunk
    pUartTxCharacteristic->setValue(chunkData, chunkSize);
    bool result = pUartTxCharacteristic->notify();

    if (!result) {
      ESP_LOGW(TAG, "[UART] Notify failed");
      // On failure, release semaphore to allow retry
      xSemaphoreGiveFromISR(txSemaphore, NULL);
    } else {
      ESP_LOGD(TAG, "[UART] Sent %d bytes, %d remaining", chunkSize, currentTxMessage.length);
    }

    // onStatus callback will call us again for next chunk
  }
}

void BLE_SetUartCallback(void (*callback)(const uint8_t* data, uint16_t len)) {
  uartCallback = callback;
}

void BLE_SendHM10Data(const uint8_t* data, uint16_t len) {
  if (deviceConnected && pHM10Characteristic != nullptr) {
    // Set the characteristic value (can be larger than MTU for read operations)
    while(len > 0)  {
        uint16_t chunkSize = len > mtuSize - 3 ? mtuSize - 3 : len; // 244 = 247 MTU - 3 overhead
        pHM10Characteristic->setValue(data, chunkSize);
        // Send via notify (now that MTU is negotiated)
        bool result = pHM10Characteristic->notify();

        if (!result) {
          ESP_LOGW(TAG, "[HM10] Notify failed");
        } else {
          // Log frame type for debugging
          ESP_LOGD(TAG, "[HM10] Sent %d bytes (header: 0x%02X 0x%02X)", chunkSize, data[0], data[1]);
        }
        data += chunkSize;
        len -= chunkSize;
      // pHM10Characteristic->setValue(data, len);

      // Send via notify (now that MTU is negotiated)
      // bool result = pHM10Characteristic->notify();

      // if (!result) {
      //   ESP_LOGW(TAG, "[HM10] Notify failed");
      // } else {
      //   // Log frame type for debugging
      //   ESP_LOGD(TAG, "[HM10] Sent %d bytes (header: 0x%02X 0x%02X)", len, data[0], data[1]);
      // }
    }
      
  }
}

void BLE_SetHM10Callback(void (*callback)(const uint8_t* data, uint16_t len)) {
  hm10Callback = callback;
}

bool BLE_IsConnected(void) {
  return deviceConnected;
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

    // ESP_LOGD(TAG, "Security state (handle %d) - Bonded: %s, Encrypted: %s, Authenticated: %s",
    //          currentConnHandle,
    //          bonded ? "YES" : "NO",
    //          encrypted ? "YES" : "NO",
    //          authenticated ? "YES" : "NO");

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
