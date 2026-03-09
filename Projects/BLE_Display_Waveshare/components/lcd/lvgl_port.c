/*
 * SPDX-FileCopyrightText: 2023-2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Adapted for Voltworks BLE Display - 1024x600 RGB LCD
 * Updated for LVGL 9.x API
 */

#include "freertos/FreeRTOS.h"
#include "freertos/semphr.h"
#include "freertos/task.h"
#include "esp_lcd_panel_ops.h"
#include "esp_lcd_panel_rgb.h"
#include "esp_lcd_touch.h"
#include "esp_timer.h"
#include "esp_log.h"
#include "lvgl.h"
#include "lvgl_port.h"

static const char *TAG = "lvgl_port";
static SemaphoreHandle_t lvgl_mux;
static SemaphoreHandle_t vsync_sem = NULL;
static volatile bool flush_pending = false;
static TaskHandle_t lvgl_task_handle = NULL;
static void (*lvgl_port_ui_callback)(void) = NULL;
static lv_display_t *s_display = NULL;
static uint8_t *pending_fb = NULL;
static uint8_t *last_pending_fb = NULL;
static bool render_complete = false;

static uint8_t *s_fb0 = NULL;
static uint8_t *s_fb1 = NULL;

static void lvgl_port_task(void *parameter);
bool lvgl_port_lock(int timeout_ms);
void lvgl_port_unlock(void);

/**
 * @brief VSYNC event callback (runs in ISR context)
 *
 * Only signals the flush callback when a flush is actually pending,
 * preventing stale VSYNC signals from causing premature flush completion.
 */
static bool IRAM_ATTR on_vsync_event(esp_lcd_panel_handle_t panel,
                                      const esp_lcd_rgb_panel_event_data_t *event_data,
                                      void *user_ctx)
{
    // ESP_EARLY_LOGI(TAG, "VSYNC");
    BaseType_t wake = pdFALSE;
    xTaskNotifyFromISR(lvgl_task_handle, ULONG_MAX, eNoAction, &wake); // Notify the LVGL task
    return wake == pdTRUE; // Return whether a context switch is needed
    // return false;
}

static bool IRAM_ATTR notify_lvgl_flush_ready(esp_lcd_panel_handle_t panel,
                                            const esp_lcd_rgb_panel_event_data_t *event_data,
                                            void *user_ctx)
{
    // ESP_EARLY_LOGI(TAG, "COLLOR");

    // lv_display_t *disp = (lv_display_t *)user_ctx;
    // lv_display_flush_ready(disp);
    return false;
}

static bool IRAM_ATTR frame_buf_complete(esp_lcd_panel_handle_t panel,
                                            const esp_lcd_rgb_panel_event_data_t *event_data,
                                            void *user_ctx)
{
    // ESP_EARLY_LOGI(TAG, "FRAME");

    // BaseType_t wake = pdFALSE;
    // xTaskNotifyFromISR(lvgl_task_handle, ULONG_MAX, eNoAction, &wake); // Notify the LVGL task
    // return wake == pdTRUE; // Return whether a context switch is needed

    return false;
}

/**
 * @brief Flush callback for LVGL display (Direct mode, double FB)
 *
 * px_map points to one of the two RGB frame buffers that LVGL just
 * finished rendering into. The RGB driver recognises its own buffer
 * pointer and swaps DMA to it (zero memcpy).
 */
static void flush_callback(lv_display_t *disp, const lv_area_t *area, uint8_t *px_map)
{
    esp_lcd_panel_handle_t panel_handle = (esp_lcd_panel_handle_t) lv_display_get_user_data(disp);

    if (lv_display_flush_is_last(disp)) {
        ESP_LOGI(TAG, "Flush cb: fb=%p (final)", px_map);
        /* Wait for the VSYNC */
        ulTaskNotifyValueClear(NULL, ULONG_MAX);
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        esp_lcd_panel_draw_bitmap(panel_handle, 0, 0, LVGL_PORT_H_RES, LVGL_PORT_V_RES, px_map);
        ESP_LOGI(TAG,"FLush complete");
    } else {
        ESP_LOGI(TAG, "Flush cb: fb=%p (pending)", px_map);
        
    }

    lv_display_flush_ready(disp);
}

