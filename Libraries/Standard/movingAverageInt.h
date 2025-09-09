/* 
 * File:   movingAverageInt.h
 * Author: Claude Code
 *
 * Integer-only moving average implementation for CPU usage measurement
 */

#ifndef MOVINGAVERAGEINT_H
#define	MOVINGAVERAGEINT_H

#include <stdint.h>
#include <math.h>

typedef struct {
    uint16_t index;
    const uint16_t windowSize;
    const uint8_t windowShift;  // log2(windowSize)
    uint32_t sum;
    uint16_t *buffer;
} movingAverageInt_S;

typedef struct {
    uint16_t alpha;
    uint32_t accum;
} lowPassFilterInt_S;

#define TWO_PI 6.28318530717958647692

/**
 * @brief Creates an integer moving average object
 * @param x: name of the average object
 * @param y: Window average size (must be power of 2)
 * @return none
 */
#define NEW_AVERAGE_INT(x,y) \
static char __attribute__((unused)) x##_power_of_2_check[((y) > 0) && (((y) & ((y) - 1)) == 0) ? 1 : -1];\
static uint16_t x##buffer[y]={};\
static movingAverageInt_S x##Object = {\
    .index = 0, \
    .windowSize = y, \
    .windowShift = __builtin_ctz(y), \
    .sum = 0, \
    .buffer = x##buffer \
};\
static movingAverageInt_S * x = &x##Object

/**
 * @brief Creates an integer low pass filter object
 * @param x: name of the average object
 * @param y: Fc Cutoff Frequency in Hz (Fc < Fs/2) to meet nyquist
 * @param z: Fs Sample time in Hz
 * @return none
 */
#define NEW_LOW_PASS_FILTER_INT(name, Fc, Fs)  \
static lowPassFilterInt_S name##Object = {\
    .alpha = ((uint16_t)( ((1.0 - exp(-TWO_PI * (double)(Fc) / (double)(Fs))) * 128) + 0.5 )), \
    .accum = 0, \
};\
static lowPassFilterInt_S * name = &name##Object

/**
 * @brief: Call with Integer Moving Average object repeatedly
 * @param x: Name of the average object
 * @param value: New value to include in the average
 * @return : running average (integer)
 */
uint16_t takeMovingAverageInt(movingAverageInt_S *x, uint16_t value);

/**
 * @brief: Get the current moving average value without adding a new sample
 * @param x: Name of the average object
 * @return : current average (integer)
 */
uint16_t getMovingAverageInt(movingAverageInt_S *x);

/**
 * @brief: resets the integer filter
 * @param x: Name of the average object
 */
void clearMovingAverageInt(movingAverageInt_S *x);


/**
 * @brief: Call with Integer Low Pass Filter object repeatedly
 * @param x: Pointer to the filter object
 * @param value: New value to include in the filter
 * @return : LPF output (integer)
 */
uint16_t takeLowPassFilterInt(lowPassFilterInt_S *x, uint32_t value);

/**
 * @brief: returns the filtered value.
 * @param x: Pointer to the filter object
 */
uint16_t getLowPassFilterInt(lowPassFilterInt_S *x);

/**
 * @brief: clears the low pass filter to 0.
 * @param x: Pointer to the filter object
 */
void clearLowPassFilterInt(lowPassFilterInt_S *x);

#endif	/* MOVINGAVERAGEINT_H */