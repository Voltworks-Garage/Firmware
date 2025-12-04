#ifndef TOUCH_H
#define TOUCH_H

#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"

#ifdef __cplusplus
extern "C" {
#endif

void Touch_Init(void);
void Touch_DeInit(void);
void Touch_Run_1ms(void);
void Touch_Run_10ms(void);
bool Touch_GetXY(uint16_t* x, uint16_t* y);

#ifdef __cplusplus
}
#endif

#endif // TOUCH_H
