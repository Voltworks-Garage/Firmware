//Hardware Abstraction Layer includes
#include "ble_module.h"
#include "lcd_module.h"
#include "src/display/display.h"
#include "can.h"
#include "touch.h"
#include <driver/gpio.h>

//Project includes
#include "src/dash.h"
#include "src/begode_emulator.h"
#include "src/kingsong_emulator.h"
#include "src/cpu_monitor.h"


//Library includes
#include "../../../CAN/generated/dash_dbc.h"
#include "../../../Libraries/Submodules/ble-protocol-schema/generated/c/ble_protocol.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"
#include <esp_sleep.h>

#define TASK_MS_FREQ(ms)   TickType_t xLastWakeTime = xTaskGetTickCount();\
                           const TickType_t xFrequency = pdMS_TO_TICKS(ms);\

// Lightweight tracking for 1ms task only (must be declared before task functions)
static uint32_t task_1ms_last_wake_tick = 0;
static uint32_t task_1ms_max_jitter_ticks = 0;
static uint32_t task_1ms_overrun_count = 0;

// Helper functions
void createSchedulerTasks(void);
void print_cpu_stats(void);

// Demo tasks
void task_1ms(void *parameter);
void task_10ms(void *parameter);
void task_100ms(void *parameter);
void task_1000ms(void *parameter);

void setup() {
  Serial.begin(921600);
  // delay(100);  // Give serial time to initialize

  // Initialize hardware modules
  LCD_Init();
  CAN_Init();
  Touch_Init();

  // Initialize IO
  LVGL_Init();  // Initialize LVGL (includes state machine init)
  CAN_DBC_init();

  //Init BLE later because its slow (in the 1000ms task entry)
  ble_encode_heartbeat_begin();

  // Create FreeRTOS tasks for scheduling
  createSchedulerTasks();
}

void loop() {
  // Check if MCU has commanded us to go to sleep. This message is sent out for 1 second.
  if (CAN_mcu_command_go_to_sleep_get() && !CAN_mcu_command_checkDataIsStale()) {
    Serial.println("Sleep command received - entering deep sleep mode");
    Serial.flush(); // Ensure message is sent before sleeping

    CAN_setMode(CAN_LISTEN_MODE); // Set CAN to listen-only to avoid bus interference
    bool actuallyGoingToSleep = true;
    // Give time for any pending operations to complete
      vTaskDelay(pdMS_TO_TICKS(2000));
      if (CAN_timeSinceLastMessageReceived() >= 900) {
        Serial.println("No CAN messages received in last 1 second");

      } else {
        Serial.println("CAN activity detected recently - aborting sleep: ");
        actuallyGoingToSleep = false;
        Serial.print(CAN_timeSinceLastMessageReceived());
        CAN_setMode(CAN_NORMAL_MODE); // Restore normal CAN operation
      }


    if (actuallyGoingToSleep) {
      // Shutdown peripherals to minimize sleep current
      CAN_DeInit();      // Stop CAN controller, disable STBY pin
      LCD_DeInit();      // Power off LCD and backlight
      Touch_DeInit();    // Deinitialize touch controller
      // Note: BLE radio will automatically power down in deep sleep

      // Configure wake on CAN activity (pin 18/RX goes LOW on CAN bus dominant state)
      esp_sleep_enable_ext0_wakeup(GPIO_NUM_18, 0); // Wake on LOW (CAN bus activity)

      Serial.println("Deep sleep configured - will wake on CAN activity (GPIO 18)");
      Serial.flush();

      esp_deep_sleep_start();
    }
  }

  vTaskDelay(pdMS_TO_TICKS(100));
  // Main loop runs every 10Hz (100ms) to check for sleep command
}

// CPU monitors for each task
static CPUMonitor_t cpu1msMonitor = {0};
static CPUMonitor_t cpu10msMonitor = {0};
static CPUMonitor_t cpu100msMonitor = {0};
static CPUMonitor_t cpu1000msMonitor = {0};

static uint16_t counter = 0;

