idf_component_register(
    INCLUDE_DIRS
        "include"
        "../../../../Libraries/Standard"
    SRCS
        "cpu_monitor.c"
        "../../../../Libraries/Standard/utils.c"
        "../../../../Libraries/Standard/movingAverage.c"
        "../../../../Libraries/Standard/movingAverageInt.c"

    REQUIRES freertos esp_timer
)
