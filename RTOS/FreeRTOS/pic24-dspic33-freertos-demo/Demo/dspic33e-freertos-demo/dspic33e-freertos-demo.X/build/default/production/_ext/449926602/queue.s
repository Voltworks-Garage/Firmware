	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\..\\Source\\queue.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.prvCopyDataToQueue,code
	.align	2
	.type	_prvCopyDataToQueue,@function
_prvCopyDataToQueue:
.LFB15:
	.file 1 "../../../Source/queue.c"
	.loc 1 2176 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI0:
	mov	w10,[w15++]
.LCFI1:
	mov	w0,w8
	mov	w2,w10
	.loc 1 2182 0
	mov	[w8+28],w9
	.loc 1 2184 0
	mov	[w8+32],w2
	cp0	w2
	.set ___BP___,39
	bra	z,.L9
	.loc 1 2201 0
	cp0	w10
	.set ___BP___,50
	bra	nz,.L4
	.loc 1 2203 0
	mov	[w8+2],w0
	rcall	_memcpy
	.loc 1 2204 0
	mov	[w8+2],w1
	mov	[w8+32],w0
	add	w1,w0,w0
	mov	w0,[w8+2]
	.loc 1 2206 0
	mov	[w8+4],w1
	sub	w0,w1,[w15]
	.set ___BP___,50
	bra	ltu,.L9
	.loc 1 2208 0
	mov	[w8],w0
	mov	w0,[w8+2]
.L9:
	inc	w9,w9
.L3:
	.loc 1 2250 0
	mov	w9,[w8+28]
	.loc 1 2253 0
	clr	w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
.L11:
	.set ___PA___,0
.L4:
	.loc 1 2217 0
	mov	[w8+6],w0
	rcall	_memcpy
	.loc 1 2218 0
	mov	[w8+32],w1
	neg	w1,w1
	mov	[w8+6],w0
	add	w0,w1,w0
	mov	w0,[w8+6]
	.loc 1 2220 0
	sub	w0,[w8],[w15]
	.set ___BP___,50
	bra	geu,.L6
	.loc 1 2222 0
	mov	[w8+4],w0
	add	w0,w1,w1
	mov	w1,[w8+6]
.L6:
	.loc 1 2229 0
	sub	w10,#2,[w15]
	.set ___BP___,62
	bra	nz,.L9
	.loc 1 2231 0
	cp0	w9
	.set ___BP___,61
	bra	nz,.L3
	mov	#1,w9
	.loc 1 2250 0
	mov	w9,[w8+28]
	.loc 1 2253 0
	clr	w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L11
.LFE15:
	.size	_prvCopyDataToQueue, .-_prvCopyDataToQueue
	.section	.text.prvCopyDataFromQueue,code
	.align	2
	.type	_prvCopyDataFromQueue,@function
_prvCopyDataFromQueue:
.LFB16:
	.loc 1 2258 0
	.set ___PA___,1
	mov	w0,w3
	mov	w1,w0
	.loc 1 2259 0
	mov	[w3+32],w2
	cp0	w2
	.set ___BP___,39
	bra	z,.L13
	.loc 1 2261 0
	mov	[w3+6],w1
	add	w1,w2,w1
	mov	w1,[w3+6]
	.loc 1 2263 0
	mov	[w3+4],w4
	sub	w1,w4,[w15]
	.set ___BP___,50
	bra	ltu,.L15
	.loc 1 2265 0
	mov	[w3],w1
	mov	w1,[w3+6]
.L15:
	.loc 1 2272 0
	rcall	_memcpy
.L13:
	return	
.LFE16:
	.size	_prvCopyDataFromQueue, .-_prvCopyDataFromQueue
	.section	.text.prvUnlockQueue,code
	.align	2
	.type	_prvUnlockQueue,@function
_prvUnlockQueue:
.LFB17:
	.loc 1 2278 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI2:
	mov	w10,[w15++]
.LCFI3:
	mov	w0,w9
	.loc 1 2285 0
	rcall	_vPortEnterCritical
.LBB23:
	.loc 1 2287 0
	mov.b	[w9+35],w8
	.loc 1 2290 0
	cp0.b	w8
	.set ___BP___,4
	bra	le,.L19
	.loc 1 2338 0
	mov	[w9+18],w0
	cp0	w0
	.set ___BP___,4
	bra	z,.L19
	add	w9,#18,w10
.L21:
	.loc 1 2340 0
	mov	w10,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,29
	bra	nz,.L34
.L22:
	.loc 1 2358 0
	dec.b	w8,w8
	.loc 1 2290 0
	.set ___BP___,4
	bclr.b	_SR,#2
	bra	le,.L19
	.loc 1 2338 0
	mov	[w9+18],w0
	cp0	w0
	.set ___BP___,95
	bra	nz,.L21
.L19:
	.loc 1 2361 0
	setm.b	w0
	mov.b	w0,[w9+35]
.LBE23:
	.loc 1 2363 0
	rcall	_vPortExitCritical
	.loc 1 2366 0
	rcall	_vPortEnterCritical
.LBB24:
	.loc 1 2368 0
	mov.b	[w9+34],w8
	.loc 1 2370 0
	cp0.b	w8
	.set ___BP___,4
	bra	le,.L24
	.loc 1 2372 0
	mov	[w9+8],w0
	cp0	w0
	.set ___BP___,4
	bra	z,.L24
	add	w9,#8,w10
.L26:
	.loc 1 2374 0
	mov	w10,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,29
	bra	nz,.L35
.L27:
	.loc 1 2383 0
	dec.b	w8,w8
	.loc 1 2370 0
	.set ___BP___,4
	bclr.b	_SR,#2
	bra	le,.L24
	.loc 1 2372 0
	mov	[w9+8],w0
	cp0	w0
	.set ___BP___,95
	bra	nz,.L26
.L24:
	.loc 1 2391 0
	setm.b	w0
	mov.b	w0,[w9+34]
.LBE24:
	.loc 1 2393 0
	rcall	_vPortExitCritical
	.loc 1 2394 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L34:
.LBB25:
	.loc 1 2344 0
	rcall	_vTaskMissedYield
	bra	.L22
.L35:
.LBE25:
.LBB26:
	.loc 1 2376 0
	rcall	_vTaskMissedYield
	bra	.L27
.LBE26:
.LFE17:
	.size	_prvUnlockQueue, .-_prvUnlockQueue
	.section	.text.xQueueGenericReset,code
	.align	2
	.global	_xQueueGenericReset	; export
	.type	_xQueueGenericReset,@function
_xQueueGenericReset:
.LFB0:
	.loc 1 296 0
	.set ___PA___,0
	lnk	#4
.LCFI4:
	mov.d	w8,[w15++]
.LCFI5:
	mov	w10,[w15++]
.LCFI6:
	mov	w0,w8
	mov	w1,w10
	.loc 1 350 0
	clr	w0
	.loc 1 302 0
	cp0	w8
	.set ___BP___,10
	bra	z,.L38
	.loc 1 303 0
	mov	[w8+30],w2
	.loc 1 302 0
	cp0	w2
	.set ___BP___,39
	bra	z,.L38
	.loc 1 305 0
	setm	w9
	repeat	#__TARGET_DIVIDE_CYCLES
	div.uw	w9,w2
	exch	w0,w1
	mov	w1,w2
	.loc 1 303 0
	mov	[w8+32],w3
	.loc 1 350 0
	clr	w0
	.loc 1 303 0
	sub	w2,w3,[w15]
	.set ___BP___,38
	bra	geu,.L45
.L38:
	.loc 1 358 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L48:
	.set ___PA___,0
.L45:
	.loc 1 307 0
	mov	w0,[w15-10]
	rcall	_vPortEnterCritical
	.loc 1 309 0
	mov	[w8],w2
	mov	[w8+30],w4
	mov	[w8+32],w3
	mulw.ss	w3,w4,w6
	add	w2,w6,w5
	mov	w5,[w8+4]
	.loc 1 310 0
	mov	[w15-10],w0
	mov	w0,[w8+28]
	.loc 1 311 0
	mov	w2,[w8+2]
	.loc 1 312 0
	add	w4,w9,w4
	mulw.ss	w4,w3,w4
	add	w2,w4,w2
	mov	w2,[w8+6]
	.loc 1 313 0
	mov.b	w9,[w8+34]
	.loc 1 314 0
	mov.b	w9,[w8+35]
	.loc 1 316 0
	cp0	w10
	.set ___BP___,29
	bra	nz,.L39
	.loc 1 323 0
	mov	[w8+8],w0
	cp0	w0
	.set ___BP___,29
	bra	nz,.L46
.L40:
	.loc 1 346 0
	rcall	_vPortExitCritical
	.loc 1 297 0
	mov	#1,w0
.L47:
	.loc 1 358 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L48
.L39:
	.loc 1 342 0
	add	w8,#8,w0
	rcall	_vListInitialise
	.loc 1 343 0
	add	w8,#18,w0
	rcall	_vListInitialise
	.loc 1 346 0
	rcall	_vPortExitCritical
	.loc 1 297 0
	mov	#1,w0
	bra	.L47
.L46:
	.loc 1 325 0
	add	w8,#8,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,50
	bra	z,.L40
	.loc 1 327 0
; 327 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 346 0
	rcall	_vPortExitCritical
	.loc 1 297 0
	mov	#1,w0
	bra	.L47
.LFE0:
	.size	_xQueueGenericReset, .-_xQueueGenericReset
	.section	.text.xQueueGenericCreate,code
	.align	2
	.global	_xQueueGenericCreate	; export
	.type	_xQueueGenericCreate,@function
_xQueueGenericCreate:
.LFB1:
	.loc 1 429 0
	.set ___PA___,1
	lnk	#2
.LCFI7:
	mov.d	w8,[w15++]
.LCFI8:
	mov	w10,[w15++]
.LCFI9:
	mov	w0,w8
	mov	w1,w10
	.loc 1 430 0
	clr	w9
	.loc 1 434 0
	cp0	w8
	.set ___BP___,10
	bra	nz,.L58
.L51:
	.loc 1 487 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L60:
	.set ___PA___,0
.L58:
	.loc 1 436 0
	setm	w0
	repeat	#__TARGET_DIVIDE_CYCLES
	div.uw	w0,w8
		
	.loc 1 434 0
	sub	w0,w10,[w15]
	.set ___BP___,90
	bra	ltu,.L51
	.loc 1 438 0
	mulw.ss	w10,w8,w0
	.loc 1 436 0
	mov	#-37,w2
	sub	w0,w2,[w15]
	.set ___BP___,61
	bra	gtu,.L51
	.loc 1 454 0
	add	#36,w0
	rcall	_pvPortMalloc
	mov	w0,w9
	.loc 1 456 0
	cp0	w9
	.set ___BP___,10
	bra	z,.L51
.LBB27:
.LBB28:
	.loc 1 502 0
	cp0	w10
	.set ___BP___,50
	bra	nz,.L52
	.loc 1 508 0
	mov	w9,[w9]
	.loc 1 518 0
	mov	w8,[w9+30]
	.loc 1 519 0
	mov	w10,[w9+32]
	.loc 1 520 0
	mov	#1,w1
	mov	w9,w0
	rcall	_xQueueGenericReset
.L59:
.LBE28:
.LBE27:
	.loc 1 487 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L60
.L52:
	.loc 1 461 0
	mov	#36,w0
	add	w9,w0,[w9]
.LBB30:
.LBB29:
	.loc 1 518 0
	mov	w8,[w9+30]
	.loc 1 519 0
	mov	w10,[w9+32]
	.loc 1 520 0
	mov	#1,w1
	mov	w9,w0
	rcall	_xQueueGenericReset
	bra	.L59
