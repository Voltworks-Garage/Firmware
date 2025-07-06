/**
 * @file spi_test.c
 * @brief SPI Test Module Implementation
 * 
 * @author Generated for Voltworks Garage  
 * @date 2025
 */

#include "spi_test.h"
#include "spi.h"
#include "IO.h"
#include "SysTick.h"
#include <string.h>

#if SPI_TEST_ENABLE_DEBUG_PRINTS
#include <stdio.h>
#define SPI_TEST_PRINT(...) printf(__VA_ARGS__)
#else
#define SPI_TEST_PRINT(...) 
#endif

/******************************************************************************
 * Test Configuration
 *******************************************************************************/
#define SPI_TEST_MAX_BUFFER_SIZE    32
#define SPI_TEST_TIMEOUT_MS         100
#define SPI_TEST_DELAY_BETWEEN_MS   50
#define SPI_TEST_AUTO_CYCLE_TIME_MS 2000

// Test patterns
static const uint8_t test_pattern_ascending[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07};
static const uint8_t test_pattern_descending[] = {0xFF, 0xFE, 0xFD, 0xFC, 0xFB, 0xFA, 0xF9, 0xF8};
static const uint8_t test_pattern_alternating[] = {0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55};
static const uint8_t test_pattern_walking[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};

/******************************************************************************
 * Internal State
 *******************************************************************************/
typedef struct {
    SPI_Test_Type_E current_test;
    SPI_Test_Type_E next_test;
    bool test_active;
    bool auto_mode;
    uint32_t test_start_time;
    uint32_t last_test_time;
    
    // Test buffers
    uint8_t tx_buffer[SPI_TEST_MAX_BUFFER_SIZE];
    uint8_t rx_buffer[SPI_TEST_MAX_BUFFER_SIZE];
    uint8_t expected_buffer[SPI_TEST_MAX_BUFFER_SIZE];
    
    // Current test parameters
    uint8_t test_length;
    uint8_t test_iteration;
    uint8_t max_iterations;
    
    // Statistics
    uint32_t total_tests;
    uint32_t passed_tests;
    uint32_t failed_tests;
    uint32_t timeout_errors;
    
} SPI_Test_Module_S;

static SPI_Test_Module_S spi_test;

/******************************************************************************
 * Test Names for Debug Output
 *******************************************************************************/
static const char* test_names[] = {
    "OFF",
    "SINGLE_BYTE", 
    "SMALL_BURST",
    "MEDIUM_BURST",
    "LARGE_BURST",
    "READ_ONLY",
    "WRITE_ONLY", 
    "STRESS_TEST",
    "PATTERN_VERIFY",
    "MAX_THROUGHPUT",
    "ERROR_RECOVERY"
};

/******************************************************************************
 * Internal Function Prototypes
 *******************************************************************************/
static void StartTest(SPI_Test_Type_E test_type);
static void ProcessTestCompletion(void);
static void PrepareTestData(SPI_Test_Type_E test_type, uint8_t iteration);
static bool VerifyTestData(void);
static void LogTestResult(bool passed);
static void NextAutoTest(void);
static uint32_t GetTestDataLength(SPI_Test_Type_E test_type);

/******************************************************************************
 * Public Function Implementations
 *******************************************************************************/

void SPI_Test_Init(void) {
    // Clear module state
    memset(&spi_test, 0, sizeof(spi_test));
    
    // Set initial state
    spi_test.current_test = SPI_TEST_OFF;
    spi_test.auto_mode = SPI_TEST_AUTO_MODE;
    
    SPI_TEST_PRINT("SPI Test Module Initialized\n");
    SPI_TEST_PRINT("Auto Mode: %s\n", spi_test.auto_mode ? "ON" : "OFF");
}

