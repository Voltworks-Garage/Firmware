	.file "C:\\REPOS\\Voltworks_Garage\\Firmware\\Projects\\RTOS_DEV.X\\..\\..\\RTOS\\FreeRTOS\\Demo\\Common\\Minimal\\blocktim.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.vSecondaryBlockTimeTestTask,code
	.align	2
	.type	_vSecondaryBlockTimeTestTask,@function
_vSecondaryBlockTimeTestTask:
.LFB2:
	.file 1 "../../RTOS/FreeRTOS/Demo/Common/Minimal/blocktim.c"
	.loc 1 385 0
	.set ___PA___,1
	lnk	#2
.LCFI0:
	mov.d	w8,[w15++]
.LCFI1:
	mov	w10,[w15++]
.LCFI2:
	.loc 1 410 0
	mov	#85,w8
	.loc 1 421 0
	mov	#174,w10
.L8:
	.loc 1 397 0
	clr	w0
	rcall	_vTaskSuspend
	.loc 1 405 0
	rcall	_xTaskGetTickCount
	mov	w0,w9
	.loc 1 409 0
	clr	w0
	mov	w0,[w15-8]
	.loc 1 410 0
	mov	w8,_xRunIndicator
	.loc 1 412 0
	mov	w0,w3
	mov	#175,w2
	sub	w15,#8,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	cp0	w0
	.set ___BP___,50
	bra	z,.L2
	.loc 1 414 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L2:
	.loc 1 418 0
	rcall	_xTaskGetTickCount
	sub	w0,w9,w9
	.loc 1 421 0
	sub	w9,w10,[w15]
	.set ___BP___,50
	bra	gtu,.L3
	.loc 1 423 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L3:
	.loc 1 429 0
	mov	#190,w0
	sub	w9,w0,[w15]
	.set ___BP___,50
	bra	leu,.L4
	.loc 1 431 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L4:
	.loc 1 435 0
	mov	w8,_xRunIndicator
	.loc 1 436 0
	clr	w0
	rcall	_vTaskSuspend
	.loc 1 442 0
	rcall	_xTaskGetTickCount
	mov	w0,w9
	.loc 1 446 0
	mov	w8,_xRunIndicator
	.loc 1 448 0
	mov	#175,w2
	sub	w15,#8,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	cp0	w0
	.set ___BP___,50
	bra	z,.L5
	.loc 1 450 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L5:
	.loc 1 453 0
	rcall	_xTaskGetTickCount
	sub	w0,w9,w9
	.loc 1 456 0
	sub	w9,w10,[w15]
	.set ___BP___,50
	bra	gtu,.L6
	.loc 1 458 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L6:
	.loc 1 464 0
	mov	#190,w0
	sub	w9,w0,[w15]
	.set ___BP___,50
	bra	leu,.L7
	.loc 1 466 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L7:
	.loc 1 469 0
	mov	w8,_xRunIndicator
	.loc 1 471 0
	inc	_xSecondaryCycles
	.loc 1 472 0
	bra	.L8
.LFE2:
	.size	_vSecondaryBlockTimeTestTask, .-_vSecondaryBlockTimeTestTask
	.section	.text.prvBasicDelayTests,code
	.align	2
	.type	_prvBasicDelayTests,@function
_prvBasicDelayTests:
.LFB3:
	.loc 1 477 0
	.set ___PA___,1
	lnk	#2
.LCFI3:
	mov.d	w8,[w15++]
.LCFI4:
	mov.d	w10,[w15++]
