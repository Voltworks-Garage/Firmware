#include "screens/screen_home.h"
#include "dash_dbc.h"
#include "ble_module.h"
#include "styles.h"

//logging
// #define LOG_LOCAL_LEVEL ESP_LOG_VERBOSE
// #define LOG_LOCAL_LEVEL ESP_LOG_INFO
// #define LOG_LOCAL_LEVEL ESP_LOG_DEBUG
// #define LOG_LOCAL_LEVEL ESP_LOG_WARN
// #define LOG_LOCAL_LEVEL ESP_LOG_ERROR
#define LOG_LOCAL_LEVEL ESP_LOG_NONE
#include "esp_log.h"
static const char* TAG = "SCREEN_HOME";

// Layout - Margins
#define MARGIN_TOP              10
#define MARGIN_BOTTOM           10
#define MARGIN_LEFT             20
#define MARGIN_RIGHT_BAR        40
#define MARGIN_RIGHT_PERCENT    10

// Layout - Battery Bar (right side, same as home screen)
#define BATTERY_BAR_WIDTH       40
#define BATTERY_BAR_HEIGHT      200
#define BATTERY_BAR_MIN         0
#define BATTERY_BAR_MAX         100
#define BATTERY_BAR_X_OFFSET    -20
#define BATTERY_PERCENT_X_OFFSET -15

// Layout - Left Side Labels
#define LEFT_LABEL_Y_HV         -60
#define LEFT_LABEL_Y_LV         0
#define LEFT_LABEL_Y_BT         60

// Helper macros for float to integer conversion (avoids float formatting)
#define FLOAT_TO_INT_TENTHS(val)    ((int)((val) * 10 + 0.5f))
#define GET_WHOLE(val_x10)          ((val_x10) / 10)
#define GET_FRAC(val_x10)           ((val_x10) % 10)

// UI elements
static lv_obj_t* label_title = NULL;
static lv_obj_t* bar_battery = NULL;
static lv_obj_t* label_battery_percent = NULL;
static lv_obj_t* label_hv_voltage = NULL;
static lv_obj_t* label_lv_voltage = NULL;
static lv_obj_t* label_bluetooth = NULL;

// Cached values to detect changes (prevent unnecessary LVGL updates)
static int cached_hv_voltage_x10 = -1;
static int cached_soc_int = -1;
static int cached_lv_voltage_x10 = -1;
static bool cached_bt_connected = false;

void ScreenHome_Create(void) {
    ESP_LOGI(TAG, "Creating home screen");

    lv_obj_t* screen = lv_screen_active();

    // Set background color
    lv_obj_set_style_bg_color(screen, lv_color_hex(COLOR_BACKGROUND), 0);

    // Title at top - uses shared style
    label_title = lv_label_create(screen);
    lv_label_set_text(label_title, "HOME");
    lv_obj_add_style(label_title, &style_label_small_white, 0);
    lv_obj_align(label_title, LV_ALIGN_TOP_MID, 0, MARGIN_TOP);

    // Battery bar on right side
    bar_battery = lv_bar_create(screen);
    lv_obj_set_size(bar_battery, BATTERY_BAR_WIDTH, BATTERY_BAR_HEIGHT);
    lv_bar_set_range(bar_battery, BATTERY_BAR_MIN, BATTERY_BAR_MAX);
    lv_bar_set_value(bar_battery, BATTERY_BAR_MIN, LV_ANIM_OFF);
    lv_obj_align(bar_battery, LV_ALIGN_RIGHT_MID, BATTERY_BAR_X_OFFSET, 0);

    // Apply battery bar styles
    lv_obj_add_style(bar_battery, &style_battery_bar_indicator, LV_PART_INDICATOR);
    lv_obj_add_style(bar_battery, &style_battery_bar_background, LV_PART_MAIN);

    // Battery percentage below bar - uses shared style
    label_battery_percent = lv_label_create(screen);
    lv_label_set_text(label_battery_percent, "---%");
    lv_obj_add_style(label_battery_percent, &style_label_small_green, 0);
    lv_obj_align(label_battery_percent, LV_ALIGN_RIGHT_MID, BATTERY_PERCENT_X_OFFSET, BATTERY_BAR_HEIGHT / 2 + 20);

    // Left side labels - HV Voltage - uses shared style
    label_hv_voltage = lv_label_create(screen);
    lv_label_set_text(label_hv_voltage, "HV: --.- V");
    lv_obj_add_style(label_hv_voltage, &style_label_small_white, 0);
    lv_obj_align(label_hv_voltage, LV_ALIGN_LEFT_MID, MARGIN_LEFT, LEFT_LABEL_Y_HV);

    // Left side labels - LV Voltage - uses shared style
    label_lv_voltage = lv_label_create(screen);
    lv_label_set_text(label_lv_voltage, "LV: --.- V");
    lv_obj_add_style(label_lv_voltage, &style_label_small_white, 0);
    lv_obj_align(label_lv_voltage, LV_ALIGN_LEFT_MID, MARGIN_LEFT, LEFT_LABEL_Y_LV);

    // Left side labels - Bluetooth - uses shared style
    label_bluetooth = lv_label_create(screen);
    lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH " Disconnected");
    lv_obj_add_style(label_bluetooth, &style_label_small_gray, 0);
    lv_obj_align(label_bluetooth, LV_ALIGN_LEFT_MID, MARGIN_LEFT, LEFT_LABEL_Y_BT);

    ESP_LOGI(TAG, "Home screen created");
}

