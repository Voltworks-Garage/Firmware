/**
 * @file bms.c
 * @brief BMS application implementation using stateful LTC6802-1 driver
 * 
 * This provides a clean interface between the BMS application and the
 * stateful LTC6802-1 driver. No callbacks, just simple request/response.
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#include "bms.h"
#include "ltc6802_1_nb.h"
#include "SysTick.h"

/******************************************************************************
 * Integration State Management
 *******************************************************************************/
typedef enum {
    BMS_LTC_STATE_IDLE = 0,
    BMS_LTC_STATE_START,
    BMS_LTC_STATE_VOLTAGE_REQUESTED,
    BMS_LTC_STATE_VOLTAGE_READY,
    BMS_LTC_STATE_TEMP_REQUESTED,
    BMS_LTC_STATE_DATA_COMPLETE
} BMS_LTC_State_E;

static BMS_LTC_State_E bms_ltc_state = BMS_LTC_STATE_IDLE;
static uint32_t cycle_start_time = 0;
static uint32_t balancing_mask = 0;

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

void BMS_Init(void) {
    // Initialize the stateful LTC6802-1 driver
    LTC6802_1_Init();
    
    // Configure for BMS operation with safe defaults
    
    // Reset to safe defaults first
    LTC6802_1_ResetConfigToDefaults(false);
    
    // Set voltage thresholds for safe BMS operation
    // 4.2V overvoltage, 2.5V undervoltage (converted to millivolts)
    LTC6802_1_SetVoltageThresholds(4200, 2500, false);
    
    // Enable monitoring for all 12 cells on both stacks
    LTC6802_1_SetCellMonitoring(LTC6802_1_ALL_STACKS, 0x0FFF, false);
    
    // Set ADC mode to normal for balanced speed/accuracy
    LTC6802_1_SetADCMode(LTC6802_1_ADC_MODE_NORMAL, false);
    
    // Configure GPIO pins as inputs initially
    LTC6802_1_SetGPIO1(LTC6802_1_ALL_STACKS, true, false);
    
    // Enable temperature measurement
    LTC6802_1_EnableTemperature(true, false);
    
    // Enable voltage comparison for fault detection
    LTC6802_1_EnableVoltageComparison(LTC6802_1_ALL_STACKS, true, false);
    
    // Send all configuration changes to hardware
    LTC6802_1_SendConfig();
    
    bms_ltc_state = BMS_LTC_STATE_IDLE;
}

void BMS_Run_1ms(void) {
    // Always run the stateful driver state machine
    LTC6802_1_Run();
}

void BMS_Run_10ms(void) {
    switch (bms_ltc_state) {
        case BMS_LTC_STATE_IDLE:

            LTC6802_1_SetGPIO1(0, true, false);
            LTC6802_1_SetGPIO1(1, true, true);
            bms_ltc_state = BMS_LTC_STATE_START;
            break;

        case BMS_LTC_STATE_START:
            // Start new measurement cycle every 10ms if driver is ready
            if (LTC6802_1_StartCellVoltageADC() == LTC6802_1_ERROR_NONE) {
                bms_ltc_state = BMS_LTC_STATE_VOLTAGE_REQUESTED;
                cycle_start_time = SysTick_Get();
            }
            // If busy, just wait for next 10ms cycle

            break;

        case BMS_LTC_STATE_VOLTAGE_REQUESTED:
            // Check if voltage data is ready
            if (!LTC6802_1_IsBusy()) {
                // Driver completed voltage operation, now start temperature
                if (LTC6802_1_StartTemperatureADC() == LTC6802_1_ERROR_NONE) {
                    bms_ltc_state = BMS_LTC_STATE_TEMP_REQUESTED;
                } else {
                    // Driver still busy, retry next cycle
                    bms_ltc_state = BMS_LTC_STATE_IDLE;
                }
            }
            break;
            
        case BMS_LTC_STATE_TEMP_REQUESTED:
            // Check if temperature data is ready
            if (!LTC6802_1_IsBusy()) {
                // Both voltage and temperature data are now available
                bms_ltc_state = BMS_LTC_STATE_DATA_COMPLETE;
            }
            break;
            
        case BMS_LTC_STATE_DATA_COMPLETE:
            // Data is ready for BMS processing
            // Reset for next cycle
            LTC6802_1_SetGPIO1(0, false, false);
            LTC6802_1_SetGPIO1(1, false, true);
            bms_ltc_state = BMS_LTC_STATE_IDLE;
            break;
    }
}

