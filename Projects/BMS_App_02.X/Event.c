#include "Events.h"

typedef struct {
    Event_t buffer[EVENT_QUEUE_SIZE];
    volatile uint8_t head;
    volatile uint8_t tail;
} EventQueue_t;

static EventQueue_t queue = { .head = 0, .tail = 0 };

bool post_event(EventType_t type, const void *data) {
    uint8_t next = (queue.head + 1) % EVENT_QUEUE_SIZE;

    // Check for overflow
    if (next == queue.tail) {
        return false; // Queue full
    }

    queue.buffer[queue.head].type = type;
    queue.buffer[queue.head].data = data;
    queue.head = next;
    return true;
}

bool get_event(Event_t *out_event) {
    if (queue.head == queue.tail) {
        return false; // Queue empty
    }

    *out_event = queue.buffer[queue.tail];
    queue.tail = (queue.tail + 1) % EVENT_QUEUE_SIZE;
    return true;
}

bool event_available(void) {
    return queue.head != queue.tail;
}

