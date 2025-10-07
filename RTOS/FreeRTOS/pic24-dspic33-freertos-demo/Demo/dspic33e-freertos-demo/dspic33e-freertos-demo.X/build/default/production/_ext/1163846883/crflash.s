	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\Common\\Minimal\\crflash.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.prvFlashCoRoutine,code
	.align	2
	.type	_prvFlashCoRoutine,@function
_prvFlashCoRoutine:
.LFB2:
	.file 1 "../../Common/Minimal/crflash.c"
	.loc 1 171 0
	.set ___PA___,1
	lnk	#2
.LCFI0:
	mov	w8,[w15++]
.LCFI1:
	mov	w0,w8
	.loc 1 178 0
	mov	[w8+26],w0
	mov	#368,w1
	sub	w0,w1,[w15]
	.set ___BP___,29
	bra	z,.L4
	mov	#369,w1
	sub	w0,w1,[w15]
	.set ___BP___,29
	bra	z,.L5
	cp0	w0
	.set ___BP___,50
	bra	nz,.L1
.L3:
	.loc 1 184 0
	setm	w2
	sub	w15,#4,w1
	mov	_xFlashQueue,w0
	rcall	_xQueueCRReceive
	add	w0,#4,[w15]
	.set ___BP___,19
	bra	z,.L9
.L6:
	add	w0,#5,[w15]
	.set ___BP___,19
	bra	z,.L10
	.loc 1 186 0
	sub	w0,#1,[w15]
	.set ___BP___,0
	bra	z,.L5
	.loc 1 189 0
	clr	_xCoRoutineFlashStatus
	.loc 1 184 0
	setm	w2
	sub	w15,#4,w1
	mov	_xFlashQueue,w0
	rcall	_xQueueCRReceive
	add	w0,#4,[w15]
	.set ___BP___,80
	bra	nz,.L6
.L9:
	mov	#368,w0
	mov	w0,[w8+26]
.L1:
	.loc 1 200 0
	mov	[--w15],w8
	ulnk	
	return	
.L11:
	.set ___PA___,0
.L4:
	.loc 1 184 0
	clr	w2
	sub	w15,#4,w1
	mov	_xFlashQueue,w0
	rcall	_xQueueCRReceive
	bra	.L6
.L10:
	mov	#369,w0
	mov	w0,[w8+26]
	.loc 1 200 0
	mov	[--w15],w8
	ulnk	
	return	
	bra	.L11
.L5:
	.loc 1 194 0
	mov	[w15-4],w0
	rcall	_vParTestToggleLED
	bra	.L3
.LFE2:
	.size	_prvFlashCoRoutine, .-_prvFlashCoRoutine
	.section	.text.prvFixedDelayCoRoutine,code
	.align	2
	.type	_prvFixedDelayCoRoutine,@function
_prvFixedDelayCoRoutine:
.LFB1:
	.loc 1 130 0
	.set ___PA___,1
	lnk	#2
.LCFI2:
	mov	w8,[w15++]
.LCFI3:
	mov	w0,w8
	mov	w1,[w15-4]
	.loc 1 146 0
	mov	[w8+26],w0
	mov	#304,w1
	sub	w0,w1,[w15]
	.set ___BP___,29
	bra	z,.L16
	.set ___BP___,50
	bra	leu,.L23
	mov	#305,w1
	sub	w0,w1,[w15]
	.set ___BP___,29
	bra	z,.L17
	mov	#324,w1
	sub	w0,w1,[w15]
	.set ___BP___,29
	bra	z,.L15
.L13:
	.loc 1 167 0
	mov	[--w15],w8
	ulnk	
	return	
.L28:
	.set ___PA___,0
.L23:
	.loc 1 146 0
	cp0	w0
	.set ___BP___,50
	bra	nz,.L13
.L15:
	.loc 1 152 0
	clr	w2
	sub	w15,#4,w1
	mov	_xFlashQueue,w0
	rcall	_xQueueCRSend
	add	w0,#4,[w15]
	.set ___BP___,19
	bra	z,.L24
.L19:
	add	w0,#5,[w15]
	.set ___BP___,19
	bra	z,.L25
	.loc 1 154 0
	sub	w0,#1,[w15]
	.set ___BP___,0
	bra	z,.L17
	.loc 1 159 0
	clr	_xCoRoutineFlashStatus
.L17:
	.loc 1 162 0
	mov	[w15-4],w0
	add	w0,w0,w0
	mov	#_xFlashRates.16964,w1
	add	w1,w0,w0
	mov	[w0],w0
	cp0	w0
	.set ___BP___,29
	bra	nz,.L26
	mov	#324,w0
	mov	w0,[w8+26]
