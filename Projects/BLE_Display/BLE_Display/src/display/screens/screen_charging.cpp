#include "screen_charging.h"
#include "esp_log.h"
#include "../../../CAN/generated/dash_dbc.h"
#include "../styles.h"

static const char* TAG = "SCREEN_CHARGING";

// Helper macros for float to integer conversion (avoids float formatting)
#define FLOAT_TO_INT_TENTHS(val)    ((int)((val) * 10 + 0.5f))
#define GET_WHOLE(val_x10)          ((val_x10) / 10)
#define GET_FRAC(val_x10)           ((val_x10) % 10)

// UI elements
static lv_obj_t* label_title = NULL;
static lv_obj_t* label_soc = NULL;
static lv_obj_t* arc_soc = NULL;
static lv_obj_t* label_voltage = NULL;
static lv_obj_t* label_current = NULL;
static lv_obj_t* label_status = NULL;

void ScreenCharging_Create(void) {
    ESP_LOGI(TAG, "Creating charging screen");

    // Set background to dark green
    lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(COLOR_BACKGROUND), 0);

    // Title
    label_title = lv_label_create(lv_screen_active());
    lv_label_set_text(label_title, "CHARGING");
    lv_obj_set_style_text_font(label_title, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_title, lv_color_hex(COLOR_TEXT_WHITE), 0);
    lv_obj_align(label_title, LV_ALIGN_TOP_MID, 0, 10);

    // SOC arc (center)
    arc_soc = lv_arc_create(lv_screen_active());
    lv_obj_set_size(arc_soc, 220, 220);
    lv_arc_set_rotation(arc_soc, 135);
    lv_arc_set_bg_angles(arc_soc, 0, 270);
    lv_arc_set_range(arc_soc, 0, 100);
    lv_arc_set_value(arc_soc, 0);
    lv_obj_center(arc_soc);
    lv_obj_set_style_arc_color(arc_soc, lv_color_hex(COLOR_BATTERY_GREEN), LV_PART_INDICATOR);
    lv_obj_set_style_arc_width(arc_soc, 20, LV_PART_INDICATOR);
    lv_obj_set_style_arc_width(arc_soc, 20, LV_PART_MAIN);

    // SOC label (center of arc)
    label_soc = lv_label_create(lv_screen_active());
    lv_label_set_text(label_soc, "0%");
    lv_obj_set_style_text_font(label_soc, &lv_font_montserrat_48, 0);
    lv_obj_set_style_text_color(label_soc, lv_color_hex(COLOR_BATTERY_GREEN), 0);
    lv_obj_align_to(label_soc, arc_soc, LV_ALIGN_CENTER, 0, 0);

    // Voltage label (bottom left)
    label_voltage = lv_label_create(lv_screen_active());
    lv_label_set_text(label_voltage, "Voltage: --.-V");
    lv_obj_set_style_text_font(label_voltage, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_voltage, lv_color_hex(COLOR_TEXT_WHITE), 0);
    lv_obj_align(label_voltage, LV_ALIGN_BOTTOM_LEFT, 10, -40);

    // Current label (bottom left)
    label_current = lv_label_create(lv_screen_active());
    lv_label_set_text(label_current, "Current: --.-A");
    lv_obj_set_style_text_font(label_current, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_current, lv_color_hex(COLOR_TEXT_WHITE), 0);
    lv_obj_align(label_current, LV_ALIGN_BOTTOM_LEFT, 10, -10);

    // Status label (bottom right)
    label_status = lv_label_create(lv_screen_active());
    lv_label_set_text(label_status, "Charging...");
    lv_obj_set_style_text_font(label_status, FONT_SMALL, 0);
    lv_obj_set_style_text_color(label_status, lv_color_hex(COLOR_BATTERY_GREEN), 0);
    lv_obj_align(label_status, LV_ALIGN_BOTTOM_RIGHT, -10, -20);

    ESP_LOGI(TAG, "Charging screen created");
}

void ScreenCharging_Destroy(void) {
    ESP_LOGI(TAG, "Destroying charging screen");

    lv_obj_clean(lv_screen_active());

    label_title = NULL;
    label_soc = NULL;
    arc_soc = NULL;
    label_voltage = NULL;
    label_current = NULL;
    label_status = NULL;
}

void ScreenCharging_Update(void) {
    // Update SOC
    if (label_soc != NULL && arc_soc != NULL && !CAN_bms_status_checkDataIsStale()) {
        float soc = CAN_bms_status_soc_percent_get();
        int soc_int = (int)soc;

        lv_label_set_text_fmt(label_soc, "%d%%", soc_int);
        lv_arc_set_value(arc_soc, soc_int);

        // Update status based on SOC
        if (label_status != NULL) {
            if (soc >= 99.0f) {
                lv_label_set_text(label_status, "Fully Charged");
            } else if (soc >= 80.0f) {
                lv_label_set_text(label_status, "Nearly Full");
            } else {
                lv_label_set_text(label_status, "Charging...");
            }
        }
    }

    // Update voltage
    if (label_voltage != NULL && !CAN_bms_status_checkDataIsStale()) {
        float voltage = CAN_bms_status_pack_voltage_get();
        int voltage_x10 = FLOAT_TO_INT_TENTHS(voltage);
        lv_label_set_text_fmt(label_voltage, "Voltage: %d.%dV",
                              GET_WHOLE(voltage_x10), GET_FRAC(voltage_x10));
    }

    // Update current (if available in CAN messages)
    if (label_current != NULL && !CAN_bms_status_checkDataIsStale()) {
        // Assuming there's a pack_current field - adjust as needed
        // For now, show placeholder
        lv_label_set_text(label_current, "Current: --.-A");
    }
}
