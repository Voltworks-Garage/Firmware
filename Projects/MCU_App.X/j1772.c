/******************************************************************************
 * Includes
 *******************************************************************************/
#include "j1772.h"
#include "IO.h"
#include "movingAverageInt.h"
#include "SysTick.h"
#include "mcu_dbc.h"
#include "timer.h"
#include "ADC.h"
#include "pinSetup.h"
#include "mcc_generated_files/clock.h"

/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/

/*Proximty Range values in milliVolts*/
#define PROX_DISCONNECT_UPPER 3200
#define PROX_DISCONNECT_LOWER 2600

#define PROX_CONNECT_UPPER 1100
#define PROX_CONNECT_LOWER 700

#define PROX_REQUEST_DISCONNECT_UPPER 2000
#define PROX_REQUEST_DISCONNECT_LOWER 1600

#define PROXIMITY_AVERAGE_WINDOW_SIZE 8

/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/
static uint8_t j1772run = 1;

NEW_AVERAGE_INT(proximityAverage, PROXIMITY_AVERAGE_WINDOW_SIZE);
static prox_status_E proximity = J1772_SNA_PROX;

NEW_LOW_PASS_FILTER_INT(pilotFilter, 0.1, 10.0);
static uint16_t pilotDutyFiltered = 0;
static uint16_t pilotDutyCycle = 0;
static uint16_t pilotEncodedCurrent = 0;

static volatile uint16_t pilotDutyInterrupt = 0;
static volatile uint16_t pilotDutyCounter = 0;

static bool vehicleChargingState = false;

NEW_TIMER(J1772_SNA_TIMER, 3000);
bool sna_timer_flag = false;
/******************************************************************************
 * Function Prototypes
 *******************************************************************************/

/******************************************************************************
 * Function Definitions
 *******************************************************************************/


void j1772Control_Init(void) {
    timer3_enableInterrupt(true);
    timer3_enable(true);

    pilotDutyFiltered = 0;
    pilotDutyCycle = 0;
    pilotEncodedCurrent = 0;
    j1772run = 1;
}


void j1772Control_Run_100ms(void) {
    if (j1772run) {

        //calculate the duty cycle interrupt version
        timer3_enableInterrupt(false);
        pilotDutyCycle = (uint32_t)pilotDutyInterrupt*100/pilotDutyCounter;
        pilotDutyInterrupt = 0;
        pilotDutyCounter = 0;
        pilotDutyFiltered = takeLowPassFilterInt(pilotFilter, pilotDutyCycle);
        timer3_enableInterrupt(true);
        
        CAN_mcu_mcu_debug_debug_value_1_u30_set(pilotDutyFiltered);

        /*Take moving average of Proximity value*/
        uint16_t currentProxAve = takeMovingAverageInt(proximityAverage, (uint16_t)(IO_GET_VOLTAGE_PROXIMITY()*1000));

        /*Determine the state of the Proximity Detector*/
        switch (currentProxAve) {
            case PROX_DISCONNECT_LOWER ... PROX_DISCONNECT_UPPER:
                proximity = J1772_DISCONNECTED;
                sna_timer_flag = false;
                break;
            case PROX_CONNECT_LOWER ... PROX_CONNECT_UPPER:
                proximity = J1772_CONNECTED;
                sna_timer_flag = false;
                break;
            case PROX_REQUEST_DISCONNECT_LOWER ... PROX_REQUEST_DISCONNECT_UPPER:
                proximity = J1772_REQUEST_DISCONNECT;
                sna_timer_flag = false;
                break;
            default:
                if (!sna_timer_flag){
                    SysTick_TimerStart(J1772_SNA_TIMER);
                    sna_timer_flag = true;
                }
                if (SysTick_TimeOut(J1772_SNA_TIMER) && sna_timer_flag){
                    proximity = J1772_SNA_PROX;
                }
                break;
        }


        /*Run the Pilot Signal State Machine with hysteresis protection*/
        static uint16_t lastPilotDutyFiltered = 0;
        
        if (abs(pilotDutyFiltered - lastPilotDutyFiltered) >= 2) {
            switch (pilotDutyFiltered) {
                case 0 ... 9:
                    pilotEncodedCurrent = 0;
                    break;
                case 10 ... 84:
                    pilotEncodedCurrent = pilotDutyFiltered * 0.6;
                    break;
                case 85 ... 100:
                    pilotEncodedCurrent = (pilotDutyFiltered - 64)*2.5;
                    break;
                default:
                    pilotEncodedCurrent = 0;
                    break;
            }
            lastPilotDutyFiltered = pilotDutyFiltered;
        }
    }

    // Always send the current state to the CAN bus.
    CAN_mcu_command_J1772_pilot_current_set(j1772getPilotCurrent());
    CAN_mcu_command_J1772_prox_status_set(j1772getProxState());

    // Always listen to the BMS to start/stop charging when in charging state.
    if (CAN_bms_power_systems_J1772_ready_to_charge_get() &&
        !CAN_bms_power_systems_checkDataIsStale() &&
        vehicleChargingState) {
        IO_SET_PILOT_EN(HIGH);
    } else {
        IO_SET_PILOT_EN(LOW);
    }
}

void j1772Control_Halt(void) {
    IO_SET_PILOT_EN(LOW);
    j1772run = 0;
    timer3_enable(false);
    pilotDutyFiltered = 0;
    pilotDutyCycle = 0;
    pilotEncodedCurrent = 0;
    clearMovingAverageInt(proximityAverage);
    clearLowPassFilterInt(pilotFilter);   
    proximity = J1772_SNA_PROX;
}

prox_status_E j1772getProxState(void) {
    return proximity;
}

uint16_t j1772getPilotCurrent(void) {
    return pilotEncodedCurrent;
}

void j1772chargingStateSet(bool charging) {
    vehicleChargingState = charging;
}

void __attribute__((interrupt, auto_psv)) _T3Interrupt(void) {
    timer3_clearInterruptFlag();
    if(ADC_GetValue(PILOT_MONITOR_AI) > 200){
        pilotDutyInterrupt++;
    }
    pilotDutyCounter++;

}