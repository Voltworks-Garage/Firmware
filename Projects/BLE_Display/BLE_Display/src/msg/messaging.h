#ifndef MESSAGING_H
#define MESSAGING_H

#include <stdint.h>
#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "messaging_schema.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    MSG_ID_CAN_FRAME,
    MSG_ID_BLE_COMMAND,
    MSG_ID_UI_EVENT,
    MSG_ID_TOUCH_EVENT,
    MSG_ID_UI_UPDATE,
    MSG_ID_APP_STATE,
    MSG_ID_COUNT
} MessageId_t;

typedef enum {
    MODULE_CAN,
    MODULE_BLE,
    MODULE_UI,
    MODULE_TOUCH,
    MODULE_APP,
    MODULE_COUNT,
    MODULE_BROADCAST = 0xFF
} ModuleId_t;

typedef struct {
    MessageId_t id;
    ModuleId_t source;
    ModuleId_t destination;   // MODULE_BROADCAST for pub-sub
    uint8_t payload[32];
    uint8_t len;
} Message_t;

/**
 * Initialize the messaging bus
 */
void MsgBus_Init(void);

/**
 * Register a module with its message queue
 */
void MsgBus_Register(ModuleId_t module, QueueHandle_t queue);

/**
 * Subscribe a module to a specific message ID
 */
void MsgBus_Subscribe(MessageId_t id, ModuleId_t module, QueueHandle_t queue);
void MsgBus_Send(const Message_t *msg);
void MsgBus_Publish(const Message_t *msg);

#ifdef __cplusplus
}
#endif
#endif // MESSAGING_H