#include "screen_charging.h"
#include "../../../CAN/generated/dash_dbc.h"
#include "../styles.h"

//logging
// #define LOG_LOCAL_LEVEL ESP_LOG_VERBOSE
// #define LOG_LOCAL_LEVEL ESP_LOG_INFO
// #define LOG_LOCAL_LEVEL ESP_LOG_DEBUG
// #define LOG_LOCAL_LEVEL ESP_LOG_WARN
// #define LOG_LOCAL_LEVEL ESP_LOG_ERROR
#define LOG_LOCAL_LEVEL ESP_LOG_NONE
#include "esp_log.h"
static const char* TAG = "SCREEN_CHARGING";

// Helper macros for float to integer conversion (avoids float formatting)
#define FLOAT_TO_INT_TENTHS(val)    ((int)((val) * 10 + 0.5f))
#define FLOAT_TO_INT_THOUSANDTHS(val) ((int)((val) * 1000 + 0.5f))
#define GET_WHOLE(val_x10)          ((val_x10) / 10)
#define GET_FRAC(val_x10)           ((val_x10) % 10)
#define GET_WHOLE_mV(val_mv)        ((val_mv) / 1000)
#define GET_FRAC3_mV(val_mv)        ((val_mv) % 1000)

// UI elements
static lv_obj_t* label_title = NULL;
static lv_obj_t* label_soc = NULL;
static lv_obj_t* arc_soc = NULL;
static lv_obj_t* label_voltage = NULL;
static lv_obj_t* label_status = NULL;

// Scrollable container and cell voltage labels
static lv_obj_t* scroll_container = NULL;
#define NUM_CELLS 24
static lv_obj_t* label_cells[NUM_CELLS] = {NULL};

void ScreenCharging_Create(void) {
    ESP_LOGI(TAG, "Creating charging screen");

    lv_obj_t* screen = lv_screen_active();

    // Set background to black
    lv_obj_set_style_bg_color(screen, lv_color_hex(COLOR_BACKGROUND), 0);

    // Title - uses shared style
    label_title = lv_label_create(screen);
    lv_label_set_text(label_title, "CHARGING");
    lv_obj_add_style(label_title, &style_label_small_white, 0);
    lv_obj_set_pos(label_title, (480 - 100) / 2, 10);  // Centered at top

    // SOC arc (positioned at original location)
    arc_soc = lv_arc_create(screen);
    lv_obj_set_size(arc_soc, 220, 220);
    lv_arc_set_rotation(arc_soc, 135);
    lv_arc_set_bg_angles(arc_soc, 0, 270);
    lv_arc_set_range(arc_soc, 0, 100);
    lv_arc_set_value(arc_soc, 0);
    lv_obj_set_pos(arc_soc, (480 - 220) / 2, 50);  // Centered horizontally
    lv_obj_set_style_arc_color(arc_soc, lv_color_hex(COLOR_BATTERY_GREEN), LV_PART_INDICATOR);
    lv_obj_set_style_arc_width(arc_soc, 20, LV_PART_INDICATOR);
    lv_obj_set_style_arc_width(arc_soc, 20, LV_PART_MAIN);

    // SOC label (center of arc) - uses shared style
    label_soc = lv_label_create(screen);
    lv_label_set_text(label_soc, "0%");
    lv_obj_add_style(label_soc, &style_label_large_green, 0);
    lv_obj_align_to(label_soc, arc_soc, LV_ALIGN_CENTER, 0, 0);

    // Voltage label (moved up slightly)
    label_voltage = lv_label_create(screen);
    lv_label_set_text(label_voltage, "Voltage: --.-V");
    lv_obj_add_style(label_voltage, &style_label_small_white, 0);
    lv_obj_set_pos(label_voltage, 10, 275);

    // Status label (moved up slightly)
    label_status = lv_label_create(screen);
    lv_label_set_text(label_status, "Charging...");
    lv_obj_add_style(label_status, &style_label_small_green, 0);
    lv_obj_set_pos(label_status, 350, 275);

    // Section divider hint (moved up and on-screen)
    lv_obj_t* divider = lv_label_create(screen);
    lv_label_set_text(divider, "v Scroll for Cell Details v");
    lv_obj_add_style(divider, &style_label_small_white, 0);
    lv_obj_set_pos(divider, 120, 295);

    // Disable bouncy scrolling and velocity effects
    lv_obj_set_scroll_snap_y(screen, LV_SCROLL_SNAP_NONE);
    lv_obj_set_style_anim_duration(screen, 0, 0);  // No animation
    lv_obj_clear_flag(screen, LV_OBJ_FLAG_SCROLL_MOMENTUM);  // Disable momentum/velocity
    lv_obj_clear_flag(screen, LV_OBJ_FLAG_SCROLL_ELASTIC);   // Disable bounce effect

    // Cell voltage grid section (starts below the visible screen)
    // LVGL will automatically enable scrolling because content extends beyond screen
    const int grid_start_y = 330;  // Moved up to give more space
    const int cols = 2;  // 2 columns for better readability
    const int cell_width = 230;  // Wider to accommodate 3 decimal places
    const int cell_height = 28;
    const int x_spacing = 10;
    const int y_spacing = 2;
    const int margin_x = 10;

    // Add section header for cell voltages
    lv_obj_t* cell_header = lv_label_create(screen);
    lv_label_set_text(cell_header, "Battery Cell Voltages");
    lv_obj_add_style(cell_header, &style_label_small_green, 0);
    lv_obj_set_pos(cell_header, 140, grid_start_y);

    // Cell grid starts below the header
    const int cell_grid_start_y = grid_start_y + 25;

    for (int i = 0; i < NUM_CELLS; i++) {
        // Row-first order: C01, C02 in row 0; C03, C04 in row 1; etc.
        int row = i / cols;
        int col = i % cols;

        label_cells[i] = lv_label_create(screen);
        lv_label_set_text_fmt(label_cells[i], "C%02d: -.---V", i + 1);
        lv_obj_add_style(label_cells[i], &style_label_small_white, 0);

        int x_pos = margin_x + col * (cell_width + x_spacing);
        int y_pos = cell_grid_start_y + row * (cell_height + y_spacing);
        lv_obj_set_pos(label_cells[i], x_pos, y_pos);
    }

    ESP_LOGI(TAG, "Charging screen created with scrollable cell voltages");
}

