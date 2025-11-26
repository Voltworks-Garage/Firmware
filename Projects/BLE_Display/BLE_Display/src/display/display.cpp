#include "display.h"
#include "display_state_machine.h"
#include "styles.h"
#include "lcd_module.h"
#include "touch.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

// Display buffer - 1/10 of screen (480x320 in landscape / 10)
// Your display is 320x480, but with rotation=3 it's 480x320
#define LVGL_HOR_RES 480
#define LVGL_VER_RES 320
#define BUFFER_SIZE (LVGL_HOR_RES * LVGL_VER_RES / 10)

static lv_color_t buf[BUFFER_SIZE];
static lv_display_t* disp = NULL;
static lv_indev_t* indev = NULL;  // Touch input device

static TFT_eSPI* tft = NULL;  // Will get from lcd_module

// Forward declarations
static void lvgl_flush_cb(lv_display_t *disp, const lv_area_t *area, uint8_t *px_map);
static void lvgl_touch_read_cb(lv_indev_t *indev, lv_indev_data_t *data);
void LVGL_Update(void *parameter);

void LVGL_Init(void) {
    ESP_LOGI("LVGL", "Starting...");

    // Get TFT instance from your existing lcd_module
    tft = LCD_GetTFT();
    ESP_LOGI("LVGL", "Got TFT instance");

    // Initialize LVGL
    lv_init();
    ESP_LOGI("LVGL", "lv_init() complete");

    // Create display
    disp = lv_display_create(LVGL_HOR_RES, LVGL_VER_RES);
    ESP_LOGI("LVGL", "Display created");

    lv_display_set_flush_cb(disp, lvgl_flush_cb);
    ESP_LOGI("LVGL", "Flush callback set");

    lv_display_set_buffers(disp, buf, NULL, BUFFER_SIZE * sizeof(lv_color_t), LV_DISPLAY_RENDER_MODE_PARTIAL);
    ESP_LOGI("LVGL", "Buffers configured");

    // Create touch input device
    indev = lv_indev_create();
    lv_indev_set_type(indev, LV_INDEV_TYPE_POINTER);
    lv_indev_set_read_cb(indev, lvgl_touch_read_cb);

    // Set scroll threshold - if touch moves more than this many pixels, it's a scroll/drag
    lv_indev_set_scroll_limit(indev, 10);  // 10 pixels movement = scroll, not click

    ESP_LOGI("LVGL", "Touch input device registered");

    ESP_LOGI("LVGL", "Complete! %dx%d, buffer=%d bytes\n",
                  LVGL_HOR_RES, LVGL_VER_RES, BUFFER_SIZE * sizeof(lv_color_t));

    // Initialize shared styles
    Styles_Init();
    ESP_LOGI("LVGL", "Styles initialized");

    // Initialize the display state machine
    DisplayStateMachine_Init();

    // LVGL task - low priority (1), core 0, runs every 50ms
    xTaskCreatePinnedToCore(
        LVGL_Update,
        "LVGL_Update",
        12000,  // Larger stack for LVGL
        NULL,
        1,  // Very low priority
        NULL,
        0  // Core 0
    );
}

void LVGL_Update(void *parameter) {
    static TickType_t last_tick = 0;

    while(1) {

        // Tell LVGL how much time has passed (in milliseconds)
        TickType_t current_tick = xTaskGetTickCount();
        uint32_t elapsed_ms = pdTICKS_TO_MS(current_tick - last_tick);

        if (last_tick > 0 && elapsed_ms > 0) {
            lv_tick_inc(elapsed_ms);
        }
        last_tick = current_tick;

        // Process LVGL tasks
        lv_timer_handler(); 

        // Run the display state machine
        DisplayStateMachine_Run();

        // Run every 50ms
        vTaskDelay(pdMS_TO_TICKS(20));
    }

}

// Callback to flush display buffer to TFT
// This is the ONLY place TFT_eSPI functions should be called directly
static void lvgl_flush_cb(lv_display_t *disp, const lv_area_t *area, uint8_t *px_map) {
    uint32_t w = (area->x2 - area->x1 + 1);
    uint32_t h = (area->y2 - area->y1 + 1);

    // Use TFT_eSPI to push pixels to display
    tft->startWrite();
    tft->setAddrWindow(area->x1, area->y1, w, h);
    tft->pushColors((uint16_t*)px_map, w * h, true);
    tft->endWrite();

    lv_display_flush_ready(disp);  // Tell LVGL we're done
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
        // data->point.x = last_x;
        // data->point.y = last_y;
    }
}

