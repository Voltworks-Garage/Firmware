#ifndef DISPLAY_STYLES_H
#define DISPLAY_STYLES_H

#include <lvgl.h>

#ifdef __cplusplus
extern "C" {
#endif

// ============================================================================
// Color Definitions
// ============================================================================
#define COLOR_BACKGROUND        0x000000
#define COLOR_BACKGROUND_BLUE   0x001F3F
#define COLOR_TEXT_WHITE        0xFFFFFF
#define COLOR_TEXT_GRAY         0x888888
#define COLOR_BATTERY_GREEN     0x00FF00
#define COLOR_SPEED_BLUE        0x00AAFF
#define COLOR_TURN_SIGNAL       0xFFAA00
#define COLOR_POWER_POSITIVE    0x00FF00
#define COLOR_POWER_NEGATIVE    0xFF6600
#define COLOR_HIGH_BEAM         0x00FFFF

// ============================================================================
// Font Definitions
// ============================================================================
#define FONT_LARGE              &lv_font_montserrat_48
#define FONT_SMALL              &lv_font_montserrat_24

// ============================================================================
// Style Declarations
// ============================================================================

// Bar styles
extern lv_style_t style_bar_indicator_green;
extern lv_style_t style_bar_background;
extern lv_style_t style_power_bar_indicator;
extern lv_style_t style_power_bar_background;

// Label styles
extern lv_style_t style_label_large_white;
extern lv_style_t style_label_large_blue;
extern lv_style_t style_label_large_green;
extern lv_style_t style_label_large_gray;
extern lv_style_t style_label_small_white;
extern lv_style_t style_label_small_gray;
extern lv_style_t style_label_small_green;

// Arc styles
extern lv_style_t style_arc_speed;

// ============================================================================
// Functions
// ============================================================================

// Initialize all styles (call once at startup)
void Styles_Init(void);

#ifdef __cplusplus
}
#endif

#endif // DISPLAY_STYLES_H