.L27:
	.loc 1 167 0
	mov	[--w15],w8
	ulnk	
	return	
	bra	.L28
.L16:
	.loc 1 152 0
	clr	w2
	sub	w15,#4,w1
	mov	_xFlashQueue,w0
	rcall	_xQueueCRSend
	bra	.L19
.L26:
	.loc 1 162 0
	clr	w1
	rcall	_vCoRoutineAddToDelayedList
	mov	#324,w0
	mov	w0,[w8+26]
	bra	.L27
.L25:
	.loc 1 152 0
	mov	#305,w0
	mov	w0,[w8+26]
	.loc 1 167 0
	mov	[--w15],w8
	ulnk	
	return	
	bra	.L28
.L24:
	.loc 1 152 0
	mov	#304,w0
	mov	w0,[w8+26]
	.loc 1 167 0
	mov	[--w15],w8
	ulnk	
	return	
	bra	.L28
.LFE1:
	.size	_prvFixedDelayCoRoutine, .-_prvFixedDelayCoRoutine
	.section	.text.vStartFlashCoRoutines,code
	.align	2
	.global	_vStartFlashCoRoutines	; export
	.type	_vStartFlashCoRoutines,@function
_vStartFlashCoRoutines:
.LFB0:
	.loc 1 104 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI4:
	mov	w0,w9
	.loc 1 113 0
	clr.b	w2
	mov	#2,w1
	mov	#1,w0
	rcall	_xQueueGenericCreate
	mov	w0,_xFlashQueue
	.loc 1 115 0
	cp0	w0
	.set ___BP___,10
	bra	z,.L30
	sub	w9,#8,[w15]
	.set ___BP___,50
	bra	gtu,.L38
	.loc 1 118 0
	cp0	w9
	.set ___BP___,9
	bra	z,.L33
	clr	w8
.L34:
	.loc 1 120 0
	mov	w8,w2
	clr	w1
	mov	#handle(_prvFixedDelayCoRoutine),w0
	rcall	_xCoRoutineCreate
	.loc 1 118 0
	inc	w8,w8
	sub	w9,w8,[w15]
	.set ___BP___,91
	bra	gtu,.L34
.L33:
	.loc 1 124 0
	clr	w2
	mov	#1,w1
	mov	#handle(_prvFlashCoRoutine),w0
	rcall	_xCoRoutineCreate
.L30:
	.loc 1 126 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L38:
	.loc 1 115 0
	mov	#8,w9
	.loc 1 118 0
	clr	w8
	bra	.L34
.LFE0:
	.size	_vStartFlashCoRoutines, .-_vStartFlashCoRoutines
	.section	.text.xAreFlashCoRoutinesStillRunning,code
	.align	2
	.global	_xAreFlashCoRoutinesStillRunning	; export
	.type	_xAreFlashCoRoutinesStillRunning,@function
_xAreFlashCoRoutinesStillRunning:
.LFB3:
	.loc 1 204 0
	.set ___PA___,1
	.loc 1 208 0
	mov	_xCoRoutineFlashStatus,w0
	return	
	.set ___PA___,0
.LFE3:
	.size	_xAreFlashCoRoutinesStillRunning, .-_xAreFlashCoRoutinesStillRunning
	.section	.ndata,data,near
	.align	2
	.type	_xCoRoutineFlashStatus,@object
	.size	_xCoRoutineFlashStatus, 2
_xCoRoutineFlashStatus:
	.word	1
	.section	.nbss,bss,near
	.align	2
	.type	_xFlashQueue,@object
	.size	_xFlashQueue, 2
_xFlashQueue:
	.skip	2
	.section	.const,psv,page
	.align	2
	.type	_xFlashRates.16964,@object
	.size	_xFlashRates.16964, 16
