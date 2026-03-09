#include "display.h"
#include "lcd_esp.h"
#include "touch.h"
#include "lvgl_port.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

static const char *TAG = "DISPLAY";

// UI callback for state machine updates
static Display_UICallback_t s_ui_callback = NULL;
static TaskHandle_t s_ui_task_handle = NULL;

/* Flag to indicate LVGL is ready */
static bool s_lvgl_initialized = false;


/**
 * @brief Initialize display subsystem
 *
 * This initializes:
 * - RGB LCD hardware
 * - GT911 touch controller
 * - LVGL port (creates LVGL task, buffers, etc.)
 * - UI callback task
 */
void Display_Init(void)
{
    ESP_LOGI(TAG, "Initializing display subsystem");

    /* Initialize touch controller first */
    ESP_LOGI(TAG, "Initializing touch controller");
    esp_err_t ret = Touch_Init();
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize touch: %s", esp_err_to_name(ret));
        return;
    }

    /* Initialize RGB LCD hardware */
    ESP_LOGI(TAG, "Initializing RGB LCD");
    esp_lcd_panel_handle_t lcd_panel = NULL;
    ret = rgb_lcd_init_panel(&lcd_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize RGB LCD: %s", esp_err_to_name(ret));
        return;
    }

    /* Initialize LVGL port with LCD and touch handles */
    ESP_LOGI(TAG, "Initializing LVGL port");
    esp_lcd_touch_handle_t touch_panel = Touch_GetHandle();
    ret = lvgl_port_init(lcd_panel, touch_panel);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to initialize LVGL port: %s", esp_err_to_name(ret));
        return;
    }


    /* Mark LVGL as initialized so UI task can proceed */
    s_lvgl_initialized = true;

    /* Turn on backlight */
    ESP_LOGI(TAG, "Turning on backlight");
    // rgb_lcd_set_backlight(100);

    /* Turn on display */
    ESP_LOGI(TAG, "Turning on display");
    rgb_lcd_display_on_off(true);

    ESP_LOGI(TAG, "Display initialization complete");
}

/**
 * @brief Register UI callback for periodic updates
 *
 * The callback will be called periodically (50 Hz) with LVGL mutex locked.
 * This is where you update your UI based on application state.
 *
 * @param callback Callback function to register (or NULL to unregister)
 */
void Display_RegisterUICallback(Display_UICallback_t callback)
{
    s_ui_callback = callback;

    if (callback != NULL) {
        ESP_LOGI(TAG, "UI callback registered");

        lvgl_register_ui_callback(callback);

        // /* Create UI callback task if not already created */
        // if (s_ui_task_handle == NULL) {
        //     xTaskCreate(
        //         ui_callback_task,
        //         "UI_Callback",
        //         4096,  // Stack size
        //         NULL,
        //         3,     // Priority (medium)
        //         &s_ui_task_handle
        //     );
        //     ESP_LOGI(TAG, "UI callback task created");
        // }
    } else {
        ESP_LOGI(TAG, "UI callback unregistered");
    }
}

/**
 * @brief Set display backlight brightness
 *
 * Note: Current implementation only supports on/off.
 *
 * @param brightness_percent 0 = off, >0 = on
 */
void Display_SetBrightness(uint8_t brightness_percent)
{
    rgb_lcd_set_backlight(brightness_percent);
}

/**
 * @brief Enable or disable display
 *
 * @param on true to enable, false to disable
 */
void Display_Enable(bool on)
{
    rgb_lcd_display_on_off(on);
}
