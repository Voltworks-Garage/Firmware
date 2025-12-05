idf_component_register(
    SRCS "src/display_state_machine.c"
         "src/styles.c"
         "src/screens/screen_logo.c"
         "src/screens/screen_home.c"
         "src/screens/screen_running.c"
         "src/screens/screen_charging.c"
    INCLUDE_DIRS "include"
                 "src/screens"
    REQUIRES lvgl can ble_module utils lcd
)
