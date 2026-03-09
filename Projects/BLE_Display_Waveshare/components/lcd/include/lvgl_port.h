/*
 * SPDX-FileCopyrightText: 2023-2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <stdint.h>

#include "esp_err.h"
#include "esp_lcd_types.h"
#include "esp_lcd_touch.h"
#include "lvgl.h"

#ifdef __cplusplus
extern "C" {
#endif

/**
 * LVGL related parameters - configured for 1024x600 RGB display
 */
#define LVGL_PORT_H_RES             (1024)
#define LVGL_PORT_V_RES             (600)
#define LVGL_PORT_TICK_PERIOD_MS    (5)

/**
 * LVGL timer task related parameters
 */
#define LVGL_PORT_TASK_MAX_DELAY_MS (100)
#define LVGL_PORT_TASK_MIN_DELAY_MS (66)
#define LVGL_PORT_TASK_STACK_SIZE   (8192)
#define LVGL_PORT_TASK_PRIORITY     (4)
#define LVGL_PORT_TASK_CORE         (0)   // Pin to core 1; bounce buffer ISR runs on core 0

/**
 * LVGL buffer related parameters
 * (These parameters will be useless if the avoid tearing function is enabled)
 */
#define LVGL_PORT_BUFFER_MALLOC_CAPS    (MALLOC_CAP_SPIRAM)
#define LVGL_PORT_BUFFER_HEIGHT         (LVGL_PORT_V_RES)

/**
 * Avoid tearing related configurations
 * Mode 0: Single framebuffer + partial LVGL draw buffer (saves PSRAM)
 * Mode 1: LCD double-buffer & LVGL full-refresh
 * Mode 2: LCD triple-buffer & LVGL full-refresh
 * Mode 3: LCD double-buffer & LVGL direct-mode (best performance)
 */
#define LVGL_PORT_AVOID_TEAR_ENABLE     (1)  // Enabled: flush waits for VSYNC (tear-free)
#define LVGL_PORT_AVOID_TEAR_MODE       (3)  // Mode 3: Double FB + LVGL direct mode (zero memcpy)

/**
 * Rotation degree (0 = no rotation)
 */
#define EXAMPLE_LVGL_PORT_ROTATION_DEGREE  (0)

/**
 * Automatically set configurations based on avoid tear mode
 */
#if LVGL_PORT_AVOID_TEAR_MODE == 1
#define LVGL_PORT_LCD_RGB_BUFFER_NUMS   (2)
#define LVGL_PORT_FULL_REFRESH          (1)
#define LVGL_PORT_DIRECT_MODE           (0)
#elif LVGL_PORT_AVOID_TEAR_MODE == 2
#define LVGL_PORT_LCD_RGB_BUFFER_NUMS   (3)
#define LVGL_PORT_FULL_REFRESH          (1)
#define LVGL_PORT_DIRECT_MODE           (0)
#elif LVGL_PORT_AVOID_TEAR_MODE == 3
#define LVGL_PORT_LCD_RGB_BUFFER_NUMS   (2)
#define LVGL_PORT_FULL_REFRESH          (0)
#define LVGL_PORT_DIRECT_MODE           (1)
#else
#define LVGL_PORT_LCD_RGB_BUFFER_NUMS   (1)
#define LVGL_PORT_FULL_REFRESH          (0)
#define LVGL_PORT_DIRECT_MODE           (0)
#endif

/**
 * @brief Initialize LVGL port
 *
 * @param[in] lcd_handle: LCD panel handle
 * @param[in] tp_handle: Touch panel handle (can be NULL if no touch)
 *
 * @return
 *      - ESP_OK: Success
 *      - ESP_ERR_INVALID_ARG: Invalid argument
 *      - Others: Fail
 */
esp_err_t lvgl_port_init(esp_lcd_panel_handle_t lcd_handle, esp_lcd_touch_handle_t tp_handle);


/**
 * @brief Register a UI update callback to be called from the LVGL task
 *
 * The registered callback will be invoked periodically by the LVGL task
 * to allow the UI layer to update its state machine and screen content.
 *
 * @param callback Function pointer to UI update callback (can be NULL to unregister)
 */
void lvgl_register_ui_callback(void (*callback)(void));

#ifdef __cplusplus
}
#endif
