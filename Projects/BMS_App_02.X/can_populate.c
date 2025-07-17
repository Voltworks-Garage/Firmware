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
#include "ev_charger.h"


void CAN_populate_1ms(void){
    
    CAN_bms_status_2_DCDC_state_set(IO_GET_DCDC_EN());
    CAN_bms_status_2_DCDC_fault_set(IO_GET_DCDC_FAULT());
    CAN_bms_status_2_DCDC_voltage_set(IO_GET_DCDC_OUTPUT_VOLTAGE());
    CAN_bms_status_2_DCDC_current_set(IO_GET_DCDC_CURRENT());
    CAN_bms_status_2_EV_charger_state_set(IO_GET_EV_CHARGER_EN());
    CAN_bms_status_2_EV_charger_fault_set(IO_GET_EV_CHARGER_FAULT());
    CAN_bms_status_2_EV_charger_voltage_set(IO_GET_EV_CHARGER_VOLTAGE());
    CAN_bms_status_2_EV_charger_current_set(IO_GET_EV_CHARGER_CURRENT());
    CAN_bms_status_2_HV_precharge_state_set(IO_GET_PRE_CHARGE_EN());
    //CAN_bms_status_2_HV_contactor_state_set(IO_GET_)
    CAN_bms_status_2_HV_isolation_voltage_set(IO_GET_ISOLATION_VOLTAGE());
    CAN_bms_debug_VBUS_Voltage_set(IO_GET_VBUS_VOLTAGE());
    
}

void CAN_populate_10ms(void){
    Nop();
}

void CAN_populate_100ms(void){
    Nop();
}

void CAN_populate_1000ms(void){
    static uint8_t cellVoltageMultiPlex = 0;
    
    // Force multiplex to 1 for testing M1 cells
    CAN_bms_cellVoltages_MultiPlex_set(cellVoltageMultiPlex);
    
    // Calculate base cell index (1-based indexing for LTC6802_get_cell_voltage)
    uint8_t baseCellIndex = cellVoltageMultiPlex * 4 + 1;
    
    // Force case 1 for testing M1 cells
    switch(cellVoltageMultiPlex) {
        case 0: // M0: cells 1-4
            CAN_bms_cellVoltages_M0_cell_1_voltage_set(BMS_GetCellVoltage(baseCellIndex));
            CAN_bms_cellVoltages_M0_cell_2_voltage_set(BMS_GetCellVoltage(baseCellIndex + 1));
            CAN_bms_cellVoltages_M0_cell_3_voltage_set(BMS_GetCellVoltage(baseCellIndex + 2));
            CAN_bms_cellVoltages_M0_cell_4_voltage_set(BMS_GetCellVoltage(baseCellIndex + 3));
            break;
        case 1: // M1: cells 5-8
            CAN_bms_cellVoltages_M1_cell_5_voltage_set(BMS_GetCellVoltage(baseCellIndex));
            CAN_bms_cellVoltages_M1_cell_6_voltage_set(BMS_GetCellVoltage(baseCellIndex + 1));
            CAN_bms_cellVoltages_M1_cell_7_voltage_set(BMS_GetCellVoltage(baseCellIndex + 2));
            CAN_bms_cellVoltages_M1_cell_8_voltage_set(BMS_GetCellVoltage(baseCellIndex + 3));
            break;
        case 2: // M2: cells 9-12
            CAN_bms_cellVoltages_M2_cell_9_voltage_set(BMS_GetCellVoltage(baseCellIndex));
            CAN_bms_cellVoltages_M2_cell_10_voltage_set(BMS_GetCellVoltage(baseCellIndex + 1));
            CAN_bms_cellVoltages_M2_cell_11_voltage_set(BMS_GetCellVoltage(baseCellIndex + 2));
            CAN_bms_cellVoltages_M2_cell_12_voltage_set(BMS_GetCellVoltage(baseCellIndex + 3));
            break;
        case 3: // M3: cells 13-16
            CAN_bms_cellVoltages_M3_cell_13_voltage_set(BMS_GetCellVoltage(baseCellIndex));
            CAN_bms_cellVoltages_M3_cell_14_voltage_set(BMS_GetCellVoltage(baseCellIndex + 1));
            CAN_bms_cellVoltages_M3_cell_15_voltage_set(BMS_GetCellVoltage(baseCellIndex + 2));
            CAN_bms_cellVoltages_M3_cell_16_voltage_set(BMS_GetCellVoltage(baseCellIndex + 3));
            break;
        case 4: // M4: cells 17-20
            CAN_bms_cellVoltages_M4_cell_17_voltage_set(BMS_GetCellVoltage(baseCellIndex));
            CAN_bms_cellVoltages_M4_cell_18_voltage_set(BMS_GetCellVoltage(baseCellIndex + 1));
            CAN_bms_cellVoltages_M4_cell_19_voltage_set(BMS_GetCellVoltage(baseCellIndex + 2));
            CAN_bms_cellVoltages_M4_cell_20_voltage_set(BMS_GetCellVoltage(baseCellIndex + 3));
            break;
        case 5: // M5: cells 21-24
            CAN_bms_cellVoltages_M5_cell_21_voltage_set(BMS_GetCellVoltage(baseCellIndex));
            CAN_bms_cellVoltages_M5_cell_22_voltage_set(BMS_GetCellVoltage(baseCellIndex + 1));
            CAN_bms_cellVoltages_M5_cell_23_voltage_set(BMS_GetCellVoltage(baseCellIndex + 2));
            CAN_bms_cellVoltages_M5_cell_24_voltage_set(BMS_GetCellVoltage(baseCellIndex + 3));
            break;
        default:
            // Invalid multiplex value, do nothing
            break;
    }
    
    // Increment for next time
    cellVoltageMultiPlex++;
    if (cellVoltageMultiPlex >= 6){
        cellVoltageMultiPlex = 0;
    }
    
    uint16_t voltage = EV_CHARGER_get_charge_voltage()*10;
    uint16_t current = EV_CHARGER_get_charge_current()*10;
    CAN_bms_charger_request_output_voltage_low_byte_set(voltage);
    CAN_bms_charger_request_output_voltage_high_byte_set(voltage>>8);
    CAN_bms_charger_request_output_current_low_byte_set(current);
    CAN_bms_charger_request_output_current_high_byte_set(current>>8);
    CAN_bms_charger_request_charge_mode_set(0); //always set to charing mode, not heating
    CAN_bms_charger_request_start_charge_not_request_set(EV_CHARGER_get_bms_request_charge()); //inverted logic. 1 means stop charging
    
    float pack_voltage1  = LTC6802_get_temp_voltage(2);
    float pack_voltage2 = LTC6802_get_temp_voltage(5);
    CAN_bms_status_packVoltage_set((pack_voltage1 + pack_voltage2)*20.119);
    CAN_bms_debug_float1_set(pack_voltage1);
    CAN_bms_debug_float2_set(pack_voltage2);
    
    CAN_bms_cellTemperaturs_M0_temp_1_set(IO_GET_MUX_1_VOLTAGE()*10);
    CAN_bms_cellTemperaturs_M0_temp_2_set(IO_GET_MUX_2_VOLTAGE()*10);
    CAN_bms_cellTemperaturs_M0_temp_3_set(IO_GET_MUX_3_VOLTAGE()*10);
}
        