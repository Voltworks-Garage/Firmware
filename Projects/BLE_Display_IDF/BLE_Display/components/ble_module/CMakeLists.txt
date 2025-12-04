idf_component_register(
    SRCS 
        "ble_module.c"
        "app_handler.c"
        "../../../../../Libraries/Submodules/ble-protocol-schema/generated/c/ble_protocol.c"
    INCLUDE_DIRS "include" "../../../../../Libraries/Submodules/ble-protocol-schema/generated/c"
    REQUIRES nvs_flash bt esp_driver_gpio freertos can
)
