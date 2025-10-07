	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\Common\\Minimal\\BlockQ.c"
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
	.file 1 "../../Common/Minimal/BlockQ.c"
	.loc 1 177 0
	.set ___PA___,1
	lnk	#2
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov	w0,w8
	.loc 1 178 0
	clr	w0
	mov	w0,[w15-6]
	.loc 1 180 0
	mov	w0,w9
.L6:
	.loc 1 186 0
	mov	[w8+2],w2
	clr	w3
	sub	w15,#6,w1
	mov	[w8],w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,9
	bra	z,.L8
.L5:
	.loc 1 188 0
	mov	#1,w9
	.loc 1 186 0
	mov	[w8+2],w2
	clr	w3
	sub	w15,#6,w1
	mov	[w8],w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,91
	bra	nz,.L5
.L8:
	.loc 1 194 0
	cp0	w9
	.set ___BP___,50
	bra	nz,.L3
	.loc 1 196 0
	mov	[w8+4],w0
	inc	[w0],[w0]
.L3:
	.loc 1 201 0
	mov	[w15-6],w0
	inc	w0,w0
	mov	w0,[w15-6]
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
.LCFI2:
	mov.d	w8,[w15++]
.LCFI3:
	mov	w10,[w15++]
.LCFI4:
	mov	w0,w8
	.loc 1 215 0
	clr	w10
	.loc 1 213 0
	mov	w10,w9
.L17:
	.loc 1 221 0
	mov	[w8+2],w2
	sub	w15,#8,w1
	mov	[w8],w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L17
.L20:
	.loc 1 223 0
	mov	[w15-8],w1
	sub	w1,w9,[w15]
	.set ___BP___,28
	bra	z,.L19
	mov	w1,w9
	.loc 1 228 0
	mov	w0,w10
	.loc 1 221 0
	mov	[w8+2],w2
	sub	w15,#8,w1
	mov	[w8],w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L17
	bra	.L20
.L19:
	.loc 1 234 0
	cp0	w10
	.set ___BP___,50
	bra	nz,.L13
	.loc 1 236 0
	mov	[w8+4],w0
	inc	[w0],[w0]
.L13:
	.loc 1 241 0
	inc	w1,w9
	.loc 1 221 0
	mov	[w8+2],w2
	sub	w15,#8,w1
	mov	[w8],w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L17
	bra	.L20
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
.LCFI5:
	mov.d	w10,[w15++]
.LCFI6:
	mov	w12,[w15++]
