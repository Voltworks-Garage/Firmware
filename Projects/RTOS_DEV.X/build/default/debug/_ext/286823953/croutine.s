	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\..\\..\\RTOS\\FreeRTOS\\Source\\croutine.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vCoRoutineAddToDelayedList,code
	.align	2
	.global	_vCoRoutineAddToDelayedList	; export
	.type	_vCoRoutineAddToDelayedList,@function
_vCoRoutineAddToDelayedList:
.LFB1:
	.file 1 "../../RTOS/FreeRTOS/Source/croutine.c"
	.loc 1 165 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI0:
	mov	w1,w8
	.loc 1 170 0
	mov	_xCoRoutineTickCount,w9
	add	w0,w9,w9
	.loc 1 175 0
	inc2	_pxCurrentCoRoutine,WREG
	rcall	_uxListRemove
	.loc 1 178 0
	mov	_pxCurrentCoRoutine,w1
	mov	w9,[w1+2]
	.loc 1 180 0
	mov	_xCoRoutineTickCount,w0
	sub	w0,w9,[w15]
	.set ___BP___,50
	bra	leu,.L2
	.loc 1 184 0
	inc2	w1,w1
	mov	_pxOverflowDelayedCoRoutineList,w0
	rcall	_vListInsert
	bra	.L3
.L2:
	.loc 1 190 0
	inc2	w1,w1
	mov	_pxDelayedCoRoutineList,w0
	rcall	_vListInsert
.L3:
	.loc 1 193 0
	cp0	w8
	.set ___BP___,21
	bra	z,.L1
	.loc 1 197 0
	mov	_pxCurrentCoRoutine,w1
	add	w1,#12,w1
	mov	w8,w0
	rcall	_vListInsert
.L1:
	.loc 1 199 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE1:
	.size	_vCoRoutineAddToDelayedList, .-_vCoRoutineAddToDelayedList
	.section	.text.prvCheckPendingReadyList,code
	.align	2
	.global	_prvCheckPendingReadyList	; export
	.type	_prvCheckPendingReadyList,@function
_prvCheckPendingReadyList:
.LFB2:
	.loc 1 203 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI1:
	mov.d	w10,[w15++]
.LCFI2:
	.loc 1 207 0
	mov	_xPendingReadyCoRoutineList,w0
	cp0	w0
	.set ___BP___,9
	bra	z,.L5
.LBB2:
	.loc 1 220 0
	mov	#_pxReadyCoRoutineLists,w10
.LBE2:
	.loc 1 207 0
	mov	#_xPendingReadyCoRoutineList,w11
