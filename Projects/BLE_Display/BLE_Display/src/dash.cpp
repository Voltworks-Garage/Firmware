#include "dash.h"
#include "lcd_module.h"
#include "driver/temperature_sensor.h"

TFT_eSPI* tft = LCD_GetTFT();        // Create TFT instance "tft" 

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

  temperature_sensor_handle_t temp_handle = NULL;
  temperature_sensor_config_t temp_sensor_config = TEMPERATURE_SENSOR_CONFIG_DEFAULT(-10, 80);

void drawDashBoard() {

  static bool once =true;
  if (once) {
    ESP_ERROR_CHECK(temperature_sensor_install(&temp_sensor_config, &temp_handle));
    once = false;
  }

  // Enable temperature sensor
  ESP_ERROR_CHECK(temperature_sensor_enable(temp_handle));
  // Get converted sensor data
  float tsens_out;
  ESP_ERROR_CHECK(temperature_sensor_get_celsius(temp_handle, &tsens_out));
  printf("Temperature in %f °C\n", tsens_out);
  // Disable the temperature sensor if it is not needed and save the power
  ESP_ERROR_CHECK(temperature_sensor_disable(temp_handle));
  char tempStr[20];
  sprintf(tempStr, "%.2f C", tsens_out);

  tft->fillScreen(TFT_NAVY);
  LCD_DrawText("Hi Dada and Desi, I love you", ROW_1_X, TITLE_LOCATION_Y, 3, TFT_WHITE);
  LCD_DrawText("And Mama and Riley and Zoe:", ROW_1_X, TEMPERATURE_LOCATION_Y, 3, TFT_WHITE);
  // LCD_DrawText(tempStr, 100, TEMPERATURE_LOCATION_Y, 2, TFT_WHITE);
  LCD_DrawText("Voltage:", ROW_1_X, VOLTAGE_LOCATION_Y, 2, TFT_WHITE);
  LCD_DrawText("Current:", ROW_1_X, CURRENT_LOCATION_Y, 2, TFT_WHITE);
  LCD_DrawText("Power:", ROW_1_X, POWER_LOCATION_Y, 2, TFT_WHITE);
  LCD_DrawText("BLE Status:", ROW_1_X, BLE_STATUS_LOCATION_Y, 2, TFT_WHITE);
  //LCD_DrawText("MAC Address:", ROW_1_X, BLE_MAC_ADDRESS_LOCATION_Y,

  static uint16_t maxRadius = 0;
  int8_t ramp = 1;
  static uint8_t radius = 0;
  static int16_t xpos = tft->width()*3 / 4;
  static int16_t ypos = tft->height() / 2;
  bool newMeter = false;

  if (maxRadius == 0) {
    maxRadius = tft->width();
    if (tft->height() < maxRadius) maxRadius = tft->height();
    maxRadius = (0.6 * maxRadius) / 2;
    radius = maxRadius;
  }

  // Choose a random meter radius for test purposes and draw for one range cycle
  // Clear old meter first
  tft->fillCircle(xpos, ypos, radius + 1, TFT_NAVY);
  radius = random(20, maxRadius); // Random radius
  initMeter = true;

  initMeter = true;
  reading = 0;
  ramp = 1;
  while (!newMeter) {
    vTaskDelay(pdMS_TO_TICKS(10)); // Small delay to allow other tasks to run
    if (millis() - runTime >= LOOP_DELAY) {
      runTime = millis();

      reading += ramp;
      ringMeter(xpos, ypos, radius, reading, "Watts"); // Draw analogue meter

      if (reading > 99) ramp = -1;
      if (reading <=  0) ramp = 1;

      if (reading > 99) vTaskDelay(pdMS_TO_TICKS(1000));
      if (reading <= 0) {
        vTaskDelay(pdMS_TO_TICKS(1000));
        newMeter = true;
      }
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