bool BMS_IsDataReady(void) {
    return (bms_ltc_state == BMS_LTC_STATE_DATA_COMPLETE);
}

uint16_t BMS_GetCellVoltage(uint8_t cell_id) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetCellVoltage(cell_id);
}

float BMS_GetTemperatureVoltage(uint8_t temp_id) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetTemperatureVoltage(temp_id);
}

void BMS_SetCellBalancing(uint8_t cell_id, bool enable, bool send_immediately) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return;
    }
    
    // Update local balancing mask
    if (enable) {
        balancing_mask |= (1UL << cell_id);
    } else {
        balancing_mask &= ~(1UL << cell_id);
    }
    
    // Apply to driver (non-blocking) using new API
    LTC6802_1_SetCellBalancing(cell_id, enable, send_immediately);
}

void BMS_ClearAllCellBalancing(void) {
    balancing_mask = 0;
    LTC6802_1_ClearAllCellBalancing();
}

/******************************************************************************
 * Migration Example - Before and After
 *******************************************************************************/

#if 0
/**
 * OLD BLOCKING CODE (from your original BMS_Run_10ms):
 * This would cause ~65% CPU spikes
 */
void OLD_BMS_Run_10ms(void) {
    // Start ADC conversion (blocking)
    LTC6802_StartAllCellADC();
    
    // Poll for completion (blocking)
    while(LTC6802_check_ADC_status() != 0) {
        // CPU is blocked here waiting
    }
    
    // Read data (blocking)
    LTC6802_ReadAllCellADC();
    
    // Process voltages immediately
    for (uint8_t i = 0; i < 24; i++) {
        cell_voltages[i] = LTC6802_get_cell_voltage(i);
    }
    
    // Same for temperatures...
    LTC6802_StartAllTempADC();
    while(LTC6802_check_ADC_status() != 0) {
        // More blocking
    }
    LTC6802_ReadAllTempADC();
    // etc...
}

/**
 * EXAMPLE: How you would use the new BMS API in your application:
 */
void EXAMPLE_BMS_Processing(void) {
    // The BMS_Run_10ms() function above handles the driver automatically
    
    // Only process data when it's actually ready
    if (BMS_IsDataReady()) {
        // Your existing BMS processing code here
        for (uint8_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
            float voltage = BMS_GetCellVoltage(i);
            if (voltage > 0.0f) {
                // Process valid voltage data
                // cell_voltages[i] = voltage;
            }
        }
        
        for (uint8_t i = 0; i < LTC6802_1_TOTAL_TEMPS; i++) {
            float temp_voltage = BMS_GetTemperatureVoltage(i);
            if (temp_voltage > 0.0f) {
                // Process valid temperature data
                // temp_voltages[i] = temp_voltage;
            }
        }
        
        // Your existing BMS safety and balancing logic
        // BMS_CheckSafety();
        // BMS_UpdateBalancing();
    }
    
    // Rest of your existing BMS_Run_10ms code...
}

/**
 * IMPORTANT: Add this to your 1ms task for best performance
 */
void Tsk_1ms(void) {
    run_iso_tp_1ms();
    DCDC_run_1ms();
    CommandService_Run();
    CAN_populate_1ms();
    
    // Add this line for non-blocking LTC6802-1
    BMS_Run_1ms();
}
#endif