.LCFI7:
	mov	w0,w11
	.loc 1 106 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w12
	.loc 1 110 0
	clr.b	w2
	mov	#2,w1
	mov	#1,w0
	rcall	_xQueueGenericCreate
	mov	w0,[w12]
	.loc 1 113 0
	mov	#1000,w8
	mov	w8,[w12+2]
	.loc 1 117 0
	mov	#_sBlockingConsumerCount,w0
	mov	w0,[w12+4]
	.loc 1 120 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 123 0
	mov	[w12],[w9]
	.loc 1 127 0
	clr	w10
	mov	w10,[w9+2]
	.loc 1 131 0
	mov	#_sBlockingProducerCount,w0
	mov	w0,[w9+4]
	.loc 1 136 0
	mov	w10,w5
	mov	w11,w4
	mov	w12,w3
	mov	#105,w2
	mov	#.LC0,w1
	mov	#handle(_vBlockingQueueConsumer),w0
	rcall	_xTaskCreate
	.loc 1 137 0
	mov	w10,w5
	mov	w10,w4
	mov	w9,w3
	mov	#105,w2
	mov	#.LC1,w1
	mov	#handle(_vBlockingQueueProducer),w0
	rcall	_xTaskCreate
	.loc 1 144 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w12
	.loc 1 145 0
	clr.b	w2
	mov	#2,w1
	mov	#1,w0
	rcall	_xQueueGenericCreate
	mov	w0,[w12]
	.loc 1 146 0
	mov	w10,[w12+2]
	.loc 1 147 0
	mov	#_sBlockingProducerCount+2,w0
	mov	w0,[w12+4]
	.loc 1 149 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 150 0
	mov	[w12],[w9]
	.loc 1 151 0
	mov	w8,[w9+2]
	.loc 1 152 0
	mov	#_sBlockingConsumerCount+2,w0
	mov	w0,[w9+4]
	.loc 1 154 0
	mov	w10,w5
	mov	w10,w4
	mov	w12,w3
	mov	#105,w2
	mov	#.LC2,w1
	mov	#handle(_vBlockingQueueConsumer),w0
	rcall	_xTaskCreate
	.loc 1 155 0
	mov	w10,w5
	mov	w11,w4
	mov	w9,w3
	mov	#105,w2
	mov	#.LC3,w1
	mov	#handle(_vBlockingQueueProducer),w0
	rcall	_xTaskCreate
	.loc 1 161 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w10
	.loc 1 162 0
	clr.b	w2
	mov	#2,w1
	mov	#5,w0
	rcall	_xQueueGenericCreate
	mov	w0,[w10]
	.loc 1 163 0
	mov	w8,[w10+2]
	.loc 1 164 0
	mov	#_sBlockingProducerCount+4,w0
	mov	w0,[w10+4]
	.loc 1 166 0
	mov	#6,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 167 0
	mov	[w10],[w9]
	.loc 1 168 0
	mov	w8,[w9+2]
	.loc 1 169 0
	mov	#_sBlockingConsumerCount+4,w0
	mov	w0,[w9+4]
	.loc 1 171 0
	clr	w5
	mov	w5,w4
	mov	w10,w3
	mov	#105,w2
	mov	#.LC4,w1
	mov	#handle(_vBlockingQueueProducer),w0
	rcall	_xTaskCreate
	.loc 1 172 0
	clr	w5
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
	.loc 1 282 0
	mov	#_sLastBlockingConsumerCount.17177,w3
	mov	#_sLastBlockingProducerCount.17178,w4
	.loc 1 271 0
	clr	w1
	.loc 1 262 0
	mov	#1,w0
	mov	#_sBlockingConsumerCount,w6
	mov	#_sBlockingProducerCount,w5
.L28:
	.loc 1 273 0
	add	w1,w1,w2
	add	w6,w2,w7
	mov	[w7],w7
	sub	w7,[w3],[w15]
	.set ___BP___,28
	bra	z,.L33
	.loc 1 278 0
	add	w6,w2,w7
	mov	[w7],[w3]
	.loc 1 280 0
	add	w5,w2,w7
	mov	[w7],w7
	sub	w7,[w4],[w15]
	.set ___BP___,28
	bra	z,.L34
.L27:
	.loc 1 285 0
	add	w5,w2,w2
	mov	[w2],[w4++]
	.loc 1 271 0
	inc	w1,w1
	inc2	w3,w3
	sub	w1,#3,[w15]
	.set ___BP___,66
	bra	nz,.L28
.L35:
	.loc 1 289 0
	return	
	.set ___PA___,0
.L34:
	.loc 1 282 0
	clr	w0
	.loc 1 285 0
	add	w5,w2,w2
	mov	[w2],[w4++]
	.loc 1 271 0
	inc	w1,w1
	inc2	w3,w3
	sub	w1,#3,[w15]
	.set ___BP___,66
	bra	nz,.L28
	bra	.L35
.L33:
	.loc 1 275 0
	clr	w0
	.loc 1 278 0
	add	w6,w2,w7
	mov	[w7],[w3]
	.loc 1 280 0
	add	w5,w2,w7
	mov	[w7],w7
	sub	w7,[w4],[w15]
	.set ___BP___,72
	bra	nz,.L27
	bra	.L34
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
	.type	_sLastBlockingProducerCount.17178,@object
	.size	_sLastBlockingProducerCount.17178, 6
