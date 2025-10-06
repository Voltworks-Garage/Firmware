/******************************************************************************
 * Includes
 *******************************************************************************/
#include "lvBattery.h"
#include "IO.h"
#include "movingAverage.h"
#include "SysTick.h"
#include "mcu_dbc.h"

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define LV_BATTERY_CHARGE_FULL_LEVEL 13.5
#define LV_BATTERY_CHARGE_EMPTY_LEVEL 11.0
#define LV_BATTERY_CHARGE_FULL_CURRENT_LEVEL 0.2

#define LV_BATTERY_STATES(state)\
state(battery_off)\
state(dcdc_support_request)\
state(battery_and_dcdc_on)\
state(faulted)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(LV_BATTERY_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/
typedef enum {
    LV_BATTERY_STATES(STATE_FORM)
    NUMBER_OF_LV_BATTERY_STATES
} LV_BATTERY_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN
} LV_BATTERY_entry_types_E;

typedef void(*lvBatteryStatePtr)(LV_BATTERY_entry_types_E);

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
LV_BATTERY_STATES(FUNCTION_FORM)
static lvBatteryStatePtr lv_battery_state_functions[] = {LV_BATTERY_STATES(FUNC_PTR_FORM)};

static LV_BATTERY_states_E lv_battery_prevState = battery_off_state;
static LV_BATTERY_states_E lv_battery_curState = battery_off_state;
static LV_BATTERY_states_E lv_battery_nextState = battery_off_state;

static bool lvBatteryEnabled = false;

/* 1Hz Filters on battery voltage and current*/
NEW_LOW_PASS_FILTER(lvBatteryVoltage, 1.0, 100.0);
NEW_LOW_PASS_FILTER(lvBatteryVoltageFast, 10.0, 100.0);
NEW_LOW_PASS_FILTER(dcdcInputCurrent, 1.0, 100.0);
NEW_LOW_PASS_FILTER(lvBatteryCurrent, 1.0, 100.0);

#define CHARGE_MONITOR_TIME 30000  // 30 seconds
NEW_TIMER(chargeMonitorTimer, CHARGE_MONITOR_TIME);
NEW_TIMER(dcdcReadyTimer, 5000); // 2 seconds for DCDC to start up
NEW_TIMER(faultTimer, 10000);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/

void LvBattery_Init(void) {
    lvBatteryEnabled = true;
    lv_battery_curState = battery_off_state;
    lv_battery_prevState = battery_off_state;
    lv_battery_nextState = battery_off_state;

    /*Initialize the fast filter so we can get up and running more quickly*/
    if (IO_GET_SW_EN()) {
        lvBatteryVoltageFast->accum = IO_GET_VOLTAGE_VBAT_SW();
    }
    
    lv_battery_state_functions[lv_battery_curState](ENTRY);
}

void LvBattery_Run_10ms(void) {
    if (!lvBatteryEnabled) {
        return;
    }

    if (lv_battery_nextState != lv_battery_curState) {
        lv_battery_state_functions[lv_battery_curState](EXIT);
        lv_battery_prevState = lv_battery_curState;
        lv_battery_curState = lv_battery_nextState;
        lv_battery_state_functions[lv_battery_curState](ENTRY);
    }
    
    lv_battery_state_functions[lv_battery_curState](RUN);
}

void LvBattery_Halt(void) {
    lv_battery_state_functions[lv_battery_curState](EXIT);
    IO_SET_DCDC_EN(LOW);
    lvBatteryEnabled = false;
}

bool LvBattery_HasDCDCSupport(void) {
    return (lv_battery_curState == dcdc_support_request_state);
}

void battery_off(LV_BATTERY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            IO_SET_BATT_EN(LOW);
            IO_SET_DCDC_EN(LOW);
            CAN_mcu_command_DCDC_enable_set(0);
            break;
        case EXIT:
            break;
        case RUN:
            if (IO_GET_SW_EN() == true) {
                lv_battery_nextState = dcdc_support_request_state;
            }
            break;
        default:
            break;
    }
}

void dcdc_support_request(LV_BATTERY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            CAN_mcu_command_DCDC_enable_set(1);
            SysTick_TimerStart(dcdcReadyTimer);
            break;
        case EXIT:
            break;
        case RUN:
            if(SysTick_TimeOut(dcdcReadyTimer)) {
                if ((CAN_bms_power_systems_DCDC_state_get() == true) && (IO_GET_DCDC_FAULT() == false)) {
                    lv_battery_nextState = battery_and_dcdc_on_state;
                } else {
                    lv_battery_nextState = faulted_state;
                }
            }
            break;
        default:
            break;
    }
}

void battery_and_dcdc_on(LV_BATTERY_entry_types_E entry_type) {
    
    static uint16_t faultCount = 0;
                
    switch (entry_type) {
        case ENTRY:
            CAN_mcu_command_DCDC_enable_set(1);
            IO_SET_BATT_EN(HIGH);
            IO_SET_DCDC_EN(HIGH);

            break;
        case EXIT:
            CAN_mcu_command_DCDC_enable_set(0);
            IO_SET_DCDC_EN(LOW);
            break;
        case RUN:
            faultCount++;
            if ((IO_GET_DCDC_FAULT() == true)){// || (CAN_bms_power_systems_DCDC_state_get() == false)) {
                lv_battery_nextState = faulted_state;
            }
            break;
        default:
            break;
    }
}

void faulted(LV_BATTERY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            CAN_mcu_command_DCDC_enable_set(0);
            IO_SET_DCDC_EN(LOW);
            IO_SET_BATT_EN(HIGH);
            SysTick_TimerStart(faultTimer);
            break;
        case EXIT:
            break;
        case RUN:
            if(SysTick_TimeOut(faultTimer)) {
                lv_battery_nextState = battery_off_state;
            }
            break;
        default:
            break;
    }
}

/*** End of File **************************************************************/