void ScreenCharging_Destroy(void) {
    ESP_LOGI(TAG, "Destroying charging screen");

    lv_obj_clean(lv_screen_active());

    label_title = NULL;
    label_soc = NULL;
    arc_soc = NULL;
    label_voltage = NULL;
    label_status = NULL;
    scroll_container = NULL;

    for (int i = 0; i < NUM_CELLS; i++) {
        label_cells[i] = NULL;
    }
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

    // Update pack voltage
    if (label_voltage != NULL && !CAN_bms_status_checkDataIsStale()) {
        float voltage = CAN_bms_status_pack_voltage_get();
        int voltage_x10 = FLOAT_TO_INT_TENTHS(voltage);
        lv_label_set_text_fmt(label_voltage, "Pack: %d.%dV",
                              GET_WHOLE(voltage_x10), GET_FRAC(voltage_x10));
    }

    // Update individual cell voltages
    if (!CAN_bms_cell_voltages_checkDataIsStale()) {
        // Array of function pointers for each cell voltage getter
        typedef uint16_t (*CellVoltageGetter)(void);
        static const CellVoltageGetter cell_getters[NUM_CELLS] = {
            CAN_bms_cell_voltages_cell_1_voltage_get,
            CAN_bms_cell_voltages_cell_2_voltage_get,
            CAN_bms_cell_voltages_cell_3_voltage_get,
            CAN_bms_cell_voltages_cell_4_voltage_get,
            CAN_bms_cell_voltages_cell_5_voltage_get,
            CAN_bms_cell_voltages_cell_6_voltage_get,
            CAN_bms_cell_voltages_cell_7_voltage_get,
            CAN_bms_cell_voltages_cell_8_voltage_get,
            CAN_bms_cell_voltages_cell_9_voltage_get,
            CAN_bms_cell_voltages_cell_10_voltage_get,
            CAN_bms_cell_voltages_cell_11_voltage_get,
            CAN_bms_cell_voltages_cell_12_voltage_get,
            CAN_bms_cell_voltages_cell_13_voltage_get,
            CAN_bms_cell_voltages_cell_14_voltage_get,
            CAN_bms_cell_voltages_cell_15_voltage_get,
            CAN_bms_cell_voltages_cell_16_voltage_get,
            CAN_bms_cell_voltages_cell_17_voltage_get,
            CAN_bms_cell_voltages_cell_18_voltage_get,
            CAN_bms_cell_voltages_cell_19_voltage_get,
            CAN_bms_cell_voltages_cell_20_voltage_get,
            CAN_bms_cell_voltages_cell_21_voltage_get,
            CAN_bms_cell_voltages_cell_22_voltage_get,
            CAN_bms_cell_voltages_cell_23_voltage_get,
            CAN_bms_cell_voltages_cell_24_voltage_get
        };

        for (int i = 0; i < NUM_CELLS; i++) {
            if (label_cells[i] != NULL) {
                uint16_t cell_voltage_mv = cell_getters[i]();
                // Display voltage with 3 decimal places (e.g., 3.856V)
                // cell_voltage_mv is already in millivolts, so we can use it directly
                lv_label_set_text_fmt(label_cells[i], "C%02d: %d.%03dV",
                                      i + 1,
                                      GET_WHOLE_mV(cell_voltage_mv),
                                      GET_FRAC3_mV(cell_voltage_mv));
            }
        }
    }
}
