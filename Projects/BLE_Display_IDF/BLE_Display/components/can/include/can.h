#ifndef CAN_H
#define CAN_H

#include "driver/twai.h"  // Legacy API (compatible with v4.x/v5.x code)

#ifdef __cplusplus
extern "C" {
#endif

// CAN operating modes
typedef enum {
    CAN_NORMAL_MODE = 0,  // Normal operation - TX and RX enabled
    CAN_LISTEN_MODE = 1   // Listen-only - RX enabled, TX disabled (ACKs still sent)
} CAN_Mode_t;

// CAN message payload structure is also defined in Libraries/PIC33_plib/inc/can.h
typedef struct {
   uint16_t word0;
   uint16_t word1;
   uint16_t word2;
   uint16_t word3;
} CAN_payload_S;

// Forward declaration
struct CAN_message_S;

// RX callback function pointer type
typedef void (*CAN_RxCallback_t)(struct CAN_message_S* msg);

// CAN message structure is also defined in Libraries/PIC33_plib/inc/can.h
typedef struct CAN_message_S {
    uint32_t canID;
    uint8_t canXID;
    uint8_t dlc;
    volatile CAN_payload_S * payload;
    volatile uint8_t * canMessageStatus;
    volatile uint32_t last_received_timestamp;
    CAN_RxCallback_t rx_callback;  // Optional: called from RX task when message received
} CAN_message_S;

// CAN pin definitions
#define CAN_TX_PIN GPIO_NUM_21
#define CAN_RX_PIN GPIO_NUM_18

// CAN queue sizes (default is 5 for both TX and RX)
#define CAN_TX_QUEUE_LEN 10
#define CAN_RX_QUEUE_LEN 32

// Initialize CAN module
void CAN_Init(void);

void CAN_DeInit(void);

// Send a CAN message (DBC-compatible signature)
uint8_t CAN_write(CAN_message_S *msg);

// Send a CAN message (simple helper)
bool CAN_write_simple(uint32_t id, uint8_t* data, uint8_t length);

// Configure a CAN mailbox to receive messages with a specific ID
uint8_t CAN_configureMailbox(CAN_message_S * newMessage);

// Receive a CAN message (non-blocking)
bool CAN_ReceiveMessage(twai_message_t* message);

// Create and start CAN receive task
void CAN_CreateRxTask(void);

/**
 * Timestamp function pointer type for CAN staleness detection
 */
typedef uint32_t (*CAN_GetTimestamp_t)(void);

/**
 * Sets the timestamp callback function for CAN staleness detection
 * @param timestamp_func Function that returns current timestamp in milliseconds
 */
void CAN_timeStampFunc(CAN_GetTimestamp_t timestamp_func);

/**
 * Checks if message data is stale based on timestamp
 * @param data CAN message to check
 * @param timeout_ms Timeout threshold in milliseconds
 * @return 1 if stale or no timestamp function set, 0 if fresh
 */
uint8_t CAN_checkDataIsStale(CAN_message_S * data, uint32_t timeout_ms);

/**
 * Gets time since last message reception
 * @param data CAN message to check
 * @return Time in milliseconds since last reception, 0 if no timestamp function set
 */
uint32_t CAN_getTimeSinceLastReceived(CAN_message_S * data);

/**
 * Checks if message data is unread
 * @param data CAN message to check
 * @return 1 if unread, 0 if read
 */
uint8_t CAN_checkDataIsUnread(CAN_message_S * data);

/**
 * Gets time since last CAN message received (any ID)
 * @return Time in milliseconds since last message, 0xFFFFFFFF if no messages received yet
 */
uint32_t CAN_timeSinceLastMessageReceived(void);

/**
 * Sets the CAN operating mode
 * @param mode CAN_NORMAL_MODE (TX/RX enabled) or CAN_LISTEN_MODE (TX disabled, RX/ACK enabled)
 */
void CAN_setMode(CAN_Mode_t mode);

#ifdef __cplusplus
}
#endif

#endif // CAN_H
