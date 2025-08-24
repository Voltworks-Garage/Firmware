/******************************************************************************
 * Includes
 *******************************************************************************/
#include "IO.h"
#include "pinSetup.h"
#include "ADC.h"
#include "movingAverage.h"
#include "mcu_dbc.h"


/******************************************************************************
 * Constants
 *******************************************************************************/

/******************************************************************************
 * Macros
 *******************************************************************************/
#define ADC_BIT_DEPTH 1023
#define ADC_REF_VOLTAGE 3.3

#define VBAT_VOLTAGE_CONVERSION 8.234
#define PILOT_VOLTAGE_CONVERSION 4.6
#define PROXIMITY_VOLTAGE_CONVERSION 1
#define VBAT_CURRENT_CONVERSION 20.0
#define DCDC_CURRENT_CONVERSION 33.33

// Fixed-point arithmetic constants (scaled by 1024)
#define FIXED_POINT_SCALE 1024
#define FIXED_POINT_SHIFT 10
#define ADC_TO_VOLTAGE_SCALE_FIXED 3317  // (3.3V * 1024) / 1023 ≈ 3.317, then * 1024
/******************************************************************************
 * Configuration
 *******************************************************************************/

/******************************************************************************
 * Typedefs
 *******************************************************************************/

/******************************************************************************
 * Variable Declarations
 *******************************************************************************/

/*Fault Bits*/
static uint8_t FAN_fault = 0;
static uint8_t PUMP_fault = 0;
static uint8_t TAILLIGHT_fault = 0;
static uint8_t BRAKELIGHT_fault = 0;
static uint8_t LOWBEAM_fault = 0;
static uint8_t HIGHBEAM_fault = 0;
static uint8_t HORN_fault = 0;
static uint8_t AUX_PORT_fault = 0;
static uint8_t HEATED_GRIPS_fault = 0;
static uint8_t HEATED_SEAT_fault = 0;
static uint8_t CHARGE_CONTROLLER_fault = 0;
static uint8_t MOTOR_CONTROLLER_fault = 0;
static uint8_t BMS_CONTROLLER_fault = 0;
static uint8_t SPARE_1_CONTROLLER_fault = 0;
static uint8_t BATT_fault = 0;
static uint8_t DCDC_fault = 0;
static uint8_t IC_CONTROLLER_fault = 0;

/*Current values*/
static uint16_t FAN_current = 0;
static uint16_t PUMP_current = 0;
static uint16_t TAILLIGHT_current = 0;
static uint16_t BRAKELIGHT_current = 0;
static uint16_t LOWBEAM_current = 0;
static uint16_t HIGHBEAM_current = 0;
static uint16_t HORN_current = 0;
static uint16_t AUX_PORT_current = 0;
static uint16_t HEATED_GRIPS_current = 0;
static uint16_t HEATED_SEAT_current = 0;
static uint16_t CHARGE_CONTROLLER_current = 0;
static uint16_t MOTOR_CONTROLLER_current = 0;
static uint16_t BMS_CONTROLLER_current = 0;
static uint16_t SPARE_1_CONTROLLER_current = 0;

