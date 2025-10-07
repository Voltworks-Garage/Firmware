	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\Common\\Minimal\\blocktim.c"
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
	.file 1 "../../Common/Minimal/blocktim.c"
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
	mov	#174,w9
.L8:
	.loc 1 397 0
	clr	w0
	rcall	_vTaskSuspend
	.loc 1 405 0
	rcall	_xTaskGetTickCount
	mov	w0,w10
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
	sub	w0,w10,w10
	.loc 1 421 0
	sub	w10,w9,[w15]
	.set ___BP___,50
	bra	leu,.L9
	.loc 1 429 0
	mov	#190,w0
	sub	w10,w0,[w15]
	.set ___BP___,0
	bra	leu,.L4
.L9:
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
	mov	w0,w10
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
	sub	w0,w10,w10
	.loc 1 456 0
	sub	w10,w9,[w15]
	.set ___BP___,50
	bra	leu,.L10
	.loc 1 464 0
	mov	#190,w0
	sub	w10,w0,[w15]
	.set ___BP___,0
	bra	leu,.L7
.L10:
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
	.section	.text.vPrimaryBlockTimeTestTask,code
	.align	2
	.type	_vPrimaryBlockTimeTestTask,@function
_vPrimaryBlockTimeTestTask:
.LFB1:
	.loc 1 124 0
	.set ___PA___,1
	lnk	#6
.LCFI3:
	mov.d	w8,[w15++]
.LCFI4:
	mov.d	w10,[w15++]
.LCFI5:
	mov.d	w12,[w15++]
.LCFI6:
.LBB4:
.LBB6:
	.loc 1 494 0
	mov	#182,w10
	.loc 1 503 0
	mov	#375,w11
.L53:
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
	sub	w8,w10,[w15]
	.set ___BP___,50
	bra	leu,.L14
	.loc 1 496 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L14:
	.loc 1 500 0
	rcall	_xTaskGetTickCount
	mov	w0,w9
	.loc 1 501 0
	mov	w9,[w15-14]
	clr	w8
.L16:
	.loc 1 509 0
	mov	#75,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	.loc 1 511 0
	rcall	_xTaskGetTickCount
	.loc 1 507 0
	sub	w0,w9,w0
	.loc 1 511 0
	sub	w0,w8,w0
	sub	w0,w10,[w15]
	.set ___BP___,50
	bra	leu,.L15
	.loc 1 513 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L15:
	.loc 1 516 0
	inc	_xPrimaryCycles
	add	#75,w8
	.loc 1 503 0
	sub	w8,w11,[w15]
	.set ___BP___,80
	bra	nz,.L16
	.loc 1 521 0
	mov	#75,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	.loc 1 523 0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L17
	.loc 1 525 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L17:
	.loc 1 530 0
	mov	#37,w0
	rcall	_vTaskDelay
	.loc 1 531 0
	mov	#75,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	.loc 1 533 0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L18
	.loc 1 535 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L18:
	.loc 1 540 0
	mov	#75,w0
	rcall	_vTaskDelay
	.loc 1 541 0
	mov	#75,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	.loc 1 543 0
	cp0	w0
	.set ___BP___,50
	bra	z,.L19
	.loc 1 545 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L19:
	.loc 1 549 0
	mov	#75,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	.loc 1 551 0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L20
	.loc 1 553 0
	mov	#1,w0
	mov	w0,_xErrorOccurred
.L20:
	.loc 1 558 0
	mov	#82,w0
	rcall	_vTaskDelay
	.loc 1 559 0
	mov	#75,w1
	sub	w15,#14,w0
	rcall	_xTaskDelayUntil
	mov	w0,w8
	.loc 1 561 0
	cp0	w8
	.set ___BP___,39
	bra	z,.L21
	.loc 1 563 0
	mov	#1,w1
	mov	w1,_xErrorOccurred
	.loc 1 567 0
	clr	w0
	rcall	_vTaskPrioritySet
