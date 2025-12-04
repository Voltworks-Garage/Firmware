// ESP Logging
// #define LOG_LOCAL_LEVEL    ESP_LOG_NONE     /*!< No log output */
// #define LOG_LOCAL_LEVEL    ESP_LOG_ERROR    /*!< Critical errors, software module can not recover on its own */
// #define LOG_LOCAL_LEVEL    ESP_LOG_WARN     /*!< Error conditions from which recovery measures have been taken */
#define LOG_LOCAL_LEVEL    ESP_LOG_INFO     /*!< Information messages which describe normal flow of events */
// #define LOG_LOCAL_LEVEL    ESP_LOG_DEBUG    /*!< Extra information which is not necessary for normal use (values, pointers, sizes, etc). */
// #define LOG_LOCAL_LEVEL    ESP_LOG_VERBOSE  /*!< Bigger chunks of debugging information, or frequent messages which can potentially flood the output. */
// #define LOG_LOCAL_LEVEL    ESP_LOG_MAX      /*!< Number of levels supported */
#include "esp_log.h"
static const char* TAG = "MAIN";

// Components
#include "can.h"
#include "dash_dbc.h"
#include "ble_module.h"
#include "app_handler.h"
#include "display.h"
#include "touch.h"
#include "cpu_monitor.h"

// FreeRTOS
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"



// GPIO for JTAG pin reclaim
#include "driver/gpio.h"
#include "esp_sleep.h"

//scheduling of periodic tasks
#define TASK_MS_FREQ(ms)   TickType_t xLastWakeTime = xTaskGetTickCount();\
                           const TickType_t xFrequency = pdMS_TO_TICKS(ms)\

#define TASK_MS_DELAY()      vTaskDelayUntil(&xLastWakeTime, xFrequency)

// Helper functions
void createSchedulerTasks(void);
void print_cpu_stats(void);
void check_for_sleep_command(void);

void task_1ms(void *parameter);
void task_10ms(void *parameter);
void task_100ms(void *parameter);
void task_1000ms(void *parameter);

// CPU monitors for each task
static CPUMonitor_t cpu1msMonitor = {0};
static CPUMonitor_t cpu10msMonitor = {0};
static CPUMonitor_t cpu100msMonitor = {0};
static CPUMonitor_t cpu1000msMonitor = {0};


void app_main(void) {
    esp_log_level_set(TAG, LOG_LOCAL_LEVEL);
    // CRITICAL: Reclaim JTAG pins for LCD use
    ESP_LOGI(TAG, "Reclaiming JTAG pins (GPIO 39-42) for LCD use...");
    gpio_reset_pin(GPIO_NUM_39);  // RD (MTCK)
    gpio_reset_pin(GPIO_NUM_40);  // WR (MTDO)
    gpio_reset_pin(GPIO_NUM_41);  // DC (MTDI)
    gpio_reset_pin(GPIO_NUM_42);  // CS (MTMS)

    ESP_LOGI(TAG, "=== BLE Display IDF ===");
    ESP_LOGI(TAG, "Initializing CAN module...");
    CAN_Init();
    CAN_DBC_init();
    ESP_LOGI(TAG, "CAN module initialized successfully!");

    ESP_LOGI(TAG, "Initializing display with LVGL...");
    Display_Init();
    Touch_Init();
    ESP_LOGI(TAG, "Display initialized successfully!");

    ESP_LOGI(TAG, "Initializing BLE module...");
    BLE_Init();
    ESP_LOGI(TAG, "BLE module initialized successfully!");

    ESP_LOGI(TAG, "Initializing BLE app handler...");
    app_handler_init();
    ESP_LOGI(TAG, "BLE app handler initialized successfully!");

    // Create FreeRTOS tasks for scheduling
    createSchedulerTasks();

    ESP_LOGI(TAG, "Initialization complete - scheduler tasks created");
    // app_main() returns here, freeing up the main task stack
    // All work is now done in the periodic tasks (1ms, 10ms, 100ms, 1000ms)
}

// 1ms task function
void task_1ms(void *parameter) {
  TASK_MS_FREQ(1);
  CPUMonitor_Init(&cpu1msMonitor);

  while(1) {
    // Update CPU statistics
    CPUMonitor_Update(&cpu1msMonitor);

    // Send CAN messages
    CAN_send_1ms();

    // Run touch hardware processing
    Touch_Run_1ms();

    TASK_MS_DELAY();


  }
}

// 10ms task function
void task_10ms(void *parameter) {
  TASK_MS_FREQ(10);
  vTaskDelay(pdMS_TO_TICKS(1)); // Initial delay to stagger tasks
  CPUMonitor_Init(&cpu10msMonitor);

  while(1) {
    // Update CPU statistics
    CPUMonitor_Update(&cpu10msMonitor);

    // Send CAN messages
    CAN_send_10ms();

    // Run touch hardware processing
    Touch_Run_10ms();

    // Send BLE messages with motor/safety data
    app_handler_run_10ms();

    TASK_MS_DELAY();
  }
}

// 100ms task function
void task_100ms(void *parameter) {
  TASK_MS_FREQ(100);
  vTaskDelay(pdMS_TO_TICKS(2)); // Initial delay to stagger tasks
  CPUMonitor_Init(&cpu100msMonitor);

  while(1) {
    // Update CPU statistics
    CPUMonitor_Update(&cpu100msMonitor);

    // Send CAN messages
    CAN_send_100ms();

    // Send BLE messages with BMS data
    app_handler_run_100ms();

    check_for_sleep_command();

    TASK_MS_DELAY();
  }
}

