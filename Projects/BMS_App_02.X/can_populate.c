/*
 * File:   can_populate.c
 * Author: zachleedogg
 *
 * Created on May 15, 2022, 11:21 PM
 */
#include <math.h>

#include "can_populate.h"
#include "bms_dbc.h"
#include "IO.h"
#include "bms.h"
#include "ltc6802_1_nb.h"
#include "ev_charger.h"
#include "NTC.h"
#include "ADC.h"


void CAN_populate_1ms(void){
    
    CAN_bms_power_systems_DCDC_state_set(IO_GET_DCDC_EN());
    CAN_bms_power_systems_DCDC_fault_set(IO_GET_DCDC_FAULT());
    CAN_bms_power_systems_DCDC_voltage_set(IO_GET_DCDC_OUTPUT_VOLTAGE());
    CAN_bms_power_systems_DCDC_current_set(IO_GET_DCDC_CURRENT());
    CAN_bms_power_systems_EV_charger_state_set(IO_GET_EV_CHARGER_EN());
    CAN_bms_power_systems_EV_charger_fault_set(IO_GET_EV_CHARGER_FAULT());
    CAN_bms_power_systems_EV_charger_voltage_set(IO_GET_EV_CHARGER_VOLTAGE());
    CAN_bms_power_systems_EV_charger_current_set(IO_GET_EV_CHARGER_CURRENT());
    CAN_bms_power_systems_HV_precharge_state_set(IO_GET_PRE_CHARGE_EN());
    //CAN_bms_power_systems_HV_contactor_state_set(IO_GET_)
    CAN_bms_power_systems_HV_isolation_voltage_set(IO_GET_ISOLATION_VOLTAGE());
    CAN_bms_status_M2_vbus_voltage_set(IO_GET_VBUS_VOLTAGE());

}

void CAN_populate_10ms(void){
    // Populate LTC6802-1 error data into bms_status MUX 2 using enhanced error handling
    LTC6802_1_Error_Info_S current_error_info;
    static uint32_t total_transactions = 0, failed_transactions = 0, total_retries = 0;
    
    // Initialize error info structure to prevent garbage values
    memset(&current_error_info, 0, sizeof(current_error_info));
    
    // Get current LTC module state (map to numeric value)
    uint16_t ltc_state = 0; // 0=idle, 1=reading, 2=processing, 3=faulted, etc.
    if (LTC6802_1_IsBusy()) {
        ltc_state = 1; // Busy/active state
    }
    
    // Check if we have an active error using enhanced error info
    bool has_active_error = LTC6802_1_GetErrorInfo(&current_error_info);
    if (has_active_error && current_error_info.error_code != LTC6802_1_ERROR_NONE) {
        ltc_state = 3; // Faulted state
    }
    CAN_bms_status_M2_ltc_state_set(ltc_state);
    
    // Get the most recent error code from the enhanced error system
    uint16_t last_error_code = 0;
    if (has_active_error && current_error_info.error_code != LTC6802_1_ERROR_NONE) {
        // Validate error code is within expected range before using
        if (current_error_info.error_code <= LTC6802_1_ERROR_DATA_CORRUPTION) {
            last_error_code = (uint16_t)current_error_info.error_code;
        } else {
            last_error_code = 255; // Invalid error marker
        }
    } else {
        // Fall back to legacy per-stack error checking
        LTC6802_1_Error_E error_stack0 = LTC6802_1_GetLastError(0);
        LTC6802_1_Error_E error_stack1 = LTC6802_1_GetLastError(1);
        LTC6802_1_Error_E max_error = (error_stack0 > error_stack1) ? error_stack0 : error_stack1;
        
        // Validate error code range
        if (max_error <= LTC6802_1_ERROR_DATA_CORRUPTION) {
            last_error_code = (uint16_t)max_error;
        } else {
            last_error_code = 254; // Invalid legacy error marker
        }
    }
    CAN_bms_status_M2_ltc_last_error_set(last_error_code);
    
    // Get transaction statistics and use failed transactions as error count
    LTC6802_1_GetStats(&total_transactions, &failed_transactions, &total_retries);
    CAN_bms_status_M2_ltc_error_count_set((uint16_t)(failed_transactions & 0xFFF)); // 12-bit field
}

void CAN_populate_100ms(void){
    Nop();
}

