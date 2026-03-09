/*
 * SPDX-FileCopyrightText: 2022-2025 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: CC0-1.0
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/lock.h>
#include <sys/param.h>
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_timer.h"
#include "esp_lcd_panel_ops.h"
#include "esp_lcd_panel_rgb.h"
#include "driver/gpio.h"
#include "esp_err.h"
#include "esp_log.h"
#include "lvgl.h"
#include "lvgl_port.h"

static const char *TAG = "example";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////// Please update the following configuration according to your LCD spec //////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Refresh Rate = 18000000/(1+40+20+800)/(1+10+5+480) = 42Hz
#define EXAMPLE_LCD_PIXEL_CLOCK_HZ     (26 * 1000 * 1000)
#define EXAMPLE_LCD_H_RES              LVGL_PORT_H_RES
#define EXAMPLE_LCD_V_RES              LVGL_PORT_V_RES


#define EXAMPLE_LCD_NUM_FB             2

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////// Please update the following configuration according to your Application ///////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define EXAMPLE_LVGL_TICK_PERIOD_MS    2
#define EXAMPLE_LVGL_TASK_STACK_SIZE   (5 * 1024)
#define EXAMPLE_LVGL_TASK_PRIORITY     2
#define EXAMPLE_LVGL_TASK_MAX_DELAY_MS 100
#define EXAMPLE_LVGL_TASK_MIN_DELAY_MS 99

// LVGL library is not thread-safe, this example will call LVGL APIs from different tasks, so use a mutex to protect it
static _lock_t lvgl_api_lock;

static TaskHandle_t lvgl_task_handle = NULL;

static void (*lvgl_port_ui_callback)(void) = NULL;
static void example_lvgl_port_task(void *arg);


static bool IRAM_ATTR example_notify_lvgl_flush_ready(esp_lcd_panel_handle_t panel, const esp_lcd_rgb_panel_event_data_t *event_data, void *user_ctx)
{   
    ESP_EARLY_LOGI(TAG, "VSYNC");
    BaseType_t wake = pdFALSE;
    xTaskNotifyFromISR(lvgl_task_handle, ULONG_MAX, eNoAction, &wake); // Notify the LVGL task
    return wake == pdTRUE; // Return whether a context switch is needed
    // lv_display_t *disp = (lv_display_t *)user_ctx;
    // lv_display_flush_ready(disp);
    // return false;
}

static void example_lvgl_flush_cb(lv_display_t *disp, const lv_area_t *area, uint8_t *px_map)
{
    esp_lcd_panel_handle_t lcd_handle = lv_display_get_user_data(disp);
    // int offsetx1 = area->x1;
    // int offsetx2 = area->x2;
    // int offsety1 = area->y1;
    // int offsety2 = area->y2;
    // pass the draw buffer to the driver
    // esp_lcd_panel_draw_bitmap(lcd_handle, offsetx1, offsety1, offsetx2 + 1, offsety2 + 1, px_map);
    if (lv_display_flush_is_last(disp)) {
        ESP_LOGI(TAG, "Flush cb: fb=%p (final)", px_map);
        // esp_lcd_panel_draw_bitmap(lcd_handle, 0, 0, EXAMPLE_LCD_H_RES, EXAMPLE_LCD_V_RES, px_map);
        /* Wait for the current frame buffer to complete transmission */
        ulTaskNotifyValueClear(NULL, ULONG_MAX);
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        esp_lcd_panel_draw_bitmap(lcd_handle, 0, 0, EXAMPLE_LCD_H_RES, EXAMPLE_LCD_V_RES, px_map);
        lv_display_flush_ready(disp);
        
    } else {
        ESP_LOGI(TAG, "Flush cb: fb=%p (partial)", px_map);
        lv_display_flush_ready(disp);
    }
    
}

static void example_increase_lvgl_tick(void *arg)
{
    /* Tell LVGL how many milliseconds has elapsed */
    lv_tick_inc(EXAMPLE_LVGL_TICK_PERIOD_MS);
}

