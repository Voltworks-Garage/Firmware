	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\..\\Source\\tasks.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.prvAddCurrentTaskToDelayedList,code
	.align	2
	.type	_prvAddCurrentTaskToDelayedList,@function
_prvAddCurrentTaskToDelayedList:
.LFB42:
	.file 1 "../../../Source/tasks.c"
	.loc 1 5299 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI0:
	mov	w10,[w15++]
.LCFI1:
	mov	w0,w8
	mov	w1,w10
	.loc 1 5301 0
	mov	_xTickCount,w9
	.loc 1 5314 0
	inc2	_pxCurrentTCB,WREG
	rcall	_uxListRemove
	.loc 1 5327 0
	add	w8,#1,[w15]
	.set ___BP___,28
	bra	z,.L6
.L2:
	.loc 1 5339 0
	add	w8,w9,w8
	.loc 1 5342 0
	mov	_pxCurrentTCB,w0
	mov	w8,[w0+2]
	.loc 1 5344 0
	sub	w9,w8,[w15]
	.set ___BP___,39
	bra	gtu,.L7
	.loc 1 5354 0
	mov	_pxCurrentTCB,w1
	mov	_pxDelayedTaskList,w0
	inc2	w1,w1
	rcall	_vListInsert
	.loc 1 5359 0
	mov	_xNextTaskUnblockTime,w0
	sub	w0,w8,[w15]
	.set ___BP___,39
	bra	leu,.L1
	.loc 1 5361 0
	mov	w8,_xNextTaskUnblockTime
.L1:
	.loc 1 5407 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
.L8:
	.set ___PA___,0
.L6:
	.loc 1 5327 0
	cp0	w10
	.set ___BP___,61
	bra	z,.L2
.LBB42:
	.loc 1 5332 0
	mov	_xSuspendedTaskList+2,w0
	mov	_pxCurrentTCB,w1
	mov	w0,[w1+4]
	mov	_pxCurrentTCB,w1
	mov	[w0+4],w2
	mov	w2,[w1+6]
	mov	[w0+4],w1
	mov	_pxCurrentTCB,w2
	inc2	w2,w2
	mov	w2,[w1+2]
	mov	_pxCurrentTCB,w1
	inc2	w1,w1
	mov	w1,[w0+4]
	mov	_pxCurrentTCB,w0
	mov	#_xSuspendedTaskList,w1
	mov	w1,[w0+10]
	mov	_xSuspendedTaskList,w0
	inc	w0,w0
	mov	w0,_xSuspendedTaskList
.LBE42:
	.loc 1 5407 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L8
.L7:
	.loc 1 5348 0
	mov	_pxCurrentTCB,w1
	mov	_pxOverflowDelayedTaskList,w0
	inc2	w1,w1
	rcall	_vListInsert
	.loc 1 5407 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L8
.LFE42:
	.size	_prvAddCurrentTaskToDelayedList, .-_prvAddCurrentTaskToDelayedList
	.section	.text.prvIdleTask,code
	.align	2
	.type	_prvIdleTask,@function
_prvIdleTask:
.LFB29:
	.loc 1 3428 0
	.set ___PA___,0
.L12:
	.loc 1 3467 0
	mov	_pxReadyTasksLists,w0
	sub	w0,#1,[w15]
	.set ___BP___,27
	bra	leu,.L11
	.loc 1 3469 0
; 3469 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L11:
.LBB43:
	.loc 1 3487 0
	rcall	_vApplicationIdleHook
.LBE43:
	.loc 1 3540 0
	bra	.L12
.LFE29:
	.size	_prvIdleTask, .-_prvIdleTask
	.section	.text.xTaskCreate,code
	.align	2
	.global	_xTaskCreate	; export
	.type	_xTaskCreate,@function
_xTaskCreate:
.LFB0:
	.loc 1 727 0
	.set ___PA___,0
	add	w15,#6,w15
.LCFI2:
	mov.d	w8,[w15++]
.LCFI3:
	mov.d	w10,[w15++]
.LCFI4:
	mov.d	w12,[w15++]
.LCFI5:
	mov	w14,[w15++]
.LCFI6:
	mov.d	w0,w8
	mov	w2,w10
	mov	w3,w14
	mov	w4,[w15-18]
	mov	w5,w13
	.loc 1 739 0
	mov	#38,w0
	rcall	_pvPortMalloc
	mov	w0,w11
	.loc 1 807 0
	setm	w1
	.loc 1 741 0
	cp0	w11
	.set ___BP___,30
	bra	z,.L16
	.loc 1 743 0
	
	repeat	#19-1
	clr	[w11++]
	
	sub	#38, w11
	.loc 1 748 0
	add	w10,w10,w0
	mov	w1,[w15-16]
	rcall	_pvPortMalloc
	mov	w0,w12
	mov	w12,[w11+24]
	.loc 1 750 0
	cp0	w12
	.set ___BP___,6
	bra	z,.L37
.LBB51:
.LBB53:
	.loc 1 880 0
	sl	w10,w10
	dec2	w10,w10
	add	w12,w10,w10
	mov	w10,[w11+30]
	.loc 1 885 0
	cp0	w9
	.set ___BP___,15
	bra	z,.L28
	.loc 1 721 0
	add	w11,#25,w1
.LBE53:
.LBE51:
	clr	w0
.L19:
	mov	w9,w2
.LBB55:
.LBB52:
	.loc 1 889 0
	mov.b	[w9++],[++w1]
	.loc 1 894 0
	cp0.b	[w2]
	.set ___BP___,4
	bra	z,.L18
	.loc 1 887 0
	inc	w0,w0
	sub	w0,#4,[w15]
	.set ___BP___,73
	bra	nz,.L19
.L18:
	.loc 1 906 0
	clr.b	w0
	mov.b	w0,[w11+29]
.L28:
	mov	[w15-18],w10
	sub	w10,#3,[w15]
	.set ___BP___,50
	bra	gtu,.L38
.L20:
	.loc 1 925 0
	mov	w10,[w11+22]
	.loc 1 932 0
	inc2	w11,w9
	mov	w9,w0
	rcall	_vListInitialiseItem
	.loc 1 933 0
	add	w11,#12,w0
	rcall	_vListInitialiseItem
	.loc 1 937 0
	mov	w11,[w11+8]
	.loc 1 940 0
	subr	w10,#4,w10
	mov	w10,[w11+12]
	.loc 1 941 0
	mov	w11,[w11+18]
	.loc 1 1007 0
	mov	w14,w2
	mov	w8,w1
	mov	w12,w0
	rcall	_pxPortInitialiseStack
	mov	w0,[w11]
	.loc 1 1013 0
	cp0	w13
	.set ___BP___,15
	bra	z,.L21
	.loc 1 1017 0
	mov	w11,[w13]
.L21:
.LBE52:
.LBE55:
.LBB56:
.LBB57:
	.loc 1 1030 0
	rcall	_vPortEnterCritical
	.loc 1 1032 0
	inc	_uxCurrentNumberOfTasks
	.loc 1 1034 0
	cp0	_pxCurrentTCB
	.set ___BP___,15
	bra	z,.L39
	.loc 1 1057 0
	cp0	_xSchedulerRunning
	.set ___BP___,50
	bra	nz,.L35
	.loc 1 1059 0
	mov	_pxCurrentTCB,w1
	mov	[w11+22],w0
	mov	[w1+22],w1
	mov	#_pxReadyTasksLists,w8
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	leu,.L40
.L24:
	.loc 1 1074 0
	inc	_uxTaskNumber
	.loc 1 1084 0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L27
	mov	w0,_uxTopReadyPriority
.L27:
.LBB58:
	mulw.su	w0,#10,w2
	add	w8,w2,w0
	mov	[w0+2],w0
	mov	w0,[w11+4]
	mov	[w0+4],w1
	mov	w1,[w11+6]
	mov	[w0+4],w1
	mov	w9,[w1+2]
	mov	w9,[w0+4]
	add	w8,w2,w8
	mov	w8,[w11+10]
	inc	[w8],[w8]
.LBE58:
	.loc 1 1088 0
	rcall	_vPortExitCritical
	.loc 1 803 0
	mov	#1,w1
	.loc 1 1090 0
	cp0	_xSchedulerRunning
	.set ___BP___,39
	bra	z,.L16
	.loc 1 1094 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w2
	mov	[w11+22],w0
	sub	w2,w0,[w15]
	.set ___BP___,39
	bra	geu,.L16
	.loc 1 1096 0
; 1096 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L16:
.LBE57:
.LBE56:
	.loc 1 811 0
	mov	w1,w0
	mov	[--w15],w14
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	sub	w15,#6
	return	
.L41:
	.set ___PA___,0
.L38:
.LBB62:
.LBB54:
	.loc 1 906 0
	mov	#3,w10
	bra	.L20
.L39:
.LBE54:
.LBE62:
.LBB63:
.LBB61:
	.loc 1 1038 0
	mov	w11,_pxCurrentTCB
	.loc 1 1040 0
	mov	_uxCurrentNumberOfTasks,w0
	sub	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L23
.L35:
	.loc 1 1057 0
	mov	[w11+22],w0
	mov	#_pxReadyTasksLists,w8
	bra	.L24
.L40:
	.loc 1 1061 0
	mov	w11,_pxCurrentTCB
	bra	.L24
.L23:
	.loc 1 1040 0
	clr	w10
	mov	#_pxReadyTasksLists,w8
.L25:
.LBB59:
.LBB60:
	.loc 1 3663 0
	mulw.su	w10,#10,w0
	add	w8,w0,w0
	rcall	_vListInitialise
	.loc 1 3661 0
	inc	w10,w10
	sub	w10,#4,[w15]
	.set ___BP___,74
	bra	nz,.L25
	.loc 1 3666 0
	mov	#_xDelayedTaskList1,w0
	rcall	_vListInitialise
	.loc 1 3667 0
	mov	#_xDelayedTaskList2,w0
	rcall	_vListInitialise
	.loc 1 3668 0
	mov	#_xPendingReadyList,w0
	rcall	_vListInitialise
	.loc 1 3678 0
	mov	#_xSuspendedTaskList,w0
	rcall	_vListInitialise
	.loc 1 3684 0
	mov	#_xDelayedTaskList1,w0
	mov	w0,_pxDelayedTaskList
	.loc 1 3685 0
	mov	#_xDelayedTaskList2,w0
	mov	w0,_pxOverflowDelayedTaskList
	mov	[w11+22],w0
	bra	.L24
.L37:
.LBE60:
.LBE59:
.LBE61:
.LBE63:
	.loc 1 753 0
	mov	w11,w0
	rcall	_vPortFree
	mov	[w15-16], w0
	.loc 1 811 0
	mov	[--w15],w14
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	sub	w15,#6
	return	
	bra	.L41
.LFE0:
	.size	_xTaskCreate, .-_xTaskCreate
	.section	.text.vTaskPrioritySet,code
	.align	2
	.global	_vTaskPrioritySet	; export
	.type	_vTaskPrioritySet,@function
_vTaskPrioritySet:
.LFB5:
	.loc 1 1509 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI7:
	mov.d	w10,[w15++]
.LCFI8:
	mov	w0,w8
	mov	w1,w10
	.loc 1 1512 0
	sub	w10,#3,[w15]
	.set ___BP___,50
	bra	leu,.L44
	mov	#3,w10
.L44:
	.loc 1 1526 0
	rcall	_vPortEnterCritical
	.loc 1 1530 0
	cp0	w8
	.set ___BP___,15
	bra	z,.L56
.L45:
	.loc 1 1540 0
	mov	[w8+22],w0
	.loc 1 1544 0
	sub	w0,w10,[w15]
	.set ___BP___,19
	bra	z,.L46
	.loc 1 1548 0
	.set ___BP___,50
	bra	geu,.L47
	.loc 1 1512 0
	clr	w9
	.loc 1 1550 0
	mov	_pxCurrentTCB,w1
	sub	w1,w8,[w15]
	.set ___BP___,15
	bra	z,.L48
	.loc 1 1555 0
	mov	_pxCurrentTCB,w1
	.loc 1 1557 0
	mov	#1,w9
	mov	[w1+22],w1
	sub	w1,w10,[w15]
	.set ___BP___,50
	bra	gtu,.L57
.L48:
	.loc 1 1608 0
	mov	w10,[w8+22]
	.loc 1 1614 0
	mov	[w8+12],w1
	cp0	w1
	.set ___BP___,27
	bra	lt,.L50
	.loc 1 1616 0
	subr	w10,#4,w10
	mov	w10,[w8+12]
.L50:
	.loc 1 1627 0
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w10
	add	w10,w0,w0
	mov	[w8+10],w1
	sub	w1,w0,[w15]
	.set ___BP___,6
	bra	z,.L58
.L51:
	.loc 1 1651 0
	cp0	w9
	.set ___BP___,39
	bra	z,.L46
	.loc 1 1653 0
; 1653 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L46:
	.loc 1 1665 0
	rcall	_vPortExitCritical
	.loc 1 1666 0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L47:
	.loc 1 1557 0
	mov	_pxCurrentTCB,w1
	xor	w1,w8,w9
	btsc	w9,#15
	neg	w9,w9
	dec	w9,w9
	lsr	w9,#15,w9
	bra	.L48
.L57:
	clr	w9
	bra	.L48
.L56:
	.loc 1 1530 0
	mov	_pxCurrentTCB,w8
	bra	.L45
