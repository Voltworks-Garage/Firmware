#include "ble_module.h"
#include "lcd_module.h"
#include "can_module.h"


// Demo tasks
void demoTask(void *parameter);
void anotherDemoTask(void *parameter);

void setup() {
  Serial.begin(921600);

  // Initialize modules

  BLE_Init();
  LCD_Init();
  CAN_Init();

  BLE_RestrictToBonded();

  // Show initial test screen
  LCD_ShowTestScreen();

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


}

void loop() {
  // Main loop is empty - all work done in RTOS tasks
}

// Demo task function
void demoTask(void *parameter) {
  while(1) {
    Serial.println("Demo task running");
    vTaskDelay(pdMS_TO_TICKS(1000));
    uint8_t buffer[8] = {1,2,3,4,5,6,7,8};
    CAN_SendMessage(0x123, buffer, 8);
  }
}

// Another demo task function
void anotherDemoTask(void *parameter) {
  while(1) {
    Serial.println("Another demo task running");
    LCD_ShowTestScreen();
    BLE_SendUartData("you fuck");
    vTaskDelay(pdMS_TO_TICKS(2000));
  }
}