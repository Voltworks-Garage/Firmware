#include "dash.h"
#include "lcd_module.h"
#include "touch.h"

#include "driver/temperature_sensor.h"
#include "FreeRTOS.h"
#include "freertos/queue.h"
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



uint32_t runTime = 0;       // time for next update

int reading = 0; // Value to be displayed
int d = 0; // Variable used for the sine wave test waveform
bool range_error = 0;
int8_t ramp = 1;

bool initMeter = true;

void ringMeter(int x, int y, int r, int val, const char *units);
float dashCheckTemperatureSensor();
void drawDashBoard();




void Dash_Init() {
  // Initialize temperature sensor
  ESP_ERROR_CHECK(temperature_sensor_install(&temp_sensor_config, &temp_handle));
  q = xQueueCreate(10, sizeof(Message_t));
  MsgBus_Register(MODULE_UI, q);

  dash_curState = dash_init_state;
  dash_prevState = dash_init_state;
  dash_nextState = dash_init_state;
  dash_state_functions[dash_curState](ENTRY);

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
            tft->fillScreen(TFT_NAVY);
            LCD_DrawText("ESP32_s3", ROW_1_X, TITLE_LOCATION_Y, 3, TFT_WHITE);
            LCD_DrawText("Temp:", ROW_1_X, TEMPERATURE_LOCATION_Y, 3, TFT_WHITE);
            LCD_DrawText("Voltage:", ROW_1_X, VOLTAGE_LOCATION_Y, 2, TFT_WHITE);
            LCD_DrawText("Current:", ROW_1_X, CURRENT_LOCATION_Y, 2, TFT_WHITE);
            LCD_DrawText("Power:", ROW_1_X, POWER_LOCATION_Y, 2, TFT_WHITE);
            LCD_DrawText("BLE Status:", ROW_1_X, BLE_STATUS_LOCATION_Y, 2, TFT_WHITE);
              //LCD_DrawText("MAC Address:", ROW_1_X, BLE_MAC_ADDRESS_LOCATION_Y, 2, TFT_WHITE);
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
                // LCD_DrawText(tempBuffer, 100, TEMPERATURE_LOCATION_Y, 2, TFT_WHITE);
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

  static uint16_t maxRadius = 0;
  static int8_t ramp = 1;
  static uint8_t radius = 0;
  static int16_t xpos = tft->width()*3 / 4;
  static int16_t ypos = tft->height() / 2;
  static bool newMeter = true;

  if (maxRadius == 0) {
    maxRadius = tft->width();
    if (tft->height() < maxRadius) maxRadius = tft->height();
    maxRadius = (0.6 * maxRadius) / 2;
    radius = maxRadius;
  }

  // Choose a random meter radius for test purposes and draw for one range cycle
  // Clear old meter first
  if (newMeter) {
    tft->fillCircle(xpos, ypos, radius + 1, TFT_NAVY);
    radius = random(20, maxRadius); // Random radius
    initMeter = true;
    reading = 1;
    ramp = 1;
    newMeter = false;
  }

  if (millis() - runTime >= LOOP_DELAY) {
    runTime = millis();

    reading += ramp;
    ringMeter(xpos, ypos, radius, reading, "Watts"); // Draw analogue meter

    if (reading > 99) ramp = -1;
    if (reading <=  0) ramp = 1;

    if (reading <= 0) {
      newMeter = true;
    }
  }
  
}


// #########################################################################
//  Draw the meter on the screen, returns x coord of right-hand side
// #########################################################################
// x,y is centre of meter, r the radius, val a number in range 0-100
// units is the meter scale label
void ringMeter(int x, int y, int r, int val, const char *units)
{
  static uint16_t last_angle = 30;

  if (initMeter) {
    initMeter = false;
    last_angle = 30;
    tft->fillCircle(x, y, r, DARKER_GREY);
    tft->drawSmoothCircle(x, y, r, TFT_SILVER, DARKER_GREY);
    uint16_t tmp = r - 3;
    tft->drawArc(x, y, tmp, tmp - tmp / 5, last_angle, 330, TFT_BLACK, DARKER_GREY);
  }

  r -= 3;

  // Range here is 0-100 so value is scaled to an angle 30-330
  int val_angle = map(val, 0, 100, 30, 330);


  if (last_angle != val_angle) {


    // Allocate a value to the arc thickness dependant of radius
    uint8_t thickness = r / 5;
    if ( r < 25 ) thickness = r / 3;

    // Update the arc, only the zone between last_angle and new val_angle is updated
    if (val_angle > last_angle) {
      tft->drawArc(x, y, r, r - thickness, last_angle, val_angle, TFT_SKYBLUE, TFT_BLACK); // TFT_SKYBLUE random(0x10000)
    }
    else {
      tft->drawArc(x, y, r, r - thickness, val_angle, last_angle, TFT_BLACK, DARKER_GREY);
    }
    last_angle = val_angle; // Store meter arc position for next redraw
  }
}