.L58:
	.loc 1 1632 0
	inc2	w8,w11
	mov	w11,w0
	rcall	_uxListRemove
	.loc 1 1644 0
	mov	[w8+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L52
	mov	w0,_uxTopReadyPriority
.L52:
.LBB64:
	mulw.su	w0,#10,w2
	add	w10,w2,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w1
	mov	w1,[w8+6]
	mov	[w0+4],w1
	mov	w11,[w1+2]
	mov	w11,[w0+4]
	add	w10,w2,w10
	mov	w10,[w8+10]
	inc	[w10],[w10]
	bra	.L51
.LBE64:
.LFE5:
	.size	_vTaskPrioritySet, .-_vTaskPrioritySet
	.section	.text.vTaskResume,code
	.align	2
	.global	_vTaskResume	; export
	.type	_vTaskResume,@function
_vTaskResume:
.LFB8:
	.loc 1 1826 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI9:
	mov	w0,w8
	.loc 1 1834 0
	mov	_pxCurrentTCB,w0
	sub	w0,w8,[w15]
	.set ___BP___,10
	bra	z,.L60
	cp0	w8
	.set ___BP___,21
	bra	z,.L60
	.loc 1 1836 0
	rcall	_vPortEnterCritical
.LBB65:
.LBB66:
	.loc 1 1791 0
	mov	[w8+10],w1
	mov	#_xSuspendedTaskList,w0
	sub	w1,w0,[w15]
	.set ___BP___,15
	bra	z,.L67
.L62:
.LBE66:
.LBE65:
	.loc 1 1865 0
	rcall	_vPortExitCritical
.L60:
	.loc 1 1871 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L67:
.LBB68:
.LBB67:
	.loc 1 1794 0
	mov	[w8+20],w0
	mov	#_xPendingReadyList,w1
	sub	w0,w1,[w15]
	.set ___BP___,15
	bra	z,.L62
	.loc 1 1798 0
	cp0	w0
	.set ___BP___,85
	bra	nz,.L62
.LBE67:
.LBE68:
	.loc 1 1844 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 1845 0
	mov	[w8+22],w3
	mov	_uxTopReadyPriority,w0
	sub	w0,w3,[w15]
	.set ___BP___,50
	bra	geu,.L65
	mov	w3,_uxTopReadyPriority
.L65:
.LBB69:
	mulw.su	w3,#10,w2
	mov	#_pxReadyTasksLists,w1
	add	w1,w2,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w4
	mov	w4,[w8+6]
	mov	[w0+4],w4
	mov	w9,[w4+2]
	mov	w9,[w0+4]
	add	w2,w1,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
.LBE69:
	.loc 1 1848 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	sub	w3,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L62
	.loc 1 1853 0
; 1853 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 1865 0
	rcall	_vPortExitCritical
	bra	.L60
.LFE8:
	.size	_vTaskResume, .-_vTaskResume
	.section	.text.xTaskResumeFromISR,code
	.align	2
	.global	_xTaskResumeFromISR	; export
	.type	_xTaskResumeFromISR,@function
_xTaskResumeFromISR:
.LFB9:
	.loc 1 1880 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI10:
	mov	w10,[w15++]
.LCFI11:
	mov	w0,w8
.LBB70:
.LBB71:
	.loc 1 1791 0
	mov	[w8+10],w1
	.loc 1 1881 0
	clr	w9
	.loc 1 1791 0
	mov	#_xSuspendedTaskList,w0
	sub	w1,w0,[w15]
	.set ___BP___,15
	bra	z,.L81
.L70:
.LBE71:
.LBE70:
	.loc 1 1949 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
.L83:
	.set ___PA___,0
.L81:
.LBB73:
.LBB72:
	.loc 1 1794 0
	mov	[w8+20],w1
	mov	#_xPendingReadyList,w0
	sub	w1,w0,[w15]
	.set ___BP___,15
	bra	z,.L70
	.loc 1 1798 0
	cp0	w1
	.set ___BP___,85
	bra	nz,.L70
.LBE72:
.LBE73:
	.loc 1 1912 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,29
	bra	nz,.L82
	.loc 1 1916 0
	mov	_pxCurrentTCB,w0
	mov	[w8+22],w1
	mov	[w0+22],w0
	.loc 1 1881 0
	clr	w9
	.loc 1 1916 0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L72
	.loc 1 1923 0
	mov	#1,w9
	mov	w9,_xYieldPending
.L72:
	.loc 1 1930 0
	inc2	w8,w10
	mov	w10,w0
	rcall	_uxListRemove
	.loc 1 1931 0
	mov	[w8+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,39
	bra	geu,.L73
	mov	w0,_uxTopReadyPriority
.L73:
.LBB74:
	mulw.su	w0,#10,w2
	mov	#_pxReadyTasksLists,w1
	add	w1,w2,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w3
	mov	w3,[w8+6]
	mov	[w0+4],w3
	mov	w10,[w3+2]
	mov	w10,[w0+4]
	add	w2,w1,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
.LBE74:
	.loc 1 1949 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L83
.L82:
	.loc 1 1938 0
	add	w8,#12,w1
	rcall	_vListInsertEnd
	.loc 1 1949 0
	clr	w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L83
.LFE9:
	.size	_xTaskResumeFromISR, .-_xTaskResumeFromISR
	.section	.const,psv,page
.LC0:
	.asciz	"IDLE"
	.section	.text.vTaskStartScheduler,code
	.align	2
	.global	_vTaskStartScheduler	; export
	.type	_vTaskStartScheduler,@function
_vTaskStartScheduler:
.LFB10:
	.loc 1 1955 0
	.set ___PA___,0
	.loc 1 1988 0
	mov	#_xIdleTaskHandle,w5
	clr	w4
	mov	w4,w3
	mov	#105,w2
	mov	#.LC0,w1
	mov	#handle(_prvIdleTask),w0
	rcall	_xTaskCreate
	.loc 1 2010 0
	sub	w0,#1,[w15]
	.set ___BP___,19
	bra	z,.L88
	.loc 1 2075 0
	mov	_uxTopUsedPriority,w0
	.loc 1 2076 0
	return	
.L89:
	.set ___PA___,0
.L88:
	.loc 1 2026 0
	mov	#-225,w1
	mov	_SRbits,w2
	and	w1,w2,w1
	bset	w1,#5
	mov	w1,_SRbits
	nop	
; 2026 "../../../Source/tasks.c" 1
	NOP
	.loc 1 2036 0
	setm	_xNextTaskUnblockTime
	.loc 1 2037 0
	mov	w0,_xSchedulerRunning
	.loc 1 2038 0
	clr	_xTickCount
	.loc 1 2052 0
	rcall	_xPortStartScheduler
	.loc 1 2075 0
	mov	_uxTopUsedPriority,w0
	.loc 1 2076 0
	return	
	bra	.L89
.LFE10:
	.size	_vTaskStartScheduler, .-_vTaskStartScheduler
	.section	.text.vTaskEndScheduler,code
	.align	2
	.global	_vTaskEndScheduler	; export
	.type	_vTaskEndScheduler,@function
_vTaskEndScheduler:
.LFB11:
	.loc 1 2080 0
	.set ___PA___,0
	.loc 1 2084 0
	mov	#-225,w0
	and	_SRbits,WREG
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 2084 "../../../Source/tasks.c" 1
	NOP
	.loc 1 2085 0
	clr	_xSchedulerRunning
	.loc 1 2086 0
	bra	_vPortEndScheduler
	.loc 1 2087 0
	.set ___PA___,0
.LFE11:
	.size	_vTaskEndScheduler, .-_vTaskEndScheduler
	.section	.text.vTaskSuspendAll,code
	.align	2
	.global	_vTaskSuspendAll	; export
	.type	_vTaskSuspendAll,@function
_vTaskSuspendAll:
.LFB12:
	.loc 1 2091 0
	.set ___PA___,1
	.loc 1 2103 0
	inc	_uxSchedulerSuspended
	.loc 1 2108 0
	return	
	.set ___PA___,0
.LFE12:
	.size	_vTaskSuspendAll, .-_vTaskSuspendAll
	.section	.text.xTaskGetTickCount,code
	.align	2
	.global	_xTaskGetTickCount	; export
	.type	_xTaskGetTickCount,@function
_xTaskGetTickCount:
.LFB14:
	.loc 1 2287 0
	.set ___PA___,1
	.loc 1 2293 0
	mov	_xTickCount,w0
	.loc 1 2298 0
	return	
	.set ___PA___,0
.LFE14:
	.size	_xTaskGetTickCount, .-_xTaskGetTickCount
	.section	.text.xTaskGetTickCountFromISR,code
	.align	2
	.global	_xTaskGetTickCountFromISR	; export
	.type	_xTaskGetTickCountFromISR,@function
_xTaskGetTickCountFromISR:
.LFB15:
	.loc 1 2302 0
	.set ___PA___,1
	.loc 1 2324 0
	mov	_xTickCount,w0
	.loc 1 2329 0
	return	
	.set ___PA___,0
.LFE15:
	.size	_xTaskGetTickCountFromISR, .-_xTaskGetTickCountFromISR
	.section	.text.uxTaskGetNumberOfTasks,code
	.align	2
	.global	_uxTaskGetNumberOfTasks	; export
	.type	_uxTaskGetNumberOfTasks,@function
_uxTaskGetNumberOfTasks:
.LFB16:
	.loc 1 2333 0
	.set ___PA___,1
	.loc 1 2336 0
	mov	_uxCurrentNumberOfTasks,w0
	.loc 1 2337 0
	return	
	.set ___PA___,0
.LFE16:
	.size	_uxTaskGetNumberOfTasks, .-_uxTaskGetNumberOfTasks
	.section	.text.pcTaskGetName,code
	.align	2
	.global	_pcTaskGetName	; export
	.type	_pcTaskGetName,@function
_pcTaskGetName:
.LFB17:
	.loc 1 2341 0
	.set ___PA___,1
	.loc 1 2346 0
	cp0	w0
	.set ___BP___,21
	bra	z,.L110
	.loc 1 2348 0
	add	w0,#26,w0
	.loc 1 2349 0
	return	
.L111:
	.set ___PA___,0
.L110:
	.loc 1 2346 0
	mov	_pxCurrentTCB,w0
	.loc 1 2348 0
	add	w0,#26,w0
	.loc 1 2349 0
	return	
	bra	.L111
.LFE17:
	.size	_pcTaskGetName, .-_pcTaskGetName
	.section	.text.xTaskIncrementTick,code
	.align	2
	.global	_xTaskIncrementTick	; export
	.type	_xTaskIncrementTick,@function
_xTaskIncrementTick:
.LFB19:
	.loc 1 2721 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI12:
	.loc 1 2731 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L114
.LBB75:
	.loc 1 2735 0
	mov	_xTickCount,w7
	inc	w7,w7
	.loc 1 2739 0
	mov	w7,_xTickCount
	.loc 1 2741 0
	.set ___BP___,50
	bra	nz,.L115
.LBB80:
	.loc 1 2743 0
	mov	_pxDelayedTaskList,w0
	mov	_pxOverflowDelayedTaskList,w1
	mov	w1,_pxDelayedTaskList
	mov	w0,_pxOverflowDelayedTaskList
	inc	_xNumOfOverflows
.LBB81:
.LBB82:
	.loc 1 4001 0
	mov	_pxDelayedTaskList,w0
	cp0	[w0]
	.set ___BP___,50
	bra	nz,.L116
	.loc 1 4007 0
	setm	_xNextTaskUnblockTime
.L115:
.LBE82:
.LBE81:
.LBE80:
	.loc 1 2754 0
	mov	_xNextTaskUnblockTime,w9
	sub	w9,w7,[w15]
	.set ___BP___,50
	bra	gtu,.L129
.L139:
	clr	w8
	mov	#_pxReadyTasksLists,w5
.LBB79:
	.loc 1 2793 0
	mov	w8,w6
.L133:
.LBE79:
	.loc 1 2758 0
	mov	_pxDelayedTaskList,w1
	cp0	[w1]
	.set ___BP___,4
	bra	z,.L135
.L119:
	.loc 1 2774 0
	mov	_pxDelayedTaskList,w0
	mov	[w0+6],w0
	mov	[w0+6],w1
	.loc 1 2775 0
	mov	[w1+2],w0
	.loc 1 2777 0
	sub	w7,w0,[w15]
	.set ___BP___,4
	bra	ltu,.L136
.LBB78:
	.loc 1 2793 0
	mov	[w1+10],w2
	mov	[w1+4],w3
	mov	[w1+6],w0
	mov	w0,[w3+4]
	mov	[w1+6],w0
	mov	w3,[w0+2]
	inc2	w1,w3
	mov	[w2+2],w4
	sub	w4,w3,[w15]
	.set ___BP___,15
	bra	z,.L137
.L121:
	mov	w6,[w1+10]
	dec	[w2],[w2]
.LBE78:
	.loc 1 2797 0
	mov	[w1+20],w2
	cp0	w2
	.set ___BP___,15
	bra	z,.L122
.LBB77:
	.loc 1 2799 0
	mov	[w1+14],w4
	mov	[w1+16],w9
	mov	w9,[w4+4]
	mov	[w1+16],w0
	mov	w4,[w0+2]
	add	w1,#12,w4
	mov	[w2+2],w9
	sub	w9,w4,[w15]
	.set ___BP___,15
	bra	z,.L138
	mov	w6,[w1+20]
	dec	[w2],[w2]
.L122:
.LBE77:
	.loc 1 2808 0
	mov	[w1+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L124
	mov	w0,_uxTopReadyPriority
.L124:
.LBB76:
	mulw.su	w0,#10,w4
	add	w5,w4,w2
	mov	[w2+2],w2
	mov	w2,[w1+4]
	mov	[w2+4],w9
	mov	w9,[w1+6]
	mov	[w2+4],w9
	mov	w3,[w9+2]
	mov	w3,[w2+4]
	add	w5,w4,w2
	mov	w2,[w1+10]
	inc	[w2],[w2]
.LBE76:
	.loc 1 2822 0
	mov	_pxCurrentTCB,w1
	mov	[w1+22],w1
	sub	w0,w1,[w15]
	.set ___BP___,50
	bra	leu,.L133
	.loc 1 2824 0
	mov	#1,w8
	.loc 1 2758 0
	mov	_pxDelayedTaskList,w1
	cp0	[w1]
	.set ___BP___,95
	bra	nz,.L119
.L135:
	.loc 1 2765 0
	setm	_xNextTaskUnblockTime
.L117:
	.loc 1 2841 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	mulw.su	w0,#10,w0
	add	w5,w0,w5
	mov	#1,w0
	subr	w0,[w5],[w15]
	.set ___BP___,27
	bra	leu,.L127
	.loc 1 2843 0
	mov	w0,w8
.L127:
	.loc 1 2869 0
	cp0	_xYieldPending
	.set ___BP___,50
	bra	z,.L128
	.loc 1 2871 0
	mov	#1,w8
.L128:
.LBE75:
	.loc 1 2894 0
	mov	w8,w0
	mov.d	[--w15],w8
	return	
.L140:
	.set ___PA___,0
.L114:
	.loc 1 2882 0
	inc	_xPendedTicks
	.loc 1 2894 0
	clr	w0
	mov.d	[--w15],w8
	return	
	bra	.L140
.L129:
.LBB88:
	.loc 1 2724 0
	clr	w8
	mov	#_pxReadyTasksLists,w5
	bra	.L117
.L137:
.LBB85:
	.loc 1 2793 0
	mov	w0,[w2+2]
	bra	.L121
.L138:
.LBE85:
.LBB86:
	.loc 1 2799 0
	mov	w0,[w2+2]
	mov	w6,[w1+20]
	dec	[w2],[w2]
	bra	.L122
.L116:
.LBE86:
.LBB87:
.LBB84:
.LBB83:
	.loc 1 4015 0
	mov	_pxDelayedTaskList,w0
	mov	[w0+6],w0
	mov	[w0],w0
	mov	w0,_xNextTaskUnblockTime
.LBE83:
.LBE84:
.LBE87:
	.loc 1 2754 0
	mov	_xNextTaskUnblockTime,w9
	sub	w9,w7,[w15]
	.set ___BP___,50
	bra	gtu,.L129
	bra	.L139
.L136:
	.loc 1 2784 0
	mov	w0,_xNextTaskUnblockTime
	.loc 1 2785 0
	bra	.L117
.LBE88:
.LFE19:
	.size	_xTaskIncrementTick, .-_xTaskIncrementTick
	.section	.text.xTaskResumeAll,code
	.align	2
	.global	_xTaskResumeAll	; export
	.type	_xTaskResumeAll,@function
_xTaskResumeAll:
.LFB13:
	.loc 1 2175 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI13:
	.loc 1 2188 0
	rcall	_vPortEnterCritical
	.loc 1 2190 0
	dec	_uxSchedulerSuspended
	.loc 1 2177 0
	clr	w8
	.loc 1 2192 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,39
	bra	nz,.L143
	.loc 1 2194 0
	cp0	_uxCurrentNumberOfTasks
	.set ___BP___,39
	bra	z,.L143
	.loc 1 2200 0
	mov	_xPendingReadyList+6,w7
	mov	w8,w0
.LBB89:
	.loc 1 2201 0
	mov	w0,w6
.LBE89:
.LBB90:
	.loc 1 2204 0
	mov	#_pxReadyTasksLists,w5
.LBE90:
	.loc 1 2210 0
	mov	#1,w8
.L162:
	.loc 1 2198 0
	mov	_xPendingReadyList,w1
	cp0	w1
	.set ___BP___,9
	bra	z,.L164
.L149:
	.loc 1 2200 0
	mov	[w7+6],w0
.LBB91:
	.loc 1 2201 0
	mov	[w0+20],w1
	mov	[w0+14],w2
	mov	[w0+16],w3
	mov	w3,[w2+4]
	mov	[w0+16],w3
	mov	w2,[w3+2]
	add	w0,#12,w2
	mov	[w1+2],w4
	sub	w4,w2,[w15]
	.set ___BP___,15
	bra	z,.L165
	mov	w6,[w0+20]
	dec	[w1],[w1]
.LBE91:
.LBB92:
	.loc 1 2203 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w9
	mov	w9,[w2+4]
	mov	[w0+6],w4
	mov	w2,[w4+2]
	inc2	w0,w3
	mov	[w1+2],w2
	sub	w2,w3,[w15]
	.set ___BP___,15
	bra	z,.L166
.L146:
	mov	w6,[w0+10]
	dec	[w1],[w1]
.LBE92:
	.loc 1 2204 0
	mov	[w0+22],w2
	mov	_uxTopReadyPriority,w1
	sub	w1,w2,[w15]
	.set ___BP___,50
	bra	geu,.L147
	mov	w2,_uxTopReadyPriority
.L147:
.LBB93:
	mulw.su	w2,#10,w4
	add	w5,w4,w1
	mov	[w1+2],w1
	mov	w1,[w0+4]
	mov	[w1+4],w9
	mov	w9,[w0+6]
	mov	[w1+4],w9
	mov	w3,[w9+2]
	mov	w3,[w1+4]
	add	w4,w5,w1
	mov	w1,[w0+10]
	inc	[w1],[w1]
.LBE93:
	.loc 1 2208 0
	mov	_pxCurrentTCB,w1
	mov	[w1+22],w1
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	ltu,.L162
	.loc 1 2210 0
	mov	w8,_xYieldPending
	.loc 1 2198 0
	mov	_xPendingReadyList,w1
	cp0	w1
	.set ___BP___,91
	bra	nz,.L149
.L164:
	.loc 1 2218 0
	cp0	w0
	.set ___BP___,15
	bra	z,.L150
.LBB94:
.LBB95:
	.loc 1 4001 0
	mov	_pxDelayedTaskList,w0
	cp0	[w0]
	.set ___BP___,50
	bra	nz,.L151
	.loc 1 4007 0
	setm	_xNextTaskUnblockTime
.L150:
.LBE95:
.LBE94:
.LBB97:
	.loc 1 2234 0
	mov	_xPendedTicks,w8
	.loc 1 2236 0
	cp0	w8
	.set ___BP___,50
	bra	nz,.L167
.L152:
.LBE97:
	.loc 1 2177 0
	clr	w8
	.loc 1 2260 0
	cp0	_xYieldPending
	.set ___BP___,39
	bra	z,.L143
	.loc 1 2267 0
; 2267 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 2264 0
	mov	#1,w8
.L143:
	.loc 1 2280 0
	rcall	_vPortExitCritical
	.loc 1 2283 0
	mov	w8,w0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L166:
.LBB98:
	.loc 1 2203 0
	mov	w4,[w1+2]
	bra	.L146
.L165:
.LBE98:
.LBB99:
	.loc 1 2201 0
	mov	w3,[w1+2]
	mov	w6,[w0+20]
	dec	[w1],[w1]
.LBE99:
.LBB100:
	.loc 1 2203 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w9
	mov	w9,[w2+4]
	mov	[w0+6],w4
	mov	w2,[w4+2]
	inc2	w0,w3
	mov	[w1+2],w2
	sub	w2,w3,[w15]
	.set ___BP___,85
	bra	nz,.L146
	bra	.L166
.L167:
.LBE100:
.LBB101:
	.loc 1 2242 0
	mov	#1,w9
.L159:
	.loc 1 2240 0
	rcall	_xTaskIncrementTick
	cp0	w0
	.set ___BP___,50
	bra	z,.L153
	.loc 1 2242 0
	mov	w9,_xYieldPending
.L153:
	.loc 1 2249 0
	dec	w8,w8
	.loc 1 2250 0
	.set ___BP___,86
	bra	nz,.L159
	.loc 1 2252 0
	clr	_xPendedTicks
	bra	.L152
.L151:
.LBE101:
.LBB102:
.LBB96:
	.loc 1 4015 0
	mov	_pxDelayedTaskList,w0
	mov	[w0+6],w0
	mov	[w0],w0
	mov	w0,_xNextTaskUnblockTime
.LBE96:
.LBE102:
.LBB103:
	.loc 1 2234 0
	mov	_xPendedTicks,w8
	.loc 1 2236 0
	cp0	w8
	.set ___BP___,50
	bra	z,.L152
	bra	.L167
.LBE103:
.LFE13:
	.size	_xTaskResumeAll, .-_xTaskResumeAll
	.section	.text.xTaskCatchUpTicks,code
	.align	2
	.global	_xTaskCatchUpTicks	; export
	.type	_xTaskCatchUpTicks,@function
_xTaskCatchUpTicks:
.LFB18:
	.loc 1 2617 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI14:
	mov	w0,w8
.LBB104:
.LBB105:
	.loc 1 2103 0
	inc	_uxSchedulerSuspended
.LBE105:
.LBE104:
	.loc 1 2629 0
	rcall	_vPortEnterCritical
	.loc 1 2631 0
	mov	w8,w0
	add	_xPendedTicks
	.loc 1 2633 0
	rcall	_vPortExitCritical
	.loc 1 2634 0
	rcall	_xTaskResumeAll
	.loc 1 2637 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE18:
	.size	_xTaskCatchUpTicks, .-_xTaskCatchUpTicks
	.section	.text.vTaskDelay,code
	.align	2
	.global	_vTaskDelay	; export
	.type	_vTaskDelay,@function
_vTaskDelay:
.LFB4:
	.loc 1 1302 0
	.set ___PA___,0
	.loc 1 1306 0
	cp0	w0
	.set ___BP___,29
	bra	nz,.L177
.L173:
	.loc 1 1333 0
; 1333 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	return	
.L177:
.LBB106:
.LBB107:
	.loc 1 2103 0
	inc	_uxSchedulerSuspended
.LBE107:
.LBE106:
	.loc 1 1320 0
	clr	w1
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 1322 0
	rcall	_xTaskResumeAll
	.loc 1 1331 0
	cp0	w0
	.set ___BP___,0
	bra	z,.L173
	return	
.LFE4:
	.size	_vTaskDelay, .-_vTaskDelay
	.section	.text.xTaskDelayUntil,code
	.align	2
	.global	_xTaskDelayUntil	; export
	.type	_xTaskDelayUntil,@function
_xTaskDelayUntil:
.LFB3:
	.loc 1 1216 0
	.set ___PA___,0
	mov	w8,[w15++]
.LCFI15:
.LBB108:
.LBB109:
	.loc 1 2103 0
	inc	_uxSchedulerSuspended
.LBE109:
.LBE108:
.LBB110:
	.loc 1 1228 0
	mov	_xTickCount,w3
	.loc 1 1231 0
	mov	[w0],w2
	add	w1,w2,w1
	.loc 1 1233 0
	sub	w3,w2,[w15]
	.set ___BP___,50
	bra	geu,.L180
	.loc 1 1240 0
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	leu,.L181
.L186:
	.loc 1 1254 0
	sub	w3,w1,[w15]
	.set ___BP___,50
	bra	geu,.L181
	.loc 1 1265 0
	mov	w1,[w0]
	.loc 1 1273 0
	sub	w1,w3,w0
	clr	w1
	rcall	_prvAddCurrentTaskToDelayedList
	mov	#1,w8
.L184:
.LBE110:
	.loc 1 1280 0
	rcall	_xTaskResumeAll
	.loc 1 1284 0
	cp0	w0
	.set ___BP___,39
	bra	nz,.L183
	.loc 1 1286 0
; 1286 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L183:
	.loc 1 1294 0
	mov	w8,w0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.L180:
.LBB111:
	.loc 1 1254 0
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	leu,.L186
	.loc 1 1265 0
	mov	w1,[w0]
	.loc 1 1273 0
	sub	w1,w3,w0
	clr	w1
	rcall	_prvAddCurrentTaskToDelayedList
	mov	#1,w8
	bra	.L184
.L181:
	.loc 1 1265 0
	mov	w1,[w0]
	clr	w8
	bra	.L184
.LBE111:
.LFE3:
	.size	_xTaskDelayUntil, .-_xTaskDelayUntil
	.section	.text.vTaskSwitchContext,code
	.align	2
	.global	_vTaskSwitchContext	; export
	.type	_vTaskSwitchContext,@function
_vTaskSwitchContext:
.LFB20:
	.loc 1 3010 0
	.set ___PA___,1
	.loc 1 3011 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,39
	bra	nz,.L199
	.loc 1 3019 0
	clr	_xYieldPending
.LBB112:
	.loc 1 3062 0
	mov	_uxTopReadyPriority,w0
	mulw.su	w0,#10,w2
	mov	#_pxReadyTasksLists,w1
	add	w1,w2,w3
	cp0	[w3]
	.set ___BP___,25
	bra	nz,.L193
.L196:
	dec	w0,w0
	mulw.su	w0,#10,w2
	add	w1,w2,w3
	cp0	[w3]
	.set ___BP___,75
	bra	z,.L196
.L193:
.LBB113:
	add	w1,w2,w3
	mov	[w3+2],w3
	mov	[w3+2],w3
	add	w1,w2,w4
	mov	w3,[++w4]
	add	w2,#4,w2
	add	w1,w2,w1
	sub	w3,w1,[w15]
	.set ___BP___,15
	bra	z,.L200
	mov	[w3+6],w3
	mov	w3,_pxCurrentTCB
.LBE113:
	mov	w0,_uxTopReadyPriority
	return	
.L199:
.LBE112:
	.loc 1 3015 0
	mov	#1,w0
	mov	w0,_xYieldPending
	return	
.L200:
.LBB115:
.LBB114:
	.loc 1 3062 0
	mov	[w3+2],w3
	mov	w3,[w4]
	mov	[w3+6],w3
	mov	w3,_pxCurrentTCB
.LBE114:
	mov	w0,_uxTopReadyPriority
	return	
.LBE115:
.LFE20:
	.size	_vTaskSwitchContext, .-_vTaskSwitchContext
	.section	.text.vTaskSuspend,code
	.align	2
	.global	_vTaskSuspend	; export
	.type	_vTaskSuspend,@function
_vTaskSuspend:
.LFB6:
	.loc 1 1674 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI16:
	mov	w0,w8
	.loc 1 1677 0
	rcall	_vPortEnterCritical
	.loc 1 1681 0
	cp0	w8
	.set ___BP___,15
	bra	z,.L214
.L203:
	.loc 1 1687 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 1697 0
	mov	[w8+20],w0
	cp0	w0
	.set ___BP___,30
	bra	z,.L204
	.loc 1 1699 0
	add	w8,#12,w0
	rcall	_uxListRemove
.L204:
	.loc 1 1706 0
	mov	w9,w1
	mov	#_xSuspendedTaskList,w0
	rcall	_vListInsertEnd
.LBB116:
	.loc 1 1714 0
	mov.b	[w8+36],w0
	sub.b	w0,#1,[w15]
	.set ___BP___,28
	bra	z,.L215
.LBE116:
	.loc 1 1724 0
	rcall	_vPortExitCritical
	.loc 1 1726 0
	cp0	_xSchedulerRunning
	.set ___BP___,29
	bra	nz,.L216
.L206:
	.loc 1 1741 0
	mov	_pxCurrentTCB,w0
	sub	w0,w8,[w15]
	.set ___BP___,21
	bra	z,.L217
.L202:
	.loc 1 1772 0
	mov.d	[--w15],w8
	return	
.L221:
	.set ___PA___,0
.L216:
	.loc 1 1730 0
	rcall	_vPortEnterCritical
.LBB117:
.LBB118:
	.loc 1 4001 0
	mov	_pxDelayedTaskList,w0
	cp0	[w0]
	.set ___BP___,50
	bra	nz,.L207
	.loc 1 4007 0
	setm	_xNextTaskUnblockTime
.LBE118:
.LBE117:
	.loc 1 1734 0
	rcall	_vPortExitCritical
.L220:
	.loc 1 1741 0
	mov	_pxCurrentTCB,w0
	sub	w0,w8,[w15]
	.set ___BP___,78
	bra	nz,.L202
	bra	.L217
.L215:
.LBB120:
	.loc 1 1718 0
	clr.b	w0
	mov.b	w0,[w8+36]
.LBE120:
	.loc 1 1724 0
	rcall	_vPortExitCritical
	.loc 1 1726 0
	cp0	_xSchedulerRunning
	.set ___BP___,71
	bra	z,.L206
	bra	.L216
.L217:
	.loc 1 1743 0
	cp0	_xSchedulerRunning
	.set ___BP___,39
	bra	nz,.L218
	.loc 1 1754 0
	mov	_xSuspendedTaskList,w0
	cp	_uxCurrentNumberOfTasks
	.set ___BP___,37
	bra	z,.L219
	.loc 1 1764 0
	rcall	_vTaskSwitchContext
	.loc 1 1772 0
	mov.d	[--w15],w8
	return	
	bra	.L221
.L214:
	.loc 1 1681 0
	mov	_pxCurrentTCB,w8
	bra	.L203
.L207:
.LBB121:
.LBB119:
	.loc 1 4015 0
	mov	_pxDelayedTaskList,w0
	mov	[w0+6],w0
	mov	[w0],w0
	mov	w0,_xNextTaskUnblockTime
.LBE119:
.LBE121:
	.loc 1 1734 0
	rcall	_vPortExitCritical
	bra	.L220
.L218:
	.loc 1 1747 0
; 1747 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 1772 0
	mov.d	[--w15],w8
	return	
	bra	.L221
.L219:
	.loc 1 1760 0
	clr	_pxCurrentTCB
	.loc 1 1772 0
	mov.d	[--w15],w8
	return	
	bra	.L221
.LFE6:
	.size	_vTaskSuspend, .-_vTaskSuspend
	.section	.text.vTaskPlaceOnEventList,code
	.align	2
	.global	_vTaskPlaceOnEventList	; export
	.type	_vTaskPlaceOnEventList,@function
_vTaskPlaceOnEventList:
.LFB21:
	.loc 1 3085 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI17:
	mov	w1,w8
	.loc 1 3102 0
	mov	_pxCurrentTCB,w1
	add	w1,#12,w1
	rcall	_vListInsert
	.loc 1 3104 0
	mov	#1,w1
	mov	w8,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 3105 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE21:
	.size	_vTaskPlaceOnEventList, .-_vTaskPlaceOnEventList
	.section	.text.vTaskPlaceOnUnorderedEventList,code
	.align	2
	.global	_vTaskPlaceOnUnorderedEventList	; export
	.type	_vTaskPlaceOnUnorderedEventList,@function
_vTaskPlaceOnUnorderedEventList:
.LFB22:
	.loc 1 3111 0
	.set ___PA___,1
	.loc 1 3121 0
	mov	_pxCurrentTCB,w3
	bset	w1,#15
	mov	w1,[w3+12]
.LBB122:
	.loc 1 3128 0
	mov	[w0+2],w1
	mov	_pxCurrentTCB,w3
	mov	w1,[w3+14]
	mov	_pxCurrentTCB,w3
	mov	[w1+4],w4
	mov	w4,[w3+16]
	mov	_pxCurrentTCB,w4
	mov	[w1+4],w3
	add	w4,#12,w4
	mov	w4,[w3+2]
	mov	_pxCurrentTCB,w3
	add	w3,#12,w3
	mov	w3,[w1+4]
	mov	_pxCurrentTCB,w1
	mov	w0,[w1+20]
	inc	[w0],[w0]
.LBE122:
	.loc 1 3130 0
	mov	#1,w1
	mov	w2,w0
	bra	_prvAddCurrentTaskToDelayedList
	.loc 1 3131 0
	.set ___PA___,0
.LFE22:
	.size	_vTaskPlaceOnUnorderedEventList, .-_vTaskPlaceOnUnorderedEventList
	.section	.text.xTaskRemoveFromEventList,code
	.align	2
	.global	_xTaskRemoveFromEventList	; export
	.type	_xTaskRemoveFromEventList,@function
_xTaskRemoveFromEventList:
.LFB23:
	.loc 1 3170 0
	.set ___PA___,1
	.loc 1 3187 0
	mov	[w0+6],w0
	mov	[w0+6],w0
.LBB123:
	.loc 1 3189 0
	mov	[w0+20],w1
	mov	[w0+14],w2
	mov	[w0+16],w3
	mov	w3,[w2+4]
	mov	[w0+16],w3
	mov	w2,[w3+2]
	add	w0,#12,w2
	mov	[w1+2],w4
	sub	w4,w2,[w15]
	.set ___BP___,15
	bra	z,.L238
.L230:
	clr	w3
	mov	w3,[w0+20]
	dec	[w1],[w1]
.LBE123:
	.loc 1 3191 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L231
.LBB124:
	.loc 1 3193 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w5
	mov	w5,[w2+4]
	mov	[w0+6],w4
	mov	w2,[w4+2]
	inc2	w0,w3
	mov	[w1+2],w2
	sub	w2,w3,[w15]
	.set ___BP___,15
	bra	z,.L239
	clr	w2
	mov	w2,[w0+10]
	dec	[w1],[w1]
.LBE124:
	.loc 1 3194 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w2
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	geu,.L233
.L240:
	mov	w1,_uxTopReadyPriority
.L233:
.LBB125:
	mulw.su	w1,#10,w6
	mov	#_pxReadyTasksLists,w4
	add	w4,w6,w2
	mov	[w2+2],w2
	mov	w2,[w0+4]
	mov	[w2+4],w5
	mov	w5,[w0+6]
	mov	[w2+4],w5
	mov	w3,[w5+2]
	mov	w3,[w2+4]
	add	w6,w4,w2
	mov	w2,[w0+10]
	inc	[w2],[w2]
.L234:
.LBE125:
	.loc 1 3217 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w2
	.loc 1 3230 0
	clr	w0
	.loc 1 3217 0
	sub	w1,w2,[w15]
	.set ___BP___,39
	bra	leu,.L235
	.loc 1 3226 0
	mov	#1,w0
	mov	w0,_xYieldPending
.L235:
	.loc 1 3234 0
	return	
.L231:
.LBB126:
	.loc 1 3214 0
	mov	_xPendingReadyList+2,w1
	mov	w1,[w0+14]
	mov	[w1+4],w3
	mov	w3,[w0+16]
	mov	[w1+4],w3
	mov	w2,[w3+2]
	mov	w2,[w1+4]
	mov	#_xPendingReadyList,w1
	mov	w1,[w0+20]
	mov	_xPendingReadyList,w1
	inc	w1,w1
	mov	w1,_xPendingReadyList
	mov	[w0+22],w1
	bra	.L234
.L238:
.LBE126:
.LBB127:
	.loc 1 3189 0
	mov	w3,[w1+2]
	bra	.L230
.L239:
.LBE127:
.LBB128:
	.loc 1 3193 0
	mov	w4,[w1+2]
	clr	w2
	mov	w2,[w0+10]
	dec	[w1],[w1]
.LBE128:
	.loc 1 3194 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w2
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	geu,.L233
	bra	.L240
.LFE23:
	.size	_xTaskRemoveFromEventList, .-_xTaskRemoveFromEventList
	.section	.text.vTaskRemoveFromUnorderedEventList,code
	.align	2
	.global	_vTaskRemoveFromUnorderedEventList	; export
	.type	_vTaskRemoveFromUnorderedEventList,@function
_vTaskRemoveFromUnorderedEventList:
.LFB24:
	.loc 1 3239 0
	.set ___PA___,1
	.loc 1 3247 0
	bset	w1,#15
	mov	w1,[w0]
	.loc 1 3251 0
	mov	[w0+6],w1
.LBB129:
	.loc 1 3253 0
	mov	[w0+8],w2
	mov	[w0+2],w3
	mov	[w0+4],w4
	mov	w4,[w3+4]
	mov	[w0+4],w4
	mov	w3,[w4+2]
	mov	[w2+2],w3
	sub	w3,w0,[w15]
	.set ___BP___,15
	bra	z,.L248
	clr	w3
	mov	w3,[w0+8]
	dec	[w2],[w2]
.LBE129:
.LBB130:
	.loc 1 3272 0
	mov	[w1+10],w0
	mov	[w1+4],w2
	mov	[w1+6],w5
	mov	w5,[w2+4]
	mov	[w1+6],w4
	mov	w2,[w4+2]
	inc2	w1,w3
	mov	[w0+2],w2
	sub	w2,w3,[w15]
	.set ___BP___,15
	bra	z,.L249
.L244:
	clr	w2
	mov	w2,[w1+10]
	dec	[w0],[w0]
.LBE130:
	.loc 1 3273 0
	mov	[w1+22],w2
	mov	_uxTopReadyPriority,w0
	sub	w0,w2,[w15]
	.set ___BP___,50
	bra	geu,.L245
	mov	w2,_uxTopReadyPriority
.L245:
.LBB131:
	mulw.su	w2,#10,w6
	mov	#_pxReadyTasksLists,w4
	add	w4,w6,w0
	mov	[w0+2],w0
	mov	w0,[w1+4]
	mov	[w0+4],w5
	mov	w5,[w1+6]
	mov	[w0+4],w5
	mov	w3,[w5+2]
	mov	w3,[w0+4]
	add	w6,w4,w0
	mov	w0,[w1+10]
	inc	[w0],[w0]
.LBE131:
	.loc 1 3275 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	sub	w2,w0,[w15]
	.set ___BP___,39
	bra	leu,.L242
	.loc 1 3281 0
	mov	#1,w0
	mov	w0,_xYieldPending
.L242:
	return	
.L249:
.LBB132:
	.loc 1 3272 0
	mov	w4,[w0+2]
	bra	.L244
.L248:
.LBE132:
.LBB133:
	.loc 1 3253 0
	mov	w4,[w2+2]
	clr	w3
	mov	w3,[w0+8]
	dec	[w2],[w2]
.LBE133:
.LBB134:
	.loc 1 3272 0
	mov	[w1+10],w0
	mov	[w1+4],w2
	mov	[w1+6],w5
	mov	w5,[w2+4]
	mov	[w1+6],w4
	mov	w2,[w4+2]
	inc2	w1,w3
	mov	[w0+2],w2
	sub	w2,w3,[w15]
	.set ___BP___,85
	bra	nz,.L244
	bra	.L249
.LBE134:
.LFE24:
	.size	_vTaskRemoveFromUnorderedEventList, .-_vTaskRemoveFromUnorderedEventList
	.section	.text.vTaskSetTimeOutState,code
	.align	2
	.global	_vTaskSetTimeOutState	; export
	.type	_vTaskSetTimeOutState,@function
_vTaskSetTimeOutState:
.LFB25:
	.loc 1 3287 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI18:
	mov	w0,w8
	.loc 1 3289 0
	rcall	_vPortEnterCritical
	.loc 1 3291 0
	mov	_xNumOfOverflows,w0
	mov	w0,[w8]
	.loc 1 3292 0
	mov	_xTickCount,w0
	mov	w0,[w8+2]
	.loc 1 3294 0
	rcall	_vPortExitCritical
	.loc 1 3295 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE25:
	.size	_vTaskSetTimeOutState, .-_vTaskSetTimeOutState
	.section	.text.vTaskInternalSetTimeOutState,code
	.align	2
	.global	_vTaskInternalSetTimeOutState	; export
	.type	_vTaskInternalSetTimeOutState,@function
_vTaskInternalSetTimeOutState:
.LFB26:
	.loc 1 3299 0
	.set ___PA___,1
	.loc 1 3301 0
	mov	_xNumOfOverflows,w1
	mov	w1,[w0]
	.loc 1 3302 0
	mov	_xTickCount,w1
	mov	w1,[w0+2]
	.loc 1 3303 0
	return	
	.set ___PA___,0
.LFE26:
	.size	_vTaskInternalSetTimeOutState, .-_vTaskInternalSetTimeOutState
	.section	.text.xTaskCheckForTimeOut,code
	.align	2
	.global	_xTaskCheckForTimeOut	; export
	.type	_xTaskCheckForTimeOut,@function
_xTaskCheckForTimeOut:
.LFB27:
	.loc 1 3308 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI19:
	mov	w10,[w15++]
.LCFI20:
	mov	w0,w8
	mov	w1,w10
	.loc 1 3314 0
	rcall	_vPortEnterCritical
.LBB135:
	.loc 1 3317 0
	mov	_xTickCount,w1
	.loc 1 3318 0
	mov	[w8+2],w0
	.loc 1 3332 0
	mov	[w10],w2
	.loc 1 3337 0
	clr	w9
	.loc 1 3332 0
	add	w2,#1,[w15]
	.set ___BP___,19
	bra	z,.L258
	.loc 1 3342 0
	mov	[w8],w3
	mov	_xNumOfOverflows,w4
	sub	w4,w3,[w15]
	.set ___BP___,28
	bra	z,.L259
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	geu,.L260
.L259:
	.loc 1 3318 0
	sub	w1,w0,w0
	.loc 1 3352 0
	sub	w0,w2,[w15]
	.set ___BP___,39
	bra	ltu,.L263
.L260:
	.loc 1 3361 0
	clr	[w10]
	.loc 1 3362 0
	mov	#1,w9
.L258:
.LBE135:
	.loc 1 3365 0
	rcall	_vPortExitCritical
	.loc 1 3368 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
.L264:
	.set ___PA___,0
.L263:
.LBB138:
	.loc 1 3355 0
	sub	w2,w0,[w10]
.LBB136:
.LBB137:
	.loc 1 3301 0
	mov	_xNumOfOverflows,w0
	mov	w0,[w8]
	.loc 1 3302 0
	mov	_xTickCount,w4
	mov	w4,[w8+2]
	.loc 1 3357 0
	clr	w9
.LBE137:
.LBE136:
.LBE138:
	.loc 1 3365 0
	rcall	_vPortExitCritical
	.loc 1 3368 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L264
.LFE27:
	.size	_xTaskCheckForTimeOut, .-_xTaskCheckForTimeOut
	.section	.text.vTaskMissedYield,code
	.align	2
	.global	_vTaskMissedYield	; export
	.type	_vTaskMissedYield,@function
_vTaskMissedYield:
.LFB28:
	.loc 1 3372 0
	.set ___PA___,1
	.loc 1 3373 0
	mov	#1,w0
	mov	w0,_xYieldPending
	.loc 1 3374 0
	return	
	.set ___PA___,0
.LFE28:
	.size	_vTaskMissedYield, .-_vTaskMissedYield
	.section	.text.xTaskGetCurrentTaskHandle,code
	.align	2
	.global	_xTaskGetCurrentTaskHandle	; export
	.type	_xTaskGetCurrentTaskHandle,@function
_xTaskGetCurrentTaskHandle:
.LFB33:
	.loc 1 4023 0
	.set ___PA___,1
	.loc 1 4029 0
	mov	_pxCurrentTCB,w0
	.loc 1 4032 0
	return	
	.set ___PA___,0
.LFE33:
	.size	_xTaskGetCurrentTaskHandle, .-_xTaskGetCurrentTaskHandle
	.section	.text.uxTaskResetEventItemValue,code
	.align	2
	.global	_uxTaskResetEventItemValue	; export
	.type	_uxTaskResetEventItemValue,@function
_uxTaskResetEventItemValue:
.LFB34:
	.loc 1 4659 0
	.set ___PA___,1
	.loc 1 4662 0
	mov	_pxCurrentTCB,w0
	mov	[w0+12],w0
	.loc 1 4666 0
	mov	_pxCurrentTCB,w1
	mov	_pxCurrentTCB,w2
	mov	[w2+22],w2
	subr	w2,#4,w2
	mov	w2,[w1+12]
	.loc 1 4669 0
	return	
	.set ___PA___,0
.LFE34:
	.size	_uxTaskResetEventItemValue, .-_uxTaskResetEventItemValue
	.section	.text.ulTaskGenericNotifyTake,code
	.align	2
	.global	_ulTaskGenericNotifyTake	; export
	.type	_ulTaskGenericNotifyTake,@function
_ulTaskGenericNotifyTake:
.LFB35:
	.loc 1 4694 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI21:
	mov.d	w10,[w15++]
.LCFI22:
	mov.d	w12,[w15++]
.LCFI23:
	mov.d	w0,w8
	mov	w2,w11
	.loc 1 4699 0
	rcall	_vPortEnterCritical
	.loc 1 4702 0
	add	w8,#8,w10
	sl	w10,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0+2],w1
	mov	[w0],w0
	sub	w0,#0,[w15]
	subb	w1,#0,[w15]
	.set ___BP___,50
	bra	nz,.L276
	.loc 1 4705 0
	mov	w8,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w2
	mov.b	#1,w1
	mov.b	w1,[w2+36]
	.loc 1 4707 0
	cp0	w11
	.set ___BP___,29
	bra	nz,.L280
.L276:
	.loc 1 4728 0
	rcall	_vPortExitCritical
	.loc 1 4730 0
	rcall	_vPortEnterCritical
	.loc 1 4733 0
	sl	w10,#2,w10
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w1
	mov	[w1],w12
	mov	[w1+2],w13
	.loc 1 4735 0
	sub	w12,#0,[w15]
	subb	w13,#0,[w15]
	.set ___BP___,39
	bra	z,.L277
	.loc 1 4737 0
	cp0	w9
	.set ___BP___,39
	bra	nz,.L281
	.loc 1 4743 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w10
	setm	w0
	setm	w1
	add	w12,w0,[w10++]
	addc	w13,w1,[w10--]
.L277:
	.loc 1 4751 0
	mov	w8,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w8
	add	#36,w8
	clr.b	[w8]
	.loc 1 4753 0
	rcall	_vPortExitCritical
	.loc 1 4756 0
	mov.d	w12,w0
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
.L282:
	.set ___PA___,0
.L281:
	.loc 1 4739 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w10
	clr	[w10]
	mov	[w10++],[w10--]
	.loc 1 4751 0
	mov	w8,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w8
	add	#36,w8
	clr.b	[w8]
	.loc 1 4753 0
	rcall	_vPortExitCritical
	.loc 1 4756 0
	mov.d	w12,w0
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L282
.L280:
	.loc 1 4709 0
	mov	#1,w1
	mov	w11,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 4716 0
; 4716 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	bra	.L276
.LFE35:
	.size	_ulTaskGenericNotifyTake, .-_ulTaskGenericNotifyTake
	.section	.text.xTaskGenericNotifyWait,code
	.align	2
	.global	_xTaskGenericNotifyWait	; export
	.type	_xTaskGenericNotifyWait,@function
_xTaskGenericNotifyWait:
.LFB36:
	.loc 1 4768 0
	.set ___PA___,0
	lnk	#4
.LCFI24:
	mov.d	w8,[w15++]
.LCFI25:
	mov.d	w10,[w15++]
.LCFI26:
	mov.d	w12,[w15++]
.LCFI27:
	mov	w0,w8
	mov.d	w4,w10
	mov	w1,w9
	mov	w6,w13
	.loc 1 4773 0
	mov	w2,[w15-16]
	mov	w3,[w15-14]
	rcall	_vPortEnterCritical
	.loc 1 4776 0
	mov	#36,w12
	add	w12,w8,w12
	mov	w12,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w1
	mov	[w15-16],w2
	mov	[w15-14],w3
	mov.b	#2,w0
	subr.b	w0,[w1],[w15]
	.set ___BP___,28
	bra	z,.L285
	.loc 1 4781 0
	add	w8,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0],w6
	mov	[w0+2],w7
	com	w2,w2
	com	w3,w3
	and	w6,w2,w4
	and	w7,w3,w5
	mov.d	w4,[w0]
	.loc 1 4784 0
	mov	w8,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w2
	mov.b	#1,w1
	mov.b	w1,[w2+36]
	.loc 1 4786 0
	cp0	w13
	.set ___BP___,29
	bra	nz,.L290
.L285:
	.loc 1 4807 0
	rcall	_vPortExitCritical
	.loc 1 4809 0
	rcall	_vPortEnterCritical
	.loc 1 4813 0
	cp0	w9
	.set ___BP___,15
	bra	z,.L286
	.loc 1 4817 0
	add	w8,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0++],[w9++]
	mov	[w0--],[w9--]
