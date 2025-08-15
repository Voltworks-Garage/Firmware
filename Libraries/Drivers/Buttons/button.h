/* 
 * File:   button.h
 * Author: kid group
 *
 * Created on June 12, 2018, 10:38 PM
 */

#ifndef BUTTON_H
#define	BUTTON_H

#include <stdint.h>
#include <stdbool.h>

typedef enum {
    BUTTON_RELEASED,
    BUTTON_PRESSED,
    BUTTON_UNDEFINED
} ButtonStatus_E;

typedef enum {
    NO_EVENT,
    BUTTON_WAS_PRESSED,
    BUTTON_WAS_RELEASED
} ButtonEvent_E;

typedef struct{
    uint16_t count;
    uint16_t holdCount;
    uint16_t undeterminedCount;
    ButtonStatus_E undeterminedState;
    ButtonStatus_E state;
    uint16_t debounceTime;
    uint16_t holdTime;
    uint8_t isHeld;
    uint8_t buttonPressedEvent;
    uint8_t buttonReleasedEvent;
    uint8_t (*pinFunction)(void);
} Button;


/**
 * NEW_BUTTON creates a Button Object
 * @param name: Name of button
 * @param debounceT: debounce counter, depends on how often function is called
 * @param holdT: hold time counter, depends on how often the function is called
 * @param function: The function that returns the GPIO value of the button
 */
#define NEW_BUTTON(name,debounceT,holdT,function) \
static Button name##Object = { \
    .count = 0, \
    .holdCount = 0, \
    .undeterminedCount = 0, \
    .undeterminedState = BUTTON_UNDEFINED, \
    .state = BUTTON_UNDEFINED, \
    .debounceTime = debounceT, \
    .holdTime = holdT, \
    .isHeld = 0, \
    .buttonPressedEvent = 0, \
    .buttonReleasedEvent = 0, \
    .pinFunction = function \
}; \
static Button * name = &name##Object\

/**
 * Call buttonRun with a button object.
 * @param thisButton
 */
void buttonRun(Button * thisButton);

void buttonReset(Button * thisButton);

ButtonStatus_E buttonGetState(Button * thisButton);

uint8_t buttonIsHeld(Button * thisButton, bool clearFlag);

ButtonEvent_E buttonGetEvent(Button * thisButton);

#endif	/* BUTTON_H */