.LCFI5:
	.loc 1 484 0
	mov	#2,w1
	clr	w0
	rcall	_vTaskPrioritySet
	.loc 1 488 0
	rcall	_xTaskGetTickCount
	mov	w0,w8
	.loc 1 489 0
	mov	#175,w0
	rcall	_vTaskDelay
	.loc 1 490 0
	rcall	_xTaskGetTickCount
	.loc 1 494 0
	sub	w0,w8,w8
	mov	#182,w1
	sub	w8,w1,[w15]
	.set ___BP___,50
	bra	leu,.L10
	.loc 1 496 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L10:
	.loc 1 500 0
	rcall	_xTaskGetTickCount
	mov	w0,w9
	.loc 1 501 0
	mov	w9,[w15-10]
	clr	w8
	.loc 1 511 0
	mov	#182,w10
	.loc 1 503 0
	mov	#375,w11
.L12:
	.loc 1 509 0
	mov	#75,w1
	sub	w15,#10,w0
	rcall	_xTaskDelayUntil
	.loc 1 511 0
	rcall	_xTaskGetTickCount
	.loc 1 507 0
	sub	w0,w9,w0
	.loc 1 511 0
	sub	w0,w8,w0
	sub	w0,w10,[w15]
	.set ___BP___,50
	bra	leu,.L11
	.loc 1 513 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L11:
	.loc 1 516 0
	inc	_xPrimaryCycles
	add	#75,w8
	.loc 1 503 0
	sub	w8,w11,[w15]
	.set ___BP___,83
	bra	nz,.L12
	.loc 1 521 0
	mov	#75,w1
	sub	w15,#10,w0
	rcall	_xTaskDelayUntil
	.loc 1 523 0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L13
	.loc 1 525 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L13:
	.loc 1 530 0
	mov	#37,w0
	rcall	_vTaskDelay
	.loc 1 531 0
	mov	#75,w1
	sub	w15,#10,w0
	rcall	_xTaskDelayUntil
	.loc 1 533 0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L14
	.loc 1 535 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L14:
	.loc 1 540 0
	mov	#75,w0
	rcall	_vTaskDelay
	.loc 1 541 0
	mov	#75,w1
	sub	w15,#10,w0
	rcall	_xTaskDelayUntil
	.loc 1 543 0
	cp0	w0
	.set ___BP___,50
	bra	z,.L15
	.loc 1 545 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L15:
	.loc 1 549 0
	mov	#75,w1
	sub	w15,#10,w0
	rcall	_xTaskDelayUntil
	.loc 1 551 0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L16
	.loc 1 553 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L16:
	.loc 1 558 0
	mov	#82,w0
	rcall	_vTaskDelay
	.loc 1 559 0
	mov	#75,w1
	sub	w15,#10,w0
	rcall	_xTaskDelayUntil
	.loc 1 561 0
	cp0	w0
	.set ___BP___,39
	bra	z,.L17
	.loc 1 563 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L17:
	.loc 1 567 0
	mov	#1,w1
	clr	w0
	rcall	_vTaskPrioritySet
	.loc 1 568 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	.set ___PA___,0
.LFE3:
	.size	_prvBasicDelayTests, .-_prvBasicDelayTests
	.section	.text.vPrimaryBlockTimeTestTask,code
	.align	2
	.type	_vPrimaryBlockTimeTestTask,@function
_vPrimaryBlockTimeTestTask:
.LFB1:
	.loc 1 124 0
	.set ___PA___,1
	lnk	#4
.LCFI6:
	mov.d	w8,[w15++]
.LCFI7:
	mov.d	w10,[w15++]
.LCFI8:
	mov	w12,[w15++]
.LCFI9:
	.loc 1 243 0
	mov	#85,w9
.L50:
	.loc 1 137 0
	rcall	_prvBasicDelayTests
	.loc 1 143 0
	clr	w0
	mov	w0,[w15-14]
	mov	w0,w8
	.loc 1 147 0
	mov	#10,w11
