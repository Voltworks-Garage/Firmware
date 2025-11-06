#include "dash.h"
#include "lcd_module.h"
#include "touch.h"
#include "cpu_monitor.h"

#include "driver/temperature_sensor.h"
#include "FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "esp_log.h"

#include "src/msg/messaging.h"

/******************************************************************************
 * State Machine
 *******************************************************************************/
#define DASH_STATES(state)\
state(dash_init)\
state(dash_home)\
state(dash_settings)\
state(dash_running)\
state(dash_error)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(DASH_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

typedef enum {
    DASH_STATES(STATE_FORM)
    NUMBER_OF_DASH_STATES
} DASH_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN,
    TOUCH,
    NUM_ENTRY_TYPES,
    NONE
} DASH_entry_types_E;

typedef void(*dashStatePtr)(DASH_entry_types_E);

DASH_STATES(FUNCTION_FORM)
static dashStatePtr dash_state_functions[] = {DASH_STATES(FUNC_PTR_FORM)};

static DASH_states_E dash_prevState = dash_init_state;
static DASH_states_E dash_curState = dash_init_state;
static DASH_states_E dash_nextState = dash_init_state;

/******************************************************************************
 * Declarations
 *******************************************************************************/

TFT_eSPI* tft = LCD_GetTFT();        // Create TFT instance "tft" 

static QueueHandle_t q = NULL;  // Message queue for DASH module

// Temperature sensor handle
temperature_sensor_handle_t temp_handle = NULL;
temperature_sensor_config_t temp_sensor_config = TEMPERATURE_SENSOR_CONFIG_DEFAULT(-10, 80);

#define DASH_HOME_BG_COLOR TFT_NAVY
#define DASH_HOME_TEXT_COLOR TFT_WHITE

#define ROW_1_X 10
#define TITLE_LOCATION_Y 10
#define TEMPERATURE_LOCATION_Y 50
#define VOLTAGE_LOCATION_Y 90
#define CURRENT_LOCATION_Y 130
#define POWER_LOCATION_Y 170
#define BLE_STATUS_LOCATION_Y 210
#define BLE_MAC_ADDRESS_LOCATION_Y 250

#define DARKER_GREY 0x18E3
#define LOOP_DELAY 50  // milliseconds between updates

// Ring meter state structure
typedef struct {
  int x;
  int y;
  int r;
  int val;
  const char *units;
  uint16_t last_angle;
  uint16_t last_val;
  bool needs_init;
} ringMeter_t;



uint32_t runTime = 0;       // time for next update

static ringMeter_t speedMeter = {0};

void ringMeter(ringMeter_t *meter);
float dashCheckTemperatureSensor();
void drawDashBoard();
void task_lcd_10ms(void *parameter);




void Dash_Init() {
  // Initialize temperature sensor
  ESP_ERROR_CHECK(temperature_sensor_install(&temp_sensor_config, &temp_handle));
  q = xQueueCreate(10, sizeof(Message_t));
  MsgBus_Register(MODULE_UI, q);

  dash_curState = dash_init_state;
  dash_prevState = dash_init_state;
  dash_nextState = dash_init_state;
  dash_state_functions[dash_curState](ENTRY);

  // Initialize speedMeter
  speedMeter.x = tft->width() * 3 / 4;
  speedMeter.y = tft->height() / 2;
  speedMeter.r = tft->height() / 3;
  speedMeter.val = 0;
  speedMeter.units = "MPH";
  speedMeter.last_angle = 30;
  speedMeter.last_val = 0;
  speedMeter.needs_init = true;

  // Create LCD task (10ms period)
  xTaskCreate(
    task_lcd_10ms,
    "task_lcd_10ms",
    10000,
    NULL,
    3,
    NULL
  );

}

void Dash_Run_10ms() {
  //Check for state transitions
  if (dash_nextState != dash_curState) {
      dash_state_functions[dash_curState](EXIT);
      dash_prevState = dash_curState;
      dash_curState = dash_nextState;
      dash_state_functions[dash_curState](ENTRY);
  }

  // Regular RUN call
  dash_state_functions[dash_curState](RUN);

  // Run current state with any events from message queue
  Message_t msg;
  while (xQueueReceive(q, &msg, 0) == pdTRUE) {
    DASH_entry_types_E thisEvent = NONE;
    // Process message
    switch (msg.id) {
      case MSG_ID_CAN_FRAME:
        // Handle CAN frame message
        break;
      case MSG_ID_BLE_COMMAND:
        // Handle BLE command message
        break;
      default:
        break;
    }
    dash_state_functions[dash_curState](thisEvent);
  }
}

void dash_init(DASH_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI("DASH", "Entering INIT state");

            break;
        case EXIT:
            ESP_LOGI("DASH", "Exiting INIT state");
            break;
        case RUN:
            // Initialization tasks can be performed here if needed
            dash_nextState = dash_home_state; // Transition to home state
            break;
        default:
            break;
    }
}