.LBE29:
.LBE30:
.LFE1:
	.size	_xQueueGenericCreate, .-_xQueueGenericCreate
	.section	.text.xQueueGenericSend,code
	.align	2
	.global	_xQueueGenericSend	; export
	.type	_xQueueGenericSend,@function
_xQueueGenericSend:
.LFB3:
	.loc 1 837 0
	.set ___PA___,0
	lnk	#6
.LCFI10:
	mov.d	w8,[w15++]
.LCFI11:
	mov.d	w10,[w15++]
.LCFI12:
	mov	w12,[w15++]
.LCFI13:
	mov.d	w0,w8
	mov	w2,[w15-12]
	mov	w3,w10
	.loc 1 838 0
	clr	w12
	.loc 1 1006 0
	add	w8,#8,w11
	.loc 1 856 0
	rcall	_vPortEnterCritical
	.loc 1 862 0
	mov	[w8+28],w1
	mov	[w8+30],w0
	sub	w1,w0,[w15]
	.set ___BP___,2
	bra	ltu,.L64
.L82:
	sub	w10,#2,[w15]
	.set ___BP___,2
	bra	z,.L64
	.loc 1 967 0
	mov	[w15-12],w0
	cp0	w0
	.set ___BP___,2
	bra	z,.L77
	.loc 1 978 0
	cp0	w12
	.set ___BP___,29
	bra	z,.L78
	.loc 1 992 0
	rcall	_vPortExitCritical
	.loc 1 997 0
	rcall	_vTaskSuspendAll
	.loc 1 998 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L79
.L71:
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L80
.L72:
	rcall	_vPortExitCritical
	.loc 1 1001 0
	sub	w15,#12,w1
	sub	w15,#16,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,2
	bra	nz,.L73
.L84:
.LBB31:
.LBB32:
	.loc 1 2442 0
	rcall	_vPortEnterCritical
	.loc 1 2444 0
	mov	[w8+28],w1
	mov	[w8+30],w0
	sub	w1,w0,[w15]
	.set ___BP___,28
	bra	z,.L81
	.loc 1 2453 0
	rcall	_vPortExitCritical
.LBE32:
.LBE31:
	.loc 1 1028 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1029 0
	rcall	_xTaskResumeAll
.L75:
	.loc 1 1039 0
	mov	#1,w12
.L85:
	.loc 1 856 0
	rcall	_vPortEnterCritical
	.loc 1 862 0
	mov	[w8+28],w1
	mov	[w8+30],w0
	sub	w1,w0,[w15]
	.set ___BP___,97
	bra	geu,.L82
.L64:
	.loc 1 928 0
	mov	w10,w2
	mov.d	w8,w0
	rcall	_prvCopyDataToQueue
	.loc 1 932 0
	mov	[w8+18],w1
	cp0	w1
	.set ___BP___,29
	bra	nz,.L83
	.loc 1 947 0
	cp0	w0
	.set ___BP___,39
	bra	z,.L67
	.loc 1 953 0
; 953 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
.L67:
	.loc 1 962 0
	rcall	_vPortExitCritical
	.loc 1 963 0
	mov	#1,w0
.L68:
	.loc 1 1042 0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L86:
	.set ___PA___,0
.L78:
	.loc 1 982 0
	sub	w15,#16,w0
	rcall	_vTaskInternalSetTimeOutState
	.loc 1 992 0
	rcall	_vPortExitCritical
	.loc 1 997 0
	rcall	_vTaskSuspendAll
	.loc 1 998 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L71
	bra	.L79
.L80:
	clr.b	w0
	mov.b	w0,[w8+35]
	rcall	_vPortExitCritical
	.loc 1 1001 0
	sub	w15,#12,w1
	sub	w15,#16,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,97
	bra	z,.L84
.L73:
	.loc 1 1035 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1036 0
	rcall	_xTaskResumeAll
	.loc 1 1039 0
	clr	w0
	.loc 1 1042 0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L86
.L79:
	.loc 1 998 0
	clr.b	w0
	mov.b	w0,[w8+34]
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L72
	bra	.L80
.L81:
.LBB34:
.LBB33:
	.loc 1 2453 0
	rcall	_vPortExitCritical
.LBE33:
.LBE34:
	.loc 1 1006 0
	mov	[w15-12],w1
	mov	w11,w0
	rcall	_vTaskPlaceOnEventList
	.loc 1 1013 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1020 0
	rcall	_xTaskResumeAll
	cp0	w0
	.set ___BP___,50
	bra	nz,.L75
	.loc 1 1022 0
; 1022 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 1039 0
	mov	#1,w12
	bra	.L85
.L77:
	.loc 1 971 0
	rcall	_vPortExitCritical
	.loc 1 976 0
	clr	w0
	.loc 1 1042 0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L86
.L83:
	.loc 1 934 0
	add	w8,#18,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L67
	.loc 1 940 0
; 940 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 962 0
	rcall	_vPortExitCritical
	.loc 1 963 0
	mov	#1,w0
	bra	.L68
.LFE3:
	.size	_xQueueGenericSend, .-_xQueueGenericSend
	.section	.text.xQueueGenericSendFromISR,code
	.align	2
	.global	_xQueueGenericSendFromISR	; export
	.type	_xQueueGenericSendFromISR,@function
_xQueueGenericSendFromISR:
.LFB4:
	.loc 1 1049 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI14:
	mov.d	w10,[w15++]
.LCFI15:
	mov	w0,w8
	mov	w2,w9
	.loc 1 1081 0
	mov	[w8+28],w2
	mov	[w8+30],w0
	sub	w2,w0,[w15]
	.set ___BP___,29
	bra	ltu,.L89
	.loc 1 1201 0
	clr	w11
	.loc 1 1081 0
	sub	w3,#2,[w15]
	.set ___BP___,37
	bra	z,.L89
.L90:
	.loc 1 1207 0
	mov	w11,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
.L99:
	.set ___PA___,0
.L89:
.LBB35:
	.loc 1 1083 0
	mov.b	[w8+35],w10
	.loc 1 1084 0
	mov	[w8+28],w0
	.loc 1 1093 0
	mov	w3,w2
	mov	w8,w0
	rcall	_prvCopyDataToQueue
	.loc 1 1097 0
	add.b	w10,#1,[w15]
	.set ___BP___,48
	bra	z,.L98
.LBB36:
	.loc 1 1193 0
	rcall	_uxTaskGetNumberOfTasks
	se	w10,w1
	.loc 1 1196 0
	mov	#1,w11
	.loc 1 1193 0
	sub	w0,w1,[w15]
	.set ___BP___,39
	bra	leu,.L90
	inc.b	w10,w10
	mov.b	w10,[w8+35]
.LBE36:
.LBE35:
	.loc 1 1207 0
	mov	w11,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L99
.L98:
.LBB37:
	.loc 1 1159 0
	mov	[w8+18],w0
	.loc 1 1196 0
	mov	#1,w11
	.loc 1 1159 0
	cp0	w0
	.set ___BP___,61
	bra	z,.L90
	.loc 1 1161 0
	add	w8,#18,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L90
	.loc 1 1165 0
	cp0	w9
	.set ___BP___,15
	bra	z,.L90
	.loc 1 1167 0
	mov	w11,[w9]
.LBE37:
	.loc 1 1207 0
	mov	w11,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L99
.LFE4:
	.size	_xQueueGenericSendFromISR, .-_xQueueGenericSendFromISR
	.section	.text.xQueueGiveFromISR,code
	.align	2
	.global	_xQueueGiveFromISR	; export
	.type	_xQueueGiveFromISR,@function
_xQueueGiveFromISR:
.LFB5:
	.loc 1 1212 0
	.set ___PA___,1
	lnk	#2
.LCFI16:
	mov.d	w8,[w15++]
.LCFI17:
	mov	w10,[w15++]
.LCFI18:
	mov	w0,w8
.LBB38:
	.loc 1 1252 0
	mov	[w8+28],w0
	.loc 1 1257 0
	mov	[w8+30],w2
	.loc 1 1367 0
	clr	w9
	.loc 1 1257 0
	sub	w0,w2,[w15]
	.set ___BP___,39
	bra	geu,.L102
.LBB39:
	.loc 1 1259 0
	mov.b	[w8+35],w10
	.loc 1 1269 0
	inc	w0,w0
	mov	w0,[w8+28]
	.loc 1 1273 0
	add.b	w10,#1,[w15]
	.set ___BP___,48
	bra	z,.L110
.LBB40:
	.loc 1 1359 0
	rcall	_uxTaskGetNumberOfTasks
	se	w10,w1
	.loc 1 1362 0
	mov	#1,w9
	.loc 1 1359 0
	sub	w0,w1,[w15]
	.set ___BP___,39
	bra	leu,.L102
	inc.b	w10,w10
	mov.b	w10,[w8+35]
.L102:
.LBE40:
.LBE39:
.LBE38:
	.loc 1 1373 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L111:
	.set ___PA___,0
.L110:
.LBB42:
.LBB41:
	.loc 1 1328 0
	mov	[w8+18],w0
	.loc 1 1362 0
	mov	#1,w9
	.loc 1 1328 0
	cp0	w0
	.set ___BP___,61
	bra	z,.L102
	.loc 1 1330 0
	add	w8,#18,w0
	mov	w1,[w15-8]
	rcall	_xTaskRemoveFromEventList
	mov	[w15-8],w1
	cp0	w0
	.set ___BP___,39
	bra	z,.L102
	.loc 1 1334 0
	cp0	w1
	.set ___BP___,15
	bra	z,.L102
	.loc 1 1336 0
	mov	w9,[w1]
.LBE41:
.LBE42:
	.loc 1 1373 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L111
.LFE5:
	.size	_xQueueGiveFromISR, .-_xQueueGiveFromISR
	.section	.text.xQueueReceive,code
	.align	2
	.global	_xQueueReceive	; export
	.type	_xQueueReceive,@function
_xQueueReceive:
.LFB6:
	.loc 1 1379 0
	.set ___PA___,0
	lnk	#6
.LCFI19:
	mov.d	w8,[w15++]
.LCFI20:
	mov.d	w10,[w15++]
.LCFI21:
	mov	w12,[w15++]
.LCFI22:
	mov.d	w0,w8
	mov	w2,[w15-12]
	.loc 1 1380 0
	clr	w12
	.loc 1 1478 0
	add	w8,#18,w11
	.loc 1 1403 0
	rcall	_vPortEnterCritical
.LBB43:
	.loc 1 1405 0
	mov	[w8+28],w10
	.loc 1 1409 0
	cp0	w10
	.set ___BP___,3
	bra	nz,.L128
.L115:
	.loc 1 1440 0
	mov	[w15-12],w0
	cp0	w0
	.set ___BP___,3
	bra	z,.L126
	.loc 1 1448 0
	cp0	w12
	.set ___BP___,29
	bra	z,.L129
.LBE43:
	.loc 1 1462 0
	rcall	_vPortExitCritical
	.loc 1 1467 0
	rcall	_vTaskSuspendAll
	.loc 1 1468 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L130
.L120:
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L131
.L121:
	rcall	_vPortExitCritical
	.loc 1 1471 0
	sub	w15,#12,w1
	sub	w15,#16,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,50
	bra	nz,.L122
.L133:
.LBB44:
.LBB45:
	.loc 1 2401 0
	rcall	_vPortEnterCritical
	.loc 1 2403 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,50
	bra	nz,.L123
	.loc 1 2412 0
	rcall	_vPortExitCritical