.L286:
	.loc 1 4824 0
	mov	w12,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w12
	.loc 1 4827 0
	clr	w9
	.loc 1 4824 0
	mov.b	#2,w0
	subr.b	w0,[w12],[w15]
	.set ___BP___,37
	bra	z,.L291
	.loc 1 4837 0
	mov	w8,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w8
	add	#36,w8
	clr.b	[w8]
	.loc 1 4839 0
	rcall	_vPortExitCritical
	.loc 1 4842 0
	mov	w9,w0
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L292:
	.set ___PA___,0
.L291:
	.loc 1 4833 0
	add	w8,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0],w4
	mov	[w0+2],w5
	com	w10,w10
	com	w11,w11
	and	w4,w10,w2
	and	w5,w11,w3
	mov.d	w2,[w0]
	.loc 1 4834 0
	mov	#1,w9
	.loc 1 4837 0
	mov	w8,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w8
	add	#36,w8
	clr.b	[w8]
	.loc 1 4839 0
	rcall	_vPortExitCritical
	.loc 1 4842 0
	mov	w9,w0
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L292
.L290:
	.loc 1 4788 0
	mov	#1,w1
	mov	w13,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 4795 0
; 4795 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	bra	.L285
.LFE36:
	.size	_xTaskGenericNotifyWait, .-_xTaskGenericNotifyWait
	.section	.text.xTaskGenericNotify,code
	.align	2
	.global	_xTaskGenericNotify	; export
	.type	_xTaskGenericNotify,@function
