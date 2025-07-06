/**
 * @file spi_test.h
 * @brief SPI Test Module for debugging buffered SPI functionality
 * 
 * This module generates various SPI traffic patterns to test and debug
 * the buffered SPI implementation and FIFO optimizations.
 * 
 * @author Generated for Voltworks Garage
 * @date 2025
 */

#ifndef SPI_TEST_H
#define SPI_TEST_H

#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Configuration
 *******************************************************************************/
#define SPI_TEST_ENABLE_DEBUG_PRINTS    1    // Enable debug output
#define SPI_TEST_AUTO_MODE              1    // Automatically cycle through tests
#define SPI_TEST_MANUAL_MODE            0    // Manual test control

/******************************************************************************
 * Test Types
 *******************************************************************************/
typedef enum {
    SPI_TEST_OFF = 0,
    SPI_TEST_SINGLE_BYTE,           // Single byte transactions
    SPI_TEST_SMALL_BURST,           // 2-4 byte transactions  
    SPI_TEST_MEDIUM_BURST,          // 8-12 byte transactions
    SPI_TEST_LARGE_BURST,           // 16-24 byte transactions
    SPI_TEST_READ_ONLY,             // RX only with dummy TX
    SPI_TEST_WRITE_ONLY,            // TX only, ignore RX
    SPI_TEST_STRESS_TEST,           // Rapid back-to-back transactions
    SPI_TEST_PATTERN_VERIFY,        // Known patterns with verification
    SPI_TEST_MAX_THROUGHPUT,        // Maximum data rate test
    SPI_TEST_ERROR_RECOVERY,        // Test timeout and error handling
    SPI_TEST_COUNT
} SPI_Test_Type_E;

/******************************************************************************
 * Function Declarations
 *******************************************************************************/

/**
 * @brief Initialize the SPI test module
 */
void SPI_Test_Init(void);

/**
 * @brief Run SPI test operations (call from task scheduler)
 * @param enable_tests true to run tests, false to stop
 */
void SPI_Test_Run(bool enable_tests);

/**
 * @brief Set specific test to run
 * @param test_type Type of test to execute
 */
void SPI_Test_SetMode(SPI_Test_Type_E test_type);

/**
 * @brief Get current test status
 * @return Current test type being executed
 */
SPI_Test_Type_E SPI_Test_GetCurrentMode(void);

/**
 * @brief Get test statistics
 * @param total_tests Pointer to store total test count
 * @param passed_tests Pointer to store passed test count  
 * @param failed_tests Pointer to store failed test count
 */
void SPI_Test_GetStats(uint32_t* total_tests, uint32_t* passed_tests, uint32_t* failed_tests);

/**
 * @brief Reset test statistics
 */
void SPI_Test_ResetStats(void);

/**
 * @brief Print test results and statistics
 */
void SPI_Test_PrintResults(void);

/**
 * @brief Check if a test is currently running
 * @return true if test active, false if idle
 */
bool SPI_Test_IsActive(void);

/**
 * @brief Manual trigger for single test
 * @param test_type Test to run once
 * @return true if test started, false if busy
 */
bool SPI_Test_TriggerSingle(SPI_Test_Type_E test_type);

#endif // SPI_TEST_H