.LBE45:
.LBE44:
	.loc 1 1478 0
	mov	[w15-12],w1
	mov	w11,w0
	rcall	_vTaskPlaceOnEventList
	.loc 1 1479 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1481 0
	rcall	_xTaskResumeAll
	cp0	w0
	.set ___BP___,50
	bra	nz,.L124
	.loc 1 1483 0
; 1483 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
.L124:
.LBB47:
.LBB49:
	.loc 1 1508 0
	mov	#1,w12
.L134:
.LBE49:
.LBE47:
	.loc 1 1403 0
	rcall	_vPortEnterCritical
.LBB52:
	.loc 1 1405 0
	mov	[w8+28],w10
	.loc 1 1409 0
	cp0	w10
	.set ___BP___,97
	bra	z,.L115
.L128:
	.loc 1 1412 0
	mov.d	w8,w0
	rcall	_prvCopyDataFromQueue
	.loc 1 1414 0
	dec	w10,w10
	mov	w10,[w8+28]
	.loc 1 1419 0
	mov	[w8+8],w0
	cp0	w0
	.set ___BP___,38
	bra	nz,.L132
.L116:
	.loc 1 1435 0
	rcall	_vPortExitCritical
	.loc 1 1436 0
	mov	#1,w0
.L117:
.LBE52:
	.loc 1 1516 0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L135:
	.set ___PA___,0
.L129:
.LBB53:
	.loc 1 1452 0
	sub	w15,#16,w0
	rcall	_vTaskInternalSetTimeOutState
.LBE53:
	.loc 1 1462 0
	rcall	_vPortExitCritical
	.loc 1 1467 0
	rcall	_vTaskSuspendAll
	.loc 1 1468 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L120
	bra	.L130
.L131:
	clr.b	w0
	mov.b	w0,[w8+35]
	rcall	_vPortExitCritical
	.loc 1 1471 0
	sub	w15,#12,w1
	sub	w15,#16,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,50
	bra	z,.L133
.L122:
	.loc 1 1502 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1503 0
	rcall	_xTaskResumeAll
.LBB54:
.LBB50:
	.loc 1 2401 0
	rcall	_vPortEnterCritical
	.loc 1 2403 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,50
	bra	z,.L126
	.loc 1 2412 0
	rcall	_vPortExitCritical
	.loc 1 1508 0
	mov	#1,w12
	bra	.L134
.L130:
.LBE50:
.LBE54:
	.loc 1 1468 0
	clr.b	w0
	mov.b	w0,[w8+34]
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L121
	bra	.L131
.L126:
.LBB55:
.LBB48:
	.loc 1 2412 0
	rcall	_vPortExitCritical
	.loc 1 1508 0
	clr	w0
.LBE48:
.LBE55:
	.loc 1 1516 0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L135
.L123:
.LBB56:
.LBB46:
	.loc 1 2412 0
	rcall	_vPortExitCritical
.LBE46:
.LBE56:
	.loc 1 1494 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1495 0
	rcall	_xTaskResumeAll
.LBB57:
.LBB51:
	.loc 1 1508 0
	mov	#1,w12
	bra	.L134
.L132:
.LBE51:
.LBE57:
.LBB58:
	.loc 1 1421 0
	add	w8,#8,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L116
	.loc 1 1423 0
; 1423 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 1435 0
	rcall	_vPortExitCritical
	.loc 1 1436 0
	mov	#1,w0
	bra	.L117
.LBE58:
.LFE6:
	.size	_xQueueReceive, .-_xQueueReceive
	.section	.text.xQueueSemaphoreTake,code
	.align	2
	.global	_xQueueSemaphoreTake	; export
	.type	_xQueueSemaphoreTake,@function
_xQueueSemaphoreTake:
.LFB7:
	.loc 1 1521 0
	.set ___PA___,0
	lnk	#6
.LCFI23:
	mov.d	w8,[w15++]
.LCFI24:
	mov	w10,[w15++]
.LCFI25:
	mov	w0,w8
	mov	w1,[w15-8]
	.loc 1 1522 0
	clr	w10
	.loc 1 1661 0
	add	w8,#18,w9
	.loc 1 1549 0
	rcall	_vPortEnterCritical
.LBB59:
	.loc 1 1553 0
	mov	[w8+28],w0
	.loc 1 1557 0
	cp0	w0
	.set ___BP___,3
	bra	nz,.L152
.L139:
	.loc 1 1603 0
	mov	[w15-8],w0
	cp0	w0
	.set ___BP___,3
	bra	z,.L150
	.loc 1 1611 0
	cp0	w10
	.set ___BP___,29
	bra	z,.L153
.LBE59:
	.loc 1 1625 0
	rcall	_vPortExitCritical
	.loc 1 1630 0
	rcall	_vTaskSuspendAll
	.loc 1 1631 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L154
.L144:
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L155
.L145:
	rcall	_vPortExitCritical
	.loc 1 1634 0
	sub	w15,#8,w1
	sub	w15,#12,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,50
	bra	nz,.L146
.L157:
.LBB60:
.LBB61:
	.loc 1 2401 0
	rcall	_vPortEnterCritical
	.loc 1 2403 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,50
	bra	nz,.L147
	.loc 1 2412 0
	rcall	_vPortExitCritical
.LBE61:
.LBE60:
	.loc 1 1661 0
	mov	[w15-8],w1
	mov	w9,w0
	rcall	_vTaskPlaceOnEventList
	.loc 1 1662 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1664 0
	rcall	_xTaskResumeAll
	cp0	w0
	.set ___BP___,50
	bra	nz,.L148
	.loc 1 1666 0
; 1666 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
.L148:
.LBB63:
.LBB65:
	.loc 1 1718 0
	mov	#1,w10
.L158:
.LBE65:
.LBE63:
	.loc 1 1549 0
	rcall	_vPortEnterCritical
.LBB68:
	.loc 1 1553 0
	mov	[w8+28],w0
	.loc 1 1557 0
	cp0	w0
	.set ___BP___,97
	bra	z,.L139
.L152:
	.loc 1 1563 0
	dec	w0,w0
	mov	w0,[w8+28]
	.loc 1 1582 0
	mov	[w8+8],w0
	cp0	w0
	.set ___BP___,38
	bra	nz,.L156
.L140:
	.loc 1 1598 0
	rcall	_vPortExitCritical
	.loc 1 1599 0
	mov	#1,w0
.L141:
.LBE68:
	.loc 1 1726 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L159:
	.set ___PA___,0
.L153:
.LBB69:
	.loc 1 1615 0
	sub	w15,#12,w0
	rcall	_vTaskInternalSetTimeOutState
.LBE69:
	.loc 1 1625 0
	rcall	_vPortExitCritical
	.loc 1 1630 0
	rcall	_vTaskSuspendAll
	.loc 1 1631 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L144
	bra	.L154
.L155:
	clr.b	w0
	mov.b	w0,[w8+35]
	rcall	_vPortExitCritical
	.loc 1 1634 0
	sub	w15,#8,w1
	sub	w15,#12,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,50
	bra	z,.L157
.L146:
	.loc 1 1684 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1685 0
	rcall	_xTaskResumeAll
.LBB70:
.LBB66:
	.loc 1 2401 0
	rcall	_vPortEnterCritical
	.loc 1 2403 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,50
	bra	z,.L150
	.loc 1 2412 0
	rcall	_vPortExitCritical
	.loc 1 1718 0
	mov	#1,w10
	bra	.L158
.L154:
.LBE66:
.LBE70:
	.loc 1 1631 0
	clr.b	w0
	mov.b	w0,[w8+34]
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L145
	bra	.L155
.L150:
.LBB71:
.LBB64:
	.loc 1 2412 0
	rcall	_vPortExitCritical
	.loc 1 1718 0
	clr	w0
.LBE64:
.LBE71:
	.loc 1 1726 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L159
.L147:
.LBB72:
.LBB62:
	.loc 1 2412 0
	rcall	_vPortExitCritical
.LBE62:
.LBE72:
	.loc 1 1677 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1678 0
	rcall	_xTaskResumeAll
.LBB73:
.LBB67:
	.loc 1 1718 0
	mov	#1,w10
	bra	.L158
.L156:
.LBE67:
.LBE73:
.LBB74:
	.loc 1 1584 0
	add	w8,#8,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L140
	.loc 1 1586 0
; 1586 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 1598 0
	rcall	_vPortExitCritical
	.loc 1 1599 0
	mov	#1,w0
	bra	.L141
.LBE74:
.LFE7:
	.size	_xQueueSemaphoreTake, .-_xQueueSemaphoreTake
	.section	.text.xQueuePeek,code
	.align	2
	.global	_xQueuePeek	; export
	.type	_xQueuePeek,@function
_xQueuePeek:
.LFB8:
	.loc 1 1732 0
	.set ___PA___,0
	lnk	#6
.LCFI26:
	mov.d	w8,[w15++]
.LCFI27:
	mov.d	w10,[w15++]
.LCFI28:
	mov.d	w0,w8
	mov	w2,[w15-10]
	.loc 1 1733 0
	clr	w11
	.loc 1 1839 0
	add	w8,#18,w10
	.loc 1 1757 0
	rcall	_vPortEnterCritical
.LBB75:
	.loc 1 1759 0
	mov	[w8+28],w0
	.loc 1 1763 0
	cp0	w0
	.set ___BP___,3
	bra	nz,.L176
.L163:
	.loc 1 1800 0
	mov	[w15-10],w0
	cp0	w0
	.set ___BP___,3
	bra	z,.L174
	.loc 1 1808 0
	cp0	w11
	.set ___BP___,29
	bra	z,.L177
.LBE75:
	.loc 1 1823 0
	rcall	_vPortExitCritical
	.loc 1 1828 0
	rcall	_vTaskSuspendAll
	.loc 1 1829 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L178
.L168:
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L179
.L169:
	rcall	_vPortExitCritical
	.loc 1 1832 0
	sub	w15,#10,w1
	sub	w15,#14,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,50
	bra	nz,.L170
.L181:
.LBB76:
.LBB77:
	.loc 1 2401 0
	rcall	_vPortEnterCritical
	.loc 1 2403 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,50
	bra	nz,.L171
	.loc 1 2412 0
	rcall	_vPortExitCritical
.LBE77:
.LBE76:
	.loc 1 1839 0
	mov	[w15-10],w1
	mov	w10,w0
	rcall	_vTaskPlaceOnEventList
	.loc 1 1840 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1842 0
	rcall	_xTaskResumeAll
	cp0	w0
	.set ___BP___,50
	bra	nz,.L172
	.loc 1 1844 0
; 1844 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
.L172:
.LBB79:
.LBB81:
	.loc 1 1869 0
	mov	#1,w11
.L182:
.LBE81:
.LBE79:
	.loc 1 1757 0
	rcall	_vPortEnterCritical
.LBB84:
	.loc 1 1759 0
	mov	[w8+28],w0
	.loc 1 1763 0
	cp0	w0
	.set ___BP___,97
	bra	z,.L163
.L176:
	.loc 1 1768 0
	mov	[w8+6],w10
	.loc 1 1770 0
	mov.d	w8,w0
	rcall	_prvCopyDataFromQueue
	.loc 1 1774 0
	mov	w10,[w8+6]
	.loc 1 1778 0
	mov	[w8+18],w0
	cp0	w0
	.set ___BP___,38
	bra	nz,.L180
.L164:
	.loc 1 1795 0
	rcall	_vPortExitCritical
	.loc 1 1796 0
	mov	#1,w0
.L165:
.LBE84:
	.loc 1 1877 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L183:
	.set ___PA___,0
