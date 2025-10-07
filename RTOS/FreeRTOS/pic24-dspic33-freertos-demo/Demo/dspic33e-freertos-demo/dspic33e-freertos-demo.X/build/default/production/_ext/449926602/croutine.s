	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\..\\Source\\croutine.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.xCoRoutineCreate,code
	.align	2
	.global	_xCoRoutineCreate	; export
	.type	_xCoRoutineCreate,@function
_xCoRoutineCreate:
.LFB0:
	.file 1 "../../../Source/croutine.c"
	.loc 1 106 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI0:
	mov.d	w10,[w15++]
.LCFI1:
	mov.d	w0,w8
	mov	w2,w11
	.loc 1 111 0
	mov	#28,w0
	rcall	_pvPortMalloc
	mov	w0,w10
	.loc 1 156 0
	setm	w0
	.loc 1 113 0
	cp0	w10
	.set ___BP___,10
	bra	z,.L2
	.loc 1 117 0
	cp0	_pxCurrentCoRoutine
	.set ___BP___,15
	bra	z,.L8
.LBB8:
.LBB10:
	.loc 1 335 0
	cp0	w9
	.set ___BP___,50
	bra	nz,.L9
.L4:
.LBE10:
.LBE8:
	.loc 1 130 0
	clr	w0
	mov	w0,[w10+26]
	.loc 1 131 0
	mov	w9,[w10+22]
	.loc 1 132 0
	mov	w11,[w10+24]
	.loc 1 133 0
	mov	w10,w11
	mov	w8,[w11++]
	.loc 1 136 0
	mov	w11,w0
	rcall	_vListInitialiseItem
	.loc 1 137 0
	add	w10,#12,w0
	rcall	_vListInitialiseItem
	.loc 1 142 0
	mov	w10,[w10+8]
	.loc 1 143 0
	mov	w10,[w10+18]
	.loc 1 146 0
	subr	w9,#2,w9
	mov	w9,[w10+12]
	.loc 1 150 0
	mov	[w10+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L5
.L10:
	mov	w0,_uxTopCoRoutineReadyPriority
.L5:
	mulw.su	w0,#10,w0
	mov	#_pxReadyCoRoutineLists,w1
	add	w0,w1,w0
	mov	w11,w1
	rcall	_vListInsertEnd
	.loc 1 152 0
	mov	#1,w0
.L2:
	.loc 1 160 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L9:
.LBB12:
.LBB9:
	.loc 1 335 0
	mov	#1,w9
.LBE9:
.LBE12:
	.loc 1 130 0
	clr	w0
	mov	w0,[w10+26]
	.loc 1 131 0
	mov	w9,[w10+22]
	.loc 1 132 0
	mov	w11,[w10+24]
	.loc 1 133 0
	mov	w10,w11
	mov	w8,[w11++]
	.loc 1 136 0
	mov	w11,w0
	rcall	_vListInitialiseItem
	.loc 1 137 0
	add	w10,#12,w0
	rcall	_vListInitialiseItem
	.loc 1 142 0
	mov	w10,[w10+8]
	.loc 1 143 0
	mov	w10,[w10+18]
	.loc 1 146 0
	subr	w9,#2,w9
	mov	w9,[w10+12]
	.loc 1 150 0
	mov	[w10+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L5
	bra	.L10
.L8:
	.loc 1 119 0
	mov	w10,_pxCurrentCoRoutine
.LBB13:
.LBB11:
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
	cp0	w9
	.set ___BP___,50
	bra	z,.L4
	bra	.L9
.LBE11:
.LBE13:
.LFE0:
	.size	_xCoRoutineCreate, .-_xCoRoutineCreate
	.section	.text.vCoRoutineAddToDelayedList,code
	.align	2
	.global	_vCoRoutineAddToDelayedList	; export
	.type	_vCoRoutineAddToDelayedList,@function
_vCoRoutineAddToDelayedList:
.LFB1:
	.loc 1 165 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI2:
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
	bra	leu,.L13
	.loc 1 184 0
	inc2	w1,w1
	mov	_pxOverflowDelayedCoRoutineList,w0
	rcall	_vListInsert
.L14:
	.loc 1 193 0
	cp0	w8
	.set ___BP___,21
	bra	z,.L12
	.loc 1 197 0
	mov	_pxCurrentCoRoutine,w1
	add	w1,#12,w1
	mov	w8,w0
	rcall	_vListInsert
.L12:
	.loc 1 199 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L13:
	.loc 1 190 0
	inc2	w1,w1
	mov	_pxDelayedCoRoutineList,w0
	rcall	_vListInsert
	bra	.L14
.LFE1:
	.size	_vCoRoutineAddToDelayedList, .-_vCoRoutineAddToDelayedList
	.section	.text.vCoRoutineSchedule,code
	.align	2
	.global	_vCoRoutineSchedule	; export
	.type	_vCoRoutineSchedule,@function
_vCoRoutineSchedule:
.LFB4:
	.loc 1 285 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI3:
	mov.d	w10,[w15++]
.LCFI4:
	.loc 1 289 0
	cp0	_pxDelayedCoRoutineList
	.set ___BP___,10
	bra	z,.L18
.LBB21:
.LBB22:
	.loc 1 207 0
	mov	_xPendingReadyCoRoutineList,w0
	mov	#_pxReadyCoRoutineLists,w9
	cp0	w0
	.set ___BP___,9
	bra	z,.L20
.LBB23:
	.loc 1 212 0
	mov	#-225,w8
.L22:
	mov	_SRbits,w1
	and	w8,w1,w0
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 212 "../../../Source/croutine.c" 1
	NOP
	.loc 1 214 0
	mov	_xPendingReadyCoRoutineList+6,w0
	mov	[w0+6],w10
	.loc 1 215 0
	add	w10,#12,w0
	rcall	_uxListRemove
	.loc 1 217 0
	mov	#_SRbits,w0
	and	w8,[w0],[w0]
	nop	
	.loc 1 219 0
	inc2	w10,w11
	mov	w11,w0
	rcall	_uxListRemove
	.loc 1 220 0
	mov	[w10+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L21
	mov	w0,_uxTopCoRoutineReadyPriority
.L21:
	mulw.su	w0,#10,w0
	add	w9,w0,w0
	mov	w11,w1
	rcall	_vListInsertEnd
.LBE23:
	.loc 1 207 0
	mov	_xPendingReadyCoRoutineList,w0
	cp0	w0
	.set ___BP___,91
	bra	nz,.L22
.L20:
.LBE22:
.LBE21:
.LBB24:
.LBB25:
	.loc 1 229 0
	rcall	_xTaskGetTickCount
	mov	_xLastTickCount,w1
	sub	w0,w1,w1
	mov	w1,_xPassedTicks
	mov	_xCoRoutineTickCount,w0
	.loc 1 259 0
	mov	#-225,w8
	.loc 1 231 0
	.set ___BP___,9
	bra	z,.L43
.L32:
	.loc 1 233 0
	inc	w0,w0
	mov	w0,_xCoRoutineTickCount
	.loc 1 234 0
	dec	w1,w1
	mov	w1,_xPassedTicks
	.loc 1 237 0
	cp0	w0
	.set ___BP___,50
	bra	z,.L24
	mov	_pxDelayedCoRoutineList,w1
.L25:
	.loc 1 249 0
	cp0	[w1]
	.set ___BP___,4
	bra	z,.L26
	.loc 1 251 0
	mov	[w1+6],w1
	mov	[w1+6],w10
	.loc 1 253 0
	mov	[w10+2],w1
	sub	w1,w0,[w15]
	.set ___BP___,4
	bra	gtu,.L26
.L41:
	.loc 1 259 0
	mov	_SRbits,w1
	and	w8,w1,w0
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 259 "../../../Source/croutine.c" 1
	NOP
	.loc 1 266 0
	inc2	w10,w11
	mov	w11,w0
	rcall	_uxListRemove
	.loc 1 269 0
	mov	[w10+20],w0
	cp0	w0
	.set ___BP___,30
	bra	z,.L29
	.loc 1 271 0
	add	w10,#12,w0
	rcall	_uxListRemove
.L29:
	.loc 1 274 0
	mov	#_SRbits,w0
	and	w8,[w0],[w0]
	nop	
	.loc 1 276 0
	mov	[w10+22],w0
	cp	_uxTopCoRoutineReadyPriority
	.set ___BP___,50
	bra	geu,.L30
	mov	w0,_uxTopCoRoutineReadyPriority
.L30:
	mulw.su	w0,#10,w0
	add	w9,w0,w0
	mov	w11,w1
	rcall	_vListInsertEnd
	.loc 1 249 0
	mov	_pxDelayedCoRoutineList,w0
	cp0	[w0]
	.set ___BP___,4
	bra	z,.L44
	.loc 1 251 0
	mov	[w0+6],w0
	mov	[w0+6],w10
	.loc 1 253 0
	mov	_xCoRoutineTickCount,w0
	mov	[w10+2],w1
	sub	w1,w0,[w15]
	.set ___BP___,95
	bra	leu,.L41
.L26:
	.loc 1 249 0
	mov	_xPassedTicks,w1
.L46:
	.loc 1 231 0
	cp0	w1
	.set ___BP___,91
	bra	nz,.L32
.L43:
	.loc 1 280 0
	mov	w0,_xLastTickCount
.LBE25:
.LBE24:
	.loc 1 298 0
	mov	_uxTopCoRoutineReadyPriority,w0
	mulw.su	w0,#10,w2
	add	w9,w2,w1
	cp0	[w1]
	.set ___BP___,4
	bra	nz,.L33
	.loc 1 300 0
	cp0	w0
	.set ___BP___,4
	bra	z,.L18
.L38:
	.loc 1 306 0
	dec	w0,w0
	.loc 1 298 0
	mulw.su	w0,#10,w2
	add	w9,w2,w1
	cp0	[w1]
	.set ___BP___,4
	bra	nz,.L45
	.loc 1 300 0
	cp0	w0
	.set ___BP___,95
	bra	nz,.L38
	mov	w0,_uxTopCoRoutineReadyPriority
.L18:
	.loc 1 316 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
.L49:
	.set ___PA___,0
.L24:
.LBB28:
.LBB27:
.LBB26:
	.loc 1 243 0
	mov	_pxDelayedCoRoutineList,w2
	.loc 1 244 0
	mov	_pxOverflowDelayedCoRoutineList,w1
	mov	w1,_pxDelayedCoRoutineList
	.loc 1 245 0
	mov	w2,_pxOverflowDelayedCoRoutineList
	bra	.L25
.L44:
.LBE26:
	.loc 1 249 0
	mov	_xCoRoutineTickCount,w0
	mov	_xPassedTicks,w1
	bra	.L46
.L45:
.LBE27:
.LBE28:
	.loc 1 298 0
	mov	w0,_uxTopCoRoutineReadyPriority
.L33:
.LBB29:
	.loc 1 311 0
	add	w9,w2,w0
	mov	[w0+2],w0
	mov	[w0+2],w0
	add	w9,w2,w1
	mov	w0,[++w1]
	add	w2,#4,w2
	add	w9,w2,w9
	sub	w0,w9,[w15]
	.set ___BP___,15
	bra	z,.L47
	mov	[w0+6],w0
	mov	w0,_pxCurrentCoRoutine
.LBE29:
	.loc 1 314 0
	mov	[w0+24],w1
	mov	[w0],w2
	call	w2
.L48:
	.loc 1 316 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L49
.L47:
.LBB30:
	.loc 1 311 0
	mov	[w0+2],w0
	mov	w0,[w1]
	mov	[w0+6],w0
	mov	w0,_pxCurrentCoRoutine
.LBE30:
	.loc 1 314 0
	mov	[w0+24],w1
	mov	[w0],w2
	call	w2
	bra	.L48
.LFE4:
	.size	_vCoRoutineSchedule, .-_vCoRoutineSchedule
	.section	.text.xCoRoutineRemoveFromEventList,code
	.align	2
	.global	_xCoRoutineRemoveFromEventList	; export
	.type	_xCoRoutineRemoveFromEventList,@function
_xCoRoutineRemoveFromEventList:
.LFB6:
	.loc 1 340 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI5:
	.loc 1 347 0
	mov	[w0+6],w0
	mov	[w0+6],w8
	.loc 1 348 0
	add	w8,#12,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 349 0
	mov	w9,w1
	mov	#_xPendingReadyCoRoutineList,w0
	rcall	_vListInsertEnd
	.loc 1 353 0
	mov	#1,w0
	mov	[w8+22],w2
	mov	_pxCurrentCoRoutine,w1
	mov	[w1+22],w1
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	geu,.L52
	clr	w0
.L52:
	.loc 1 361 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE6:
	.size	_xCoRoutineRemoveFromEventList, .-_xCoRoutineRemoveFromEventList
	.global	_pxCurrentCoRoutine	; export
	.section	.nbss,bss,near
	.align	2
	.type	_pxCurrentCoRoutine,@object
	.size	_pxCurrentCoRoutine, 2
_pxCurrentCoRoutine:
	.skip	2
	.section	.bss,bss
	.align	2
	.type	_xPendingReadyCoRoutineList,@object
	.size	_xPendingReadyCoRoutineList, 10
_xPendingReadyCoRoutineList:
	.skip	10
	.section	.nbss,bss,near
	.align	2
	.type	_pxDelayedCoRoutineList,@object
	.size	_pxDelayedCoRoutineList, 2
_pxDelayedCoRoutineList:
	.skip	2
	.align	2
	.type	_uxTopCoRoutineReadyPriority,@object
	.size	_uxTopCoRoutineReadyPriority, 2
_uxTopCoRoutineReadyPriority:
	.skip	2
	.section	.bss,bss
	.align	2
	.type	_pxReadyCoRoutineLists,@object
	.size	_pxReadyCoRoutineLists, 20
_pxReadyCoRoutineLists:
	.skip	20
	.section	.nbss,bss,near
	.align	2
	.type	_xLastTickCount,@object
	.size	_xLastTickCount, 2
_xLastTickCount:
	.skip	2
	.align	2
	.type	_xPassedTicks,@object
	.size	_xPassedTicks, 2
_xPassedTicks:
	.skip	2
	.align	2
	.type	_xCoRoutineTickCount,@object
	.size	_xCoRoutineTickCount, 2
_xCoRoutineTickCount:
	.skip	2
	.align	2
	.type	_pxOverflowDelayedCoRoutineList,@object
	.size	_pxOverflowDelayedCoRoutineList, 2
_pxOverflowDelayedCoRoutineList:
	.skip	2
	.section	.bss,bss
	.align	2
	.type	_xDelayedCoRoutineList1,@object
	.size	_xDelayedCoRoutineList1, 10
_xDelayedCoRoutineList1:
	.skip	10
	.align	2
	.type	_xDelayedCoRoutineList2,@object
	.size	_xDelayedCoRoutineList2, 10
_xDelayedCoRoutineList2:
	.skip	10
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
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI2-.LFB1
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI3-.LFB4
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
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI5-.LFB6
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE6:
	.section	.text,code
.Letext0:
	.file 2 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h"
	.file 3 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 4 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 5 "../../../Source/include/list.h"
	.file 6 "../../../Source/include/croutine.h"
	.section	.debug_info,info
	.4byte	0xa4a
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../../Source/croutine.c"
	.ascii	"C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24"
	.ascii	"-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspi"
	.asciz	"c33e-freertos-demo\\dspic33e-freertos-demo.X"
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
	.4byte	0x145
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
	.4byte	0x2c1
	.uleb128 0x5
	.asciz	"C"
	.byte	0x2
	.byte	0x89
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x300
	.uleb128 0x5
	.asciz	"IPL0"
	.byte	0x2
	.byte	0x9a
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x199
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
	.4byte	0x313
	.uleb128 0x7
	.4byte	0x1d8
	.uleb128 0x7
	.4byte	0x2c1
	.byte	0x0
	.uleb128 0x8
	.asciz	"tagSRBITS"
	.byte	0x2
	.byte	0x2
	.byte	0x86
	.4byte	0x32e
	.uleb128 0x9
	.4byte	0x300
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x3
	.asciz	"SRBITS"
	.byte	0x2
	.byte	0x9f
	.4byte	0x313
	.uleb128 0xa
	.byte	0x2
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x4
	.byte	0x61
	.4byte	0x350
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x4
	.byte	0x62
	.4byte	0x12f
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x4
	.byte	0x65
	.4byte	0x199
	.uleb128 0x8
	.asciz	"xLIST_ITEM"
	.byte	0xa
	.byte	0x5
	.byte	0x90
	.4byte	0x3eb
	.uleb128 0xb
	.4byte	.LASF0
	.byte	0x5
	.byte	0x93
	.4byte	0x370
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"pxNext"
	.byte	0x5
	.byte	0x94
	.4byte	0x3eb
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xb
	.4byte	.LASF1
	.byte	0x5
	.byte	0x95
	.4byte	0x3eb
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xc
	.asciz	"pvOwner"
	.byte	0x5
	.byte	0x96
	.4byte	0x33c
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0xc
	.asciz	"pvContainer"
	.byte	0x5
	.byte	0x97
	.4byte	0x43f
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x382
	.uleb128 0x8
	.asciz	"xLIST"
	.byte	0xa
	.byte	0x5
	.byte	0xac
	.4byte	0x43f
	.uleb128 0xc
	.asciz	"uxNumberOfItems"
	.byte	0x5
	.byte	0xaf
	.4byte	0x4b3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"pxIndex"
	.byte	0x5
	.byte	0xb0
	.4byte	0x4b8
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xc
	.asciz	"xListEnd"
	.byte	0x5
	.byte	0xb1
	.4byte	0x49d
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x3f1
	.uleb128 0x3
	.asciz	"ListItem_t"
	.byte	0x5
	.byte	0x9a
	.4byte	0x382
	.uleb128 0x8
	.asciz	"xMINI_LIST_ITEM"
	.byte	0x6
	.byte	0x5
	.byte	0x9d
	.4byte	0x49d
	.uleb128 0xb
	.4byte	.LASF0
	.byte	0x5
	.byte	0xa0
	.4byte	0x370
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"pxNext"
	.byte	0x5
	.byte	0xa1
	.4byte	0x3eb
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xb
	.4byte	.LASF1
	.byte	0x5
	.byte	0xa2
	.4byte	0x3eb
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x3
	.asciz	"MiniListItem_t"
	.byte	0x5
	.byte	0xa4
	.4byte	0x457
	.uleb128 0xe
	.4byte	0x35d
	.uleb128 0xd
	.byte	0x2
	.4byte	0x445
	.uleb128 0x3
	.asciz	"List_t"
	.byte	0x5
	.byte	0xb3
	.4byte	0x3f1
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"CoRoutineHandle_t"
	.byte	0x6
	.byte	0x2f
	.4byte	0x33c
	.uleb128 0x3
	.asciz	"crCOROUTINE_CODE"
	.byte	0x6
	.byte	0x32
	.4byte	0x505
	.uleb128 0xd
	.byte	0x2
	.4byte	0x50b
	.uleb128 0xf
	.byte	0x1
	.4byte	0x51c
	.uleb128 0x10
	.4byte	0x4d4
	.uleb128 0x10
	.4byte	0x35d
	.byte	0x0
	.uleb128 0x8
	.asciz	"corCoRoutineControlBlock"
	.byte	0x1c
	.byte	0x6
	.byte	0x35
	.4byte	0x5c2
	.uleb128 0xc
	.asciz	"pxCoRoutineFunction"
	.byte	0x6
	.byte	0x37
	.4byte	0x4ed
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xc
	.asciz	"xGenericListItem"
	.byte	0x6
	.byte	0x38
	.4byte	0x445
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xc
	.asciz	"xEventListItem"
	.byte	0x6
	.byte	0x39
	.4byte	0x445
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0xb
	.4byte	.LASF2
	.byte	0x6
	.byte	0x3a
	.4byte	0x35d
	.byte	0x2
	.byte	0x23
	.uleb128 0x16
	.uleb128 0xc
	.asciz	"uxIndex"
	.byte	0x6
	.byte	0x3b
	.4byte	0x35d
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0xc
	.asciz	"uxState"
	.byte	0x6
	.byte	0x3c
	.4byte	0x199
	.byte	0x2
	.byte	0x23
	.uleb128 0x1a
	.byte	0x0
	.uleb128 0x3
	.asciz	"CRCB_t"
	.byte	0x6
	.byte	0x3d
	.4byte	0x51c
	.uleb128 0x11
	.asciz	"prvInitialiseCoRoutineLists"
	.byte	0x1
	.2byte	0x13f
	.byte	0x1
	.byte	0x1
	.4byte	0x603
	.uleb128 0x12
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x141
	.4byte	0x35d
	.byte	0x0
	.uleb128 0x13
	.asciz	"prvCheckPendingReadyList"
	.byte	0x1
	.byte	0xca
	.byte	0x1
	.byte	0x1
	.4byte	0x633
	.uleb128 0x14
	.uleb128 0x15
	.4byte	.LASF3
	.byte	0x1
	.byte	0xd1
	.4byte	0x633
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x5c2
	.uleb128 0x16
	.byte	0x1
	.asciz	"xCoRoutineCreate"
	.byte	0x1
	.byte	0x67
	.byte	0x1
	.4byte	0x33e
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x6dc
	.uleb128 0x17
	.asciz	"pxCoRoutineCode"
	.byte	0x1
	.byte	0x67
	.4byte	0x4ed
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF2
	.byte	0x1
	.byte	0x68
	.4byte	0x35d
	.byte	0x1
	.byte	0x59
	.uleb128 0x17
	.asciz	"uxIndex"
	.byte	0x1
	.byte	0x69
	.4byte	0x35d
	.byte	0x1
	.byte	0x5b
	.uleb128 0x19
	.asciz	"xReturn"
	.byte	0x1
	.byte	0x6b
	.4byte	0x33e
	.byte	0x1
	.byte	0x50
	.uleb128 0x19
	.asciz	"pxCoRoutine"
	.byte	0x1
	.byte	0x6c
	.4byte	0x633
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1a
	.4byte	0x5d0
	.4byte	.LBB8
	.4byte	.LBE8
	.uleb128 0x1b
	.4byte	.LBB10
	.4byte	.LBE10
	.uleb128 0x1c
	.4byte	0x5f6
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1d
	.byte	0x1
	.asciz	"vCoRoutineAddToDelayedList"
	.byte	0x1
	.byte	0xa3
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x744
	.uleb128 0x17
	.asciz	"xTicksToDelay"
	.byte	0x1
	.byte	0xa3
	.4byte	0x370
	.byte	0x1
	.byte	0x50
	.uleb128 0x18
	.4byte	.LASF4
	.byte	0x1
	.byte	0xa4
	.4byte	0x744
	.byte	0x1
	.byte	0x58
	.uleb128 0x19
	.asciz	"xTimeToWake"
	.byte	0x1
	.byte	0xa6
	.4byte	0x370
	.byte	0x1
	.byte	0x59
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x4be
	.uleb128 0x13
	.asciz	"prvCheckDelayedList"
	.byte	0x1
	.byte	0xe1
	.byte	0x1
	.byte	0x1
	.4byte	0x786
	.uleb128 0x1e
	.asciz	"pxCRCB"
	.byte	0x1
	.byte	0xe3
	.4byte	0x633
	.uleb128 0x14
	.uleb128 0x1e
	.asciz	"pxTemp"
	.byte	0x1
	.byte	0xef
	.4byte	0x744
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"vCoRoutineSchedule"
	.byte	0x1
	.2byte	0x11c
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x823
	.uleb128 0x20
	.4byte	0x603
	.4byte	.LBB21
	.4byte	.LBE21
	.4byte	0x7d0
	.uleb128 0x1b
	.4byte	.LBB23
	.4byte	.LBE23
	.uleb128 0x21
	.4byte	0x626
	.byte	0x1
	.byte	0x5a
	.byte	0x0
	.byte	0x0
	.uleb128 0x20
	.4byte	0x74a
	.4byte	.LBB24
	.4byte	.LBE24
	.4byte	0x804
	.uleb128 0x1b
	.4byte	.LBB25
	.4byte	.LBE25
	.uleb128 0x21
	.4byte	0x767
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1b
	.4byte	.LBB26
	.4byte	.LBE26
	.uleb128 0x21
	.4byte	0x776
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB29
	.4byte	.LBE29
	.uleb128 0x22
	.asciz	"pxConstList"
	.byte	0x1
	.2byte	0x137
	.4byte	0x823
	.byte	0x0
	.byte	0x0
	.uleb128 0x23
	.4byte	0x744
	.uleb128 0x24
	.byte	0x1
	.asciz	"xCoRoutineRemoveFromEventList"
	.byte	0x1
	.2byte	0x153
	.byte	0x1
	.4byte	0x33e
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.4byte	0x88b
	.uleb128 0x25
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x153
	.4byte	0x88b
	.byte	0x1
	.byte	0x50
	.uleb128 0x26
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x155
	.4byte	0x633
	.byte	0x1
	.byte	0x58
	.uleb128 0x22
	.asciz	"xReturn"
	.byte	0x1
	.2byte	0x156
	.4byte	0x33e
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.4byte	0x891
	.uleb128 0x23
	.4byte	0x4be
	.uleb128 0x27
	.asciz	"SRbits"
	.byte	0x2
	.byte	0xa0
	.4byte	0x8a6
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x32e
	.uleb128 0x28
	.4byte	0x4be
	.4byte	0x8bb
	.uleb128 0x29
	.4byte	0x145
	.byte	0x1
	.byte	0x0
	.uleb128 0x19
	.asciz	"pxReadyCoRoutineLists"
	.byte	0x1
	.byte	0x2e
	.4byte	0x8ab
	.byte	0x5
	.byte	0x3
	.4byte	_pxReadyCoRoutineLists
	.uleb128 0x19
	.asciz	"xDelayedCoRoutineList1"
	.byte	0x1
	.byte	0x2f
	.4byte	0x4be
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedCoRoutineList1
	.uleb128 0x19
	.asciz	"xDelayedCoRoutineList2"
	.byte	0x1
	.byte	0x30
	.4byte	0x4be
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedCoRoutineList2
	.uleb128 0x19
	.asciz	"pxDelayedCoRoutineList"
	.byte	0x1
	.byte	0x31
	.4byte	0x744
	.byte	0x5
	.byte	0x3
	.4byte	_pxDelayedCoRoutineList
	.uleb128 0x19
	.asciz	"pxOverflowDelayedCoRoutineList"
	.byte	0x1
	.byte	0x32
	.4byte	0x744
	.byte	0x5
	.byte	0x3
	.4byte	_pxOverflowDelayedCoRoutineList
	.uleb128 0x19
	.asciz	"xPendingReadyCoRoutineList"
	.byte	0x1
	.byte	0x33
	.4byte	0x4be
	.byte	0x5
	.byte	0x3
	.4byte	_xPendingReadyCoRoutineList
	.uleb128 0x2a
	.4byte	.LASF5
	.byte	0x1
	.byte	0x36
	.4byte	0x633
	.byte	0x1
	.byte	0x1
	.uleb128 0x19
	.asciz	"uxTopCoRoutineReadyPriority"
	.byte	0x1
	.byte	0x37
	.4byte	0x35d
	.byte	0x5
	.byte	0x3
	.4byte	_uxTopCoRoutineReadyPriority
	.uleb128 0x19
	.asciz	"xCoRoutineTickCount"
	.byte	0x1
	.byte	0x38
	.4byte	0x370
	.byte	0x5
	.byte	0x3
	.4byte	_xCoRoutineTickCount
	.uleb128 0x19
	.asciz	"xLastTickCount"
	.byte	0x1
	.byte	0x38
	.4byte	0x370
	.byte	0x5
	.byte	0x3
	.4byte	_xLastTickCount
	.uleb128 0x19
	.asciz	"xPassedTicks"
	.byte	0x1
	.byte	0x38
	.4byte	0x370
	.byte	0x5
	.byte	0x3
	.4byte	_xPassedTicks
	.uleb128 0x27
	.asciz	"SRbits"
	.byte	0x2
	.byte	0xa0
	.4byte	0x8a6
	.byte	0x1
	.byte	0x1
	.uleb128 0x2b
	.4byte	.LASF5
	.byte	0x1
	.byte	0x36
	.4byte	0x633
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxCurrentCoRoutine
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
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
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
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0xb
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
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
	.uleb128 0x20
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x22
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
	.uleb128 0x23
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x24
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
	.uleb128 0x25
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
	.uleb128 0x26
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
	.uleb128 0x27
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
	.uleb128 0x28
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x2a
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
	.uleb128 0x2b
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
	.4byte	0x92
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0xa4e
	.4byte	0x639
	.asciz	"xCoRoutineCreate"
	.4byte	0x6dc
	.asciz	"vCoRoutineAddToDelayedList"
	.4byte	0x786
	.asciz	"vCoRoutineSchedule"
	.4byte	0x828
	.asciz	"xCoRoutineRemoveFromEventList"
	.4byte	0xa3b
	.asciz	"pxCurrentCoRoutine"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x10f
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0xa4e
	.4byte	0x199
	.asciz	"uint16_t"
	.4byte	0x313
	.asciz	"tagSRBITS"
	.4byte	0x32e
	.asciz	"SRBITS"
	.4byte	0x33e
	.asciz	"BaseType_t"
	.4byte	0x35d
	.asciz	"UBaseType_t"
	.4byte	0x370
	.asciz	"TickType_t"
	.4byte	0x382
	.asciz	"xLIST_ITEM"
	.4byte	0x445
	.asciz	"ListItem_t"
	.4byte	0x457
	.asciz	"xMINI_LIST_ITEM"
	.4byte	0x49d
	.asciz	"MiniListItem_t"
	.4byte	0x3f1
	.asciz	"xLIST"
	.4byte	0x4be
	.asciz	"List_t"
	.4byte	0x4d4
	.asciz	"CoRoutineHandle_t"
	.4byte	0x4ed
	.asciz	"crCOROUTINE_CODE"
	.4byte	0x51c
	.asciz	"corCoRoutineControlBlock"
	.4byte	0x5c2
	.asciz	"CRCB_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x34
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF1:
	.asciz	"pxPrevious"
.LASF0:
	.asciz	"xItemValue"
.LASF5:
	.asciz	"pxCurrentCoRoutine"
.LASF4:
	.asciz	"pxEventList"
.LASF3:
	.asciz	"pxUnblockedCRCB"
.LASF2:
	.asciz	"uxPriority"
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
