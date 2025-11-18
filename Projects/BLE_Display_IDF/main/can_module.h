#ifndef CAN_MODULE_H
#define CAN_MODULE_H

#include <stdbool.h>
#include <stdint.h>
#include "esp_twai.h"

#ifdef __cplusplus
extern "C" {
#endif

// CAN pin definitions
#define CAN_TX_PIN 21
#define CAN_RX_PIN 18

// CAN TX queue size (default is 5)
// Note: RX queue is managed internally by the new TWAI driver
#define CAN_TX_QUEUE_LEN 10

// Initialize CAN module
void CAN_Init(void);

// Deinitialize CAN module
void CAN_Deinit(void);

// Send a CAN message
bool CAN_write(uint32_t id, uint8_t* data, uint8_t length);

#ifdef __cplusplus
}
#endif

#endif // CAN_MODULE_H
