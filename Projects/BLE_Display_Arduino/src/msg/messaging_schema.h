#ifndef MESSAGING_SCHEMA_H
#define MESSAGING_SCHEMA_H

#include <stdint.h>

typedef enum {
    BLE_CONNECTION,
    BLE_BOND,
    BLE_UART_RX,
    BLE_HM10_RX,
    BLE_ARG_COUNT
} ble_arg_t;

#endif // MESSAGING_SCHEMA_H