.LBE6:
.LBE4:
	.loc 1 143 0
	clr	w0
	mov	w0,[w15-18]
.LBB9:
.LBB7:
	.loc 1 501 0
	clr	w8
.LBE7:
.LBE9:
	.loc 1 147 0
	mov	#10,w13
	.loc 1 155 0
	mov	#1,w12
.L26:
	.loc 1 147 0
	sl	w13,w8,w8
	.loc 1 149 0
	rcall	_xTaskGetTickCount
	mov	w0,w9
	.loc 1 153 0
	mov	w8,w2
	sub	w15,#16,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	cp0	w0
	.set ___BP___,50
	bra	z,.L23
	.loc 1 155 0
	mov	w12,_xErrorOccurred
.L23:
	.loc 1 159 0
	rcall	_xTaskGetTickCount
	sub	w0,w9,w9
	.loc 1 161 0
	sub	w8,w9,[w15]
	.set ___BP___,50
	bra	leu,.L24
	.loc 1 164 0
	mov	w12,_xErrorOccurred
.L24:
	.loc 1 167 0
	add	w8,#15,w8
	sub	w9,w8,[w15]
	.set ___BP___,50
	bra	leu,.L25
	.loc 1 172 0
	mov	w12,_xErrorOccurred
.L25:
	.loc 1 143 0
	mov	[w15-18],w1
	inc	w1,w8
	mov	w8,[w15-18]
	sub	w8,#4,[w15]
	.set ___BP___,91
	bra	le,.L26
	.loc 1 182 0
	clr	w0
	mov	w0,[w15-18]
	.loc 1 186 0
	mov	#1,w8
.L28:
	.loc 1 184 0
	clr	w3
	mov	w3,w2
	sub	w15,#18,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L27
	.loc 1 186 0
	mov	w8,_xErrorOccurred
.L27:
	.loc 1 182 0
	mov	[w15-18],w1
	inc	w1,w0
	mov	w0,[w15-18]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L28
	.loc 1 194 0
	clr	w0
	mov	w0,[w15-18]
	mov	w0,w8
	.loc 1 198 0
	mov	#10,w13
	.loc 1 206 0
	mov	#1,w12
.L32:
	.loc 1 198 0
	sl	w13,w8,w8
	.loc 1 200 0
	rcall	_xTaskGetTickCount
	mov	w0,w9
	.loc 1 204 0
	clr	w3
	mov	w8,w2
	sub	w15,#18,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	cp0	w0
	.set ___BP___,50
	bra	z,.L29
	.loc 1 206 0
	mov	w12,_xErrorOccurred
.L29:
	.loc 1 210 0
	rcall	_xTaskGetTickCount
	sub	w0,w9,w9
	.loc 1 212 0
	sub	w8,w9,[w15]
	.set ___BP___,50
	bra	leu,.L30
	.loc 1 215 0
	mov	w12,_xErrorOccurred
.L30:
	.loc 1 218 0
	add	w8,#15,w8
	sub	w9,w8,[w15]
	.set ___BP___,50
	bra	leu,.L31
	.loc 1 223 0
	mov	w12,_xErrorOccurred
.L31:
	.loc 1 194 0
	mov	[w15-18],w1
	inc	w1,w8
	mov	w8,[w15-18]
	sub	w8,#4,[w15]
	.set ___BP___,91
	bra	le,.L32
	.loc 1 239 0
	clr	_xRunIndicator
	.loc 1 240 0
	mov	_xSecondary,w0
	rcall	_vTaskResume
	.loc 1 243 0
	mov	#85,w0
	cp	_xRunIndicator
	.set ___BP___,9
	bra	z,.L33
	mov	w0,w8
.L57:
	.loc 1 246 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 243 0
	mov	_xRunIndicator,w0
	sub	w0,w8,[w15]
	.set ___BP___,91
	bra	nz,.L57
