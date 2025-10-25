	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\..\\..\\RTOS\\FreeRTOS\\Demo\\Common\\Minimal\\BlockQ.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vBlockingQueueProducer,code
	.align	2
	.type	_vBlockingQueueProducer,@function
_vBlockingQueueProducer:
.LFB1:
	.file 1 "../../RTOS/FreeRTOS/Demo/Common/Minimal/BlockQ.c"
	.loc 1 177 0
	.set ___PA___,1
	lnk	#2
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov.d	w10,[w15++]
.LCFI2:
	.loc 1 178 0
	clr	w1
	mov	w1,[w15-10]
	.loc 1 182 0
	mov.d	w0,w8
	.loc 1 186 0
	mov	w9,w10
	.loc 1 188 0
	mov	#1,w11
	bra	.L6
.L5:
	mov	w11,w9
.L6:
	.loc 1 186 0
	mov	[w8+2],w2
	mov	w10,w3
	sub	w15,#10,w1
	mov	[w8],w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,86
	bra	nz,.L5
	.loc 1 194 0
	cp0	w9
	.set ___BP___,50
	bra	nz,.L3
	.loc 1 196 0
	mov	[w8+4],w0
	inc	[w0],[w0]
.L3:
	.loc 1 201 0
	mov	[w15-10],w0
	inc	w0,w0
	mov	w0,[w15-10]
	bra	.L6
.LFE1:
	.size	_vBlockingQueueProducer, .-_vBlockingQueueProducer
	.section	.text.vBlockingQueueConsumer,code
	.align	2
	.type	_vBlockingQueueConsumer,@function
_vBlockingQueueConsumer:
.LFB2:
	.loc 1 212 0
	.set ___PA___,1
	lnk	#2
.LCFI3:
	mov.d	w8,[w15++]
.LCFI4:
	mov.d	w10,[w15++]
.LCFI5:
	mov	w0,w8
	.loc 1 215 0
	clr	w10
	.loc 1 213 0
	mov	w10,w9
	.loc 1 228 0
	mov	#1,w11
	bra	.L14
.L11:
	.loc 1 226 0
	mov	w0,w9
	.loc 1 228 0
	mov	w11,w10
.L14:
	.loc 1 221 0
	mov	[w8+2],w2
	sub	w15,#10,w1
	mov	[w8],w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L14
	.loc 1 223 0
	mov	[w15-10],w0
	sub	w0,w9,[w15]
	.set ___BP___,72
	bra	nz,.L11
	.loc 1 234 0
	cp0	w10
	.set ___BP___,50
	bra	nz,.L10
	.loc 1 236 0
	mov	[w8+4],w1
	inc	[w1],[w1]
.L10:
	.loc 1 241 0
	inc	w0,w9
	bra	.L14
.LFE2:
	.size	_vBlockingQueueConsumer, .-_vBlockingQueueConsumer
	.section	.const,psv,page
.LC0:
	.asciz	"QConsB1"
.LC1:
	.asciz	"QProdB2"
.LC2:
	.asciz	"QConsB3"
.LC3:
	.asciz	"QProdB4"
.LC4:
	.asciz	"QProdB5"
.LC5:
	.asciz	"QConsB6"
	.section	.text.vStartBlockingQueueTasks,code
	.align	2
	.global	_vStartBlockingQueueTasks	; export
	.type	_vStartBlockingQueueTasks,@function
_vStartBlockingQueueTasks:
.LFB0:
	.loc 1 95 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI6:
	mov.d	w10,[w15++]
.LCFI7:
	mov	w12,[w15++]