_xTaskGenericNotify:
.LFB37:
	.loc 1 4854 0
	.set ___PA___,0
	lnk	#4
.LCFI28:
	mov.d	w8,[w15++]
.LCFI29:
	mov.d	w10,[w15++]
.LCFI30:
	mov.d	w0,w8
	mov.d	w4,w10
	.loc 1 4863 0
	mov	w2,[w15-12]
	mov	w3,[w15-10]
	rcall	_vPortEnterCritical
	.loc 1 4865 0
	mov	[w15-12],w2
	mov	[w15-10],w3
	cp0	w11
	.set ___BP___,15
	bra	z,.L295
	.loc 1 4867 0
	add	w9,#8,w0
	sl	w0,#2,w0
	add	w8,w0,w0
	mov	[w0++],[w11++]
	mov	[w0--],[w11--]
.L295:
	.loc 1 4870 0
	add	w8,w9,w0
	mov.b	[w0+36],w0
	.loc 1 4872 0
	add	w8,w9,w1
	mov.b	#2,w4
	mov.b	w4,[w1+36]
	.loc 1 4874 0
	sub	w10,#2,[w15]
	.set ___BP___,29
	bra	z,.L298
	.set ___BP___,50
	bra	leu,.L310
	sub	w10,#3,[w15]
	.set ___BP___,29
	bra	z,.L308
	sub	w10,#4,[w15]
	.set ___BP___,29
	bra	z,.L311
.L296:
	.loc 1 4922 0
	mov	#1,w10
	sub.b	w0,#1,[w15]
	.set ___BP___,40
	bra	z,.L312
.L302:
	.loc 1 4962 0
	rcall	_vPortExitCritical
	.loc 1 4965 0
	mov	w10,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
.L315:
	.set ___PA___,0
.L310:
	.loc 1 4874 0
	sub	w10,#1,[w15]
	.set ___BP___,71
	bra	nz,.L296
	.loc 1 4877 0
	add	w9,#8,w9
	sl	w9,#2,w9
	add	w8,w9,w9
	ior	w2,[w9],[w9++]
	ior	w3,[w9],[w9--]
	.loc 1 4922 0
	mov	#1,w10
	sub.b	w0,#1,[w15]
	.set ___BP___,59
	bra	nz,.L302
.L312:
.LBB139:
	.loc 1 4924 0
	mov	[w8+10],w0
	mov	[w8+4],w1
	mov	[w8+6],w3
	mov	w3,[w1+4]
	mov	[w8+6],w3
	mov	w1,[w3+2]
	inc2	w8,w2
	mov	[w0+2],w1
	sub	w1,w2,[w15]
	.set ___BP___,15
	bra	z,.L313
	clr	w1
	mov	w1,[w8+10]
	dec	[w0],[w0]
.LBE139:
	.loc 1 4925 0
	mov	[w8+22],w1
	mov	_uxTopReadyPriority,w5
	sub	w5,w1,[w15]
	.set ___BP___,50
	bra	ltu,.L314
.L304:
.LBB140:
	mulw.su	w1,#10,w4
	mov	#_pxReadyTasksLists,w3
	add	w3,w4,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w5
	mov	w5,[w8+6]
	mov	[w0+4],w5
	mov	w2,[w5+2]
	mov	w2,[w0+4]
	add	w4,w3,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
.LBE140:
	.loc 1 4946 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	mov	#1,w10
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L302
	.loc 1 4950 0
; 4950 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 4962 0
	rcall	_vPortExitCritical
	.loc 1 4965 0
	mov	w10,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L315
.L311:
	.loc 1 4897 0
	clr	w10
	.loc 1 4890 0
	sub.b	w0,#2,[w15]
	.set ___BP___,28
	bra	z,.L302
.L308:
	.loc 1 4892 0
	add	w9,#8,w9
	sl	w9,#2,w9
	add	w8,w9,w9
	mov.d	w2,[w9]
	.loc 1 4922 0
	mov	#1,w10
	sub.b	w0,#1,[w15]
	.set ___BP___,59
	bra	nz,.L302
	bra	.L312
.L298:
	.loc 1 4881 0
	add	w9,#8,w9
	sl	w9,#2,w9
	add	w8,w9,w9
	mov	#1,w2
	mov	#0,w3
	add	w2,[w9],[w9]
	addc	w3,[++w9],[w9--]
	.loc 1 4922 0
	mov	#1,w10
	sub.b	w0,#1,[w15]
	.set ___BP___,59
	bra	nz,.L302
	bra	.L312
.L314:
	.loc 1 4925 0
	mov	w1,_uxTopReadyPriority
	bra	.L304
.L313:
.LBB141:
	.loc 1 4924 0
	mov	w3,[w0+2]
	clr	w1
	mov	w1,[w8+10]
	dec	[w0],[w0]
.LBE141:
	.loc 1 4925 0
	mov	[w8+22],w1
	mov	_uxTopReadyPriority,w5
	sub	w5,w1,[w15]
	.set ___BP___,50
	bra	geu,.L304
	bra	.L314
.LFE37:
	.size	_xTaskGenericNotify, .-_xTaskGenericNotify
	.section	.text.xTaskGenericNotifyFromISR,code
	.align	2
	.global	_xTaskGenericNotifyFromISR	; export
	.type	_xTaskGenericNotifyFromISR,@function
_xTaskGenericNotifyFromISR:
.LFB38:
	.loc 1 4978 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI31:
	.loc 1 5009 0
	cp0	w5
	.set ___BP___,15
	bra	z,.L318
	.loc 1 5011 0
	add	w1,#8,w7
	sl	w7,#2,w7
	add	w0,w7,w7
	mov	[w7++],[w5++]
	mov	[w7--],[w5--]
.L318:
	.loc 1 5014 0
	add	w0,w1,w5
	mov.b	[w5+36],w5
	.loc 1 5015 0
	add	w0,w1,w7
	mov.b	#2,w8
	mov.b	w8,[w7+36]
	.loc 1 5017 0
	sub	w4,#2,[w15]
	.set ___BP___,29
	bra	z,.L321
	.set ___BP___,50
	bra	leu,.L336
	sub	w4,#3,[w15]
	.set ___BP___,29
	bra	z,.L334
	sub	w4,#4,[w15]
	.set ___BP___,29
	bra	z,.L337
.L319:
	.loc 1 5064 0
	mov	#1,w4
	sub.b	w5,#1,[w15]
	.set ___BP___,40
	bra	z,.L338
.L325:
	.loc 1 5104 0
	mov	w4,w0
	mov	[--w15],w8
	return	
.L340:
	.set ___PA___,0
.L336:
	.loc 1 5017 0
	sub	w4,#1,[w15]
	.set ___BP___,71
	bra	nz,.L319
	.loc 1 5020 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	ior	w2,[w1],[w1++]
	ior	w3,[w1],[w1--]
	.loc 1 5064 0
	mov	#1,w4
	sub.b	w5,#1,[w15]
	.set ___BP___,59
	bra	nz,.L325
.L338:
	.loc 1 5069 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L326
.LBB142:
	.loc 1 5071 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w3
	mov	w3,[w2+4]
	mov	[w0+6],w4
	mov	w2,[w4+2]
	inc2	w0,w3
	mov	[w1+2],w2
	sub	w2,w3,[w15]
	.set ___BP___,15
	bra	z,.L339
.L327:
	clr	w2
	mov	w2,[w0+10]
	dec	[w1],[w1]
.LBE142:
	.loc 1 5072 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w5
	sub	w5,w1,[w15]
	.set ___BP___,50
	bra	geu,.L328
	mov	w1,_uxTopReadyPriority
.L328:
.LBB143:
	mulw.su	w1,#10,w8
	mov	#_pxReadyTasksLists,w4
	add	w4,w8,w2
	mov	[w2+2],w2
	mov	w2,[w0+4]
	mov	[w2+4],w5
	mov	w5,[w0+6]
	mov	[w2+4],w5
	mov	w3,[w5+2]
	mov	w3,[w2+4]
	add	w8,w4,w2
	mov	w2,[w0+10]
	inc	[w2],[w2]
.L329:
.LBE143:
	.loc 1 5081 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	mov	#1,w4
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L325
	.loc 1 5085 0
	cp0	w6
	.set ___BP___,15
	bra	z,.L330
	.loc 1 5087 0
	mov	w4,[w6]
.L330:
	.loc 1 5093 0
	mov	#1,w4
	mov	w4,_xYieldPending
	.loc 1 5104 0
	mov	w4,w0
	mov	[--w15],w8
	return	
	bra	.L340
.L337:
	.loc 1 5040 0
	clr	w4
	.loc 1 5033 0
	sub.b	w5,#2,[w15]
	.set ___BP___,28
	bra	z,.L325
.L334:
	.loc 1 5035 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	mov.d	w2,[w1]
	.loc 1 5064 0
	mov	#1,w4
	sub.b	w5,#1,[w15]
	.set ___BP___,59
	bra	nz,.L325
	bra	.L338
.L321:
	.loc 1 5024 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	mov	#1,w2
	mov	#0,w3
	add	w2,[w1],[w1]
	addc	w3,[++w1],[w1--]
	.loc 1 5064 0
	mov	#1,w4
	sub.b	w5,#1,[w15]
	.set ___BP___,59
	bra	nz,.L325
	bra	.L338
