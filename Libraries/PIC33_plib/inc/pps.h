/* 
 * File:   pps.h
 * Author: kid group
 *
 * Created on March 7, 2018, 10:12 PM
 */

#ifndef PPS_H
#define	PPS_H

/*******************************************************************************
 * PPS (Peripheral Pin Select) Definitions - Multi-Processor Support
 * ****************************************************************************/

// PPS Input Pin enumeration
typedef enum {
    RPI16_IN = 0x10,
    RPI17_IN = 0x11,
    RPI18_IN = 0x12,
    RPI19_IN = 0x13,
    RPI20_IN = 0x14,
    RPI21_IN = 0x15,
    RPI22_IN = 0x16,
    RPI23_IN = 0x17,
    RPI30_IN = 0x1E,
    RPI31_IN = 0x1F,
    RPI32_IN = 0x20,
    RPI33_IN = 0x21,
    RPI34_IN = 0x22,
    RPI35_IN = 0x23,
    RPI36_IN = 0x24,
    RPI37_IN = 0x25,
    RPI38_IN = 0x26,
    RPI39_IN = 0x27,
    RPI40_IN = 0x28,
    RPI41_IN = 0x29,
    RPI42_IN = 0x2A,
    RPI43_IN = 0x2B,
    RPI44_IN = 0x2C,
    RPI45_IN = 0x2D,
    RPI46_IN = 0x2E,
    RPI47_IN = 0x2F,
    RPI49_IN = 0x31,
    RPI50_IN = 0x32,
    RPI51_IN = 0x33,
    RPI52_IN = 0x34,
    RP55_IN = 0x37,
    RPI60_IN = 0x3C,
    RPI61_IN = 0x3D,
    RPI62_IN = 0x3E,
    RP64_IN = 0x40,
    RP65_IN = 0x41,
    RP66_IN = 0x42,
    RP67_IN = 0x43,
    RP68_IN = 0x44,
    RP69_IN = 0x45,
    RP70_IN = 0x46,
    RP71_IN = 0x47,
    RPI72_IN = 0x48,
    RPI73_IN = 0x49,
    RPI74_IN = 0x4A,
    RPI75_IN = 0x4B,
    RPI76_IN = 0x4C,
    RPI77_IN = 0x4D,
    RPI78_IN = 0x4E,
    RP79_IN = 0x4F,
    RP80_IN = 0x50,
    RPI81_IN = 0x51,
    RP82_IN = 0x52,
    RPI83_IN = 0x53,
    RP84_IN = 0x54,
    RP85_IN = 0x55,
    RPI86_IN = 0x56,
    RP87_IN = 0x57,
    RPI88_IN = 0x58,
    RPI89_IN = 0x59,
    RP96_IN = 0x60,
    RPI96_IN = 0x60,
    RP97_IN = 0x61,
    RP98_IN = 0x62,
    RP99_IN = 0x63,
    RP100_IN = 0x64,
    RP101_IN = 0x65,
    RP102_IN = 0x66,
    RP109_IN = 0x6D,
    RP112_IN = 0x70,
    RP113_IN = 0x71,
    RP104_IN = 0x68,
    RP118_IN = 0x76,
    RPI119_IN = 0x77,
    RP120_IN = 0x78,
    RPI121_IN = 0x79,
    RP108_IN = 0x6C,
    RPI124_IN = 0x7C,
    RP125_IN = 0x7D,
    RP126_IN = 0x7E,
    RP127_IN = 0x7F
} pps_input_pin_t;

/*******************************************************************************
 * PPS Output Pin Enumeration - Multi-Processor Support
 * ****************************************************************************/