.L33:
	.loc 1 250 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 251 0
	clr	_xRunIndicator
	.loc 1 253 0
	clr	w1
	mov	w1,[w15-18]
	.loc 1 259 0
	mov	#1,w9
	.loc 1 270 0
	mov	#85,w8
.L39:
	.loc 1 257 0
	clr	w2
	sub	w15,#16,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L35
	.loc 1 259 0
	mov	w9,_xErrorOccurred
.L35:
	.loc 1 265 0
	clr	w3
	mov	w3,w2
	sub	w15,#18,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L36
	.loc 1 267 0
	mov	w9,_xErrorOccurred
.L36:
	.loc 1 270 0
	mov	_xRunIndicator,w0
	sub	w0,w8,[w15]
	.set ___BP___,28
	bra	z,.L70
	.loc 1 278 0
	mov	#3,w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 282 0
	mov	_xRunIndicator,w1
	sub	w1,w8,[w15]
	.set ___BP___,28
	bra	z,.L71
.L38:
	.loc 1 290 0
	clr	w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 253 0
	mov	[w15-18],w1
	inc	w1,w0
	mov	w0,[w15-18]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L39
.L74:
	.loc 1 295 0
	mov	#85,w0
	cp	_xRunIndicator
	.set ___BP___,9
	bra	z,.L40
	mov	w0,w8
.L56:
	.loc 1 297 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 295 0
	mov	_xRunIndicator,w0
	sub	w0,w8,[w15]
	.set ___BP___,91
	bra	nz,.L56
.L40:
	.loc 1 300 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 301 0
	clr	_xRunIndicator
	.loc 1 310 0
	clr	w1
	mov	w1,[w15-18]
	.loc 1 314 0
	mov	#1,w8
.L43:
	.loc 1 312 0
	clr	w2
	sub	w15,#16,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L42
	.loc 1 314 0
	mov	w8,_xErrorOccurred
.L42:
	.loc 1 310 0
	mov	[w15-18],w1
	inc	w1,w0
	mov	w0,[w15-18]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L43
	.loc 1 320 0
	mov	_xSecondary,w0
	rcall	_vTaskResume
	.loc 1 323 0
	mov	#85,w0
	cp	_xRunIndicator
	.set ___BP___,9
	bra	z,.L44
	mov	w0,w8
.L55:
	.loc 1 325 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 323 0
	mov	_xRunIndicator,w0
	sub	w0,w8,[w15]
	.set ___BP___,91
	bra	nz,.L55
.L44:
	.loc 1 328 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 329 0
	clr	_xRunIndicator
	.loc 1 331 0
	clr	w1
	mov	w1,[w15-18]
	.loc 1 337 0
	mov	#1,w9
	.loc 1 348 0
	mov	#85,w8
.L50:
	.loc 1 335 0
	clr	w3
	mov	w3,w2
	sub	w15,#18,w1
	mov	_xTestQueue,w0
	rcall	_xQueueGenericSend
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L46
	.loc 1 337 0
	mov	w9,_xErrorOccurred
.L46:
	.loc 1 343 0
	clr	w2
	sub	w15,#16,w1
	mov	_xTestQueue,w0
	rcall	_xQueueReceive
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L47
	.loc 1 345 0
	mov	w9,_xErrorOccurred
.L47:
	.loc 1 348 0
	mov	_xRunIndicator,w0
	sub	w0,w8,[w15]
	.set ___BP___,28
	bra	z,.L72
	.loc 1 356 0
	mov	#3,w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 360 0
	mov	_xRunIndicator,w1
	sub	w1,w8,[w15]
	.set ___BP___,28
	bra	z,.L73
.L49:
	.loc 1 367 0
	clr	w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 331 0
	mov	[w15-18],w1
	inc	w1,w0
	mov	w0,[w15-18]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L50
.L75:
	.loc 1 372 0
	mov	#85,w0
	cp	_xRunIndicator
	.set ___BP___,9
	bra	z,.L51
	mov	w0,w8