/**
 * @brief Initialize LVGL display driver (Direct mode, double FB)
 *
 * Gets the two RGB frame buffer pointers from the panel driver and
 * hands them directly to LVGL. No separate draw buffer is allocated.
 * LVGL renders into one FB while DMA reads the other — zero memcpy.
 */
static lv_display_t *display_init(esp_lcd_panel_handle_t panel_handle)
{
    assert(panel_handle);

    void *fb0 = NULL;
    void *fb1 = NULL;
    ESP_ERROR_CHECK(esp_lcd_rgb_panel_get_frame_buffer(panel_handle, 2, &fb0, &fb1));
    assert(fb0 && fb1);
    s_fb0 = (uint8_t *)fb0;
    s_fb1 = (uint8_t *)fb1;

    int buffer_size = LVGL_PORT_H_RES * LVGL_PORT_V_RES * sizeof(lv_color_t);
    ESP_LOGI(TAG, "Direct mode: fb0=%p fb1=%p (%d KB each)", fb0, fb1, buffer_size / 1024);

    s_display = lv_display_create(LVGL_PORT_H_RES, LVGL_PORT_V_RES);
    assert(s_display);

    /* Create VSYNC semaphore and register callback for tear-free rendering */
    vsync_sem = xSemaphoreCreateBinary();
    assert(vsync_sem);

    esp_lcd_rgb_panel_event_callbacks_t cbs = {
        .on_vsync = on_vsync_event,
        .on_color_trans_done = notify_lvgl_flush_ready,
        .on_frame_buf_complete = frame_buf_complete
    };
    ESP_ERROR_CHECK(esp_lcd_rgb_panel_register_event_callbacks(panel_handle, &cbs, s_display));

    lv_display_set_flush_cb(s_display, flush_callback);
    lv_display_set_buffers(s_display, fb0, fb1, buffer_size, LV_DISPLAY_RENDER_MODE_DIRECT);
    lv_display_set_user_data(s_display, panel_handle);
    esp_lcd_panel_draw_bitmap(panel_handle, 0, 0, LVGL_PORT_H_RES, LVGL_PORT_V_RES, fb1);
    return s_display;
}

/**
 * @brief Touch panel read callback for LVGL
 */
static void touchpad_read(lv_indev_t *indev, lv_indev_data_t *data)
{
    esp_lcd_touch_handle_t tp = (esp_lcd_touch_handle_t)lv_indev_get_user_data(indev);
    assert(tp);

    uint16_t touchpad_x;
    uint16_t touchpad_y;
    uint8_t touchpad_cnt = 0;

    /* Read data from touch controller into memory */
    esp_lcd_touch_read_data(tp);

    /* Get touch coordinates */
    bool touchpad_pressed = esp_lcd_touch_get_coordinates(tp, &touchpad_x, &touchpad_y, NULL, &touchpad_cnt, 1);

    if (touchpad_pressed && touchpad_cnt > 0) {
        data->point.x = touchpad_x;
        data->point.y = touchpad_y;
        data->state = LV_INDEV_STATE_PRESSED;
    } else {
        data->state = LV_INDEV_STATE_RELEASED;
    }
}

/**
 * @brief Initialize LVGL touch input device
 */
static lv_indev_t *indev_init(esp_lcd_touch_handle_t tp)
{
    assert(tp);

    /* Register a touchpad input device */
    lv_indev_t *indev = lv_indev_create();
    assert(indev);

    lv_indev_set_type(indev, LV_INDEV_TYPE_POINTER);
    lv_indev_set_read_cb(indev, touchpad_read);
    lv_indev_set_user_data(indev, tp);

    return indev;
}

/**
 * @brief LVGL tick increment callback (called every 2ms)
 */
static void tick_increment(void *arg)
{
    lv_tick_inc(LVGL_PORT_TICK_PERIOD_MS);
}

/**
 * @brief Initialize LVGL tick timer
 */
