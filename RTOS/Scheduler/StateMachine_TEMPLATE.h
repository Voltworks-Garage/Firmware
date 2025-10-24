/******************************************************************************
 * File:   StateMachine_TEMPLATE.h
 * Author: [Your Name]
 *
 * Description: Template header file for state machine implementation
 *
 * Created on [Date]
 *******************************************************************************/

#ifndef STATEMACHINE_TEMPLATE_H
#define STATEMACHINE_TEMPLATE_H

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
void Template_Init(void);

/**
 * @brief Run the state machine (call periodically)
 */
void Template_Run_10ms(void);

/**
 * @brief Halt the state machine and clean up
 */
void Template_Halt(void);

#endif /* STATEMACHINE_TEMPLATE_H */

/*** End of File **************************************************************/
