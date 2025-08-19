/* 
 * File:   IgnitionControl.h
 * Author: kid group
 *
 * Created on June 12, 2018, 10:38 PM
 */

#ifndef IGNITIONCONTROL_H
#define	IGNITIONCONTROL_H

#include "button.h"
#include <stdbool.h>

#define DEBOUNCE_TIME 10
#define HOLD_TIME 1000

typedef enum {
    KILL_SWITCH,
    START_BUTTON,
    LEFT_TURN_BUTTON,
    RIGHT_TURN_BUTTON,
    HORN_BUTTON,
    ASS_BUTTON,
    LEFT_BRAKE_BUTTON,
    RIGHT_BRAKE_BUTTON
} IgnitionControlButton_E;

void IgnitionControl_Init(void);

void IgnitionControl_Run_1ms(void);

ButtonStatus_E IgnitionControl_GetKillSwitchStatus(void);
bool IgnitionControl_GetKillSwitchIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetKillSwitchEvent(void);

ButtonStatus_E IgnitionControl_GetStartButtonStatus(void);
bool IgnitionControl_GetStartButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetStartButtonEvent(void);

ButtonStatus_E IgnitionControl_GetLeftTurnButtonStatus(void);
bool IgnitionControl_GetLeftTurnButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetLeftTurnButtonEvent(void);

ButtonStatus_E IgnitionControl_GetRightTurnButtonStatus(void);
bool IgnitionControl_GetRightTurnButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetRightTurnButtonEvent(void);

ButtonStatus_E IgnitionControl_GetHornButtonStatus(void);
bool IgnitionControl_GetHornButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetHornButtonEvent(void);

ButtonStatus_E IgnitionControl_GetAssButtonStatus(void);
bool IgnitionControl_GetAssButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetAssButtonEvent(void);

ButtonStatus_E IgnitionControl_GetLeftBrakeButtonStatus(void);
bool IgnitionControl_GetLeftBrakeButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetLeftBrakeButtonEvent(void);

ButtonStatus_E IgnitionControl_GetRightBrakeButtonStatus(void);
bool IgnitionControl_GetRightBrakeButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetRightBrakeButtonEvent(void);

ButtonStatus_E IgnitionControl_GetHighBeamButtonStatus(void);
bool IgnitionControl_GetHighBeamButtonIsHeld(bool clearFlag);
ButtonEvent_E IgnitionControl_GetHighBeamButtonEvent(void);

void IgnitionControl_Halt(void);

#endif	/* IGNITIONCONTROL_H */

