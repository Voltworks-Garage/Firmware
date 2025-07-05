/******************************************************************************
 * Includes
 *******************************************************************************/
#include "IgnitionControl.h"
#include "IO.h"

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define KILL_SWITCH_DEBOUNCE_TIME 10
#define KILL_SWITCH_HOLD_TIME 100
/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
NEW_BUTTON(ignition_startButton, KILL_SWITCH_DEBOUNCE_TIME, KILL_SWITCH_HOLD_TIME, IO_GET_IGNITION_SWITCH_IN);
NEW_BUTTON(ignition_killButton, KILL_SWITCH_DEBOUNCE_TIME, KILL_SWITCH_HOLD_TIME, IO_GET_KILL_SWITCH_IN);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void IgnitionControl_Init(void) {
    //Assume button is in RUN position so that we don't just go to sleep right away.
    buttonSetState(ignition_killButton, BUTTON_NOT_PRESSED);
}

void IgnitionControl_Run_10ms(void) {
    buttonRun(ignition_startButton);
    buttonRun(ignition_killButton);
}

ButtonStatus_E IgnitionControl_GetKillStatus(void) {
    return buttonGetState(ignition_killButton);
}

ButtonStatus_E IgnitionControl_GetIgnitionStatus(void) {
    return buttonGetState(ignition_startButton);
}


void IgnitionControl_Halt(void) {
    Nop();
}

/*** End of File **************************************************************/