static void example_lvgl_port_task(void *arg)
{
    ESP_LOGI(TAG, "Starting LVGL task");
    uint32_t time_till_next_ms = 0;
    while (1) {
        _lock_acquire(&lvgl_api_lock);
        time_till_next_ms = lv_timer_handler();
        _lock_release(&lvgl_api_lock);

        lvgl_port_ui_callback();
        
        // in case of task watch dog timeout
        time_till_next_ms = MAX(time_till_next_ms, EXAMPLE_LVGL_TASK_MIN_DELAY_MS);
        // in case of lvgl display not ready yet
        time_till_next_ms = MIN(time_till_next_ms, EXAMPLE_LVGL_TASK_MAX_DELAY_MS);
        ESP_LOGI(TAG, "LVGL task delay: %d ms", time_till_next_ms);
        usleep(1000 * time_till_next_ms);
    }
}

esp_err_t lvgl_port_init(esp_lcd_panel_handle_t lcd_handle, esp_lcd_touch_handle_t tp_handle)
{

    ESP_LOGI(TAG, "Initialize LVGL library");
    lv_init();
    // create a lvgl display
    lv_display_t *display = lv_display_create(EXAMPLE_LCD_H_RES, EXAMPLE_LCD_V_RES);
    // associate the rgb panel handle to the display
    lv_display_set_user_data(display, lcd_handle);
    // set color depth
    lv_display_set_color_format(display, LV_COLOR_FORMAT_RGB565);
    // create draw buffers
    void *buf1 = NULL;
    void *buf2 = NULL;

    ESP_LOGI(TAG, "Use frame buffers as LVGL draw buffers");
    ESP_ERROR_CHECK(esp_lcd_rgb_panel_get_frame_buffer(lcd_handle, 2, &buf1, &buf2));
    // set LVGL draw buffers and direct mode
    lv_display_set_buffers(display, buf1, buf2, EXAMPLE_LCD_H_RES * EXAMPLE_LCD_V_RES * sizeof(lv_color16_t), LV_DISPLAY_RENDER_MODE_DIRECT);

    ESP_LOGI(TAG, "FB1 addr: %p, aligned 64B? %s", buf1,
         ((uintptr_t)buf1 % 64 == 0) ? "yes" : "no");

    // set the callback which can copy the rendered image to an area of the display
    lv_display_set_flush_cb(display, example_lvgl_flush_cb);

    ESP_LOGI(TAG, "Register event callbacks");
    esp_lcd_rgb_panel_event_callbacks_t cbs = {
        // .on_color_trans_done = example_notify_lvgl_flush_ready,
        .on_vsync = example_notify_lvgl_flush_ready
    };
    ESP_ERROR_CHECK(esp_lcd_rgb_panel_register_event_callbacks(lcd_handle, &cbs, display));

    ESP_LOGI(TAG, "Install LVGL tick timer");
    // Tick interface for LVGL (using esp_timer to generate 2ms periodic event)
    const esp_timer_create_args_t lvgl_tick_timer_args = {
        .callback = &example_increase_lvgl_tick,
        .name = "lvgl_tick"
    };
    esp_timer_handle_t lvgl_tick_timer = NULL;
    ESP_ERROR_CHECK(esp_timer_create(&lvgl_tick_timer_args, &lvgl_tick_timer));
    ESP_ERROR_CHECK(esp_timer_start_periodic(lvgl_tick_timer, EXAMPLE_LVGL_TICK_PERIOD_MS * 1000));

    ESP_LOGI(TAG, "Create LVGL task");
    xTaskCreate(example_lvgl_port_task, "LVGL", EXAMPLE_LVGL_TASK_STACK_SIZE, NULL, EXAMPLE_LVGL_TASK_PRIORITY, &lvgl_task_handle);
    return ESP_OK;
}

void lvgl_register_ui_callback(void (*callback)(void))
{
    lvgl_port_ui_callback = callback;
    /* This function can be used to register a UI update callback that will be called from the LVGL task */
    /* Implementation depends on how you want to structure your UI updates */
}