.L177:
.LBB85:
	.loc 1 1813 0
	sub	w15,#14,w0
	rcall	_vTaskInternalSetTimeOutState
.LBE85:
	.loc 1 1823 0
	rcall	_vPortExitCritical
	.loc 1 1828 0
	rcall	_vTaskSuspendAll
	.loc 1 1829 0
	rcall	_vPortEnterCritical
	mov.b	[w8+34],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L168
	bra	.L178
.L179:
	clr.b	w0
	mov.b	w0,[w8+35]
	rcall	_vPortExitCritical
	.loc 1 1832 0
	sub	w15,#10,w1
	sub	w15,#14,w0
	rcall	_xTaskCheckForTimeOut
	cp0	w0
	.set ___BP___,50
	bra	z,.L181
.L170:
	.loc 1 1863 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1864 0
	rcall	_xTaskResumeAll
.LBB86:
.LBB82:
	.loc 1 2401 0
	rcall	_vPortEnterCritical
	.loc 1 2403 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,50
	bra	z,.L174
	.loc 1 2412 0
	rcall	_vPortExitCritical
	.loc 1 1869 0
	mov	#1,w11
	bra	.L182
.L178:
.LBE82:
.LBE86:
	.loc 1 1829 0
	clr.b	w0
	mov.b	w0,[w8+34]
	mov.b	[w8+35],w0
	add.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L169
	bra	.L179
.L174:
.LBB87:
.LBB80:
	.loc 1 2412 0
	rcall	_vPortExitCritical
	.loc 1 1869 0
	clr	w0
.LBE80:
.LBE87:
	.loc 1 1877 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L183
.L171:
.LBB88:
.LBB78:
	.loc 1 2412 0
	rcall	_vPortExitCritical
.LBE78:
.LBE88:
	.loc 1 1855 0
	mov	w8,w0
	rcall	_prvUnlockQueue
	.loc 1 1856 0
	rcall	_xTaskResumeAll
.LBB89:
.LBB83:
	.loc 1 1869 0
	mov	#1,w11
	bra	.L182
.L180:
.LBE83:
.LBE89:
.LBB90:
	.loc 1 1780 0
	add	w8,#18,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L164
	.loc 1 1783 0
; 1783 "../../../Source/queue.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 1795 0
	rcall	_vPortExitCritical
	.loc 1 1796 0
	mov	#1,w0
	bra	.L165
.LBE90:
.LFE8:
	.size	_xQueuePeek, .-_xQueuePeek
	.section	.text.xQueueReceiveFromISR,code
	.align	2
	.global	_xQueueReceiveFromISR	; export
	.type	_xQueueReceiveFromISR,@function
_xQueueReceiveFromISR:
.LFB9:
	.loc 1 1883 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI29:
	mov.d	w10,[w15++]
.LCFI30:
	mov	w12,[w15++]
.LCFI31:
	mov	w0,w8
	mov	w2,w11
.LBB91:
	.loc 1 1909 0
	mov	[w8+28],w9
	.loc 1 1963 0
	clr	w12
	.loc 1 1912 0
	cp0	w9
	.set ___BP___,38
	bra	nz,.L194
.L186:
.LBE91:
	.loc 1 1970 0
	mov	w12,w0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
.L196:
	.set ___PA___,0
.L194:
.LBB95:
.LBB92:
	.loc 1 1914 0
	mov.b	[w8+34],w10
	.loc 1 1918 0
	mov	w8,w0
	rcall	_prvCopyDataFromQueue
	.loc 1 1919 0
	dec	w9,w9
	mov	w9,[w8+28]
	.loc 1 1925 0
	add.b	w10,#1,[w15]
	.set ___BP___,48
	bra	z,.L195
.LBB93:
	.loc 1 1956 0
	rcall	_uxTaskGetNumberOfTasks
	se	w10,w1
	.loc 1 1959 0
	mov	#1,w12
	.loc 1 1956 0
	sub	w0,w1,[w15]
	.set ___BP___,39
	bra	leu,.L186
	inc.b	w10,w10
	mov.b	w10,[w8+34]
.LBE93:
.LBE92:
.LBE95:
	.loc 1 1970 0
	mov	w12,w0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L196
.L195:
.LBB96:
.LBB94:
	.loc 1 1927 0
	mov	[w8+8],w0
	.loc 1 1959 0
	mov	#1,w12
	.loc 1 1927 0
	cp0	w0
	.set ___BP___,61
	bra	z,.L186
	.loc 1 1929 0
	add	w8,#8,w0
	rcall	_xTaskRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L186
	.loc 1 1933 0
	cp0	w11
	.set ___BP___,15
	bra	z,.L186
	.loc 1 1935 0
	mov	w12,[w11]
.LBE94:
.LBE96:
	.loc 1 1970 0
	mov	w12,w0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L196
.LFE9:
	.size	_xQueueReceiveFromISR, .-_xQueueReceiveFromISR
	.section	.text.xQueuePeekFromISR,code
	.align	2
	.global	_xQueuePeekFromISR	; export
	.type	_xQueuePeekFromISR,@function
_xQueuePeekFromISR:
.LFB10:
	.loc 1 1975 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI32:
	mov	w0,w8
	.loc 1 2004 0
	mov	[w8+28],w2
	.loc 1 2018 0
	clr	w0
	.loc 1 2004 0
	cp0	w2
	.set ___BP___,38
	bra	nz,.L202
	.loc 1 2025 0
	mov.d	[--w15],w8
	return	
.L203:
	.set ___PA___,0
.L202:
	.loc 1 2010 0
	mov	[w8+6],w9
	.loc 1 2011 0
	mov	w8,w0
	rcall	_prvCopyDataFromQueue
	.loc 1 2012 0
	mov	w9,[w8+6]
	.loc 1 2014 0
	mov	#1,w0
	.loc 1 2025 0
	mov.d	[--w15],w8
	return	
	bra	.L203
.LFE10:
	.size	_xQueuePeekFromISR, .-_xQueuePeekFromISR
	.section	.text.uxQueueMessagesWaiting,code
	.align	2
	.global	_uxQueueMessagesWaiting	; export
	.type	_uxQueueMessagesWaiting,@function
_uxQueueMessagesWaiting:
.LFB11:
	.loc 1 2029 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI33:
	mov	w0,w8
	.loc 1 2034 0
	rcall	_vPortEnterCritical
	.loc 1 2036 0
	mov	[w8+28],w8
	.loc 1 2038 0
	rcall	_vPortExitCritical
	.loc 1 2041 0
	mov	w8,w0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE11:
	.size	_uxQueueMessagesWaiting, .-_uxQueueMessagesWaiting
	.section	.text.uxQueueSpacesAvailable,code
	.align	2
	.global	_uxQueueSpacesAvailable	; export
	.type	_uxQueueSpacesAvailable,@function
_uxQueueSpacesAvailable:
.LFB12:
	.loc 1 2045 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI34:
	mov	w0,w8
	.loc 1 2051 0
	rcall	_vPortEnterCritical
	.loc 1 2053 0
	mov	[w8+28],w0
	mov	[w8+30],w8
	sub	w8,w0,w8
	.loc 1 2055 0
	rcall	_vPortExitCritical
	.loc 1 2058 0
	mov	w8,w0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE12:
	.size	_uxQueueSpacesAvailable, .-_uxQueueSpacesAvailable
	.section	.text.uxQueueMessagesWaitingFromISR,code
	.align	2
	.global	_uxQueueMessagesWaitingFromISR	; export
	.type	_uxQueueMessagesWaitingFromISR,@function
_uxQueueMessagesWaitingFromISR:
.LFB13:
	.loc 1 2062 0
	.set ___PA___,1
	.loc 1 2067 0
	mov	[w0+28],w0
	.loc 1 2070 0
	return	
	.set ___PA___,0
.LFE13:
	.size	_uxQueueMessagesWaitingFromISR, .-_uxQueueMessagesWaitingFromISR
	.section	.text.vQueueDelete,code
	.align	2
	.global	_vQueueDelete	; export
	.type	_vQueueDelete,@function
_vQueueDelete:
.LFB14:
	.loc 1 2074 0
	.set ___PA___,1
	.loc 1 2090 0
	bra	_vPortFree
	.loc 1 2112 0
	.set ___PA___,0
.LFE14:
	.size	_vQueueDelete, .-_vQueueDelete
	.section	.text.xQueueIsQueueEmptyFromISR,code
	.align	2
	.global	_xQueueIsQueueEmptyFromISR	; export
	.type	_xQueueIsQueueEmptyFromISR,@function
_xQueueIsQueueEmptyFromISR:
.LFB19:
	.loc 1 2419 0
	.set ___PA___,1
	.loc 1 2425 0
	mov	[w0+28],w0
	.loc 1 2427 0
	btsc	w0,#15
	neg	w0,w0
	dec	w0,w0
	lsr	w0,#15,w0
	.loc 1 2435 0
	return	
	.set ___PA___,0
.LFE19:
	.size	_xQueueIsQueueEmptyFromISR, .-_xQueueIsQueueEmptyFromISR
	.section	.text.xQueueIsQueueFullFromISR,code
	.align	2
	.global	_xQueueIsQueueFullFromISR	; export
	.type	_xQueueIsQueueFullFromISR,@function
_xQueueIsQueueFullFromISR:
.LFB21:
	.loc 1 2460 0
	.set ___PA___,1
	.loc 1 2466 0
	mov	[w0+28],w1
	.loc 1 2468 0
	mov	[w0+30],w0
	xor	w1,w0,w0
	btsc	w0,#15
	neg	w0,w0
	dec	w0,w0
	lsr	w0,#15,w0
	.loc 1 2476 0
	return	
	.set ___PA___,0
.LFE21:
	.size	_xQueueIsQueueFullFromISR, .-_xQueueIsQueueFullFromISR
	.section	.text.xQueueCRSend,code
	.align	2
	.global	_xQueueCRSend	; export
	.type	_xQueueCRSend,@function
_xQueueCRSend:
.LFB22:
	.loc 1 2484 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI35:
	mov.d	w10,[w15++]
.LCFI36:
	mov	w0,w8
	mov	w1,w11
	mov	w2,w10
	.loc 1 2491 0
	mov	#-225,w9
	mov	_SRbits,w1
	and	w9,w1,w0
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 2491 "../../../Source/queue.c" 1
	NOP
.LBB97:
.LBB98:
	.loc 1 2442 0
	rcall	_vPortEnterCritical
	.loc 1 2444 0
	mov	[w8+28],w1
	mov	[w8+30],w0
	sub	w1,w0,[w15]
	.set ___BP___,28
	bra	z,.L232
	.loc 1 2453 0
	rcall	_vPortExitCritical
.LBE98:
.LBE97:
	.loc 1 2512 0
	mov	#_SRbits,w0
	and	w9,[w0],[w0]
	nop	
	.loc 1 2514 0
	mov	_SRbits,w1
	and	w9,w1,w9
	bset	w9,#5
	mov	w9,_SRbits
	nop	
; 2514 "../../../Source/queue.c" 1
	NOP
	.loc 1 2516 0
	mov	[w8+28],w1
	mov	[w8+30],w0
	sub	w1,w0,[w15]
	.set ___BP___,29
	bra	ltu,.L228
	.loc 1 2547 0
	clr	w0
.L227:
	.loc 1 2550 0
	mov	#-225,w1
	mov	#_SRbits,w2
	and	w1,[w2],[w2]
	nop	
.L226:
	.loc 1 2553 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
.L234:
	.set ___PA___,0
.L232:
.LBB100:
.LBB99:
	.loc 1 2453 0
	rcall	_vPortExitCritical
