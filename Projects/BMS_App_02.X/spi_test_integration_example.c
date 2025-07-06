/**
 * @file spi_test_integration_example.c
 * @brief Example integration of SPI test module into task scheduler
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#include "spi_test.h"
#include "SysTick.h"

// Example task scheduler integration
void BMS_Run_10ms(void) {
    static uint32_t spi_test_counter = 0;
    
    // Your existing BMS tasks...
    // LTC6802_1_Run();
    // other_bms_tasks();
    
    // Run SPI test every 10ms when enabled
    // Enable/disable based on debug mode or switch
    bool enable_spi_tests = true; // Set based on your debug configuration
    
    SPI_Test_Run(enable_spi_tests);
    
    // Print results every 5 seconds (500 x 10ms)
    spi_test_counter++;
    if (spi_test_counter >= 500) {
        SPI_Test_PrintResults();
        spi_test_counter = 0;
    }
}

// Example initialization
void System_Init(void) {
    // Your existing initialization...
    // spi1Init();
    // LTC6802_1_Init();
    
    // Initialize SPI test module
    SPI_Test_Init();
}

// Example debug commands (if you have a CLI)
void ProcessDebugCommand(const char* command) {
    if (strcmp(command, "spi_test_single") == 0) {
        SPI_Test_TriggerSingle(SPI_TEST_SINGLE_BYTE);
    }
    else if (strcmp(command, "spi_test_burst") == 0) {
        SPI_Test_TriggerSingle(SPI_TEST_MEDIUM_BURST);
    }
    else if (strcmp(command, "spi_test_stress") == 0) {
        SPI_Test_TriggerSingle(SPI_TEST_STRESS_TEST);
    }
    else if (strcmp(command, "spi_test_results") == 0) {
        SPI_Test_PrintResults();
    }
    else if (strcmp(command, "spi_test_reset") == 0) {
        SPI_Test_ResetStats();
    }
}