_xFlashRates.16964:
	.word	150
	.word	200
	.word	250
	.word	300
	.word	350
	.word	400
	.word	450
	.word	500
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
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI0-.LFB2
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x88
	.uleb128 0x4
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
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0x88
	.uleb128 0x4
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI4-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.align	4
.LEFDE6:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../../Source/include/list.h"
	.file 5 "../../../Source/include/croutine.h"
	.file 6 "../../../Source/include/queue.h"
	.section	.debug_info,info
	.4byte	0x651
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../Common/Minimal/crflash.c"
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
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0x19b
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x149
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
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x3
	.byte	0x61
	.4byte	0x1ff
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x133
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x1ac
	.uleb128 0x5
	.asciz	"xLIST_ITEM"
	.byte	0xa
	.byte	0x4
	.byte	0x90
	.4byte	0x29a
	.uleb128 0x6
	.4byte	.LASF0
	.byte	0x4
	.byte	0x93
	.4byte	0x21f
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"pxNext"
	.byte	0x4
	.byte	0x94
	.4byte	0x29a
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.4byte	.LASF1
	.byte	0x4
	.byte	0x95
	.4byte	0x29a
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x7
	.asciz	"pvOwner"
	.byte	0x4
	.byte	0x96
	.4byte	0x1eb
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x7
	.asciz	"pvContainer"
	.byte	0x4
	.byte	0x97
	.4byte	0x2ee
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x8
	.byte	0x2
	.4byte	0x231
	.uleb128 0x5
	.asciz	"xLIST"
	.byte	0xa
	.byte	0x4
	.byte	0xac
	.4byte	0x2ee
	.uleb128 0x7
	.asciz	"uxNumberOfItems"
	.byte	0x4
	.byte	0xaf
	.4byte	0x362
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"pxIndex"
	.byte	0x4
	.byte	0xb0
	.4byte	0x367
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x7
	.asciz	"xListEnd"
	.byte	0x4
	.byte	0xb1
	.4byte	0x34c
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x8
	.byte	0x2
	.4byte	0x2a0
	.uleb128 0x3
	.asciz	"ListItem_t"
	.byte	0x4
	.byte	0x9a
	.4byte	0x231
	.uleb128 0x5
	.asciz	"xMINI_LIST_ITEM"
	.byte	0x6
	.byte	0x4
	.byte	0x9d
	.4byte	0x34c
	.uleb128 0x6
	.4byte	.LASF0
	.byte	0x4
	.byte	0xa0
	.4byte	0x21f
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"pxNext"
	.byte	0x4
	.byte	0xa1
	.4byte	0x29a
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x6
	.4byte	.LASF1
	.byte	0x4
	.byte	0xa2
	.4byte	0x29a
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x3
	.asciz	"MiniListItem_t"
	.byte	0x4
	.byte	0xa4
	.4byte	0x306
	.uleb128 0x9
	.4byte	0x20c
	.uleb128 0x8
	.byte	0x2
	.4byte	0x2f4
	.uleb128 0x3
	.asciz	"CoRoutineHandle_t"
	.byte	0x5
	.byte	0x2f
	.4byte	0x1eb
	.uleb128 0x3
	.asciz	"crCOROUTINE_CODE"
	.byte	0x5
	.byte	0x32
	.4byte	0x39e
	.uleb128 0x8
	.byte	0x2
	.4byte	0x3a4
	.uleb128 0xa
	.byte	0x1
	.4byte	0x3b5
	.uleb128 0xb
	.4byte	0x36d
	.uleb128 0xb
	.4byte	0x20c
	.byte	0x0
	.uleb128 0x5
	.asciz	"corCoRoutineControlBlock"
	.byte	0x1c
	.byte	0x5
	.byte	0x35
	.4byte	0x45e
	.uleb128 0x7
	.asciz	"pxCoRoutineFunction"
	.byte	0x5
	.byte	0x37
	.4byte	0x386
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x7
	.asciz	"xGenericListItem"
	.byte	0x5
	.byte	0x38
	.4byte	0x2f4
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x7
	.asciz	"xEventListItem"
	.byte	0x5
	.byte	0x39
	.4byte	0x2f4
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x7
	.asciz	"uxPriority"
	.byte	0x5
	.byte	0x3a
	.4byte	0x20c
	.byte	0x2
	.byte	0x23
	.uleb128 0x16
	.uleb128 0x6
	.4byte	.LASF2
	.byte	0x5
	.byte	0x3b
	.4byte	0x20c
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x7
	.asciz	"uxState"
	.byte	0x5
	.byte	0x3c
	.4byte	0x1ac
	.byte	0x2
	.byte	0x23
	.uleb128 0x1a
	.byte	0x0
	.uleb128 0x3
	.asciz	"CRCB_t"
	.byte	0x5
	.byte	0x3d
	.4byte	0x3b5
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"QueueHandle_t"
	.byte	0x6
	.byte	0x33
	.4byte	0x489
	.uleb128 0x8
	.byte	0x2
	.4byte	0x48f
	.uleb128 0xc
	.asciz	"QueueDefinition"
	.byte	0x1
	.uleb128 0xd
	.asciz	"prvFlashCoRoutine"
	.byte	0x1
	.byte	0xaa
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x50c
	.uleb128 0xe
	.asciz	"xHandle"
	.byte	0x1
	.byte	0xaa
	.4byte	0x36d
	.byte	0x1
	.byte	0x50
	.uleb128 0xf
	.4byte	.LASF2
	.byte	0x1
	.byte	0xaa
	.4byte	0x20c
	.byte	0x1
	.byte	0x51
	.uleb128 0x10
	.asciz	"xResult"
	.byte	0x1
	.byte	0xae
	.4byte	0x1ed
	.byte	0x1
	.byte	0x50
	.uleb128 0x10
	.asciz	"uxLEDToFlash"
	.byte	0x1
	.byte	0xaf
	.4byte	0x20c
	.byte	0x2
	.byte	0x91
	.sleb128 -4
	.byte	0x0
	.uleb128 0xd
	.asciz	"prvFixedDelayCoRoutine"
	.byte	0x1
	.byte	0x81
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x57f
	.uleb128 0xe
	.asciz	"xHandle"
	.byte	0x1
	.byte	0x81
	.4byte	0x36d
	.byte	0x1
	.byte	0x58
	.uleb128 0xf
	.4byte	.LASF2
	.byte	0x1
	.byte	0x81
	.4byte	0x20c
	.byte	0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x10
	.asciz	"xResult"
	.byte	0x1
	.byte	0x85
	.4byte	0x1ed
	.byte	0x1
	.byte	0x50
	.uleb128 0x10
	.asciz	"xFlashRates"
	.byte	0x1
	.byte	0x88
	.4byte	0x58f
	.byte	0x5
	.byte	0x3
	.4byte	_xFlashRates.16964
	.byte	0x0
	.uleb128 0x11
	.4byte	0x21f
	.4byte	0x58f
	.uleb128 0x12
	.4byte	0x149
	.byte	0x7
	.byte	0x0
	.uleb128 0x13
	.4byte	0x57f
	.uleb128 0x14
	.byte	0x1
	.asciz	"vStartFlashCoRoutines"
	.byte	0x1
	.byte	0x67
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x5e5
	.uleb128 0xe
	.asciz	"uxNumberToCreate"
	.byte	0x1
	.byte	0x67
	.4byte	0x20c
	.byte	0x1
	.byte	0x59
	.uleb128 0x15
	.4byte	.LASF2
	.byte	0x1
	.byte	0x69
	.4byte	0x20c
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x16
	.byte	0x1
	.asciz	"xAreFlashCoRoutinesStillRunning"
	.byte	0x1
	.byte	0xcb
	.byte	0x1
	.4byte	0x1ed
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.uleb128 0x10
	.asciz	"xFlashQueue"
	.byte	0x1
	.byte	0x5d
	.4byte	0x474
	.byte	0x5
	.byte	0x3
	.4byte	_xFlashQueue
	.uleb128 0x10
	.asciz	"xCoRoutineFlashStatus"
	.byte	0x1
	.byte	0x60
	.4byte	0x1ed
	.byte	0x5
	.byte	0x3
	.4byte	_xCoRoutineFlashStatus
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
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
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
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x8
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0xf
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
	.uleb128 0x10
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
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x0
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
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x4c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x655
	.4byte	0x594
	.asciz	"vStartFlashCoRoutines"
	.4byte	0x5e5
	.asciz	"xAreFlashCoRoutinesStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x109
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x655
	.4byte	0x18c
	.asciz	"uint8_t"
	.4byte	0x1ac
	.asciz	"uint16_t"
	.4byte	0x1ed
	.asciz	"BaseType_t"
	.4byte	0x20c
	.asciz	"UBaseType_t"
	.4byte	0x21f
	.asciz	"TickType_t"
	.4byte	0x231
	.asciz	"xLIST_ITEM"
	.4byte	0x2f4
	.asciz	"ListItem_t"
	.4byte	0x306
	.asciz	"xMINI_LIST_ITEM"
	.4byte	0x34c
	.asciz	"MiniListItem_t"
	.4byte	0x2a0
	.asciz	"xLIST"
	.4byte	0x36d
	.asciz	"CoRoutineHandle_t"
	.4byte	0x386
	.asciz	"crCOROUTINE_CODE"
	.4byte	0x3b5
	.asciz	"corCoRoutineControlBlock"
	.4byte	0x45e
	.asciz	"CRCB_t"
	.4byte	0x474
	.asciz	"QueueHandle_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x34
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF2:
	.asciz	"uxIndex"
.LASF1:
	.asciz	"pxPrevious"
.LASF0:
	.asciz	"xItemValue"
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
