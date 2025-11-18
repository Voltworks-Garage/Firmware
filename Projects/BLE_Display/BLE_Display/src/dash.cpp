// #include "dash.h"
// #include "lcd_module.h"
// #include "touch.h"
// #include "cpu_monitor.h"

// #include "driver/temperature_sensor.h"
// #include "FreeRTOS.h"
// #include "freertos/queue.h"
// #include "freertos/task.h"

// #define LOG_LOCAL_LEVEL ESP_LOG_VERBOSE
// // #define LOG_LOCAL_LEVEL ESP_LOG_INFO
// // #define LOG_LOCAL_LEVEL ESP_LOG_DEBUG
// // #define LOG_LOCAL_LEVEL ESP_LOG_WARN
// // #define LOG_LOCAL_LEVEL ESP_LOG_ERROR
// // #define LOG_LOCAL_LEVEL ESP_LOG_NONE
// #include "esp_log.h"
// static const char* TAG = "DASH";

// #include "src/msg/messaging.h"
// #include "../../../CAN/generated/dash_dbc.h"
// #include "src/logo.h"

// /******************************************************************************
//  * State Machine
//  *******************************************************************************/
// #define DASH_STATES(state)\
// state(dash_init)\
// state(dash_home)\
// state(dash_settings)\
// state(dash_running)\
// state(dash_error)\

// #define STATE_FORM(WORD) WORD##_state,
// #define FUNCTION_FORM(WORD) static void WORD(DASH_entry_types_E entry_type);
// #define FUNC_PTR_FORM(WORD) WORD,

// typedef enum {
//     DASH_STATES(STATE_FORM)
//     NUMBER_OF_DASH_STATES
// } DASH_states_E;

// typedef enum {
//     ENTRY,
//     EXIT,
//     RUN,
//     NONE
// } DASH_entry_types_E;

// typedef void(*dashStatePtr)(DASH_entry_types_E);

// DASH_STATES(FUNCTION_FORM)
// static dashStatePtr dash_state_functions[] = {DASH_STATES(FUNC_PTR_FORM)};

// static DASH_states_E dash_prevState = dash_init_state;
// static DASH_states_E dash_curState = dash_init_state;
// static DASH_states_E dash_nextState = dash_init_state;

// /******************************************************************************
//  * Declarations
//  *******************************************************************************/

// TFT_eSPI* tft = NULL;        // Create TFT instance "tft" 

// static QueueHandle_t q = NULL;  // Message queue for DASH module
// static Message_t msg = {};  //Global message holder for processing event

// //Internal Variables for Display:
// bool ble_connection_status = false;
// uint8_t can_connection_status = 0;
// float battery_percentage = 0;
// float battery_voltage = 0;

// // Temperature sensor handle
// temperature_sensor_handle_t temp_handle = NULL;
// temperature_sensor_config_t temp_sensor_config = TEMPERATURE_SENSOR_CONFIG_DEFAULT(-10, 80);

// #define DASH_HOME_BG_COLOR TFT_NAVY
// #define DASH_HOME_TEXT_COLOR TFT_WHITE

// #define DASH_FINE_PRINT_FONT 2 //which font is this? 26pixels? LOAD_FONT4??
// #define DASH_FINE_PRINT_FONT_HEIGHT 26 //pixels
// #define DASH_FINE_PRINT_FONT_LINE_SPACING 5 //pixels

// #define DASH_DISPLAY_FONT 3 // which one??? LOAD_FONT6
// #define DASH_DISPLAY_FONT_HEIGHT 48 //pixels
// #define DASH_DISPLAY_FONT_LINE_SPACING 10 //pixels

// #define DASH_SPEEDO_FONT 6 //LOAD_FONT6
// #define DASH_SPEEDO_FONT_HEIGHT 75 //pixels