.LBE99:
.LBE100:
	.loc 1 2497 0
	cp0	w10
	.set ___BP___,4
	bra	nz,.L233
	.loc 1 2507 0
	mov	#_SRbits,w0
	and	w9,[w0],[w0]
	nop	
	.loc 1 2508 0
	clr	w0
	.loc 1 2553 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L234
.L228:
	.loc 1 2519 0
	clr	w2
	mov	w11,w1
	mov	w8,w0
	rcall	_prvCopyDataToQueue
	.loc 1 2523 0
	mov	[w8+18],w1
	.loc 1 2520 0
	mov	#1,w0
	.loc 1 2523 0
	cp0	w1
	.set ___BP___,71
	bra	z,.L227
	.loc 1 2529 0
	add	w8,#18,w0
	rcall	_xCoRoutineRemoveFromEventList
	mov	w0,w1
	.loc 1 2533 0
	mov	#-5,w0
	.loc 1 2529 0
	cp0	w1
	.set ___BP___,50
	bra	nz,.L227
	.loc 1 2520 0
	mov	#1,w0
	.loc 1 2550 0
	mov	#-225,w1
	mov	#_SRbits,w2
	and	w1,[w2],[w2]
	nop	
	bra	.L226
.L233:
	.loc 1 2501 0
	add	w8,#8,w1
	mov	w10,w0
	rcall	_vCoRoutineAddToDelayedList
	.loc 1 2502 0
	mov	#_SRbits,w2
	and	w9,[w2],[w2]
	nop	
	.loc 1 2503 0
	mov	#-4,w0
	.loc 1 2553 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L234
.LFE22:
	.size	_xQueueCRSend, .-_xQueueCRSend
	.section	.text.xQueueCRReceive,code
	.align	2
	.global	_xQueueCRReceive	; export
	.type	_xQueueCRReceive,@function
_xQueueCRReceive:
.LFB23:
	.loc 1 2563 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI37:
	mov	w0,w8
	mov	w1,w3
	.loc 1 2570 0
	mov	#-225,w9
	mov	_SRbits,w1
	and	w9,w1,w0
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 2570 "../../../Source/queue.c" 1
	NOP
	.loc 1 2572 0
	mov	[w8+28],w0
	cp0	w0
	.set ___BP___,29
	bra	nz,.L237
	.loc 1 2576 0
	cp0	w2
	.set ___BP___,4
	bra	nz,.L246
	.loc 1 2586 0
	mov	#_SRbits,w0
	and	w9,[w0],[w0]
	nop	
	.loc 1 2587 0
	clr	w0
	.loc 1 2647 0
	mov.d	[--w15],w8
	return	
.L249:
	.set ___PA___,0
.L237:
	.loc 1 2595 0
	mov	#_SRbits,w1
	and	w9,[w1],[w1]
	nop	
	.loc 1 2597 0
	mov	_SRbits,w2
	and	w9,w2,w9
	bset	w9,#5
	mov	w9,_SRbits
	nop	
; 2597 "../../../Source/queue.c" 1
	NOP
	.loc 1 2599 0
	mov	[w8+28],w1
	.loc 1 2641 0
	clr	w0
	.loc 1 2599 0
	cp0	w1
	.set ___BP___,50
	bra	z,.L240
	.loc 1 2602 0
	mov	[w8+32],w2
	mov	[w8+6],w1
	add	w1,w2,w1
	mov	w1,[w8+6]
	.loc 1 2604 0
	mov	[w8+4],w0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L241
	.loc 1 2606 0
	mov	[w8],w1
	mov	w1,[w8+6]
.L241:
	.loc 1 2613 0
	mov	[w8+28],w0
	dec	w0,w0
	mov	w0,[w8+28]
	.loc 1 2614 0
	mov	w3,w0
	rcall	_memcpy
	.loc 1 2619 0
	mov	[w8+8],w1
	.loc 1 2616 0
	mov	#1,w0
	.loc 1 2619 0
	cp0	w1
	.set ___BP___,29
	bra	nz,.L247
.L240:
	.loc 1 2644 0
	mov	#-225,w1
	mov	#_SRbits,w2
	and	w1,[w2],[w2]
	nop	
.L248:
	.loc 1 2647 0
	mov.d	[--w15],w8
	return	
	bra	.L249
.L247:
	.loc 1 2625 0
	add	w8,#8,w0
	rcall	_xCoRoutineRemoveFromEventList
	mov	w0,w1
	.loc 1 2627 0
	mov	#-5,w0
	.loc 1 2625 0
	cp0	w1
	.set ___BP___,50
	bra	nz,.L240
	.loc 1 2616 0
	mov	#1,w0
	.loc 1 2644 0
	mov	#-225,w1
	mov	#_SRbits,w2
	and	w1,[w2],[w2]
	nop	
	bra	.L248
.L246:
	.loc 1 2580 0
	add	w8,#18,w1
	mov	w2,w0
	rcall	_vCoRoutineAddToDelayedList
	.loc 1 2581 0
	mov	#_SRbits,w2
	and	w9,[w2],[w2]
	nop	
	.loc 1 2582 0
	mov	#-4,w0
	.loc 1 2647 0
	mov.d	[--w15],w8
	return	
	bra	.L249
.LFE23:
	.size	_xQueueCRReceive, .-_xQueueCRReceive
	.section	.text.xQueueCRSendFromISR,code
	.align	2
	.global	_xQueueCRSendFromISR	; export
	.type	_xQueueCRSendFromISR,@function
_xQueueCRSendFromISR:
.LFB24:
	.loc 1 2657 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI38:
	mov	w0,w8
	mov	w2,w9
	.loc 1 2662 0
	mov	[w8+28],w2
	mov	[w8+30],w0
	sub	w2,w0,[w15]
	.set ___BP___,29
	bra	ltu,.L254
.L252:
	.loc 1 2697 0
	mov	w9,w0
	mov.d	[--w15],w8
	return	
.L255:
	.set ___PA___,0
.L254:
	.loc 1 2664 0
	clr	w2
	mov	w8,w0
	rcall	_prvCopyDataToQueue
	.loc 1 2668 0
	cp0	w9
	.set ___BP___,50
	bra	nz,.L252
	.loc 1 2670 0
	mov	[w8+18],w0
	cp0	w0
	.set ___BP___,71
	bra	z,.L252
	.loc 1 2672 0
	add	w8,#18,w0
	rcall	_xCoRoutineRemoveFromEventList
	.loc 1 2654 0
	btsc	w0,#15
	neg	w0,w0
	neg	w0,w0
	lsr	w0,#15,w9
	.loc 1 2697 0
	mov	w9,w0
	mov.d	[--w15],w8
	return	
	bra	.L255
.LFE24:
	.size	_xQueueCRSendFromISR, .-_xQueueCRSendFromISR
	.section	.text.xQueueCRReceiveFromISR,code
	.align	2
	.global	_xQueueCRReceiveFromISR	; export
	.type	_xQueueCRReceiveFromISR,@function
_xQueueCRReceiveFromISR:
.LFB25:
	.loc 1 2707 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI39:
	mov	w10,[w15++]
.LCFI40:
	mov	w0,w8
	mov	w1,w0
	mov	w2,w9
	.loc 1 2713 0
	mov	[w8+28],w1
	.loc 1 2757 0
	clr	w10
	.loc 1 2713 0
	cp0	w1
	.set ___BP___,39
	bra	z,.L258
	.loc 1 2716 0
	mov	[w8+32],w2
	mov	[w8+6],w1
	add	w1,w2,w1
	mov	w1,[w8+6]
	.loc 1 2718 0
	mov	[w8+4],w3
	sub	w1,w3,[w15]
	.set ___BP___,50
	bra	ltu,.L259
	.loc 1 2720 0
	mov	[w8],w1
	mov	w1,[w8+6]
.L259:
	.loc 1 2727 0
	mov	[w8+28],w3
	dec	w3,w3
	mov	w3,[w8+28]
	.loc 1 2728 0
	rcall	_memcpy
	.loc 1 2753 0
	mov	#1,w10
	.loc 1 2730 0
	cp0	[w9]
	.set ___BP___,39
	bra	nz,.L258
	.loc 1 2732 0
	mov	[w8+8],w0
	cp0	w0
	.set ___BP___,38
	bra	nz,.L265
.L258:
	.loc 1 2761 0
	mov	w10,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
.L266:
	.set ___PA___,0
.L265:
	.loc 1 2734 0
	add	w8,#8,w0
	rcall	_xCoRoutineRemoveFromEventList
	cp0	w0
	.set ___BP___,39
	bra	z,.L258
	.loc 1 2736 0
	mov	w10,[w9]
	.loc 1 2761 0
	mov	w10,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L266
.LFE25:
	.size	_xQueueCRReceiveFromISR, .-_xQueueCRReceiveFromISR
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
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.byte	0x4
	.4byte	.LCFI0-.LFB15
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x13
	.sleb128 -5
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
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.byte	0x4
	.4byte	.LCFI2-.LFB17
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0x13
	.sleb128 -5
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
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI4-.LFB0
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI6-.LCFI4
	.byte	0x8a
	.uleb128 0x7
	.byte	0x88
	.uleb128 0x5
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI7-.LFB1
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI9-.LCFI7
	.byte	0x8a
	.uleb128 0x6
	.byte	0x88
	.uleb128 0x4
	.align	4
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI10-.LFB3
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI13-.LCFI10
	.byte	0x8c
	.uleb128 0xa
	.byte	0x8a
	.uleb128 0x8
	.byte	0x88
	.uleb128 0x6
	.align	4
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI14-.LFB4
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI15-.LCFI14
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI16-.LFB5
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI18-.LCFI16
	.byte	0x8a
	.uleb128 0x6
	.byte	0x88
	.uleb128 0x4
	.align	4
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI19-.LFB6
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI22-.LCFI19
	.byte	0x8c
	.uleb128 0xa
	.byte	0x8a
	.uleb128 0x8
	.byte	0x88
	.uleb128 0x6
	.align	4
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.byte	0x4
	.4byte	.LCFI23-.LFB7
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI25-.LCFI23
	.byte	0x8a
	.uleb128 0x8
	.byte	0x88
	.uleb128 0x6
	.align	4
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.byte	0x4
	.4byte	.LCFI26-.LFB8
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI28-.LCFI26
	.byte	0x8a
	.uleb128 0x8
	.byte	0x88
	.uleb128 0x6
	.align	4
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.byte	0x4
	.4byte	.LCFI29-.LFB9
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI30-.LCFI29
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI31-.LCFI30
	.byte	0x13
	.sleb128 -7
	.byte	0x8c
	.uleb128 0x6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.byte	0x4
	.4byte	.LCFI32-.LFB10
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.byte	0x4
	.4byte	.LCFI33-.LFB11
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.byte	0x4
	.4byte	.LCFI34-.LFB12
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.align	4
.LEFDE30:
.LSFDE32:
	.4byte	.LEFDE32-.LASFDE32
.LASFDE32:
	.4byte	.Lframe0
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.align	4
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.align	4
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.align	4
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.byte	0x4
	.4byte	.LCFI35-.LFB22
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI36-.LCFI35
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE38:
.LSFDE40:
	.4byte	.LEFDE40-.LASFDE40
.LASFDE40:
	.4byte	.Lframe0
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.byte	0x4
	.4byte	.LCFI37-.LFB23
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE40:
.LSFDE42:
	.4byte	.LEFDE42-.LASFDE42