.L54:
	.loc 1 374 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 372 0
	mov	_xRunIndicator,w0
	sub	w0,w8,[w15]
	.set ___BP___,91
	bra	nz,.L54
.L51:
	.loc 1 377 0
	mov	#20,w0
	rcall	_vTaskDelay
	.loc 1 379 0
	inc	_xPrimaryCycles
	.loc 1 380 0
	bra	.L53
.L71:
	.loc 1 286 0
	mov	w9,_xErrorOccurred
	.loc 1 290 0
	clr	w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 253 0
	mov	[w15-18],w1
	inc	w1,w0
	mov	w0,[w15-18]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L39
	bra	.L74
.L70:
	.loc 1 273 0
	mov	w9,_xErrorOccurred
	.loc 1 278 0
	mov	#3,w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 282 0
	mov	_xRunIndicator,w1
	sub	w1,w8,[w15]
	.set ___BP___,72
	bra	nz,.L38
	bra	.L71
.L73:
	.loc 1 364 0
	mov	w9,_xErrorOccurred
	.loc 1 367 0
	clr	w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 331 0
	mov	[w15-18],w1
	inc	w1,w0
	mov	w0,[w15-18]
	sub	w0,#4,[w15]
	.set ___BP___,91
	bra	le,.L50
	bra	.L75
.L72:
	.loc 1 351 0
	mov	w9,_xErrorOccurred
	.loc 1 356 0
	mov	#3,w1
	mov	_xSecondary,w0
	rcall	_vTaskPrioritySet
	.loc 1 360 0
	mov	_xRunIndicator,w1
	sub	w1,w8,[w15]
	.set ___BP___,72
	bra	nz,.L49
	bra	.L73
.L21:
.LBB10:
.LBB5:
	.loc 1 567 0
	mov	#1,w1
	clr	w0
	rcall	_vTaskPrioritySet
.LBE5:
.LBE10:
	.loc 1 143 0
	mov	w8,[w15-18]
.LBB11:
.LBB8:
	.loc 1 501 0
	clr	w8
.LBE8:
.LBE11:
	.loc 1 147 0
	mov	#10,w13
	.loc 1 155 0
	mov	#1,w12
	bra	.L26
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
	bra	z,.L77
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
.L77:
	return	
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
	mov	_xLastPrimaryCycleCount.16994,w2
	.loc 1 585 0
	clr	w0
	.loc 1 583 0
	mov	_xLastSecondaryCycleCount.16995,w1
	mov	_xSecondaryCycles,w4
	sub	w4,w1,[w15]
	.set ___BP___,28
	bra	z,.L82
	.loc 1 574 0
	xor	w3,w2,w0
	btsc	w0,#15
	neg	w0,w0
	neg	w0,w0
	lsr	w0,#15,w0
.L82:
	.loc 1 588 0
	mov	_xErrorOccurred,w1
	sub	w1,#1,[w15]
	.set ___BP___,37
	bra	z,.L87
	.loc 1 593 0
	mov	_xSecondaryCycles,w1
	mov	w1,_xLastSecondaryCycleCount.16995
	.loc 1 594 0
	mov	_xPrimaryCycles,w4
	mov	w4,_xLastPrimaryCycleCount.16994
	.loc 1 597 0
	return	
.L88:
	.set ___PA___,0
.L87:
	.loc 1 590 0
	clr	w0
	.loc 1 593 0
	mov	_xSecondaryCycles,w1
	mov	w1,_xLastSecondaryCycleCount.16995
	.loc 1 594 0
	mov	_xPrimaryCycles,w4
	mov	w4,_xLastPrimaryCycleCount.16994
	.loc 1 597 0
	return	
	bra	.L88
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
	.type	_xLastSecondaryCycleCount.16995,@object
	.size	_xLastSecondaryCycleCount.16995, 2
_xLastSecondaryCycleCount.16995:
	.skip	2
	.align	2
	.type	_xLastPrimaryCycleCount.16994,@object
	.size	_xLastPrimaryCycleCount.16994, 2