.L23:
	sl	w11,w8,w8
	.loc 1 149 0
	rcall	_xTaskGetTickCount
	mov	w0,w10
	.loc 1 153 0
	mov	w8,w2
	sub	w15,#12,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	cp0	w0
	.set ___BP___,50
	bra	z,.L20
	.loc 1 155 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L20:
	.loc 1 159 0
	rcall	_xTaskGetTickCount
	sub	w0,w10,w10
	.loc 1 161 0
	sub	w8,w10,[w15]
	.set ___BP___,50
	bra	leu,.L21
	.loc 1 164 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L21:
	.loc 1 167 0
	add	w8,#15,w8
	sub	w10,w8,[w15]
	.set ___BP___,50
	bra	leu,.L22
	.loc 1 172 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L22:
	.loc 1 143 0
	mov	[w15-14],w1
	inc	w1,w8
	mov	w8,[w15-14]
	sub	w8,#4,[w15]
	.set ___BP___,91
	bra	le,.L23
	.loc 1 182 0
	clr	w0
	mov	w0,[w15-14]
	.loc 1 184 0
	mov	w0,w8
	.loc 1 186 0
	mov	#1,w10
.L25:
	.loc 1 184 0
	mov	w8,w3
	mov	w8,w2
	sub	w15,#14,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L24
	.loc 1 186 0
	mov	w10,_xErrorOccurred
.L24:
	.loc 1 182 0
	mov	[w15-14],w1
	inc	w1,w0
	mov	w0,[w15-14]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L25
	.loc 1 194 0
	clr	w0
	mov	w0,[w15-14]
	mov	w0,w8
	.loc 1 198 0
	mov	#10,w12
	.loc 1 206 0
	mov	#1,w11
.L29:
	.loc 1 198 0
	sl	w12,w8,w8
	.loc 1 200 0
	rcall	_xTaskGetTickCount
	mov	w0,w10
	.loc 1 204 0
	clr	w3
	mov	w8,w2
	sub	w15,#14,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	cp0	w0
	.set ___BP___,50
	bra	z,.L26
	.loc 1 206 0
	mov	w11,_xErrorOccurred
.L26:
	.loc 1 210 0
	rcall	_xTaskGetTickCount
	sub	w0,w10,w10
	.loc 1 212 0
	sub	w8,w10,[w15]
	.set ___BP___,50
	bra	leu,.L27
	.loc 1 215 0
	mov	w11,_xErrorOccurred
.L27:
	.loc 1 218 0
	add	w8,#15,w8
	sub	w10,w8,[w15]
	.set ___BP___,50
	bra	leu,.L28
	.loc 1 223 0
	mov	w11,_xErrorOccurred
.L28:
	.loc 1 194 0
	mov	[w15-14],w1
	inc	w1,w8
	mov	w8,[w15-14]
	sub	w8,#4,[w15]
	.set ___BP___,91
	bra	le,.L29
	.loc 1 239 0
	clr	_xRunIndicator
	.loc 1 240 0
	mov	_xSecondary,w0
	rcall	_vTaskResume
	.loc 1 243 0
	mov	_xRunIndicator,w0
	sub	w0,w9,[w15]
	.set ___BP___,9
	bra	z,.L30
	.loc 1 246 0
	mov	#20,w8
.L54:
	mov	w8,w0
	rcall	_vTaskDelay
	.loc 1 243 0
	mov	_xRunIndicator,w1
	sub	w1,w9,[w15]
	.set ___BP___,91
	bra	nz,.L54
.L30:
	.loc 1 250 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 251 0
	clr	_xRunIndicator
	.loc 1 253 0
	clr	w0
	mov	w0,[w15-14]
