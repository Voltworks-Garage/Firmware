#include "messaging.h"

// Internal storage for registered queues
static QueueHandle_t msg_queues[MODULE_COUNT];

// Optional: subscription lists
static QueueHandle_t sub_list[MSG_ID_COUNT][MODULE_COUNT];

void MsgBus_Init(void) {
    // do nothing for now
}

void MsgBus_Register(ModuleId_t module, QueueHandle_t queue) {
    if (module < MODULE_COUNT) {
        msg_queues[module] = queue;
    }
}

void MsgBus_Subscribe(MessageId_t id, ModuleId_t module, QueueHandle_t queue) {
    if (queue != NULL && id < MSG_ID_COUNT && module < MODULE_COUNT) {
        sub_list[id][module] = queue;
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
            if (sub_list[msg->id][i] != NULL) {
                xQueueSend(sub_list[msg->id][i], msg, 0);
            }
        }
    }
}