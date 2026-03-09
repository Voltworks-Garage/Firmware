#include "styles.h"

// ============================================================================
// Style Definitions
// ============================================================================

// Bar styles
lv_style_t style_battery_bar_indicator;
lv_style_t style_battery_bar_background;
lv_style_t style_power_bar_indicator;
lv_style_t style_power_bar_background;

// Label styles
lv_style_t style_label_large_white;
lv_style_t style_label_large_blue;
lv_style_t style_label_large_green;
lv_style_t style_label_extra_large_green;
lv_style_t style_label_large_gray;
lv_style_t style_label_small_white;
lv_style_t style_label_small_gray;
lv_style_t style_label_small_green;

// Arc styles
lv_style_t style_arc_speed;

// Track initialization
static bool styles_initialized = false;

// ============================================================================
// Initialization
// ============================================================================

void Styles_Init(void) {
    if (styles_initialized) return;

    LV_FONT_DECLARE(Montserrat_96);

    // ========== Battery Bar Background ==========
    lv_style_init(&style_battery_bar_background);
    lv_style_set_border_color(&style_battery_bar_background, lv_color_hex(COLOR_TEXT_WHITE));
    lv_style_set_border_width(&style_battery_bar_background, 2);
    lv_style_set_pad_all(&style_battery_bar_background, 6);  // Makes indicator smaller, border appears outside
    lv_style_set_radius(&style_battery_bar_background, 8);
    lv_style_set_bg_opa(&style_battery_bar_background, LV_OPA_TRANSP);  // Transparent background

    // ========== Battery Bar Indicator ==========
    lv_style_init(&style_battery_bar_indicator);
    lv_style_set_bg_opa(&style_battery_bar_indicator, LV_OPA_COVER);
    lv_style_set_bg_color(&style_battery_bar_indicator, lv_color_hex(COLOR_BATTERY_GREEN));
    lv_style_set_radius(&style_battery_bar_indicator, 3);  // Smaller radius than background

    // ========== Power Bar Indicator ==========
    lv_style_init(&style_power_bar_indicator);
    lv_style_set_bg_color(&style_power_bar_indicator, lv_color_hex(COLOR_POWER_POSITIVE));
    lv_style_set_radius(&style_power_bar_indicator, 4);

    // ========== Power Bar Background ==========
    lv_style_init(&style_power_bar_background);
    lv_style_set_bg_color(&style_power_bar_background, lv_color_hex(0x2a2a2a));
    lv_style_set_radius(&style_power_bar_background, 4);
    lv_style_set_border_width(&style_power_bar_background, 1);
    lv_style_set_border_color(&style_power_bar_background, lv_color_hex(0x555555));

    // ========== Large Labels ==========
    lv_style_init(&style_label_large_white);
    lv_style_set_text_font(&style_label_large_white, FONT_LARGE);
    lv_style_set_text_color(&style_label_large_white, lv_color_hex(COLOR_TEXT_WHITE));

    lv_style_init(&style_label_large_blue);
    lv_style_set_text_font(&style_label_large_blue, FONT_LARGE);
    lv_style_set_text_color(&style_label_large_blue, lv_color_hex(COLOR_SPEED_BLUE));

    lv_style_init(&style_label_large_green);
    lv_style_set_text_font(&style_label_large_green, FONT_LARGE);
    lv_style_set_text_color(&style_label_large_green, lv_color_hex(COLOR_BATTERY_GREEN));

    lv_style_init(&style_label_extra_large_green);
    lv_style_set_text_font(&style_label_extra_large_green, FONT_X_LARGE);
    lv_style_set_text_color(&style_label_extra_large_green, lv_color_hex(COLOR_BATTERY_GREEN));

    lv_style_init(&style_label_large_gray);
    lv_style_set_text_font(&style_label_large_gray, FONT_LARGE);
    lv_style_set_text_color(&style_label_large_gray, lv_color_hex(COLOR_TEXT_GRAY));

    // ========== Small Labels ==========
    lv_style_init(&style_label_small_white);
    lv_style_set_text_font(&style_label_small_white, FONT_SMALL);
    lv_style_set_text_color(&style_label_small_white, lv_color_hex(COLOR_TEXT_WHITE));

    lv_style_init(&style_label_small_gray);
    lv_style_set_text_font(&style_label_small_gray, FONT_SMALL);
    lv_style_set_text_color(&style_label_small_gray, lv_color_hex(COLOR_TEXT_GRAY));

    lv_style_init(&style_label_small_green);
    lv_style_set_text_font(&style_label_small_green, FONT_SMALL);
    lv_style_set_text_color(&style_label_small_green, lv_color_hex(COLOR_BATTERY_GREEN));

    // ========== Speed Arc ==========
    lv_style_init(&style_arc_speed);
    lv_style_set_arc_color(&style_arc_speed, lv_color_hex(COLOR_SPEED_BLUE));
    lv_style_set_arc_width(&style_arc_speed, 15);

    styles_initialized = true;
}