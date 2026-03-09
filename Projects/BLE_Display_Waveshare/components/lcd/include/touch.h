#ifndef TOUCH_H
#define TOUCH_H

#include <stdint.h>
#include <stdbool.h>
#include "esp_err.h"
#include "esp_lcd_touch.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief Initialize GT911 capacitive touch controller
 */
esp_err_t Touch_Init(void);

/**
 * @brief Deinitialize touch controller
 */
esp_err_t Touch_DeInit(void);

/**
 * @brief Get current touch coordinates
 *
 * @param x Pointer to store X coordinate
 * @param y Pointer to store Y coordinate
 * @return true if touch is pressed, false otherwise
 */
bool Touch_GetXY(uint16_t *x, uint16_t *y);

/**
 * @brief Get touch panel handle (for use with lvgl_port)
 *
 * @return Touch panel handle or NULL if not initialized
 */
esp_lcd_touch_handle_t Touch_GetHandle(void);

#ifdef __cplusplus
}
#endif

#endif // TOUCH_H
