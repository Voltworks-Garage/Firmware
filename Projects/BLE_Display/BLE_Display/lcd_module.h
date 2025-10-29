#ifndef LCD_MODULE_H
#define LCD_MODULE_H

#include <TFT_eSPI.h>
// #include <LovyanGFX.hpp>
// #include <LGFX_AUTODETECT.hpp>

// Initialize LCD module
void LCD_Init(void);

// DeInitialize LCD module
void LCD_DeInit(void);

// Get TFT instance for direct drawing operations
// TFT_eSPI* LCD_GetTFT(void);

// Display a test screen
void LCD_ShowTestScreen(void);

// Clear screen
void LCD_Clear(uint16_t color);

// Display text at position
void LCD_DrawText(const char* text, int16_t x, int16_t y, uint8_t size, uint16_t color);

#endif // LCD_MODULE_H
