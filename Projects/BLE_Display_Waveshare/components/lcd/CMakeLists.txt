idf_component_register(
    SRCS "lvgl_port.c" "lvgl_port_testing.c" "lcd_esp.c" "display.c" "touch.c"
    INCLUDE_DIRS "include"
    REQUIRES driver esp_lcd esp_driver_gpio lvgl esp_lcd_touch_gt911 utils esp_timer esp_mm
)