void CAN_populate_1000ms(void){

        CAN_bms_status_M0_bms_state_set(1);
        CAN_bms_status_M0_pack_voltage_set(BMS_GetPackVoltage());
        CAN_bms_status_M0_soc_percent_set((BMS_GetPackVoltage() - 60)*2.5);
        CAN_bms_status_M0_pack_temp_min_set(14);
        CAN_bms_status_M0_pack_temp_max_set(65);
        CAN_bms_status_M0_pack_current_set(10.5);

        CAN_bms_status_M1_stack_voltage_1_set(BMS_GetStackVoltage(0));
        CAN_bms_status_M1_stack_voltage_2_set(BMS_GetStackVoltage(1));
        CAN_bms_status_M1_pack_voltage_sum_of_stacks_set(BMS_GetStackVoltage(0)+BMS_GetStackVoltage(1));
        CAN_bms_status_M1_debug_signal_1_set(ADC_GetValue(AN2));

        CAN_bms_cell_voltages_M0_cell_1_voltage_set(BMS_GetCellVoltage(0));
        CAN_bms_cell_voltages_M0_cell_2_voltage_set(BMS_GetCellVoltage(1));
        CAN_bms_cell_voltages_M0_cell_3_voltage_set(BMS_GetCellVoltage(2));
        CAN_bms_cell_voltages_M0_cell_4_voltage_set(BMS_GetCellVoltage(3));

        CAN_bms_cell_voltages_M1_cell_5_voltage_set(BMS_GetCellVoltage(4));
        CAN_bms_cell_voltages_M1_cell_6_voltage_set(BMS_GetCellVoltage(5));
        CAN_bms_cell_voltages_M1_cell_7_voltage_set(BMS_GetCellVoltage(6));
        CAN_bms_cell_voltages_M1_cell_8_voltage_set(BMS_GetCellVoltage(7));

        CAN_bms_cell_voltages_M2_cell_9_voltage_set(BMS_GetCellVoltage(8));
        CAN_bms_cell_voltages_M2_cell_10_voltage_set(BMS_GetCellVoltage(9));
        CAN_bms_cell_voltages_M2_cell_11_voltage_set(BMS_GetCellVoltage(10));
        CAN_bms_cell_voltages_M2_cell_12_voltage_set(BMS_GetCellVoltage(11));

        CAN_bms_cell_voltages_M3_cell_13_voltage_set(BMS_GetCellVoltage(12));
        CAN_bms_cell_voltages_M3_cell_14_voltage_set(BMS_GetCellVoltage(13));
        CAN_bms_cell_voltages_M3_cell_15_voltage_set(BMS_GetCellVoltage(14));
        CAN_bms_cell_voltages_M3_cell_16_voltage_set(BMS_GetCellVoltage(15));

        CAN_bms_cell_voltages_M4_cell_17_voltage_set(BMS_GetCellVoltage(16));
        CAN_bms_cell_voltages_M4_cell_18_voltage_set(BMS_GetCellVoltage(17));
        CAN_bms_cell_voltages_M4_cell_19_voltage_set(BMS_GetCellVoltage(18));
        CAN_bms_cell_voltages_M4_cell_20_voltage_set(BMS_GetCellVoltage(19));

        CAN_bms_cell_voltages_M5_cell_21_voltage_set(BMS_GetCellVoltage(20));
        CAN_bms_cell_voltages_M5_cell_22_voltage_set(BMS_GetCellVoltage(21));
        CAN_bms_cell_voltages_M5_cell_23_voltage_set(BMS_GetCellVoltage(22));
        CAN_bms_cell_voltages_M5_cell_24_voltage_set(BMS_GetCellVoltage(23));
    
    // Debug: Check actual voltage values from LTC driver
    float temp_voltage_0 = BMS_GetTemperatureVoltage(0);
    float temp_voltage_1 = BMS_GetTemperatureVoltage(1);
    float temp_voltage_2 = BMS_GetTemperatureVoltage(2);
    float temp_voltage_3 = BMS_GetTemperatureVoltage(3);
    float temp_voltage_4 = BMS_GetTemperatureVoltage(4);
    float temp_voltage_5 = BMS_GetTemperatureVoltage(5);
    
    // Pass the actual voltage values directly as temperature - this will show what LTC is returning
    CAN_bms_cell_temperatures_M0_temp_4_set(temp_voltage_3); // Should show raw voltage as temperature
    CAN_bms_cell_temperatures_M1_temp_5_set(temp_voltage_4); // Should show raw voltage as temperature
    CAN_bms_cell_temperatures_M1_temp_6_set(temp_voltage_5); // Should show raw voltage as temperature

    CAN_bms_cell_temperatures_M0_ext_temp_1_set(temp_voltage_0); // Should show raw voltage as temperature
    CAN_bms_cell_temperatures_M0_stack_voltage_1_set(BMS_GetTemperatureVoltage(1)*19.007); // Keep voltage scaling
    CAN_bms_cell_temperatures_M0_int_voltage_1_set(temp_voltage_2); // Should show raw voltage as temperature
    CAN_bms_debug_word1_set(temp_voltage_0);
    CAN_bms_debug_byte1_set(13);
}
        