.LCFI8:
	mov	w0,w12
	.loc 1 106 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w8
	.loc 1 110 0
	clr.b	w2
	mov	#2,w1
	mov	#1,w0
	rcall	_xQueueGenericCreate
	mov	w0,[w8]
	.loc 1 113 0
	mov	#1000,w10
	mov	w10,[w8+2]
	.loc 1 117 0
	mov	#_sBlockingConsumerCount,w0
	mov	w0,[w8+4]
	.loc 1 120 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 123 0
	mov	[w8],[w9]
	.loc 1 127 0
	clr	w11
	mov	w11,[w9+2]
	.loc 1 131 0
	mov	#_sBlockingProducerCount,w0
	mov	w0,[w9+4]
	.loc 1 136 0
	mov	w11,w5
	mov	w12,w4
	mov	w8,w3
	mov	#105,w2
	mov	#.LC0,w1
	mov	#handle(_vBlockingQueueConsumer),w0
	rcall	_xTaskCreate
	.loc 1 137 0
	mov	w11,w5
	mov	w11,w4
	mov	w9,w3
	mov	#105,w2
	mov	#.LC1,w1
	mov	#handle(_vBlockingQueueProducer),w0
	rcall	_xTaskCreate
	.loc 1 144 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w8
	.loc 1 145 0
	clr.b	w2
	mov	#2,w1
	mov	#1,w0
	rcall	_xQueueGenericCreate
	mov	w0,[w8]
	.loc 1 146 0
	mov	w11,[w8+2]
	.loc 1 147 0
	mov	#_sBlockingProducerCount+2,w0
	mov	w0,[w8+4]
	.loc 1 149 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 150 0
	mov	[w8],[w9]
	.loc 1 151 0
	mov	w10,[w9+2]
	.loc 1 152 0
	mov	#_sBlockingConsumerCount+2,w0
	mov	w0,[w9+4]
	.loc 1 154 0
	mov	w11,w5
	mov	w11,w4
	mov	w8,w3
	mov	#105,w2
	mov	#.LC2,w1
	mov	#handle(_vBlockingQueueConsumer),w0
	rcall	_xTaskCreate
	.loc 1 155 0
	mov	w11,w5
	mov	w12,w4
	mov	w9,w3
	mov	#105,w2
	mov	#.LC3,w1
	mov	#handle(_vBlockingQueueProducer),w0
	rcall	_xTaskCreate
	.loc 1 161 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w8
	.loc 1 162 0
	clr.b	w2
	mov	#2,w1
	mov	#5,w0
	rcall	_xQueueGenericCreate
	mov	w0,[w8]
	.loc 1 163 0
	mov	w10,[w8+2]
	.loc 1 164 0
	mov	#_sBlockingProducerCount+4,w0
	mov	w0,[w8+4]
	.loc 1 166 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 167 0
	mov	[w8],[w9]
	.loc 1 168 0
	mov	w10,[w9+2]
	.loc 1 169 0
	mov	#_sBlockingConsumerCount+4,w0
	mov	w0,[w9+4]
	.loc 1 171 0
	mov	w11,w5
	mov	w11,w4
	mov	w8,w3
	mov	#105,w2
	mov	#.LC4,w1
	mov	#handle(_vBlockingQueueProducer),w0
	rcall	_xTaskCreate
	.loc 1 172 0
	mov	w11,w5
	mov	w5,w4
	mov	w9,w3
	mov	#105,w2
	mov	#.LC5,w1
	mov	#handle(_vBlockingQueueConsumer),w0
	rcall	_xTaskCreate
	.loc 1 173 0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE0:
	.size	_vStartBlockingQueueTasks, .-_vStartBlockingQueueTasks
	.section	.text.xAreBlockingQueuesStillRunning,code
	.align	2
	.global	_xAreBlockingQueuesStillRunning	; export
	.type	_xAreBlockingQueuesStillRunning,@function
_xAreBlockingQueuesStillRunning:
.LFB3:
	.loc 1 259 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI9:
	.loc 1 282 0
	mov	#_sLastBlockingConsumerCount.9901,w3
	mov	#_sLastBlockingProducerCount.9902,w2
	.loc 1 271 0
	clr	w1
	.loc 1 262 0
	mov	#1,w0
	.loc 1 273 0
	mov	#_sBlockingConsumerCount,w6
	.loc 1 275 0
	mov	w1,w9
	.loc 1 280 0
	mov	#_sBlockingProducerCount,w5
.L19:
	.loc 1 273 0
	add	w1,w1,w4
	add	w6,w4,w4
	.loc 1 258 0
	mov	w3,w7
	.loc 1 273 0
	mov	[w4],w4
	sub	w4,[w3],[w15]
	.set ___BP___,72
	bra	nz,.L17
	.loc 1 275 0
	mov	w9,w0
.L17:
	.loc 1 278 0
	add	w1,w1,w4
	add	w6,w4,w8
	mov	[w8],[w7]
	.loc 1 280 0
	add	w5,w4,w4
	.loc 1 258 0
	mov	w2,w7
	.loc 1 280 0
	mov	[w4],w4
	sub	w4,[w2],[w15]
	.set ___BP___,72
	bra	nz,.L18
	.loc 1 282 0
	mov	w9,w0
.L18:
	.loc 1 285 0
	add	w1,w1,w4
	add	w5,w4,w4
	mov	[w4],[w7]
	.loc 1 271 0
	inc	w1,w1
	inc2	w3,w3
	inc2	w2,w2
	sub	w1,#3,[w15]
	.set ___BP___,75
	bra	nz,.L19
	.loc 1 289 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE3:
	.size	_xAreBlockingQueuesStillRunning, .-_xAreBlockingQueuesStillRunning
	.section	.bss,bss
	.align	2
	.type	_sBlockingConsumerCount,@object
	.size	_sBlockingConsumerCount, 6