.L326:
.LBB144:
	.loc 1 5078 0
	mov	_xPendingReadyList+2,w1
	mov	w1,[w0+14]
	mov	[w1+4],w2
	mov	w2,[w0+16]
	add	w0,#12,w2
	mov	[w1+4],w3
	mov	w2,[w3+2]
	mov	w2,[w1+4]
	mov	#_xPendingReadyList,w1
	mov	w1,[w0+20]
	mov	_xPendingReadyList,w1
	inc	w1,w1
	mov	w1,_xPendingReadyList
	mov	[w0+22],w1
	bra	.L329
.L339:
.LBE144:
.LBB145:
	.loc 1 5071 0
	mov	w4,[w1+2]
	bra	.L327
.LBE145:
.LFE38:
	.size	_xTaskGenericNotifyFromISR, .-_xTaskGenericNotifyFromISR
	.section	.text.vTaskGenericNotifyGiveFromISR,code
	.align	2
	.global	_vTaskGenericNotifyGiveFromISR	; export
	.type	_vTaskGenericNotifyGiveFromISR,@function
_vTaskGenericNotifyGiveFromISR:
.LFB39:
	.loc 1 5114 0
	.set ___PA___,1
	.loc 1 5144 0
	add	w0,w1,w3
	mov.b	[w3+36],w3
	.loc 1 5145 0
	add	w0,w1,w4
	mov.b	#2,w5
	mov.b	w5,[w4+36]
	.loc 1 5149 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	mov	#1,w4
	mov	#0,w5
	add	w4,[w1],[w1]
	addc	w5,[++w1],[w1--]
	.loc 1 5155 0
	sub.b	w3,#1,[w15]
	.set ___BP___,37
	bra	z,.L350
.L342:
	return	
.L350:
	.loc 1 5160 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L344
.LBB146:
	.loc 1 5162 0
	mov	[w0+10],w1
	mov	[w0+4],w3
	mov	[w0+6],w5
	mov	w5,[w3+4]
	mov	[w0+6],w5
	mov	w3,[w5+2]
	inc2	w0,w4
	mov	[w1+2],w3
	sub	w3,w4,[w15]
	.set ___BP___,15
	bra	z,.L351
.L345:
	clr	w3
	mov	w3,[w0+10]
	dec	[w1],[w1]
.LBE146:
	.loc 1 5163 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w7
	sub	w7,w1,[w15]
	.set ___BP___,50
	bra	geu,.L346
	mov	w1,_uxTopReadyPriority
.L346:
.LBB147:
	mulw.su	w1,#10,w6
	mov	#_pxReadyTasksLists,w5
	add	w5,w6,w3
	mov	[w3+2],w3
	mov	w3,[w0+4]
	mov	[w3+4],w7
	mov	w7,[w0+6]
	mov	[w3+4],w7
	mov	w4,[w7+2]
	mov	w4,[w3+4]
	add	w6,w5,w3
	mov	w3,[w0+10]
	inc	[w3],[w3]
.L347:
.LBE147:
	.loc 1 5172 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L342
	.loc 1 5176 0
	cp0	w2
	.set ___BP___,15
	bra	z,.L348
	.loc 1 5178 0
	mov	#1,w0
	mov	w0,[w2]
.L348:
	.loc 1 5184 0
	mov	#1,w0
	mov	w0,_xYieldPending
	return	
.L344:
.LBB148:
	.loc 1 5169 0
	mov	_xPendingReadyList+2,w1
	mov	w1,[w0+14]
	mov	[w1+4],w3
	mov	w3,[w0+16]
	add	w0,#12,w3
	mov	[w1+4],w4
	mov	w3,[w4+2]
	mov	w3,[w1+4]
	mov	#_xPendingReadyList,w1
	mov	w1,[w0+20]
	mov	_xPendingReadyList,w1
	inc	w1,w1
	mov	w1,_xPendingReadyList
	mov	[w0+22],w1
	bra	.L347
.L351:
.LBE148:
.LBB149:
	.loc 1 5162 0
	mov	w5,[w1+2]
	bra	.L345
.LBE149:
.LFE39:
	.size	_vTaskGenericNotifyGiveFromISR, .-_vTaskGenericNotifyGiveFromISR
	.section	.text.xTaskGenericNotifyStateClear,code
	.align	2
	.global	_xTaskGenericNotifyStateClear	; export
	.type	_xTaskGenericNotifyStateClear,@function
_xTaskGenericNotifyStateClear:
.LFB40:
	.loc 1 5202 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI32:
	mov	w10,[w15++]
.LCFI33:
	mov	w1,w9
	.loc 1 5210 0
	cp0	w0
	.set ___BP___,15
	bra	z,.L359
	mov	w0,w10
	.loc 1 5212 0
	rcall	_vPortEnterCritical
	.loc 1 5214 0
	add	w10,w9,w0
	mov.b	[w0+36],w0
	.loc 1 5221 0
	clr	w8
	.loc 1 5214 0
	sub.b	w0,#2,[w15]
	.set ___BP___,37
	bra	z,.L360
.L355:
	.loc 1 5224 0
	rcall	_vPortExitCritical
	.loc 1 5227 0
	mov	w8,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
.L361:
	.set ___PA___,0
.L360:
	.loc 1 5216 0
	add	w10,w9,w9
	add	#36,w9
	clr.b	[w9]
	.loc 1 5217 0
	mov	#1,w8
	.loc 1 5224 0
	rcall	_vPortExitCritical
	.loc 1 5227 0
	mov	w8,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	bra	.L361
.L359:
	.loc 1 5210 0
	mov	_pxCurrentTCB,w10
	.loc 1 5212 0
	rcall	_vPortEnterCritical
	.loc 1 5214 0
	add	w10,w9,w0
	mov.b	[w0+36],w0
	.loc 1 5221 0
	clr	w8
	.loc 1 5214 0
	sub.b	w0,#2,[w15]
	.set ___BP___,62
	bra	nz,.L355
	bra	.L360
.LFE40:
	.size	_xTaskGenericNotifyStateClear, .-_xTaskGenericNotifyStateClear
	.section	.text.ulTaskGenericNotifyValueClear,code
	.align	2
	.global	_ulTaskGenericNotifyValueClear	; export
	.type	_ulTaskGenericNotifyValueClear,@function
_ulTaskGenericNotifyValueClear:
.LFB41:
	.loc 1 5237 0
	.set ___PA___,1
	lnk	#4
.LCFI34:
	mov.d	w8,[w15++]
.LCFI35:
	mov	w1,w8
	.loc 1 5243 0
	cp0	w0
	.set ___BP___,21
	bra	z,.L367
	mov	w0,w9
	.loc 1 5245 0
	mov	w2,[w15-8]
	mov	w3,[w15-6]
	rcall	_vPortEnterCritical
	.loc 1 5249 0
	add	w8,#8,w8
	sl	w8,#2,w8
	add	w9,w8,w0
	mov	[w0],w8
	mov	[w0+2],w9
	.loc 1 5250 0
	mov	[w0],w6
	mov	[w0+2],w7
	mov	[w15-8],w2
	mov	[w15-6],w3
	com	w2,w4
	com	w3,w5
	and	w6,w4,w2
	and	w7,w5,w3
	mov.d	w2,[w0]
	.loc 1 5252 0
	rcall	_vPortExitCritical
	.loc 1 5255 0
	mov.d	w8,w0
	mov.d	[--w15],w8
	ulnk	
	return	
.L368:
	.set ___PA___,0
.L367:
	.loc 1 5243 0
	mov	_pxCurrentTCB,w9
	.loc 1 5245 0
	mov	w2,[w15-8]
	mov	w3,[w15-6]
	rcall	_vPortEnterCritical
	.loc 1 5249 0
	add	w8,#8,w8
	sl	w8,#2,w8
	add	w9,w8,w0
	mov	[w0],w8
	mov	[w0+2],w9
	.loc 1 5250 0
	mov	[w0],w6
	mov	[w0+2],w7
	mov	[w15-8],w2
	mov	[w15-6],w3
	com	w2,w4
	com	w3,w5
	and	w6,w4,w2
	and	w7,w5,w3
	mov.d	w2,[w0]
	.loc 1 5252 0
	rcall	_vPortExitCritical
	.loc 1 5255 0
	mov.d	w8,w0
	mov.d	[--w15],w8
	ulnk	
	return	
	bra	.L368
.LFE41:
	.size	_ulTaskGenericNotifyValueClear, .-_ulTaskGenericNotifyValueClear
	.global	_pxCurrentTCB	; export
	.section	.nbss,bss,near
	.align	2
	.type	_pxCurrentTCB,@object
	.size	_pxCurrentTCB, 2
_pxCurrentTCB:
	.skip	2
	.global	_uxTopUsedPriority	; export
	.section	.const,psv,page
	.align	2
	.type	_uxTopUsedPriority,@object
	.size	_uxTopUsedPriority, 2
_uxTopUsedPriority:
	.word	3
	.section	.nbss,bss,near
	.align	2
	.type	_uxSchedulerSuspended,@object
	.size	_uxSchedulerSuspended, 2
_uxSchedulerSuspended:
	.skip	2
	.align	2
	.type	_uxTopReadyPriority,@object
	.size	_uxTopReadyPriority, 2
_uxTopReadyPriority:
	.skip	2
	.section	.bss,bss
	.align	2
	.type	_pxReadyTasksLists,@object
	.size	_pxReadyTasksLists, 40
_pxReadyTasksLists:
	.skip	40
	.align	2
	.type	_xPendingReadyList,@object
	.size	_xPendingReadyList, 10
_xPendingReadyList:
	.skip	10
	.section	.nbss,bss,near
	.align	2
	.type	_xYieldPending,@object
	.size	_xYieldPending, 2
_xYieldPending:
	.skip	2
	.align	2
	.type	_xTickCount,@object
	.size	_xTickCount, 2
_xTickCount:
	.skip	2
	.section	.bss,bss
	.align	2
	.type	_xSuspendedTaskList,@object
	.size	_xSuspendedTaskList, 10
_xSuspendedTaskList:
	.skip	10
	.section	.nbss,bss,near
	.align	2
	.type	_pxOverflowDelayedTaskList,@object
	.size	_pxOverflowDelayedTaskList, 2
_pxOverflowDelayedTaskList:
	.skip	2
	.align	2
	.type	_pxDelayedTaskList,@object
	.size	_pxDelayedTaskList, 2
_pxDelayedTaskList:
	.skip	2
	.align	2
	.type	_xNextTaskUnblockTime,@object
	.size	_xNextTaskUnblockTime, 2
_xNextTaskUnblockTime:
	.skip	2
	.align	2
	.type	_xNumOfOverflows,@object
	.size	_xNumOfOverflows, 2
_xNumOfOverflows:
	.skip	2
	.align	2
	.type	_xPendedTicks,@object
	.size	_xPendedTicks, 2
_xPendedTicks:
	.skip	2
	.align	2
	.type	_uxCurrentNumberOfTasks,@object
	.size	_uxCurrentNumberOfTasks, 2
_uxCurrentNumberOfTasks:
	.skip	2
	.align	2
	.type	_xSchedulerRunning,@object
	.size	_xSchedulerRunning, 2
_xSchedulerRunning:
	.skip	2
	.align	2
	.type	_xIdleTaskHandle,@object
	.size	_xIdleTaskHandle, 2
_xIdleTaskHandle:
	.skip	2
	.align	2
	.type	_uxTaskNumber,@object
	.size	_uxTaskNumber, 2
_uxTaskNumber:
	.skip	2
	.section	.bss,bss
	.align	2
	.type	_xDelayedTaskList1,@object
	.size	_xDelayedTaskList1, 10
_xDelayedTaskList1:
	.skip	10
	.align	2
	.type	_xDelayedTaskList2,@object
	.size	_xDelayedTaskList2, 10
_xDelayedTaskList2:
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
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.byte	0x4
	.4byte	.LCFI0-.LFB42
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
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI2-.LFB0
	.byte	0x13
	.sleb128 -5
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0x13
	.sleb128 -7
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x13
	.sleb128 -9
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0x13
	.sleb128 -11
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0x13
	.sleb128 -12
	.byte	0x8e
	.uleb128 0xb
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
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI7-.LFB5
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.byte	0x4
	.4byte	.LCFI9-.LFB8
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.byte	0x4
	.4byte	.LCFI10-.LFB9
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI11-.LCFI10
	.byte	0x13
	.sleb128 -5
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
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.align	4
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.align	4
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.align	4
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.align	4
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.align	4
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.align	4
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.align	4
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.byte	0x4
	.4byte	.LCFI12-.LFB19
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.byte	0x4
	.4byte	.LCFI13-.LFB13
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.byte	0x4
	.4byte	.LCFI14-.LFB18
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE30:
.LSFDE32:
	.4byte	.LEFDE32-.LASFDE32
.LASFDE32:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.align	4
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI15-.LFB3
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.align	4
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI16-.LFB6
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE38:
.LSFDE40:
	.4byte	.LEFDE40-.LASFDE40
.LASFDE40:
	.4byte	.Lframe0
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.byte	0x4
	.4byte	.LCFI17-.LFB21
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE40:
.LSFDE42:
	.4byte	.LEFDE42-.LASFDE42
.LASFDE42:
	.4byte	.Lframe0
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.align	4
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.align	4
.LEFDE44:
.LSFDE46:
	.4byte	.LEFDE46-.LASFDE46
.LASFDE46:
	.4byte	.Lframe0
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.align	4
.LEFDE46:
.LSFDE48:
	.4byte	.LEFDE48-.LASFDE48
.LASFDE48:
	.4byte	.Lframe0
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.byte	0x4
	.4byte	.LCFI18-.LFB25
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE48:
.LSFDE50:
	.4byte	.LEFDE50-.LASFDE50
.LASFDE50:
	.4byte	.Lframe0
	.4byte	.LFB26
	.4byte	.LFE26-.LFB26
	.align	4
.LEFDE50:
.LSFDE52:
	.4byte	.LEFDE52-.LASFDE52
.LASFDE52:
	.4byte	.Lframe0
	.4byte	.LFB27
	.4byte	.LFE27-.LFB27
	.byte	0x4
	.4byte	.LCFI19-.LFB27
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI20-.LCFI19
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE52:
.LSFDE54:
	.4byte	.LEFDE54-.LASFDE54
.LASFDE54:
	.4byte	.Lframe0
	.4byte	.LFB28
	.4byte	.LFE28-.LFB28
	.align	4
.LEFDE54:
.LSFDE56:
	.4byte	.LEFDE56-.LASFDE56
.LASFDE56:
	.4byte	.Lframe0
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.align	4
.LEFDE56:
.LSFDE58:
	.4byte	.LEFDE58-.LASFDE58
.LASFDE58:
	.4byte	.Lframe0
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
	.align	4
.LEFDE58:
.LSFDE60:
	.4byte	.LEFDE60-.LASFDE60
.LASFDE60:
	.4byte	.Lframe0
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.byte	0x4
	.4byte	.LCFI21-.LFB35
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI22-.LCFI21
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI23-.LCFI22
	.byte	0x13
	.sleb128 -8
	.byte	0x8c
	.uleb128 0x6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE60:
.LSFDE62:
	.4byte	.LEFDE62-.LASFDE62
.LASFDE62:
	.4byte	.Lframe0
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.byte	0x4
	.4byte	.LCFI24-.LFB36
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI27-.LCFI24
	.byte	0x8c
	.uleb128 0x9
	.byte	0x8a
	.uleb128 0x7
	.byte	0x88
	.uleb128 0x5
	.align	4
.LEFDE62:
.LSFDE64:
	.4byte	.LEFDE64-.LASFDE64
.LASFDE64:
	.4byte	.Lframe0
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.byte	0x4
	.4byte	.LCFI28-.LFB37
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI30-.LCFI28
	.byte	0x8a
	.uleb128 0x7
	.byte	0x88
	.uleb128 0x5
	.align	4
.LEFDE64:
.LSFDE66:
	.4byte	.LEFDE66-.LASFDE66
.LASFDE66:
	.4byte	.Lframe0
	.4byte	.LFB38
	.4byte	.LFE38-.LFB38
	.byte	0x4
	.4byte	.LCFI31-.LFB38
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE66:
.LSFDE68:
	.4byte	.LEFDE68-.LASFDE68
.LASFDE68:
	.4byte	.Lframe0
	.4byte	.LFB39
	.4byte	.LFE39-.LFB39
	.align	4
.LEFDE68:
.LSFDE70:
	.4byte	.LEFDE70-.LASFDE70
.LASFDE70:
	.4byte	.Lframe0
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.byte	0x4
	.4byte	.LCFI32-.LFB40
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI33-.LCFI32
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE70:
.LSFDE72:
	.4byte	.LEFDE72-.LASFDE72
.LASFDE72:
	.4byte	.Lframe0
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.byte	0x4
	.4byte	.LCFI34-.LFB41
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI35-.LCFI34
	.byte	0x88
	.uleb128 0x5
	.align	4
