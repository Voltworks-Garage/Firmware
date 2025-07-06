/**
 * @file bms_ltc6802_1_integration.c
 * @brief Integration example for LTC6802-1 in BMS application
 * 
 * This shows how to replace the old blocking LTC6802-2 code with the new
 * non-blocking LTC6802-1 driver in your BMS_Run_10ms() function.
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#include "ltc6802_1_nb.h"
#include "bms.h"
#include "SysTick.h"

/******************************************************************************
 * Integration State Management
 *******************************************************************************/
typedef enum {
    BMS_LTC_STATE_IDLE = 0,
    BMS_LTC_STATE_VOLTAGE_PENDING,
    BMS_LTC_STATE_TEMP_PENDING,
    BMS_LTC_STATE_DATA_READY
} BMS_LTC_State_E;

static BMS_LTC_State_E bms_ltc_state = BMS_LTC_STATE_IDLE;
static uint32_t last_measurement_time = 0;
static bool ltc_data_ready = false;

// Storage for BMS integration
static float bms_cell_voltages[LTC6802_1_TOTAL_CELLS];
static float bms_temperatures[LTC6802_1_TOTAL_TEMPS];

/******************************************************************************
 * Callback for LTC6802-1 Operations
 *******************************************************************************/
static void BMS_LTC6802_Callback(LTC6802_1_Operation_E operation, 
                                LTC6802_1_Error_E error, 
                                uint8_t stack_id) {
    if (error != LTC6802_1_ERROR_NONE) {
        // Handle error - could set BMS fault flags here
        // For now, just retry on next cycle
        bms_ltc_state = BMS_LTC_STATE_IDLE;
        return;
    }
    
    switch (operation) {
        case LTC6802_1_OP_START_ADC_VOLTAGES:
            // Voltage ADC started, now read the data
            LTC6802_1_ReadCellVoltages(0xFF);
            break;
            
        case LTC6802_1_OP_READ_VOLTAGES:
            // Voltage data ready, start temperature measurement
            bms_ltc_state = BMS_LTC_STATE_TEMP_PENDING;
            LTC6802_1_StartTempADC(0xFF);
            break;
            
        case LTC6802_1_OP_START_ADC_TEMPERATURES:
            // Temperature ADC started, now read the data
            LTC6802_1_ReadTemperatures(0xFF);
            break;
            
        case LTC6802_1_OP_READ_TEMPERATURES:
            // All data ready, copy to BMS arrays
            for (uint8_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
                bms_cell_voltages[i] = LTC6802_1_GetCellVoltage(i);
            }
            for (uint8_t i = 0; i < LTC6802_1_TOTAL_TEMPS; i++) {
                bms_temperatures[i] = LTC6802_1_GetTemperatureVoltage(i);
            }
            
            bms_ltc_state = BMS_LTC_STATE_DATA_READY;
            ltc_data_ready = true;
            last_measurement_time = SysTick_Get();
            break;
            
        default:
            break;
    }
}

/******************************************************************************
 * BMS Integration Functions
 *******************************************************************************/

/**
 * @brief Initialize LTC6802-1 for BMS use
 * Call this from BMS_Init()
 */
void BMS_LTC6802_Init(void) {
    // Initialize the LTC6802-1 module
    LTC6802_1_Init();
    
    // Register our callback
    LTC6802_1_RegisterCallback(BMS_LTC6802_Callback);
    
    // Configure for BMS operation
    LTC6802_1_Config_S config = {
        .adc_mode = 1,  // Normal ADC mode for accuracy
        .temp_enable = 1,  // Enable temperature measurement
        .discharge_cells = 0,  // Cell balancing controlled separately
        .forced_cells = 0,
        .overvoltage_threshold = (uint16_t)(4.2f / LTC6802_1_VOLTAGE_SCALE_FACTOR),
        .undervoltage_threshold = (uint16_t)(2.5f / LTC6802_1_VOLTAGE_SCALE_FACTOR)
    };
    
    // Apply configuration to all stacks
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        LTC6802_1_SetConfig(i, &config);
    }
    
    // Write initial configuration
    LTC6802_1_WriteConfig(0xFF);
}

/**
 * @brief Run LTC6802-1 operations
 * Call this from your 1ms task (NOT 10ms task for best performance)
 */