// ============================================================================
// DEMO CODE - COMMENTED OUT
// This code demonstrates various LVGL widgets but should not be used in
// production. Each screen mode should have its own file in src/display/screens/
// ============================================================================

// // Create a simple test UI to verify LVGL is working
// void LVGL_CreateTestUI(void) {
//     // Set background to black for better contrast
//     lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(0x000000), 0);
//
//     // Create a label in the center of the screen
//     lv_obj_t *label = lv_label_create(lv_screen_active());
//     lv_label_set_text(label, "LVGL Working!\nHello World");
//     lv_obj_align(label, LV_ALIGN_CENTER, 0, 60);  // Below the arc
//     lv_obj_set_style_text_color(label, lv_color_hex(0xFFFFFF), 0);  // White text
//     lv_obj_set_style_text_font(label, &lv_font_montserrat_24, 0);
//
//     // Create a colored arc (progress indicator)
//     lv_obj_t *arc = lv_arc_create(lv_screen_active());
//     lv_obj_set_size(arc, 150, 150);
//     lv_arc_set_rotation(arc, 270);
//     lv_arc_set_bg_angles(arc, 0, 360);
//     lv_arc_set_value(arc, 75);
//     lv_obj_align(arc, LV_ALIGN_CENTER, 0, -40);
//     lv_obj_set_style_arc_color(arc, lv_color_hex(0x00FF00), LV_PART_INDICATOR);
//
//     ESP_LOGI("LVGL", "Test UI created - black background, white text");
// }
//
// // Widget references for dynamic updates
// static lv_obj_t *speed_label = NULL;
// static lv_obj_t *speed_arc = NULL;
// static lv_obj_t *battery_bar = NULL;
// static lv_obj_t *battery_label = NULL;
// static lv_obj_t *temp_label = NULL;
// static lv_obj_t *button_counter_label = NULL;
// static uint32_t button_press_count = 0;
//
// // Button event callback
// static void button_event_cb(lv_event_t *e) {
//     button_press_count++;
//     if (button_counter_label) {
//         lv_label_set_text_fmt(button_counter_label, "Button pressed: %u times", button_press_count);
//     }
//     ESP_LOGI("LVGL", "Button pressed! Count: %u", button_press_count);
// }
//
// // Slider event callback
// static void slider_event_cb(lv_event_t *e) {
//     lv_obj_t *slider = (lv_obj_t*)lv_event_get_target(e);
//     int32_t value = lv_slider_get_value(slider);
//     ESP_LOGI("LVGL", "Slider value: %d", value);
// }
//
// // Create a comprehensive demo with multiple widgets
// void LVGL_CreateComprehensiveDemo(void) {
//     Serial.println("LVGL_CreateComprehensiveDemo: Starting UI creation...");
//
//     // Set background to black
//     lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(0x000000), 0);
//     Serial.println("LVGL_CreateComprehensiveDemo: Background set");
//
//     // Title label at top
//     lv_obj_t *title = lv_label_create(lv_screen_active());
//     lv_label_set_text(title, "LVGL Dashboard Demo");
//     lv_obj_align(title, LV_ALIGN_TOP_MID, 0, 5);
//     lv_obj_set_style_text_color(title, lv_color_hex(0xFFFFFF), 0);
//
//     // Speed Arc (left side)
//     speed_arc = lv_arc_create(lv_screen_active());
//     lv_obj_set_size(speed_arc, 140, 140);
//     lv_arc_set_rotation(speed_arc, 135);
//     lv_arc_set_bg_angles(speed_arc, 0, 270);
//     lv_arc_set_range(speed_arc, 0, 60);
//     lv_arc_set_value(speed_arc, 0);
//     lv_obj_align(speed_arc, LV_ALIGN_LEFT_MID, 20, 0);
//     lv_obj_set_style_arc_color(speed_arc, lv_color_hex(0x00AAFF), LV_PART_INDICATOR);
//     lv_obj_set_style_arc_width(speed_arc, 12, LV_PART_INDICATOR);
//
//     // Speed label (center of arc)
//     speed_label = lv_label_create(lv_screen_active());
//     lv_label_set_text(speed_label, "0\nkm/h");
//     lv_obj_align_to(speed_label, speed_arc, LV_ALIGN_CENTER, 0, 0);
//     lv_obj_set_style_text_color(speed_label, lv_color_hex(0x00AAFF), 0);
//     lv_obj_set_style_text_align(speed_label, LV_TEXT_ALIGN_CENTER, 0);
//
//     // Battery bar (right side)
//     lv_obj_t *battery_container = lv_obj_create(lv_screen_active());
//     lv_obj_set_size(battery_container, 100, 150);
//     lv_obj_align(battery_container, LV_ALIGN_RIGHT_MID, -20, 0);
//     lv_obj_set_style_bg_color(battery_container, lv_color_hex(0x1a1a1a), 0);
//     lv_obj_set_style_border_color(battery_container, lv_color_hex(0x404040), 0);
//     lv_obj_set_style_border_width(battery_container, 2, 0);
//
//     lv_obj_t *batt_title = lv_label_create(battery_container);
//     lv_label_set_text(batt_title, "Battery");
//     lv_obj_align(batt_title, LV_ALIGN_TOP_MID, 0, 5);
//     lv_obj_set_style_text_color(batt_title, lv_color_hex(0xFFFFFF), 0);
//
//     battery_bar = lv_bar_create(battery_container);
//     lv_obj_set_size(battery_bar, 30, 100);
//     lv_bar_set_range(battery_bar, 0, 100);
//     lv_bar_set_value(battery_bar, 100, LV_ANIM_OFF);
//     lv_obj_align(battery_bar, LV_ALIGN_CENTER, 0, 5);
//     lv_obj_set_style_bg_color(battery_bar, lv_color_hex(0x00FF00), LV_PART_INDICATOR);
//
//     battery_label = lv_label_create(battery_container);
//     lv_label_set_text(battery_label, "100%");
//     lv_obj_align(battery_label, LV_ALIGN_BOTTOM_MID, 0, -5);
//     lv_obj_set_style_text_color(battery_label, lv_color_hex(0x00FF00), 0);
//
//     // Temperature label (bottom left)
//     temp_label = lv_label_create(lv_screen_active());
//     lv_label_set_text(temp_label, "Temp: 25.0°C");
//     lv_obj_align(temp_label, LV_ALIGN_BOTTOM_LEFT, 10, -80);
//     lv_obj_set_style_text_color(temp_label, lv_color_hex(0xFFAA00), 0);
//
//     // Interactive button (bottom center)
//     lv_obj_t *btn = lv_button_create(lv_screen_active());
//     lv_obj_set_size(btn, 120, 50);
//     lv_obj_align(btn, LV_ALIGN_BOTTOM_MID, 0, -50);
//     lv_obj_add_event_cb(btn, button_event_cb, LV_EVENT_CLICKED, NULL);
//     lv_obj_set_style_bg_color(btn, lv_color_hex(0xFF0000), 0);
//
//     // Disable scrolling on the button - it's not a scrollable widget
//     lv_obj_remove_flag(btn, LV_OBJ_FLAG_SCROLLABLE);
//
//     lv_obj_t *btn_label = lv_label_create(btn);
//     lv_label_set_text(btn_label, "Press Me!");
//     lv_obj_center(btn_label);
//
//     // Button counter label
//     button_counter_label = lv_label_create(lv_screen_active());
//     lv_label_set_text(button_counter_label, "Button pressed: 0 times");
//     lv_obj_align(button_counter_label, LV_ALIGN_BOTTOM_MID, 0, -5);
//     lv_obj_set_style_text_color(button_counter_label, lv_color_hex(0xFFFFFF), 0);
//
//     // Slider (bottom right)
//     lv_obj_t *slider = lv_slider_create(lv_screen_active());
//     lv_obj_set_size(slider, 150, 10);
//     lv_slider_set_range(slider, 0, 100);
//     lv_slider_set_value(slider, 50, LV_ANIM_OFF);
//     lv_obj_align(slider, LV_ALIGN_BOTTOM_RIGHT, -10, -80);
//     lv_obj_add_event_cb(slider, slider_event_cb, LV_EVENT_VALUE_CHANGED, NULL);
//     lv_obj_set_style_bg_color(slider, lv_color_hex(0xAA00FF), LV_PART_INDICATOR);
//
//     lv_obj_t *slider_label = lv_label_create(lv_screen_active());
//     lv_label_set_text(slider_label, "Slide Me!");
//     lv_obj_align(slider_label, LV_ALIGN_BOTTOM_RIGHT, -40, -95);
//     lv_obj_set_style_text_color(slider_label, lv_color_hex(0xAA00FF), 0);
//
//     Serial.println("LVGL_CreateComprehensiveDemo: UI creation complete!");
//     ESP_LOGI("LVGL", "Comprehensive demo created with speed arc, battery bar, button, slider");
//
//     // Force immediate screen refresh
//     lv_refr_now(disp);
//     Serial.println("LVGL_CreateComprehensiveDemo: Screen refresh triggered");
// }
//
// // Update dynamic values on the demo screen
// void LVGL_UpdateDemoValues(float speed, float battery, float temperature) {
//
//     if (speed_label && speed_arc) {
//         // Convert float to int with one decimal (e.g., 54.5 -> 545)
//         int speed_int = (int)(speed * 10);
//         int speed_whole = speed_int / 10;
//         int speed_frac = speed_int % 10;
//
//         lv_label_set_text_fmt(speed_label, "%d.%d\nkm/h", speed_whole, speed_frac);
//         lv_arc_set_value(speed_arc, (int16_t)speed);
//
//         // Change color based on speed
//         if (speed > 40) {
//             lv_obj_set_style_arc_color(speed_arc, lv_color_hex(0xFF0000), LV_PART_INDICATOR);
//             lv_obj_set_style_text_color(speed_label, lv_color_hex(0xFF0000), 0);
//         } else if (speed > 20) {
//             lv_obj_set_style_arc_color(speed_arc, lv_color_hex(0xFFAA00), LV_PART_INDICATOR);
//             lv_obj_set_style_text_color(speed_label, lv_color_hex(0xFFAA00), 0);
//         } else {
//             lv_obj_set_style_arc_color(speed_arc, lv_color_hex(0x00AAFF), LV_PART_INDICATOR);
//             lv_obj_set_style_text_color(speed_label, lv_color_hex(0x00AAFF), 0);
//         }
//     }
//
//     if (battery_label && battery_bar) {
//         int batt_int = (int)battery;
//         lv_label_set_text_fmt(battery_label, "%d%%", batt_int);
//         lv_bar_set_value(battery_bar, batt_int, LV_ANIM_ON);
//
//         // Change color based on battery level
//         if (battery < 20) {
//             lv_obj_set_style_bg_color(battery_bar, lv_color_hex(0xFF0000), LV_PART_INDICATOR);
//             lv_obj_set_style_text_color(battery_label, lv_color_hex(0xFF0000), 0);
//         } else if (battery < 50) {
//             lv_obj_set_style_bg_color(battery_bar, lv_color_hex(0xFFAA00), LV_PART_INDICATOR);
//             lv_obj_set_style_text_color(battery_label, lv_color_hex(0xFFAA00), 0);
//         } else {
//             lv_obj_set_style_bg_color(battery_bar, lv_color_hex(0x00FF00), LV_PART_INDICATOR);
//             lv_obj_set_style_text_color(battery_label, lv_color_hex(0x00FF00), 0);
//         }
//     }
//
//     if (temp_label) {
//         // Convert float to int with one decimal
//         int temp_int = (int)(temperature * 10);
//         int temp_whole = temp_int / 10;
//         int temp_frac = temp_int % 10;
//
//         lv_label_set_text_fmt(temp_label, "Temp: %d.%d°C", temp_whole, temp_frac);
//
//         // Change color based on temperature
//         if (temperature > 60) {
//             lv_obj_set_style_text_color(temp_label, lv_color_hex(0xFF0000), 0);
//         } else if (temperature > 40) {
//             lv_obj_set_style_text_color(temp_label, lv_color_hex(0xFFAA00), 0);
//         } else {
//             lv_obj_set_style_text_color(temp_label, lv_color_hex(0x00FF00), 0);
//         }
//     }
//
//     // LVGL will auto-refresh every 33ms (LV_DEF_REFR_PERIOD) now that lv_tick_inc() is working
// }
