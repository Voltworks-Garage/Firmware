#include "display.h"
#include "lcd_esp.h"
#include "touch.h"
#include "display_state_machine.h"
#include "styles.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "lvgl.h"

static const char *TAG = "DISPLAY";

// Display buffer - 1/10 of screen for partial rendering
// Display is 480x320 in landscape (matching Arduino setup)
#define LVGL_HOR_RES 480
#define LVGL_VER_RES 320
#define BUFFER_SIZE (LVGL_HOR_RES * 32)  // 64 lines of pixels

static lv_color_t buf1[BUFFER_SIZE];
static lv_color_t buf2[BUFFER_SIZE];  // Double buffering
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
    lv_display_set_buffers(disp, buf1, buf2,
                          sizeof(buf1), LV_DISPLAY_RENDER_MODE_PARTIAL);
    ESP_LOGI(TAG, "Display buffers configured (2x %d bytes)", sizeof(buf1));

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

    // Initialize shared styles
    Styles_Init();
    ESP_LOGI(TAG, "Styles initialized");

    // Initialize the display state machine
    DisplayStateMachine_Init();
    ESP_LOGI(TAG, "Display state machine initialized");

    // Create single LVGL task - handles tick updates and timer processing
    // No locking needed since this is the only task accessing LVGL
    xTaskCreatePinnedToCore(
        lvgl_task,
        "LVGL",
        8192,   // Stack size for LVGL processing
        NULL,
        2,      // Medium priority
        NULL,
        0       // Core 0
    );

    ESP_LOGI(TAG, "Display initialization complete");
}

// Single LVGL task - handles tick updates and timer processing
// No locking needed since this is the only task accessing LVGL API
// This enables LV_USE_FREERTOS_TASK_NOTIFY for 45% faster DMA synchronization
static void lvgl_task(void *parameter) {
    TickType_t xLastWakeTime = xTaskGetTickCount();
    const TickType_t tick_period = pdMS_TO_TICKS(2);
    uint32_t tick_counter = 0;

    while (1) {
        // Increment LVGL tick every 2ms
        lv_tick_inc(2);
        tick_counter++;

        // Run timer handler every 50ms (25 ticks × 2ms = 50ms)
        if (tick_counter >= 25) {
            tick_counter = 0;
            lv_timer_handler();  // Process LVGL timers, animations, and rendering
            DisplayStateMachine_Run();  // Update display state machine
        }

        vTaskDelayUntil(&xLastWakeTime, tick_period);
    }
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

// Get the LVGL display object (for creating UI elements)
lv_display_t* Display_GetLVGL(void) {
    return disp;
}
