/**
 * @file ltc6802_1_example.c
 * @brief Example usage of the non-blocking LTC6802-1 driver
 * 
 * This file demonstrates how to integrate the LTC6802-1 non-blocking driver
 * into your BMS application. It shows the proper usage patterns and
 * how to handle asynchronous operations.
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#include "ltc6802_1_nb.h"
#include "ltc6802_1_example.h"
#include "SysTick.h"
#include <stdio.h>

/******************************************************************************
 * Private Function Prototypes
 *******************************************************************************/
static void ProcessMeasurementData(void);

/******************************************************************************
 * Example Usage State Machine
 *******************************************************************************/
typedef enum {
    EXAMPLE_STATE_INIT = 0,
    EXAMPLE_STATE_CONFIG,
    EXAMPLE_STATE_START_VOLTAGE_ADC,
    EXAMPLE_STATE_READ_VOLTAGES,
    EXAMPLE_STATE_START_TEMP_ADC,
    EXAMPLE_STATE_READ_TEMPERATURES,
    EXAMPLE_STATE_PROCESS_DATA,
    EXAMPLE_STATE_IDLE,
    EXAMPLE_STATE_ERROR
} ExampleState_E;

static ExampleState_E example_state = EXAMPLE_STATE_INIT;
static uint32_t last_measurement_time = 0;
static bool measurement_complete = false;

// Storage for latest measurements
static float cell_voltages[LTC6802_1_TOTAL_CELLS];
static float temperatures[LTC6802_1_TOTAL_TEMPS];

/******************************************************************************
 * Callback function for LTC6802-1 operations
 *******************************************************************************/
static void LTC6802_OperationComplete(LTC6802_1_Operation_E operation, 
                                     LTC6802_1_Error_E error, 
                                     uint8_t stack_id) {
    
    if (error != LTC6802_1_ERROR_NONE) {
        printf("LTC6802-1 Error: Operation %d failed with error %d on stack %d\n", 
               operation, error, stack_id);
        example_state = EXAMPLE_STATE_ERROR;
        return;
    }
    
    switch (operation) {
        case LTC6802_1_OP_WRITE_CONFIG:
            printf("Configuration written successfully\n");
            example_state = EXAMPLE_STATE_START_VOLTAGE_ADC;
            break;
            
        case LTC6802_1_OP_START_ADC_VOLTAGES:
            printf("Voltage ADC started, reading voltages...\n");
            example_state = EXAMPLE_STATE_READ_VOLTAGES;
            break;
            
        case LTC6802_1_OP_READ_VOLTAGES:
            printf("Voltage reading complete\n");
            example_state = EXAMPLE_STATE_START_TEMP_ADC;
            break;
            
        case LTC6802_1_OP_START_ADC_TEMPERATURES:
            printf("Temperature ADC started, reading temperatures...\n");
            example_state = EXAMPLE_STATE_READ_TEMPERATURES;
            break;
            
        case LTC6802_1_OP_READ_TEMPERATURES:
            printf("Temperature reading complete\n");
            example_state = EXAMPLE_STATE_PROCESS_DATA;
            measurement_complete = true;
            break;
            
        default:
            break;
    }
}

/******************************************************************************
 * Public Functions
 *******************************************************************************/

void LTC6802_Example_Init(void) {
    // Initialize the LTC6802-1 module
    LTC6802_1_Error_E error = LTC6802_1_Init();
    if (error != LTC6802_1_ERROR_NONE) {
        printf("Failed to initialize LTC6802-1: %d\n", error);
        example_state = EXAMPLE_STATE_ERROR;
        return;
    }
    
    // Register our callback
    LTC6802_1_RegisterCallback(LTC6802_OperationComplete);
    
    // Configure each stack
    LTC6802_1_Config_S config;
    config.adc_mode = 1;  // Normal ADC mode
    config.temp_enable = 1;  // Enable temperature measurement
    config.discharge_cells = 0;  // No cell balancing initially
    config.forced_cells = 0;
    config.overvoltage_threshold = (uint16_t)(4.2f / LTC6802_1_VOLTAGE_SCALE_FACTOR);
    config.undervoltage_threshold = (uint16_t)(2.5f / LTC6802_1_VOLTAGE_SCALE_FACTOR);
    
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        error = LTC6802_1_SetConfig(i, &config);
        if (error != LTC6802_1_ERROR_NONE) {
            printf("Failed to set config for stack %d: %d\n", i, error);
            example_state = EXAMPLE_STATE_ERROR;
            return;
        }
    }
    
    example_state = EXAMPLE_STATE_CONFIG;
    printf("LTC6802-1 Example initialized\n");
}