static esp_err_t tick_init(void)
{
    const esp_timer_create_args_t lvgl_tick_timer_args = {
        .callback = &tick_increment,
        .name = "LVGL tick"
    };
    esp_timer_handle_t lvgl_tick_timer = NULL;
    ESP_ERROR_CHECK(esp_timer_create(&lvgl_tick_timer_args, &lvgl_tick_timer));
    return esp_timer_start_periodic(lvgl_tick_timer, LVGL_PORT_TICK_PERIOD_MS * 1000);
}

/**
 * @brief LVGL task - processes timers and rendering
 */
static void lvgl_port_task(void *parameter)
{
    ESP_LOGI(TAG, "Starting LVGL task");

    uint32_t task_delay_ms = LVGL_PORT_TASK_MAX_DELAY_MS;

    while (1) {
        lvgl_port_lock(portMAX_DELAY);
        task_delay_ms = lv_timer_handler();
        lvgl_port_unlock();

        lvgl_port_ui_callback();

        /* Clamp delay to reasonable limits */
        if (task_delay_ms > LVGL_PORT_TASK_MAX_DELAY_MS) {
            task_delay_ms = LVGL_PORT_TASK_MAX_DELAY_MS;
        } else if (task_delay_ms < LVGL_PORT_TASK_MIN_DELAY_MS) {
            task_delay_ms = LVGL_PORT_TASK_MIN_DELAY_MS;
        }

        vTaskDelay(pdMS_TO_TICKS(task_delay_ms));
    }
}

/**
 * @brief Initialize LVGL port with RGB LCD and touch panel
 */
esp_err_t lvgl_port_init(esp_lcd_panel_handle_t lcd_handle, esp_lcd_touch_handle_t tp_handle)
{
    lv_init();
    ESP_ERROR_CHECK(tick_init());

    lv_display_t *disp = display_init(lcd_handle);
    assert(disp);

    //Set the background to black before any UI is created to avoid white flashes on startup
    lv_obj_t *scr = lv_display_get_screen_active(disp);
    lv_obj_set_style_bg_color(scr, lv_color_black(), LV_PART_MAIN);
    lv_obj_set_style_bg_opa(scr, LV_OPA_COVER, LV_PART_MAIN);

    if (tp_handle) {
        lv_indev_t *indev = indev_init(tp_handle);
        assert(indev);
        ESP_LOGI(TAG, "Touch panel initialized");
    }

    /* Create mutex for thread-safe LVGL access */
    lvgl_mux = xSemaphoreCreateRecursiveMutex();
    assert(lvgl_mux);

    /* Create LVGL task */
    ESP_LOGI(TAG, "Creating LVGL task");
    BaseType_t ret = xTaskCreate(
        lvgl_port_task,
        "lvgl",
        LVGL_PORT_TASK_STACK_SIZE,
        NULL,
        LVGL_PORT_TASK_PRIORITY,
        &lvgl_task_handle
    );

    if (ret != pdPASS) {
        ESP_LOGE(TAG, "Failed to create LVGL task");
        return ESP_FAIL;
    }

    ESP_LOGI(TAG, "LVGL port initialized successfully");
    return ESP_OK;
}

/**
 * @brief Take LVGL mutex (must call before any LVGL API from another task)
 */
bool lvgl_port_lock(int timeout_ms)
{
    assert(lvgl_mux && "lvgl_port_init must be called first");

    const TickType_t timeout_ticks = (timeout_ms < 0) ? portMAX_DELAY : pdMS_TO_TICKS(timeout_ms);
    return xSemaphoreTakeRecursive(lvgl_mux, timeout_ticks) == pdTRUE;
}

/**
 * @brief Give LVGL mutex (must call after LVGL API usage)
 */
void lvgl_port_unlock(void)
{
    assert(lvgl_mux && "lvgl_port_init must be called first");
    xSemaphoreGiveRecursive(lvgl_mux);
}


void lvgl_register_ui_callback(void (*callback)(void))
{
    lvgl_port_ui_callback = callback;
    /* This function can be used to register a UI update callback that will be called from the LVGL task */
    /* Implementation depends on how you want to structure your UI updates */
}