void SPI_Test_Run(bool enable_tests) {
    if (!enable_tests) {
        spi_test.current_test = SPI_TEST_OFF;
        spi_test.test_active = false;
        return;
    }
    
    // Handle active test completion
    if (spi_test.test_active) {
        if (spi1IsBufferedTransactionComplete()) {
            ProcessTestCompletion();
        }
        // Check for timeout
        else if ((SysTick_Get() - spi_test.test_start_time) > SPI_TEST_TIMEOUT_MS) {
            IO_SET_SPI_CS(HIGH); // Release CS
            spi_test.timeout_errors++;
            SPI_TEST_PRINT("TEST TIMEOUT: %s\n", test_names[spi_test.current_test]);
            LogTestResult(false);
            spi_test.test_active = false;
        }
        return;
    }
    
    // Auto mode cycling
    if (spi_test.auto_mode && spi_test.current_test != SPI_TEST_OFF) {
        if ((SysTick_Get() - spi_test.last_test_time) > SPI_TEST_DELAY_BETWEEN_MS) {
            if (spi_test.test_iteration >= spi_test.max_iterations) {
                NextAutoTest();
            } else {
                StartTest(spi_test.current_test);
            }
        }
    }
    
    // Start initial test in auto mode
    if (spi_test.auto_mode && spi_test.current_test == SPI_TEST_OFF) {
        spi_test.current_test = SPI_TEST_SINGLE_BYTE;
        StartTest(spi_test.current_test);
    }
}

void SPI_Test_SetMode(SPI_Test_Type_E test_type) {
    if (!spi_test.test_active) {
        spi_test.current_test = test_type;
        spi_test.auto_mode = false;
        if (test_type != SPI_TEST_OFF) {
            StartTest(test_type);
        }
        SPI_TEST_PRINT("SPI Test Mode: %s\n", 
                      (test_type < SPI_TEST_COUNT) ? test_names[test_type] : "INVALID");
    }
}

SPI_Test_Type_E SPI_Test_GetCurrentMode(void) {
    return spi_test.current_test;
}

void SPI_Test_GetStats(uint32_t* total_tests, uint32_t* passed_tests, uint32_t* failed_tests) {
    if (total_tests) *total_tests = spi_test.total_tests;
    if (passed_tests) *passed_tests = spi_test.passed_tests;
    if (failed_tests) *failed_tests = spi_test.failed_tests;
}

void SPI_Test_ResetStats(void) {
    spi_test.total_tests = 0;
    spi_test.passed_tests = 0;
    spi_test.failed_tests = 0;
    spi_test.timeout_errors = 0;
    SPI_TEST_PRINT("SPI Test Statistics Reset\n");
}

void SPI_Test_PrintResults(void) {
    uint32_t success_rate = 0;
    if (spi_test.total_tests > 0) {
        success_rate = (spi_test.passed_tests * 100) / spi_test.total_tests;
    }
    
    SPI_TEST_PRINT("\n=== SPI Test Results ===\n");
    SPI_TEST_PRINT("Current Test: %s\n", test_names[spi_test.current_test]);
    SPI_TEST_PRINT("Total Tests: %lu\n", spi_test.total_tests);
    SPI_TEST_PRINT("Passed: %lu\n", spi_test.passed_tests);
    SPI_TEST_PRINT("Failed: %lu\n", spi_test.failed_tests);
    SPI_TEST_PRINT("Timeouts: %lu\n", spi_test.timeout_errors);
    SPI_TEST_PRINT("Success Rate: %lu%%\n", success_rate);
    SPI_TEST_PRINT("Status: %s\n", spi_test.test_active ? "ACTIVE" : "IDLE");
    SPI_TEST_PRINT("========================\n\n");
}

bool SPI_Test_IsActive(void) {
    return spi_test.test_active;
}

bool SPI_Test_TriggerSingle(SPI_Test_Type_E test_type) {
    if (spi_test.test_active || test_type >= SPI_TEST_COUNT) {
        return false;
    }
    
    spi_test.auto_mode = false;
    spi_test.current_test = test_type;
    StartTest(test_type);
    return true;
}

/******************************************************************************
 * Internal Function Implementations
 *******************************************************************************/