// PPS Output Pin enumeration - only defined if SFR exists on processor
typedef enum {
    PPS_OUTPUT_NONE = 0,
    
#ifdef _RP36R
    RP36_OUT = 36,
#endif
#ifdef _RP64R
    RP64_OUT = 64,
#endif
#ifdef _RP65R
    RP65_OUT = 65,
#endif
#ifdef _RP66R
    RP66_OUT = 66,
#endif
#ifdef _RP67R
    RP67_OUT = 67,
#endif
#ifdef _RP68R
    RP68_OUT = 68,
#endif
#ifdef _RP69R
    RP69_OUT = 69,
#endif
#ifdef _RP70R
    RP70_OUT = 70,
#endif
#ifdef _RP71R
    RP71_OUT = 71,
#endif
#ifdef _RP79R
    RP79_OUT = 79,
#endif
#ifdef _RP80R
    RP80_OUT = 80,
#endif
#ifdef _RP82R
    RP82_OUT = 82,
#endif
#ifdef _RP84R
    RP84_OUT = 84,
#endif
#ifdef _RP85R
    RP85_OUT = 85,
#endif
#ifdef _RP87R
    RP87_OUT = 87,
#endif
#ifdef _RP96R
    RP96_OUT = 96,
#endif
#ifdef _RP97R
    RP97_OUT = 97,
#endif
#ifdef _RP98R
    RP98_OUT = 98,
#endif
#ifdef _RP99R
    RP99_OUT = 99,
#endif
#ifdef _RP100R
    RP100_OUT = 100,
#endif
#ifdef _RP101R
    RP101_OUT = 101,
#endif
#ifdef _RP102R
    RP102_OUT = 102,
#endif
#ifdef _RP104R
    RP104_OUT = 104,
#endif
#ifdef _RP108R
    RP108_OUT = 108,
#endif
#ifdef _RP109R
    RP109_OUT = 109,
#endif
#ifdef _RP112R
    RP112_OUT = 112,
#endif
#ifdef _RP113R
    RP113_OUT = 113,
#endif
#ifdef _RP118R
    RP118_OUT = 118,
#endif
#ifdef _RP120R
    RP120_OUT = 120,
#endif
#ifdef _RP125R
    RP125_OUT = 125,
#endif
#ifdef _RP126R
    RP126_OUT = 126,
#endif
#ifdef _RP127R
    RP127_OUT = 127,
#endif
    
    PPS_OUTPUT_MAX = 255,
} pps_output_pin_t;

/*******************************************************************************
 * PPS Utility Functions
 * ****************************************************************************/

// Get register address for PPS output pin (returns NULL if not available)
#define PPS_GET_OUTPUT_REG(pin) ( \
    ((pin) == RP36_OUT && defined(_RP36R)) ? &_RP36R : \
    ((pin) == RP64_OUT && defined(_RP64R)) ? &_RP64R : \
    ((pin) == RP65_OUT && defined(_RP65R)) ? &_RP65R : \
    ((pin) == RP66_OUT && defined(_RP66R)) ? &_RP66R : \
    ((pin) == RP67_OUT && defined(_RP67R)) ? &_RP67R : \
    ((pin) == RP68_OUT && defined(_RP68R)) ? &_RP68R : \
    ((pin) == RP69_OUT && defined(_RP69R)) ? &_RP69R : \
    ((pin) == RP70_OUT && defined(_RP70R)) ? &_RP70R : \
    ((pin) == RP71_OUT && defined(_RP71R)) ? &_RP71R : \
    ((pin) == RP79_OUT && defined(_RP79R)) ? &_RP79R : \
    ((pin) == RP80_OUT && defined(_RP80R)) ? &_RP80R : \
    ((pin) == RP82_OUT && defined(_RP82R)) ? &_RP82R : \
    ((pin) == RP84_OUT && defined(_RP84R)) ? &_RP84R : \
    ((pin) == RP85_OUT && defined(_RP85R)) ? &_RP85R : \
    ((pin) == RP87_OUT && defined(_RP87R)) ? &_RP87R : \
    ((pin) == RP96_OUT && defined(_RP96R)) ? &_RP96R : \
    ((pin) == RP97_OUT && defined(_RP97R)) ? &_RP97R : \
    ((pin) == RP98_OUT && defined(_RP98R)) ? &_RP98R : \
    ((pin) == RP99_OUT && defined(_RP99R)) ? &_RP99R : \
    ((pin) == RP100_OUT && defined(_RP100R)) ? &_RP100R : \
    ((pin) == RP101_OUT && defined(_RP101R)) ? &_RP101R : \
    ((pin) == RP102_OUT && defined(_RP102R)) ? &_RP102R : \
    ((pin) == RP104_OUT && defined(_RP104R)) ? &_RP104R : \
    ((pin) == RP108_OUT && defined(_RP108R)) ? &_RP108R : \
    ((pin) == RP109_OUT && defined(_RP109R)) ? &_RP109R : \
    ((pin) == RP112_OUT && defined(_RP112R)) ? &_RP112R : \
    ((pin) == RP113_OUT && defined(_RP113R)) ? &_RP113R : \
    ((pin) == RP118_OUT && defined(_RP118R)) ? &_RP118R : \
    ((pin) == RP120_OUT && defined(_RP120R)) ? &_RP120R : \
    ((pin) == RP125_OUT && defined(_RP125R)) ? &_RP125R : \
    ((pin) == RP126_OUT && defined(_RP126R)) ? &_RP126R : \
    ((pin) == RP127_OUT && defined(_RP127R)) ? &_RP127R : \
    (volatile uint16_t*)0)

// Check if PPS output pin is available on this processor
#define PPS_IS_OUTPUT_AVAILABLE(pin) (PPS_GET_OUTPUT_REG(pin) != (volatile uint16_t*)0)

#endif	/* PPS_H */