// #define ROW_SPACING 24
// #define ROW_1 10
// #define ROW_2 (ROW_1 + ROW_SPACING*1)
// #define ROW_3 (ROW_1 + ROW_SPACING*2)
// #define ROW_4 (ROW_1 + ROW_SPACING*3)
// #define ROW_5 (ROW_1 + ROW_SPACING*4)
// #define ROW_6 (ROW_1 + ROW_SPACING*5)
// #define ROW_7 (ROW_1 + ROW_SPACING*6)
// #define ROW_8 (ROW_1 + ROW_SPACING*7)
// #define ROW_9 (ROW_1 + ROW_SPACING*8)
// #define ROW_10 (ROW_1 + ROW_SPACING*9)
// #define ROW_11 (ROW_1 + ROW_SPACING*10)
// #define ROW_12 (ROW_1 + ROW_SPACING*11)

// #define COL_1 10
// #define COL_2 150

// #define DARKER_GREY 0x18E3
// #define LOOP_DELAY 50  // milliseconds between updates

// // Ring meter state structure
// typedef struct {
//   int x;
//   int y;
//   int r;
//   int val;
//   const char *units;
//   uint16_t last_angle;
//   uint16_t last_val;
//   bool needs_init;
// } ringMeter_t;

// uint32_t runTime = 0;       // time for next update
// static ringMeter_t speedMeter = {0};

// void messageQueueHandler(void);
// void ringMeter(ringMeter_t *meter);
// float dashCheckTemperatureSensor();
// void drawDashBoard();
// void task_lcd_10ms(void *parameter);




// void Dash_Init() {
//   esp_log_level_set("DASH", LOG_LOCAL_LEVEL); // This has to be here to take effect due to .c file type

//   tft = LCD_GetTFT();
//   // Initialize temperature sensor
//   ESP_ERROR_CHECK(temperature_sensor_install(&temp_sensor_config, &temp_handle));
//   q = xQueueCreate(10, sizeof(Message_t));
//   MsgBus_Register(MODULE_UI, q);

//   dash_curState = dash_init_state;
//   dash_prevState = dash_init_state;
//   dash_nextState = dash_init_state;
//   dash_state_functions[dash_curState](ENTRY);

//   // Initialize speedMeter
//   speedMeter.x = tft->width() * 3 / 4;
//   speedMeter.y = tft->height() / 2;
//   speedMeter.r = tft->height() / 3;
//   speedMeter.val = 0;
//   speedMeter.units = "MPH";
//   speedMeter.last_angle = 30;
//   speedMeter.last_val = 0;
//   speedMeter.needs_init = true;

//   // Create LCD task (10ms period)
//   xTaskCreatePinnedToCore(
//     task_lcd_10ms,
//     "task_lcd_10ms",
//     10000,
//     NULL,
//     3,
//     NULL,
//     0
//   );

// }

// void Dash_Run_10ms() {
//   //Check for state transitions
//   if (dash_nextState != dash_curState) {
//       dash_state_functions[dash_curState](EXIT);
//       dash_prevState = dash_curState;
//       dash_curState = dash_nextState;
//       dash_state_functions[dash_curState](ENTRY);
//   }

//   // Run current state with any events from message queue
//   messageQueueHandler();

//   // Regular RUN call
//   dash_state_functions[dash_curState](RUN);


// }

// void dash_init(DASH_entry_types_E entry_type) {
//     switch (entry_type) {
//         case ENTRY:
//             ESP_LOGI("DASH", "Entering INIT state");
//             {
//               uint32_t imgSize = sizeof(Voltworks_Garage)/sizeof(Voltworks_Garage[0]);
//               ESP_LOGI("DASH", "Image size: %u pixels", imgSize);
//             }

//             tft->pushImage(80,
//                            0,
//                            VOLTWORKS_GARAGE_WIDTH,
//                            VOLTWORKS_GARAGE_HEIGHT,
//                            Voltworks_Garage);

