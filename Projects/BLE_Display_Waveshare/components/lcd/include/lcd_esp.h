#pragma once
#ifndef RGB_LCD_PANEL_H
#define RGB_LCD_PANEL_H

#include "esp_err.h"
#include "esp_lcd_types.h"
#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Initialize RGB LCD panel (1024x600)
 *
 * Initializes the ESP32-S3 RGB LCD peripheral with 16-bit parallel interface.
 * Configures frame buffers in PSRAM and registers VSYNC callback.
 *
 * @param out_panel Optional pointer to receive the created panel handle
 * @return ESP_OK on success
 */
esp_err_t rgb_lcd_init_panel(esp_lcd_panel_handle_t *out_panel);

/**
 * @brief Deinitialize RGB LCD panel and release resources
 *
 * @return ESP_OK on success
 */
esp_err_t rgb_lcd_deinit_panel(void);

/**
 * @brief Set backlight brightness via I2C GPIO expander
 *
 * Note: Current implementation only supports on/off control.
 * Pass 0 to turn off, any value > 0 to turn on.
 *
 * @param brightness_percent Brightness level (0 = off, >0 = on)
 * @return ESP_OK on success
 */
esp_err_t rgb_lcd_set_backlight(uint8_t brightness_percent);

/**
 * @brief Turn display pixels on or off
 *
 * @param on true to turn on, false to turn off
 * @return ESP_OK on success
 */
esp_err_t rgb_lcd_display_on_off(bool on);

#ifdef __cplusplus
}
#endif

#endif // RGB_LCD_PANEL_H