.LEFDE72:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33E-GM-GP-MC-GU-MU_DFP/1.5.258/xc16/bin/..\\support\\dsPIC33E\\h/p33EP512MU810.h"
	.file 4 "../../../Source/include/projdefs.h"
	.file 5 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 6 "../../../Source/include/list.h"
	.file 7 "../../../Source/include/task.h"
	.section	.debug_info,info
	.4byte	0x1f91
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.asciz	"GNU C 4.5.1 (XC16, Microchip v2.10) (B) Build date: Mar 27 2023"
	.byte	0x1
	.asciz	"../../../Source/tasks.c"
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
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"signed char"
	.uleb128 0x3
	.asciz	"uint8_t"
	.byte	0x2
	.byte	0xbb
	.4byte	0x1a2
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.asciz	"unsigned char"
	.uleb128 0x3
	.asciz	"uint16_t"
	.byte	0x2
	.byte	0xc1
	.4byte	0x150
	.uleb128 0x3
	.asciz	"uint32_t"
	.byte	0x2
	.byte	0xcd
	.4byte	0x1d3
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
	.4byte	0x2eb
	.uleb128 0x5
	.asciz	"C"
	.byte	0x3
	.byte	0x89
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x32a
	.uleb128 0x5
	.asciz	"IPL0"
	.byte	0x3
	.byte	0x9a
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x1b3
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
	.4byte	0x33d
	.uleb128 0x7
	.4byte	0x202
	.uleb128 0x7
	.4byte	0x2eb
	.byte	0x0
	.uleb128 0x8
	.asciz	"tagSRBITS"
	.byte	0x2
	.byte	0x3
	.byte	0x86
	.4byte	0x358
	.uleb128 0x9
	.4byte	0x32a
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x3
	.asciz	"SRBITS"
	.byte	0x3
	.byte	0x9f
	.4byte	0x33d
	.uleb128 0x3
	.asciz	"TaskFunction_t"
	.byte	0x4
	.byte	0x24
	.4byte	0x37c
	.uleb128 0xa
	.byte	0x2
	.4byte	0x382
	.uleb128 0xb
	.byte	0x1
	.4byte	0x38e
	.uleb128 0xc
	.4byte	0x38e
	.byte	0x0
	.uleb128 0xd
	.byte	0x2
	.uleb128 0x3
	.asciz	"StackType_t"
	.byte	0x5
	.byte	0x60
	.4byte	0x1b3
	.uleb128 0x3
	.asciz	"BaseType_t"
	.byte	0x5
	.byte	0x61
	.4byte	0x3b5
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.asciz	"short int"
	.uleb128 0x3
	.asciz	"UBaseType_t"
	.byte	0x5
	.byte	0x62
	.4byte	0x12c
	.uleb128 0x3
	.asciz	"TickType_t"
	.byte	0x5
	.byte	0x65
	.4byte	0x1b3
	.uleb128 0xe
	.4byte	0x1c3
	.4byte	0x3f7
	.uleb128 0xf
	.4byte	0x150
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.4byte	0x193
	.4byte	0x407
	.uleb128 0xf
	.4byte	0x150
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.asciz	"xLIST_ITEM"
	.byte	0xa
	.byte	0x6
	.byte	0x90
	.4byte	0x470
	.uleb128 0x10
	.4byte	.LASF0
	.byte	0x6
	.byte	0x93
	.4byte	0x3d5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.asciz	"pxNext"
	.byte	0x6
	.byte	0x94
	.4byte	0x470
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x10
	.4byte	.LASF1
	.byte	0x6
	.byte	0x95
	.4byte	0x470
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.uleb128 0x11
	.asciz	"pvOwner"
	.byte	0x6
	.byte	0x96
	.4byte	0x38e
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.uleb128 0x11
	.asciz	"pvContainer"
	.byte	0x6
	.byte	0x97
	.4byte	0x4c0
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x407
	.uleb128 0x8
	.asciz	"xLIST"
	.byte	0xa
	.byte	0x6
	.byte	0xac
	.4byte	0x4c0
	.uleb128 0x11
	.asciz	"uxNumberOfItems"
	.byte	0x6
	.byte	0xaf
	.4byte	0x534
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x10
	.4byte	.LASF2
	.byte	0x6
	.byte	0xb0
	.4byte	0x539
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x11
	.asciz	"xListEnd"
	.byte	0x6
	.byte	0xb1
	.4byte	0x51e
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x476
	.uleb128 0x3
	.asciz	"ListItem_t"
	.byte	0x6
	.byte	0x9a
	.4byte	0x407
	.uleb128 0x8
	.asciz	"xMINI_LIST_ITEM"
	.byte	0x6
	.byte	0x6
	.byte	0x9d
	.4byte	0x51e
	.uleb128 0x10
	.4byte	.LASF0
	.byte	0x6
	.byte	0xa0
	.4byte	0x3d5
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.asciz	"pxNext"
	.byte	0x6
	.byte	0xa1
	.4byte	0x470
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x10
	.4byte	.LASF1
	.byte	0x6
	.byte	0xa2
	.4byte	0x470
	.byte	0x2
	.byte	0x23
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x3
	.asciz	"MiniListItem_t"
	.byte	0x6
	.byte	0xa4
	.4byte	0x4d8
	.uleb128 0x12
	.4byte	0x3c2
	.uleb128 0xa
	.byte	0x2
	.4byte	0x4c6
	.uleb128 0x3
	.asciz	"List_t"
	.byte	0x6
	.byte	0xb3
	.4byte	0x476
	.uleb128 0x3
	.asciz	"TaskHandle_t"
	.byte	0x7
	.byte	0x57
	.4byte	0x561
	.uleb128 0xa
	.byte	0x2
	.4byte	0x567
	.uleb128 0x8
	.asciz	"tskTaskControlBlock"
	.byte	0x26
	.byte	0x1
	.byte	0xff
	.4byte	0x64b
	.uleb128 0x13
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x101
	.4byte	0x7a9
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x14
	.asciz	"xStateListItem"
	.byte	0x1
	.2byte	0x107
	.4byte	0x4c6
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x14
	.asciz	"xEventListItem"
	.byte	0x1
	.2byte	0x108
	.4byte	0x4c6
	.byte	0x2
	.byte	0x23
	.uleb128 0xc
	.uleb128 0x13
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x109
	.4byte	0x3c2
	.byte	0x2
	.byte	0x23
	.uleb128 0x16
	.uleb128 0x14
	.asciz	"pxStack"
	.byte	0x1
	.2byte	0x10a
	.4byte	0x7a3
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x14
	.asciz	"pcTaskName"
	.byte	0x1
	.2byte	0x10b
	.4byte	0x7b4
	.byte	0x2
	.byte	0x23
	.uleb128 0x1a
	.uleb128 0x14
	.asciz	"pxEndOfStack"
	.byte	0x1
	.2byte	0x10e
	.4byte	0x7a3
	.byte	0x2
	.byte	0x23
	.uleb128 0x1e
	.uleb128 0x14
	.asciz	"ulNotifiedValue"
	.byte	0x1
	.2byte	0x130
	.4byte	0x7c4
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x14
	.asciz	"ucNotifyState"
	.byte	0x1
	.2byte	0x131
	.4byte	0x7c9
	.byte	0x2
	.byte	0x23
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x15
	.byte	0x2
	.byte	0x7
	.byte	0x6c
	.4byte	0x6ad
	.uleb128 0x16
	.asciz	"eNoAction"
	.sleb128 0
	.uleb128 0x16
	.asciz	"eSetBits"
	.sleb128 1
	.uleb128 0x16
	.asciz	"eIncrement"
	.sleb128 2
	.uleb128 0x16
	.asciz	"eSetValueWithOverwrite"
	.sleb128 3
	.uleb128 0x16
	.asciz	"eSetValueWithoutOverwrite"
	.sleb128 4
	.byte	0x0
	.uleb128 0x3
	.asciz	"eNotifyAction"
	.byte	0x7
	.byte	0x72
	.4byte	0x64b
	.uleb128 0x8
	.asciz	"xTIME_OUT"
	.byte	0x4
	.byte	0x7
	.byte	0x77
	.4byte	0x708
	.uleb128 0x11
	.asciz	"xOverflowCount"
	.byte	0x7
	.byte	0x79
	.4byte	0x3a3
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.asciz	"xTimeOnEntering"
	.byte	0x7
	.byte	0x7a
	.4byte	0x3d5
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x3
	.asciz	"TimeOut_t"
	.byte	0x7
	.byte	0x7b
	.4byte	0x6c2
	.uleb128 0x8
	.asciz	"xMEMORY_REGION"
	.byte	0xa
	.byte	0x7
	.byte	0x80
	.4byte	0x77a
	.uleb128 0x11
	.asciz	"pvBaseAddress"
	.byte	0x7
	.byte	0x82
	.4byte	0x38e
	.byte	0x2
	.byte	0x23
	.uleb128 0x0
	.uleb128 0x11
	.asciz	"ulLengthInBytes"
	.byte	0x7
	.byte	0x83
	.4byte	0x1c3
	.byte	0x2
	.byte	0x23
	.uleb128 0x2
	.uleb128 0x11
	.asciz	"ulParameters"
	.byte	0x7
	.byte	0x84
	.4byte	0x1c3
	.byte	0x2
	.byte	0x23
	.uleb128 0x6
	.byte	0x0
	.uleb128 0x3
	.asciz	"MemoryRegion_t"
	.byte	0x7
	.byte	0x85
	.4byte	0x719
	.uleb128 0xa
	.byte	0x2
	.4byte	0x796
	.uleb128 0x17
	.4byte	0x79b
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.asciz	"char"
	.uleb128 0xa
	.byte	0x2
	.4byte	0x390
	.uleb128 0xa
	.byte	0x2
	.4byte	0x7af
	.uleb128 0x12
	.4byte	0x390
	.uleb128 0xe
	.4byte	0x79b
	.4byte	0x7c4
	.uleb128 0xf
	.4byte	0x150
	.byte	0x3
	.byte	0x0
	.uleb128 0x12
	.4byte	0x3e7
	.uleb128 0x12
	.4byte	0x3f7
	.uleb128 0x18
	.asciz	"tskTCB"
	.byte	0x1
	.2byte	0x141
	.4byte	0x567
	.uleb128 0x18
	.asciz	"TCB_t"
	.byte	0x1
	.2byte	0x145
	.4byte	0x7ce
	.uleb128 0x19
	.asciz	"prvCheckTasksWaitingTermination"
	.byte	0x1
	.2byte	0xe69
	.byte	0x1
	.byte	0x1
	.uleb128 0x1a
	.asciz	"prvInitialiseNewTask"
	.byte	0x1
	.2byte	0x330
	.byte	0x1
	.byte	0x1
	.4byte	0x8b8
	.uleb128 0x1b
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x330
	.4byte	0x366
	.uleb128 0x1c
	.asciz	"pcName"
	.byte	0x1
	.2byte	0x331
	.4byte	0x8b8
	.uleb128 0x1c
	.asciz	"ulStackDepth"
	.byte	0x1
	.2byte	0x332
	.4byte	0x8bd
	.uleb128 0x1b
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x333
	.4byte	0x8c2
	.uleb128 0x1b
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x334
	.4byte	0x3c2
	.uleb128 0x1b
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x335
	.4byte	0x8c7
	.uleb128 0x1b
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x336
	.4byte	0x8d2
	.uleb128 0x1c
	.asciz	"xRegions"
	.byte	0x1
	.2byte	0x337
	.4byte	0x8d8
	.uleb128 0x1d
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x339
	.4byte	0x7a3
	.uleb128 0x1e
	.asciz	"x"
	.byte	0x1
	.2byte	0x33a
	.4byte	0x3c2
	.byte	0x0
	.uleb128 0x17
	.4byte	0x790
	.uleb128 0x17
	.4byte	0x1c3
	.uleb128 0x17
	.4byte	0x38e
	.uleb128 0x17
	.4byte	0x8cc
	.uleb128 0xa
	.byte	0x2
	.4byte	0x54d
	.uleb128 0xa
	.byte	0x2
	.4byte	0x7dd
	.uleb128 0x17
	.4byte	0x8dd
	.uleb128 0xa
	.byte	0x2
	.4byte	0x8e3
	.uleb128 0x17
	.4byte	0x77a
	.uleb128 0x1a
	.asciz	"prvInitialiseTaskLists"
	.byte	0x1
	.2byte	0xe49
	.byte	0x1
	.byte	0x1
	.4byte	0x916
	.uleb128 0x1d
	.4byte	.LASF4
	.byte	0x1
	.2byte	0xe4b
	.4byte	0x3c2
	.byte	0x0
	.uleb128 0x1f
	.asciz	"prvTaskIsTaskSuspended"
	.byte	0x1
	.2byte	0x6f3
	.byte	0x1
	.4byte	0x3a3
	.byte	0x1
	.4byte	0x960
	.uleb128 0x1b
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x6f3
	.4byte	0x960
	.uleb128 0x1d
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x6f5
	.4byte	0x3a3
	.uleb128 0x1d
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x6f6
	.4byte	0x965
	.byte	0x0
	.uleb128 0x17
	.4byte	0x54d
	.uleb128 0x17
	.4byte	0x96a
	.uleb128 0xa
	.byte	0x2
	.4byte	0x970
	.uleb128 0x17
	.4byte	0x7dd
	.uleb128 0x19
	.asciz	"prvResetNextTaskUnblockTime"
	.byte	0x1
	.2byte	0xf9f
	.byte	0x1
	.byte	0x1
	.uleb128 0x20
	.byte	0x1
	.asciz	"vTaskSuspendAll"
	.byte	0x1
	.2byte	0x82a
	.byte	0x1
	.byte	0x1
	.uleb128 0x21
	.byte	0x1
	.asciz	"vTaskInternalSetTimeOutState"
	.byte	0x1
	.2byte	0xce2
	.byte	0x1
	.byte	0x1
	.4byte	0x9e3
	.uleb128 0x1b
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xce2
	.4byte	0x9e3
	.byte	0x0
	.uleb128 0x17
	.4byte	0x9e8
	.uleb128 0xa
	.byte	0x2
	.4byte	0x708
	.uleb128 0x22
	.asciz	"prvAddCurrentTaskToDelayedList"
	.byte	0x1
	.2byte	0x14b1
	.byte	0x1
	.4byte	.LFB42
	.4byte	.LFE42
	.byte	0x1
	.byte	0x5f
	.4byte	0xa83
	.uleb128 0x23
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x14b1
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"xCanBlockIndefinitely"
	.byte	0x1
	.2byte	0x14b2
	.4byte	0xa83
	.byte	0x1
	.byte	0x5a
	.uleb128 0x25
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x14b4
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x25
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x14b5
	.4byte	0xa88
	.byte	0x1
	.byte	0x59
	.uleb128 0x26
	.4byte	.LBB42
	.4byte	.LBE42
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x14d4
	.4byte	0xa8d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x3a3
	.uleb128 0x17
	.4byte	0x3d5
	.uleb128 0x17
	.4byte	0x539
	.uleb128 0x22
	.asciz	"prvIdleTask"
	.byte	0x1
	.2byte	0xd63
	.byte	0x1
	.4byte	.LFB29
	.4byte	.LFE29
	.byte	0x1
	.byte	0x5f
	.4byte	0xae6
	.uleb128 0x23
	.4byte	.LASF6
	.byte	0x1
	.2byte	0xd63
	.4byte	0x38e
	.byte	0x1
	.byte	0x50
	.uleb128 0x26
	.4byte	.LBB43
	.4byte	.LBE43
	.uleb128 0x27
	.byte	0x1
	.asciz	"vApplicationIdleHook"
	.byte	0x1
	.2byte	0xd98
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x1a
	.asciz	"prvAddNewTaskToReadyList"
	.byte	0x1
	.2byte	0x402
	.byte	0x1
	.byte	0x1
	.4byte	0xb24
	.uleb128 0x1b
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x402
	.4byte	0x8d2
	.uleb128 0x28
	.uleb128 0x1d
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x43c
	.4byte	0xa8d
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskCreate"
	.byte	0x1
	.2byte	0x2d1
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB0
	.4byte	.LFE0
	.byte	0x1
	.byte	0x5f
	.4byte	0xc58
	.uleb128 0x23
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x2d1
	.4byte	0x366
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"pcName"
	.byte	0x1
	.2byte	0x2d2
	.4byte	0x8b8
	.byte	0x1
	.byte	0x59
	.uleb128 0x24
	.asciz	"usStackDepth"
	.byte	0x1
	.2byte	0x2d3
	.4byte	0xc58
	.byte	0x1
	.byte	0x5a
	.uleb128 0x23
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x2d4
	.4byte	0x8c2
	.byte	0x1
	.byte	0x5e
	.uleb128 0x23
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x2d5
	.4byte	0x3c2
	.byte	0x2
	.byte	0x7f
	.sleb128 -18
	.uleb128 0x23
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x2d6
	.4byte	0x8c7
	.byte	0x1
	.byte	0x5d
	.uleb128 0x25
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x2d8
	.4byte	0x8d2
	.byte	0x1
	.byte	0x5b
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x2d9
	.4byte	0x3a3
	.byte	0x1
	.byte	0x51
	.uleb128 0x2a
	.4byte	0x811
	.4byte	.LBB51
	.4byte	.LBE51
	.4byte	0xc10
	.uleb128 0x2b
	.4byte	0x884
	.uleb128 0x2b
	.4byte	0x878
	.uleb128 0x2b
	.4byte	0x86c
	.uleb128 0x2b
	.4byte	0x860
	.uleb128 0x2b
	.4byte	0x84b
	.uleb128 0x2b
	.4byte	0x83c
	.uleb128 0x2b
	.4byte	0x830
	.uleb128 0x26
	.4byte	.LBB53
	.4byte	.LBE53
	.uleb128 0x2c
	.4byte	0x8a1
	.uleb128 0x2d
	.4byte	0x8ad
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x2e
	.4byte	0xae6
	.4byte	.LBB56
	.4byte	.LBE56
	.uleb128 0x2b
	.4byte	0xb09
	.uleb128 0x2f
	.4byte	.LBB58
	.4byte	.LBE58
	.4byte	0xc37
	.uleb128 0x2d
	.4byte	0xb16
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x2e
	.4byte	0x8e8
	.4byte	.LBB59
	.4byte	.LBE59
	.uleb128 0x26
	.4byte	.LBB60
	.4byte	.LBE60
	.uleb128 0x2d
	.4byte	0x909
	.byte	0x1
	.byte	0x5a
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x1b3
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskPrioritySet"
	.byte	0x1
	.2byte	0x5e3
	.byte	0x1
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.4byte	0xd1b
	.uleb128 0x23
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x5e3
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"uxNewPriority"
	.byte	0x1
	.2byte	0x5e4
	.4byte	0x3c2
	.byte	0x1
	.byte	0x51
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x5e6
	.4byte	0x8d2
	.byte	0x1
	.byte	0x58
	.uleb128 0x31
	.asciz	"uxCurrentBasePriority"
	.byte	0x1
	.2byte	0x5e7
	.4byte	0x3c2
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.asciz	"uxPriorityUsedOnEntry"
	.byte	0x1
	.2byte	0x5e7
	.4byte	0x3c2
	.uleb128 0x25
	.4byte	.LASF16
	.byte	0x1
	.2byte	0x5e8
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.uleb128 0x26
	.4byte	.LBB64
	.4byte	.LBE64
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x66c
	.4byte	0xa8d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskResume"
	.byte	0x1
	.2byte	0x721
	.byte	0x1
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.4byte	0xd99
	.uleb128 0x23
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x721
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x1d
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x723
	.4byte	0xd99
	.uleb128 0x2a
	.4byte	0x916
	.4byte	.LBB65
	.4byte	.LBE65
	.4byte	0xd80
	.uleb128 0x2b
	.4byte	0x93b
	.uleb128 0x26
	.4byte	.LBB66
	.4byte	.LBE66
	.uleb128 0x2c
	.4byte	0x947
	.uleb128 0x2c
	.4byte	0x953
	.byte	0x0
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB69
	.4byte	.LBE69
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x735
	.4byte	0xa8d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x8d2
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskResumeFromISR"
	.byte	0x1
	.2byte	0x757
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB9
	.4byte	.LFE9
	.byte	0x1
	.byte	0x5f
	.4byte	0xe41
	.uleb128 0x23
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x757
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x25
	.4byte	.LASF16
	.byte	0x1
	.2byte	0x759
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.uleb128 0x1d
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x75a
	.4byte	0xd99
	.uleb128 0x1d
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x75b
	.4byte	0x3c2
	.uleb128 0x2a
	.4byte	0x916
	.4byte	.LBB70
	.4byte	.LBE70
	.4byte	0xe28
	.uleb128 0x2b
	.4byte	0x93b
	.uleb128 0x26
	.4byte	.LBB71
	.4byte	.LBE71
	.uleb128 0x2c
	.4byte	0x947
	.uleb128 0x2c
	.4byte	0x953
	.byte	0x0
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB74
	.4byte	.LBE74
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x78b
	.4byte	0xa8d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskStartScheduler"
	.byte	0x1
	.2byte	0x7a2
	.byte	0x1
	.4byte	.LFB10
	.4byte	.LFE10
	.byte	0x1
	.byte	0x5f
	.4byte	0xe78
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x7a4
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x32
	.byte	0x1
	.asciz	"vTaskEndScheduler"
	.byte	0x1
	.2byte	0x81f
	.byte	0x1
	.4byte	.LFB11
	.4byte	.LFE11
	.byte	0x1
	.byte	0x5f
	.uleb128 0x33
	.4byte	0x997
	.4byte	.LFB12
	.4byte	.LFE12
	.byte	0x1
	.byte	0x5f
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGetTickCount"
	.byte	0x1
	.2byte	0x8ee
	.byte	0x1
	.4byte	0x3d5
	.4byte	.LFB14
	.4byte	.LFE14
	.byte	0x1
	.byte	0x5f
	.4byte	0xee5
	.uleb128 0x31
	.asciz	"xTicks"
	.byte	0x1
	.2byte	0x8f0
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGetTickCountFromISR"
	.byte	0x1
	.2byte	0x8fd
	.byte	0x1
	.4byte	0x3d5
	.4byte	.LFB15
	.4byte	.LFE15
	.byte	0x1
	.byte	0x5f
	.4byte	0xf31
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x8ff
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.uleb128 0x1d
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x900
	.4byte	0x3c2
	.byte	0x0
	.uleb128 0x34
	.byte	0x1
	.asciz	"uxTaskGetNumberOfTasks"
	.byte	0x1
	.2byte	0x91c
	.byte	0x1
	.4byte	0x3c2
	.4byte	.LFB16
	.4byte	.LFE16
	.byte	0x1
	.byte	0x5f
	.uleb128 0x29
	.byte	0x1
	.asciz	"pcTaskGetName"
	.byte	0x1
	.2byte	0x924
	.byte	0x1
	.4byte	0xfa8
	.4byte	.LFB17
	.4byte	.LFE17
	.byte	0x1
	.byte	0x5f
	.4byte	0xfa8
	.uleb128 0x24
	.asciz	"xTaskToQuery"
	.byte	0x1
	.2byte	0x924
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x926
	.4byte	0x8d2
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x79b
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskIncrementTick"
	.byte	0x1
	.2byte	0xaa0
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB19
	.4byte	.LFE19
	.byte	0x1
	.byte	0x5f
	.4byte	0x10a2
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0xaa2
	.4byte	0x8d2
	.byte	0x1
	.byte	0x51
	.uleb128 0x25
	.4byte	.LASF0
	.byte	0x1
	.2byte	0xaa3
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.uleb128 0x31
	.asciz	"xSwitchRequired"
	.byte	0x1
	.2byte	0xaa4
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.uleb128 0x26
	.4byte	.LBB75
	.4byte	.LBE75
	.uleb128 0x25
	.4byte	.LASF15
	.byte	0x1
	.2byte	0xaaf
	.4byte	0xa88
	.byte	0x1
	.byte	0x57
	.uleb128 0x2f
	.4byte	.LBB76
	.4byte	.LBE76
	.4byte	0x1042
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xaf8
	.4byte	0xa8d
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB77
	.4byte	.LBE77
	.4byte	0x105c
	.uleb128 0x1d
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xaef
	.4byte	0x10a2
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB79
	.4byte	.LBE79
	.4byte	0x1078
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xae9
	.4byte	0x10a2
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB80
	.4byte	.LBE80
	.uleb128 0x31
	.asciz	"pxTemp"
	.byte	0x1
	.2byte	0xab7
	.4byte	0x10a7
	.byte	0x1
	.byte	0x50
	.uleb128 0x35
	.4byte	0x975
	.4byte	.LBB81
	.4byte	.LBE81
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x10a7
	.uleb128 0xa
	.byte	0x2
	.4byte	0x53f
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskResumeAll"
	.byte	0x1
	.2byte	0x87e
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB13
	.4byte	.LFE13
	.byte	0x1
	.byte	0x5f
	.4byte	0x1174
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x880
	.4byte	0x8d2
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x881
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.uleb128 0x2f
	.4byte	.LBB89
	.4byte	.LBE89
	.4byte	0x110c
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x899
	.4byte	0x10a2
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB90
	.4byte	.LBE90
	.4byte	0x1128
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x89c
	.4byte	0xa8d
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB92
	.4byte	.LBE92
	.4byte	0x1144
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x89b
	.4byte	0x10a2
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x35
	.4byte	0x975
	.4byte	.LBB94
	.4byte	.LBE94
	.uleb128 0x26
	.4byte	.LBB97
	.4byte	.LBE97
	.uleb128 0x31
	.asciz	"xPendedCounts"
	.byte	0x1
	.2byte	0x8ba
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskCatchUpTicks"
	.byte	0x1
	.2byte	0xa38
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB18
	.4byte	.LFE18
	.byte	0x1
	.byte	0x5f
	.4byte	0x11df
	.uleb128 0x24
	.asciz	"xTicksToCatchUp"
	.byte	0x1
	.2byte	0xa38
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x31
	.asciz	"xYieldOccurred"
	.byte	0x1
	.2byte	0xa3a
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x35
	.4byte	0x997
	.4byte	.LBB104
	.4byte	.LBE104
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskDelay"
	.byte	0x1
	.2byte	0x515
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x1232
	.uleb128 0x24
	.asciz	"xTicksToDelay"
	.byte	0x1
	.2byte	0x515
	.4byte	0xa88
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x517
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x35
	.4byte	0x997
	.4byte	.LBB106
	.4byte	.LBE106
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskDelayUntil"
	.byte	0x1
	.2byte	0x4be
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB3
	.4byte	.LFE3
	.byte	0x1
	.byte	0x5f
	.4byte	0x12e9
	.uleb128 0x24
	.asciz	"pxPreviousWakeTime"
	.byte	0x1
	.2byte	0x4be
	.4byte	0x12e9
	.byte	0x1
	.byte	0x50
	.uleb128 0x24
	.asciz	"xTimeIncrement"
	.byte	0x1
	.2byte	0x4bf
	.4byte	0xa88
	.byte	0x1
	.byte	0x51
	.uleb128 0x25
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x4c1
	.4byte	0x3d5
	.byte	0x1
	.byte	0x51
	.uleb128 0x25
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x4c2
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x31
	.asciz	"xShouldDelay"
	.byte	0x1
	.2byte	0x4c2
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.uleb128 0x35
	.4byte	0x997
	.4byte	.LBB108
	.4byte	.LBE108
	.uleb128 0x26
	.4byte	.LBB110
	.4byte	.LBE110
	.uleb128 0x25
	.4byte	.LASF15
	.byte	0x1
	.2byte	0x4cc
	.4byte	0xa88
	.byte	0x1
	.byte	0x53
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x12ee
	.uleb128 0xa
	.byte	0x2
	.4byte	0x3d5
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskSwitchContext"
	.byte	0x1
	.2byte	0xbc1
	.byte	0x1
	.4byte	.LFB20
	.4byte	.LFE20
	.byte	0x1
	.byte	0x5f
	.4byte	0x135c
	.uleb128 0x26
	.4byte	.LBB112
	.4byte	.LBE112
	.uleb128 0x31
	.asciz	"uxTopPriority"
	.byte	0x1
	.2byte	0xbf6
	.4byte	0x3c2
	.byte	0x1
	.byte	0x50
	.uleb128 0x26
	.4byte	.LBB113
	.4byte	.LBE113
	.uleb128 0x1e
	.asciz	"pxConstList"
	.byte	0x1
	.2byte	0xbf6
	.4byte	0x10a2
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskSuspend"
	.byte	0x1
	.2byte	0x689
	.byte	0x1
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.4byte	0x13ca
	.uleb128 0x24
	.asciz	"xTaskToSuspend"
	.byte	0x1
	.2byte	0x689
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x68b
	.4byte	0x8d2
	.byte	0x1
	.byte	0x58
	.uleb128 0x2f
	.4byte	.LBB116
	.4byte	.LBE116
	.4byte	0x13bc
	.uleb128 0x1e
	.asciz	"x"
	.byte	0x1
	.2byte	0x6ae
	.4byte	0x3a3
	.byte	0x0
	.uleb128 0x35
	.4byte	0x975
	.4byte	.LBB117
	.4byte	.LBE117
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskPlaceOnEventList"
	.byte	0x1
	.2byte	0xc0b
	.byte	0x1
	.4byte	.LFB21
	.4byte	.LFE21
	.byte	0x1
	.byte	0x5f
	.4byte	0x1411
	.uleb128 0x23
	.4byte	.LASF21
	.byte	0x1
	.2byte	0xc0b
	.4byte	0x10a2
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF13
	.byte	0x1
	.2byte	0xc0c
	.4byte	0xa88
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskPlaceOnUnorderedEventList"
	.byte	0x1
	.2byte	0xc24
	.byte	0x1
	.4byte	.LFB22
	.4byte	.LFE22
	.byte	0x1
	.byte	0x5f
	.4byte	0x1487
	.uleb128 0x23
	.4byte	.LASF21
	.byte	0x1
	.2byte	0xc24
	.4byte	0x10a7
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF0
	.byte	0x1
	.2byte	0xc25
	.4byte	0xa88
	.byte	0x1
	.byte	0x51
	.uleb128 0x23
	.4byte	.LASF13
	.byte	0x1
	.2byte	0xc26
	.4byte	0xa88
	.byte	0x1
	.byte	0x52
	.uleb128 0x26
	.4byte	.LBB122
	.4byte	.LBE122
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xc38
	.4byte	0xa8d
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskRemoveFromEventList"
	.byte	0x1
	.2byte	0xc61
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB23
	.4byte	.LFE23
	.byte	0x1
	.byte	0x5f
	.4byte	0x154f
	.uleb128 0x23
	.4byte	.LASF21
	.byte	0x1
	.2byte	0xc61
	.4byte	0x154f
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LASF22
	.byte	0x1
	.2byte	0xc63
	.4byte	0x8d2
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0xc64
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x2f
	.4byte	.LBB123
	.4byte	.LBE123
	.4byte	0x14fe
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xc75
	.4byte	0x10a2
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB124
	.4byte	.LBE124
	.4byte	0x151a
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xc79
	.4byte	0x10a2
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB125
	.4byte	.LBE125
	.4byte	0x1536
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xc7a
	.4byte	0xa8d
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB126
	.4byte	.LBE126
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xc8e
	.4byte	0xa8d
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x1554
	.uleb128 0xa
	.byte	0x2
	.4byte	0x155a
	.uleb128 0x17
	.4byte	0x53f
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskRemoveFromUnorderedEventList"
	.byte	0x1
	.2byte	0xca5
	.byte	0x1
	.4byte	.LFB24
	.4byte	.LFE24
	.byte	0x1
	.byte	0x5f
	.4byte	0x161c
	.uleb128 0x24
	.asciz	"pxEventListItem"
	.byte	0x1
	.2byte	0xca5
	.4byte	0x539
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF0
	.byte	0x1
	.2byte	0xca6
	.4byte	0xa88
	.byte	0x1
	.byte	0x51
	.uleb128 0x25
	.4byte	.LASF22
	.byte	0x1
	.2byte	0xca8
	.4byte	0x8d2
	.byte	0x1
	.byte	0x51
	.uleb128 0x2f
	.4byte	.LBB129
	.4byte	.LBE129
	.4byte	0x15e7
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xcb5
	.4byte	0x10a2
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB130
	.4byte	.LBE130
	.4byte	0x1603
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xcc8
	.4byte	0x10a2
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB131
	.4byte	.LBE131
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xcc9
	.4byte	0xa8d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskSetTimeOutState"
	.byte	0x1
	.2byte	0xcd6
	.byte	0x1
	.4byte	.LFB25
	.4byte	.LFE25
	.byte	0x1
	.byte	0x5f
	.4byte	0x1654
	.uleb128 0x23
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xcd6
	.4byte	0x9e3
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x36
	.4byte	0x9ae
	.4byte	.LFB26
	.4byte	.LFE26
	.byte	0x1
	.byte	0x5f
	.4byte	0x166f
	.uleb128 0x37
	.4byte	0x9d6
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskCheckForTimeOut"
	.byte	0x1
	.2byte	0xcea
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB27
	.4byte	.LFE27
	.byte	0x1
	.byte	0x5f
	.4byte	0x1713
	.uleb128 0x23
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xcea
	.4byte	0x9e3
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"pxTicksToWait"
	.byte	0x1
	.2byte	0xceb
	.4byte	0x12e9
	.byte	0x1
	.byte	0x5a
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0xced
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.uleb128 0x26
	.4byte	.LBB135
	.4byte	.LBE135
	.uleb128 0x25
	.4byte	.LASF15
	.byte	0x1
	.2byte	0xcf5
	.4byte	0xa88
	.byte	0x1
	.byte	0x51
	.uleb128 0x31
	.asciz	"xElapsedTime"
	.byte	0x1
	.2byte	0xcf6
	.4byte	0xa88
	.byte	0x1
	.byte	0x50
	.uleb128 0x2e
	.4byte	0x9ae
	.4byte	.LBB136
	.4byte	.LBE136
	.uleb128 0x2b
	.4byte	0x9d6
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x32
	.byte	0x1
	.asciz	"vTaskMissedYield"
	.byte	0x1
	.2byte	0xd2b
	.byte	0x1
	.4byte	.LFB28
	.4byte	.LFE28
	.byte	0x1
	.byte	0x5f
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGetCurrentTaskHandle"
	.byte	0x1
	.2byte	0xfb6
	.byte	0x1
	.4byte	0x54d
	.4byte	.LFB33
	.4byte	.LFE33
	.byte	0x1
	.byte	0x5f
	.4byte	0x1775
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0xfb8
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"uxTaskResetEventItemValue"
	.byte	0x1
	.2byte	0x1232
	.byte	0x1
	.4byte	0x3d5
	.4byte	.LFB34
	.4byte	.LFE34
	.byte	0x1
	.byte	0x5f
	.4byte	0x17bb
	.uleb128 0x31
	.asciz	"uxReturn"
	.byte	0x1
	.2byte	0x1234
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"ulTaskGenericNotifyTake"
	.byte	0x1
	.2byte	0x1253
	.byte	0x1
	.4byte	0x1c3
	.4byte	.LFB35
	.4byte	.LFE35
	.byte	0x1
	.byte	0x5f
	.4byte	0x1837
	.uleb128 0x23
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x1253
	.4byte	0x3c2
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"xClearCountOnExit"
	.byte	0x1
	.2byte	0x1254
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.uleb128 0x23
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x1255
	.4byte	0x3d5
	.byte	0x1
	.byte	0x5b
	.uleb128 0x25
	.4byte	.LASF24
	.byte	0x1
	.2byte	0x1257
	.4byte	0x1c3
	.byte	0x6
	.byte	0x5c
	.byte	0x93
	.uleb128 0x2
	.byte	0x5d
	.byte	0x93
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGenericNotifyWait"
	.byte	0x1
	.2byte	0x129b
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB36
	.4byte	.LFE36
	.byte	0x1
	.byte	0x5f
	.4byte	0x18f7
	.uleb128 0x23
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x129b
	.4byte	0x3c2
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"ulBitsToClearOnEntry"
	.byte	0x1
	.2byte	0x129c
	.4byte	0x1c3
	.byte	0x6
	.byte	0x52
	.byte	0x93
	.uleb128 0x2
	.byte	0x53
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x24
	.asciz	"ulBitsToClearOnExit"
	.byte	0x1
	.2byte	0x129d
	.4byte	0x1c3
	.byte	0x6
	.byte	0x5a
	.byte	0x93
	.uleb128 0x2
	.byte	0x5b
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x24
	.asciz	"pulNotificationValue"
	.byte	0x1
	.2byte	0x129e
	.4byte	0x18f7
	.byte	0x1
	.byte	0x59
	.uleb128 0x23
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x129f
	.4byte	0x3d5
	.byte	0x1
	.byte	0x5d
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x12a1
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x1c3
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGenericNotify"
	.byte	0x1
	.2byte	0x12f1
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB37
	.4byte	.LFE37
	.byte	0x1
	.byte	0x5f
	.4byte	0x19d8
	.uleb128 0x23
	.4byte	.LASF25
	.byte	0x1
	.2byte	0x12f1
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x23
	.4byte	.LASF26
	.byte	0x1
	.2byte	0x12f2
	.4byte	0x3c2
	.byte	0x1
	.byte	0x59
	.uleb128 0x24
	.asciz	"ulValue"
	.byte	0x1
	.2byte	0x12f3
	.4byte	0x1c3
	.byte	0x6
	.byte	0x52
	.byte	0x93
	.uleb128 0x2
	.byte	0x53
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x24
	.asciz	"eAction"
	.byte	0x1
	.2byte	0x12f4
	.4byte	0x6ad
	.byte	0x1
	.byte	0x5a
	.uleb128 0x23
	.4byte	.LASF27
	.byte	0x1
	.2byte	0x12f5
	.4byte	0x18f7
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1d
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x12f7
	.4byte	0x8d2
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x12f8
	.4byte	0x3a3
	.byte	0x1
	.byte	0x5a
	.uleb128 0x25
	.4byte	.LASF28
	.byte	0x1
	.2byte	0x12f9
	.4byte	0x193
	.byte	0x1
	.byte	0x50
	.uleb128 0x2f
	.4byte	.LBB139
	.4byte	.LBE139
	.4byte	0x19bf
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x133c
	.4byte	0x10a2
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB140
	.4byte	.LBE140
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x133d
	.4byte	0xa8d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGenericNotifyFromISR"
	.byte	0x1
	.2byte	0x136c
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB38
	.4byte	.LFE38
	.byte	0x1
	.byte	0x5f
	.4byte	0x1af0
	.uleb128 0x23
	.4byte	.LASF25
	.byte	0x1
	.2byte	0x136c
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF26
	.byte	0x1
	.2byte	0x136d
	.4byte	0x3c2
	.byte	0x1
	.byte	0x51
	.uleb128 0x24
	.asciz	"ulValue"
	.byte	0x1
	.2byte	0x136e
	.4byte	0x1c3
	.byte	0x6
	.byte	0x52
	.byte	0x93
	.uleb128 0x2
	.byte	0x53
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x24
	.asciz	"eAction"
	.byte	0x1
	.2byte	0x136f
	.4byte	0x6ad
	.byte	0x1
	.byte	0x54
	.uleb128 0x23
	.4byte	.LASF27
	.byte	0x1
	.2byte	0x1370
	.4byte	0x18f7
	.byte	0x1
	.byte	0x55
	.uleb128 0x23
	.4byte	.LASF29
	.byte	0x1
	.2byte	0x1371
	.4byte	0x1af0
	.byte	0x1
	.byte	0x56
	.uleb128 0x1d
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x1373
	.4byte	0x8d2
	.uleb128 0x25
	.4byte	.LASF28
	.byte	0x1
	.2byte	0x1374
	.4byte	0x193
	.byte	0x1
	.byte	0x55
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1375
	.4byte	0x3a3
	.byte	0x1
	.byte	0x54
	.uleb128 0x1d
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x1376
	.4byte	0x3c2
	.uleb128 0x2f
	.4byte	.LBB142
	.4byte	.LBE142
	.4byte	0x1abb
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x13cf
	.4byte	0x10a2
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB143
	.4byte	.LBE143
	.4byte	0x1ad7
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x13d0
	.4byte	0xa8d
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB144
	.4byte	.LBE144
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x13d6
	.4byte	0xa8d
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x3a3
	.uleb128 0x30
	.byte	0x1
	.asciz	"vTaskGenericNotifyGiveFromISR"
	.byte	0x1
	.2byte	0x13f7
	.byte	0x1
	.4byte	.LFB39
	.4byte	.LFE39
	.byte	0x1
	.byte	0x5f
	.4byte	0x1bc9
	.uleb128 0x23
	.4byte	.LASF25
	.byte	0x1
	.2byte	0x13f7
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF26
	.byte	0x1
	.2byte	0x13f8
	.4byte	0x3c2
	.byte	0x1
	.byte	0x51
	.uleb128 0x23
	.4byte	.LASF29
	.byte	0x1
	.2byte	0x13f9
	.4byte	0x1af0
	.byte	0x1
	.byte	0x52
	.uleb128 0x1d
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x13fb
	.4byte	0x8d2
	.uleb128 0x25
	.4byte	.LASF28
	.byte	0x1
	.2byte	0x13fc
	.4byte	0x193
	.byte	0x1
	.byte	0x53
	.uleb128 0x1d
	.4byte	.LASF18
	.byte	0x1
	.2byte	0x13fd
	.4byte	0x3c2
	.uleb128 0x2f
	.4byte	.LBB146
	.4byte	.LBE146
	.4byte	0x1b94
	.uleb128 0x25
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x142a
	.4byte	0x10a2
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x2f
	.4byte	.LBB147
	.4byte	.LBE147
	.4byte	0x1bb0
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x142b
	.4byte	0xa8d
	.byte	0x1
	.byte	0x53
	.byte	0x0
	.uleb128 0x26
	.4byte	.LBB148
	.4byte	.LBE148
	.uleb128 0x25
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x1431
	.4byte	0xa8d
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"xTaskGenericNotifyStateClear"
	.byte	0x1
	.2byte	0x1450
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB40
	.4byte	.LFE40
	.byte	0x1
	.byte	0x5f
	.4byte	0x1c37
	.uleb128 0x23
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x1450
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF30
	.byte	0x1
	.2byte	0x1451
	.4byte	0x3c2
	.byte	0x1
	.byte	0x59
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x1453
	.4byte	0x8d2
	.byte	0x1
	.byte	0x5a
	.uleb128 0x25
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1454
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x29
	.byte	0x1
	.asciz	"ulTaskGenericNotifyValueClear"
	.byte	0x1
	.2byte	0x1472
	.byte	0x1
	.4byte	0x1c3
	.4byte	.LFB41
	.4byte	.LFE41
	.byte	0x1
	.byte	0x5f
	.4byte	0x1cc8
	.uleb128 0x23
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x1472
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x23
	.4byte	.LASF30
	.byte	0x1
	.2byte	0x1473
	.4byte	0x3c2
	.byte	0x1
	.byte	0x58
	.uleb128 0x24
	.asciz	"ulBitsToClear"
	.byte	0x1
	.2byte	0x1474
	.4byte	0x1c3
	.byte	0x6
	.byte	0x52
	.byte	0x93
	.uleb128 0x2
	.byte	0x53
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x25
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x1476
	.4byte	0x8d2
	.byte	0x1
	.byte	0x59
	.uleb128 0x25
	.4byte	.LASF24
	.byte	0x1
	.2byte	0x1477
	.4byte	0x1c3
	.byte	0x6
	.byte	0x58
	.byte	0x93
	.uleb128 0x2
	.byte	0x59
	.byte	0x93
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x38
	.asciz	"SRbits"
	.byte	0x3
	.byte	0xa0
	.4byte	0x1cd8
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x358
	.uleb128 0x39
	.4byte	.LASF31
	.byte	0x1
	.2byte	0x149
	.4byte	0x1ceb
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x8d2
	.uleb128 0xe
	.4byte	0x53f
	.4byte	0x1d00
	.uleb128 0xf
	.4byte	0x150
	.byte	0x3
	.byte	0x0
	.uleb128 0x31
	.asciz	"pxReadyTasksLists"
	.byte	0x1
	.2byte	0x14f
	.4byte	0x1cf0
	.byte	0x5
	.byte	0x3
	.4byte	_pxReadyTasksLists
	.uleb128 0x31
	.asciz	"xDelayedTaskList1"
	.byte	0x1
	.2byte	0x150
	.4byte	0x53f
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedTaskList1
	.uleb128 0x31
	.asciz	"xDelayedTaskList2"
	.byte	0x1
	.2byte	0x151
	.4byte	0x53f
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedTaskList2
	.uleb128 0x31
	.asciz	"pxDelayedTaskList"
	.byte	0x1
	.2byte	0x152
	.4byte	0x1d80
	.byte	0x5
	.byte	0x3
	.4byte	_pxDelayedTaskList
	.uleb128 0x12
	.4byte	0x10a7
	.uleb128 0x31
	.asciz	"pxOverflowDelayedTaskList"
	.byte	0x1
	.2byte	0x153
	.4byte	0x1d80
	.byte	0x5
	.byte	0x3
	.4byte	_pxOverflowDelayedTaskList
	.uleb128 0x31
	.asciz	"xPendingReadyList"
	.byte	0x1
	.2byte	0x154
	.4byte	0x53f
	.byte	0x5
	.byte	0x3
	.4byte	_xPendingReadyList
	.uleb128 0x31
	.asciz	"xSuspendedTaskList"
	.byte	0x1
	.2byte	0x15f
	.4byte	0x53f
	.byte	0x5
	.byte	0x3
	.4byte	_xSuspendedTaskList
	.uleb128 0x31
	.asciz	"uxCurrentNumberOfTasks"
	.byte	0x1
	.2byte	0x16a
	.4byte	0x534
	.byte	0x5
	.byte	0x3
	.4byte	_uxCurrentNumberOfTasks
	.uleb128 0x31
	.asciz	"xTickCount"
	.byte	0x1
	.2byte	0x16b
	.4byte	0x1e2c
	.byte	0x5
	.byte	0x3
	.4byte	_xTickCount
	.uleb128 0x12
	.4byte	0x3d5
	.uleb128 0x31
	.asciz	"uxTopReadyPriority"
	.byte	0x1
	.2byte	0x16c
	.4byte	0x534
	.byte	0x5
	.byte	0x3
	.4byte	_uxTopReadyPriority
	.uleb128 0x31
	.asciz	"xSchedulerRunning"
	.byte	0x1
	.2byte	0x16d
	.4byte	0x1e72
	.byte	0x5
	.byte	0x3
	.4byte	_xSchedulerRunning
	.uleb128 0x12
	.4byte	0x3a3
	.uleb128 0x31
	.asciz	"xPendedTicks"
	.byte	0x1
	.2byte	0x16e
	.4byte	0x1e2c
	.byte	0x5
	.byte	0x3
	.4byte	_xPendedTicks
	.uleb128 0x31
	.asciz	"xYieldPending"
	.byte	0x1
	.2byte	0x16f
	.4byte	0x1e72
	.byte	0x5
	.byte	0x3
	.4byte	_xYieldPending
	.uleb128 0x31
	.asciz	"xNumOfOverflows"
	.byte	0x1
	.2byte	0x170
	.4byte	0x1e72
	.byte	0x5
	.byte	0x3
	.4byte	_xNumOfOverflows
	.uleb128 0x31
	.asciz	"uxTaskNumber"
	.byte	0x1
	.2byte	0x171
	.4byte	0x3c2
	.byte	0x5
	.byte	0x3
	.4byte	_uxTaskNumber
	.uleb128 0x31
	.asciz	"xNextTaskUnblockTime"
	.byte	0x1
	.2byte	0x172
	.4byte	0x1e2c
	.byte	0x5
	.byte	0x3
	.4byte	_xNextTaskUnblockTime
	.uleb128 0x31
	.asciz	"xIdleTaskHandle"
	.byte	0x1
	.2byte	0x173
	.4byte	0x54d
	.byte	0x5
	.byte	0x3
	.4byte	_xIdleTaskHandle
	.uleb128 0x39
	.4byte	.LASF32
	.byte	0x1
	.2byte	0x178
	.4byte	0x1f36
	.byte	0x1
	.byte	0x1
	.uleb128 0x17
	.4byte	0x534
	.uleb128 0x31
	.asciz	"uxSchedulerSuspended"
	.byte	0x1
	.2byte	0x182
	.4byte	0x534
	.byte	0x5
	.byte	0x3
	.4byte	_uxSchedulerSuspended
	.uleb128 0x38
	.asciz	"SRbits"
	.byte	0x3
	.byte	0xa0
	.4byte	0x1cd8
	.byte	0x1
	.byte	0x1
	.uleb128 0x3a
	.4byte	.LASF31
	.byte	0x1
	.2byte	0x149
	.4byte	0x1ceb
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxCurrentTCB
	.uleb128 0x3a
	.4byte	.LASF32
	.byte	0x1
	.2byte	0x178
	.4byte	0x1f36
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxTopUsedPriority
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
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
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
	.uleb128 0x38
	.uleb128 0xa
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
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0x4
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
	.uleb128 0x16
	.uleb128 0x28
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0x16
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
	.uleb128 0x2e
	.byte	0x0
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x1a
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
	.uleb128 0x1b
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
	.uleb128 0x1c
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x1d
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
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x0
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
	.uleb128 0x20
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
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
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x22
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
	.uleb128 0x23
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
	.uleb128 0x24
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
	.uleb128 0x25
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
	.uleb128 0x26
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x0
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
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x28
	.uleb128 0xb
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x29
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
	.uleb128 0x2a
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
	.uleb128 0x2b
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x2c
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x2d
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x2e
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
	.uleb128 0x2f
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
	.uleb128 0x30
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
	.uleb128 0x31
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
	.uleb128 0x32
	.uleb128 0x2e
	.byte	0x0
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x33
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x34
	.uleb128 0x2e
	.byte	0x0
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
	.byte	0x0
	.byte	0x0
	.uleb128 0x35
	.uleb128 0x1d
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x36
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
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
	.uleb128 0x37
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x38
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
	.uleb128 0x39
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x3a
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
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,info
	.4byte	0x3a3
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x1f95
	.4byte	0xb24
	.asciz	"xTaskCreate"
	.4byte	0xc5d
	.asciz	"vTaskPrioritySet"
	.4byte	0xd1b
	.asciz	"vTaskResume"
	.4byte	0xd9e
	.asciz	"xTaskResumeFromISR"
	.4byte	0xe41
	.asciz	"vTaskStartScheduler"
	.4byte	0xe78
	.asciz	"vTaskEndScheduler"
	.4byte	0xe9a
	.asciz	"vTaskSuspendAll"
	.4byte	0xea9
	.asciz	"xTaskGetTickCount"
	.4byte	0xee5
	.asciz	"xTaskGetTickCountFromISR"
	.4byte	0xf31
	.asciz	"uxTaskGetNumberOfTasks"
	.4byte	0xf5c
	.asciz	"pcTaskGetName"
	.4byte	0xfae
	.asciz	"xTaskIncrementTick"
	.4byte	0x10ad
	.asciz	"xTaskResumeAll"
	.4byte	0x1174
	.asciz	"xTaskCatchUpTicks"
	.4byte	0x11df
	.asciz	"vTaskDelay"
	.4byte	0x1232
	.asciz	"xTaskDelayUntil"
	.4byte	0x12f4
	.asciz	"vTaskSwitchContext"
	.4byte	0x135c
	.asciz	"vTaskSuspend"
	.4byte	0x13ca
	.asciz	"vTaskPlaceOnEventList"
	.4byte	0x1411
	.asciz	"vTaskPlaceOnUnorderedEventList"
	.4byte	0x1487
	.asciz	"xTaskRemoveFromEventList"
	.4byte	0x155f
	.asciz	"vTaskRemoveFromUnorderedEventList"
	.4byte	0x161c
	.asciz	"vTaskSetTimeOutState"
	.4byte	0x1654
	.asciz	"vTaskInternalSetTimeOutState"
	.4byte	0x166f
	.asciz	"xTaskCheckForTimeOut"
	.4byte	0x1713
	.asciz	"vTaskMissedYield"
	.4byte	0x1734
	.asciz	"xTaskGetCurrentTaskHandle"
	.4byte	0x1775
	.asciz	"uxTaskResetEventItemValue"
	.4byte	0x17bb
	.asciz	"ulTaskGenericNotifyTake"
	.4byte	0x1837
	.asciz	"xTaskGenericNotifyWait"
	.4byte	0x18fd
	.asciz	"xTaskGenericNotify"
	.4byte	0x19d8
	.asciz	"xTaskGenericNotifyFromISR"
	.4byte	0x1af6
	.asciz	"vTaskGenericNotifyGiveFromISR"
	.4byte	0x1bc9
	.asciz	"xTaskGenericNotifyStateClear"
	.4byte	0x1c37
	.asciz	"ulTaskGenericNotifyValueClear"
	.4byte	0x1f6e
	.asciz	"pxCurrentTCB"
	.4byte	0x1f81
	.asciz	"uxTopUsedPriority"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x195
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x1f95
	.4byte	0x142
	.asciz	"size_t"
	.4byte	0x193
	.asciz	"uint8_t"
	.4byte	0x1b3
	.asciz	"uint16_t"
	.4byte	0x1c3
	.asciz	"uint32_t"
	.4byte	0x33d
	.asciz	"tagSRBITS"
	.4byte	0x358
	.asciz	"SRBITS"
	.4byte	0x366
	.asciz	"TaskFunction_t"
	.4byte	0x390
	.asciz	"StackType_t"
	.4byte	0x3a3
	.asciz	"BaseType_t"
	.4byte	0x3c2
	.asciz	"UBaseType_t"
	.4byte	0x3d5
	.asciz	"TickType_t"
	.4byte	0x407
	.asciz	"xLIST_ITEM"
	.4byte	0x4c6
	.asciz	"ListItem_t"
	.4byte	0x4d8
	.asciz	"xMINI_LIST_ITEM"
	.4byte	0x51e
	.asciz	"MiniListItem_t"
	.4byte	0x476
	.asciz	"xLIST"
	.4byte	0x53f
	.asciz	"List_t"
	.4byte	0x54d
	.asciz	"TaskHandle_t"
	.4byte	0x6ad
	.asciz	"eNotifyAction"
	.4byte	0x6c2
	.asciz	"xTIME_OUT"
	.4byte	0x708
	.asciz	"TimeOut_t"
	.4byte	0x719
	.asciz	"xMEMORY_REGION"
	.4byte	0x77a
	.asciz	"MemoryRegion_t"
	.4byte	0x567
	.asciz	"tskTaskControlBlock"
	.4byte	0x7ce
	.asciz	"tskTCB"
	.4byte	0x7dd
	.asciz	"TCB_t"
	.4byte	0x0
	.section	.debug_aranges,info
	.4byte	0x13c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
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
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
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
	.4byte	.LFB26
	.4byte	.LFE26-.LFB26
	.4byte	.LFB27
	.4byte	.LFE27-.LFB27
	.4byte	.LFB28
	.4byte	.LFE28-.LFB28
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.4byte	.LFB38
	.4byte	.LFE38-.LFB38
	.4byte	.LFB39
	.4byte	.LFE39-.LFB39
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF9:
	.asciz	"xTask"