_sLastBlockingProducerCount.17178:
	.skip	6
	.align	2
	.type	_sLastBlockingConsumerCount.17177,@object
	.size	_sLastBlockingConsumerCount.17177, 6
_sLastBlockingConsumerCount.17177:
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
	.4byte	.LCFI1-.LCFI0
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
	.4byte	.LCFI2-.LFB2
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI4-.LCFI2
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
	.4byte	.LCFI5-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
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
	.align	4
.LEFDE6:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../../Source/include/queue.h"
	.section	.debug_info,info
	.4byte	0x602
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../Common/Minimal/BlockQ.c"
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
	.4byte	0x19a
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x148
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
	.4byte	0x1fe
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x132
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x1ab
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"QueueHandle_t"
	.byte	0x4
	.byte	0x33
	.4byte	0x24d
	.uleb128 0x5
	.byte	0x2
	.4byte	0x253
	.uleb128 0x6
	.asciz	"QueueDefinition"
	.byte	0x1
	.uleb128 0x7
	.asciz	"BLOCKING_QUEUE_PARAMETERS"
	.byte	0x6
	.byte	0x1
	.byte	0x45
	.4byte	0x2c1
	.uleb128 0x8
	.asciz	"xQueue"
	.byte	0x1
	.byte	0x47
	.4byte	0x238
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x9
	.4byte	.LASF0
	.byte	0x1
	.byte	0x48
	.4byte	0x21e
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x8
	.asciz	"psCheckVariable"
	.byte	0x1
	.byte	0x49
	.4byte	0x2c1
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	0x2c7
	.uleb128 0xa
	.4byte	0x1fe
	.uleb128 0x3
	.asciz	"xBlockingQueueParameters"
	.byte	0x1
	.byte	0x4a
	.4byte	0x265
	.uleb128 0xb
	.asciz	"vBlockingQueueProducer"
	.byte	0x1
	.byte	0xb0
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x34b
	.uleb128 0xc
	.4byte	.LASF3
	.byte	0x1
	.byte	0xb0
	.4byte	0x1ea
	.byte	0x1
	.byte	0x58
	.uleb128 0xd
	.asciz	"usValue"
	.byte	0x1
	.byte	0xb2
	.4byte	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -6
	.uleb128 0xe
	.4byte	.LASF1
	.byte	0x1
	.byte	0xb3
	.4byte	0x34b
	.uleb128 0xe
	.4byte	.LASF2
	.byte	0x1
	.byte	0xb4
	.4byte	0x1fe
	.byte	0x0
	.uleb128 0x5
	.byte	0x2
	.4byte	0x2cc
	.uleb128 0xb
	.asciz	"vBlockingQueueConsumer"
	.byte	0x1
	.byte	0xd3
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x3ca
	.uleb128 0xc
	.4byte	.LASF3
	.byte	0x1
	.byte	0xd3
	.4byte	0x1ea
	.byte	0x1
	.byte	0x50
	.uleb128 0xd
	.asciz	"usData"
	.byte	0x1
	.byte	0xd5
	.4byte	0x1ab
	.byte	0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0xf
	.asciz	"usExpectedValue"
	.byte	0x1
	.byte	0xd5
	.4byte	0x1ab
	.uleb128 0x10
	.4byte	.LASF1
	.byte	0x1
	.byte	0xd6
	.4byte	0x34b
	.byte	0x1
	.byte	0x58
	.uleb128 0x10
	.4byte	.LASF2
	.byte	0x1
	.byte	0xd7
	.4byte	0x1fe
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
	.4byte	0x4ec
	.uleb128 0x12
	.asciz	"uxPriority"
	.byte	0x1
	.byte	0x5e
	.4byte	0x20b
	.byte	0x1
	.byte	0x5b
	.uleb128 0xf
	.asciz	"pxQueueParameters1"
	.byte	0x1
	.byte	0x60
	.4byte	0x34b
	.uleb128 0xf
	.asciz	"pxQueueParameters2"
	.byte	0x1
	.byte	0x60
	.4byte	0x34b
	.uleb128 0xf
	.asciz	"pxQueueParameters3"
	.byte	0x1
	.byte	0x61
	.4byte	0x34b
	.uleb128 0xf
	.asciz	"pxQueueParameters4"
	.byte	0x1
	.byte	0x61
	.4byte	0x34b
	.uleb128 0xf
	.asciz	"pxQueueParameters5"
	.byte	0x1
	.byte	0x62
	.4byte	0x34b
	.uleb128 0xf
	.asciz	"pxQueueParameters6"
	.byte	0x1
	.byte	0x62
	.4byte	0x34b
	.uleb128 0xf
	.asciz	"uxQueueSize1"
	.byte	0x1
	.byte	0x63
	.4byte	0x4ec
	.uleb128 0xf
	.asciz	"uxQueueSize5"
	.byte	0x1
	.byte	0x63
	.4byte	0x4ec
	.uleb128 0xe
	.4byte	.LASF0
	.byte	0x1
	.byte	0x64
	.4byte	0x4f1
	.uleb128 0xf
	.asciz	"xDontBlock"
	.byte	0x1
	.byte	0x65
	.4byte	0x4f1
	.byte	0x0
	.uleb128 0x13
	.4byte	0x20b
	.uleb128 0x13
	.4byte	0x21e
	.uleb128 0x14
	.byte	0x1
	.asciz	"xAreBlockingQueuesStillRunning"
	.byte	0x1
	.2byte	0x102
	.byte	0x1
	.4byte	0x1ec
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x5a3
	.uleb128 0x15
	.asciz	"sLastBlockingConsumerCount"
	.byte	0x1
	.2byte	0x104
	.4byte	0x5a3
	.byte	0x5
	.byte	0x3
	.4byte	_sLastBlockingConsumerCount.17177
	.uleb128 0x15
	.asciz	"sLastBlockingProducerCount"
	.byte	0x1
	.2byte	0x105
	.4byte	0x5a3
	.byte	0x5
	.byte	0x3
	.4byte	_sLastBlockingProducerCount.17178
	.uleb128 0x15
	.asciz	"xReturn"
	.byte	0x1
	.2byte	0x106
	.4byte	0x1ec
	.byte	0x1
	.byte	0x50
	.uleb128 0x15
	.asciz	"xTasks"
	.byte	0x1
	.2byte	0x106
	.4byte	0x1ec
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x16
	.4byte	0x1fe
	.4byte	0x5b3
	.uleb128 0x17
	.4byte	0x148
	.byte	0x2
	.byte	0x0
	.uleb128 0xd
	.asciz	"sBlockingConsumerCount"
	.byte	0x1
	.byte	0x56
	.4byte	0x5d7
	.byte	0x5
	.byte	0x3
	.4byte	_sBlockingConsumerCount
	.uleb128 0xa
	.4byte	0x5a3
	.uleb128 0xd
	.asciz	"sBlockingProducerCount"
	.byte	0x1
	.byte	0x5a
	.4byte	0x600
	.byte	0x5
	.byte	0x3
	.4byte	_sBlockingProducerCount
	.uleb128 0xa
	.4byte	0x5a3
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
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
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
	.uleb128 0x10
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
	.4byte	0x606
	.4byte	0x3ca
	.asciz	"vStartBlockingQueueTasks"
	.4byte	0x4f6
	.asciz	"xAreBlockingQueuesStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0xa2
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x606
	.4byte	0x18b
	.asciz	"uint8_t"
	.4byte	0x1ab
	.asciz	"uint16_t"
	.4byte	0x1ec
	.asciz	"BaseType_t"
	.4byte	0x20b
	.asciz	"UBaseType_t"
	.4byte	0x21e
	.asciz	"TickType_t"
	.4byte	0x238
	.asciz	"QueueHandle_t"
	.4byte	0x265
	.asciz	"BLOCKING_QUEUE_PARAMETERS"
	.4byte	0x2cc
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
.LASF3:
	.asciz	"pvParameters"
.LASF2:
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
