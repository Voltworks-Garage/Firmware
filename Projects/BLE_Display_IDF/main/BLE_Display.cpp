#include <stdio.h>

// #include "ble_module.h"
#include "lcd_module.h"
#include "can_module.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

// Demo tasks
void demoTask(void *parameter);
void anotherDemoTask(void *parameter);

extern "C" void app_main(void)
{
  // Initialize modules
//   BLE_Init();
  LCD_Init();
  CAN_Init();

  // Show initial test screen
  // LCD_ShowTestScreen();

  // Create demo tasks
  xTaskCreate(
    demoTask,
    "DemoTask",
    10000,
    NULL,
    1,
    NULL
  );

  xTaskCreate(
    anotherDemoTask,
    "AnotherDemoTask",
    10000,
    NULL,
    1,
    NULL
  );

  while(1);

}

// Demo task function
void demoTask(void *parameter) {
  while(1) {
    // Serial.println("Demo task running");
    vTaskDelay(pdMS_TO_TICKS(1000));
  }
}

// Another demo task function
void anotherDemoTask(void *parameter) {
  while(1) {
    // Serial.println("Another demo task running");
    vTaskDelay(pdMS_TO_TICKS(2000));
  }
}
