idf_component_register(SRCS "main.c"
                    INCLUDE_DIRS "."
                    REQUIRES can ble_module lcd utils esp_hw_support)