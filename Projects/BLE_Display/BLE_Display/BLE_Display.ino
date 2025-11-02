//Hardware Abstraction Layer includes
#include "ble_module.h"
#include "lcd_module.h"
#include "can.h"

//Project includes
#include "src/dash.h"
#include "src/begode_emulator.h"

//Library includes
#include "../../../CAN/generated/dash_dbc.h"

// Helper functions
void print_cpu_stats(void);

// Demo tasks
void task_1ms(void *parameter);
void task_10ms(void *parameter);
void task_100ms(void *parameter);
void task_1000ms(void *parameter);

void setup() {
  Serial.begin(921600);

  // Initialize modules

  BLE_Init();
  LCD_Init();
  CAN_Init();

  CAN_DBC_init();

  BLE_AllowNewDevices();
  // BLE_RestrictToBonded();

  Begode_Init();

  // Show initial test screen
  LCD_ShowTestScreen();

  // Create demo tasks
  xTaskCreate(
    task_1ms,
    "task_1ms",
    10000,
    NULL,
    2,
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
    4,
    NULL
  );

  xTaskCreate(
    task_1000ms,
    "task_1000ms",
    10000,
    NULL,
    5,
    NULL
  );


}

void loop() {
  // Main loop is empty - all work done in RTOS tasks
  drawDashBoard();
}

// 1ms task function
void task_1ms(void *parameter) {
  TickType_t xLastWakeTime = xTaskGetTickCount();
  const TickType_t xFrequency = pdMS_TO_TICKS(1);

  while(1) {
    // Serial.println("1ms task running");
    uint8_t buffer[8] = {1,2,3,4,5,6,7,8};
    CAN_write_simple(0x123, buffer, 8);

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// 10ms task function
void task_10ms(void *parameter) {
  TickType_t xLastWakeTime = xTaskGetTickCount();
  const TickType_t xFrequency = pdMS_TO_TICKS(10);

  while(1) {
    // Serial.println("10ms task running");

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// 100ms task function
void task_100ms(void *parameter) {
  TickType_t xLastWakeTime = xTaskGetTickCount();
  const TickType_t xFrequency = pdMS_TO_TICKS(200);

  while(1) {
    Serial.println("100ms task running");
    BLE_SendBegodeFrame(Begode_GetFrame(), 24);

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// 1000ms task function
void task_1000ms(void *parameter) {
  TickType_t xLastWakeTime = xTaskGetTickCount();
  const TickType_t xFrequency = pdMS_TO_TICKS(1000);

  while(1) {
    print_cpu_stats();

    vTaskDelayUntil(&xLastWakeTime, xFrequency);
  }
}

// Helper function to print CPU statistics
void print_cpu_stats(void) {
  static uint32_t ulLastTotalRunTime = 0;
  static TaskStatus_t *pxLastTaskStatusArray = NULL;
  static UBaseType_t uxLastArraySize = 0;

  TaskStatus_t *pxTaskStatusArray;
  volatile UBaseType_t uxArraySize, x;
  uint32_t ulTotalRunTime, ulDeltaTime, ulStatsAsPercentage;

  // Get number of tasks
  uxArraySize = uxTaskGetNumberOfTasks();

  // Allocate array for task statuses
  pxTaskStatusArray = (TaskStatus_t*)pvPortMalloc(uxArraySize * sizeof(TaskStatus_t));

  if (pxTaskStatusArray != NULL) {
    // Get detailed stats for all tasks
    uxArraySize = uxTaskGetSystemState(pxTaskStatusArray, uxArraySize, &ulTotalRunTime);

    // Calculate delta time since last measurement
    ulDeltaTime = ulTotalRunTime - ulLastTotalRunTime;

    Serial.println("\n=== CPU Statistics ===");
    Serial.println("Task Name\t\tCPU %\tStack Free");
    Serial.println("=============================================");

    for (x = 0; x < uxArraySize; x++) {
      uint32_t ulTaskDelta = 0;

      // Find matching task in previous snapshot to calculate delta
      if (pxLastTaskStatusArray != NULL) {
        for (UBaseType_t y = 0; y < uxLastArraySize; y++) {
          if (strcmp(pxTaskStatusArray[x].pcTaskName, pxLastTaskStatusArray[y].pcTaskName) == 0) {
            ulTaskDelta = pxTaskStatusArray[x].ulRunTimeCounter - pxLastTaskStatusArray[y].ulRunTimeCounter;
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

      // Print task name, CPU usage, and stack high water mark
      Serial.printf("%-20s\t%2d%%\t%d\n",
                    pxTaskStatusArray[x].pcTaskName,
                    ulStatsAsPercentage,
                    pxTaskStatusArray[x].usStackHighWaterMark);
    }

    // Free old snapshot and save current one
    if (pxLastTaskStatusArray != NULL) {
      vPortFree(pxLastTaskStatusArray);
    }
    pxLastTaskStatusArray = pxTaskStatusArray;
    uxLastArraySize = uxArraySize;
    ulLastTotalRunTime = ulTotalRunTime;

  } else {
    Serial.println("Error: Failed to allocate memory for task stats");
  }
}

