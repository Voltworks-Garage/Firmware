//Hardware Abstraction Layer includes
#include "ble_module.h"
#include "lcd_module.h"
#include "can.h"
#include "touch.h"

//Project includes
#include "src/dash.h"
#include "src/begode_emulator.h"
#include "src/kingsong_emulator.h"


//Library includes
#include "../../../CAN/generated/dash_dbc.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_log.h"

#define TASK_MS_DELAY(ms)   TickType_t xLastWakeTime = xTaskGetTickCount();\
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
  delay(100);  // Give serial time to initialize

  // Configure ESP-IDF logging
  // esp_log_level_set("TOUCH", ESP_LOG_VERBOSE);  // Specifically enable TOUCH tag
  // esp_log_level_set("CAN", ESP_LOG_INFO);  // Enable CAN module info logging

  // Initialize hardware modules
  BLE_Init();
  LCD_Init();
  CAN_Init();
  Touch_Init();

  // Initialize IO
  CAN_DBC_init();
  Begode_Init();
  // Kingsong_Init();
  Dash_Init();

  //TODO: move this somewhere else
  BLE_AllowNewDevices();
  // BLE_RestrictToBonded();


  //TODO: move this somewhere else
  // Show initial test screen
  LCD_ShowTestScreen();

  createSchedulerTasks();


}

void loop() {
  vTaskDelay(pdMS_TO_TICKS(1000));
  // Main loop is empty - all work done in RTOS tasks
}