NEW_LOW_PASS_FILTER(FAN_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(PUMP_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(TAILLIGHT_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(BRAKELIGHT_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(LOWBEAM_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(HIGHBEAM_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(HORN_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(AUX_PORT_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(HEATED_GRIPS_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(HEATED_SEAT_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(CHARGE_CONTROLLER_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(MOTOR_CONTROLLER_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(BMS_CONTROLLER_current_filter, 3, 10.0);
NEW_LOW_PASS_FILTER(SPARE_1_CONTROLLER_current_filter, 3, 10.0);

static uint8_t efuse_run = 1;


/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
void IO_PopulateCANFaultBits(void);
void IO_PopulateCANCurrentBits(void);
float convertADCToCurrent(uint16_t adcValue, uint16_t dkillis, uint16_t rsense);
/******************************************************************************
 * Function Definitions
 *******************************************************************************/
void IO_Efuse_Init(void) {
    IO_SET_DIAG_SELECT_EN(LOW);
    IO_SET_DIAG_EN(HIGH);
    efuse_run = 1;

    FAN_fault = 0;
    PUMP_fault = 0;
    TAILLIGHT_fault = 0;
    BRAKELIGHT_fault = 0;
    LOWBEAM_fault = 0;
    HIGHBEAM_fault = 0;
    HORN_fault = 0;
    AUX_PORT_fault = 0;
    HEATED_GRIPS_fault = 0;
    HEATED_SEAT_fault = 0;
    CHARGE_CONTROLLER_fault = 0;
    MOTOR_CONTROLLER_fault = 0;
    BMS_CONTROLLER_fault = 0;
    SPARE_1_CONTROLLER_fault = 0;
    BATT_fault = 0;
    DCDC_fault = 0;
    IC_CONTROLLER_fault = 0;
}

void IO_Efuse_Run_10ms(void) {

    IO_PopulateCANFaultBits();
    IO_PopulateCANCurrentBits();
    if(efuse_run){
        /*Check value of Diag pin to select which HSDs are being read out*/
        uint8_t diagSelect = IO_GET_DIAG_SELECT_EN();

        if (diagSelect == 1) {

            takeLowPassFilter(PUMP_current_filter, ADC_GetValue(FAN_ISENSE_AI));
            if (getLowPassFilter(PUMP_current_filter) >= 1000) {
                PUMP_fault = 1;
                IO_SET_PUMP_1_EN(LOW);
            }

            takeLowPassFilter(BRAKELIGHT_current_filter, ADC_GetValue(TAILLIGHT_ISENSE_AI));
            if (getLowPassFilter(BRAKELIGHT_current_filter) >= 1000) {
                BRAKELIGHT_fault = 1;
                IO_SET_BRAKE_LIGHT_EN(LOW);
            }

            takeLowPassFilter(LOWBEAM_current_filter, ADC_GetValue(HEADLIGHT_ISENSE_AI));
            if (getLowPassFilter(LOWBEAM_current_filter) >= 1000) {
                LOWBEAM_fault = 1;
                IO_SET_HEADLIGHT_LO_EN(LOW);
            }

            takeLowPassFilter(HEATED_SEAT_current_filter, ADC_GetValue(HEATER_ISENSE_AI));
            if (getLowPassFilter(HEATED_SEAT_current_filter) >= 1000) {
                HEATED_SEAT_fault = 1;
                IO_SET_HEATED_SEAT_EN(LOW);
            }

            takeLowPassFilter(CHARGE_CONTROLLER_current_filter, ADC_GetValue(ECU_2_ISENSE_AI));
            if (getLowPassFilter(CHARGE_CONTROLLER_current_filter) >= 1000) {
                CHARGE_CONTROLLER_fault = 1;
                IO_SET_CHARGE_CONTROLLER_EN(LOW);
            }

            takeLowPassFilter(SPARE_1_CONTROLLER_current_filter, ADC_GetValue(ECU_1_ISENSE_AI));
            if (getLowPassFilter(SPARE_1_CONTROLLER_current_filter) >= 1000) {
                SPARE_1_CONTROLLER_fault = 1;
                IO_SET_J1772_CONTROLLER_EN(LOW);
            }

        } else {
            takeLowPassFilter(FAN_current_filter, ADC_GetValue(FAN_ISENSE_AI));
            if (getLowPassFilter(FAN_current_filter) >= 1000) {
                FAN_fault = 1;
                IO_SET_FAN_1_EN(LOW);
            }

            takeLowPassFilter(TAILLIGHT_current_filter, ADC_GetValue(TAILLIGHT_ISENSE_AI));
            if (getLowPassFilter(TAILLIGHT_current_filter) >= 1000) {
                TAILLIGHT_fault = 1;
                IO_SET_TAILLIGHT_EN(LOW);
            }

            takeLowPassFilter(HIGHBEAM_current_filter, ADC_GetValue(HEADLIGHT_ISENSE_AI));
            if (getLowPassFilter(HIGHBEAM_current_filter) >= ADC_BIT_DEPTH) {
                HIGHBEAM_fault = 1;
                IO_SET_HEADLIGHT_HI_EN(LOW);
            }

            takeLowPassFilter(HEATED_GRIPS_current_filter, ADC_GetValue(HEATER_ISENSE_AI));
            if (getLowPassFilter(HEATED_GRIPS_current_filter) >= 1000) {
                HEATED_GRIPS_fault = 1;
                IO_SET_HEATED_GRIPS_EN(LOW);
            }

            takeLowPassFilter(MOTOR_CONTROLLER_current_filter, ADC_GetValue(ECU_2_ISENSE_AI));
            if (getLowPassFilter(MOTOR_CONTROLLER_current_filter) >= 1000) {
                MOTOR_CONTROLLER_fault = 1;
                IO_SET_MOTOR_CONTROLLER_EN(LOW);
            }

            takeLowPassFilter(BMS_CONTROLLER_current_filter, ADC_GetValue(ECU_1_ISENSE_AI));
            if (getLowPassFilter(BMS_CONTROLLER_current_filter) >= 1000) {
                BMS_CONTROLLER_fault = 1;
                IO_SET_BMS_CONTROLLER_EN(LOW);
            }
        }

        takeLowPassFilter(HORN_current_filter, IO_GET_CURRENT_HORN());
        if (getLowPassFilter(HORN_current_filter) >= 1000) {
            HORN_fault = 1;
            IO_SET_HORN_EN(LOW);
        }

        takeLowPassFilter(AUX_PORT_current_filter, IO_GET_CURRENT_AUX_PORT());
        if (getLowPassFilter(AUX_PORT_current_filter) >= 1000) {
            AUX_PORT_fault = 1;
            IO_SET_AUX_PORT_EN(LOW);
        }

        BATT_fault = IO_GET_BATT_FAULT();

        DCDC_fault = IO_GET_DCDC_FAULT();

        IC_CONTROLLER_fault = IO_GET_IC_CONTROLLER_FAULT();

        /*Toggle Diag Select for next cycle*/
        IO_SET_DIAG_SELECT_EN(TOGGLE);
    }

}

void IO_Efuse_Halt(void) {
    efuse_run = 0;
    IO_SET_DIAG_SELECT_EN(LOW);
    IO_SET_DIAG_EN(LOW);
}

void IO_SET_DEBUG_LED_EN(uint8_t state) {
    PINS_write(DEBUG_LED_EN, state);
}

void IO_SET_DEBUG_PIN_EN(uint8_t state) {
    PINS_write(DEBUG_PIN_EN, state);
}

void IO_SET_BMS_CONTROLLER_EN(uint8_t state) {
    if (BMS_CONTROLLER_fault == 0) {
        PINS_write(BMS_CONTROLLER_EN, state);
    }
}

void IO_SET_J1772_CONTROLLER_EN(uint8_t state) {
    PINS_write(J1772_CONTROLLER_EN, state);
}

void IO_SET_MOTOR_CONTROLLER_EN(uint8_t state) {
    if (MOTOR_CONTROLLER_fault == 0) {
        PINS_write(MOTOR_CONTROLLER_EN, state);
    }
}

void IO_SET_CHARGE_CONTROLLER_EN(uint8_t state) {
    if (CHARGE_CONTROLLER_fault == 0) {
        PINS_write(CHARGE_CONTROLLER_EN, state);
    }
}

void IO_SET_PILOT_EN(uint8_t state) {
    PINS_write(PILOT_EN, state);
}

void IO_SET_BRAKE_LIGHT_EN(uint8_t state) {
    if (BRAKELIGHT_fault == 0) {
        PINS_write(BRAKE_LIGHT_EN, state);
    }
}

void IO_SET_TAILLIGHT_EN(uint8_t state) {
    if (TAILLIGHT_fault == 0) {
        PINS_write(TAILLIGHT_EN, state);
    }
}

void IO_SET_HEADLIGHT_HI_EN(uint8_t state) {
    if (HIGHBEAM_fault == 0) {
        PINS_write(HEADLIGHT_HI_EN, state);
    }
}

void IO_SET_HEADLIGHT_LO_EN(uint8_t state) {
    if (LOWBEAM_fault == 0) {
        PINS_write(HEADLIGHT_LO_EN, state);
    }
}

void IO_SET_CHARGER_CONTACTOR_EN(uint8_t state) {
    PINS_write(CHARGER_CONTACTOR_EN, state);
}

void IO_SET_DCDC_CONTACTOR_EN(uint8_t state) {
    PINS_write(DCDC_CONTACTOR_EN, state);
}

void IO_SET_BATTERY_CONTACTOR_EN(uint8_t state) {
    PINS_write(BATTERY_CONTACTOR_EN, state);
}

void IO_SET_PRECHARGE_RELAY_EN(uint8_t state) {
    PINS_write(PRECHARGE_RELAY_EN, state);
}

void IO_SET_HORN_EN(uint8_t state) {
    if (HORN_fault == 0) {
        PINS_write(HORN_EN, state);
    }
}

void IO_SET_AUX_PORT_EN(uint8_t state) {
    if (AUX_PORT_fault == 0) {
        PINS_write(AUX_PORT_EN, state);
    }
}

void IO_SET_TURN_SIGNAL_FR_EN(uint8_t state) {
    PINS_write(TURN_SIGNAL_FR_EN, state);
}

void IO_SET_TURN_SIGNAL_RR_EN(uint8_t state) {
    PINS_write(TURN_SIGNAL_RR_EN, state);
}

void IO_SET_TURN_SIGNAL_FL_EN(uint8_t state) {
    PINS_write(TURN_SIGNAL_FL_EN, state);
}

void IO_SET_TURN_SIGNAL_RL_EN(uint8_t state) {
    PINS_write(TURN_SIGNAL_RL_EN, state);
}

void IO_SET_HEATED_GRIPS_EN(uint8_t state) {
    if (HEATED_GRIPS_fault == 0) {
        PINS_write(HEATED_GRIPS_EN, state);
    }
}

void IO_SET_HEATED_SEAT_EN(uint8_t state) {
    if (HEATED_SEAT_fault == 0) {
        PINS_write(HEATED_SEAT_EN, state);
    }
}

void IO_SET_SW_EN(uint8_t state) {
    PINS_write(SW_EN, state);
}

void IO_SET_DIAG_EN(uint8_t state) {
    PINS_write(DIAG_EN, state);
}

void IO_SET_DIAG_SELECT_EN(uint8_t state) {
    PINS_write(DIAG_SELECT_EN, state);
}

void IO_SET_DCDC_EN(uint8_t state) {
    //if (DCDC_fault == 0) {
        PINS_write(DCDC_EN, state);
    //}
}

void IO_SET_BATT_EN(uint8_t state) {
    //if (BATT_fault == 0) {
        PINS_write(BATT_EN, state);
    //}
}

void IO_SET_CAN_SLEEP_EN(uint8_t state) {
    PINS_write(CAN_SLEEP_EN, state);
}

void IO_SET_IC_CONTROLLER_SLEEP_EN(uint8_t state) {
    PINS_write(IC_CONTROLLER_SLEEP_EN, state);
}

void IO_SET_PUMP_1_EN(uint8_t state) {
    if (PUMP_fault == 0) {
        PINS_write(PUMP_1_EN, state);
    }
}

void IO_SET_FAN_1_EN(uint8_t state) {
    if (FAN_fault == 0) {
        PINS_write(FAN_1_EN, state);
    }
}

void IO_SET_KICKSTAND_SWITCH_IN(uint8_t state) {
    PINS_write(KICKSTAND_SWITCH_IN, state);
}

/*INPUTS*/

uint8_t IO_GET_DEBUG_LED_EN(void) {
    return PINS_read(DEBUG_LED_EN);
}

uint8_t IO_GET_DEBUG_PIN_EN(void) {
    return PINS_read(DEBUG_PIN_EN);
}

uint8_t IO_GET_BMS_CONTROLLER_EN(void) {
    return PINS_read(BMS_CONTROLLER_EN);
}

uint8_t IO_GET_J1772_CONTROLLER_EN(void) {
    return PINS_read(J1772_CONTROLLER_EN);
}

uint8_t IO_GET_MOTOR_CONTROLLER_EN(void) {
    return PINS_read(MOTOR_CONTROLLER_EN);
}

uint8_t IO_GET_CHARGE_CONTROLLER_EN(void) {
    return PINS_read(CHARGE_CONTROLLER_EN);
}

uint8_t IO_GET_PILOT_EN(void) {
    return PINS_read(PILOT_EN);
}

uint8_t IO_GET_BRAKE_LIGHT_EN(void) {
    return PINS_read(BRAKE_LIGHT_EN);
}

uint8_t IO_GET_TAILLIGHT_EN(void) {
    return PINS_read(TAILLIGHT_EN);
}

uint8_t IO_GET_HEADLIGHT_HI_EN(void) {
    return PINS_read(HEADLIGHT_HI_EN);
}

uint8_t IO_GET_HEADLIGHT_LO_EN(void) {
    return PINS_read(HEADLIGHT_LO_EN);
}

uint8_t IO_GET_CHARGER_CONTACTOR_EN(void) {
    return PINS_read(CHARGER_CONTACTOR_EN);
}

uint8_t IO_GET_DCDC_CONTACTOR_EN(void) {
    return PINS_read(DCDC_CONTACTOR_EN);
}

uint8_t IO_GET_BATTERY_CONTACTOR_EN(void) {
    return PINS_read(BATTERY_CONTACTOR_EN);
}

uint8_t IO_GET_PRECHARGE_RELAY_EN(void) {
    return PINS_read(PRECHARGE_RELAY_EN);
}

uint8_t IO_GET_HORN_EN(void) {
    return PINS_read(HORN_EN);
}

uint8_t IO_GET_AUX_PORT_EN(void) {
    return PINS_read(AUX_PORT_EN);
}

uint8_t IO_GET_TURN_SIGNAL_FR_EN(void) {
    return PINS_read(TURN_SIGNAL_FR_EN);
}

uint8_t IO_GET_TURN_SIGNAL_RR_EN(void) {
    return PINS_read(TURN_SIGNAL_RR_EN);
}

uint8_t IO_GET_TURN_SIGNAL_FL_EN(void) {
    return PINS_read(TURN_SIGNAL_FL_EN);
}

uint8_t IO_GET_TURN_SIGNAL_RL_EN(void) {
    return PINS_read(TURN_SIGNAL_RL_EN);
}

uint8_t IO_GET_HEATED_GRIPS_EN(void) {
    return PINS_read(HEATED_GRIPS_EN);
}

uint8_t IO_GET_HEATED_SEAT_EN(void) {
    return PINS_read(HEATED_SEAT_EN);
}

uint8_t IO_GET_SW_EN(void) {
    return PINS_read(SW_EN);
}

uint8_t IO_GET_DIAG_EN(void) {
    return PINS_read(DIAG_EN);
}

uint8_t IO_GET_DIAG_SELECT_EN(void) {
    return PINS_read(DIAG_SELECT_EN);
}

uint8_t IO_GET_DCDC_EN(void) {
    return PINS_read(DCDC_EN);
}

uint8_t IO_GET_BATT_EN(void) {
    return PINS_read(BATT_EN);
}

uint8_t IO_GET_CAN_SLEEP_EN(void) {
    return PINS_read(CAN_SLEEP_EN);
}

uint8_t IO_GET_IC_CONTROLLER_SLEEP_EN(void) {
    return PINS_read(IC_CONTROLLER_SLEEP_EN);
}

uint8_t IO_GET_PUMP_1_EN(void) {
    return PINS_read(PUMP_1_EN);
}

uint8_t IO_GET_FAN_1_EN(void) {
    return PINS_read(FAN_1_EN);
}

uint8_t IO_GET_IC_CONTROLLER_FAULT(void) {
    return PINS_read(IC_CONTROLLER_nFAULT) ? 0 : 1;
}

uint8_t IO_GET_DCDC_FAULT(void) {
    if(IO_GET_SW_EN() == 1) {
        return PINS_read(DCDC_nFAULT) ? 0 : 1;
    }
    return 0;
}

uint8_t IO_GET_BATT_FAULT(void) {
    if(IO_GET_SW_EN() == 1) {
        return PINS_read(BATT_nFAULT) ? 0 : 1;
    }
    return 0;
}

uint8_t IO_GET_TURN_SIGNAL_L_STATUS(void) {
    return PINS_read(TURN_SIGNAL_L_STATUS);
}

uint8_t IO_GET_TURN_SIGNAL_R_STATUS(void) {
    return PINS_read(TURN_SIGNAL_R_STATUS);
}

uint8_t IO_GET_CONTACT_1_2_STATUS(void) {
    return PINS_read(CONTACT_1_2_STATUS);
}

uint8_t IO_GET_CONTACT_3_4_STATUS(void) {
    return PINS_read(CONTACT_3_4_STATUS);
}

uint8_t IO_GET_SPARE_SWITCH_1_IN(void) {
    return PINS_read(SPARE_SWITCH_1_IN) ? 0 : 1;
}

uint8_t IO_GET_SPARE_SWITCH_2_IN(void) {
    return PINS_read(SPARE_SWITCH_2_IN) ? 0 : 1;
}

uint8_t IO_GET_BRAKE_SWITCH_1_IN(void) {
    return PINS_read(BRAKE_SWITCH_1_IN) ? 0 : 1;
}

uint8_t IO_GET_BRAKE_SWITCH_2_IN(void) {
    return PINS_read(BRAKE_SWITCH_2_IN) ? 0 : 1;
}

uint8_t IO_GET_IGNITION_SWITCH_IN(void) {
    return PINS_read(IGNITION_SWITCH_IN) ? 0 : 1;
}

uint8_t IO_GET_KILL_SWITCH_IN(void) {
    return PINS_read(KILL_SWITCH_IN) ? 1 : 0;
}

uint8_t IO_GET_TURN_LEFT_SWITCH_IN(void) {
    return PINS_read(TURN_LEFT_SWITCH_IN) ? 0 : 1;
}

uint8_t IO_GET_TURN_RIGHT_SWITCH_IN(void) {
    return PINS_read(TURN_RIGHT_SWITCH_IN) ? 0 : 1;
}

uint8_t IO_GET_BRIGHTS_SWITCH_IN(void) {
    return PINS_read(BRIGHTS_SWITCH_IN) ? 1 : 0;
}

uint8_t IO_GET_HORN_SWITCH_IN(void) {
    return PINS_read(HORN_SWITCH_IN) ? 0 : 1;
}

uint8_t IO_GET_KICKSTAND_SWITCH_IN(void) {
    return PINS_read(KICKSTAND_SWITCH_IN) ? 0 : 1;
}

/*ANALOG*/

uint16_t IO_GET_CURRENT_FAN() {
    return convertADCToCurrent(getLowPassFilter(FAN_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_PUMP() {
    return convertADCToCurrent(getLowPassFilter(PUMP_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_TAILLIGHT() {
    return convertADCToCurrent(getLowPassFilter(TAILLIGHT_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_BRAKELIGHT() {
    return convertADCToCurrent(getLowPassFilter(BRAKELIGHT_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_LOWBEAM() {
    return convertADCToCurrent(getLowPassFilter(LOWBEAM_current_filter), 3000, 1500);
}

uint16_t IO_GET_CURRENT_HIGHBEAM() {
    return convertADCToCurrent(getLowPassFilter(HIGHBEAM_current_filter), 3000, 1500);
}

uint16_t IO_GET_CURRENT_HORN() {
    return convertADCToCurrent(getLowPassFilter(HORN_current_filter), 12500, 4700);
}

uint16_t IO_GET_CURRENT_AUX_PORT() {
    return convertADCToCurrent(getLowPassFilter(AUX_PORT_current_filter), 12500, 4700);
}

uint16_t IO_GET_CURRENT_HEATED_GRIPS() {
    return convertADCToCurrent(getLowPassFilter(HEATED_GRIPS_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_HEATED_SEAT() {
    return convertADCToCurrent(getLowPassFilter(HEATED_SEAT_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_CHARGE_CONTROLLER() {
    return convertADCToCurrent(getLowPassFilter(CHARGE_CONTROLLER_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_MOTOR_CONTROLLER() {
    return convertADCToCurrent(getLowPassFilter(MOTOR_CONTROLLER_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_BMS_CONTROLLER() {
    return convertADCToCurrent(getLowPassFilter(BMS_CONTROLLER_current_filter), 3000, 4700);
}

uint16_t IO_GET_CURRENT_SPARE_1_CONTROLLER() {
    return convertADCToCurrent(getLowPassFilter(SPARE_1_CONTROLLER_current_filter), 3000, 4700);
}

float IO_GET_CURRENT_BATT() {
    return ((ADC_GetValue(BATT_ISENSE_AI))*(ADC_REF_VOLTAGE/ADC_BIT_DEPTH)-1.65)*VBAT_CURRENT_CONVERSION;
}

float IO_GET_CURRENT_DCDC() {
    return (ADC_GetValue(DCDC_ISENSE_AI)*(ADC_REF_VOLTAGE/ADC_BIT_DEPTH)-1.65)*DCDC_CURRENT_CONVERSION;
}

float IO_GET_CURRENT_IC_CONTROLLER() {
    return ADC_GetValue(IC_CONTROLLER_ISENSE_AI)*(ADC_REF_VOLTAGE/ADC_BIT_DEPTH)*2;
}

float IO_GET_VOLTAGE_PILOT(void) {
    return (((float)ADC_GetValue(PILOT_MONITOR_AI))*(ADC_REF_VOLTAGE*PILOT_VOLTAGE_CONVERSION)/ADC_BIT_DEPTH);
}

float IO_GET_VOLTAGE_PROXIMITY(void) {
    return (((float)ADC_GetValue(PROXIMITY_MONITOR_AI))*(ADC_REF_VOLTAGE*PROXIMITY_VOLTAGE_CONVERSION)/ADC_BIT_DEPTH);
}

float IO_GET_VOLTAGE_VBAT(void) {
    return (((float)ADC_GetValue(V12_MONITOR_AI))*(ADC_REF_VOLTAGE*VBAT_VOLTAGE_CONVERSION)/ADC_BIT_DEPTH);
}

float IO_GET_VOLTAGE_VBAT_SW(void) {
    return (((float)ADC_GetValue(P12_MONITOR_AI))*(ADC_REF_VOLTAGE*VBAT_VOLTAGE_CONVERSION)/ADC_BIT_DEPTH);
}


/*FAULT BITS*/

uint8_t IO_GET_FAN_FAULT(void) {
    return FAN_fault;
}

uint8_t IO_GET_PUMP_FAULT(void) {
    return PUMP_fault;
}

uint8_t IO_GET_TAILLIGHT_FAULT(void) {
    return TAILLIGHT_fault;
}

uint8_t IO_GET_BRAKELIGHT_FAULT(void) {
    return BRAKELIGHT_fault;
}

uint8_t IO_GET_LOWBEAM_FAULT(void) {
    return LOWBEAM_fault;
}

uint8_t IO_GET_HIGHBEAM_FAULT(void) {
    return HIGHBEAM_fault;
}

uint8_t IO_GET_HORN_FAULT(void) {
    return HORN_fault;
}

uint8_t IO_GET_AUX_PORT_FAULT(void) {
    return AUX_PORT_fault;
}

uint8_t IO_GET_HEATED_GRIPS_FAULT(void) {
    return HEATED_GRIPS_fault;
}

uint8_t IO_GET_HEATED_SEAT_FAULT(void) {
    return HEATED_SEAT_fault;
}

uint8_t IO_GET_CHARGE_CONTROLLER_FAULT(void) {
    return CHARGE_CONTROLLER_fault;
}

uint8_t IO_GET_MOTOR_CONTROLLER_FAULT(void) {
    return MOTOR_CONTROLLER_fault;
}

uint8_t IO_GET_BMS_CONTROLLER_FAULT(void) {
    return BMS_CONTROLLER_fault;
}

uint8_t IO_GET_SPARE_1_CONTROLLER_FAULT(void) {
    return SPARE_1_CONTROLLER_fault;
}

void IO_PopulateCANFaultBits(void) {
    CAN_mcu_status_batt_fault_set(BATT_fault);
    CAN_mcu_status_dcdc_fault_set(DCDC_fault);
    CAN_mcu_status_fan_fault_set(FAN_fault);
    CAN_mcu_status_pump_fault_set(PUMP_fault);
    CAN_mcu_status_taillight_fault_set(TAILLIGHT_fault);
    CAN_mcu_status_brakelight_fault_set(BRAKELIGHT_fault);
    CAN_mcu_status_lowbeam_fault_set(LOWBEAM_fault);
    CAN_mcu_status_highbeam_fault_set(HIGHBEAM_fault);
    CAN_mcu_status_horn_fault_set(HORN_fault);
    CAN_mcu_status_aux_port_fault_set(AUX_PORT_fault);
    CAN_mcu_status_heated_grips_fault_set(HEATED_GRIPS_fault);
    CAN_mcu_status_heated_seat_fault_set(HEATED_SEAT_fault);
    CAN_mcu_status_charge_controller_fault_set(CHARGE_CONTROLLER_fault);
    CAN_mcu_status_motor_controller_fault_set(MOTOR_CONTROLLER_fault);
    CAN_mcu_status_bms_controller_fault_set(BMS_CONTROLLER_fault);
    CAN_mcu_status_spare_1_controller_fault_set(SPARE_1_CONTROLLER_fault);
    CAN_mcu_status_ic_controller_fault_set(IC_CONTROLLER_fault);
}

void IO_PopulateCANCurrentBits(void) {
    // CAN_mcu_status_fan_current_set(IO_GET_CURRENT_FAN());
    // CAN_mcu_status_pump_current_set(IO_GET_CURRENT_PUMP());
    // CAN_mcu_status_taillight_current_set(IO_GET_CURRENT_TAILLIGHT());
    // CAN_mcu_status_brakelight_current_set(IO_GET_CURRENT_BRAKELIGHT());
    CAN_mcu_status_lowbeam_current_set(IO_GET_CURRENT_LOWBEAM());
    CAN_mcu_status_highbeam_current_set(IO_GET_CURRENT_HIGHBEAM());
    CAN_mcu_status_horn_current_set(IO_GET_CURRENT_HORN());
    CAN_mcu_status_aux_port_current_set(IO_GET_CURRENT_AUX_PORT());
    CAN_mcu_status_heated_grips_current_set(IO_GET_CURRENT_HEATED_GRIPS());
    CAN_mcu_status_heated_seat_current_set(IO_GET_CURRENT_HEATED_SEAT());
    // CAN_mcu_status_charge_controller_current_set(IO_GET_CURRENT_CHARGE_CONTROLLER());
    // CAN_mcu_status_motor_controller_current_set(IO_GET_CURRENT_MOTOR_CONTROLLER());
    CAN_mcu_status_bms_controller_current_set(IO_GET_CURRENT_BMS_CONTROLLER());
    // CAN_mcu_status_spare_1_controller_current_set(IO_GET_CURRENT_SPARE_1_CONTROLLER());
}

// Fixed-point version: returns current scaled by 1024 (much faster!)
uint32_t convertADCToCurrentFixed(uint16_t adcValue, uint16_t dkillis, uint16_t rsense) {
    // Convert ADC to voltage (scaled by 1024)
    // adcValue * 3317 gives us voltage * 1024 * 1024
    uint32_t voltage_scaled = ((uint32_t)adcValue * ADC_TO_VOLTAGE_SCALE_FIXED) >> FIXED_POINT_SHIFT;
    
    // Calculate current: (voltage * dkillis) / rsense, result scaled by 1024
    // Use 64-bit intermediate to prevent overflow
    uint64_t current_temp = ((uint64_t)voltage_scaled * dkillis) / rsense;
    
    // Clamp to 32-bit max to prevent overflow
    if (current_temp > UINT32_MAX) {
        return UINT32_MAX;
    }
    
    return (uint32_t)current_temp;
}

// Convert fixed-point result to float (only when needed for display/CAN)
float fixedToFloat(uint32_t fixed_value) {
    return (float)fixed_value / FIXED_POINT_SCALE;
}

// Legacy float version (kept for compatibility)
float convertADCToCurrent(uint16_t adcValue, uint16_t dkillis, uint16_t rsense) {
    return fixedToFloat(convertADCToCurrentFixed(adcValue, dkillis, rsense));
}




/*** End of File **************************************************************/



