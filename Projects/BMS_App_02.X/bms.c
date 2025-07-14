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
    LTC6802_1_Config_S config = {
        .adc_mode = 1,  // Normal ADC mode for accuracy
        .temp_enable = 1,  // Enable temperature measurement
        .discharge_cells = 0,  // Cell balancing controlled separately
        .forced_cells = 0,
        .overvoltage_threshold = (uint16_t)(4.2f / LTC6802_1_VOLTAGE_SCALE_FACTOR),
        .undervoltage_threshold = (uint16_t)(2.5f / LTC6802_1_VOLTAGE_SCALE_FACTOR)
    };
    
    // Apply configuration (non-blocking)
    LTC6802_1_WriteConfig(&config);
    
    bms_ltc_state = BMS_LTC_STATE_IDLE;
}

void BMS_Run_1ms(void) {
    // Always run the stateful driver state machine
    LTC6802_1_Run();
}

void BMS_Run_10ms(void) {
    switch (bms_ltc_state) {
        case BMS_LTC_STATE_IDLE:
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
            bms_ltc_state = BMS_LTC_STATE_IDLE;
            break;
    }
}

bool BMS_IsDataReady(void) {
    return (bms_ltc_state == BMS_LTC_STATE_DATA_COMPLETE);
}

float BMS_GetCellVoltage(uint8_t cell_id) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetCellVoltage(cell_id);
}

float BMS_GetTemperatureVoltage(uint8_t temp_id) {
    // Direct pass-through to driver with staleness detection
    return LTC6802_1_GetTemperatureVoltage(temp_id);
}

void BMS_SetCellBalancing(uint8_t cell_id, bool enable) {
    if (cell_id >= LTC6802_1_TOTAL_CELLS) {
        return;
    }
    
    // Update local balancing mask
    if (enable) {
        balancing_mask |= (1UL << cell_id);
    } else {
        balancing_mask &= ~(1UL << cell_id);
    }
    
    // Apply to driver (non-blocking)
    LTC6802_1_SetCellBalancing(balancing_mask);
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