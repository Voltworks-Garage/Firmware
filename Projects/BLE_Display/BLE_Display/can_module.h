#ifndef CAN_MODULE_H
#define CAN_MODULE_H

#include <Arduino.h>
#include "driver/twai.h"

// CAN pin definitions
#define CAN_TX_PIN 21
#define CAN_RX_PIN 18

// CAN queue sizes (default is 5 for both TX and RX)
#define CAN_TX_QUEUE_LEN 10
#define CAN_RX_QUEUE_LEN 10

// Initialize CAN module
void CAN_Init(void);

// Send a CAN message
bool CAN_SendMessage(uint32_t id, uint8_t* data, uint8_t length);

// Receive a CAN message (non-blocking)
bool CAN_ReceiveMessage(twai_message_t* message);

// Create and start CAN receive task
void CAN_CreateRxTask(void);

#endif // CAN_MODULE_H
