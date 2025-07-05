#ifndef EVENTS_H
#define EVENTS_H

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#define EVENT_QUEUE_SIZE 16

// Event types (you can extend this list)
typedef enum {
    EVENT_NONE = 0,
    EVENT_BUTTON_PRESSED,
    EVENT_TIMEOUT,
    EVENT_CAN_RX,
    EVENT_ISO_TP,
    EVENT_USER_DEFINED_2,
    // ...
} EventType_t;

// Event structure with a pointer to arbitrary data
typedef struct {
    EventType_t type;
    const void *data;    // Generic pointer to event-specific data
} Event_t;

// Post an event to the queue (returns false if queue full)
bool post_event(EventType_t type, const void *data);

// Get next event from the queue (returns false if none)
bool get_event(Event_t *out_event);

// Peek if any events are pending (optional)
bool event_available(void);

#endif // EVENTS_H