void ScreenHome_Destroy(void) {
    ESP_LOGI(TAG, "Destroying home screen");

    lv_obj_clean(lv_screen_active());

    label_title = NULL;
    bar_battery = NULL;
    label_battery_percent = NULL;
    label_hv_voltage = NULL;
    label_lv_voltage = NULL;
    label_bluetooth = NULL;

    // Reset cached values
    cached_hv_voltage_x10 = -1;
    cached_soc_int = -1;
    cached_lv_voltage_x10 = -1;
    cached_bt_connected = false;
}

void ScreenHome_Update(void) {
    lv_label_set_text_fmt(label_hv_voltage, "HV: %d.%d V",
        GET_WHOLE(cached_hv_voltage_x10), GET_FRAC(cached_hv_voltage_x10));
    // Update HV battery voltage and SOC
    if (!CAN_bms_status_checkDataIsStale()) {
        // Update HV voltage (only if changed)
        if (label_hv_voltage != NULL) {
            float hv_voltage = CAN_bms_status_pack_voltage_get();
            int hv_voltage_x10 = FLOAT_TO_INT_TENTHS(hv_voltage);
            if (hv_voltage_x10 != cached_hv_voltage_x10) {
                lv_label_set_text_fmt(label_hv_voltage, "HV: %d.%d V",
                                      GET_WHOLE(hv_voltage_x10), GET_FRAC(hv_voltage_x10));
                cached_hv_voltage_x10 = hv_voltage_x10;
            }
        }

        // Update battery percentage and bar (only if changed)
        if (label_battery_percent != NULL && bar_battery != NULL) {
            float soc = CAN_bms_status_soc_percent_get();
            int soc_int = (int)soc;
            if (soc_int != cached_soc_int) {
                lv_label_set_text_fmt(label_battery_percent, "%d%%", soc_int);
                lv_bar_set_value(bar_battery, soc_int, LV_ANIM_ON);
                cached_soc_int = soc_int;
            }
        }
    }

    // Update LV battery voltage (only if changed)
    if (label_lv_voltage != NULL && !CAN_mcu_status_checkDataIsStale()) {
        float lv_voltage = CAN_mcu_status_batt_voltage_get();
        int lv_voltage_x10 = FLOAT_TO_INT_TENTHS(lv_voltage);
        if (lv_voltage_x10 != cached_lv_voltage_x10) {
            lv_label_set_text_fmt(label_lv_voltage, "LV: %d.%d V",
                                  GET_WHOLE(lv_voltage_x10), GET_FRAC(lv_voltage_x10));
            cached_lv_voltage_x10 = lv_voltage_x10;
        }
    }

    // Update Bluetooth connection status (only if changed)
    if (label_bluetooth != NULL) {
        bool connected = BLE_IsConnected();
        if (connected != cached_bt_connected) {
            if (connected) {
                lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH " Connected");
                lv_obj_set_style_text_color(label_bluetooth, lv_color_hex(COLOR_TEXT_WHITE), 0);
            } else {
                lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH " Disconnected");
                lv_obj_set_style_text_color(label_bluetooth, lv_color_hex(COLOR_TEXT_GRAY), 0);
            }
            cached_bt_connected = connected;
        }
    }
}
