#ifndef MESSAGING_SCHEMA_H
#define MESSAGING_SCHEMA_H

#include <stdint.h>

// Define payload structures for each message type:
typedef struct {
    uint32_t can_id;
    uint8_t  data[8];
    uint8_t  dlc;
} MsgCanFrame_t;

typedef struct {
    char command[20];
    uint8_t arg;
} MsgBleCommand_t;

typedef struct {
    uint16_t x, y;
    uint8_t  pressed;
} MsgUiEvent_t;

typedef struct {
    uint8_t systemState;
} MsgAppState_t;

// Optional union if you want easier access:
typedef union {
    MsgCanFrame_t can;
    MsgBleCommand_t ble;
    MsgUiEvent_t ui;
    MsgAppState_t app;
} MessagePayload_t;

#endif // MESSAGING_SCHEMA_H