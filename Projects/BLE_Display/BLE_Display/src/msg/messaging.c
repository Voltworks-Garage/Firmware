#include "messaging.h"

// Internal storage for registered queues
static QueueHandle_t msg_queues[MODULE_COUNT];

// Optional: subscription lists
static QueueHandle_t sub_list[MODULE_COUNT][MODULE_COUNT];

void MsgBus_Init(void) {
    // do nothing for now
}

void MsgBus_Register(ModuleId_t module, QueueHandle_t queue) {
    if (module < MODULE_COUNT) {
        msg_queues[module] = queue;
    }
}

void MsgBus_Subscribe(ModuleId_t sub2module, ModuleId_t module, QueueHandle_t queue) {
    if (queue != NULL && sub2module < MODULE_COUNT && module < MODULE_COUNT) {
        sub_list[sub2module][module] = queue;
    }
}

void MsgBus_Send(const Message_t *msg) {
    if (msg->destination < MODULE_COUNT) {
        xQueueSend(msg_queues[msg->destination], msg, 0);
    }
}

void MsgBus_Publish(const Message_t *msg) {
    if (msg->source < MODULE_COUNT) {
        for (int i = 0; i < MODULE_COUNT; i++) {
            if (sub_list[msg->source][i] != NULL) {
                xQueueSend(sub_list[msg->source][i], msg, 0);
            }
        }
    }
}