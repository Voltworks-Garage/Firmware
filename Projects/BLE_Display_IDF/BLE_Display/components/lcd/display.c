#include "display.h"
#include "lcd_esp.h"
#include "touch.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "lvgl.h"
#include "esp_heap_caps.h"

static const char *TAG = "DISPLAY";

// UI callback for state machine updates
static Display_UICallback_t s_ui_callback = NULL;

// Display buffer - 1/10 of screen for partial rendering
// Display is 480x320 in landscape (matching Arduino setup)
// lv_color16_t is 3 bytes
#define LVGL_HOR_RES 480
#define LVGL_VER_RES 320
#define PIXEL_BYTES 2  // RGB565 = 2 bytes per pixel
#define LINES_IN_BUFFER 32  // Number of lines in each buffer
#define BUFFER_SIZE_PIXELS (LVGL_HOR_RES * LINES_IN_BUFFER)  // 32 lines of pixels
#define BUFFER_SIZE (BUFFER_SIZE_PIXELS * PIXEL_BYTES)  // Buffer size in bytes

#define USE_PSRAM_BUFFERS 1  // Set to 1 to allocate buffers in PSRAM, 0 for internal RAM
#if USE_PSRAM_BUFFERS
static EXT_RAM_BSS_ATTR lv_color16_t buf1[BUFFER_SIZE_PIXELS];
static EXT_RAM_BSS_ATTR lv_color16_t buf2[BUFFER_SIZE_PIXELS];  // Double buffering
#else
static lv_color16_t buf1[BUFFER_SIZE_PIXELS];
static lv_color16_t buf2[BUFFER_SIZE_PIXELS];  // Double buffering
#endif
static lv_display_t* disp = NULL;
static lv_indev_t* indev = NULL;  // Touch input device

// Forward declarations
static void lvgl_task(void *parameter);
static void lvgl_touch_read_cb(lv_indev_t *indev, lv_indev_data_t *data);

void Display_Init(void) {
    ESP_LOGI(TAG, "Initializing display...");

    // Initialize LVGL
    lv_init();
    ESP_LOGI(TAG, "LVGL initialized");

    // Create LVGL display
    disp = lv_display_create(LVGL_HOR_RES, LVGL_VER_RES);
    if (disp == NULL) {
        ESP_LOGE(TAG, "Failed to create LVGL display");
        return;
    }
    ESP_LOGI(TAG, "LVGL display created (%dx%d)", LVGL_HOR_RES, LVGL_VER_RES);

    // Set display buffers (partial rendering with double buffering)
    ESP_LOGI(TAG, "buf1 @ %p (PSRAM: %s, aligned: 64B, size: %d bytes)",
             buf1,
             esp_ptr_external_ram(buf1) ? "YES" : "NO",
             BUFFER_SIZE_PIXELS * sizeof(lv_color16_t));
    ESP_LOGI(TAG, "buf2 @ %p (PSRAM: %s, aligned: 64B, size: %d bytes)",
             buf2,
             esp_ptr_external_ram(buf2) ? "YES" : "NO",
             BUFFER_SIZE_PIXELS * sizeof(lv_color16_t));
    lv_display_set_buffers(disp, buf1, buf2,
                          BUFFER_SIZE, LV_DISPLAY_RENDER_MODE_PARTIAL);
    ESP_LOGI(TAG, "Display buffers configured (2x %d pixels = %d bytes)",
             BUFFER_SIZE, BUFFER_SIZE * sizeof(lv_color16_t));

    // Set screen to all black
    lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(0x000000), 0);

    // Set the flush callback to HX8357D driver
    lv_display_set_flush_cb(disp, hx8357d_lvgl_flush);
    ESP_LOGI(TAG, "Flush callback set to hx8357d_lvgl_flush");

    // Initialize the HX8357D panel with LVGL integration
    esp_lcd_panel_handle_t panel = NULL;
    esp_err_t ret = hx8357d_init_panel(&panel, disp);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize HX8357D panel: %d", ret);
        return;
    }
    ESP_LOGI(TAG, "HX8357D panel initialized successfully");

    // Create touch input device
    indev = lv_indev_create();
    lv_indev_set_type(indev, LV_INDEV_TYPE_POINTER);
    lv_indev_set_read_cb(indev, lvgl_touch_read_cb);

    // Set scroll threshold - if touch moves more than this many pixels, it's a scroll/drag
    lv_indev_set_scroll_limit(indev, 10);  // 10 pixels movement = scroll, not click

    ESP_LOGI(TAG, "Touch input device registered");

    // Create single LVGL task - handles tick updates and timer processing
    // No locking needed since this is the only task accessing LVGL
    xTaskCreate(
        lvgl_task,
        "LVGL",
        8192,   // Stack size for LVGL processing
        NULL,
        2,      // Medium priority
        NULL
    );

    ESP_LOGI(TAG, "Display initialization complete");
}

// Single LVGL task - handles tick updates and timer processing
// No locking needed since this is the only task accessing LVGL API
// This enables LV_USE_FREERTOS_TASK_NOTIFY for 45% faster DMA synchronization
static void lvgl_task(void *parameter) {
    TickType_t xLastWakeTime = xTaskGetTickCount();
    const TickType_t tick_period = pdMS_TO_TICKS(2);
    uint32_t tick_counter = 25;

    while (1) {
        // Increment LVGL tick every 2ms
        lv_tick_inc(2);
        tick_counter++;

        // Run timer handler every 50ms (25 ticks × 2ms = 50ms)
        if (tick_counter >= 25) {
            tick_counter = 0;
            lv_timer_handler();  // Process LVGL timers, animations, and rendering

            // Call UI update callback if registered
            if (s_ui_callback != NULL) {
                s_ui_callback();
            }

        }

        vTaskDelayUntil(&xLastWakeTime, tick_period);
    }
}

void Display_RegisterUICallback(Display_UICallback_t callback) {
    s_ui_callback = callback;
    if (callback != NULL) {
        ESP_LOGI(TAG, "UI callback registered");
    } else {
        ESP_LOGI(TAG, "UI callback unregistered");
    }
}

void Display_SetBrightness(uint8_t brightness_percent){
    hx8357d_set_backlight(brightness_percent);
}

// Callback to read touch input
// LVGL calls this periodically to check for touch events
static void lvgl_touch_read_cb(lv_indev_t *indev_drv, lv_indev_data_t *data) {
    static uint16_t last_x = 0;
    static uint16_t last_y = 0;

    uint16_t x = 0, y = 0;
    bool touched = Touch_GetXY(&x, &y);

    if (touched) {
        data->state = LV_INDEV_STATE_PRESSED;
        data->point.x = x;
        data->point.y = y;
        last_x = x;
        last_y = y;
    } else {
        data->state = LV_INDEV_STATE_RELEASED;
        // Keep last position on release for proper release event
        data->point.x = last_x;
        data->point.y = last_y;
    }
}
