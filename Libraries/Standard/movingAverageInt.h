/* 
 * File:   movingAverageInt.h
 * Author: Claude Code
 *
 * Integer-only moving average implementation for CPU usage measurement
 */

#ifndef MOVINGAVERAGEINT_H
#define	MOVINGAVERAGEINT_H

#include <stdint.h>

typedef struct {
    uint16_t index;
    const uint16_t windowSize;
    uint32_t sum;
    uint16_t *buffer;
} movingAverageInt_S;

/**
 * @brief Creates an integer moving average object
 * @param x: name of the average object
 * @param y: Window average size
 * @return none
 */
#define NEW_AVERAGE_INT(x,y) \
static uint16_t x##buffer[y]={};\
static movingAverageInt_S x##Object = {\
    .index = 0, \
    .windowSize = y, \
    .sum = 0, \
    .buffer = x##buffer \
};\
static movingAverageInt_S * x = &x##Object

/**
 * @brief: Call with Integer Moving Average object repeatedly
 * @param x: Name of the average object
 * @param value: New value to include in the average
 * @return : running average (integer)
 */
uint16_t takeMovingAverageInt(movingAverageInt_S *x, uint16_t value);

/**
 * @brief: resets the integer filter
 * @param x: Name of the average object
 */
void clearMovingAverageInt(movingAverageInt_S *x);

#endif	/* MOVINGAVERAGEINT_H */