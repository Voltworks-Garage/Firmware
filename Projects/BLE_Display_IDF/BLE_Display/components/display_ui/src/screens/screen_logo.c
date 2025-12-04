#include "screens/screen_logo.h"
#include "logo.h"
#include "esp_log.h"

// LVGL image object to hold the logo
static lv_obj_t* logo_img = NULL;

void ScreenLogo_Create(void) {
    ESP_LOGI("SCREEN_LOGO", "Creating logo screen...");

    // Set background to black (matching logo background)
    lv_obj_set_style_bg_color(lv_screen_active(), lv_color_hex(0x000000), 0);

    // Create an image descriptor for the logo
    static lv_image_dsc_t logo_dsc;
    logo_dsc.header.cf = LV_COLOR_FORMAT_RGB565;  // RGB565 format
    logo_dsc.header.w = VOLTWORKS_GARAGE_WIDTH;
    logo_dsc.header.h = VOLTWORKS_GARAGE_HEIGHT;
    logo_dsc.data_size = VOLTWORKS_GARAGE_WIDTH * VOLTWORKS_GARAGE_HEIGHT * sizeof(uint16_t);
    logo_dsc.data = (const uint8_t*)Voltworks_Garage;

    // Create image object
    logo_img = lv_image_create(lv_screen_active());
    lv_image_set_src(logo_img, &logo_dsc);

    // Center the image on the screen
    // Display is 480x320 in landscape, logo is 322x320
    lv_obj_align(logo_img, LV_ALIGN_CENTER, 0, 0);

    ESP_LOGI("SCREEN_LOGO", "Logo screen created - %dx%d image centered",
             VOLTWORKS_GARAGE_WIDTH, VOLTWORKS_GARAGE_HEIGHT);
}

void ScreenLogo_Destroy(void) {
    if (logo_img != NULL) {
        lv_obj_del(logo_img);
        logo_img = NULL;
        ESP_LOGI("SCREEN_LOGO", "Logo screen destroyed");
    }
}