void LTC6802_Example_Run(void) {
    // Always run the LTC6802-1 state machine
    LTC6802_1_Run();
    
    // Run our example state machine
    switch (example_state) {
        case EXAMPLE_STATE_INIT:
            // Initialization should be done via LTC6802_Example_Init()
            break;
            
        case EXAMPLE_STATE_CONFIG:
            // Write configuration to all stacks
            {
                LTC6802_1_Error_E error = LTC6802_1_WriteConfig(0xFF); // Broadcast to all
                if (error == LTC6802_1_ERROR_NONE) {
                    printf("Writing configuration...\n");
                } else {
                    printf("Failed to start config write: %d\n", error);
                    example_state = EXAMPLE_STATE_ERROR;
                }
            }
            break;
            
        case EXAMPLE_STATE_START_VOLTAGE_ADC:
            // Start voltage ADC conversion
            {
                LTC6802_1_Error_E error = LTC6802_1_StartCellVoltageADC(0xFF); // All stacks
                if (error == LTC6802_1_ERROR_NONE) {
                    printf("Starting voltage ADC...\n");
                } else {
                    printf("Failed to start voltage ADC: %d\n", error);
                    example_state = EXAMPLE_STATE_ERROR;
                }
            }
            break;
            
        case EXAMPLE_STATE_READ_VOLTAGES:
            // Read voltage data
            {
                LTC6802_1_Error_E error = LTC6802_1_ReadCellVoltages(0xFF); // All stacks
                if (error != LTC6802_1_ERROR_NONE) {
                    printf("Failed to start voltage read: %d\n", error);
                    example_state = EXAMPLE_STATE_ERROR;
                }
            }
            break;
            
        case EXAMPLE_STATE_START_TEMP_ADC:
            // Start temperature ADC conversion
            {
                LTC6802_1_Error_E error = LTC6802_1_StartTempADC(0xFF); // All stacks
                if (error == LTC6802_1_ERROR_NONE) {
                    printf("Starting temperature ADC...\n");
                } else {
                    printf("Failed to start temperature ADC: %d\n", error);
                    example_state = EXAMPLE_STATE_ERROR;
                }
            }
            break;
            
        case EXAMPLE_STATE_READ_TEMPERATURES:
            // Read temperature data
            {
                LTC6802_1_Error_E error = LTC6802_1_ReadTemperatures(0xFF); // All stacks
                if (error != LTC6802_1_ERROR_NONE) {
                    printf("Failed to start temperature read: %d\n", error);
                    example_state = EXAMPLE_STATE_ERROR;
                }
            }
            break;
            
        case EXAMPLE_STATE_PROCESS_DATA:
            // Process the measurement data
            ProcessMeasurementData();
            example_state = EXAMPLE_STATE_IDLE;
            last_measurement_time = SysTick_Get();
            break;
            
        case EXAMPLE_STATE_IDLE:
            // Wait for next measurement cycle (every 100ms for example)
            if ((SysTick_Get() - last_measurement_time) >= 100) {
                example_state = EXAMPLE_STATE_START_VOLTAGE_ADC;
            }
            break;
            
        case EXAMPLE_STATE_ERROR:
            // Handle error state - could implement recovery logic here
            printf("Example in error state\n");
            break;
    }
}