void dash_home(DASH_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI("DASH", "Entering HOME state");
            tft->fillScreen(DASH_HOME_BG_COLOR);
            LCD_DrawText("ESP32_s3", ROW_1_X, TITLE_LOCATION_Y, 3, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            LCD_DrawText("Temp:", ROW_1_X, TEMPERATURE_LOCATION_Y, 3, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            LCD_DrawText("Voltage:", ROW_1_X, VOLTAGE_LOCATION_Y, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            LCD_DrawText("Current:", ROW_1_X, CURRENT_LOCATION_Y, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            LCD_DrawText("Power:", ROW_1_X, POWER_LOCATION_Y, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            LCD_DrawText("BLE Status:", ROW_1_X, BLE_STATUS_LOCATION_Y, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            LCD_DrawText("MAC Address:", ROW_1_X, BLE_MAC_ADDRESS_LOCATION_Y, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            break;
        case EXIT:
            ESP_LOGI("DASH", "Exiting HOME state");
            break;
        case RUN:
            // Home screen tasks can be performed here
            {
                float temperature = dashCheckTemperatureSensor();
                char tempBuffer[10];
                snprintf(tempBuffer, sizeof(tempBuffer), "%.2f C", temperature);
                LCD_DrawText(tempBuffer, 100, TEMPERATURE_LOCATION_Y, 2, DASH_HOME_TEXT_COLOR, DASH_HOME_BG_COLOR);
            }
            drawDashBoard();
            uint16_t xval, yval;
            if (Touch_GetXY(&xval, &yval)) {
              tft->fillCircle(xval, yval, 5, TFT_RED);
            }
            break;

        default:
            break;
    }
}

void dash_settings(DASH_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI("DASH", "Entering SETTINGS state");
            break;
        case EXIT:
            ESP_LOGI("DASH", "Exiting SETTINGS state");
            break;
        case RUN:
            // Settings screen tasks can be performed here
            break;
        default:
            break;
    }
}

void dash_running(DASH_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI("DASH", "Entering RUNNING state");
            break;
        case EXIT:
            ESP_LOGI("DASH", "Exiting RUNNING state");
            break;
        case RUN:
            // Running screen tasks can be performed here
            break;
        default:
            break;
    }
}

void dash_error(DASH_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI("DASH", "Entering ERROR state");
            break;
        case EXIT:
            ESP_LOGI("DASH", "Exiting ERROR state");
            break;
        case RUN:
            // Error handling tasks can be performed here
            break;
        default:
            break;
    }
}

float dashCheckTemperatureSensor() {
  // Enable temperature sensor
  ESP_ERROR_CHECK(temperature_sensor_enable(temp_handle));
  // Get converted sensor data
  float tsens_out;
  ESP_ERROR_CHECK(temperature_sensor_get_celsius(temp_handle, &tsens_out));
  // Disable the temperature sensor if it is not needed and save the power
  ESP_ERROR_CHECK(temperature_sensor_disable(temp_handle));
  return tsens_out;
}

void drawDashBoard() {

  static uint8_t reading = 0;
  static int ramp = 1;

  if (millis() - runTime >= LOOP_DELAY) {
    runTime = millis();

    reading += ramp;
    speedMeter.val = reading;
    ringMeter(&speedMeter); // Draw analogue meter

    if (reading >= 99) ramp = -1;
    if (reading <=  0) ramp = 1;
  }

}


// #########################################################################
//  Draw the meter on the screen
// #########################################################################
// meter->x, meter->y is centre of meter
// meter->r is the radius
// meter->val is a number in range 0-100
// meter->units is the meter scale label
// meter->needs_init indicates if meter needs initialization
void ringMeter(ringMeter_t *meter)
{
  // Initialize meter on first call or after reset
  if (meter->needs_init) {
    meter->needs_init = false;
    meter->last_angle = 30;
    tft->fillCircle(meter->x, meter->y, meter->r, DARKER_GREY);
    tft->drawSmoothCircle(meter->x, meter->y, meter->r, TFT_SILVER, DARKER_GREY);
    uint16_t tmp = meter->r - 3;
    tft->drawArc(meter->x, meter->y, tmp, tmp - tmp / 5, meter->last_angle, 330, TFT_BLACK, DARKER_GREY);
  }

  int r = meter->r - 3;

  // Range here is 0-100 so value is scaled to an angle 30-330
  int val_angle = map(meter->val, 0, 100, 30, 330);

  if (meter->last_angle != val_angle) {
    // Allocate a value to the arc thickness dependant of radius
    uint8_t thickness = r / 5;
    if (r < 25) thickness = r / 3;

    // Update the arc, only the zone between last_angle and new val_angle is updated
    if (val_angle > meter->last_angle) {
      tft->drawArc(meter->x, meter->y, r, r - thickness, meter->last_angle, val_angle, TFT_SKYBLUE, TFT_BLACK);
    }
    else {
      tft->drawArc(meter->x, meter->y, r, r - thickness, val_angle, meter->last_angle, TFT_BLACK, DARKER_GREY);
    }

    // Update the numeric value display
    tft->setTextFont(6);
    tft->setTextDatum(CC_DATUM);
    // tft->setTextColor(DARKER_GREY);
    // tft->drawNumber(meter->last_val, meter->x, meter->y);
    tft->setTextPadding(meter->r);
    tft->setTextColor(TFT_RED, DARKER_GREY);
    tft->drawNumber(meter->val, meter->x, meter->y + 10);
    tft->setTextPadding(0);

    // Store meter state for next redraw
    meter->last_angle = val_angle;
    meter->last_val = meter->val;
  }
}

// LCD task running at 10ms intervals
void task_lcd_10ms(void *parameter) {
  const TickType_t xFrequency = pdMS_TO_TICKS(10);

  while(1) {
    Dash_Run_10ms();
    vTaskDelay(xFrequency);
  }
}