static void StartTest(SPI_Test_Type_E test_type) {
    if (spi_test.test_active) return;
    
    // Prepare test data
    PrepareTestData(test_type, spi_test.test_iteration);
    
    // Get test parameters
    spi_test.test_length = GetTestDataLength(test_type);
    
    uint8_t tx_len = 0;
    uint8_t rx_len = 0;
    uint8_t* tx_ptr = 0;
    uint8_t* rx_ptr = 0;
    
    // Configure transaction based on test type
    switch (test_type) {
        case SPI_TEST_READ_ONLY:
            tx_len = 0;
            rx_len = spi_test.test_length;
            rx_ptr = spi_test.rx_buffer;
            break;
            
        case SPI_TEST_WRITE_ONLY:
            tx_len = spi_test.test_length;
            rx_len = 0;
            tx_ptr = spi_test.tx_buffer;
            break;
            
        default:
            // Normal read/write transaction
            tx_len = spi_test.test_length;
            rx_len = spi_test.test_length;
            tx_ptr = spi_test.tx_buffer;
            rx_ptr = spi_test.rx_buffer;
            break;
    }
    
    // Start SPI transaction
    IO_SET_SPI_CS(LOW);
    spi_test.test_start_time = SysTick_Get();
    
    if (spi1StartBufferedTransaction(tx_ptr, tx_len, rx_ptr, rx_len)) {
        spi_test.test_active = true;
        spi_test.test_iteration++;
        SPI_TEST_PRINT("Started %s test #%d (%d bytes)\n", 
                      test_names[test_type], spi_test.test_iteration, spi_test.test_length);
    } else {
        IO_SET_SPI_CS(HIGH);
        SPI_TEST_PRINT("Failed to start %s test - SPI busy\n", test_names[test_type]);
    }
}

static void ProcessTestCompletion(void) {
    IO_SET_SPI_CS(HIGH);
    spi_test.test_active = false;
    spi_test.last_test_time = SysTick_Get();
    
    uint32_t test_duration = spi_test.last_test_time - spi_test.test_start_time;
    
    // Verify results for applicable tests
    bool test_passed = true;
    
    if (spi_test.current_test == SPI_TEST_PATTERN_VERIFY) {
        test_passed = VerifyTestData();
    }
    
    LogTestResult(test_passed);
    
    SPI_TEST_PRINT("Completed %s test #%d in %lums - %s\n", 
                  test_names[spi_test.current_test], 
                  spi_test.test_iteration,
                  test_duration,
                  test_passed ? "PASS" : "FAIL");
    
    // Print data for debug
    if (spi_test.test_length <= 8) {
        SPI_TEST_PRINT("TX: ");
        for (uint8_t i = 0; i < spi_test.test_length; i++) {
            SPI_TEST_PRINT("%02X ", spi_test.tx_buffer[i]);
        }
        SPI_TEST_PRINT("\nRX: ");
        for (uint8_t i = 0; i < spi_test.test_length; i++) {
            SPI_TEST_PRINT("%02X ", spi_test.rx_buffer[i]);
        }
        SPI_TEST_PRINT("\n");
    }
}

