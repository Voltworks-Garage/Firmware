#include "lcd_module.h"

// Module-level TFT instance
static TFT_eSPI tft = TFT_eSPI();

void LCD_Init(void) {
  Serial.println("LCD: Initializing...");

  tft.init();
  tft.setRotation(1);  // Landscape
  tft.fillScreen(TFT_BLACK);

  Serial.println("LCD: Initialization complete");
}

TFT_eSPI* LCD_GetTFT(void) {
  return &tft;
}

void LCD_ShowTestScreen(void) {
  tft.fillScreen(TFT_BLACK);
  tft.setTextColor(TFT_WHITE, TFT_BLACK);
  tft.setTextSize(2);
  tft.drawString("ESP32-S3 + HX8357D", 10, 10);
}

void LCD_Clear(uint16_t color) {
  tft.fillScreen(color);
}

void LCD_DrawText(const char* text, int16_t x, int16_t y, uint8_t size, uint16_t color) {
  tft.setTextColor(color, TFT_BLACK);
  tft.setTextSize(size);
  tft.drawString(text, x, y);
}