_sBlockingConsumerCount:
	.skip	6
	.align	2
	.type	_sBlockingProducerCount,@object
	.size	_sBlockingProducerCount, 6
_sBlockingProducerCount:
	.skip	6
	.align	2
	.type	_sLastBlockingProducerCount.9902,@object
	.size	_sLastBlockingProducerCount.9902, 6
_sLastBlockingProducerCount.9902:
	.skip	6
	.align	2
	.type	_sLastBlockingConsumerCount.9901,@object
	.size	_sLastBlockingConsumerCount.9901, 6
_sLastBlockingConsumerCount.9901:
	.skip	6
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
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI2-.LCFI0
	.byte	0x8a
	.uleb128 0x6
	.byte	0x88
	.uleb128 0x4
	.align	4
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI3-.LFB2
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI5-.LCFI3
	.byte	0x8a
	.uleb128 0x6
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
	.4byte	.LCFI6-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0x13
	.sleb128 -7
	.byte	0x8c
	.uleb128 0x6
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
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI9-.LFB3
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE6:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../RTOS/FreeRTOS/Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../RTOS/FreeRTOS/Source/include/queue.h"
	.section	.debug_info,info
	.4byte	0x5a2
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../RTOS/FreeRTOS/Demo/Common/Minimal/BlockQ.c"
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
	.byte	0x4
	.byte	0x5
	.asciz	"long int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.asciz	"long long int"
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0x138
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0xe6
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
	.4byte	0x19c
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0xd0
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x149
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"QueueHandle_t"
	.byte	0x4
	.byte	0x33
	.4byte	0x1eb
	.uleb128 0x5
	.byte	0x2
	.4byte	0x1f1
	.uleb128 0x6
	.asciz	"QueueDefinition"
	.byte	0x1
	.uleb128 0x7
	.asciz	"BLOCKING_QUEUE_PARAMETERS"
	.byte	0x6
	.byte	0x1
	.byte	0x45
	.4byte	0x25f
	.uleb128 0x8
	.asciz	"xQueue"
	.byte	0x1
	.byte	0x47
	.4byte	0x1d6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x9
	.4byte	.LASF0
	.byte	0x1
	.byte	0x48
	.4byte	0x1bc
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x8
	.asciz	"psCheckVariable"
	.byte	0x1
	.byte	0x49
	.4byte	0x25f
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	0x265
	.uleb128 0xa
	.4byte	0x19c
	.uleb128 0x3
	.asciz	"xBlockingQueueParameters"
	.byte	0x1
	.byte	0x4a
	.4byte	0x203
	.uleb128 0xb
	.asciz	"vBlockingQueueProducer"
	.byte	0x1
	.byte	0xb0
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x2eb
	.uleb128 0xc
	.4byte	.LASF2
	.byte	0x1
	.byte	0xb0
	.4byte	0x188
	.byte	0x1
	.byte	0x50
	.uleb128 0xd
	.asciz	"usValue"
	.byte	0x1
	.byte	0xb2
	.4byte	0x149
	.byte	0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0xe
	.4byte	.LASF1
	.byte	0x1
	.byte	0xb3
	.4byte	0x2eb
	.byte	0x1
	.byte	0x58
	.uleb128 0xf
	.4byte	.LASF3
	.byte	0x1
	.byte	0xb4
	.4byte	0x19c
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	0x26a
	.uleb128 0xb
	.asciz	"vBlockingQueueConsumer"
	.byte	0x1
	.byte	0xd3
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x36a
	.uleb128 0xc
	.4byte	.LASF2
	.byte	0x1
	.byte	0xd3
	.4byte	0x188
	.byte	0x1
	.byte	0x50
	.uleb128 0xd
	.asciz	"usData"
	.byte	0x1
	.byte	0xd5
	.4byte	0x149
	.byte	0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x10
	.asciz	"usExpectedValue"
	.byte	0x1
	.byte	0xd5
	.4byte	0x149
	.uleb128 0xe
	.4byte	.LASF1
	.byte	0x1
	.byte	0xd6
	.4byte	0x2eb
	.byte	0x1
	.byte	0x58
	.uleb128 0xe
	.4byte	.LASF3
	.byte	0x1
	.byte	0xd7
	.4byte	0x19c
	.byte	0x1
	.byte	0x5a
	.byte	0x0
	.uleb128 0x11
	.byte	0x1
	.asciz	"vStartBlockingQueueTasks"
	.byte	0x1
	.byte	0x5e
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0x48c
	.uleb128 0x12
	.asciz	"uxPriority"
	.byte	0x1
	.byte	0x5e
	.4byte	0x1a9
	.byte	0x1
	.byte	0x5c
	.uleb128 0x10
	.asciz	"pxQueueParameters1"
	.byte	0x1
	.byte	0x60
	.4byte	0x2eb
	.uleb128 0x10
	.asciz	"pxQueueParameters2"
	.byte	0x1
	.byte	0x60
	.4byte	0x2eb
	.uleb128 0x10
	.asciz	"pxQueueParameters3"
	.byte	0x1
	.byte	0x61
	.4byte	0x2eb
	.uleb128 0x10
	.asciz	"pxQueueParameters4"
	.byte	0x1
	.byte	0x61
	.4byte	0x2eb
	.uleb128 0x10
	.asciz	"pxQueueParameters5"
	.byte	0x1
	.byte	0x62
	.4byte	0x2eb
	.uleb128 0x10
	.asciz	"pxQueueParameters6"
	.byte	0x1
	.byte	0x62
	.4byte	0x2eb
	.uleb128 0x10
	.asciz	"uxQueueSize1"
	.byte	0x1
	.byte	0x63
	.4byte	0x48c
	.uleb128 0x10
	.asciz	"uxQueueSize5"
	.byte	0x1
	.byte	0x63
	.4byte	0x48c
	.uleb128 0xf
	.4byte	.LASF0
	.byte	0x1
	.byte	0x64
	.4byte	0x491
	.uleb128 0x10
	.asciz	"xDontBlock"
	.byte	0x1
	.byte	0x65
	.4byte	0x491
	.byte	0x0
	.uleb128 0x13
	.4byte	0x1a9
	.uleb128 0x13
	.4byte	0x1bc
	.uleb128 0x14
	.byte	0x1
	.asciz	"xAreBlockingQueuesStillRunning"
	.byte	0x1
	.2byte	0x102
	.byte	0x1
	.4byte	0x18a
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x543
	.uleb128 0x15
	.asciz	"sLastBlockingConsumerCount"
	.byte	0x1
	.2byte	0x104
	.4byte	0x543
	.byte	0x5
	.byte	0x3
	.4byte	_sLastBlockingConsumerCount.9901
	.uleb128 0x15
	.asciz	"sLastBlockingProducerCount"
	.byte	0x1
	.2byte	0x105
	.4byte	0x543
	.byte	0x5
	.byte	0x3
	.4byte	_sLastBlockingProducerCount.9902
	.uleb128 0x15
	.asciz	"xReturn"
	.byte	0x1
	.2byte	0x106
	.4byte	0x18a
	.byte	0x1
	.byte	0x50
	.uleb128 0x15
	.asciz	"xTasks"
	.byte	0x1
	.2byte	0x106
	.4byte	0x18a
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x16
	.4byte	0x19c
	.4byte	0x553
	.uleb128 0x17
	.4byte	0xe6
	.byte	0x2
	.byte	0x0
	.uleb128 0xd
	.asciz	"sBlockingConsumerCount"
	.byte	0x1
	.byte	0x56
	.4byte	0x577
	.byte	0x5
	.byte	0x3
	.4byte	_sBlockingConsumerCount
	.uleb128 0xa
	.4byte	0x543
	.uleb128 0xd
	.asciz	"sBlockingProducerCount"
	.byte	0x1
	.byte	0x5a
	.4byte	0x5a0
	.byte	0x5
	.byte	0x3
	.4byte	_sBlockingProducerCount
	.uleb128 0xa
	.4byte	0x543
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
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
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
	.uleb128 0xf
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
	.uleb128 0x15
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x4e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x5a6
	.4byte	0x36a
	.asciz	"vStartBlockingQueueTasks"
	.4byte	0x496
	.asciz	"xAreBlockingQueuesStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0xa2
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x5a6
	.4byte	0x129
	.asciz	"uint8_t"
	.4byte	0x149
	.asciz	"uint16_t"
	.4byte	0x18a
	.asciz	"BaseType_t"
	.4byte	0x1a9
	.asciz	"UBaseType_t"
	.4byte	0x1bc
	.asciz	"TickType_t"
	.4byte	0x1d6
	.asciz	"QueueHandle_t"
	.4byte	0x203
	.asciz	"BLOCKING_QUEUE_PARAMETERS"
	.4byte	0x26a
	.asciz	"xBlockingQueueParameters"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x34
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
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF2:
	.asciz	"pvParameters"
.LASF3:
	.asciz	"sErrorEverOccurred"
.LASF0:
	.asciz	"xBlockTime"
.LASF1:
	.asciz	"pxQueueParameters"
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