.L36:
	.loc 1 257 0
	clr	w2
	sub	w15,#12,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L32
	.loc 1 259 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L32:
	.loc 1 265 0
	clr	w3
	mov	w3,w2
	sub	w15,#14,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L33
	.loc 1 267 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L33:
	.loc 1 270 0
	mov	_xRunIndicator,w1
	sub	w1,w9,[w15]
	.set ___BP___,72
	bra	nz,.L34
	.loc 1 273 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L34:
	.loc 1 278 0
	mov	#3,w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 282 0
	mov	_xRunIndicator,w0
	sub	w0,w9,[w15]
	.set ___BP___,72
	bra	nz,.L35
	.loc 1 286 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L35:
	.loc 1 290 0
	clr	w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 253 0
	mov	[w15-14],w1
	inc	w1,w0
	mov	w0,[w15-14]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L36
	.loc 1 295 0
	mov	_xRunIndicator,w0
	sub	w0,w9,[w15]
	.set ___BP___,9
	bra	z,.L37
	.loc 1 297 0
	mov	#20,w8
.L53:
	mov	w8,w0
	rcall	_vTaskDelay
	.loc 1 295 0
	mov	_xRunIndicator,w1
	sub	w1,w9,[w15]
	.set ___BP___,91
	bra	nz,.L53
.L37:
	.loc 1 300 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 301 0
	clr	_xRunIndicator
	.loc 1 310 0
	clr	w0
	mov	w0,[w15-14]
	.loc 1 314 0
	mov	#1,w8
.L40:
	.loc 1 312 0
	clr	w2
	sub	w15,#12,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L39
	.loc 1 314 0
	mov	w8,_xErrorOccurred
.L39:
	.loc 1 310 0
	mov	[w15-14],w1
	inc	w1,w0
	mov	w0,[w15-14]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L40
	.loc 1 320 0
	mov	_xSecondary,w0
	rcall	_vTaskResume
	.loc 1 323 0
	mov	_xRunIndicator,w0
	sub	w0,w9,[w15]
	.set ___BP___,9
	bra	z,.L41
	.loc 1 325 0
	mov	#20,w8
.L52:
	mov	w8,w0
	rcall	_vTaskDelay
	.loc 1 323 0
	mov	_xRunIndicator,w1
	sub	w1,w9,[w15]
	.set ___BP___,91
	bra	nz,.L52
.L41:
	.loc 1 328 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 329 0
	clr	_xRunIndicator
	.loc 1 331 0
	clr	w0
	mov	w0,[w15-14]
.L47:
	.loc 1 335 0
	clr	w3
	mov	w3,w2
	sub	w15,#14,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L43
	.loc 1 337 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L43:
	.loc 1 343 0
	clr	w2
	sub	w15,#12,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L44
	.loc 1 345 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L44:
	.loc 1 348 0
	mov	_xRunIndicator,w1
	sub	w1,w9,[w15]
	.set ___BP___,72
	bra	nz,.L45
	.loc 1 351 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L45:
	.loc 1 356 0
	mov	#3,w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 360 0
	mov	_xRunIndicator,w0
	sub	w0,w9,[w15]
	.set ___BP___,72
	bra	nz,.L46
	.loc 1 364 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L46:
	.loc 1 367 0
	clr	w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 331 0
	mov	[w15-14],w1
	inc	w1,w0
	mov	w0,[w15-14]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L47
	.loc 1 372 0
	mov	_xRunIndicator,w0
	sub	w0,w9,[w15]
	.set ___BP___,9
	bra	z,.L48
	.loc 1 374 0
	mov	#20,w8
.L51:
	mov	w8,w0
	rcall	_vTaskDelay
	.loc 1 372 0
	mov	_xRunIndicator,w1
	sub	w1,w9,[w15]
	.set ___BP___,91
	bra	nz,.L51
.L48:
	.loc 1 377 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 379 0
	inc	_xPrimaryCycles
	.loc 1 380 0
	bra	.L50
.LFE1:
	.size	_vPrimaryBlockTimeTestTask, .-_vPrimaryBlockTimeTestTask
	.section	.const,psv,page
.LC0:
	.asciz	"BTest1"
.LC1:
	.asciz	"BTest2"
	.section	.text.vCreateBlockTimeTasks,code
	.align	2
	.global	_vCreateBlockTimeTasks	; export
	.type	_vCreateBlockTimeTasks,@function
