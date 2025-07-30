/******************************************************************************
 * NTC Thermistor Library Implementation
 * 
 * Description: Simple lookup table based NTC temperature conversion
 *              for NTC_TYPE_B57355V5104F360
 * 
 * Author: Generated with Claude Code
 * Date: 2025-07-29
 *******************************************************************************/

#include "NTC.h"

/******************************************************************************
 * Private Constants
 *******************************************************************************/

// Lookup table for B57355V5104F360 NTC (100kΩ, B25/85=4260K)
// Temperature range: -55°C to +125°C in 5°C steps
// Temperature stored as °C * 10 (e.g., 25.5°C = 255)
// Resistance stored as ohms (integer values)
typedef struct {
    int16_t temperature_x10;  // Temperature in °C * 10
    uint32_t resistance;      // Resistance in ohms
} NTC_LUT_Entry_S;

static const NTC_LUT_Entry_S NTC_B57355V5104F360_LUT[] = {
    { -500, 12177657 },
    { -450, 8014331 },
    { -400, 5369871 },
    { -350, 3659003 },
    { -300, 2532873 },
    { -250, 1779515 },
    { -200, 1267787 },
    { -150, 915155 },
    { -100, 668841 },
    {  -50, 494571 },
    {    0, 369772 },
    {   50, 279370 },
    {  100, 213170 },
    {  150, 164190 },
    {  200, 127596 },
    {  250, 100000 },
    {  300, 79005 },
    {  350, 62897 },
    {  400, 50439 },
    {  450, 40730 },
    {  500, 33109 },
    {  550, 27084 },
    {  600, 22289 },
    {  650, 18449 },
    {  700, 15355 },
    {  750, 12848 },
    {  800, 10804 },
    {  850, 9130 },
    {  900, 7750 },
    {  950, 6609 },
    { 1000, 5660 },
    { 1050, 4867 },
    { 1100, 4201 },
    { 1150, 3641 },
    { 1200, 3166 },
    { 1250, 2764 },
};

#define NTC_B57355V5104F360_LUT_SIZE (sizeof(NTC_B57355V5104F360_LUT) / sizeof(NTC_B57355V5104F360_LUT[0]))

static const NTC_LUT_Entry_S * NTC_LUT_list[] = {
    NTC_B57355V5104F360_LUT
};

static const uint16_t NTC_LUT_sizes[] = {
    NTC_B57355V5104F360_LUT_SIZE
};

/******************************************************************************
 * Public Function Implementation
 *******************************************************************************/

float NTC_ResistanceToTemperature(uint32_t resistance_ohms, NTC_Type_E ntc_type) {
    // Validate NTC type
    if (ntc_type >= (sizeof(NTC_LUT_list) / sizeof(NTC_LUT_list[0]))) {
        return -999.0f;  // Invalid NTC type (error value)
    }
    
    uint16_t table_size = NTC_LUT_sizes[ntc_type];
    
    // Handle out of range cases
    if (resistance_ohms >= NTC_LUT_list[ntc_type][0].resistance) {
        return NTC_LUT_list[ntc_type][0].temperature_x10 / 10.0f;  // Below minimum temperature
    }
    if (resistance_ohms <= NTC_LUT_list[ntc_type][table_size - 1].resistance) {
        return NTC_LUT_list[ntc_type][table_size - 1].temperature_x10 / 10.0f;  // Above maximum temperature
    }
    
    // Binary search for the correct range
    uint16_t low_idx = 0;
    uint16_t high_idx = table_size - 1;
    
    while (high_idx - low_idx > 1) {
        uint16_t mid_idx = (low_idx + high_idx) / 2;
        if (resistance_ohms >= NTC_LUT_list[ntc_type][mid_idx].resistance) {
            high_idx = mid_idx;
        } else {
            low_idx = mid_idx;
        }
    }
    
    // Linear interpolation between table[high_idx] and table[low_idx]
    uint32_t r1 = NTC_LUT_list[ntc_type][high_idx].resistance;
    int16_t t1 = NTC_LUT_list[ntc_type][high_idx].temperature_x10;
    uint32_t r2 = NTC_LUT_list[ntc_type][low_idx].resistance;
    int16_t t2 = NTC_LUT_list[ntc_type][low_idx].temperature_x10;
    
    // Integer linear interpolation
    if (r2 != r1) {
        // Calculate: t1 + (t2 - t1) * (resistance_ohms - r1) / (r2 - r1)
        int32_t temp_diff = (int32_t)(t2 - t1);
        int32_t res_diff = (int32_t)(r2 - r1);
        int32_t res_offset = (int32_t)(resistance_ohms - r1);
        
        int32_t interpolated_x10 = (int32_t)t1 + (temp_diff * res_offset) / res_diff;
        
        return interpolated_x10 / 10.0f;  // Convert to degrees Celsius
    } else {
        return t1 / 10.0f;  // Convert to degrees Celsius
    }
}