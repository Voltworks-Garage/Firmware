#include "screens/screen_running.h"
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
static const char* TAG = "SCREEN_RUNNING";

// Helper macros for float to integer conversion (avoids float formatting)
#define FLOAT_TO_INT_TENTHS(val)    ((int)((val) * 10 + 0.5f))
#define GET_WHOLE(val_x10)          ((val_x10) / 10)
#define GET_FRAC(val_x10)           ((val_x10) % 10)

// Layout - Margins
#define MARGIN_TOP              10
#define MARGIN_BOTTOM           10
#define MARGIN_LEFT             10
#define MARGIN_RIGHT            20

// Layout - Speed Arc (center)
#define SPEED_ARC_SIZE          200
#define SPEED_ARC_WIDTH         20
#define SPEED_MAX               100

// Layout - Battery Bar (right side, same as home screen)
#define BATTERY_BAR_WIDTH       40
#define BATTERY_BAR_HEIGHT      200
#define BATTERY_BAR_MIN         0
#define BATTERY_BAR_MAX         100
#define BATTERY_BAR_X_OFFSET    -20
#define BATTERY_PERCENT_X_OFFSET -15

// Layout - Power Bar (bottom)
#define POWER_BAR_WIDTH         280
#define POWER_BAR_HEIGHT        20
#define POWER_BAR_Y_OFFSET      -10
#define POWER_LABEL_WIDTH       100
#define POWER_MAX_KW            60

// Layout - Turn Signals
#define TURN_SIGNAL_Y           5

// Layout - Idiot Lights (left column)
#define IDIOT_LIGHT_X           15
#define IDIOT_LIGHT_SPACING     35
#define IDIOT_LIGHT_START_Y     -70

// UI elements
static lv_obj_t* label_speed = NULL;
static lv_obj_t* label_speed_unit = NULL;
static lv_obj_t* arc_speed = NULL;
static lv_obj_t* bar_battery = NULL;
static lv_obj_t* label_battery_percent = NULL;
static lv_obj_t* bar_power = NULL;
static lv_obj_t* label_power = NULL;
static lv_obj_t* label_turn_left = NULL;
static lv_obj_t* label_turn_right = NULL;
static lv_obj_t* label_light_low = NULL;
static lv_obj_t* label_light_high = NULL;
static lv_obj_t* label_hazard = NULL;
static lv_obj_t* label_bluetooth = NULL;
static lv_obj_t* label_title = NULL;

// Cached values to detect changes (prevent unnecessary LVGL updates)
static int cached_speed_mph = -1;
static int cached_soc_int = -1;
static int cached_power_x10 = 0x7FFFFFFF;  // Use max int as invalid initial value
static bool cached_power_positive = true;
static uint16_t cached_turn_left = 0;
static uint16_t cached_turn_right = 0;
static uint16_t cached_low_beam = 0;
static uint16_t cached_high_beam = 0;
static bool cached_bt_connected = false;

