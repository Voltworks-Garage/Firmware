#include "lcd_module.h"
#include "driver/gpio.h"
#include "esp_log.h"

#define POWER_PIN GPIO_NUM_46

// Module-level TFT instance
static TFT_eSPI tft = TFT_eSPI();

void LCD_Init(void) {
  Serial.println("LCD: Initializing...");

  gpio_set_direction(POWER_PIN, GPIO_MODE_OUTPUT);
  gpio_set_level(POWER_PIN, 1);

  tft.init();
  tft.setRotation(3);  // Landscape
  tft.fillScreen(TFT_BLACK);

  Serial.println("LCD: Initialization complete");
}

void LCD_DeInit(void){
  gpio_set_level(POWER_PIN, 0);
}

TFT_eSPI* LCD_GetTFT(void) {
  return &tft;
}

void LCD_ShowTestScreen(void) {
  tft.fillScreen(TFT_BLACK);
  tft.fillScreen(TFT_GREEN);
  tft.fillScreen(TFT_BLUE);
  tft.fillScreen(TFT_PURPLE);
  tft.setTextColor(TFT_WHITE, TFT_BLACK);
  tft.setTextSize(4);
  tft.drawString("ESP32-S3", 10, 10);
  tft.drawString("SARAH IS A POO", 10, 50);
  tft.drawString("SARAH IS A POO", 10, 100);
  tft.drawString("SARAH IS A POO", 10, 150);
  tft.drawString("SARAH IS A POO", 10, 200);
  tft.drawString("SARAH IS A POO", 10, 250);
  tft.drawString("SARAH IS A POO", 10, 300);
}

void LCD_Clear(uint16_t color) {
  tft.fillScreen(color);
}

void LCD_DrawText(const char* text, int16_t x, int16_t y, uint8_t size, uint16_t color) {
  tft.setTextColor(color, TFT_BLACK);
  tft.setTextSize(size);
  tft.drawString(text, x, y);
}


// #define LGFX_USE_V1
// class LGFX_Display : public lgfx::LGFX_Device  // Changed from LGFX
// {
//   lgfx::Panel_HX8357D _panel_instance;
//   lgfx::Bus_Parallel8 _bus_instance;

// public:
//   LGFX_Display(void)
//   {
//     {
//       // Configure 8-bit parallel bus
//       auto cfg = _bus_instance.config();
      
//       cfg.freq_write = 20000000;
//       cfg.pin_wr = GPIO_NUM_40;
//       cfg.pin_rd = GPIO_NUM_39;
//       cfg.pin_rs = GPIO_NUM_41;

//       cfg.pin_d0 = GPIO_NUM_8;
//       cfg.pin_d1 = GPIO_NUM_9;
//       cfg.pin_d2 = GPIO_NUM_10;
//       cfg.pin_d3 = GPIO_NUM_11;
//       cfg.pin_d4 = GPIO_NUM_12;
//       cfg.pin_d5 = GPIO_NUM_13;
//       cfg.pin_d6 = GPIO_NUM_14;
//       cfg.pin_d7 = GPIO_NUM_15;

//       _bus_instance.config(cfg);
//       _panel_instance.setBus(&_bus_instance);
//     }

//     {
//       auto cfg = _panel_instance.config();
      
//       cfg.pin_cs   = 15;
//       cfg.pin_rst  = 4;
//       cfg.pin_busy = -1;
      
//       cfg.panel_width  = 320;
//       cfg.panel_height = 480;
//       cfg.offset_x = 0;
//       cfg.offset_y = 0;
      
//       cfg.invert = false;
//       cfg.rgb_order = false;
//       cfg.dlen_16bit = false;
//       cfg.bus_shared = false;

//       _panel_instance.config(cfg);
//     }

//     setPanel(&_panel_instance);
//   }
// };

// // Create display instance with new class name
// LGFX_Display tft;