// 1ms task function
void task_1ms(void *parameter) {
  TASK_MS_FREQ(1);
  CPUMonitor_Init(&cpu1msMonitor);

  while(1) {
    CAN_send_1ms();

    // Serial.println("1ms task running");
    uint8_t buffer[8] = {1,2,3,4,5,6,7,8};
    if (CAN_boot_host_dash_checkDataIsUnread()) {
      CAN_write_simple(0x123, buffer, 8);
    }

    Touch_Run_1ms();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    // Update CPU statistics
    CPUMonitor_Update(&cpu1msMonitor);
    // Serial.println(cpu1msMonitor.period);
  }
}

// 10ms task function
void task_10ms(void *parameter) {
  TASK_MS_FREQ(10);
  vTaskDelay(pdMS_TO_TICKS(1)); // Initial delay to stagger tasks
  CPUMonitor_Init(&cpu10msMonitor);

  while(1) {
    CAN_send_10ms();
    // Serial.println("10ms task running");

    Touch_Run_10ms();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    // Update CPU statistics
    CPUMonitor_Update(&cpu10msMonitor);
  }
}

// 100ms task function
void task_100ms(void *parameter) {
  TASK_MS_FREQ(100);
  vTaskDelay(pdMS_TO_TICKS(2)); // Initial delay to stagger tasks
  CPUMonitor_Init(&cpu100msMonitor);

  while(1) {
    CAN_send_1000ms();
    Begode_SendFrame();
    // Kingsong_SendNextPacket();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    // Update CPU statistics
    CPUMonitor_Update(&cpu100msMonitor);
  }
}

// 1000ms task function
void task_1000ms(void *parameter) {
  TASK_MS_FREQ(1000);
  vTaskDelay(pdMS_TO_TICKS(3)); // Initial delay to stagger tasks
  CPUMonitor_Init(&cpu1000msMonitor);

  float current_speed = 0.0f;  // Start at 0 m/s
  float target_speed = 15.0f;  // Target 15 m/s (54 km/h)
  float speed_increment = 0.5f; // Increase by 0.5 m/s per second (realistic acceleration)
  bool speed_increasing = true;

  BLE_Init();
  Begode_Init();
  // Kingsong_Init();

  //TODO: move this somewhere else
  BLE_AllowNewDevices();
  // BLE_RestrictToBonded();

  while(1) {
    CAN_send_1000ms();
    print_cpu_stats();

    // Slowly ramp speed up and down
    if (speed_increasing) {
      current_speed += speed_increment;
      if (current_speed >= target_speed) {
        current_speed = target_speed;
        speed_increasing = false;
      }
    } else {
      current_speed -= speed_increment;
      if (current_speed <= 0.0f) {
        current_speed = 0.0f;
        speed_increasing = true;
      }
    }

    // Convert m/s to km/h for KingSong (it expects km/h, not m/s like Begode)
    float speed_kmh = current_speed * 3.6f;  // 1 m/s = 3.6 km/h
    // Kingsong_SetSpeed(speed_kmh);
    Begode_SetSpeed(current_speed);

    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    BLE_SendUartData("Hi DADA poopoo you are a silly one does this work?\n");
    BLE_SendUartData("Another message from 1000ms task!\n");

    // Update CPU statistics
    CPUMonitor_Update(&cpu1000msMonitor);
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
  Serial.println("\n=== CPU Statistics ===");
  Serial.println("Task Name\t\tAvg %\tPeak %\tPeak Period (us)\tMax Period (us)");
  Serial.println("=============================================================================");

  // Print stats for all monitored tasks
  Serial.printf("%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u\n",
                "task_1ms",
                cpu1msMonitor.cpuUsageAvg,
                cpu1msMonitor.cpuUsagePeak,
                cpu1msMonitor.peakPeriod,
                cpu1msMonitor.maxPeriod);

  Serial.printf("%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u\n",
                "task_10ms",
                cpu10msMonitor.cpuUsageAvg,
                cpu10msMonitor.cpuUsagePeak,
                cpu10msMonitor.peakPeriod,
                cpu10msMonitor.maxPeriod);

  Serial.printf("%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u\n",
                "task_100ms",
                cpu100msMonitor.cpuUsageAvg,
                cpu100msMonitor.cpuUsagePeak,
                cpu100msMonitor.peakPeriod,
                cpu100msMonitor.maxPeriod);

  Serial.printf("%-20s\t%5.2f%%\t%5.2f%%\t%8u\t\t%8u\n",
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