void ScreenRunning_Create(void) {
    ESP_LOGI(TAG, "Creating running screen");

    lv_obj_t* screen = lv_screen_active();

    // Set background to black
    lv_obj_set_style_bg_color(screen, lv_color_hex(COLOR_BACKGROUND), 0);

    // ===== Title at top - uses shared style =====
    label_title = lv_label_create(screen);
    lv_label_set_text(label_title, "RUNNING");
    lv_obj_add_style(label_title, &style_label_small_white, 0);
    lv_obj_align(label_title, LV_ALIGN_TOP_MID, 0, MARGIN_TOP);

    // ===== Turn Signals (upper corners) =====
    // Left turn signal - color set dynamically in Update
    label_turn_left = lv_label_create(screen);
    lv_label_set_text(label_turn_left, LV_SYMBOL_LEFT);
    lv_obj_add_style(label_turn_left, &style_label_large_gray, 0);
    lv_obj_align(label_turn_left, LV_ALIGN_TOP_LEFT, 5, TURN_SIGNAL_Y);

    // Right turn signal - color set dynamically in Update
    label_turn_right = lv_label_create(screen);
    lv_label_set_text(label_turn_right, LV_SYMBOL_RIGHT);
    lv_obj_add_style(label_turn_right, &style_label_large_gray, 0);
    lv_obj_align(label_turn_right, LV_ALIGN_TOP_RIGHT, -5, TURN_SIGNAL_Y);

    // ===== Speed Arc (center) =====
    arc_speed = lv_arc_create(screen);
    lv_obj_set_size(arc_speed, SPEED_ARC_SIZE, SPEED_ARC_SIZE);
    lv_arc_set_rotation(arc_speed, 135);
    lv_arc_set_bg_angles(arc_speed, 0, 270);
    lv_arc_set_range(arc_speed, 0, SPEED_MAX);
    lv_arc_set_value(arc_speed, 0);
    lv_obj_center(arc_speed);
    lv_obj_set_style_arc_color(arc_speed, lv_color_hex(COLOR_BATTERY_GREEN), LV_PART_INDICATOR);
    lv_obj_set_style_arc_width(arc_speed, SPEED_ARC_WIDTH, LV_PART_INDICATOR);
    lv_obj_set_style_arc_width(arc_speed, SPEED_ARC_WIDTH, LV_PART_MAIN);

    // Speed number (center of arc) - uses shared style
    label_speed = lv_label_create(screen);
    lv_label_set_text(label_speed, "0");
    lv_obj_add_style(label_speed, &style_label_large_green, 0);
    lv_obj_set_width(label_speed, SPEED_ARC_SIZE);  // Fixed width for centering
    lv_obj_set_style_text_align(label_speed, LV_TEXT_ALIGN_CENTER, 0);
    lv_obj_align_to(label_speed, arc_speed, LV_ALIGN_CENTER, 0, -10);

    // Speed unit (below number, smaller font) - uses shared style
    label_speed_unit = lv_label_create(screen);
    lv_label_set_text(label_speed_unit, "mph");
    lv_obj_add_style(label_speed_unit, &style_label_small_green, 0);
    lv_obj_set_width(label_speed_unit, SPEED_ARC_SIZE);  // Fixed width for centering
    lv_obj_set_style_text_align(label_speed_unit, LV_TEXT_ALIGN_CENTER, 0);
    lv_obj_align_to(label_speed_unit, arc_speed, LV_ALIGN_CENTER, 0, 25);

    // ===== Battery Bar (right side, same as home screen) =====
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

    // ===== Power Bar (bottom, horizontal) =====
    // Power label (right-aligned, left of bar) - color set dynamically in Update
    label_power = lv_label_create(screen);
    lv_label_set_text(label_power, "0.0 kW");
    lv_obj_add_style(label_power, &style_label_small_green, 0);
    lv_obj_set_width(label_power, POWER_LABEL_WIDTH);
    lv_obj_set_style_text_align(label_power, LV_TEXT_ALIGN_RIGHT, 0);
    lv_obj_align(label_power, LV_ALIGN_BOTTOM_LEFT, MARGIN_LEFT, POWER_BAR_Y_OFFSET);

    // Power bar - uses shared power bar styles
    bar_power = lv_bar_create(screen);
    lv_obj_set_size(bar_power, POWER_BAR_WIDTH, POWER_BAR_HEIGHT);
    lv_bar_set_range(bar_power, 0, POWER_MAX_KW * 10);  // Range in 0.1 kW units
    lv_bar_set_value(bar_power, 0, LV_ANIM_OFF);
    lv_obj_align(bar_power, LV_ALIGN_BOTTOM_LEFT, MARGIN_LEFT + POWER_LABEL_WIDTH + 10, POWER_BAR_Y_OFFSET);

    // Apply shared power bar styles
    lv_obj_add_style(bar_power, &style_power_bar_indicator, LV_PART_INDICATOR);
    lv_obj_add_style(bar_power, &style_power_bar_background, LV_PART_MAIN);

    // ===== Idiot Lights (left column) - uses shared style =====
    // Low beam
    label_light_low = lv_label_create(screen);
    lv_label_set_text(label_light_low, LV_SYMBOL_EYE_CLOSE);
    lv_obj_add_style(label_light_low, &style_label_small_gray, 0);
    lv_obj_align(label_light_low, LV_ALIGN_LEFT_MID, IDIOT_LIGHT_X, IDIOT_LIGHT_START_Y);

    // High beam
    label_light_high = lv_label_create(screen);
    lv_label_set_text(label_light_high, LV_SYMBOL_EYE_CLOSE);
    lv_obj_add_style(label_light_high, &style_label_small_gray, 0);
    lv_obj_align(label_light_high, LV_ALIGN_LEFT_MID, IDIOT_LIGHT_X, IDIOT_LIGHT_START_Y + IDIOT_LIGHT_SPACING);

    // Hazard
    label_hazard = lv_label_create(screen);
    lv_label_set_text(label_hazard, LV_SYMBOL_WARNING);
    lv_obj_add_style(label_hazard, &style_label_small_gray, 0);
    lv_obj_align(label_hazard, LV_ALIGN_LEFT_MID, IDIOT_LIGHT_X, IDIOT_LIGHT_START_Y + IDIOT_LIGHT_SPACING * 2);

    // Bluetooth
    label_bluetooth = lv_label_create(screen);
    lv_label_set_text(label_bluetooth, LV_SYMBOL_BLUETOOTH);
    lv_obj_add_style(label_bluetooth, &style_label_small_gray, 0);
    lv_obj_align(label_bluetooth, LV_ALIGN_LEFT_MID, IDIOT_LIGHT_X, IDIOT_LIGHT_START_Y + IDIOT_LIGHT_SPACING * 3);

    ESP_LOGI(TAG, "Running screen created");
}

