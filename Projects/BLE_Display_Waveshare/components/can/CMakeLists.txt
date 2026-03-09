idf_component_register(
    SRCS
        "can.c"
        "../../../../CAN/generated/dash_dbc.c"
        "../../../../Libraries/Standard/utils.c"
    INCLUDE_DIRS
        "include"
        "../../../../CAN/generated"
        "../../../../Libraries/Standard"
    REQUIRES driver esp_driver_gpio freertos  # Legacy TWAI + new GPIO driver
)
