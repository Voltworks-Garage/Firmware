/******************************************************************************
 * File:   ThermalControl.h
 * Author: [Your Name]
 *
 * Description: Thermal control state machine implementation
 *
 * Created on [Date]
 *******************************************************************************/

#ifndef THERMALCONTROL_H
#define THERMALCONTROL_H

/******************************************************************************
 * Includes
 *******************************************************************************/
#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
 * Public Function Prototypes
 *******************************************************************************/

/**
 * @brief Initialize the state machine
 */
void ThermalControl_Init(void);

/**
 * @brief Run the state machine (call periodically)
 */
void ThermalControl_Run_10ms(void);

/**
 * @brief Halt the state machine and clean up
 */
void ThermalControl_Halt(void);

#endif /* THERMALCONTROL_H */

/*** End of File **************************************************************/
