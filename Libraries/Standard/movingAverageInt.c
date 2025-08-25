#include "movingAverageInt.h"
#include <string.h>

uint16_t takeMovingAverageInt(movingAverageInt_S *x, uint16_t value){
    x->sum -= (x->buffer[x->index]);
    x->buffer[x->index++] = value;
    x->sum += value;
    if(x->index >= x->windowSize){
        x->index = 0;
    }
    return x->sum >> x->windowShift;
}

uint16_t getMovingAverageInt(movingAverageInt_S *x){
    return x->sum >> x->windowShift;
}

void clearMovingAverageInt(movingAverageInt_S *x){
    memset(x->buffer, 0, x->windowSize * sizeof(uint16_t));
    x->index = 0;
    x->sum = 0;
}

uint16_t takeLowPassFilterInt(lowPassFilterInt_S *x, uint32_t value){
    // convert input to Q7
    uint32_t valueQ7 = ((uint32_t)value) << 7;

    // IIR update: accum = alpha*input + (1-alpha)*prev
    x->accum = (x->alpha * valueQ7 + (128 - x->alpha) * x->accum) >> 7;

    // return integer result (drop Q10 fraction)
    return (uint16_t)(x->accum >> 7);
}

uint16_t getLowPassFilterInt(lowPassFilterInt_S *x){
    // return integer result (drop Q7 fraction)
    return (uint16_t)(x->accum >> 7);
}

void clearLowPassFilterInt(lowPassFilterInt_S *x){
    x->accum = 0;
}