static void PrepareTestData(SPI_Test_Type_E test_type, uint8_t iteration) {
    uint8_t length = GetTestDataLength(test_type);
    
    // Clear buffers
    memset(spi_test.tx_buffer, 0, sizeof(spi_test.tx_buffer));
    memset(spi_test.rx_buffer, 0, sizeof(spi_test.rx_buffer));
    
    switch (test_type) {
        case SPI_TEST_SINGLE_BYTE:
            spi_test.tx_buffer[0] = 0x42 + iteration;
            spi_test.max_iterations = 10;
            break;
            
        case SPI_TEST_SMALL_BURST:
            for (uint8_t i = 0; i < length; i++) {
                spi_test.tx_buffer[i] = 0x10 + i + iteration;
            }
            spi_test.max_iterations = 5;
            break;
            
        case SPI_TEST_MEDIUM_BURST:
            for (uint8_t i = 0; i < length; i++) {
                spi_test.tx_buffer[i] = 0x20 + i + (iteration * 10);
            }
            spi_test.max_iterations = 3;
            break;
            
        case SPI_TEST_LARGE_BURST:
            for (uint8_t i = 0; i < length; i++) {
                spi_test.tx_buffer[i] = 0x30 + (i & 0x0F) + (iteration * 20);
            }
            spi_test.max_iterations = 2;
            break;
            
        case SPI_TEST_PATTERN_VERIFY:
            // Use known patterns
            switch (iteration % 4) {
                case 0:
                    memcpy(spi_test.tx_buffer, test_pattern_ascending, length);
                    memcpy(spi_test.expected_buffer, test_pattern_ascending, length);
                    break;
                case 1:
                    memcpy(spi_test.tx_buffer, test_pattern_descending, length);
                    memcpy(spi_test.expected_buffer, test_pattern_descending, length);
                    break;
                case 2:
                    memcpy(spi_test.tx_buffer, test_pattern_alternating, length);
                    memcpy(spi_test.expected_buffer, test_pattern_alternating, length);
                    break;
                case 3:
                    memcpy(spi_test.tx_buffer, test_pattern_walking, length);
                    memcpy(spi_test.expected_buffer, test_pattern_walking, length);
                    break;
            }
            spi_test.max_iterations = 8;
            break;
            
        case SPI_TEST_STRESS_TEST:
        case SPI_TEST_MAX_THROUGHPUT:
            // Random-ish data
            for (uint8_t i = 0; i < length; i++) {
                spi_test.tx_buffer[i] = (uint8_t)(0x80 + i + iteration + SysTick_Get());
            }
            spi_test.max_iterations = 20;
            break;
            
        case SPI_TEST_READ_ONLY:
        case SPI_TEST_WRITE_ONLY:
            // Simple counter pattern
            for (uint8_t i = 0; i < length; i++) {
                spi_test.tx_buffer[i] = i + iteration;
            }
            spi_test.max_iterations = 5;
            break;
            
        default:
            spi_test.max_iterations = 1;
            break;
    }
}

static bool VerifyTestData(void) {
    for (uint8_t i = 0; i < spi_test.test_length; i++) {
        if (spi_test.rx_buffer[i] != spi_test.expected_buffer[i]) {
            SPI_TEST_PRINT("Data mismatch at byte %d: expected 0x%02X, got 0x%02X\n", 
                          i, spi_test.expected_buffer[i], spi_test.rx_buffer[i]);
            return false;
        }
    }
    return true;
}

static void LogTestResult(bool passed) {
    spi_test.total_tests++;
    if (passed) {
        spi_test.passed_tests++;
    } else {
        spi_test.failed_tests++;
    }
}

static void NextAutoTest(void) {
    spi_test.test_iteration = 0;
    
    // Cycle to next test
    spi_test.current_test++;
    if (spi_test.current_test >= SPI_TEST_COUNT) {
        spi_test.current_test = SPI_TEST_SINGLE_BYTE;
        SPI_TEST_PRINT("\n=== SPI Test Cycle Complete ===\n");
        SPI_Test_PrintResults();
    }
    
    SPI_TEST_PRINT("Auto switching to: %s\n", test_names[spi_test.current_test]);
}

static uint32_t GetTestDataLength(SPI_Test_Type_E test_type) {
    switch (test_type) {
        case SPI_TEST_SINGLE_BYTE:
            return 1;
        case SPI_TEST_SMALL_BURST:
            return 4;
        case SPI_TEST_MEDIUM_BURST:
            return 12;
        case SPI_TEST_LARGE_BURST:
            return 24;
        case SPI_TEST_PATTERN_VERIFY:
            return 8;
        case SPI_TEST_STRESS_TEST:
            return 6;
        case SPI_TEST_MAX_THROUGHPUT:
            return 16;
        case SPI_TEST_READ_ONLY:
        case SPI_TEST_WRITE_ONLY:
            return 8;
        case SPI_TEST_ERROR_RECOVERY:
            return 4;
        default:
            return 1;
    }
}