_xLastPrimaryCycleCount.16994:
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
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI3-.LFB1
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI6-.LCFI3
	.byte	0x8c
	.uleb128 0xa
	.byte	0x8a
	.uleb128 0x8
	.byte	0x88
	.uleb128 0x6
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
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
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 4 "../../../Source/include/task.h"
	.file 5 "../../../Source/include/queue.h"
	.section	.debug_info,info
	.4byte	0x61d
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../Common/Minimal/blocktim.c"
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
	.4byte	0x19c
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x14a
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
	.4byte	0x200
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x3
	.byte	0x62
	.4byte	0x134
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x3
	.byte	0x65
	.4byte	0x1ad
	.uleb128 0x5
	.4byte	0x20d
	.uleb128 0x3
	.asciz	"TaskHandle_t"
	.byte	0x4
	.byte	0x57
	.4byte	0x24b
	.uleb128 0x6
	.byte	0x2
	.4byte	0x251
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
	.4byte	0x284
	.uleb128 0x6
	.byte	0x2
	.4byte	0x28a
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
	.4byte	0x303
	.uleb128 0x9
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x180
	.4byte	0x1ec
	.byte	0x1
	.byte	0x50
	.uleb128 0xa
	.4byte	.LASF0
	.byte	0x1
	.2byte	0x182
	.4byte	0x220
	.uleb128 0xa
	.4byte	.LASF1
	.byte	0x1
	.2byte	0x182
	.4byte	0x220
	.uleb128 0xb
	.asciz	"xData"
	.byte	0x1
	.2byte	0x183
	.4byte	0x1ee
	.byte	0x2
	.byte	0x91
	.sleb128 -8
	.byte	0x0
	.uleb128 0xc
	.asciz	"prvBasicDelayTests"
	.byte	0x1
	.2byte	0x1dc
	.byte	0x1
	.byte	0x1
	.4byte	0x3e3
	.uleb128 0xd
	.asciz	"xPreTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x220
	.uleb128 0xd
	.asciz	"xPostTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x220
	.uleb128 0xd
	.asciz	"x"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x220
	.uleb128 0xd
	.asciz	"xLastUnblockTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x220
	.uleb128 0xd
	.asciz	"xExpectedUnblockTime"
	.byte	0x1
	.2byte	0x1de
	.4byte	0x220
	.uleb128 0xd
	.asciz	"xPeriod"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x3e3
	.uleb128 0xd
	.asciz	"xCycles"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x3e3
	.uleb128 0xd
	.asciz	"xAllowableMargin"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x3e3
	.uleb128 0xd
	.asciz	"xHalfPeriod"
	.byte	0x1
	.2byte	0x1df
	.4byte	0x3e3
	.uleb128 0xd
	.asciz	"xDidBlock"
	.byte	0x1
	.2byte	0x1e0
	.4byte	0x1ee
	.byte	0x0
	.uleb128 0xe
	.4byte	0x220
	.uleb128 0xf
	.asciz	"vPrimaryBlockTimeTestTask"
	.byte	0x1
	.byte	0x7b
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x4bb
	.uleb128 0x10
	.4byte	.LASF2
	.byte	0x1
	.byte	0x7b
	.4byte	0x1ec
	.byte	0x1
	.byte	0x50
	.uleb128 0x11
	.asciz	"xItem"
	.byte	0x1
	.byte	0x7d
	.4byte	0x1ee
	.byte	0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x11
	.asciz	"xData"
	.byte	0x1
	.byte	0x7d
	.4byte	0x1ee
	.byte	0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x12
	.4byte	.LASF0
	.byte	0x1
	.byte	0x7e
	.4byte	0x220
	.uleb128 0x13
	.asciz	"xTimeToBlock"
	.byte	0x1
	.byte	0x7f
	.4byte	0x220
	.uleb128 0x12
	.4byte	.LASF1
	.byte	0x1
	.byte	0x7f
	.4byte	0x220
	.uleb128 0x14
	.4byte	0x303
	.4byte	.LBB4
	.4byte	.LBE4
	.uleb128 0x15
	.4byte	.LBB6
	.4byte	.LBE6
	.uleb128 0x16
	.4byte	0x320
	.byte	0x1
	.byte	0x58
	.uleb128 0x17
	.4byte	0x331
	.uleb128 0x17
	.4byte	0x343
	.uleb128 0x16
	.4byte	0x34d
	.byte	0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x17
	.4byte	0x366
	.uleb128 0x17
	.4byte	0x383
	.uleb128 0x17
	.4byte	0x3bc
	.uleb128 0x17
	.4byte	0x3d0
	.uleb128 0x17
	.4byte	0x393
	.uleb128 0x17
	.4byte	0x3a3
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.byte	0x1
	.asciz	"vCreateBlockTimeTasks"
	.byte	0x1
	.byte	0x65
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.uleb128 0x19
	.byte	0x1
	.asciz	"xAreBlockTimeTestTasksStillRunning"
	.byte	0x1
	.2byte	0x23b
	.byte	0x1
	.4byte	0x1ee
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x57a
	.uleb128 0xb
	.asciz	"xLastPrimaryCycleCount"
	.byte	0x1
	.2byte	0x23d
	.4byte	0x1ee
	.byte	0x5
	.byte	0x3
	.4byte	_xLastPrimaryCycleCount.16994
	.uleb128 0xb
	.asciz	"xLastSecondaryCycleCount"
	.byte	0x1
	.2byte	0x23d
	.4byte	0x1ee
	.byte	0x5
	.byte	0x3
	.4byte	_xLastSecondaryCycleCount.16995
	.uleb128 0xb
	.asciz	"xReturn"
	.byte	0x1
	.2byte	0x23e
	.4byte	0x1ee
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x11
	.asciz	"xTestQueue"
	.byte	0x1
	.byte	0x55
	.4byte	0x26f
	.byte	0x5
	.byte	0x3
	.4byte	_xTestQueue
	.uleb128 0x11
	.asciz	"xSecondary"
	.byte	0x1
	.byte	0x59
	.4byte	0x237
	.byte	0x5
	.byte	0x3
	.4byte	_xSecondary
	.uleb128 0x11
	.asciz	"xPrimaryCycles"
	.byte	0x1
	.byte	0x5c
	.4byte	0x5c6
	.byte	0x5
	.byte	0x3
	.4byte	_xPrimaryCycles
	.uleb128 0x5
	.4byte	0x1ee
	.uleb128 0x11
	.asciz	"xSecondaryCycles"
	.byte	0x1
	.byte	0x5c
	.4byte	0x5c6
	.byte	0x5
	.byte	0x3
	.4byte	_xSecondaryCycles
	.uleb128 0x11
	.asciz	"xErrorOccurred"
	.byte	0x1
	.byte	0x5d
	.4byte	0x5c6
	.byte	0x5
	.byte	0x3
	.4byte	_xErrorOccurred
	.uleb128 0x11
	.asciz	"xRunIndicator"
	.byte	0x1
	.byte	0x61
	.4byte	0x232
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
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
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
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
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
	.uleb128 0x19
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
	.4byte	0x621
	.4byte	0x4bb
	.asciz	"vCreateBlockTimeTasks"
	.4byte	0x4e0
	.asciz	"xAreBlockTimeTestTasksStillRunning"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x78
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x621
	.4byte	0x18d
	.asciz	"uint8_t"
	.4byte	0x1ad
	.asciz	"uint16_t"
	.4byte	0x1ee
	.asciz	"BaseType_t"
	.4byte	0x20d
	.asciz	"UBaseType_t"
	.4byte	0x220
	.asciz	"TickType_t"
	.4byte	0x237
	.asciz	"TaskHandle_t"
	.4byte	0x26f
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
