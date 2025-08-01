#include "SerialDebugger.h"
#include "uart.h"
#include "pins.h"
#include "ADC.h"
#include "OC.h"
#include "sleep.h"
#include "tsk.h"


#define DEBUG 1
#if DEBUG
#include <stdio.h>
#include "uart.h"

static uint8_t debugEnable = 1;
#define debuggerService_print(...) if(debugEnable){char tempArray[125]={};sprintf(tempArray,__VA_ARGS__);Uart1Write(tempArray);}
#else
#define debuggerService_print(...)
#endif

#define LS 5863588
#define GPIO_SET 156940064
#define GPIO_GET 156926996
#define I2C_SET 9287727
#define I2C_GET 9274659
#define SPI 193506033
#define ADC 193486029
#define RESET_BOOT 273105544
#define SLEEP 274527774


unsigned long hash(const char *str);

///*Extra pointer so the compiler is happy*/
//static unsigned char msgBuff[64] = {};
//static char * msg = (char*)msgBuff;
//static unsigned char * msgUart = msgBuff;

void SerialConsole_Run_100ms(void) {
    if (Uart1RXdataReady()) {
        unsigned char msg[64] = {};
        Uart1Read(msg);
        debuggerService_print("User: %s\n", msg);

        /*Parse cmd string by spaces*/
        char cmd[16];
        char port;
        int pin;
        int state;
        sscanf(msg, "%16s %*s\n", cmd);
        unsigned long newHash = hash(cmd);
        switch (newHash) {
            case GPIO_SET:
                debuggerService_print("running GPIO_SET\n");
                if (sscanf(msg, "%*s %1c%2d %1d", &port, &pin, &state) == 4) {
                    gpio_pin_t thisPin = (gpio_pin_t)((port - 'a') * 16 + pin);
                    PINS_write(thisPin, state);
                } else {
                    debuggerService_print("GPIO_SET failed\n");
                }
                break;
                
            case GPIO_GET:
                debuggerService_print("running GPIO_GET\n");
                if (sscanf(msg, "%*s %1c%2d", &port, &pin) == 3) {
                    gpio_pin_t thisPin = (gpio_pin_t)((port - 'a') * 16 + pin);
                    PINS_State_E state = PINS_read(thisPin);
                    debuggerService_print("PIN %c%d state: %d\n", port, pin, state);
                } else {
                    debuggerService_print("GPIO_GET failed\n");
                }
                break;
                
            case I2C_SET:
                debuggerService_print("running I2C_SET\n");
                break;
                
            case I2C_GET:
                debuggerService_print("running I2C_GET\n");
                break;
                
            case SPI:
                debuggerService_print("running SPI\n");
                break;
                
            case ADC:
                debuggerService_print("running ADC\n");
                if (sscanf(msg, "%*s %2d", &pin) == 2) {
                    debuggerService_print("ADC AN%d value: %d\n", pin, ADC_GetValue(pin));
                } else {
                    debuggerService_print("ADC failed\n");
                }
                debuggerService_print("running ADC\n");
                break;
                
            case LS:
                debuggerService_print("Available commands:\ngpioget [port][pin]\ngpioset [port][pin] [value]\nadc [analog pin]\nreset\nsleep\n")
                break;
                
            case RESET_BOOT:
                __asm__ volatile ("reset");
                break;
                
            case SLEEP:
                Tsk_Sleep();
                debuggerService_print("\nwaking up....\n");
                break;
                
            default:
                debuggerService_print("invalid command. Type 'ls' to list commands: %s %lu\n", cmd, newHash);
                break;
        }

    }
}

unsigned long hash(const char *str) {
    unsigned long hash = 5381;
    int c;

    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash;
}

