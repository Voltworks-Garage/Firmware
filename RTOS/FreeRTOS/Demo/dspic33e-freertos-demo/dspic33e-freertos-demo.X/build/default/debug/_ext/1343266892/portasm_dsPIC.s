# 1 "../../../Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "../../../Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S"
# 105 "../../../Source/portable/MPLAB/PIC24_dsPIC/portasm_dsPIC.S"
        .global _vPortYield
  .extern _vTaskSwitchContext
  .extern uxCriticalNesting

_vPortYield:

  PUSH SR
  PUSH W0
  MOV #32, W0
  MOV W0, SR
  PUSH W1
  PUSH.D W2
  PUSH.D W4
  PUSH.D W6
  PUSH.D W8
  PUSH.D W10
  PUSH.D W12
  PUSH W14
  PUSH RCOUNT
  PUSH TBLPAG
  PUSH ACCAL
  PUSH ACCAH
  PUSH ACCAU
  PUSH ACCBL
  PUSH ACCBH
  PUSH ACCBU
  PUSH DCOUNT
  PUSH DOSTARTL
  PUSH DOSTARTH
  PUSH DOENDL
  PUSH DOENDH


  PUSH CORCON
  PUSH DSRPAG
  PUSH DSWPAG
  MOV _uxCriticalNesting, W0
  PUSH W0
  MOV _pxCurrentTCB, W0
  MOV W15, [W0]

  call _vTaskSwitchContext

  MOV _pxCurrentTCB, W0
  MOV [W0], W15
  POP W0
  MOV W0, _uxCriticalNesting
  POP DSWPAG
  POP DSRPAG
  POP CORCON
  POP DOENDH
  POP DOENDL
  POP DOSTARTH
  POP DOSTARTL
  POP DCOUNT
  POP ACCBU
  POP ACCBH
  POP ACCBL
  POP ACCAU
  POP ACCAH
  POP ACCAL
  POP TBLPAG
  POP RCOUNT
  POP W14
  POP.D W12
  POP.D W10
  POP.D W8
  POP.D W6
  POP.D W4
  POP.D W2
  POP.D W0
  POP SR

        return

        .end
