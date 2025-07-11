/*
    (c) 2020 Microchip Technology Inc. and its subsidiaries. You may use this
    software and any derivatives exclusively with Microchip products.

    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
    WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
    PARTICULAR PURPOSE, OR ITS INTERACTION WITH MICROCHIP PRODUCTS, COMBINATION
    WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION.

    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
    BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
    FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
    ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
    THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.

    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE
    TERMS.
*/

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>
    
#include "can_tp_config.h"
#include "mcc_generated_files/can1.h"
#include "can_tp_phy_adaptor.h"

#define ECAN
#ifdef ECAN
#include "xc.h"
#endif
#ifdef ECAN
static unsigned char rxBuffer[8];
#endif
static CAN_MSG_OBJ rxCanMsg;
static CAN_MSG_OBJ txCanMsg;
        
static uint8_t DlcToDataBytesGet(const CAN_DLC dlc)
{
    static const uint8_t dlcByteSize[] = {0U, 1U, 2U, 3U, 4U, 5U, 6U, 7U, 8U, 12U, 16U, 20U, 24U, 32U, 48U, 64U};
    return dlcByteSize[dlc];
}

#ifdef ECAN
typedef struct __attribute__((packed))
{
    unsigned priority                   :2;
    unsigned remote_transmit_enable     :1;
    unsigned send_request               :1;
    unsigned error                      :1;
    unsigned lost_arbitration           :1;
    unsigned message_aborted            :1;
    unsigned transmit_enabled           :1;
} CAN1_TX_CONTROLS;

#endif

static CAN_DLC BytesToDLCGet(uint8_t length)
{
#ifndef ECAN
    if(length <= 8)
    {
        return length;
    }
    else if(length <= 12)
    {
        return DLC_12;
    }
    else if(length <= 16)
    {
        return DLC_16;
    }
    else if(length <= 20)
    {
        return DLC_20;
    }
    else if(length <= 24)
    {
        return DLC_24;
    }
    else if(length <= 32)
    {
        return DLC_32;
    }
    else if(length <= 48)
    {
        return DLC_48;
    }
    
    return DLC_64; 
#else
    return length;
#endif    
}
    
uint8_t CAN_PHY_ReceivedMessageCountGet(void)
{
    return CAN1_ReceivedMessageCountGet();
}

bool CAN_PHY_Receive(uint8_t *data, uint8_t *length)
{
    if(CAN1_ReceivedMessageCountGet() == 0)
    {
        return false;
    }
#ifdef ECAN    
    //ECAN does not have a local buffer in the driver so we need to use one from here.
    rxCanMsg.data = &rxBuffer[0];
#endif
    CAN1_Receive(&rxCanMsg);

    *length = DlcToDataBytesGet(rxCanMsg.field.dlc);
    memcpy(data, rxCanMsg.data, *length);
    
    return true;
}

bool CAN_PHY_Transmit(uint32_t messageId, bool isEid, uint8_t *data, uint8_t length)
{   

    txCanMsg.msgId = messageId;
    txCanMsg.data = data;     // Pointer to the buffer to send
#ifndef ECAN
    txCanMsg.field.brs = 0;
    txCanMsg.field.formatType = CAN_2_0_FORMAT;  // 1 bit (CAN 2.0 Format or CAN_FD Format)
#else
    CAN_TX_PRIOIRTY priority =  CAN_PRIORITY_HIGH;    
#endif    
    txCanMsg.field.dlc = BytesToDLCGet(length);                  // amount of data to send.  
 
    txCanMsg.field.frameType  = CAN_FRAME_DATA;  // 1 bit (Data Frame or RTR Frame)
    if(isEid == true)
    {
        txCanMsg.field.idType     = CAN_FRAME_EXT;   // 1 bit (Standard Frame or Extended Frame)
    }
    else
    {
        txCanMsg.field.idType     = CAN_FRAME_STD;   // 1 bit (Standard Frame or Extended Frame)
    }
    
    //return (CAN1_Transmit(CAN1_FIFO_1, &txCanMsg) == CAN_TX_MSG_REQUEST_SUCCESS);
    return (CAN1_Transmit(priority, &txCanMsg) == CAN_TX_MSG_REQUEST_SUCCESS);
}

#ifdef ECAN
enum CAN_PHY_TRANSMIT_STATUS CAN_PHY_TransmitStatusGet(void)
{
    #define CAN1_TX_BUFFER_COUNT 1
    uint_fast8_t i;
    CAN1_TX_CONTROLS * pTxControls = (CAN1_TX_CONTROLS*)&C1TR01CON;
    
    enum CAN_PHY_TRANSMIT_STATUS status = CAN_PHY_TRANSMIT_STATUS_ERROR;

    if(CAN1_TX_BUFFER_COUNT > 0)
    {
        for(i=0; i<CAN1_TX_BUFFER_COUNT; i++)
        {
            if(pTxControls->transmit_enabled == 1)
            {
                if (pTxControls->send_request == 0)
                {
                    status = CAN_PHY_TRANSMIT_STATUS_SUCCESS;
                    break;
                } else
                if (pTxControls->send_request == 1)
                {
                    status = CAN_PHY_TRANSMIT_STATUS_PENDING;
                    break;
                }    
                
            }    
        }
    }    
/*                
    switch(CAN1_TransmitFIFOStatusGet(CAN1_FIFO_1))
    {
        case CAN_TX_FIFO_AVAILABLE:
            status = CAN_PHY_TRANSMIT_STATUS_SUCCESS;
            break;
            
        case CAN_TX_FIFO_FULL:
            status = CAN_PHY_TRANSMIT_STATUS_PENDING;
            break;
            
        default:
            break;
    }
  */  
    return status;
}
#else

enum CAN_PHY_TRANSMIT_STATUS CAN_PHY_TransmitStatusGet(void)
{
    enum CAN_PHY_TRANSMIT_STATUS status = CAN_PHY_TRANSMIT_STATUS_ERROR;

    switch(CAN1_TransmitFIFOStatusGet(CAN1_FIFO_1))
    {
        case CAN_TX_FIFO_AVAILABLE:
            status = CAN_PHY_TRANSMIT_STATUS_SUCCESS;
            break;
            
        case CAN_TX_FIFO_FULL:
            status = CAN_PHY_TRANSMIT_STATUS_PENDING;
            break;
            
        default:
            break;
    }
    
    return status;
} 
#endif

