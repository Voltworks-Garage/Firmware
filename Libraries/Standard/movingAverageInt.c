#include "movingAverageInt.h"
#include <string.h>

uint16_t takeMovingAverageInt(movingAverageInt_S *x, uint16_t value){
    x->sum -= (x->buffer[x->index]);
    x->buffer[x->index++] = value;
    x->sum += value;
    if(x->index >= x->windowSize){
        x->index = 0;
    }
    return x->sum / x->windowSize;
}

void clearMovingAverageInt(movingAverageInt_S *x){
    memset(x->buffer, 0, x->windowSize * sizeof(uint16_t));
    x->index = 0;
    x->sum = 0;
}