// 1000ms task function
void task_1000ms(void *parameter) {
  TASK_MS_FREQ(1000);
  vTaskDelay(pdMS_TO_TICKS(3)); // Initial delay to stagger tasks
  CPUMonitor_Init(&cpu1000msMonitor);

  while(1) {
    // Update CPU statistics
    CPUMonitor_Update(&cpu1000msMonitor);
    print_cpu_stats();

    // Send CAN messages
    CAN_send_1000ms();

    // Send BLE messages with heartbeat and performance data
    app_handler_run_1000ms();

    TASK_MS_DELAY();
  }
}

void createSchedulerTasks() {
  
  // Create demo tasks
  xTaskCreatePinnedToCore(
    task_1ms,
    "task_1ms",
    10000,
    NULL,
    configMAX_PRIORITIES-1,
    NULL,
    1
  );

  xTaskCreatePinnedToCore(
    task_10ms,
    "task_10ms",
    10000,
    NULL,
    configMAX_PRIORITIES-3 ,
    NULL,
    1
  );

  xTaskCreatePinnedToCore(
    task_100ms,
    "task_100ms",
    10000,
    NULL,
    configMAX_PRIORITIES-4,
    NULL,
    1
  );

  xTaskCreatePinnedToCore(
    task_1000ms,
    "task_1000ms",
    10000,
    NULL,
    configMAX_PRIORITIES-5,
    NULL,
    1
  );

}

// Print CPU statistics for monitored tasks (call every 1000ms)
void print_cpu_stats(void) {
  ESP_LOGI(TAG, "=== CPU Statistics ===");
  ESP_LOGI(TAG, "Task Name\t\tAvg %%\tPeak %%\tPeak Period (us)\tMax Period (us)");
  ESP_LOGI(TAG, "=============================================================================");

  // Print stats for all monitored tasks
  ESP_LOGI(TAG, "%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u",
                "task_1ms",
                cpu1msMonitor.cpuUsageAvg,
                cpu1msMonitor.cpuUsagePeak,
                cpu1msMonitor.peakPeriod,
                cpu1msMonitor.maxPeriod);

  ESP_LOGI(TAG, "%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u",
                "task_10ms",
                cpu10msMonitor.cpuUsageAvg,
                cpu10msMonitor.cpuUsagePeak,
                cpu10msMonitor.peakPeriod,
                cpu10msMonitor.maxPeriod);

  ESP_LOGI(TAG, "%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u",
                "task_100ms",
                cpu100msMonitor.cpuUsageAvg,
                cpu100msMonitor.cpuUsagePeak,
                cpu100msMonitor.peakPeriod,
                cpu100msMonitor.maxPeriod);

  ESP_LOGI(TAG, "%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u",
                "task_1000ms",
                cpu1000msMonitor.cpuUsageAvg,
                cpu1000msMonitor.cpuUsagePeak,
                cpu1000msMonitor.peakPeriod,
                cpu1000msMonitor.maxPeriod);

  // Reset peak values after printing (for next measurement window)
  CPUMonitor_ResetPeak(&cpu1msMonitor);
  CPUMonitor_ResetPeak(&cpu10msMonitor);
  CPUMonitor_ResetPeak(&cpu100msMonitor);
  CPUMonitor_ResetPeak(&cpu1000msMonitor);
}

void check_for_sleep_command(void) {
  //
// Check if MCU has commanded us to go to sleep. This message is sent out for 1 second.
  if (CAN_mcu_command_go_to_sleep_get() && !CAN_mcu_command_checkDataIsStale()) {
    ESP_LOGI(TAG, "Sleep command received - entering deep sleep mode");
    vTaskDelay(pdMS_TO_TICKS(1)); // Short delay to ensure message is sent

    CAN_setMode(CAN_LISTEN_MODE); // Set CAN to listen-only to avoid bus interference
    bool actuallyGoingToSleep = true;
    // Give time for any pending operations to complete
      vTaskDelay(pdMS_TO_TICKS(2000));
      if (CAN_timeSinceLastMessageReceived() >= 900) {
        ESP_LOGI(TAG, "No CAN messages received in last 1 second");

      } else {
        ESP_LOGI(TAG, "CAN activity detected recently - aborting sleep: ");
        actuallyGoingToSleep = false;
        ESP_LOGI(TAG, "%u", CAN_timeSinceLastMessageReceived());
        CAN_setMode(CAN_NORMAL_MODE); // Restore normal CAN operation
      }


    if (actuallyGoingToSleep) {
      // Shutdown peripherals to minimize sleep current
      CAN_DeInit();      // Stop CAN controller, disable STBY pin
      // LCD_DeInit();      // Power off LCD and backlight
      Touch_DeInit();    // Deinitialize touch controller
      // Note: BLE radio will automatically power down in deep sleep

      // Configure wake on CAN activity (pin 18/RX goes LOW on CAN bus dominant state)
      esp_sleep_enable_ext0_wakeup(GPIO_NUM_18, 0); // Wake on LOW (CAN bus activity)

      ESP_LOGI(TAG, "Deep sleep configured - will wake on CAN activity (GPIO 18)");
      vTaskDelay(pdMS_TO_TICKS(1)); // Short delay to ensure message is sent

      esp_deep_sleep_start();
    }
  }
}