_vCreateBlockTimeTasks:
.LFB0:
	.loc 1 102 0
	.set ___PA___,1
	.loc 1 104 0
	clr.b	w2
	mov	#2,w1
	mov	#5,w0
	rcall	_xQueueGenericCreate
	mov	w0,_xTestQueue
	.loc 1 106 0
	cp0	w0
	.set ___BP___,21
	bra	z,.L65
	.loc 1 117 0
	clr	w5
	mov	#1,w4
	mov	w5,w3
	mov	#105,w2
	mov	#.LC0,w1
	mov	#handle(_vPrimaryBlockTimeTestTask),w0
	rcall	_xTaskCreate
	.loc 1 118 0
	mov	#_xSecondary,w5
	clr	w4
	mov	w4,w3
	mov	#105,w2
	mov	#.LC1,w1
	mov	#handle(_vSecondaryBlockTimeTestTask),w0
	rcall	_xTaskCreate
.L65:
	.loc 1 120 0
	return	
	.set ___PA___,0
.LFE0:
	.size	_vCreateBlockTimeTasks, .-_vCreateBlockTimeTasks
	.section	.text.xAreBlockTimeTestTasksStillRunning,code
	.align	2
	.global	_xAreBlockTimeTestTasksStillRunning	; export
	.type	_xAreBlockTimeTestTasksStillRunning,@function
_xAreBlockTimeTestTasksStillRunning:
.LFB4:
	.loc 1 572 0
	.set ___PA___,1
	.loc 1 578 0
	mov	_xPrimaryCycles,w3
	mov	_xLastPrimaryCycleCount.9718,w2
	.loc 1 585 0
	clr	w0
	.loc 1 583 0
	mov	_xLastSecondaryCycleCount.9719,w1
	mov	_xSecondaryCycles,w4
	sub	w4,w1,[w15]
	.set ___BP___,28
	bra	z,.L68
	.loc 1 574 0
	xor	w3,w2,w2
	btsc	w2,#15
	neg	w2,w2
	neg	w2,w0
	lsr	w0,#15,w0
.L68:
	.loc 1 588 0
	mov	_xErrorOccurred,w1
	sub	w1,#1,[w15]
	.set ___BP___,62
	bra	nz,.L69
	.loc 1 590 0
	clr	w0
.L69:
	.loc 1 593 0
	mov	_xSecondaryCycles,w1
	mov	w1,_xLastSecondaryCycleCount.9719
	.loc 1 594 0
	mov	_xPrimaryCycles,w4
	mov	w4,_xLastPrimaryCycleCount.9718
	.loc 1 597 0
	return	
	.set ___PA___,0
.LFE4:
	.size	_xAreBlockTimeTestTasksStillRunning, .-_xAreBlockTimeTestTasksStillRunning
	.section	.nbss,bss,near
	.align	2
	.type	_xPrimaryCycles,@object
	.size	_xPrimaryCycles, 2
_xPrimaryCycles:
	.skip	2
	.align	2
	.type	_xSecondaryCycles,@object
	.size	_xSecondaryCycles, 2
_xSecondaryCycles:
	.skip	2
	.align	2
	.type	_xErrorOccurred,@object
	.size	_xErrorOccurred, 2
_xErrorOccurred:
	.skip	2
	.align	2
	.type	_xLastSecondaryCycleCount.9719,@object
	.size	_xLastSecondaryCycleCount.9719, 2
_xLastSecondaryCycleCount.9719:
	.skip	2
	.align	2
	.type	_xLastPrimaryCycleCount.9718,@object
	.size	_xLastPrimaryCycleCount.9718, 2
_xLastPrimaryCycleCount.9718:
	.skip	2
	.align	2
	.type	_xTestQueue,@object
	.size	_xTestQueue, 2
_xTestQueue:
	.skip	2
	.align	2
	.type	_xSecondary,@object
	.size	_xSecondary, 2