// 1ms task function
void task_1ms(void *parameter) {
  TASK_MS_DELAY(1);

  while(1) {
    // Lightweight 1ms jitter detection - just read tick counter (very fast!)
    TickType_t now = xTaskGetTickCount();
    if (task_1ms_last_wake_tick != 0) {
      uint32_t delta = now - task_1ms_last_wake_tick;
      if (delta > 1) {  // Should be exactly 1 tick (1ms)
        uint32_t jitter = delta - 1;
        if (jitter > task_1ms_max_jitter_ticks) {
          task_1ms_max_jitter_ticks = jitter;
        }
        task_1ms_overrun_count++;
      }
    }
    task_1ms_last_wake_tick = now;

    // Serial.println("1ms task running");
    uint8_t buffer[8] = {1,2,3,4,5,6,7,8};
    if (CAN_boot_host_dash_checkDataIsUnread()) {
      CAN_write_simple(0x123, buffer, 8);
    }
  
    Touch_Run_1ms();



    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// 10ms task function
void task_10ms(void *parameter) {
  TASK_MS_DELAY(10);
  vTaskDelay(pdMS_TO_TICKS(1)); // Initial delay to stagger tasks

  while(1) {
    // Serial.println("10ms task running");
    
    Touch_Run_10ms();
    Dash_Run_10ms();

        // sample_cpu_stats();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// 100ms task function
void task_100ms(void *parameter) {
  TASK_MS_DELAY(100);
  vTaskDelay(pdMS_TO_TICKS(2)); // Initial delay to stagger tasks
  while(1) {
    Serial.println("100ms task running");
    Begode_SendFrame();
    // Kingsong_SendNextPacket();

    sample_cpu_stats();  // Sample CPU stats every 100ms (optimized - no malloc, pointer compares)

        // Serial.println("1ms task running");
    CAN_dash_command_send();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// 1000ms task function
void task_1000ms(void *parameter) {
  TASK_MS_DELAY(1000);
  vTaskDelay(pdMS_TO_TICKS(3)); // Initial delay to stagger tasks

  float current_speed = 0.0f;  // Start at 0 m/s
  float target_speed = 15.0f;  // Target 15 m/s (54 km/h)
  float speed_increment = 0.5f; // Increase by 0.5 m/s per second (realistic acceleration)
  bool speed_increasing = true;

  while(1) {
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

    CAN_dash_status_send();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

void createSchedulerTasks() {
  
  // Create demo tasks
  xTaskCreate(
    task_1ms,
    "task_1ms",
    10000,
    NULL,
    4,
    NULL
  );

  xTaskCreate(
    task_10ms,
    "task_10ms",
    10000,
    NULL,
    3,
    NULL
  );

  xTaskCreate(
    task_100ms,
    "task_100ms",
    10000,
    NULL,
    2,
    NULL
  );

  xTaskCreate(
    task_1000ms,
    "task_1000ms",
    10000,
    NULL,
    1,
    NULL
  );

}

// Track max CPU usage per task (max 32 tasks) - shared between sample and print
#define MAX_TRACKED_TASKS 32
static struct {
  TaskHandle_t handle;    // Use handle as key - pointer comparison is MUCH faster than strcmp!
  char name[configMAX_TASK_NAME_LEN];
  uint32_t maxCpu;        // Peak CPU % seen in any sample
  uint32_t totalCpu;      // Sum of all samples for averaging
  uint32_t sampleCount;   // Number of samples taken
} taskMaxStats[MAX_TRACKED_TASKS] = {0};
static int numTrackedTasks = 0;

// Sample CPU stats (call every 100ms - uxTaskGetSystemState is HEAVY!)
void sample_cpu_stats(void) {
  static uint32_t ulLastTotalRunTime = 0;

  // Pre-allocated buffers - no malloc/free overhead!
  static TaskStatus_t pxCurrentTaskStatusArray[MAX_TRACKED_TASKS];
  static TaskStatus_t pxLastTaskStatusArray[MAX_TRACKED_TASKS];
  static UBaseType_t uxLastArraySize = 0;

  UBaseType_t uxArraySize;
  uint32_t ulTotalRunTime, ulDeltaTime, ulStatsAsPercentage;

  // Get number of tasks (capped at MAX_TRACKED_TASKS)
  uxArraySize = uxTaskGetNumberOfTasks();
  if (uxArraySize > MAX_TRACKED_TASKS) {
    uxArraySize = MAX_TRACKED_TASKS;
  }

  // Get detailed stats for all tasks - THIS IS THE HEAVY OPERATION!
  // It locks the scheduler and iterates all tasks
  uxArraySize = uxTaskGetSystemState(pxCurrentTaskStatusArray, uxArraySize, &ulTotalRunTime);

  // Calculate delta time since last measurement
  ulDeltaTime = ulTotalRunTime - ulLastTotalRunTime;

  for (int x = 0; x < uxArraySize; x++) {
    uint32_t ulTaskDelta = 0;
    TaskHandle_t taskHandle = pxCurrentTaskStatusArray[x].xHandle;

    // Find matching task in previous snapshot - using HANDLE not string!
    if (uxLastArraySize > 0) {
      for (UBaseType_t y = 0; y < uxLastArraySize; y++) {
        if (pxLastTaskStatusArray[y].xHandle == taskHandle) {  // Pointer comparison - fast!
          ulTaskDelta = pxCurrentTaskStatusArray[x].ulRunTimeCounter - pxLastTaskStatusArray[y].ulRunTimeCounter;
          break;
        }
      }
    }

    // Calculate percentage based on delta (avoid divide by zero)
    if (ulDeltaTime > 0) {
      ulStatsAsPercentage = (ulTaskDelta * 100) / ulDeltaTime;
    } else {
      ulStatsAsPercentage = 0;
    }

    // Find or create entry for this task's max stats - using HANDLE not string!
    int taskIdx = -1;
    for (int i = 0; i < numTrackedTasks; i++) {
      if (taskMaxStats[i].handle == taskHandle) {  // Pointer comparison - fast!
        taskIdx = i;
        break;
      }
    }
    if (taskIdx == -1 && numTrackedTasks < MAX_TRACKED_TASKS) {
      taskIdx = numTrackedTasks++;
      taskMaxStats[taskIdx].handle = taskHandle;
      strncpy(taskMaxStats[taskIdx].name, pxCurrentTaskStatusArray[x].pcTaskName, configMAX_TASK_NAME_LEN - 1);
      taskMaxStats[taskIdx].maxCpu = 0;
      taskMaxStats[taskIdx].totalCpu = 0;
      taskMaxStats[taskIdx].sampleCount = 0;
    }

    // Update total (for average), max CPU, and sample count
    if (taskIdx >= 0) {
      taskMaxStats[taskIdx].totalCpu += ulStatsAsPercentage;
      taskMaxStats[taskIdx].sampleCount++;
      if (ulStatsAsPercentage > taskMaxStats[taskIdx].maxCpu) {
        taskMaxStats[taskIdx].maxCpu = ulStatsAsPercentage;
      }
    }
  }

  // Copy current snapshot to last (no malloc/free - just memcpy!)
  memcpy(pxLastTaskStatusArray, pxCurrentTaskStatusArray, uxArraySize * sizeof(TaskStatus_t));
  uxLastArraySize = uxArraySize;
  ulLastTotalRunTime = ulTotalRunTime;
}

// Print CPU statistics (call every 1000ms)
void print_cpu_stats(void) {

  Serial.println("\n=== CPU Statistics ===");

  // Print 1ms task timing issues (lightweight - sampled at 1ms resolution!)
  Serial.printf("1ms Task Jitter: Max=%dms, Overruns=%d (in last 1sec)\n",
                task_1ms_max_jitter_ticks, task_1ms_overrun_count);
  task_1ms_max_jitter_ticks = 0;
  task_1ms_overrun_count = 0;
  Serial.println();

  Serial.println("All Tasks (sampled every 100ms):");
  Serial.println("Task Name\t\tAvg %\tPeak %\tStack Free");
  Serial.println("=========================================================");

  // Print stats for all tracked tasks
  for (int i = 0; i < numTrackedTasks; i++) {
    // Calculate average CPU over the measurement period
    uint32_t avgCpu = 0;
    if (taskMaxStats[i].sampleCount > 0) {
      avgCpu = taskMaxStats[i].totalCpu / taskMaxStats[i].sampleCount;
    }

    // Get current stack info (need to find the task)
    TaskHandle_t taskHandle = xTaskGetHandle(taskMaxStats[i].name);
    UBaseType_t stackFree = 0;
    if (taskHandle != NULL) {
      stackFree = uxTaskGetStackHighWaterMark(taskHandle);
    }

    Serial.printf("%-20s\t%3d%%\t%3d%%\t%d\n",
                  taskMaxStats[i].name,
                  avgCpu,
                  taskMaxStats[i].maxCpu,
                  stackFree);

    // Reset stats after printing (shows average/peak over last 1 second)
    taskMaxStats[i].maxCpu = 0;
    taskMaxStats[i].totalCpu = 0;
    taskMaxStats[i].sampleCount = 0;
  }
}

