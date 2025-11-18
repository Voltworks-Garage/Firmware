#include "screen_home.h"
#include "esp_log.h"
#include "../../../CAN/generated/dash_dbc.h"
#include "../../../ble_module.h"
#include "../styles.h"

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

void ScreenHome_Create(void) {
    ESP_LOGI(TAG, "Creating home screen");

    // Set background color
    lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(COLOR_BACKGROUND), 0);

    // Title at top
    label_title = lv_label_create(lv_screen_active());
    lv_label_set_text(label_title, "HOME");
    lv_obj_set_style_text_font(label_title, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_title, lv_color_hex(COLOR_TEXT_WHITE), 0);
    lv_obj_align(label_title, LV_ALIGN_TOP_MID, 0, MARGIN_TOP);

    // Battery bar on right side
    bar_battery = lv_bar_create(lv_screen_active());
    lv_obj_set_size(bar_battery, BATTERY_BAR_WIDTH, BATTERY_BAR_HEIGHT);
    lv_bar_set_range(bar_battery, BATTERY_BAR_MIN, BATTERY_BAR_MAX);
    lv_bar_set_value(bar_battery, BATTERY_BAR_MIN, LV_ANIM_OFF);
    lv_obj_align(bar_battery, LV_ALIGN_RIGHT_MID, -MARGIN_RIGHT_BAR, 0);

    // Style the indicator (filled part)
    lv_obj_set_style_bg_color(bar_battery, lv_color_hex(COLOR_BATTERY_GREEN), LV_PART_INDICATOR);
    lv_obj_set_style_radius(bar_battery, 8, LV_PART_INDICATOR);  // Rounded corners

    // Style the background (empty part)
    lv_obj_set_style_bg_color(bar_battery, lv_color_hex(0x2a2a2a), LV_PART_MAIN);  // Dark gray background
    lv_obj_set_style_radius(bar_battery, 8, LV_PART_MAIN);  // Rounded corners
    lv_obj_set_style_border_width(bar_battery, 2, LV_PART_MAIN);  // Border thickness
    lv_obj_set_style_border_color(bar_battery, lv_color_hex(0x555555), LV_PART_MAIN);  // Border color

    // Battery percentage below bar
    label_battery_percent = lv_label_create(lv_screen_active());
    lv_label_set_text(label_battery_percent, "---%");
    lv_obj_set_style_text_font(label_battery_percent, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_battery_percent, lv_color_hex(COLOR_BATTERY_GREEN), 0);
    lv_obj_align(label_battery_percent, LV_ALIGN_RIGHT_MID, BATTERY_PERCENT_X_OFFSET, BATTERY_BAR_HEIGHT / 2 + 20);

    // Left side labels - HV Voltage
    label_hv_voltage = lv_label_create(lv_screen_active());
    lv_label_set_text(label_hv_voltage, "HV: --.- V");
    lv_obj_set_style_text_font(label_hv_voltage, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_hv_voltage, lv_color_hex(COLOR_TEXT_WHITE), 0);
    lv_obj_align(label_hv_voltage, LV_ALIGN_LEFT_MID, MARGIN_LEFT, LEFT_LABEL_Y_HV);

    // Left side labels - LV Voltage
    label_lv_voltage = lv_label_create(lv_screen_active());
    lv_label_set_text(label_lv_voltage, "LV: --.- V");
    lv_obj_set_style_text_font(label_lv_voltage, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_lv_voltage, lv_color_hex(COLOR_TEXT_WHITE), 0);
    lv_obj_align(label_lv_voltage, LV_ALIGN_LEFT_MID, MARGIN_LEFT, LEFT_LABEL_Y_LV);

    // Left side labels - Bluetooth
    label_bluetooth = lv_label_create(lv_screen_active());
    lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH " Disconnected");
    lv_obj_set_style_text_font(label_bluetooth, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_bluetooth, lv_color_hex(COLOR_TEXT_GRAY), 0);
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
}

void ScreenHome_Update(void) {
    // Update HV battery voltage and SOC
    if (!CAN_bms_status_checkDataIsStale()) {
        // Update HV voltage
        if (label_hv_voltage != NULL) {
            float hv_voltage = CAN_bms_status_pack_voltage_get();
            int hv_voltage_x10 = FLOAT_TO_INT_TENTHS(hv_voltage);
            lv_label_set_text_fmt(label_hv_voltage, "HV: %d.%d V",
                                  GET_WHOLE(hv_voltage_x10), GET_FRAC(hv_voltage_x10));
        }

        // Update battery percentage and bar
        if (label_battery_percent != NULL && bar_battery != NULL) {
            float soc = CAN_bms_status_soc_percent_get();
            int soc_int = (int)soc;
            lv_label_set_text_fmt(label_battery_percent, "%d%%", soc_int);
            lv_bar_set_value(bar_battery, soc_int, LV_ANIM_ON);
        }
    }

    // Update LV battery voltage
    if (label_lv_voltage != NULL && !CAN_mcu_status_checkDataIsStale()) {
        float lv_voltage = CAN_mcu_status_batt_voltage_get();
        int lv_voltage_x10 = FLOAT_TO_INT_TENTHS(lv_voltage);
        lv_label_set_text_fmt(label_lv_voltage, "LV: %d.%d V",
                              GET_WHOLE(lv_voltage_x10), GET_FRAC(lv_voltage_x10));
    }

    // Update Bluetooth connection status
    if (label_bluetooth != NULL) {
        bool connected = BLE_IsConnected();
        if (connected) {
            lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH " Connected");
            lv_obj_set_style_text_color(label_bluetooth, lv_color_hex(COLOR_TEXT_WHITE), 0);
        } else {
            lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH " Disconnected");
            lv_obj_set_style_text_color(label_bluetooth, lv_color_hex(COLOR_TEXT_GRAY), 0);
        }
    }
}