_xSecondary:
	.skip	2
	.align	2
	.type	_xRunIndicator,@object
	.size	_xRunIndicator, 2
_xRunIndicator:
	.skip	2
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
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI3-.LFB3
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
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI6-.LFB1
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI9-.LCFI6
	.byte	0x8c
	.uleb128 0x9
	.byte	0x8a
	.uleb128 0x7
	.byte	0x88
	.uleb128 0x5
	.align	4
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.align	4
.LEFDE8:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../RTOS/FreeRTOS/Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../RTOS/FreeRTOS/Source/include/task.h"
	.file 5 "../../RTOS/FreeRTOS/Source/include/queue.h"
	.section	.debug_info,info
	.4byte	0x57a
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../RTOS/FreeRTOS/Demo/Common/Minimal/blocktim.c"
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
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0x13a
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0xe8
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
	.4byte	0x19e
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0xd2
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x14b
	.uleb128 0x5
	.4byte	0x1ab
	.uleb128 0x3
	.asciz	"TaskHandle_t"
	.byte	0x4
	.byte	0x57
	.4byte	0x1e9
	.uleb128 0x6
	.byte	0x2
	.4byte	0x1ef
	.uleb128 0x7
	.asciz	"tskTaskControlBlock"
	.byte	0x1
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"QueueHandle_t"
	.byte	0x5
	.byte	0x33
	.4byte	0x222
	.uleb128 0x6
	.byte	0x2
	.4byte	0x228
	.uleb128 0x7
	.asciz	"QueueDefinition"
	.byte	0x1
	.uleb128 0x8
	.asciz	"vSecondaryBlockTimeTestTask"
	.byte	0x1
	.2byte	0x180
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x2a1
	.uleb128 0x9
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x180
	.4byte	0x18a
	.byte	0x1
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF0
	.byte	0x1
	.2byte	0x182
	.4byte	0x1be
	.uleb128 0xa
	.4byte	.LASF1
	.byte	0x1
	.2byte	0x182
	.4byte	0x1be
	.uleb128 0xb
	.asciz	"xData"
	.byte	0x1
	.2byte	0x183
	.4byte	0x18c
	.byte	0x2
	.byte	0x91
	.sleb128 -8
	.byte	0x0
	.uleb128 0x8
	.asciz	"prvBasicDelayTests"
	.byte	0x1
	.2byte	0x1dc
	.byte	0x1
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x38f
	.uleb128 0xb
	.asciz	"xPreTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x1be
	.byte	0x1
	.byte	0x58
	.uleb128 0xc
	.asciz	"xPostTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x1be
	.uleb128 0xc
	.asciz	"x"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x1be
	.uleb128 0xb
	.asciz	"xLastUnblockTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x1be
	.byte	0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0xc
	.asciz	"xExpectedUnblockTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x1be
	.uleb128 0xc
	.asciz	"xPeriod"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x38f
	.uleb128 0xc
	.asciz	"xCycles"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x38f
	.uleb128 0xc
	.asciz	"xAllowableMargin"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x38f
	.uleb128 0xc
	.asciz	"xHalfPeriod"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x38f
	.uleb128 0xc
	.asciz	"xDidBlock"
	.byte	0x1
	.2byte	0x1e0
	.4byte	0x18c
	.byte	0x0
	.uleb128 0xd
	.4byte	0x1be
	.uleb128 0xe
	.asciz	"vPrimaryBlockTimeTestTask"
	.byte	0x1
	.byte	0x7b
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x418
	.uleb128 0xf
	.4byte	.LASF2
	.byte	0x1
	.byte	0x7b
	.4byte	0x18a
	.byte	0x1
	.byte	0x50
	.uleb128 0x10
	.asciz	"xItem"
	.byte	0x1
	.byte	0x7d
	.4byte	0x18c
	.byte	0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x10
	.asciz	"xData"
	.byte	0x1
	.byte	0x7d
	.4byte	0x18c
	.byte	0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x11
	.4byte	.LASF0
	.byte	0x1
	.byte	0x7e
	.4byte	0x1be
	.uleb128 0x12
	.asciz	"xTimeToBlock"
	.byte	0x1
	.byte	0x7f
	.4byte	0x1be
	.uleb128 0x11
	.4byte	.LASF1
	.byte	0x1
	.byte	0x7f
	.4byte	0x1be
	.byte	0x0
	.uleb128 0x13
	.byte	0x1
	.asciz	"vCreateBlockTimeTasks"
	.byte	0x1
	.byte	0x65
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.uleb128 0x14
	.byte	0x1
	.asciz	"xAreBlockTimeTestTasksStillRunning"
	.byte	0x1
	.2byte	0x23b
	.byte	0x1
	.4byte	0x18c
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x4d7
	.uleb128 0xb
	.asciz	"xLastPrimaryCycleCount"
	.byte	0x1
	.2byte	0x23d
	.4byte	0x18c
	.byte	0x5
	.byte	0x3
	.4byte	_xLastPrimaryCycleCount.9718
	.uleb128 0xb
	.asciz	"xLastSecondaryCycleCount"
	.byte	0x1
	.2byte	0x23d
	.4byte	0x18c
	.byte	0x5
	.byte	0x3
	.4byte	_xLastSecondaryCycleCount.9719
	.uleb128 0xb
	.asciz	"xReturn"
	.byte	0x1
	.2byte	0x23e
	.4byte	0x18c
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x10
	.asciz	"xTestQueue"
	.byte	0x1
	.byte	0x55
	.4byte	0x20d
	.byte	0x5
	.byte	0x3
	.4byte	_xTestQueue
	.uleb128 0x10
	.asciz	"xSecondary"
	.byte	0x1
	.byte	0x59
	.4byte	0x1d5
	.byte	0x5
	.byte	0x3
	.4byte	_xSecondary
	.uleb128 0x10
	.asciz	"xPrimaryCycles"
	.byte	0x1
	.byte	0x5c
	.4byte	0x523
	.byte	0x5
	.byte	0x3
	.4byte	_xPrimaryCycles
	.uleb128 0x5
	.4byte	0x18c
	.uleb128 0x10
	.asciz	"xSecondaryCycles"
	.byte	0x1
	.byte	0x5c
	.4byte	0x523
	.byte	0x5
	.byte	0x3
	.4byte	_xSecondaryCycles
	.uleb128 0x10
	.asciz	"xErrorOccurred"
	.byte	0x1
	.byte	0x5d
	.4byte	0x523
	.byte	0x5
	.byte	0x3
	.4byte	_xErrorOccurred
	.uleb128 0x10
	.asciz	"xRunIndicator"
	.byte	0x1
	.byte	0x61
	.4byte	0x1d0
	.byte	0x5
	.byte	0x3
	.4byte	_xRunIndicator
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
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0xc
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
	.uleb128 0xd
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
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
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
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
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x4f
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x57e
	.4byte	0x418
	.asciz	"vCreateBlockTimeTasks"
	.4byte	0x43d
	.asciz	"xAreBlockTimeTestTasksStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x78
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x57e
	.4byte	0x12b
	.asciz	"uint8_t"
	.4byte	0x14b
	.asciz	"uint16_t"
	.4byte	0x18c
	.asciz	"BaseType_t"
	.4byte	0x1ab
	.asciz	"UBaseType_t"
	.4byte	0x1be
	.asciz	"TickType_t"
	.4byte	0x1d5
	.asciz	"TaskHandle_t"
	.4byte	0x20d
	.asciz	"QueueHandle_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x3c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF2:
	.asciz	"pvParameters"
.LASF1:
	.asciz	"xBlockedTime"
.LASF0:
	.asciz	"xTimeWhenBlocking"
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
