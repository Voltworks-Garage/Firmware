/******************************************************************************
 * Includes
 *******************************************************************************/
#include "button.h"
#include <stdint.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void buttonRun(Button * thisButton) {

    uint8_t pinState = thisButton->pinFunction();
    
    switch (thisButton->state) {
        case BUTTON_RELEASED:
            if (pinState == 1) { // Button pressed
                thisButton->count++;
                if (thisButton->count >= thisButton->debounceTime) {
                    thisButton->state = BUTTON_PRESSED;
                    thisButton->buttonPressedEvent = 1;
                    thisButton->buttonReleasedEvent = 0; // Reset released event
                    thisButton->count = 0; // Reset count
                }
            } else {
                thisButton->count = 0; // Reset debounce counter
            }
            break;
            
        case BUTTON_PRESSED:
            thisButton->holdCount++;
            // Check if held long enough
            if (thisButton->holdCount >= thisButton->holdTime) {
                thisButton->isHeld = 1;
                thisButton->holdCount = thisButton->holdTime; // Keep holdCount at holdTime
            }
            if (pinState == 0) { // Button being released
                thisButton->count++;
                // Debounce the release - only change state after debounce period
                if (thisButton->count >= thisButton->debounceTime) {
                    thisButton->state = BUTTON_RELEASED;
                    thisButton->buttonReleasedEvent = 1;
                    thisButton->buttonPressedEvent = 0; // Reset pressed event
                    thisButton->count = 0;
                    thisButton->isHeld = 0;
                    thisButton->holdCount = 0; // Reset hold count
                }
            }
            break;
        case BUTTON_UNDEFINED:
            thisButton->undeterminedCount++;
            if(thisButton->undeterminedState != pinState) {
                thisButton->undeterminedCount = 0;
                thisButton->undeterminedState = pinState;
            }
            if(thisButton->undeterminedCount >= thisButton->debounceTime) {
                thisButton->state = thisButton->undeterminedState;
                thisButton->undeterminedCount = 0;
                thisButton->undeterminedState = BUTTON_UNDEFINED;
            }
            break;
        default:
            break;
    }
}

void buttonReset(Button * thisButton) {
    thisButton->count = 0;
    thisButton->holdCount = 0;
    thisButton->state = BUTTON_UNDEFINED;
    thisButton->isHeld = 0;
    thisButton->buttonPressedEvent = 0;
    thisButton->buttonReleasedEvent = 0;
    thisButton->undeterminedCount = 0;
    thisButton->undeterminedState = BUTTON_UNDEFINED;
}

ButtonStatus_E buttonGetState(Button * thisButton){
    return thisButton->state;
}

uint8_t buttonIsHeld(Button * thisButton, bool clearFlag) {
    uint8_t isHeld = thisButton->isHeld;
    if (isHeld && clearFlag) {
        thisButton->isHeld = 0;
        thisButton->holdCount = 0; // Reset hold count
    }
    return isHeld;
}

ButtonEvent_E buttonGetEvent(Button * thisButton) {
    if (thisButton->buttonPressedEvent) {
        thisButton->buttonPressedEvent = 0;
        return BUTTON_WAS_PRESSED;
    }
    if (thisButton->buttonReleasedEvent) {
        thisButton->buttonReleasedEvent = 0;
        return BUTTON_WAS_RELEASED;
    }
    return NO_EVENT;
}

/*** End of File **************************************************************/