void BMS_LTC6802_Run_1ms(void) {
    // Always run the LTC6802-1 state machine
    LTC6802_1_Run();
}

/**
 * @brief Handle LTC6802-1 in BMS 10ms task
 * This replaces your old blocking BMS_Run_10ms() LTC6802 code
 */
void BMS_LTC6802_Run_10ms(void) {
    switch (bms_ltc_state) {
        case BMS_LTC_STATE_IDLE:
            // Start new measurement cycle every 10ms
            if (LTC6802_1_StartCellVoltageADC(0xFF) == LTC6802_1_ERROR_NONE) {
                bms_ltc_state = BMS_LTC_STATE_VOLTAGE_PENDING;
                ltc_data_ready = false;
            }
            break;
            
        case BMS_LTC_STATE_VOLTAGE_PENDING:
        case BMS_LTC_STATE_TEMP_PENDING:
            // Waiting for measurements to complete
            // LTC6802_1_Run() handles the async operations
            break;
            
        case BMS_LTC_STATE_DATA_READY:
            // Data is ready, process it (this is your old synchronous code)
            BMS_ProcessVoltageData();
            BMS_ProcessTemperatureData();
            
            // Reset for next cycle
            bms_ltc_state = BMS_LTC_STATE_IDLE;
            break;
    }
}

/**
 * @brief Check if fresh LTC6802-1 data is available
 * @return true if new data is ready
 */
bool BMS_LTC6802_IsDataReady(void) {
    return ltc_data_ready;
}

/**
 * @brief Get cell voltage (replacement for LTC6802_get_cell_voltage)
 * @param cell_id Cell ID (0-23)
 * @return Voltage in volts
 */
float BMS_GetCellVoltage(uint8_t cell_id) {
    if (cell_id < LTC6802_1_TOTAL_CELLS) {
        return bms_cell_voltages[cell_id];
    }
    return 0.0f;
}

/**
 * @brief Get temperature voltage (replacement for LTC6802_get_temp_voltage)
 * @param temp_id Temperature ID (0-3)
 * @return Temperature voltage in volts
 */
float BMS_GetTemperatureVoltage(uint8_t temp_id) {
    if (temp_id < LTC6802_1_TOTAL_TEMPS) {
        return bms_temperatures[temp_id];
    }
    return 0.0f;
}

/**
 * @brief Enable cell balancing (replacement for LTC6802_set_cell_discharge)
 * @param cell_id Cell ID (0-23)
 * @param enable true to enable, false to disable
 */
void BMS_SetCellBalancing(uint8_t cell_id, bool enable) {
    LTC6802_1_SetCellBalancing(cell_id, enable);
    
    // Write configuration asynchronously
    uint8_t stack_id = cell_id / LTC6802_1_CELLS_PER_STACK;
    LTC6802_1_WriteConfig(stack_id);
}

/**
 * @brief Disable all cell balancing
 */
void BMS_ClearAllCellBalancing(void) {
    LTC6802_1_ClearAllCellBalancing();
    
    // Write configuration to all stacks
    LTC6802_1_WriteConfig(0xFF);
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
#endif

/**
 * NEW NON-BLOCKING CODE:
 * CPU usage distributed across multiple 1ms cycles
 */
void BMS_Run_10ms(void) {
    // Non-blocking LTC6802-1 operations
    BMS_LTC6802_Run_10ms();
    
    // Only process data when it's actually ready
    if (BMS_LTC6802_IsDataReady()) {
        // Your existing BMS processing code here
        BMS_ProcessVoltageData();
        BMS_ProcessTemperatureData();
        BMS_CheckSafety();
        BMS_UpdateBalancing();
    }
    
    // Rest of your BMS_Run_10ms code...
    EV_CHARGER_Run_10ms();
    CAN_bms_debug_CPU_USAGE_set(SysTick_GetCPUPercentage());
    CAN_bms_debug_CPU_peak_set(SysTick_GetCPUPeak());
    CAN_populate_10ms();
    CAN_send_10ms();
}

/**
 * IMPORTANT: Add this to your 1ms task for best performance
 */
void Tsk_1ms(void) {
    run_iso_tp_1ms();
    DCDC_run_1ms();
    CAN_populate_1ms();
    
    // Add this line for non-blocking LTC6802-1
    BMS_LTC6802_Run_1ms();
}