.LASFDE42:
	.4byte	.Lframe0
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.byte	0x4
	.4byte	.LCFI38-.LFB24
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.byte	0x4
	.4byte	.LCFI39-.LFB25
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI40-.LCFI39
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE44:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h"
	.file 4 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 5 "../../../Source/include/list.h"
	.file 6 "../../../Source/include/task.h"
	.file 7 "../../../Source/include/queue.h"
	.section	.debug_info,info
	.4byte	0x151b
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../../Source/queue.c"
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
	.uleb128 0x3
	.asciz	"size_t"
	.byte	0x2
	.byte	0xdd
	.4byte	0x150
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
	.uleb128 0x3
	.asciz	"int8_t"
	.byte	0x2
	.byte	0x9a
	.4byte	0x192
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0x1b0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x150
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
	.byte	0x3
	.byte	0x88
	.4byte	0x2e9
	.uleb128 0x5
	.asciz	"C"
	.byte	0x3
	.byte	0x89
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0xf
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"Z"
	.byte	0x3
	.byte	0x8a
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0xe
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OV"
	.byte	0x3
	.byte	0x8b
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0xd
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"N"
	.byte	0x3
	.byte	0x8c
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0xc
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"RA"
	.byte	0x3
	.byte	0x8d
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0xb
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"IPL"
	.byte	0x3
	.byte	0x8e
	.4byte	0x1c1
	.byte	0x2
	.byte	0x3
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DC"
	.byte	0x3
	.byte	0x8f
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x7
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"DA"
	.byte	0x3
	.byte	0x90
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SAB"
	.byte	0x3
	.byte	0x91
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OAB"
	.byte	0x3
	.byte	0x92
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x4
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SB"
	.byte	0x3
	.byte	0x93
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"SA"
	.byte	0x3
	.byte	0x94
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x2
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OB"
	.byte	0x3
	.byte	0x95
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x1
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"OA"
	.byte	0x3
	.byte	0x96
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x0
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x4
	.byte	0x2
	.byte	0x3
	.byte	0x98
	.4byte	0x328
	.uleb128 0x5
	.asciz	"IPL0"
	.byte	0x3
	.byte	0x9a
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0xa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"IPL1"
	.byte	0x3
	.byte	0x9b
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x5
	.asciz	"IPL2"
	.byte	0x3
	.byte	0x9c
	.4byte	0x1c1
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x6
	.byte	0x2
	.byte	0x3
	.byte	0x87
	.4byte	0x33b
	.uleb128 0x7
	.4byte	0x200
	.uleb128 0x7
	.4byte	0x2e9
	.byte	0x0
	.uleb128 0x8
	.asciz	"tagSRBITS"
	.byte	0x2
	.byte	0x3
	.byte	0x86
	.4byte	0x356
	.uleb128 0x9
	.4byte	0x328
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x3
	.asciz	"SRBITS"
	.byte	0x3
	.byte	0x9f
	.4byte	0x33b
	.uleb128 0xa
	.byte	0x2
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x4
	.byte	0x61
	.4byte	0x378
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x4
	.byte	0x62
	.4byte	0x12c
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x4
	.byte	0x65
	.4byte	0x1c1
	.uleb128 0xb
	.byte	0x2
	.4byte	0x1a1
	.uleb128 0x8
	.asciz	"xLIST_ITEM"
	.byte	0xa
	.byte	0x5
	.byte	0x90
	.4byte	0x419
	.uleb128 0xc
	.4byte	.LASF0
	.byte	0x5
	.byte	0x93
	.4byte	0x398
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"pxNext"
	.byte	0x5
	.byte	0x94
	.4byte	0x419
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xc
	.4byte	.LASF1
	.byte	0x5
	.byte	0x95
	.4byte	0x419
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xd
	.asciz	"pvOwner"
	.byte	0x5
	.byte	0x96
	.4byte	0x364
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0xd
	.asciz	"pvContainer"
	.byte	0x5
	.byte	0x97
	.4byte	0x46d
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0xb
	.byte	0x2
	.4byte	0x3b0
	.uleb128 0x8
	.asciz	"xLIST"
	.byte	0xa
	.byte	0x5
	.byte	0xac
	.4byte	0x46d
	.uleb128 0xd
	.asciz	"uxNumberOfItems"
	.byte	0x5
	.byte	0xaf
	.4byte	0x4e1
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"pxIndex"
	.byte	0x5
	.byte	0xb0
	.4byte	0x4e6
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xd
	.asciz	"xListEnd"
	.byte	0x5
	.byte	0xb1
	.4byte	0x4cb
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0xb
	.byte	0x2
	.4byte	0x41f
	.uleb128 0x3
	.asciz	"ListItem_t"
	.byte	0x5
	.byte	0x9a
	.4byte	0x3b0
	.uleb128 0x8
	.asciz	"xMINI_LIST_ITEM"
	.byte	0x6
	.byte	0x5
	.byte	0x9d
	.4byte	0x4cb
	.uleb128 0xc
	.4byte	.LASF0
	.byte	0x5
	.byte	0xa0
	.4byte	0x398
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"pxNext"
	.byte	0x5
	.byte	0xa1
	.4byte	0x419
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xc
	.4byte	.LASF1
	.byte	0x5
	.byte	0xa2
	.4byte	0x419
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x3
	.asciz	"MiniListItem_t"
	.byte	0x5
	.byte	0xa4
	.4byte	0x485
	.uleb128 0xe
	.4byte	0x385
	.uleb128 0xb
	.byte	0x2
	.4byte	0x473
	.uleb128 0x3
	.asciz	"List_t"
	.byte	0x5
	.byte	0xb3
	.4byte	0x41f
	.uleb128 0x3
	.asciz	"TaskHandle_t"
	.byte	0x6
	.byte	0x57
	.4byte	0x50e
	.uleb128 0xb
	.byte	0x2
	.4byte	0x514
	.uleb128 0xf
	.asciz	"tskTaskControlBlock"
	.byte	0x1
	.uleb128 0x8
	.asciz	"xTIME_OUT"
	.byte	0x4
	.byte	0x6
	.byte	0x77
	.4byte	0x570
	.uleb128 0xd
	.asciz	"xOverflowCount"
	.byte	0x6
	.byte	0x79
	.4byte	0x366
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"xTimeOnEntering"
	.byte	0x6
	.byte	0x7a
	.4byte	0x398
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x3
	.asciz	"TimeOut_t"
	.byte	0x6
	.byte	0x7b
	.4byte	0x52a
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0x3
	.asciz	"QueueHandle_t"
	.byte	0x7
	.byte	0x33
	.4byte	0x59e
	.uleb128 0xb
	.byte	0x2
	.4byte	0x5a4
	.uleb128 0x8
	.asciz	"QueueDefinition"
	.byte	0x24
	.byte	0x1
	.byte	0x62
	.4byte	0x678
	.uleb128 0xd
	.asciz	"pcHead"
	.byte	0x1
	.byte	0x64
	.4byte	0x6b5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"pcWriteTo"
	.byte	0x1
	.byte	0x65
	.4byte	0x6b5
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0xd
	.asciz	"u"
	.byte	0x1
	.byte	0x6b
	.4byte	0x736
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0xd
	.asciz	"xTasksWaitingToSend"
	.byte	0x1
	.byte	0x6d
	.4byte	0x4ec
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xd
	.asciz	"xTasksWaitingToReceive"
	.byte	0x1
	.byte	0x6e
	.4byte	0x4ec
	.byte	0x2
	.byte	0x23
	.uleb128 0x12
	.uleb128 0xc
	.4byte	.LASF2
	.byte	0x1
	.byte	0x70
	.4byte	0x4e1
	.byte	0x2
	.byte	0x23
	.uleb128 0x1c
	.uleb128 0xd
	.asciz	"uxLength"
	.byte	0x1
	.byte	0x71
	.4byte	0x385
	.byte	0x2
	.byte	0x23
	.uleb128 0x1e
	.uleb128 0xc
	.4byte	.LASF3
	.byte	0x1
	.byte	0x72
	.4byte	0x385
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0xc
	.4byte	.LASF4
	.byte	0x1
	.byte	0x74
	.4byte	0x75c
	.byte	0x2
	.byte	0x23
	.uleb128 0x22
	.uleb128 0xc
	.4byte	.LASF5
	.byte	0x1
	.byte	0x75
	.4byte	0x75c
	.byte	0x2
	.byte	0x23
	.uleb128 0x23
	.byte	0x0
	.uleb128 0x8
	.asciz	"QueuePointers"
	.byte	0x4
	.byte	0x1
	.byte	0x43
	.4byte	0x6b5
	.uleb128 0xd
	.asciz	"pcTail"
	.byte	0x1
	.byte	0x45
	.4byte	0x6b5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"pcReadFrom"
	.byte	0x1
	.byte	0x46
	.4byte	0x6b5
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0xb
	.byte	0x2
	.4byte	0x184
	.uleb128 0x3
	.asciz	"QueuePointers_t"
	.byte	0x1
	.byte	0x47
	.4byte	0x678
	.uleb128 0x8
	.asciz	"SemaphoreData"
	.byte	0x4
	.byte	0x1
	.byte	0x49
	.4byte	0x71f
	.uleb128 0xd
	.asciz	"xMutexHolder"
	.byte	0x1
	.byte	0x4b
	.4byte	0x4fa
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0xd
	.asciz	"uxRecursiveCallCount"
	.byte	0x1
	.byte	0x4c
	.4byte	0x385
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x3
	.asciz	"SemaphoreData_t"
	.byte	0x1
	.byte	0x4d
	.4byte	0x6d2
	.uleb128 0x6
	.byte	0x4
	.byte	0x1
	.byte	0x67
	.4byte	0x75c
	.uleb128 0x10
	.4byte	.LASF6
	.byte	0x1
	.byte	0x69
	.4byte	0x6bb
	.uleb128 0x11
	.asciz	"xSemaphore"
	.byte	0x1
	.byte	0x6a
	.4byte	0x71f
	.byte	0x0
	.uleb128 0xe
	.4byte	0x184
	.uleb128 0x3
	.asciz	"xQUEUE"
	.byte	0x1
	.byte	0x83
	.4byte	0x5a4
	.uleb128 0x3
	.asciz	"Queue_t"
	.byte	0x1
	.byte	0x87
	.4byte	0x761
	.uleb128 0x12
	.asciz	"prvInitialiseNewQueue"
	.byte	0x1
	.2byte	0x1ec
	.byte	0x1
	.byte	0x1
	.4byte	0x7db
	.uleb128 0x13
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x1ec
	.4byte	0x7db
	.uleb128 0x13
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x1ed
	.4byte	0x7db
	.uleb128 0x13
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x1ee
	.4byte	0x3aa
	.uleb128 0x13
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x1ef
	.4byte	0x7e0
	.uleb128 0x13
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1f0
	.4byte	0x7e5
	.byte	0x0
	.uleb128 0x14
	.4byte	0x385
	.uleb128 0x14
	.4byte	0x1a1
	.uleb128 0xb
	.byte	0x2
	.4byte	0x76f
	.uleb128 0x15
	.asciz	"prvIsQueueFull"
	.byte	0x1
	.2byte	0x986
	.byte	0x1
	.4byte	0x366
	.byte	0x1
	.4byte	0x821
	.uleb128 0x13
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x986
	.4byte	0x821
	.uleb128 0x16
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x988
	.4byte	0x366
	.byte	0x0
	.uleb128 0xb
	.byte	0x2
	.4byte	0x827
	.uleb128 0x14
	.4byte	0x76f
	.uleb128 0x15
	.asciz	"prvIsQueueEmpty"
	.byte	0x1
	.2byte	0x95d
	.byte	0x1
	.4byte	0x366
	.byte	0x1
	.4byte	0x863
	.uleb128 0x13
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x95d
	.4byte	0x821
	.uleb128 0x16
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x95f
	.4byte	0x366
	.byte	0x0
	.uleb128 0x17
	.asciz	"prvCopyDataToQueue"
	.byte	0x1
	.2byte	0x87d
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB15
	.4byte	.LFE15
	.byte	0x1
	.byte	0x5f
	.4byte	0x8d8
	.uleb128 0x18
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x87d
	.4byte	0x8d8
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x87e
	.4byte	0x8dd
	.byte	0x1
	.byte	0x51
	.uleb128 0x19
	.asciz	"xPosition"
	.byte	0x1
	.2byte	0x87f
	.4byte	0x8e4
	.byte	0x1
	.byte	0x5a
	.uleb128 0x16
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x881
	.4byte	0x366
	.uleb128 0x1a
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x882
	.4byte	0x385
	.byte	0x1
	.byte	0x59
	.byte	0x0
	.uleb128 0x14
	.4byte	0x7e5
	.uleb128 0xb
	.byte	0x2
	.4byte	0x8e3
	.uleb128 0x1b
	.uleb128 0x14
	.4byte	0x366
	.uleb128 0x1c
	.asciz	"prvCopyDataFromQueue"
	.byte	0x1
	.2byte	0x8d0
	.byte	0x1
	.4byte	.LFB16
	.4byte	.LFE16
	.byte	0x1
	.byte	0x5f
	.4byte	0x92e
	.uleb128 0x18
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x8d0
	.4byte	0x8d8
	.byte	0x1
	.byte	0x53
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x8d1
	.4byte	0x92e
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x14
	.4byte	0x364
	.uleb128 0x1c
	.asciz	"prvUnlockQueue"
	.byte	0x1
	.2byte	0x8e5
	.byte	0x1
	.4byte	.LFB17
	.4byte	.LFE17
	.byte	0x1
	.byte	0x5f
	.4byte	0x998
	.uleb128 0x18
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x8e5
	.4byte	0x8d8
	.byte	0x1
	.byte	0x59
	.uleb128 0x1d
	.4byte	.LBB23
	.4byte	.LBE23
	.4byte	0x97f
	.uleb128 0x1a
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x8ef
	.4byte	0x184
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x1e
	.4byte	.LBB24
	.4byte	.LBE24
	.uleb128 0x1a
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x940
	.4byte	0x184
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueGenericReset"
	.byte	0x1
	.2byte	0x126
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0xa00
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x126
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x19
	.asciz	"xNewQueue"
	.byte	0x1
	.2byte	0x127
	.4byte	0x366
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x129
	.4byte	0x366
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x12a
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueGenericCreate"
	.byte	0x1
	.2byte	0x1aa
	.byte	0x1
	.4byte	0x589
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0xaad
	.uleb128 0x18
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x1aa
	.4byte	0x7db
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x1ab
	.4byte	0x7db
	.byte	0x1
	.byte	0x5a
	.uleb128 0x18
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x1ac
	.4byte	0x7e0
	.byte	0x1
	.byte	0x52
	.uleb128 0x1a
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1ae
	.4byte	0x7e5
	.byte	0x1
	.byte	0x59
	.uleb128 0x20
	.asciz	"xQueueSizeInBytes"
	.byte	0x1
	.2byte	0x1af
	.4byte	0x142
	.uleb128 0x16
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x1b0
	.4byte	0x3aa
	.uleb128 0x21
	.4byte	0x77e
	.4byte	.LBB27
	.4byte	.LBE27
	.uleb128 0x22
	.4byte	0x7ce
	.uleb128 0x22
	.4byte	0x7b6
	.uleb128 0x22
	.4byte	0x7aa
	.uleb128 0x22
	.4byte	0x79e
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueGenericSend"
	.byte	0x1
	.2byte	0x341
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0xb75
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x341
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x342
	.4byte	0xb75
	.byte	0x1
	.byte	0x59
	.uleb128 0x18
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x343
	.4byte	0x398
	.byte	0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x18
	.4byte	.LASF16
	.byte	0x1
	.2byte	0x344
	.4byte	0x8e4
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1a
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x346
	.4byte	0x366
	.byte	0x1
	.byte	0x5c
	.uleb128 0x23
	.asciz	"xYieldRequired"
	.byte	0x1
	.2byte	0x346
	.4byte	0x366
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x347
	.4byte	0x570
	.byte	0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x348
	.4byte	0x8d8
	.uleb128 0x21
	.4byte	0x7eb
	.4byte	.LBB31
	.4byte	.LBE31
	.uleb128 0x22
	.4byte	0x808
	.uleb128 0x1e
	.4byte	.LBB32
	.4byte	.LBE32
	.uleb128 0x24
	.4byte	0x814
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.4byte	0x8dd
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueGenericSendFromISR"
	.byte	0x1
	.2byte	0x415
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0xc5e
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x415
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x416
	.4byte	0xb75
	.byte	0x1
	.byte	0x51
	.uleb128 0x18
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x417
	.4byte	0xc5e
	.byte	0x1
	.byte	0x59
	.uleb128 0x18
	.4byte	.LASF16
	.byte	0x1
	.2byte	0x418
	.4byte	0x8e4
	.byte	0x1
	.byte	0x53
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x41a
	.4byte	0x366
	.byte	0x1
	.byte	0x5b
	.uleb128 0x16
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x41b
	.4byte	0x385
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x41c
	.4byte	0x8d8
	.uleb128 0x1e
	.4byte	.LBB35
	.4byte	.LBE35
	.uleb128 0x1a
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x43b
	.4byte	0xc69
	.byte	0x1
	.byte	0x5a
	.uleb128 0x23
	.asciz	"uxPreviousMessagesWaiting"
	.byte	0x1
	.2byte	0x43c
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LBB36
	.4byte	.LBE36
	.uleb128 0x1a
	.4byte	.LASF21
	.byte	0x1
	.2byte	0x4a9
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.4byte	0xc63
	.uleb128 0xb
	.byte	0x2
	.4byte	0x366
	.uleb128 0x14
	.4byte	0x184
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueGiveFromISR"
	.byte	0x1
	.2byte	0x4ba
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.4byte	0xd23
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x4ba
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x4bb
	.4byte	0xc5e
	.byte	0x1
	.byte	0x51
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x4bd
	.4byte	0x366
	.byte	0x1
	.byte	0x59
	.uleb128 0x16
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x4be
	.4byte	0x385
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x4bf
	.4byte	0x8d8
	.uleb128 0x1e
	.4byte	.LBB38
	.4byte	.LBE38
	.uleb128 0x1a
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x4e4
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LBB39
	.4byte	.LBE39
	.uleb128 0x1a
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x4eb
	.4byte	0xc69
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1e
	.4byte	.LBB40
	.4byte	.LBE40
	.uleb128 0x1a
	.4byte	.LASF21
	.byte	0x1
	.2byte	0x54f
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueReceive"
	.byte	0x1
	.2byte	0x560
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.4byte	0xe02
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x560
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x561
	.4byte	0x92e
	.byte	0x1
	.byte	0x59
	.uleb128 0x18
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x562
	.4byte	0x398
	.byte	0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x564
	.4byte	0x366
	.byte	0x1
	.byte	0x5c
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x565
	.4byte	0x570
	.byte	0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x566
	.4byte	0x8d8
	.uleb128 0x1d
	.4byte	.LBB43
	.4byte	.LBE43
	.4byte	0xdb9
	.uleb128 0x1a
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x57d
	.4byte	0x7db
	.byte	0x1
	.byte	0x5a
	.byte	0x0
	.uleb128 0x25
	.4byte	0x82c
	.4byte	.LBB44
	.4byte	.LBE44
	.4byte	0xddf
	.uleb128 0x22
	.4byte	0x84a
	.uleb128 0x1e
	.4byte	.LBB45
	.4byte	.LBE45
	.uleb128 0x24
	.4byte	0x856
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
	.4byte	0x82c
	.4byte	.LBB47
	.4byte	.LBE47
	.uleb128 0x22
	.4byte	0x84a
	.uleb128 0x1e
	.4byte	.LBB49
	.4byte	.LBE49
	.uleb128 0x24
	.4byte	0x856
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueSemaphoreTake"
	.byte	0x1
	.2byte	0x5ef
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB7
	.4byte	.LFE7
	.byte	0x1
	.byte	0x5f
	.4byte	0xee6
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x5ef
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x5f0
	.4byte	0x398
	.byte	0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x1a
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x5f2
	.4byte	0x366
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x5f3
	.4byte	0x570
	.byte	0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x5f4
	.4byte	0x8d8
	.uleb128 0x1d
	.4byte	.LBB59
	.4byte	.LBE59
	.4byte	0xe9d
	.uleb128 0x23
	.asciz	"uxSemaphoreCount"
	.byte	0x1
	.2byte	0x611
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x25
	.4byte	0x82c
	.4byte	.LBB60
	.4byte	.LBE60
	.4byte	0xec3
	.uleb128 0x22
	.4byte	0x84a
	.uleb128 0x1e
	.4byte	.LBB61
	.4byte	.LBE61
	.uleb128 0x24
	.4byte	0x856
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
	.4byte	0x82c
	.4byte	.LBB63
	.4byte	.LBE63
	.uleb128 0x22
	.4byte	0x84a
	.uleb128 0x1e
	.4byte	.LBB65
	.4byte	.LBE65
	.uleb128 0x24
	.4byte	0x856
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueuePeek"
	.byte	0x1
	.2byte	0x6c1
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.4byte	0xfd0
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x6c1
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x6c2
	.4byte	0x92e
	.byte	0x1
	.byte	0x59
	.uleb128 0x18
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x6c3
	.4byte	0x398
	.byte	0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x1a
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x6c5
	.4byte	0x366
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x6c6
	.4byte	0x570
	.byte	0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x1a
	.4byte	.LASF22
	.byte	0x1
	.2byte	0x6c7
	.4byte	0x6b5
	.byte	0x1
	.byte	0x5a
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x6c8
	.4byte	0x8d8
	.uleb128 0x1d
	.4byte	.LBB75
	.4byte	.LBE75
	.4byte	0xf87
	.uleb128 0x1a
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x6df
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x25
	.4byte	0x82c
	.4byte	.LBB76
	.4byte	.LBE76
	.4byte	0xfad
	.uleb128 0x22
	.4byte	0x84a
	.uleb128 0x1e
	.4byte	.LBB77
	.4byte	.LBE77
	.uleb128 0x24
	.4byte	0x856
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
	.4byte	0x82c
	.4byte	.LBB79
	.4byte	.LBE79
	.uleb128 0x22
	.4byte	0x84a
	.uleb128 0x1e
	.4byte	.LBB81
	.4byte	.LBE81
	.uleb128 0x24
	.4byte	0x856
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueReceiveFromISR"
	.byte	0x1
	.2byte	0x758
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB9
	.4byte	.LFE9
	.byte	0x1
	.byte	0x5f
	.4byte	0x1096
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x758
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x759
	.4byte	0x92e
	.byte	0x1
	.byte	0x51
	.uleb128 0x18
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x75a
	.4byte	0xc5e
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x75c
	.4byte	0x366
	.byte	0x1
	.byte	0x5c
	.uleb128 0x16
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x75d
	.4byte	0x385
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x75e
	.4byte	0x8d8
	.uleb128 0x1e
	.4byte	.LBB91
	.4byte	.LBE91
	.uleb128 0x1a
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x775
	.4byte	0x7db
	.byte	0x1
	.byte	0x59
	.uleb128 0x1e
	.4byte	.LBB92
	.4byte	.LBE92
	.uleb128 0x1a
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x77a
	.4byte	0xc69
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1e
	.4byte	.LBB93
	.4byte	.LBE93
	.uleb128 0x1a
	.4byte	.LASF21
	.byte	0x1
	.2byte	0x7a4
	.4byte	0x7db
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueuePeekFromISR"
	.byte	0x1
	.2byte	0x7b5
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB10
	.4byte	.LFE10
	.byte	0x1
	.byte	0x5f
	.4byte	0x1111
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x7b5
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x7b6
	.4byte	0x92e
	.byte	0x1
	.byte	0x51
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x7b8
	.4byte	0x366
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x7b9
	.4byte	0x385
	.uleb128 0x1a
	.4byte	.LASF22
	.byte	0x1
	.2byte	0x7ba
	.4byte	0x6b5
	.byte	0x1
	.byte	0x59
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x7bb
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"uxQueueMessagesWaiting"
	.byte	0x1
	.2byte	0x7ec
	.byte	0x1
	.4byte	0x385
	.4byte	.LFB11
	.4byte	.LFE11
	.byte	0x1
	.byte	0x5f
	.4byte	0x115d
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x7ec
	.4byte	0x115d
	.byte	0x1
	.byte	0x58
	.uleb128 0x1a
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x7ee
	.4byte	0x385
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x14
	.4byte	0x589
	.uleb128 0x1f
	.byte	0x1
	.asciz	"uxQueueSpacesAvailable"
	.byte	0x1
	.2byte	0x7fc
	.byte	0x1
	.4byte	0x385
	.4byte	.LFB12
	.4byte	.LFE12
	.byte	0x1
	.byte	0x5f
	.4byte	0x11ba
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x7fc
	.4byte	0x115d
	.byte	0x1
	.byte	0x58
	.uleb128 0x1a
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x7fe
	.4byte	0x385
	.byte	0x1
	.byte	0x58
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x7ff
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"uxQueueMessagesWaitingFromISR"
	.byte	0x1
	.2byte	0x80d
	.byte	0x1
	.4byte	0x385
	.4byte	.LFB13
	.4byte	.LFE13
	.byte	0x1
	.byte	0x5f
	.4byte	0x1219
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x80d
	.4byte	0x115d
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x80f
	.4byte	0x385
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x810
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x26
	.byte	0x1
	.asciz	"vQueueDelete"
	.byte	0x1
	.2byte	0x819
	.byte	0x1
	.4byte	.LFB14
	.4byte	.LFE14
	.byte	0x1
	.byte	0x5f
	.4byte	0x1255
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x819
	.4byte	0x589
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x81b
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueIsQueueEmptyFromISR"
	.byte	0x1
	.2byte	0x972
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB19
	.4byte	.LFE19
	.byte	0x1
	.byte	0x5f
	.4byte	0x12ae
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x972
	.4byte	0x115d
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x974
	.4byte	0x366
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x975
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueIsQueueFullFromISR"
	.byte	0x1
	.2byte	0x99b
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB21
	.4byte	.LFE21
	.byte	0x1
	.byte	0x5f
	.4byte	0x1306
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x99b
	.4byte	0x115d
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x99d
	.4byte	0x366
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x99e
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueCRSend"
	.byte	0x1
	.2byte	0x9b1
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB22
	.4byte	.LFE22
	.byte	0x1
	.byte	0x5f
	.4byte	0x1392
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x9b1
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x9b2
	.4byte	0x8dd
	.byte	0x1
	.byte	0x5b
	.uleb128 0x18
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x9b3
	.4byte	0x398
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x9b5
	.4byte	0x366
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x9b6
	.4byte	0x8d8
	.uleb128 0x21
	.4byte	0x7eb
	.4byte	.LBB97
	.4byte	.LBE97
	.uleb128 0x22
	.4byte	0x808
	.uleb128 0x1e
	.4byte	.LBB98
	.4byte	.LBE98
	.uleb128 0x24
	.4byte	0x814
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueCRReceive"
	.byte	0x1
	.2byte	0xa00
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB23
	.4byte	.LFE23
	.byte	0x1
	.byte	0x5f
	.4byte	0x13ff
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0xa00
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0xa01
	.4byte	0x364
	.byte	0x1
	.byte	0x53
	.uleb128 0x18
	.4byte	.LASF15
	.byte	0x1
	.2byte	0xa02
	.4byte	0x398
	.byte	0x1
	.byte	0x52
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xa04
	.4byte	0x366
	.byte	0x1
	.byte	0x50
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0xa05
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueCRSendFromISR"
	.byte	0x1
	.2byte	0xa5e
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB24
	.4byte	.LFE24
	.byte	0x1
	.byte	0x5f
	.4byte	0x1478
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0xa5e
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF13
	.byte	0x1
	.2byte	0xa5f
	.4byte	0x8dd
	.byte	0x1
	.byte	0x51
	.uleb128 0x19
	.asciz	"xCoRoutinePreviouslyWoken"
	.byte	0x1
	.2byte	0xa60
	.4byte	0x366
	.byte	0x1
	.byte	0x59
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0xa62
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x1f
	.byte	0x1
	.asciz	"xQueueCRReceiveFromISR"
	.byte	0x1
	.2byte	0xa90
	.byte	0x1
	.4byte	0x366
	.4byte	.LFB25
	.4byte	.LFE25
	.byte	0x1
	.byte	0x5f
	.4byte	0x14f9
	.uleb128 0x18
	.4byte	.LASF6
	.byte	0x1
	.2byte	0xa90
	.4byte	0x589
	.byte	0x1
	.byte	0x58
	.uleb128 0x18
	.4byte	.LASF14
	.byte	0x1
	.2byte	0xa91
	.4byte	0x364
	.byte	0x1
	.byte	0x50
	.uleb128 0x19
	.asciz	"pxCoRoutineWoken"
	.byte	0x1
	.2byte	0xa92
	.4byte	0xc63
	.byte	0x1
	.byte	0x59
	.uleb128 0x1a
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xa94
	.4byte	0x366
	.byte	0x1
	.byte	0x5a
	.uleb128 0x16
	.4byte	.LASF11
	.byte	0x1
	.2byte	0xa95
	.4byte	0x8d8
	.byte	0x0
	.uleb128 0x27
	.asciz	"SRbits"
	.byte	0x3
	.byte	0xa0
	.4byte	0x1509
	.byte	0x1
	.byte	0x1
	.uleb128 0xe
	.4byte	0x356
	.uleb128 0x27
	.asciz	"SRbits"
	.byte	0x3
	.byte	0xa0
	.4byte	0x1509
	.byte	0x1
	.byte	0x1
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
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
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
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
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
	.uleb128 0x13
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
	.uleb128 0x5
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
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.uleb128 0x26
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
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
	.uleb128 0x1d
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x1e
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
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
	.uleb128 0x20
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
	.uleb128 0x21
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
	.uleb128 0x22
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x23
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
	.uleb128 0x24
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x25
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
	.uleb128 0x26
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
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x1ea
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x151f
	.4byte	0x998
	.asciz	"xQueueGenericReset"
	.4byte	0xa00
	.asciz	"xQueueGenericCreate"
	.4byte	0xaad
	.asciz	"xQueueGenericSend"
	.4byte	0xb7a
	.asciz	"xQueueGenericSendFromISR"
	.4byte	0xc6e
	.asciz	"xQueueGiveFromISR"
	.4byte	0xd23
	.asciz	"xQueueReceive"
	.4byte	0xe02
	.asciz	"xQueueSemaphoreTake"
	.4byte	0xee6
	.asciz	"xQueuePeek"
	.4byte	0xfd0
	.asciz	"xQueueReceiveFromISR"
	.4byte	0x1096
	.asciz	"xQueuePeekFromISR"
	.4byte	0x1111
	.asciz	"uxQueueMessagesWaiting"
	.4byte	0x1162
	.asciz	"uxQueueSpacesAvailable"
	.4byte	0x11ba
	.asciz	"uxQueueMessagesWaitingFromISR"
	.4byte	0x1219
	.asciz	"vQueueDelete"
	.4byte	0x1255
	.asciz	"xQueueIsQueueEmptyFromISR"
	.4byte	0x12ae
	.asciz	"xQueueIsQueueFullFromISR"
	.4byte	0x1306
	.asciz	"xQueueCRSend"
	.4byte	0x1392
	.asciz	"xQueueCRReceive"
	.4byte	0x13ff
	.asciz	"xQueueCRSendFromISR"
	.4byte	0x1478
	.asciz	"xQueueCRReceiveFromISR"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x194
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x151f
	.4byte	0x142
	.asciz	"size_t"
	.4byte	0x184
	.asciz	"int8_t"
	.4byte	0x1a1
	.asciz	"uint8_t"
	.4byte	0x1c1
	.asciz	"uint16_t"
	.4byte	0x33b
	.asciz	"tagSRBITS"
	.4byte	0x356
	.asciz	"SRBITS"
	.4byte	0x366
	.asciz	"BaseType_t"
	.4byte	0x385
	.asciz	"UBaseType_t"
	.4byte	0x398
	.asciz	"TickType_t"
	.4byte	0x3b0
	.asciz	"xLIST_ITEM"
	.4byte	0x473
	.asciz	"ListItem_t"
	.4byte	0x485
	.asciz	"xMINI_LIST_ITEM"
	.4byte	0x4cb
	.asciz	"MiniListItem_t"
	.4byte	0x41f
	.asciz	"xLIST"
	.4byte	0x4ec
	.asciz	"List_t"
	.4byte	0x4fa
	.asciz	"TaskHandle_t"
	.4byte	0x52a
	.asciz	"xTIME_OUT"
	.4byte	0x570
	.asciz	"TimeOut_t"
	.4byte	0x589
	.asciz	"QueueHandle_t"
	.4byte	0x678
	.asciz	"QueuePointers"
	.4byte	0x6bb
	.asciz	"QueuePointers_t"
	.4byte	0x6d2
	.asciz	"SemaphoreData"
	.4byte	0x71f
	.asciz	"SemaphoreData_t"
	.4byte	0x5a4
	.asciz	"QueueDefinition"
	.4byte	0x761
	.asciz	"xQUEUE"
	.4byte	0x76f
	.asciz	"Queue_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0xcc
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF19:
	.asciz	"pxHigherPriorityTaskWoken"