.LASF15:
	.asciz	"xConstTickCount"
.LASF2:
	.asciz	"pxIndex"
.LASF29:
	.asciz	"pxHigherPriorityTaskWoken"
.LASF0:
	.asciz	"xItemValue"
.LASF20:
	.asciz	"xAlreadyYielded"
.LASF28:
	.asciz	"ucOriginalNotifyState"
.LASF13:
	.asciz	"xTicksToWait"
.LASF25:
	.asciz	"xTaskToNotify"
.LASF27:
	.asciz	"pulPreviousNotificationValue"
.LASF1:
	.asciz	"pxPrevious"
.LASF11:
	.asciz	"pxTCB"
.LASF16:
	.asciz	"xYieldRequired"
.LASF7:
	.asciz	"pxCreatedTask"
.LASF8:
	.asciz	"pxNewTCB"
.LASF12:
	.asciz	"pxTimeOut"
.LASF26:
	.asciz	"uxIndexToNotify"
.LASF10:
	.asciz	"xReturn"
.LASF32:
	.asciz	"uxTopUsedPriority"
.LASF17:
	.asciz	"xTaskToResume"
.LASF4:
	.asciz	"uxPriority"
.LASF23:
	.asciz	"uxIndexToWait"
.LASF21:
	.asciz	"pxEventList"
.LASF5:
	.asciz	"pxTaskCode"
.LASF24:
	.asciz	"ulReturn"
.LASF14:
	.asciz	"xTimeToWake"
.LASF6:
	.asciz	"pvParameters"
.LASF31:
	.asciz	"pxCurrentTCB"
.LASF3:
	.asciz	"pxTopOfStack"
.LASF18:
	.asciz	"uxSavedInterruptStatus"
.LASF22:
	.asciz	"pxUnblockedTCB"
.LASF19:
	.asciz	"pxList"
.LASF30:
	.asciz	"uxIndexToClear"
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