//             vTaskDelay(pdMS_TO_TICKS(1000));
//             break;
//         case EXIT:
//             ESP_LOGI("DASH", "Exiting INIT state");
//             break;
//         case RUN:

            
//             // Initialization tasks can be performed here if needed
//             dash_nextState = dash_home_state; // Transition to home state
//             break;
//         default:
//             break;
//     }
// }

// void dash_home(DASH_entry_types_E entry_type) {
//     switch (entry_type) {
//         case ENTRY:
//             ESP_LOGI("DASH", "Entering HOME state");
//             tft->fillScreen(DASH_HOME_BG_COLOR);
//             LCD_DrawText("Voltworks Garage eMOTO", COL_1, ROW_1, 3, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             LCD_DrawText("Battery (%):", COL_1, ROW_2, DASH_FINE_PRINT_FONT, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             LCD_DrawText("Voltage (V):", COL_1, ROW_3, DASH_FINE_PRINT_FONT, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             LCD_DrawText("CAN Status:", COL_1, ROW_4, DASH_FINE_PRINT_FONT, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             LCD_DrawText("BLE Status:", COL_1, ROW_5, DASH_FINE_PRINT_FONT, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             LCD_DrawText("Vehicle Status:", COL_1, ROW_6, DASH_FINE_PRINT_FONT, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             LCD_DrawText("Not Connected", COL_2, ROW_5, DASH_FINE_PRINT_FONT, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             break;
//         case EXIT:
//             ESP_LOGI("DASH", "Exiting HOME state");
//             break;
//         case RUN:
//             LCD_DrawText("0 Nodes", COL_2, ROW_4, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);

//             LCD_DrawText("Accesory State", COL_2, ROW_6, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             {
//               char buf[10];
//               sprintf(buf, "%5.1f", CAN_bms_status_soc_percent_get());
//               LCD_DrawText(buf , COL_2, ROW_2, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//               sprintf(buf, "%5.1f", CAN_bms_status_pack_voltage_get());
//               LCD_DrawText(buf , COL_2, ROW_3, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             }

//             if (ble_connection_status){
//               LCD_DrawText("Connected    ", COL_2, ROW_5, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             } else {
//               LCD_DrawText("Not Connected", COL_2, ROW_5, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
//             }

//             drawDashBoard();

//             uint16_t xval, yval;
//             if (Touch_GetXY(&xval, &yval)) {
//               tft->fillCircle(xval, yval, 5, TFT_RED);
//             }
//             break;

//         default:
//             break;
//     }
// }

// void dash_settings(DASH_entry_types_E entry_type) {
//     switch (entry_type) {
//         case ENTRY:
//             ESP_LOGI("DASH", "Entering SETTINGS state");
//             break;
//         case EXIT:
//             ESP_LOGI("DASH", "Exiting SETTINGS state");
//             break;
//         case RUN:
//             // Settings screen tasks can be performed here
//             break;
//         default:
//             break;
//     }
// }

// void dash_running(DASH_entry_types_E entry_type) {
//     switch (entry_type) {
//         case ENTRY:
//             ESP_LOGI("DASH", "Entering RUNNING state");
//             break;
//         case EXIT:
//             ESP_LOGI("DASH", "Exiting RUNNING state");
//             break;
//         case RUN:
//             // Running screen tasks can be performed here
//             break;
//         default:
//             break;
//     }
// }

// void dash_error(DASH_entry_types_E entry_type) {
//     switch (entry_type) {
//         case ENTRY:
//             ESP_LOGI("DASH", "Entering ERROR state");
//             break;
//         case EXIT:
//             ESP_LOGI("DASH", "Exiting ERROR state");
//             break;
//         case RUN:
//             // Error handling tasks can be performed here
//             break;
//         default:
//             break;
//     }
// }