void ScreenRunning_Destroy(void) {
    ESP_LOGI(TAG, "Destroying running screen");

    lv_obj_clean(lv_screen_active());

    label_speed = NULL;
    label_speed_unit = NULL;
    arc_speed = NULL;
    bar_battery = NULL;
    label_battery_percent = NULL;
    bar_power = NULL;
    label_power = NULL;
    label_turn_left = NULL;
    label_turn_right = NULL;
    label_light_low = NULL;
    label_light_high = NULL;
    label_hazard = NULL;
    label_bluetooth = NULL;
    label_title = NULL;

    // Reset cached values
    cached_speed_mph = -1;
    cached_soc_int = -1;
    cached_power_x10 = 0x7FFFFFFF;
    cached_power_positive = true;
    cached_turn_left = 0;
    cached_turn_right = 0;
    cached_low_beam = 0;
    cached_high_beam = 0;
    cached_bt_connected = false;
}

void ScreenRunning_Update(void) {
    // ===== Update Speed (only if changed) =====
    if (label_speed != NULL && arc_speed != NULL) {
        // TODO: Replace with actual CAN velocity message when available
        float speed_ms = 12.0f;  // Hardcoded test value (m/s)
        float speed_mph = speed_ms * 2.237f;  // Convert m/s to mph
        int speed_mph_int = (int)(speed_mph + 0.5f);

        if (speed_mph_int != cached_speed_mph) {
            lv_label_set_text_fmt(label_speed, "%d", speed_mph_int);
            lv_arc_set_value(arc_speed, speed_mph_int);
            cached_speed_mph = speed_mph_int;
        }
    }

    // ===== Update Battery (only if changed) =====
    if (label_battery_percent != NULL && bar_battery != NULL && !CAN_bms_status_checkDataIsStale()) {
        float soc = CAN_bms_status_soc_percent_get();
        int soc_int = (int)soc;

        if (soc_int != cached_soc_int) {
            lv_label_set_text_fmt(label_battery_percent, "%d%%", soc_int);
            lv_bar_set_value(bar_battery, soc_int, LV_ANIM_ON);
            cached_soc_int = soc_int;
        }
    }

    // ===== Update Power (only if changed) =====
    if (label_power != NULL && bar_power != NULL && !CAN_bms_status_checkDataIsStale()) {
        float voltage = CAN_bms_status_pack_voltage_get();
        float current = CAN_bms_status_pack_current_get();
        float power_kw = (voltage * current) / 1000.0f;

        // Convert to tenths for display
        int power_x10 = FLOAT_TO_INT_TENTHS(power_kw < 0 ? -power_kw : power_kw);
        bool power_positive = (power_kw >= 0);

        // Only update if value or direction changed
        if (power_x10 != cached_power_x10 || power_positive != cached_power_positive) {
            lv_label_set_text_fmt(label_power, "%d.%d kW", GET_WHOLE(power_x10), GET_FRAC(power_x10));

            // Update bar (absolute value)
            int bar_value = power_x10 > POWER_MAX_KW * 10 ? POWER_MAX_KW * 10 : power_x10;
            lv_bar_set_value(bar_power, bar_value, LV_ANIM_ON);

            // Color based on discharge (positive) or regen (negative)
            if (power_positive) {
                lv_obj_set_style_text_color(label_power, lv_color_hex(COLOR_POWER_POSITIVE), 0);
                lv_obj_set_style_bg_color(bar_power, lv_color_hex(COLOR_POWER_POSITIVE), LV_PART_INDICATOR);
            } else {
                lv_obj_set_style_text_color(label_power, lv_color_hex(COLOR_POWER_NEGATIVE), 0);
                lv_obj_set_style_bg_color(bar_power, lv_color_hex(COLOR_POWER_NEGATIVE), LV_PART_INDICATOR);
            }

            cached_power_x10 = power_x10;
            cached_power_positive = power_positive;
        }
    }

    // ===== Update Turn Signals (only if changed) =====
    if (!CAN_mcu_status_checkDataIsStale()) {
        uint16_t left_signal = CAN_mcu_status_turnSignalFL_get() || CAN_mcu_status_turnSignalRL_get();
        uint16_t right_signal = CAN_mcu_status_turnSignalFR_get() || CAN_mcu_status_turnSignalRR_get();

        if (label_turn_left != NULL && left_signal != cached_turn_left) {
            lv_obj_set_style_text_color(label_turn_left,
                left_signal ? lv_color_hex(COLOR_TURN_SIGNAL) : lv_color_hex(COLOR_TEXT_GRAY), 0);
            cached_turn_left = left_signal;
        }
        if (label_turn_right != NULL && right_signal != cached_turn_right) {
            lv_obj_set_style_text_color(label_turn_right,
                right_signal ? lv_color_hex(COLOR_TURN_SIGNAL) : lv_color_hex(COLOR_TEXT_GRAY), 0);
            cached_turn_right = right_signal;
        }

        // Update hazard (both signals on) - updates when either signal changes
        if (label_hazard != NULL && (left_signal != cached_turn_left || right_signal != cached_turn_right)) {
            bool hazard_on = left_signal && right_signal;
            lv_obj_set_style_text_color(label_hazard,
                hazard_on ? lv_color_hex(COLOR_TURN_SIGNAL) : lv_color_hex(COLOR_TEXT_GRAY), 0);
        }
    }

    // ===== Update Idiot Lights (only if changed) =====
    if (!CAN_mcu_status_checkDataIsStale()) {
        // Low beam
        if (label_light_low != NULL) {
            uint16_t low_beam = CAN_mcu_status_lowBeam_get();
            if (low_beam != cached_low_beam) {
                lv_obj_set_style_text_color(label_light_low,
                    low_beam ? lv_color_hex(COLOR_BATTERY_GREEN) : lv_color_hex(COLOR_TEXT_GRAY), 0);
                lv_label_set_text(label_light_low,
                    low_beam ? LV_SYMBOL_EYE_OPEN : LV_SYMBOL_EYE_CLOSE);
                cached_low_beam = low_beam;
            }
        }

        // High beam
        if (label_light_high != NULL) {
            uint16_t high_beam = CAN_mcu_status_highBeam_get();
            if (high_beam != cached_high_beam) {
                lv_obj_set_style_text_color(label_light_high,
                    high_beam ? lv_color_hex(0x00FFFF) : lv_color_hex(COLOR_TEXT_GRAY), 0);  // Cyan for high beam
                lv_label_set_text(label_light_high,
                    high_beam ? LV_SYMBOL_EYE_OPEN : LV_SYMBOL_EYE_CLOSE);
                cached_high_beam = high_beam;
            }
        }
    }

    // ===== Update Bluetooth (only if changed) =====
    if (label_bluetooth != NULL) {
        bool connected = BLE_IsConnected();
        if (connected != cached_bt_connected) {
            lv_obj_set_style_text_color(label_bluetooth,
                connected ? lv_color_hex(COLOR_TEXT_WHITE) : lv_color_hex(COLOR_TEXT_GRAY), 0);
            cached_bt_connected = connected;
        }
    }
}