.LASF8:
	.asciz	"pucQueueStorage"
.LASF4:
	.asciz	"cRxLock"
.LASF9:
	.asciz	"ucQueueType"
.LASF10:
	.asciz	"pxNewQueue"
.LASF17:
	.asciz	"xEntryTimeSet"
.LASF12:
	.asciz	"xReturn"
.LASF22:
	.asciz	"pcOriginalReadPosition"
.LASF5:
	.asciz	"cTxLock"
.LASF1:
	.asciz	"pxPrevious"
.LASF13:
	.asciz	"pvItemToQueue"
.LASF14:
	.asciz	"pvBuffer"
.LASF11:
	.asciz	"pxQueue"
.LASF20:
	.asciz	"uxSavedInterruptStatus"
.LASF7:
	.asciz	"uxQueueLength"
.LASF2:
	.asciz	"uxMessagesWaiting"
.LASF18:
	.asciz	"xTimeOut"
.LASF0:
	.asciz	"xItemValue"
.LASF15:
	.asciz	"xTicksToWait"
.LASF3:
	.asciz	"uxItemSize"
.LASF6:
	.asciz	"xQueue"
.LASF23:
	.asciz	"uxReturn"
.LASF21:
	.asciz	"uxNumberOfTasks"
.LASF16:
	.asciz	"xCopyPosition"
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