// void messageQueueHandler(void){
//   while (xQueueReceive(q, &msg, 0) == pdTRUE) {
//     switch(msg.source){
//       case MODULE_BLE:
//         switch (msg.payload[0]){
//           case BLE_CONNECTION:
//             ble_connection_status = msg.payload[1];
//             break;
          
//           default:
//             break;
//         }
//         break;
//       default:
//         break;
//     }
//   }
// }

// float dashCheckTemperatureSensor() {
//   // Enable temperature sensor
//   ESP_ERROR_CHECK(temperature_sensor_enable(temp_handle));
//   // Get converted sensor data
//   float tsens_out;
//   ESP_ERROR_CHECK(temperature_sensor_get_celsius(temp_handle, &tsens_out));
//   // Disable the temperature sensor if it is not needed and save the power
//   ESP_ERROR_CHECK(temperature_sensor_disable(temp_handle));
//   return tsens_out;
// }

// void drawDashBoard() {

//   static uint8_t reading = 0;
//   static int ramp = 1;

//   if (millis() - runTime >= LOOP_DELAY) {
//     runTime = millis();

//     reading += ramp;
//     speedMeter.val = reading;
//     ringMeter(&speedMeter); // Draw analogue meter

//     if (reading >= 99) ramp = -1;
//     if (reading <=  0) ramp = 1;
//   }

// }


// // #########################################################################
// //  Draw the meter on the screen
// // #########################################################################
// // meter->x, meter->y is centre of meter
// // meter->r is the radius
// // meter->val is a number in range 0-100
// // meter->units is the meter scale label
// // meter->needs_init indicates if meter needs initialization
// void ringMeter(ringMeter_t *meter)
// {
//   // Initialize meter on first call or after reset
//   if (meter->needs_init) {
//     meter->needs_init = false;
//     meter->last_angle = 30;
//     tft->fillCircle(meter->x, meter->y, meter->r, DARKER_GREY);
//     tft->drawSmoothCircle(meter->x, meter->y, meter->r, TFT_SILVER, DARKER_GREY);
//     uint16_t tmp = meter->r - 3;
//     tft->drawArc(meter->x, meter->y, tmp, tmp - tmp / 5, meter->last_angle, 330, TFT_BLACK, DARKER_GREY);
//   }

//   int r = meter->r - 3;

//   // Range here is 0-100 so value is scaled to an angle 30-330
//   int val_angle = map(meter->val, 0, 100, 30, 330);

//   if (meter->last_angle != val_angle) {
//     // Allocate a value to the arc thickness dependant of radius
//     uint8_t thickness = r / 5;
//     if (r < 25) thickness = r / 3;

//     // Update the arc, only the zone between last_angle and new val_angle is updated
//     if (val_angle > meter->last_angle) {
//       tft->drawArc(meter->x, meter->y, r, r - thickness, meter->last_angle, val_angle, TFT_SKYBLUE, TFT_BLACK);
//     }
//     else {
//       tft->drawArc(meter->x, meter->y, r, r - thickness, val_angle, meter->last_angle, TFT_BLACK, DARKER_GREY);
//     }

//     // Update the numeric value display
//     tft->setTextFont(6);
//     tft->setTextDatum(CC_DATUM);
//     // tft->setTextColor(DARKER_GREY);
//     // tft->drawNumber(meter->last_val, meter->x, meter->y);
//     tft->setTextPadding(meter->r);
//     tft->setTextColor(TFT_RED, DARKER_GREY);
//     tft->drawNumber(meter->val, meter->x, meter->y + 10);
//     tft->setTextPadding(0);

//     // Store meter state for next redraw
//     meter->last_angle = val_angle;
//     meter->last_val = meter->val;
//   }
// }

// // LCD task running at 10ms intervals
// void task_lcd_10ms(void *parameter) {
//   const TickType_t xFrequency = pdMS_TO_TICKS(10);

//   while(1) {
//     Dash_Run_10ms();
//     vTaskDelay(xFrequency);
//   }
// }