.L9:
.LBB3:
	.loc 1 212 0
	mov	#-225,w9
	mov	_SRbits,w1
	and	w9,w1,w0
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 212 "../../RTOS/FreeRTOS/Source/croutine.c" 1
	NOP
	.loc 1 214 0
	mov	_xPendingReadyCoRoutineList+6,w0
	mov	[w0+6],w8
	.loc 1 215 0
	add	w8,#12,w0
	rcall	_uxListRemove
	.loc 1 217 0
	mov	#_SRbits,w0
	and	w9,[w0],[w0]
	nop	
	.loc 1 219 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 220 0
	mov	[w8+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L7
	mov	w0,_uxTopCoRoutineReadyPriority
.L7:
	mulw.su	w0,#10,w0
	add	w0,w10,w0
	mov	w9,w1
	rcall	_vListInsertEnd
.LBE3:
	.loc 1 207 0
	cp0	[w11]
	.set ___BP___,91
	bra	nz,.L9
.L5:
	.loc 1 222 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE2:
	.size	_prvCheckPendingReadyList, .-_prvCheckPendingReadyList
	.section	.text.prvCheckDelayedList,code
	.align	2
	.global	_prvCheckDelayedList	; export
	.type	_prvCheckDelayedList,@function
_prvCheckDelayedList:
.LFB3:
	.loc 1 226 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI3:
	mov.d	w10,[w15++]
.LCFI4:
	.loc 1 229 0
	rcall	_xTaskGetTickCount
	mov	_xLastTickCount,w1
	sub	w0,w1,w0
	mov	w0,_xPassedTicks
	.loc 1 259 0
	mov	#-225,w10
	.loc 1 276 0
	mov	#_pxReadyCoRoutineLists,w11
	.loc 1 231 0
	bra	.L22
.L19:
	.loc 1 233 0
	inc	_xCoRoutineTickCount,WREG
	mov	w0,_xCoRoutineTickCount
	.loc 1 234 0
	dec	w1,w1
	mov	w1,_xPassedTicks
	.loc 1 237 0
	cp0	w0
	.set ___BP___,50
	bra	nz,.L13
.LBB4:
	.loc 1 243 0
	mov	_pxDelayedCoRoutineList,w1
	.loc 1 244 0
	mov	_pxOverflowDelayedCoRoutineList,w2
	mov	w2,_pxDelayedCoRoutineList
	.loc 1 245 0
	mov	w1,_pxOverflowDelayedCoRoutineList
.L13:
.LBE4:
	.loc 1 249 0
	mov	_pxDelayedCoRoutineList,w1
	cp0	[w1]
	.set ___BP___,4
	bra	z,.L22
	.loc 1 251 0
	mov	[w1+6],w1
	mov	[w1+6],w8
	.loc 1 253 0
	mov	[w8+2],w1
	sub	w0,w1,[w15]
	.set ___BP___,95
	bra	geu,.L24
	bra	.L22
.L18:
	.loc 1 251 0
	mov	[w0+6],w0
	mov	[w0+6],w8
	.loc 1 253 0
	mov	[w8+2],w0
	cp	_xCoRoutineTickCount
	.set ___BP___,4
	bra	ltu,.L22
.L24:
	.loc 1 259 0
	mov	_SRbits,w1
	and	w10,w1,w0
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 259 "../../RTOS/FreeRTOS/Source/croutine.c" 1
	NOP
	.loc 1 266 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 269 0
	mov	[w8+20],w0
	cp0	w0
	.set ___BP___,30
	bra	z,.L16
	.loc 1 271 0
	add	w8,#12,w0
	rcall	_uxListRemove
.L16:
	.loc 1 274 0
	mov	#_SRbits,w2
	and	w10,[w2],[w2]
	nop	
	.loc 1 276 0
	mov	[w8+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L17
	mov	w0,_uxTopCoRoutineReadyPriority
.L17:
	mulw.su	w0,#10,w0
	add	w0,w11,w0
	mov	w9,w1
	rcall	_vListInsertEnd
	.loc 1 249 0
	mov	_pxDelayedCoRoutineList,w0
	cp0	[w0]
	.set ___BP___,95
	bra	nz,.L18
.L22:
	.loc 1 231 0
	mov	_xPassedTicks,w1
	cp0	w1
	.set ___BP___,91
	bra	nz,.L19
	.loc 1 280 0
	mov	_xCoRoutineTickCount,w0
	mov	w0,_xLastTickCount
	.loc 1 281 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE3:
	.size	_prvCheckDelayedList, .-_prvCheckDelayedList
	.section	.text.vCoRoutineSchedule,code
	.align	2
	.global	_vCoRoutineSchedule	; export
	.type	_vCoRoutineSchedule,@function
_vCoRoutineSchedule:
.LFB4:
	.loc 1 285 0
	.set ___PA___,1
	.loc 1 289 0
	cp0	_pxDelayedCoRoutineList
	.set ___BP___,21
	bra	z,.L25
	.loc 1 292 0
	rcall	_prvCheckPendingReadyList
	.loc 1 295 0
	rcall	_prvCheckDelayedList
	.loc 1 298 0
	mov	_uxTopCoRoutineReadyPriority,w0
	mulw.su	w0,#10,w2
	mov	#_pxReadyCoRoutineLists,w1
	add	w1,w2,w1
	cp0	[w1]
	.set ___BP___,4
	bra	nz,.L27
	mov	#_pxReadyCoRoutineLists,w3
	.loc 1 300 0
	cp0	w0
	.set ___BP___,95
	bra	nz,.L31
	bra	.L25
.L29:
	cp0	w0
	.set ___BP___,95
	bra	nz,.L31
	mov	w0,_uxTopCoRoutineReadyPriority
	bra	.L25
.L31:
	.loc 1 306 0
	dec	w0,w0
	.loc 1 298 0
	mulw.su	w0,#10,w2
	add	w3,w2,w1
	cp0	[w1]
	.set ___BP___,95
	bra	z,.L29
	mov	w0,_uxTopCoRoutineReadyPriority
.L27:
.LBB5:
	.loc 1 311 0
	mulw.su	w0,#10,w2
	mov	#_pxReadyCoRoutineLists,w1
	add	w1,w2,w3
	mov	[w3+2],w3
	mov	[w3+2],w3
	add	w1,w2,w4
	mov	w3,[w4+2]
	add	w2,#4,w2
	add	w2,w1,w1
	sub	w3,w1,[w15]
	.set ___BP___,85
	bra	nz,.L30
	mulw.su	w0,#10,w2
	mov	#_pxReadyCoRoutineLists+2,w1
	add	w2,w1,w1
	mov	[w3+2],w3
	mov	w3,[w1]
.L30:
	mulw.su	w0,#10,w0
	mov	#_pxReadyCoRoutineLists+2,w1
	add	w0,w1,w0
	mov	[w0],w0
	mov	[w0+6],w0
	mov	w0,_pxCurrentCoRoutine
.LBE5:
	.loc 1 314 0
	mov	[w0+24],w1
	mov	[w0],w2
	call	w2
.L25:
	.loc 1 316 0
	return	
	.set ___PA___,0
.LFE4:
	.size	_vCoRoutineSchedule, .-_vCoRoutineSchedule
	.section	.text.prvInitialiseCoRoutineLists,code
	.align	2
	.global	_prvInitialiseCoRoutineLists	; export
	.type	_prvInitialiseCoRoutineLists,@function
_prvInitialiseCoRoutineLists:
.LFB5:
	.loc 1 320 0
	.set ___PA___,1
	.loc 1 325 0
	mov	#_pxReadyCoRoutineLists,w0
	rcall	_vListInitialise
	mov	#_pxReadyCoRoutineLists+10,w0
	rcall	_vListInitialise
	.loc 1 328 0
	mov	#_xDelayedCoRoutineList1,w0
	rcall	_vListInitialise
	.loc 1 329 0
	mov	#_xDelayedCoRoutineList2,w0
	rcall	_vListInitialise
	.loc 1 330 0
	mov	#_xPendingReadyCoRoutineList,w0
	rcall	_vListInitialise
	.loc 1 334 0
	mov	#_xDelayedCoRoutineList1,w0
	mov	w0,_pxDelayedCoRoutineList
	.loc 1 335 0
	mov	#_xDelayedCoRoutineList2,w0
	mov	w0,_pxOverflowDelayedCoRoutineList
	.loc 1 336 0
	return	
	.set ___PA___,0
.LFE5:
	.size	_prvInitialiseCoRoutineLists, .-_prvInitialiseCoRoutineLists
	.section	.text.xCoRoutineCreate,code
	.align	2
	.global	_xCoRoutineCreate	; export
	.type	_xCoRoutineCreate,@function
_xCoRoutineCreate:
.LFB0:
	.loc 1 106 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI5:
	mov.d	w10,[w15++]
.LCFI6:
	mov	w0,w11
	mov	w1,w10
	mov	w2,w9
	.loc 1 111 0
	mov	#28,w0
	rcall	_pvPortMalloc
	mov	w0,w8
	.loc 1 156 0
	setm	w0
	.loc 1 113 0
	cp0	w8
	.set ___BP___,10
	bra	z,.L36
	.loc 1 117 0
	cp0	_pxCurrentCoRoutine
	.set ___BP___,93
	bra	nz,.L37
	.loc 1 119 0
	mov	w8,_pxCurrentCoRoutine
	.loc 1 120 0
	rcall	_prvInitialiseCoRoutineLists
.L37:
	cp0	w10
	.set ___BP___,50
	bra	z,.L38
	mov	#1,w10
.L38:
	.loc 1 130 0
	clr	w0
	mov	w0,[w8+26]
	.loc 1 131 0
	mov	w10,[w8+22]
	.loc 1 132 0
	mov	w9,[w8+24]
	.loc 1 133 0
	mov	w8,w9
	mov	w11,[w9++]
	.loc 1 136 0
	mov	w9,w0
	rcall	_vListInitialiseItem
	.loc 1 137 0
	add	w8,#12,w0
	rcall	_vListInitialiseItem
	.loc 1 142 0
	mov	w8,[w8+8]
	.loc 1 143 0
	mov	w8,[w8+18]
	.loc 1 146 0
	subr	w10,#2,w10
	mov	w10,[w8+12]
	.loc 1 150 0
	mov	[w8+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L39
	mov	w0,_uxTopCoRoutineReadyPriority
.L39:
	mulw.su	w0,#10,w0
	mov	#_pxReadyCoRoutineLists,w1
	add	w0,w1,w0
	mov	w9,w1
	rcall	_vListInsertEnd
	.loc 1 152 0
	mov	#1,w0
.L36:
	.loc 1 160 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE0:
	.size	_xCoRoutineCreate, .-_xCoRoutineCreate
	.section	.text.xCoRoutineRemoveFromEventList,code
	.align	2
	.global	_xCoRoutineRemoveFromEventList	; export
	.type	_xCoRoutineRemoveFromEventList,@function
_xCoRoutineRemoveFromEventList:
.LFB6:
	.loc 1 340 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI7:
	.loc 1 347 0
	mov	[w0+6],w0
	mov	[w0+6],w9
	.loc 1 348 0
	add	w9,#12,w8
	mov	w8,w0
	rcall	_uxListRemove
	.loc 1 349 0
	mov	w8,w1
	mov	#_xPendingReadyCoRoutineList,w0
	rcall	_vListInsertEnd
	.loc 1 353 0
	mov	#1,w0
	mov	[w9+22],w2
	mov	_pxCurrentCoRoutine,w1
	mov	[w1+22],w1
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	geu,.L42
	clr	w0
.L42:
	.loc 1 361 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE6:
	.size	_xCoRoutineRemoveFromEventList, .-_xCoRoutineRemoveFromEventList
	.global	_pxDelayedCoRoutineList	; export
	.section	.nbss,bss,near
	.align	2
	.type	_pxDelayedCoRoutineList,@object
	.size	_pxDelayedCoRoutineList, 2
_pxDelayedCoRoutineList:
	.skip	2
	.global	_pxOverflowDelayedCoRoutineList	; export
	.align	2
	.type	_pxOverflowDelayedCoRoutineList,@object
	.size	_pxOverflowDelayedCoRoutineList, 2
_pxOverflowDelayedCoRoutineList:
	.skip	2
	.global	_pxCurrentCoRoutine	; export
	.align	2
	.type	_pxCurrentCoRoutine,@object
	.size	_pxCurrentCoRoutine, 2
_pxCurrentCoRoutine:
	.skip	2
	.global	_uxTopCoRoutineReadyPriority	; export
	.align	2
	.type	_uxTopCoRoutineReadyPriority,@object
	.size	_uxTopCoRoutineReadyPriority, 2
_uxTopCoRoutineReadyPriority:
	.skip	2
	.global	_xCoRoutineTickCount	; export
	.align	2
	.type	_xCoRoutineTickCount,@object
	.size	_xCoRoutineTickCount, 2
_xCoRoutineTickCount:
	.skip	2
	.global	_xLastTickCount	; export
	.align	2
	.type	_xLastTickCount,@object
	.size	_xLastTickCount, 2
_xLastTickCount:
	.skip	2
	.global	_xPassedTicks	; export
	.align	2
	.type	_xPassedTicks,@object
	.size	_xPassedTicks, 2
_xPassedTicks:
	.skip	2
	.section	.bss,bss
	.type	_pxReadyCoRoutineLists,@object
	.size	_pxReadyCoRoutineLists, 20
	.global	_pxReadyCoRoutineLists
	.align	2
_pxReadyCoRoutineLists:	.space	20
	.type	_xDelayedCoRoutineList1,@object
	.size	_xDelayedCoRoutineList1, 10
	.global	_xDelayedCoRoutineList1
	.align	2
_xDelayedCoRoutineList1:	.space	10
	.type	_xDelayedCoRoutineList2,@object
	.size	_xDelayedCoRoutineList2, 10
	.global	_xDelayedCoRoutineList2
	.align	2
_xDelayedCoRoutineList2:	.space	10
	.type	_xPendingReadyCoRoutineList,@object
	.size	_xPendingReadyCoRoutineList, 10
	.global	_xPendingReadyCoRoutineList
	.align	2
_xPendingReadyCoRoutineList:	.space	10
	.section	.debug_frame,info
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.byte	0
	.uleb128 0x1
	.sleb128 2
	.byte	0x25
	.byte	0x12
	.uleb128 0xf
	.sleb128 -2
	.byte	0x9
	.uleb128 0x25
	.uleb128 0xf
	.align	4
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI0-.LFB1
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI1-.LFB2
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI3-.LFB3
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.align	4
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI5-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI7-.LFB6
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE12:
	.section	.text,code
.Letext0:
	.file 2 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.file 3 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 4 "../../RTOS/FreeRTOS/Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 5 "../../RTOS/FreeRTOS/Source/include/list.h"
	.file 6 "../../RTOS/FreeRTOS/Source/include/croutine.h"
	.section	.debug_info,info
	.4byte	0x973
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../RTOS/FreeRTOS/Source/croutine.c"
	.asciz	"C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X"
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.asciz	"long double"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"short unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.asciz	"unsigned int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"int"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.asciz	"long int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.asciz	"long long int"
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x3
	.byte	0xc1
	.4byte	0xdb
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.asciz	"long unsigned int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.asciz	"long long unsigned int"
	.uleb128 0x4
	.byte	0x2
	.byte	0x2
	.byte	0x88
	.4byte	0x257
	.uleb128 0x5
	.asciz	"C"
	.byte	0x2
	.byte	0x89
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0xf
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"Z"
	.byte	0x2
	.byte	0x8a
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0xe
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OV"
	.byte	0x2
	.byte	0x8b
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0xd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"N"
	.byte	0x2
	.byte	0x8c
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"RA"
	.byte	0x2
	.byte	0x8d
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"IPL"
	.byte	0x2
	.byte	0x8e
	.4byte	0x12f
	.byte	0x2
	.byte	0x3
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DC"
	.byte	0x2
	.byte	0x8f
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DA"
	.byte	0x2
	.byte	0x90
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SAB"
	.byte	0x2
	.byte	0x91
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OAB"
	.byte	0x2
	.byte	0x92
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SB"
	.byte	0x2
	.byte	0x93
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SA"
	.byte	0x2
	.byte	0x94
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x2
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OB"
	.byte	0x2
	.byte	0x95
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OA"
	.byte	0x2
	.byte	0x96
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x0
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x4
	.byte	0x2
	.byte	0x2
	.byte	0x98
	.4byte	0x296
	.uleb128 0x5
	.asciz	"IPL0"
	.byte	0x2
	.byte	0x9a
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"IPL1"
	.byte	0x2
	.byte	0x9b
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"IPL2"
	.byte	0x2
	.byte	0x9c
	.4byte	0x12f
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.byte	0x2
	.byte	0x2
	.byte	0x87
	.4byte	0x2a9
	.uleb128 0x7
	.4byte	0x16e
	.uleb128 0x7
	.4byte	0x257
	.byte	0x0
	.uleb128 0x8
	.asciz	"tagSRBITS"
	.byte	0x2
	.byte	0x2
	.byte	0x86
	.4byte	0x2c4
	.uleb128 0x9
	.4byte	0x296
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x3
	.asciz	"SRBITS"
	.byte	0x2
	.byte	0x9f
	.4byte	0x2a9
	.uleb128 0xa
	.byte	0x2
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x4
	.byte	0x61
	.4byte	0x2e6
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x4
	.byte	0x62
	.4byte	0xc5
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x4
	.byte	0x65
	.4byte	0x12f
	.uleb128 0x8
	.asciz	"xLIST_ITEM"
	.byte	0xa
	.byte	0x5
	.byte	0x90
	.4byte	0x381
	.uleb128 0xb
	.4byte	.LASF0
	.byte	0x5
	.byte	0x93
	.4byte	0x306
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"pxNext"
	.byte	0x5
	.byte	0x94
	.4byte	0x381
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xb
	.4byte	.LASF1
	.byte	0x5
	.byte	0x95
	.4byte	0x381
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xc
	.asciz	"pvOwner"
	.byte	0x5
	.byte	0x96
	.4byte	0x2d2
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0xc
	.asciz	"pvContainer"
	.byte	0x5
	.byte	0x97
	.4byte	0x3d5
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x318
	.uleb128 0x8
	.asciz	"xLIST"
	.byte	0xa
	.byte	0x5
	.byte	0xac
	.4byte	0x3d5
	.uleb128 0xc
	.asciz	"uxNumberOfItems"
	.byte	0x5
	.byte	0xaf
	.4byte	0x449
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"pxIndex"
	.byte	0x5
	.byte	0xb0
	.4byte	0x44e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xc
	.asciz	"xListEnd"
	.byte	0x5
	.byte	0xb1
	.4byte	0x433
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x387
	.uleb128 0x3
	.asciz	"ListItem_t"
	.byte	0x5
	.byte	0x9a
	.4byte	0x318
	.uleb128 0x8
	.asciz	"xMINI_LIST_ITEM"
	.byte	0x6
	.byte	0x5
	.byte	0x9d
	.4byte	0x433
	.uleb128 0xb
	.4byte	.LASF0
	.byte	0x5
	.byte	0xa0
	.4byte	0x306
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"pxNext"
	.byte	0x5
	.byte	0xa1
	.4byte	0x381
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xb
	.4byte	.LASF1
	.byte	0x5
	.byte	0xa2
	.4byte	0x381
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x3
	.asciz	"MiniListItem_t"
	.byte	0x5
	.byte	0xa4
	.4byte	0x3ed
	.uleb128 0xe
	.4byte	0x2f3
	.uleb128 0xd
	.byte	0x2
	.4byte	0x3db
	.uleb128 0x3
	.asciz	"List_t"
	.byte	0x5
	.byte	0xb3
	.4byte	0x387
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"CoRoutineHandle_t"
	.byte	0x6
	.byte	0x2f
	.4byte	0x2d2
	.uleb128 0x3
	.asciz	"crCOROUTINE_CODE"
	.byte	0x6
	.byte	0x32
	.4byte	0x49b
	.uleb128 0xd
	.byte	0x2
	.4byte	0x4a1
	.uleb128 0xf
	.byte	0x1
	.4byte	0x4b2
	.uleb128 0x10
	.4byte	0x46a
	.uleb128 0x10
	.4byte	0x2f3
	.byte	0x0
	.uleb128 0x8
	.asciz	"corCoRoutineControlBlock"
	.byte	0x1c
	.byte	0x6
	.byte	0x35
	.4byte	0x558
	.uleb128 0xc
	.asciz	"pxCoRoutineFunction"
	.byte	0x6
	.byte	0x37
	.4byte	0x483
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"xGenericListItem"
	.byte	0x6
	.byte	0x38
	.4byte	0x3db
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xc
	.asciz	"xEventListItem"
	.byte	0x6
	.byte	0x39
	.4byte	0x3db
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0xb
	.4byte	.LASF2
	.byte	0x6
	.byte	0x3a
	.4byte	0x2f3
	.byte	0x2
	.byte	0x23
	.uleb128 0x16
	.uleb128 0xc
	.asciz	"uxIndex"
	.byte	0x6
	.byte	0x3b
	.4byte	0x2f3
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0xc
	.asciz	"uxState"
	.byte	0x6
	.byte	0x3c
	.4byte	0x12f
	.byte	0x2
	.byte	0x23
	.uleb128 0x1a
	.byte	0x0
	.uleb128 0x3
	.asciz	"CRCB_t"
	.byte	0x6
	.byte	0x3d
	.4byte	0x4b2
	.uleb128 0x11
	.byte	0x1
	.asciz	"vCoRoutineAddToDelayedList"
	.byte	0x1
	.byte	0xa3
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x5ce
	.uleb128 0x12
	.asciz	"xTicksToDelay"
	.byte	0x1
	.byte	0xa3
	.4byte	0x306
	.byte	0x1
	.byte	0x50
	.uleb128 0x13
	.4byte	.LASF3
	.byte	0x1
	.byte	0xa4
	.4byte	0x5ce
	.byte	0x1
	.byte	0x58
	.uleb128 0x14
	.asciz	"xTimeToWake"
	.byte	0x1
	.byte	0xa6
	.4byte	0x306
	.byte	0x1
	.byte	0x59
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x454
	.uleb128 0x11
	.byte	0x1
	.asciz	"prvCheckPendingReadyList"
	.byte	0x1
	.byte	0xca
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x618
	.uleb128 0x15
	.4byte	.LBB2
	.4byte	.LBE2
	.uleb128 0x16
	.4byte	.LASF4
	.byte	0x1
	.byte	0xd1
	.4byte	0x618
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x558
	.uleb128 0x11
	.byte	0x1
	.asciz	"prvCheckDelayedList"
	.byte	0x1
	.byte	0xe1
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x670
	.uleb128 0x14
	.asciz	"pxCRCB"
	.byte	0x1
	.byte	0xe3
	.4byte	0x618
	.byte	0x1
	.byte	0x58
	.uleb128 0x15
	.4byte	.LBB4
	.4byte	.LBE4
	.uleb128 0x14
	.asciz	"pxTemp"
	.byte	0x1
	.byte	0xef
	.4byte	0x5ce
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.byte	0x1
	.asciz	"vCoRoutineSchedule"
	.byte	0x1
	.2byte	0x11c
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x6b6
	.uleb128 0x15
	.4byte	.LBB5
	.4byte	.LBE5
	.uleb128 0x18
	.asciz	"pxConstList"
	.byte	0x1
	.2byte	0x137
	.4byte	0x6b6
	.byte	0x0
	.byte	0x0
	.uleb128 0x19
	.4byte	0x5ce
	.uleb128 0x17
	.byte	0x1
	.asciz	"prvInitialiseCoRoutineLists"
	.byte	0x1
	.2byte	0x13f
	.byte	0x1
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.4byte	0x6f8
	.uleb128 0x1a
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x141
	.4byte	0x2f3
	.byte	0x0
	.uleb128 0x1b
	.byte	0x1
	.asciz	"xCoRoutineCreate"
	.byte	0x1
	.byte	0x67
	.byte	0x1
	.4byte	0x2d4
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x77e
	.uleb128 0x12
	.asciz	"pxCoRoutineCode"
	.byte	0x1
	.byte	0x67
	.4byte	0x483
	.byte	0x1
	.byte	0x5b
	.uleb128 0x13
	.4byte	.LASF2
	.byte	0x1
	.byte	0x68
	.4byte	0x2f3
	.byte	0x1
	.byte	0x5a
	.uleb128 0x12
	.asciz	"uxIndex"
	.byte	0x1
	.byte	0x69
	.4byte	0x2f3
	.byte	0x1
	.byte	0x59
	.uleb128 0x14
	.asciz	"xReturn"
	.byte	0x1
	.byte	0x6b
	.4byte	0x2d4
	.byte	0x1
	.byte	0x50
	.uleb128 0x14
	.asciz	"pxCoRoutine"
	.byte	0x1
	.byte	0x6c
	.4byte	0x618
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x1c
	.byte	0x1
	.asciz	"xCoRoutineRemoveFromEventList"
	.byte	0x1
	.2byte	0x153
	.byte	0x1
	.4byte	0x2d4
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.4byte	0x7e1
	.uleb128 0x1d
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x153
	.4byte	0x7e1
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x155
	.4byte	0x618
	.byte	0x1
	.byte	0x59
	.uleb128 0x18
	.asciz	"xReturn"
	.byte	0x1
	.2byte	0x156
	.4byte	0x2d4
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x7e7
	.uleb128 0x19
	.4byte	0x454
	.uleb128 0x1f
	.asciz	"SRbits"
	.byte	0x2
	.byte	0xa0
	.4byte	0x7fc
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x2c4
	.uleb128 0x20
	.4byte	0x454
	.4byte	0x811
	.uleb128 0x21
	.4byte	0xdb
	.byte	0x1
	.byte	0x0
	.uleb128 0x22
	.4byte	.LASF5
	.byte	0x1
	.byte	0x2e
	.4byte	0x801
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF6
	.byte	0x1
	.byte	0x2f
	.4byte	0x454
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF7
	.byte	0x1
	.byte	0x30
	.4byte	0x454
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF8
	.byte	0x1
	.byte	0x31
	.4byte	0x5ce
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF9
	.byte	0x1
	.byte	0x32
	.4byte	0x5ce
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.byte	0x33
	.4byte	0x454
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF11
	.byte	0x1
	.byte	0x36
	.4byte	0x618
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF12
	.byte	0x1
	.byte	0x37
	.4byte	0x2f3
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF13
	.byte	0x1
	.byte	0x38
	.4byte	0x306
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF14
	.byte	0x1
	.byte	0x38
	.4byte	0x306
	.byte	0x1
	.byte	0x1
	.uleb128 0x22
	.4byte	.LASF15
	.byte	0x1
	.byte	0x38
	.4byte	0x306
	.byte	0x1
	.byte	0x1
	.uleb128 0x1f
	.asciz	"SRbits"
	.byte	0x2
	.byte	0xa0
	.4byte	0x7fc
	.byte	0x1
	.byte	0x1
	.uleb128 0x23
	.4byte	.LASF5
	.byte	0x1
	.byte	0x2e
	.4byte	0x801
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxReadyCoRoutineLists
	.uleb128 0x23
	.4byte	.LASF6
	.byte	0x1
	.byte	0x2f
	.4byte	0x454
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedCoRoutineList1
	.uleb128 0x23
	.4byte	.LASF7
	.byte	0x1
	.byte	0x30
	.4byte	0x454
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedCoRoutineList2
	.uleb128 0x23
	.4byte	.LASF8
	.byte	0x1
	.byte	0x31
	.4byte	0x5ce
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxDelayedCoRoutineList
	.uleb128 0x23
	.4byte	.LASF9
	.byte	0x1
	.byte	0x32
	.4byte	0x5ce
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxOverflowDelayedCoRoutineList
	.uleb128 0x23
	.4byte	.LASF10
	.byte	0x1
	.byte	0x33
	.4byte	0x454
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xPendingReadyCoRoutineList
	.uleb128 0x23
	.4byte	.LASF11
	.byte	0x1
	.byte	0x36
	.4byte	0x618
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxCurrentCoRoutine
	.uleb128 0x23
	.4byte	.LASF12
	.byte	0x1
	.byte	0x37
	.4byte	0x2f3
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxTopCoRoutineReadyPriority
	.uleb128 0x23
	.4byte	.LASF13
	.byte	0x1
	.byte	0x38
	.4byte	0x306
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xCoRoutineTickCount
	.uleb128 0x23
	.4byte	.LASF14
	.byte	0x1
	.byte	0x38
	.4byte	0x306
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xLastTickCount
	.uleb128 0x23
	.4byte	.LASF15
	.byte	0x1
	.byte	0x38
	.4byte	0x306
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xPassedTicks
	.byte	0x0
	.section	.debug_abbrev,info
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0xc
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x19
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1d
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x20
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x22
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x23
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x1f0
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x977
	.4byte	0x566
	.asciz	"vCoRoutineAddToDelayedList"
	.4byte	0x5d4
	.asciz	"prvCheckPendingReadyList"
	.4byte	0x61e
	.asciz	"prvCheckDelayedList"
	.4byte	0x670
	.asciz	"vCoRoutineSchedule"
	.4byte	0x6bb
	.asciz	"prvInitialiseCoRoutineLists"
	.4byte	0x6f8
	.asciz	"xCoRoutineCreate"
	.4byte	0x77e
	.asciz	"xCoRoutineRemoveFromEventList"
	.4byte	0x8b0
	.asciz	"pxReadyCoRoutineLists"
	.4byte	0x8c2
	.asciz	"xDelayedCoRoutineList1"
	.4byte	0x8d4
	.asciz	"xDelayedCoRoutineList2"
	.4byte	0x8e6
	.asciz	"pxDelayedCoRoutineList"
	.4byte	0x8f8
	.asciz	"pxOverflowDelayedCoRoutineList"
	.4byte	0x90a
	.asciz	"xPendingReadyCoRoutineList"
	.4byte	0x91c
	.asciz	"pxCurrentCoRoutine"
	.4byte	0x92e
	.asciz	"uxTopCoRoutineReadyPriority"
	.4byte	0x940
	.asciz	"xCoRoutineTickCount"
	.4byte	0x952
	.asciz	"xLastTickCount"
	.4byte	0x964
	.asciz	"xPassedTicks"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x10f
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x977
	.4byte	0x12f
	.asciz	"uint16_t"
	.4byte	0x2a9
	.asciz	"tagSRBITS"
	.4byte	0x2c4
	.asciz	"SRBITS"
	.4byte	0x2d4
	.asciz	"BaseType_t"
	.4byte	0x2f3
	.asciz	"UBaseType_t"
	.4byte	0x306
	.asciz	"TickType_t"
	.4byte	0x318
	.asciz	"xLIST_ITEM"
	.4byte	0x3db
	.asciz	"ListItem_t"
	.4byte	0x3ed
	.asciz	"xMINI_LIST_ITEM"
	.4byte	0x433
	.asciz	"MiniListItem_t"
	.4byte	0x387
	.asciz	"xLIST"
	.4byte	0x454
	.asciz	"List_t"
	.4byte	0x46a
	.asciz	"CoRoutineHandle_t"
	.4byte	0x483
	.asciz	"crCOROUTINE_CODE"
	.4byte	0x4b2
	.asciz	"corCoRoutineControlBlock"
	.4byte	0x558
	.asciz	"CRCB_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x4c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF14:
	.asciz	"xLastTickCount"
.LASF15:
	.asciz	"xPassedTicks"
.LASF6:
	.asciz	"xDelayedCoRoutineList1"
.LASF7:
	.asciz	"xDelayedCoRoutineList2"
.LASF4:
	.asciz	"pxUnblockedCRCB"
.LASF5:
	.asciz	"pxReadyCoRoutineLists"
.LASF11:
	.asciz	"pxCurrentCoRoutine"
.LASF10:
	.asciz	"xPendingReadyCoRoutineList"
.LASF8:
	.asciz	"pxDelayedCoRoutineList"
.LASF13:
	.asciz	"xCoRoutineTickCount"
.LASF9:
	.asciz	"pxOverflowDelayedCoRoutineList"
.LASF1:
	.asciz	"pxPrevious"
.LASF0:
	.asciz	"xItemValue"
.LASF2:
	.asciz	"uxPriority"
.LASF3:
	.asciz	"pxEventList"
.LASF12:
	.asciz	"uxTopCoRoutineReadyPriority"
	.section	.text,code



	.section __c30_info, info, bss
__large_data_scalar:

	.section __c30_signature, info, data
	.word 0x0001
	.word 0x0007
	.word 0x0000

; MCHP configuration words

	.set ___PA___,0
	.end
