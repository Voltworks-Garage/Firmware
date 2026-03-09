//logging
#define LOG_LOCAL_LEVEL    ESP_LOG_NONE     /*!< No log output */
// #define LOG_LOCAL_LEVEL    ESP_LOG_ERROR    /*!< Critical errors, software module can not recover on its own */
// #define LOG_LOCAL_LEVEL    ESP_LOG_WARN     /*!< Error conditions from which recovery measures have been taken */
// #define LOG_LOCAL_LEVEL    ESP_LOG_INFO     /*!< Information messages which describe normal flow of events */
// #define LOG_LOCAL_LEVEL    ESP_LOG_DEBUG    /*!< Extra information which is not necessary for normal use (values, pointers, sizes, etc). */
// #define LOG_LOCAL_LEVEL    ESP_LOG_VERBOSE  /*!< Bigger chunks of debugging information, or frequent messages which can potentially flood the output. */
// #define LOG_LOCAL_LEVEL    ESP_LOG_MAX      /*!< Number of levels supported */
#include "esp_log.h"
static const char* TAG = "DISPLAYsm";

#include "display_state_machine.h"
#include "styles.h"
#include "rtos_utils.h"
#include "display.h"

// Screen includes
#include "screens/screen_logo.h"
#include "screens/screen_home.h"
#include "screens/screen_running.h"
#include "screens/screen_charging.h"

// CAN DBC includes
#include "dash_dbc.h"



// MCU vehicle state enum (matches MCU_App.X StateMachine order)
typedef enum {
    MCU_STATE_BOOT = 0,
    MCU_STATE_IDLE = 1,
    MCU_STATE_SILENT_WAKE = 2,
    MCU_STATE_RUNNING = 3,
    MCU_STATE_CHARGING = 4,
    MCU_STATE_GOING_TO_SLEEP = 5,
    MCU_STATE_SLEEP = 6,
    MCU_STATE_DIAG = 7
} MCU_VehicleState_E;

/******************************************************************************
 * State Machine
 *******************************************************************************/
#define DISPLAY_STATES(state)\
state(screen_welcome)\
state(screen_home)\
state(screen_running)\
state(screen_charging)\

#define STATE_FORM(WORD) WORD##_state,
#define FUNCTION_FORM(WORD) static void WORD(DISPLAY_entry_types_E entry_type);
#define FUNC_PTR_FORM(WORD) WORD,

typedef enum {
    DISPLAY_STATES(STATE_FORM)
    NUMBER_OF_DISPLAY_STATES
} DISPLAY_states_E;

typedef enum {
    ENTRY,
    EXIT,
    RUN,
    NONE
} DISPLAY_entry_types_E;

typedef void(*displayStatePtr)(DISPLAY_entry_types_E);

DISPLAY_STATES(FUNCTION_FORM)
static displayStatePtr display_state_functions[] = {DISPLAY_STATES(FUNC_PTR_FORM)};

static DISPLAY_states_E display_prevState = 0;
static DISPLAY_states_E display_curState = 0;
static DISPLAY_states_E display_nextState = 0;

static bool init = false;

/******************************************************************************
 * Timers
 *******************************************************************************/
NEW_TIMER(welcome_timer, 3000);
NEW_TIMER(backlight_delay, 30);

/******************************************************************************
 * Function Prototypes
 *******************************************************************************/
static DISPLAY_states_E map_vehicle_state_to_screen(uint8_t vehicle_state);
static void check_vehicle_state_transition(void);


/******************************************************************************
 * Public Functions
 *******************************************************************************/

void DisplayStateMachine_Run(void) {
    if(!init){
        display_state_functions[display_curState](ENTRY);
        init = true;
    }

    // Check for state transitions
    if (display_nextState != display_curState) {
        display_state_functions[display_curState](EXIT);
        display_prevState = display_curState;
        display_curState = display_nextState;
        display_state_functions[display_curState](ENTRY);
    }

    // Regular RUN call for current state
    display_state_functions[display_curState](RUN);
}

/******************************************************************************
 * State Functions
 *******************************************************************************/

void screen_welcome(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering WELCOME state");
            Styles_Init();
            ScreenLogo_Create();
            TIMER_START(welcome_timer);
            TIMER_START(backlight_delay);
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting WELCOME state");
            ScreenLogo_Destroy();
            break;

        case RUN:
            // Delay backlight so we dont see a flash of white.
            if (TIMER_IS_UP(backlight_delay)){
                Display_SetBrightness(100);
                Display_Enable(true);
            }

            // Auto-transition to HOME after 3 seconds
            if (TIMER_IS_UP(welcome_timer)) {
                display_nextState = screen_home_state;
            }
            break;

        default:
            break;
    }
}

void screen_home(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering HOME state");
            ScreenHome_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting HOME state");
            ScreenHome_Destroy();
            break;

        case RUN:
            ScreenHome_Update();
            check_vehicle_state_transition();
            break;

        default:
            break;
    }
}

void screen_running(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering RUNNING state");
            ScreenRunning_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting RUNNING state");
            ScreenRunning_Destroy();
            break;

        case RUN:
            ScreenRunning_Update();
            check_vehicle_state_transition();
            break;

        default:
            break;
    }
}

void screen_charging(DISPLAY_entry_types_E entry_type) {
    switch (entry_type) {
        case ENTRY:
            ESP_LOGI(TAG, "Entering CHARGING state");
            ScreenCharging_Create();
            break;

        case EXIT:
            ESP_LOGI(TAG, "Exiting CHARGING state");
            ScreenCharging_Destroy();
            break;

        case RUN:
            ScreenCharging_Update();
            check_vehicle_state_transition();
            break;

        default:
            break;
    }
}

/******************************************************************************
 * Helper Functions
 *******************************************************************************/

// Map MCU vehicle state to display screen state
static DISPLAY_states_E map_vehicle_state_to_screen(uint8_t vehicle_state) {
    switch (vehicle_state) {
        case MCU_STATE_BOOT:
            // Boot shows welcome screen
            return screen_welcome_state;

        case MCU_STATE_IDLE:
            // Idle shows home screen
            return screen_home_state;

        case MCU_STATE_RUNNING:
            // Running shows running screen
            return screen_running_state;

        case MCU_STATE_CHARGING:
            // Charging shows charging screen
            return screen_charging_state;

        default:
            ESP_LOGW(TAG, "Unknown vehicle state: %d, defaulting to home", vehicle_state);
            return screen_home_state;
    }
}

// Check CAN vehicle state and request screen transition if needed
// Call this from states that should respond to vehicle state changes
static void check_vehicle_state_transition(void) {
    if (!CAN_mcu_status_checkDataIsStale()) {
        uint8_t vehicle_state = CAN_mcu_status_vehicleState_get();
        DISPLAY_states_E requested_screen = map_vehicle_state_to_screen(vehicle_state);

        // Request state transition if different from current
        if (requested_screen != display_curState && requested_screen != display_nextState) {
            ESP_LOGI(TAG, "CAN vehicle state %d -> requesting screen %d", vehicle_state, requested_screen);
            display_nextState = requested_screen;
        }
    } else {
        ESP_LOGW(TAG, "CAN MCU status data is stale, cannot determine vehicle state");
        display_nextState = screen_running_state; // Default to home screen on stale data
    }
}
