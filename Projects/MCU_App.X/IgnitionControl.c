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

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
NEW_BUTTON(ignition_startButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_IGNITION_SWITCH_IN);
NEW_BUTTON(ignition_killSwitch, DEBOUNCE_TIME, HOLD_TIME, IO_GET_KILL_SWITCH_IN);
NEW_BUTTON(ignition_leftTurnButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_TURN_LEFT_SWITCH_IN);
NEW_BUTTON(ignition_rightTurnButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_TURN_RIGHT_SWITCH_IN);
NEW_BUTTON(ignition_hornButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_HORN_SWITCH_IN);
NEW_BUTTON(ignition_assButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_SPARE_SWITCH_1_IN);
NEW_BUTTON(ignition_leftBrakeButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_BRAKE_SWITCH_1_IN);
NEW_BUTTON(ignition_rightBrakeButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_BRAKE_SWITCH_2_IN);
NEW_BUTTON(ignition_highBeamButton, DEBOUNCE_TIME, HOLD_TIME, IO_GET_BRIGHTS_SWITCH_IN);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void IgnitionControl_Init(void) {
    buttonReset(ignition_startButton);
    buttonReset(ignition_killSwitch);
    buttonReset(ignition_leftTurnButton);
    buttonReset(ignition_rightTurnButton);
    buttonReset(ignition_hornButton);
    buttonReset(ignition_assButton);
    buttonReset(ignition_leftBrakeButton);
    buttonReset(ignition_rightBrakeButton);
    buttonReset(ignition_highBeamButton);
}

void IgnitionControl_Halt(void) {
    buttonReset(ignition_startButton);
    buttonReset(ignition_killSwitch);
    buttonReset(ignition_leftTurnButton);
    buttonReset(ignition_rightTurnButton);
    buttonReset(ignition_hornButton);
    buttonReset(ignition_assButton);
    buttonReset(ignition_leftBrakeButton);
    buttonReset(ignition_rightBrakeButton);
    buttonReset(ignition_highBeamButton);
}

void IgnitionControl_Run_1ms(void) {
    buttonRun(ignition_startButton);
    buttonRun(ignition_killSwitch);
    if (IO_GET_SW_EN()){
        buttonRun(ignition_leftTurnButton);
        buttonRun(ignition_rightTurnButton);
        buttonRun(ignition_hornButton);
        buttonRun(ignition_assButton);
        buttonRun(ignition_leftBrakeButton);
        buttonRun(ignition_rightBrakeButton);
        buttonRun(ignition_highBeamButton);
    } else {
        buttonReset(ignition_leftTurnButton);
        buttonReset(ignition_rightTurnButton);
        buttonReset(ignition_hornButton);
        buttonReset(ignition_assButton);
        buttonReset(ignition_leftBrakeButton);
        buttonReset(ignition_rightBrakeButton);
        buttonReset(ignition_highBeamButton);
    }
}

ButtonStatus_E IgnitionControl_GetKillSwitchStatus(void){
    return buttonGetState(ignition_killSwitch);
}
bool IgnitionControl_GetKillSwitchIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_killSwitch, clearFlag);
}
ButtonStatus_E IgnitionControl_GetStartButtonStatus(void){
    return buttonGetState(ignition_startButton);
}
bool IgnitionControl_GetStartButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_startButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetLeftTurnButtonStatus(void){
    return buttonGetState(ignition_leftTurnButton);
}
bool IgnitionControl_GetLeftTurnButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_leftTurnButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetRightTurnButtonStatus(void){
    return buttonGetState(ignition_rightTurnButton);
}
bool IgnitionControl_GetRightTurnButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_rightTurnButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetHornButtonStatus(void){
    return buttonGetState(ignition_hornButton);
}
bool IgnitionControl_GetHornButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_hornButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetAssButtonStatus(void){
    return buttonGetState(ignition_assButton);
}
bool IgnitionControl_GetAssButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_assButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetLeftBrakeButtonStatus(void){
    return buttonGetState(ignition_leftBrakeButton);
}
bool IgnitionControl_GetLeftBrakeButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_leftBrakeButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetRightBrakeButtonStatus(void){
    return buttonGetState(ignition_rightBrakeButton);
}
bool IgnitionControl_GetRightBrakeButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_rightBrakeButton, clearFlag);
}
ButtonStatus_E IgnitionControl_GetHighBeamButtonStatus(void){
    return buttonGetState(ignition_highBeamButton);
}
bool IgnitionControl_GetHighBeamButtonIsHeld(bool clearFlag){
    return buttonIsHeld(ignition_highBeamButton, clearFlag);
}

ButtonEvent_E IgnitionControl_GetKillSwitchEvent(void){
    return buttonGetEvent(ignition_killSwitch);
}
ButtonEvent_E IgnitionControl_GetStartButtonEvent(void){
    return buttonGetEvent(ignition_startButton);
}
ButtonEvent_E IgnitionControl_GetLeftTurnButtonEvent(void){
    return buttonGetEvent(ignition_leftTurnButton);
}
ButtonEvent_E IgnitionControl_GetRightTurnButtonEvent(void){
    return buttonGetEvent(ignition_rightTurnButton);
}
ButtonEvent_E IgnitionControl_GetHornButtonEvent(void){
    return buttonGetEvent(ignition_hornButton);
}
ButtonEvent_E IgnitionControl_GetAssButtonEvent(void){
    return buttonGetEvent(ignition_assButton);
}
ButtonEvent_E IgnitionControl_GetLeftBrakeButtonEvent(void){
    return buttonGetEvent(ignition_leftBrakeButton);
}
ButtonEvent_E IgnitionControl_GetRightBrakeButtonEvent(void){
    return buttonGetEvent(ignition_rightBrakeButton);
}
ButtonEvent_E IgnitionControl_GetHighBeamButtonEvent(void){
    return buttonGetEvent(ignition_highBeamButton);
}

/*** End of File **************************************************************/