bool LTC6802_Example_IsReady(void) {
    return (example_state == EXAMPLE_STATE_IDLE && measurement_complete);
}

float LTC6802_Example_GetCellVoltage(uint8_t cell_id) {
    if (cell_id < LTC6802_1_TOTAL_CELLS) {
        return cell_voltages[cell_id];
    }
    return 0.0f;
}

float LTC6802_Example_GetTemperature(uint8_t temp_id) {
    if (temp_id < LTC6802_1_TOTAL_TEMPS) {
        return temperatures[temp_id];
    }
    return 0.0f;
}

void LTC6802_Example_EnableCellBalancing(uint8_t cell_id, bool enable) {
    LTC6802_1_Error_E error = LTC6802_1_SetCellBalancing(cell_id, enable);
    if (error == LTC6802_1_ERROR_NONE) {
        // Write the updated configuration
        uint8_t stack_id = cell_id / LTC6802_1_CELLS_PER_STACK;
        LTC6802_1_WriteConfig(stack_id);
    }
}

void LTC6802_Example_PrintDiagnostics(void) {
    uint32_t total_trans, failed_trans, retries;
    LTC6802_1_GetStats(&total_trans, &failed_trans, &retries);
    
    printf("=== LTC6802-1 Diagnostics ===\n");
    printf("State: %d\n", LTC6802_1_GetState());
    printf("Busy: %s\n", LTC6802_1_IsBusy() ? "Yes" : "No");
    printf("Total Transactions: %lu\n", total_trans);
    printf("Failed Transactions: %lu\n", failed_trans);
    printf("Retries: %lu\n", retries);
    
    if (total_trans > 0) {
        printf("Success Rate: %.1f%%\n", 
               100.0f * (total_trans - failed_trans) / total_trans);
    }
    
    // Print last errors for each stack
    for (uint8_t i = 0; i < LTC6802_1_NUM_STACKS; i++) {
        LTC6802_1_Error_E error = LTC6802_1_GetLastError(i);
        if (error != LTC6802_1_ERROR_NONE) {
            printf("Stack %d Error: %d\n", i, error);
        }
    }
    printf("===========================\n");
}

/******************************************************************************
 * Private Functions
 *******************************************************************************/

static void ProcessMeasurementData(void) {
    printf("=== Processing Measurement Data ===\n");
    
    // Read all cell voltages
    float min_voltage = 5.0f;
    float max_voltage = 0.0f;
    float total_voltage = 0.0f;
    
    for (uint8_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
        cell_voltages[i] = LTC6802_1_GetCellVoltage(i);
        total_voltage += cell_voltages[i];
        
        if (cell_voltages[i] < min_voltage) min_voltage = cell_voltages[i];
        if (cell_voltages[i] > max_voltage) max_voltage = cell_voltages[i];
        
        printf("Cell %2d: %.3fV\n", i, cell_voltages[i]);
    }
    
    // Read all temperatures
    for (uint8_t i = 0; i < LTC6802_1_TOTAL_TEMPS; i++) {
        temperatures[i] = LTC6802_1_GetTemperatureVoltage(i);
        printf("Temp %d: %.3fV\n", i, temperatures[i]);
    }
    
    printf("Pack Voltage: %.2fV\n", total_voltage);
    printf("Min Cell: %.3fV, Max Cell: %.3fV\n", min_voltage, max_voltage);
    printf("Cell Delta: %.3fV\n", max_voltage - min_voltage);
    
    // Simple balancing logic example
    if ((max_voltage - min_voltage) > 0.010f) { // 10mV delta threshold
        printf("Cell imbalance detected, enabling balancing\n");
        for (uint8_t i = 0; i < LTC6802_1_TOTAL_CELLS; i++) {
            if (cell_voltages[i] > (min_voltage + 0.005f)) {
                LTC6802_Example_EnableCellBalancing(i, true);
            }
        }
    } else {
        // Clear all balancing
        LTC6802_1_ClearAllCellBalancing();
    }
    
    printf("================================\n");
}