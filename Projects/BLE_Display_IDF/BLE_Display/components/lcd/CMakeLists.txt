idf_component_register(
    SRCS "lcd_esp.c" "display.c" "touch.c"
    INCLUDE_DIRS "include"
    REQUIRES driver esp_lcd esp_driver_gpio lvgl esp_lcd_hx8357d esp_adc utils
)