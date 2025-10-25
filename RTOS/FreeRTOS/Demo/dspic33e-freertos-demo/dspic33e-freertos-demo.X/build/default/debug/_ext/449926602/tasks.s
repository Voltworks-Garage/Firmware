	.file "C:\\Users\\zachl\\Downloads\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo-main\\pic24-dspic33-freertos-demo\\Demo\\dspic33e-freertos-demo\\dspic33e-freertos-demo.X\\..\\..\\..\\Source\\tasks.c"
	.section	.debug_abbrev,info
.Ldebug_abbrev0:
	.section	.debug_info,info
.Ldebug_info0:
	.section	.debug_line,info
.Ldebug_line0:
	.section	.text,code
.Ltext0:
	.section	.text.prvIdleTask,code
	.align	2
	.global	_prvIdleTask	; export
	.type	_prvIdleTask,@function
_prvIdleTask:
.LFB29:
	.file 1 "../../../Source/tasks.c"
	.loc 1 3428 0
	.set ___PA___,0
	mov	w8,[w15++]
.LCFI0:
	.loc 1 3467 0
	mov	#_pxReadyTasksLists,w8
.L3:
	mov	#1,w0
	subr	w0,[w8],[w15]
	.set ___BP___,27
	bra	leu,.L2
	.loc 1 3469 0
; 3469 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L2:
.LBB2:
	.loc 1 3487 0
	rcall	_vApplicationIdleHook
.LBE2:
	.loc 1 3540 0
	bra	.L3
.LFE29:
	.size	_prvIdleTask, .-_prvIdleTask
	.section	.text.prvInitialiseNewTask,code
	.align	2
	.global	_prvInitialiseNewTask	; export
	.type	_prvInitialiseNewTask,@function
_prvInitialiseNewTask:
.LFB1:
	.loc 1 824 0
	.set ___PA___,1
	lnk	#0
.LCFI1:
	mov.d	w8,[w15++]
.LCFI2:
	mov.d	w10,[w15++]
.LCFI3:
	mov.d	w12,[w15++]
.LCFI4:
	mov	w0,w13
	mov	w4,w12
	mov	w6,w11
	mov	w7,w8
	.loc 1 873 0
	mov	[w8+24],w10
	.loc 1 880 0
	sl	w2,w2
	dec2	w2,w2
	add	w10,w2,w2
	mov	w2,[w8+30]
	.loc 1 885 0
	cp0	w1
	.set ___BP___,15
	bra	z,.L5
	.loc 1 889 0
	mov.b	[w1],w0
	mov.b	w0,[w8+26]
	.loc 1 894 0
	cp0.b	[w1]
	.set ___BP___,4
	bra	z,.L6
	.loc 1 816 0
	add	w8,#26,w2
	.loc 1 887 0
	mov	#1,w0
.L7:
	.loc 1 889 0
	mov.b	[++w1],[++w2]
	.loc 1 894 0
	cp0.b	[w1]
	.set ___BP___,4
	bra	z,.L6
	.loc 1 887 0
	inc	w0,w0
	sub	w0,#4,[w15]
	.set ___BP___,71
	bra	nz,.L7
.L6:
	.loc 1 906 0
	clr.b	w0
	mov.b	w0,[w8+29]
.L5:
	mov	w5,w9
	sub	w9,#3,[w15]
	.set ___BP___,50
	bra	leu,.L8
	mov	#3,w9
.L8:
	.loc 1 925 0
	mov	w9,[w8+22]
	.loc 1 932 0
	inc2	w8,w0
	rcall	_vListInitialiseItem
	.loc 1 933 0
	add	w8,#12,w0
	rcall	_vListInitialiseItem
	.loc 1 937 0
	mov	w8,[w8+8]
	.loc 1 940 0
	subr	w9,#4,w9
	mov	w9,[w8+12]
	.loc 1 941 0
	mov	w8,[w8+18]
	.loc 1 1007 0
	mov	w12,w2
	mov	w13,w1
	mov	w10,w0
	rcall	_pxPortInitialiseStack
	mov	w0,[w8]
	.loc 1 1013 0
	cp0	w11
	.set ___BP___,10
	bra	z,.L4
	.loc 1 1017 0
	mov	w8,[w11]
.L4:
	.loc 1 1023 0
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	.set ___PA___,0
.LFE1:
	.size	_prvInitialiseNewTask, .-_prvInitialiseNewTask
	.section	.text.vTaskPrioritySet,code
	.align	2
	.global	_vTaskPrioritySet	; export
	.type	_vTaskPrioritySet,@function
_vTaskPrioritySet:
.LFB5:
	.loc 1 1509 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI5:
	mov	w10,[w15++]
.LCFI6:
	mov.d	w0,w8
	.loc 1 1512 0
	sub	w9,#3,[w15]
	.set ___BP___,50
	bra	leu,.L12
	mov	#3,w9
.L12:
	.loc 1 1526 0
	rcall	_vPortEnterCritical
	.loc 1 1530 0
	cp0	w8
	.set ___BP___,85
	bra	nz,.L13
	mov	_pxCurrentTCB,w8
.L13:
	.loc 1 1540 0
	mov	[w8+22],w0
	.loc 1 1544 0
	sub	w0,w9,[w15]
	.set ___BP___,19
	bra	z,.L14
	.loc 1 1548 0
	.set ___BP___,50
	bra	geu,.L15
	.loc 1 1512 0
	clr	w10
	.loc 1 1550 0
	mov	_pxCurrentTCB,w1
	sub	w1,w8,[w15]
	.set ___BP___,15
	bra	z,.L16
	.loc 1 1555 0
	mov	_pxCurrentTCB,w1
	.loc 1 1557 0
	mov	#1,w10
	mov	[w1+22],w1
	sub	w1,w9,[w15]
	.set ___BP___,50
	bra	leu,.L16
	clr	w10
	bra	.L16
.L15:
	mov	_pxCurrentTCB,w2
	xor	w2,w8,w10
	btsc	w10,#15
	neg	w10,w10
	dec	w10,w10
	lsr	w10,#15,w10
.L16:
	.loc 1 1608 0
	mov	w9,[w8+22]
	.loc 1 1614 0
	mov	[w8+12],w1
	cp0	w1
	.set ___BP___,27
	bra	lt,.L18
	.loc 1 1616 0
	subr	w9,#4,w9
	mov	w9,[w8+12]
.L18:
	.loc 1 1627 0
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w1
	add	w0,w1,w0
	mov	[w8+10],w1
	sub	w1,w0,[w15]
	.set ___BP___,93
	bra	nz,.L19
	.loc 1 1632 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 1644 0
	mov	[w8+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L20
	mov	w0,_uxTopReadyPriority
.L20:
.LBB3:
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w1
	add	w1,w0,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w2
	mov	w2,[w8+6]
	mov	[w0+4],w2
	mov	w9,[w2+2]
	mov	w9,[w0+4]
	mov	[w8+22],w0
	mulw.su	w0,#10,w0
	add	w0,w1,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
.L19:
.LBE3:
	.loc 1 1651 0
	cp0	w10
	.set ___BP___,39
	bra	z,.L14
	.loc 1 1653 0
; 1653 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L14:
	.loc 1 1665 0
	rcall	_vPortExitCritical
	.loc 1 1666 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE5:
	.size	_vTaskPrioritySet, .-_vTaskPrioritySet
	.section	.text.prvTaskIsTaskSuspended,code
	.align	2
	.global	_prvTaskIsTaskSuspended	; export
	.type	_prvTaskIsTaskSuspended,@function
_prvTaskIsTaskSuspended:
.LFB7:
	.loc 1 1780 0
	.set ___PA___,1
	mov	w0,w1
	.loc 1 1791 0
	mov	[w1+10],w3
	.loc 1 1781 0
	clr	w0
	.loc 1 1791 0
	mov	#_xSuspendedTaskList,w2
	sub	w3,w2,[w15]
	.set ___BP___,78
	bra	nz,.L24
	.loc 1 1794 0
	mov	[w1+20],w1
	mov	#_xPendingReadyList,w2
	sub	w1,w2,[w15]
	.set ___BP___,10
	bra	z,.L24
	.loc 1 1781 0
	btsc	w1,#15
	neg	w1,w1
	dec	w1,w0
	lsr	w0,#15,w0
.L24:
	.loc 1 1818 0
	return	
	.set ___PA___,0
.LFE7:
	.size	_prvTaskIsTaskSuspended, .-_prvTaskIsTaskSuspended
	.section	.text.vTaskResume,code
	.align	2
	.global	_vTaskResume	; export
	.type	_vTaskResume,@function
_vTaskResume:
.LFB8:
	.loc 1 1826 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI7:
	mov	w0,w8
	.loc 1 1834 0
	mov	_pxCurrentTCB,w0
	sub	w0,w8,[w15]
	.set ___BP___,10
	bra	z,.L27
	cp0	w8
	.set ___BP___,21
	bra	z,.L27
	.loc 1 1836 0
	rcall	_vPortEnterCritical
	.loc 1 1838 0
	mov	w8,w0
	rcall	_prvTaskIsTaskSuspended
	cp0	w0
	.set ___BP___,71
	bra	z,.L29
	.loc 1 1844 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 1845 0
	mov	[w8+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L30
	mov	w0,_uxTopReadyPriority
.L30:
.LBB4:
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w1
	add	w1,w0,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w2
	mov	w2,[w8+6]
	mov	[w0+4],w2
	mov	w9,[w2+2]
	mov	w9,[w0+4]
	mov	[w8+22],w0
	mulw.su	w0,#10,w0
	add	w0,w1,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
.LBE4:
	.loc 1 1848 0
	mov	_pxCurrentTCB,w0
	mov	[w8+22],w1
	mov	[w0+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L29
	.loc 1 1853 0
; 1853 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L29:
	.loc 1 1865 0
	rcall	_vPortExitCritical
.L27:
	.loc 1 1871 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
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
.LCFI8:
	mov	w10,[w15++]
.LCFI9:
	mov	w0,w8
	.loc 1 1907 0
	mov	w8,w0
	rcall	_prvTaskIsTaskSuspended
	.loc 1 1881 0
	clr	w9
	.loc 1 1907 0
	cp0	w0
	.set ___BP___,39
	bra	z,.L32
	.loc 1 1912 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,29
	bra	nz,.L33
	.loc 1 1916 0
	mov	_pxCurrentTCB,w0
	mov	[w8+22],w1
	mov	[w0+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L34
	.loc 1 1923 0
	mov	#1,w9
	mov	w9,_xYieldPending
.L34:
	.loc 1 1930 0
	inc2	w8,w10
	mov	w10,w0
	rcall	_uxListRemove
	.loc 1 1931 0
	mov	[w8+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,39
	bra	geu,.L35
	mov	w0,_uxTopReadyPriority
.L35:
.LBB5:
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w1
	add	w1,w0,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w2
	mov	w2,[w8+6]
	mov	[w0+4],w2
	mov	w10,[w2+2]
	mov	w10,[w0+4]
	mov	[w8+22],w0
	mulw.su	w0,#10,w0
	add	w0,w1,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
	bra	.L32
.L33:
.LBE5:
	.loc 1 1938 0
	add	w8,#12,w1
	mov	#_xPendingReadyList,w0
	rcall	_vListInsertEnd
	.loc 1 1881 0
	clr	w9
.L32:
	.loc 1 1949 0
	mov	w9,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE9:
	.size	_xTaskResumeFromISR, .-_xTaskResumeFromISR
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
	rcall	_vPortEndScheduler
	.loc 1 2087 0
	return	
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
	.set ___BP___,78
	bra	nz,.L44
	mov	_pxCurrentTCB,w0
.L44:
	.loc 1 2348 0
	add	w0,#26,w0
	.loc 1 2349 0
	return	
	.set ___PA___,0
.LFE17:
	.size	_pcTaskGetName, .-_pcTaskGetName
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
	.set ___BP___,61
	bra	z,.L47
	.loc 1 3015 0
	mov	#1,w0
	mov	w0,_xYieldPending
	bra	.L46
.L47:
	.loc 1 3019 0
	clr	_xYieldPending
.LBB6:
	.loc 1 3062 0
	mov	_uxTopReadyPriority,w0
	mulw.su	w0,#10,w2
	mov	#_pxReadyTasksLists,w1
	add	w1,w2,w1
	cp0	[w1]
	.set ___BP___,25
	bra	nz,.L49
	mov	#_pxReadyTasksLists,w3
.L52:
	dec	w0,w0
	mulw.su	w0,#10,w2
	add	w3,w2,w1
	cp0	[w1]
	.set ___BP___,75
	bra	z,.L52
.L49:
.LBB7:
	mulw.su	w0,#10,w2
	mov	#_pxReadyTasksLists,w1
	add	w1,w2,w3
	mov	[w3+2],w3
	mov	[w3+2],w3
	add	w1,w2,w4
	mov	w3,[w4+2]
	add	w2,#4,w2
	add	w2,w1,w1
	sub	w3,w1,[w15]
	.set ___BP___,85
	bra	nz,.L51
	mulw.su	w0,#10,w2
	mov	#_pxReadyTasksLists+2,w1
	add	w2,w1,w1
	mov	[w3+2],w3
	mov	w3,[w1]
.L51:
	mulw.su	w0,#10,w2
	mov	#_pxReadyTasksLists+2,w1
	add	w2,w1,w1
	mov	[w1],w1
	mov	[w1+6],w1
	mov	w1,_pxCurrentTCB
.LBE7:
	mov	w0,_uxTopReadyPriority
.L46:
.LBE6:
	.loc 1 3080 0
	return	
	.set ___PA___,0
.LFE20:
	.size	_vTaskSwitchContext, .-_vTaskSwitchContext
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
.LBB8:
	.loc 1 3189 0
	mov	[w0+20],w1
	mov	[w0+14],w2
	mov	[w0+16],w3
	mov	w3,[w2+4]
	mov	[w0+16],w2
	mov	[w0+14],w4
	mov	w4,[w2+2]
	add	w0,#12,w2
	mov	[w1+2],w3
	sub	w3,w2,[w15]
	.set ___BP___,85
	bra	nz,.L55
	mov	[w0+16],w3
	mov	w3,[w1+2]
.L55:
	clr	w3
	mov	w3,[w0+20]
	dec	[w1],[w1]
.LBE8:
	.loc 1 3191 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L56
.LBB9:
	.loc 1 3193 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w4
	mov	w4,[w2+4]
	mov	[w0+6],w2
	mov	[w0+4],w3
	mov	w3,[w2+2]
	inc2	w0,w2
	mov	[w1+2],w3
	sub	w3,w2,[w15]
	.set ___BP___,85
	bra	nz,.L57
	mov	[w0+6],w4
	mov	w4,[w1+2]
.L57:
	clr	w3
	mov	w3,[w0+10]
	dec	[w1],[w1]
.LBE9:
	.loc 1 3194 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w3
	sub	w3,w1,[w15]
	.set ___BP___,50
	bra	geu,.L58
	mov	w1,_uxTopReadyPriority
.L58:
.LBB10:
	mulw.su	w1,#10,w4
	mov	#_pxReadyTasksLists,w3
	add	w3,w4,w1
	mov	[w1+2],w1
	mov	w1,[w0+4]
	mov	[w1+4],w4
	mov	w4,[w0+6]
	mov	[w1+4],w4
	mov	w2,[w4+2]
	mov	w2,[w1+4]
	mov	[w0+22],w2
	mulw.su	w2,#10,w2
	add	w2,w3,w1
	mov	w1,[w0+10]
	inc	[w1],[w1]
	bra	.L59
.L56:
.LBE10:
.LBB11:
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
	inc	[w1],[w1]
.L59:
.LBE11:
	.loc 1 3217 0
	mov	_pxCurrentTCB,w1
	mov	[w0+22],w2
	mov	[w1+22],w1
	.loc 1 3230 0
	clr	w0
	.loc 1 3217 0
	sub	w2,w1,[w15]
	.set ___BP___,39
	bra	leu,.L60
	.loc 1 3226 0
	mov	#1,w0
	mov	w0,_xYieldPending
.L60:
	.loc 1 3234 0
	return	
	.set ___PA___,0
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
.LBB12:
	.loc 1 3253 0
	mov	[w0+8],w2
	mov	[w0+2],w3
	mov	[w0+4],w4
	mov	w4,[w3+4]
	mov	[w0+4],w3
	mov	[w0+2],w4
	mov	w4,[w3+2]
	mov	[w2+2],w3
	sub	w3,w0,[w15]
	.set ___BP___,85
	bra	nz,.L63
	mov	[w3+4],w3
	mov	w3,[w2+2]
.L63:
	clr	w3
	mov	w3,[w0+8]
	dec	[w2],[w2]
.LBE12:
.LBB13:
	.loc 1 3272 0
	mov	[w1+10],w0
	mov	[w1+4],w2
	mov	[w1+6],w3
	mov	w3,[w2+4]
	mov	[w1+6],w2
	mov	[w1+4],w4
	mov	w4,[w2+2]
	inc2	w1,w2
	mov	[w0+2],w3
	sub	w3,w2,[w15]
	.set ___BP___,85
	bra	nz,.L64
	mov	[w1+6],w3
	mov	w3,[w0+2]
.L64:
	clr	w3
	mov	w3,[w1+10]
	dec	[w0],[w0]
.LBE13:
	.loc 1 3273 0
	mov	[w1+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L65
	mov	w0,_uxTopReadyPriority
.L65:
.LBB14:
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w3
	add	w3,w0,w0
	mov	[w0+2],w0
	mov	w0,[w1+4]
	mov	[w0+4],w4
	mov	w4,[w1+6]
	mov	[w0+4],w4
	mov	w2,[w4+2]
	mov	w2,[w0+4]
	mov	[w1+22],w0
	mulw.su	w0,#10,w0
	add	w0,w3,w0
	mov	w0,[w1+10]
	inc	[w0],[w0]
.LBE14:
	.loc 1 3275 0
	mov	_pxCurrentTCB,w0
	mov	[w1+22],w1
	mov	[w0+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L62
	.loc 1 3281 0
	mov	#1,w0
	mov	w0,_xYieldPending
.L62:
	.loc 1 3283 0
	return	
	.set ___PA___,0
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
.LCFI10:
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
.LCFI11:
	mov	w10,[w15++]
.LCFI12:
	mov	w0,w9
	mov	w1,w10
	.loc 1 3314 0
	rcall	_vPortEnterCritical
.LBB15:
	.loc 1 3317 0
	mov	_xTickCount,w2
	.loc 1 3318 0
	mov	[w9+2],w1
	.loc 1 3332 0
	mov	[w10],w0
	.loc 1 3337 0
	clr	w8
	.loc 1 3332 0
	add	w0,#1,[w15]
	.set ___BP___,19
	bra	z,.L70
	.loc 1 3342 0
	mov	[w9],w3
	mov	_xNumOfOverflows,w4
	sub	w4,w3,[w15]
	.set ___BP___,28
	bra	z,.L71
	sub	w2,w1,[w15]
	.set ___BP___,61
	bra	ltu,.L71
	.loc 1 3350 0
	clr	[w10]
	.loc 1 3349 0
	mov	#1,w8
	.loc 1 3350 0
	bra	.L70
.L71:
	.loc 1 3318 0
	sub	w2,w1,w1
	.loc 1 3352 0
	sub	w1,w0,[w15]
	.set ___BP___,79
	bra	geu,.L72
	.loc 1 3355 0
	sub	w0,w1,[w10]
	.loc 1 3356 0
	mov	w9,w0
	rcall	_vTaskInternalSetTimeOutState
	.loc 1 3357 0
	clr	w8
	bra	.L70
.L72:
	.loc 1 3361 0
	clr	[w10]
	.loc 1 3362 0
	mov	#1,w8
.L70:
.LBE15:
	.loc 1 3365 0
	rcall	_vPortExitCritical
	.loc 1 3368 0
	mov	w8,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
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
	.section	.text.prvInitialiseTaskLists,code
	.align	2
	.global	_prvInitialiseTaskLists	; export
	.type	_prvInitialiseTaskLists,@function
_prvInitialiseTaskLists:
.LFB30:
	.loc 1 3658 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI13:
	.loc 1 3661 0
	clr	w8
	.loc 1 3663 0
	mov	#_pxReadyTasksLists,w9
.L76:
	mulw.su	w8,#10,w0
	add	w0,w9,w0
	rcall	_vListInitialise
	.loc 1 3661 0
	inc	w8,w8
	sub	w8,#4,[w15]
	.set ___BP___,80
	bra	nz,.L76
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
	.loc 1 3686 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE30:
	.size	_prvInitialiseTaskLists, .-_prvInitialiseTaskLists
	.section	.text.prvAddNewTaskToReadyList,code
	.align	2
	.global	_prvAddNewTaskToReadyList	; export
	.type	_prvAddNewTaskToReadyList,@function
_prvAddNewTaskToReadyList:
.LFB2:
	.loc 1 1027 0
	.set ___PA___,0
	mov	w8,[w15++]
.LCFI14:
	mov	w0,w8
	.loc 1 1030 0
	rcall	_vPortEnterCritical
	.loc 1 1032 0
	inc	_uxCurrentNumberOfTasks
	.loc 1 1034 0
	cp0	_pxCurrentTCB
	.set ___BP___,85
	bra	nz,.L79
	.loc 1 1038 0
	mov	w8,_pxCurrentTCB
	.loc 1 1040 0
	mov	_uxCurrentNumberOfTasks,w0
	sub	w0,#1,[w15]
	.set ___BP___,86
	bra	nz,.L80
	.loc 1 1045 0
	rcall	_prvInitialiseTaskLists
	bra	.L80
.L79:
	.loc 1 1057 0
	cp0	_xSchedulerRunning
	.set ___BP___,50
	bra	nz,.L80
	.loc 1 1059 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w1
	mov	[w8+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	gtu,.L80
	.loc 1 1061 0
	mov	w8,_pxCurrentTCB
.L80:
	.loc 1 1074 0
	inc	_uxTaskNumber
	.loc 1 1084 0
	mov	[w8+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L81
	mov	w0,_uxTopReadyPriority
.L81:
.LBB16:
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w1
	add	w1,w0,w0
	mov	[w0+2],w0
	mov	w0,[w8+4]
	mov	[w0+4],w2
	mov	w2,[w8+6]
	inc2	w8,w2
	mov	[w0+4],w3
	mov	w2,[w3+2]
	mov	w2,[w0+4]
	mov	[w8+22],w0
	mulw.su	w0,#10,w0
	add	w0,w1,w0
	mov	w0,[w8+10]
	inc	[w0],[w0]
.LBE16:
	.loc 1 1088 0
	rcall	_vPortExitCritical
	.loc 1 1090 0
	cp0	_xSchedulerRunning
	.set ___BP___,39
	bra	z,.L78
	.loc 1 1094 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w1
	mov	[w8+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	geu,.L78
	.loc 1 1096 0
; 1096 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L78:
	.loc 1 1107 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
.LFE2:
	.size	_prvAddNewTaskToReadyList, .-_prvAddNewTaskToReadyList
	.section	.text.xTaskCreate,code
	.align	2
	.global	_xTaskCreate	; export
	.type	_xTaskCreate,@function
_xTaskCreate:
.LFB0:
	.loc 1 727 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI15:
	mov.d	w10,[w15++]
.LCFI16:
	mov.d	w12,[w15++]
.LCFI17:
	mov	w14,[w15++]
.LCFI18:
	mov	w0,w14
	mov	w1,w13
	mov	w2,w9
	mov	w3,w12
	mov	w4,w11
	mov	w5,w10
	.loc 1 739 0
	mov	#38,w0
	rcall	_pvPortMalloc
	mov	w0,w8
	.loc 1 807 0
	setm	w0
	.loc 1 741 0
	cp0	w8
	.set ___BP___,30
	bra	z,.L84
	.loc 1 743 0
	
	repeat	#19-1
	clr	[w8++]
	
	sub	#38, w8
	.loc 1 748 0
	add	w9,w9,w0
	rcall	_pvPortMalloc
	mov	w0,[w8+24]
	.loc 1 750 0
	cp0	w0
	.set ___BP___,93
	bra	nz,.L85
	.loc 1 753 0
	mov	w8,w0
	rcall	_vPortFree
	.loc 1 807 0
	setm	w0
.L84:
	.loc 1 811 0
	mov	[--w15],w14
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L85:
	.loc 1 801 0
	mul.uu	w9,#1,w2
	clr	[w15++]
.LCFI19:
	mov	w8,w7
	mov	w10,w6
	mov	w11,w5
	mov	w12,w4
	mov	w13,w1
	mov	w14,w0
.LCFI20:
	rcall	_prvInitialiseNewTask
	.loc 1 802 0
	mov	w8,w0
	rcall	_prvAddNewTaskToReadyList
	dec2	w15,w15
.LCFI21:
	.loc 1 803 0
	mov	#1,w0
	bra	.L84
.LFE0:
	.size	_xTaskCreate, .-_xTaskCreate
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
	.set ___BP___,80
	bra	nz,.L88
	.loc 1 2026 0
	mov	#-225,w0
	and	_SRbits,WREG
	bset	w0,#5
	mov	w0,_SRbits
	nop	
; 2026 "../../../Source/tasks.c" 1
	NOP
	.loc 1 2036 0
	setm	_xNextTaskUnblockTime
	.loc 1 2037 0
	mov	#1,w0
	mov	w0,_xSchedulerRunning
	.loc 1 2038 0
	clr	_xTickCount
	.loc 1 2052 0
	rcall	_xPortStartScheduler
.L88:
	.loc 1 2075 0
	mov	_uxTopUsedPriority,w0
	.loc 1 2076 0
	return	
	.set ___PA___,0
.LFE10:
	.size	_vTaskStartScheduler, .-_vTaskStartScheduler
	.section	.text.prvCheckTasksWaitingTermination,code
	.align	2
	.global	_prvCheckTasksWaitingTermination	; export
	.type	_prvCheckTasksWaitingTermination,@function
_prvCheckTasksWaitingTermination:
.LFB31:
	.loc 1 3690 0
	.set ___PA___,1
	.loc 1 3714 0
	return	
	.set ___PA___,0
.LFE31:
	.size	_prvCheckTasksWaitingTermination, .-_prvCheckTasksWaitingTermination
	.section	.text.prvResetNextTaskUnblockTime,code
	.align	2
	.global	_prvResetNextTaskUnblockTime	; export
	.type	_prvResetNextTaskUnblockTime,@function
_prvResetNextTaskUnblockTime:
.LFB32:
	.loc 1 4000 0
	.set ___PA___,1
	.loc 1 4001 0
	mov	_pxDelayedTaskList,w0
	cp0	[w0]
	.set ___BP___,61
	bra	nz,.L91
	.loc 1 4007 0
	setm	_xNextTaskUnblockTime
	bra	.L90
.L91:
	.loc 1 4015 0
	mov	_pxDelayedTaskList,w0
	mov	[w0+6],w0
	mov	[w0],w0
	mov	w0,_xNextTaskUnblockTime
.L90:
	.loc 1 4017 0
	return	
	.set ___PA___,0
.LFE32:
	.size	_prvResetNextTaskUnblockTime, .-_prvResetNextTaskUnblockTime
	.section	.text.xTaskIncrementTick,code
	.align	2
	.global	_xTaskIncrementTick	; export
	.type	_xTaskIncrementTick,@function
_xTaskIncrementTick:
.LFB19:
	.loc 1 2721 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI22:
	.loc 1 2731 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L94
.LBB17:
	.loc 1 2735 0
	mov	_xTickCount,w8
	inc	w8,w8
	.loc 1 2739 0
	mov	w8,_xTickCount
	.loc 1 2741 0
	.set ___BP___,71
	bra	nz,.L95
.LBB23:
	.loc 1 2743 0
	mov	_pxDelayedTaskList,w0
	mov	_pxOverflowDelayedTaskList,w1
	mov	w1,_pxDelayedTaskList
	mov	w0,_pxOverflowDelayedTaskList
	inc	_xNumOfOverflows
	rcall	_prvResetNextTaskUnblockTime
.L95:
.LBE23:
	.loc 1 2754 0
	clr	w6
	mov	_xNextTaskUnblockTime,w3
	sub	w3,w8,[w15]
	.set ___BP___,50
	bra	leu,.L113
	bra	.L97
.L109:
	.loc 1 2824 0
	mov	w7,w6
	bra	.L114
.L113:
.LBB22:
	.loc 1 2793 0
	clr	w5
.LBE22:
.LBB21:
	.loc 1 2808 0
	mov	#_pxReadyTasksLists,w4
.LBE21:
	.loc 1 2824 0
	mov	#1,w7
.L114:
	.loc 1 2758 0
	mov	_pxDelayedTaskList,w1
	cp0	[w1]
	.set ___BP___,95
	bra	nz,.L98
	.loc 1 2765 0
	setm	_xNextTaskUnblockTime
	.loc 1 2766 0
	bra	.L97
.L98:
	.loc 1 2774 0
	mov	_pxDelayedTaskList,w0
	mov	[w0+6],w1
	mov	[w1+6],w1
	.loc 1 2775 0
	mov	[w1+2],w2
	.loc 1 2777 0
	sub	w8,w2,[w15]
	.set ___BP___,95
	bra	geu,.L99
	.loc 1 2784 0
	mov	w2,_xNextTaskUnblockTime
	.loc 1 2785 0
	bra	.L97
.L99:
.LBB20:
	.loc 1 2793 0
	mov	[w1+10],w2
	mov	[w1+4],w0
	mov	[w1+6],w9
	mov	w9,[w0+4]
	mov	[w1+6],w0
	mov	[w1+4],w3
	mov	w3,[w0+2]
	inc2	w1,w3
	mov	[w2+2],w0
	sub	w0,w3,[w15]
	.set ___BP___,85
	bra	nz,.L100
	mov	[w1+6],w9
	mov	w9,[w2+2]
.L100:
	mov	w5,[w1+10]
	dec	[w2],[w2]
.LBE20:
	.loc 1 2797 0
	mov	[w1+20],w2
	cp0	w2
	.set ___BP___,15
	bra	z,.L101
.LBB19:
	.loc 1 2799 0
	mov	[w1+14],w0
	mov	[w1+16],w9
	mov	w9,[w0+4]
	mov	[w1+16],w0
	mov	[w1+14],w9
	mov	w9,[w0+2]
	add	w1,#12,w0
	mov	[w2+2],w9
	sub	w9,w0,[w15]
	.set ___BP___,85
	bra	nz,.L102
	mov	[w1+16],w0
	mov	w0,[w2+2]
.L102:
	mov	w5,[w1+20]
	dec	[w2],[w2]
.L101:
.LBE19:
	.loc 1 2808 0
	mov	[w1+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L103
	mov	w0,_uxTopReadyPriority
.L103:
.LBB18:
	mulw.su	w0,#10,w0
	add	w4,w0,w0
	mov	[w0+2],w2
	mov	w2,[w1+4]
	mov	[w2+4],w9
	mov	w9,[w1+6]
	mov	[w2+4],w0
	mov	w3,[w0+2]
	mov	w3,[w2+4]
	mov	[w1+22],w2
	mulw.su	w2,#10,w2
	add	w2,w4,w2
	mov	w2,[w1+10]
	inc	[w2],[w2]
.LBE18:
	.loc 1 2822 0
	mov	_pxCurrentTCB,w0
	mov	[w1+22],w1
	mov	[w0+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	gtu,.L109
	bra	.L114
.L97:
	.loc 1 2841 0
	mov	_pxCurrentTCB,w0
	mov	[w0+22],w0
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w1
	add	w1,w0,w0
	mov	#1,w1
	subr	w1,[w0],[w15]
	.set ___BP___,27
	bra	leu,.L106
	.loc 1 2843 0
	mov	w1,w6
.L106:
	.loc 1 2869 0
	cp0	_xYieldPending
	.set ___BP___,50
	bra	nz,.L111
	bra	.L107
.L94:
.LBE17:
	.loc 1 2882 0
	inc	_xPendedTicks
	.loc 1 2724 0
	clr	w6
	bra	.L107
.L111:
.LBB24:
	.loc 1 2871 0
	mov	#1,w6
.L107:
.LBE24:
	.loc 1 2894 0
	mov	w6,w0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
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
.LCFI23:
	.loc 1 2188 0
	rcall	_vPortEnterCritical
	.loc 1 2190 0
	dec	_uxSchedulerSuspended
	.loc 1 2177 0
	clr	w8
	.loc 1 2192 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,39
	bra	nz,.L116
	.loc 1 2194 0
	mov	w8,w0
	cp0	_uxCurrentNumberOfTasks
	.set ___BP___,61
	bra	nz,.L131
	.loc 1 2177 0
	mov	w0,w8
	bra	.L116
.L122:
	.loc 1 2200 0
	mov	_xPendingReadyList+6,w0
	mov	[w0+6],w0
.LBB25:
	.loc 1 2201 0
	mov	[w0+20],w1
	mov	[w0+14],w2
	mov	[w0+16],w7
	mov	w7,[w2+4]
	mov	[w0+16],w2
	mov	[w0+14],w7
	mov	w7,[w2+2]
	add	w0,#12,w2
	mov	[w1+2],w7
	sub	w7,w2,[w15]
	.set ___BP___,85
	bra	nz,.L118
	mov	[w0+16],w2
	mov	w2,[w1+2]
.L118:
	mov	w4,[w0+20]
	dec	[w1],[w1]
.LBE25:
.LBB26:
	.loc 1 2203 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w7
	mov	w7,[w2+4]
	mov	[w0+6],w2
	mov	[w0+4],w7
	mov	w7,[w2+2]
	inc2	w0,w2
	mov	[w1+2],w7
	sub	w7,w2,[w15]
	.set ___BP___,85
	bra	nz,.L119
	mov	[w0+6],w7
	mov	w7,[w1+2]
.L119:
	mov	w4,[w0+10]
	dec	[w1],[w1]
.LBE26:
	.loc 1 2204 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w7
	sub	w7,w1,[w15]
	.set ___BP___,50
	bra	geu,.L120
	mov	w1,_uxTopReadyPriority
.L120:
.LBB27:
	mulw.su	w1,#10,w8
	add	w3,w8,w1
	mov	[w1+2],w1
	mov	w1,[w0+4]
	mov	[w1+4],w7
	mov	w7,[w0+6]
	mov	[w1+4],w7
	mov	w2,[w7+2]
	mov	w2,[w1+4]
	mov	[w0+22],w2
	mulw.su	w2,#10,w2
	add	w2,w3,w1
	mov	w1,[w0+10]
	inc	[w1],[w1]
.LBE27:
	.loc 1 2208 0
	mov	_pxCurrentTCB,w1
	mov	[w0+22],w2
	mov	[w1+22],w1
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	ltu,.L135
	.loc 1 2210 0
	mov	w6,_xYieldPending
	bra	.L135
.L131:
	.loc 1 2198 0
	mov	#_xPendingReadyList,w5
.LBB28:
	.loc 1 2201 0
	clr	w4
.LBE28:
.LBB29:
	.loc 1 2204 0
	mov	#_pxReadyTasksLists,w3
.LBE29:
	.loc 1 2210 0
	mov	#1,w6
.L135:
	.loc 1 2198 0
	cp0	[w5]
	.set ___BP___,91
	bra	nz,.L122
	.loc 1 2218 0
	cp0	w0
	.set ___BP___,30
	bra	z,.L123
	.loc 1 2226 0
	rcall	_prvResetNextTaskUnblockTime
.L123:
.LBB30:
	.loc 1 2234 0
	mov	_xPendedTicks,w8
	.loc 1 2236 0
	cp0	w8
	.set ___BP___,50
	bra	z,.L124
	.loc 1 2242 0
	mov	#1,w9
.L132:
	.loc 1 2240 0
	rcall	_xTaskIncrementTick
	cp0	w0
	.set ___BP___,50
	bra	z,.L125
	.loc 1 2242 0
	mov	w9,_xYieldPending
.L125:
	.loc 1 2249 0
	dec	w8,w8
	.loc 1 2250 0
	.set ___BP___,86
	bra	nz,.L132
	.loc 1 2252 0
	clr	_xPendedTicks
.L124:
.LBE30:
	.loc 1 2177 0
	clr	w8
	.loc 1 2260 0
	cp0	_xYieldPending
	.set ___BP___,39
	bra	z,.L116
	.loc 1 2267 0
; 2267 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	.loc 1 2264 0
	mov	#1,w8
.L116:
	.loc 1 2280 0
	rcall	_vPortExitCritical
	.loc 1 2283 0
	mov	w8,w0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
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
.LCFI24:
	mov	w0,w8
	.loc 1 2626 0
	rcall	_vTaskSuspendAll
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
	.section	.text.vTaskSuspend,code
	.align	2
	.global	_vTaskSuspend	; export
	.type	_vTaskSuspend,@function
_vTaskSuspend:
.LFB6:
	.loc 1 1674 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI25:
	mov	w0,w8
	.loc 1 1677 0
	rcall	_vPortEnterCritical
	.loc 1 1681 0
	cp0	w8
	.set ___BP___,85
	bra	nz,.L138
	mov	_pxCurrentTCB,w8
.L138:
	.loc 1 1687 0
	inc2	w8,w9
	mov	w9,w0
	rcall	_uxListRemove
	.loc 1 1697 0
	mov	[w8+20],w0
	cp0	w0
	.set ___BP___,30
	bra	z,.L139
	.loc 1 1699 0
	add	w8,#12,w0
	rcall	_uxListRemove
.L139:
	.loc 1 1706 0
	mov	w9,w1
	mov	#_xSuspendedTaskList,w0
	rcall	_vListInsertEnd
.LBB31:
	.loc 1 1714 0
	mov.b	[w8+36],w0
	sub.b	w0,#1,[w15]
	.set ___BP___,72
	bra	nz,.L140
	.loc 1 1718 0
	clr.b	w0
	mov.b	w0,[w8+36]
.L140:
.LBE31:
	.loc 1 1724 0
	rcall	_vPortExitCritical
	.loc 1 1726 0
	cp0	_xSchedulerRunning
	.set ___BP___,71
	bra	z,.L141
	.loc 1 1730 0
	rcall	_vPortEnterCritical
	.loc 1 1732 0
	rcall	_prvResetNextTaskUnblockTime
	.loc 1 1734 0
	rcall	_vPortExitCritical
.L141:
	.loc 1 1741 0
	mov	_pxCurrentTCB,w0
	sub	w0,w8,[w15]
	.set ___BP___,78
	bra	nz,.L137
	.loc 1 1743 0
	cp0	_xSchedulerRunning
	.set ___BP___,61
	bra	z,.L143
	.loc 1 1747 0
; 1747 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
	bra	.L137
.L143:
	.loc 1 1754 0
	mov	_xSuspendedTaskList,w0
	cp	_uxCurrentNumberOfTasks
	.set ___BP___,62
	bra	nz,.L144
	.loc 1 1760 0
	clr	_pxCurrentTCB
	bra	.L137
.L144:
	.loc 1 1764 0
	rcall	_vTaskSwitchContext
.L137:
	.loc 1 1772 0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE6:
	.size	_vTaskSuspend, .-_vTaskSuspend
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
	.section	.text.xTaskGenericNotify,code
	.align	2
	.global	_xTaskGenericNotify	; export
	.type	_xTaskGenericNotify,@function
_xTaskGenericNotify:
.LFB37:
	.loc 1 4854 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI26:
	mov.d	w10,[w15++]
.LCFI27:
	mov.d	w12,[w15++]
.LCFI28:
	mov	w0,w9
	mov	w1,w12
	mov.d	w2,w10
	mov	w4,w8
	mov	w5,w13
	.loc 1 4863 0
	rcall	_vPortEnterCritical
	.loc 1 4865 0
	cp0	w13
	.set ___BP___,15
	bra	z,.L149
	.loc 1 4867 0
	add	w12,#8,w0
	sl	w0,#2,w0
	add	w9,w0,w0
	mov	[w0++],[w13++]
	mov	[w0--],[w13--]
.L149:
	.loc 1 4870 0
	add	w9,w12,w0
	mov.b	[w0+36],w0
	.loc 1 4872 0
	add	w9,w12,w1
	mov.b	#2,w2
	mov.b	w2,[w1+36]
	.loc 1 4874 0
	sub	w8,#2,[w15]
	.set ___BP___,29
	bra	z,.L152
	.set ___BP___,50
	bra	gtu,.L155
	sub	w8,#1,[w15]
	.set ___BP___,71
	bra	nz,.L150
	bra	.L162
.L155:
	sub	w8,#3,[w15]
	.set ___BP___,29
	bra	z,.L153
	sub	w8,#4,[w15]
	.set ___BP___,71
	bra	nz,.L150
	bra	.L163
.L162:
	.loc 1 4877 0
	add	w12,#8,w12
	sl	w12,#2,w12
	add	w9,w12,w12
	ior	w10,[w12],[w12++]
	ior	w11,[w12],[w12--]
	.loc 1 4878 0
	bra	.L150
.L152:
	.loc 1 4881 0
	add	w12,#8,w12
	sl	w12,#2,w12
	add	w9,w12,w12
	mov	#1,w2
	mov	#0,w3
	add	w2,[w12],[w12]
	addc	w3,[++w12],[w12--]
	.loc 1 4882 0
	bra	.L150
.L153:
	.loc 1 4885 0
	add	w12,#8,w12
	sl	w12,#2,w12
	add	w9,w12,w12
	mov.d	w10,[w12]
	.loc 1 4886 0
	bra	.L150
.L163:
	.loc 1 4897 0
	clr	w8
	.loc 1 4890 0
	sub.b	w0,#2,[w15]
	.set ___BP___,28
	bra	z,.L156
	.loc 1 4892 0
	add	w12,#8,w12
	sl	w12,#2,w12
	add	w9,w12,w12
	mov.d	w10,[w12]
.L150:
	.loc 1 4922 0
	mov	#1,w8
	sub.b	w0,#1,[w15]
	.set ___BP___,59
	bra	nz,.L156
.LBB32:
	.loc 1 4924 0
	mov	[w9+10],w0
	mov	[w9+4],w1
	mov	[w9+6],w3
	mov	w3,[w1+4]
	mov	[w9+6],w1
	mov	[w9+4],w2
	mov	w2,[w1+2]
	inc2	w9,w1
	mov	[w0+2],w2
	sub	w2,w1,[w15]
	.set ___BP___,85
	bra	nz,.L157
	mov	[w9+6],w3
	mov	w3,[w0+2]
.L157:
	clr	w2
	mov	w2,[w9+10]
	dec	[w0],[w0]
.LBE32:
	.loc 1 4925 0
	mov	[w9+22],w0
	cp	_uxTopReadyPriority
	.set ___BP___,50
	bra	geu,.L158
	mov	w0,_uxTopReadyPriority
.L158:
.LBB33:
	mulw.su	w0,#10,w0
	mov	#_pxReadyTasksLists,w2
	add	w2,w0,w0
	mov	[w0+2],w0
	mov	w0,[w9+4]
	mov	[w0+4],w3
	mov	w3,[w9+6]
	mov	[w0+4],w3
	mov	w1,[w3+2]
	mov	w1,[w0+4]
	mov	[w9+22],w0
	mulw.su	w0,#10,w0
	add	w0,w2,w0
	mov	w0,[w9+10]
	inc	[w0],[w0]
.LBE33:
	.loc 1 4946 0
	mov	_pxCurrentTCB,w0
	mov	[w9+22],w1
	mov	[w0+22],w0
	mov	#1,w8
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L156
	.loc 1 4950 0
; 4950 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L156:
	.loc 1 4962 0
	rcall	_vPortExitCritical
	.loc 1 4965 0
	mov	w8,w0
	mov.d	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
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
.LCFI29:
	.loc 1 5009 0
	cp0	w5
	.set ___BP___,15
	bra	z,.L165
	.loc 1 5011 0
	add	w1,#8,w7
	sl	w7,#2,w7
	add	w0,w7,w7
	mov	[w7++],[w5++]
	mov	[w7--],[w5--]
.L165:
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
	bra	z,.L168
	.set ___BP___,50
	bra	gtu,.L171
	sub	w4,#1,[w15]
	.set ___BP___,71
	bra	nz,.L166
	bra	.L181
.L171:
	sub	w4,#3,[w15]
	.set ___BP___,29
	bra	z,.L169
	sub	w4,#4,[w15]
	.set ___BP___,71
	bra	nz,.L166
	bra	.L182
.L181:
	.loc 1 5020 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	ior	w2,[w1],[w1++]
	ior	w3,[w1],[w1--]
	.loc 1 5021 0
	bra	.L166
.L168:
	.loc 1 5024 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	mov	#1,w2
	mov	#0,w3
	add	w2,[w1],[w1]
	addc	w3,[++w1],[w1--]
	.loc 1 5025 0
	bra	.L166
.L169:
	.loc 1 5028 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	mov.d	w2,[w1]
	.loc 1 5029 0
	bra	.L166
.L182:
	.loc 1 5040 0
	clr	w4
	.loc 1 5033 0
	sub.b	w5,#2,[w15]
	.set ___BP___,28
	bra	z,.L172
	.loc 1 5035 0
	add	w1,#8,w1
	sl	w1,#2,w1
	add	w0,w1,w1
	mov.d	w2,[w1]
.L166:
	.loc 1 5064 0
	mov	#1,w4
	sub.b	w5,#1,[w15]
	.set ___BP___,59
	bra	nz,.L172
	.loc 1 5069 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L173
.LBB34:
	.loc 1 5071 0
	mov	[w0+10],w1
	mov	[w0+4],w2
	mov	[w0+6],w3
	mov	w3,[w2+4]
	mov	[w0+6],w2
	mov	[w0+4],w4
	mov	w4,[w2+2]
	inc2	w0,w2
	mov	[w1+2],w3
	sub	w3,w2,[w15]
	.set ___BP___,85
	bra	nz,.L174
	mov	[w0+6],w3
	mov	w3,[w1+2]
.L174:
	clr	w3
	mov	w3,[w0+10]
	dec	[w1],[w1]
.LBE34:
	.loc 1 5072 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w4
	sub	w4,w1,[w15]
	.set ___BP___,50
	bra	geu,.L175
	mov	w1,_uxTopReadyPriority
.L175:
.LBB35:
	mulw.su	w1,#10,w4
	mov	#_pxReadyTasksLists,w3
	add	w3,w4,w1
	mov	[w1+2],w1
	mov	w1,[w0+4]
	mov	[w1+4],w4
	mov	w4,[w0+6]
	mov	[w1+4],w4
	mov	w2,[w4+2]
	mov	w2,[w1+4]
	mov	[w0+22],w2
	mulw.su	w2,#10,w2
	add	w2,w3,w1
	mov	w1,[w0+10]
	inc	[w1],[w1]
	bra	.L176
.L173:
.LBE35:
.LBB36:
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
	inc	[w1],[w1]
.L176:
.LBE36:
	.loc 1 5081 0
	mov	_pxCurrentTCB,w2
	mov	[w0+22],w1
	mov	[w2+22],w0
	mov	#1,w4
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L172
	.loc 1 5085 0
	cp0	w6
	.set ___BP___,15
	bra	z,.L177
	.loc 1 5087 0
	mov	w4,w0
	mov	w0,[w6]
.L177:
	.loc 1 5093 0
	mov	#1,w4
	mov	w4,_xYieldPending
.L172:
	.loc 1 5104 0
	mov	w4,w0
	mov	[--w15],w8
	return	
	.set ___PA___,0
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
	.set ___BP___,62
	bra	nz,.L183
	.loc 1 5160 0
	cp0	_uxSchedulerSuspended
	.set ___BP___,50
	bra	nz,.L185
.LBB37:
	.loc 1 5162 0
	mov	[w0+10],w1
	mov	[w0+4],w3
	mov	[w0+6],w5
	mov	w5,[w3+4]
	mov	[w0+6],w3
	mov	[w0+4],w4
	mov	w4,[w3+2]
	inc2	w0,w3
	mov	[w1+2],w4
	sub	w4,w3,[w15]
	.set ___BP___,85
	bra	nz,.L186
	mov	[w0+6],w5
	mov	w5,[w1+2]
.L186:
	clr	w4
	mov	w4,[w0+10]
	dec	[w1],[w1]
.LBE37:
	.loc 1 5163 0
	mov	[w0+22],w1
	mov	_uxTopReadyPriority,w4
	sub	w4,w1,[w15]
	.set ___BP___,50
	bra	geu,.L187
	mov	w1,_uxTopReadyPriority
.L187:
.LBB38:
	mulw.su	w1,#10,w6
	mov	#_pxReadyTasksLists,w4
	add	w4,w6,w1
	mov	[w1+2],w1
	mov	w1,[w0+4]
	mov	[w1+4],w5
	mov	w5,[w0+6]
	mov	[w1+4],w5
	mov	w3,[w5+2]
	mov	w3,[w1+4]
	mov	[w0+22],w6
	mulw.su	w6,#10,w6
	add	w6,w4,w1
	mov	w1,[w0+10]
	inc	[w1],[w1]
	bra	.L188
.L185:
.LBE38:
.LBB39:
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
	inc	[w1],[w1]
.L188:
.LBE39:
	.loc 1 5172 0
	mov	_pxCurrentTCB,w3
	mov	[w0+22],w1
	mov	[w3+22],w0
	sub	w1,w0,[w15]
	.set ___BP___,39
	bra	leu,.L183
	.loc 1 5176 0
	cp0	w2
	.set ___BP___,15
	bra	z,.L189
	.loc 1 5178 0
	mov	#1,w0
	mov	w0,[w2]
.L189:
	.loc 1 5184 0
	mov	#1,w0
	mov	w0,_xYieldPending
.L183:
	.loc 1 5193 0
	return	
	.set ___PA___,0
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
.LCFI30:
	mov	w10,[w15++]
.LCFI31:
	mov	w1,w10
	.loc 1 5210 0
	cp0	w0
	.set ___BP___,85
	bra	nz,.L193
	mov	_pxCurrentTCB,w9
	bra	.L191
.L193:
	mov	w0,w9
.L191:
	.loc 1 5212 0
	rcall	_vPortEnterCritical
	.loc 1 5214 0
	add	w9,w10,w0
	mov.b	[w0+36],w0
	.loc 1 5221 0
	clr	w8
	.loc 1 5214 0
	sub.b	w0,#2,[w15]
	.set ___BP___,62
	bra	nz,.L192
	.loc 1 5216 0
	add	w9,w10,w9
	add	#36,w9
	clr.b	[w9]
	.loc 1 5217 0
	mov	#1,w8
.L192:
	.loc 1 5224 0
	rcall	_vPortExitCritical
	.loc 1 5227 0
	mov	w8,w0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
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
	mov.d	w8,[w15++]
.LCFI32:
	mov.d	w10,[w15++]
.LCFI33:
	mov	w1,w10
	mov.d	w2,w8
	.loc 1 5243 0
	cp0	w0
	.set ___BP___,78
	bra	nz,.L197
	mov	_pxCurrentTCB,w11
	bra	.L196
.L197:
	mov	w0,w11
.L196:
	.loc 1 5245 0
	rcall	_vPortEnterCritical
	.loc 1 5249 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	w11,w0,w0
	mov	[w0],w10
	mov	[w0+2],w11
	.loc 1 5250 0
	mov	[w0],w4
	mov	[w0+2],w5
	com	w8,w8
	com	w9,w9
	and	w5,w9,w3
	and	w4,w8,w2
	mov.d	w2,[w0]
	.loc 1 5252 0
	rcall	_vPortExitCritical
	.loc 1 5255 0
	mov.d	w10,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE41:
	.size	_ulTaskGenericNotifyValueClear, .-_ulTaskGenericNotifyValueClear
	.section	.text.prvAddCurrentTaskToDelayedList,code
	.align	2
	.global	_prvAddCurrentTaskToDelayedList	; export
	.type	_prvAddCurrentTaskToDelayedList,@function
_prvAddCurrentTaskToDelayedList:
.LFB42:
	.loc 1 5299 0
	.set ___PA___,1
	mov.d	w8,[w15++]
.LCFI34:
	mov	w10,[w15++]
.LCFI35:
	mov	w0,w8
	mov	w1,w10
	.loc 1 5301 0
	mov	_xTickCount,w9
	.loc 1 5314 0
	inc2	_pxCurrentTCB,WREG
	rcall	_uxListRemove
	.loc 1 5327 0
	add	w8,#1,[w15]
	.set ___BP___,72
	bra	nz,.L199
	cp0	w10
	.set ___BP___,61
	bra	z,.L199
.LBB40:
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
	mov	_pxCurrentTCB,w1
	mov	#_xSuspendedTaskList,w0
	mov	w0,[w1+10]
	inc	[w0],[w0]
.LBE40:
	bra	.L198
.L199:
	.loc 1 5339 0
	add	w8,w9,w8
	.loc 1 5342 0
	mov	_pxCurrentTCB,w0
	mov	w8,[w0+2]
	.loc 1 5344 0
	sub	w9,w8,[w15]
	.set ___BP___,61
	bra	leu,.L201
	.loc 1 5348 0
	mov	_pxCurrentTCB,w1
	mov	_pxOverflowDelayedTaskList,w0
	inc2	w1,w1
	rcall	_vListInsert
	bra	.L198
.L201:
	.loc 1 5354 0
	mov	_pxCurrentTCB,w1
	mov	_pxDelayedTaskList,w0
	inc2	w1,w1
	rcall	_vListInsert
	.loc 1 5359 0
	mov	_xNextTaskUnblockTime,w0
	sub	w0,w8,[w15]
	.set ___BP___,39
	bra	leu,.L198
	.loc 1 5361 0
	mov	w8,_xNextTaskUnblockTime
.L198:
	.loc 1 5407 0
	mov	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE42:
	.size	_prvAddCurrentTaskToDelayedList, .-_prvAddCurrentTaskToDelayedList
	.section	.text.xTaskGenericNotifyWait,code
	.align	2
	.global	_xTaskGenericNotifyWait	; export
	.type	_xTaskGenericNotifyWait,@function
_xTaskGenericNotifyWait:
.LFB36:
	.loc 1 4768 0
	.set ___PA___,0
	lnk	#4
.LCFI36:
	mov.d	w8,[w15++]
.LCFI37:
	mov.d	w10,[w15++]
.LCFI38:
	mov	w12,[w15++]
.LCFI39:
	mov	w0,w10
	mov.d	w2,w8
	mov	w4,[w15-14]
	mov	w5,[w15-12]
	mov	w1,w11
	mov	w6,w12
	.loc 1 4773 0
	rcall	_vPortEnterCritical
	.loc 1 4776 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w1
	mov.b	[w1+36],w0
	sub.b	w0,#2,[w15]
	.set ___BP___,28
	bra	z,.L203
	.loc 1 4781 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0],w4
	mov	[w0+2],w5
	com	w8,w8
	com	w9,w9
	and	w5,w9,w3
	and	w4,w8,w2
	mov.d	w2,[w0]
	.loc 1 4784 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w2
	mov.b	#1,w1
	mov.b	w1,[w2+36]
	.loc 1 4786 0
	cp0	w12
	.set ___BP___,71
	bra	z,.L203
	.loc 1 4788 0
	mov	#1,w1
	mov	w12,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 4795 0
; 4795 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L203:
	.loc 1 4807 0
	rcall	_vPortExitCritical
	.loc 1 4809 0
	rcall	_vPortEnterCritical
	.loc 1 4813 0
	cp0	w11
	.set ___BP___,15
	bra	z,.L204
	.loc 1 4817 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0++],[w11++]
	mov	[w0--],[w11--]
.L204:
	.loc 1 4824 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w1
	mov.b	[w1+36],w0
	.loc 1 4827 0
	clr	w8
	.loc 1 4824 0
	sub.b	w0,#2,[w15]
	.set ___BP___,62
	bra	nz,.L205
	.loc 1 4833 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0],w6
	mov	[w0+2],w7
	mov	[w15-14],w2
	mov	[w15-12],w3
	com	w2,w4
	com	w3,w5
	and	w7,w5,w3
	and	w6,w4,w2
	mov.d	w2,[w0]
	.loc 1 4834 0
	mov	#1,w8
.L205:
	.loc 1 4837 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w10
	add	#36,w10
	clr.b	[w10]
	.loc 1 4839 0
	rcall	_vPortExitCritical
	.loc 1 4842 0
	mov	w8,w0
	mov	[--w15],w12
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	ulnk	
	return	
	.set ___PA___,0
.LFE36:
	.size	_xTaskGenericNotifyWait, .-_xTaskGenericNotifyWait
	.section	.text.ulTaskGenericNotifyTake,code
	.align	2
	.global	_ulTaskGenericNotifyTake	; export
	.type	_ulTaskGenericNotifyTake,@function
_ulTaskGenericNotifyTake:
.LFB35:
	.loc 1 4694 0
	.set ___PA___,0
	mov.d	w8,[w15++]
.LCFI40:
	mov.d	w10,[w15++]
.LCFI41:
	mov.d	w0,w10
	mov	w2,w8
	.loc 1 4699 0
	rcall	_vPortEnterCritical
	.loc 1 4702 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0+2],w1
	mov	[w0],w0
	sub	w0,#0,[w15]
	subb	w1,#0,[w15]
	.set ___BP___,50
	bra	nz,.L208
	.loc 1 4705 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w2
	mov.b	#1,w1
	mov.b	w1,[w2+36]
	.loc 1 4707 0
	cp0	w8
	.set ___BP___,71
	bra	z,.L208
	.loc 1 4709 0
	mov	#1,w1
	mov	w8,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 4716 0
; 4716 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L208:
	.loc 1 4728 0
	rcall	_vPortExitCritical
	.loc 1 4730 0
	rcall	_vPortEnterCritical
	.loc 1 4733 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	mov	[w0],w8
	mov	[w0+2],w9
	.loc 1 4735 0
	sub	w8,#0,[w15]
	subb	w9,#0,[w15]
	.set ___BP___,39
	bra	z,.L209
	.loc 1 4737 0
	cp0	w11
	.set ___BP___,61
	bra	z,.L210
	.loc 1 4739 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	clr	[w0]
	mov	[w0++],[w0--]
	bra	.L209
.L210:
	.loc 1 4743 0
	add	w10,#8,w0
	sl	w0,#2,w0
	add	_pxCurrentTCB,WREG
	setm	w2
	setm	w3
	add	w8,w2,[w0++]
	addc	w9,w3,[w0--]
.L209:
	.loc 1 4751 0
	mov	w10,w0
	add	_pxCurrentTCB,WREG
	mov	w0,w10
	add	#36,w10
	clr.b	[w10]
	.loc 1 4753 0
	rcall	_vPortExitCritical
	.loc 1 4756 0
	mov.d	w8,w0
	mov.d	[--w15],w10
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.LFE35:
	.size	_ulTaskGenericNotifyTake, .-_ulTaskGenericNotifyTake
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
.LBB41:
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
.LBE41:
	.loc 1 3130 0
	mov	#1,w1
	mov	w2,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 3131 0
	return	
	.set ___PA___,0
.LFE22:
	.size	_vTaskPlaceOnUnorderedEventList, .-_vTaskPlaceOnUnorderedEventList
	.section	.text.vTaskPlaceOnEventList,code
	.align	2
	.global	_vTaskPlaceOnEventList	; export
	.type	_vTaskPlaceOnEventList,@function
_vTaskPlaceOnEventList:
.LFB21:
	.loc 1 3085 0
	.set ___PA___,1
	mov	w8,[w15++]
.LCFI42:
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
	.section	.text.vTaskDelay,code
	.align	2
	.global	_vTaskDelay	; export
	.type	_vTaskDelay,@function
_vTaskDelay:
.LFB4:
	.loc 1 1302 0
	.set ___PA___,0
	mov	w8,[w15++]
.LCFI43:
	mov	w0,w8
	.loc 1 1306 0
	cp0	w8
	.set ___BP___,71
	bra	z,.L214
	.loc 1 1309 0
	rcall	_vTaskSuspendAll
	.loc 1 1320 0
	clr	w1
	mov	w8,w0
	rcall	_prvAddCurrentTaskToDelayedList
	.loc 1 1322 0
	rcall	_xTaskResumeAll
	.loc 1 1331 0
	cp0	w0
	.set ___BP___,100
	bra	nz,.L213
.L214:
	.loc 1 1333 0
; 1333 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L213:
	.loc 1 1339 0
	mov	[--w15],w8
	return	
	.set ___PA___,0
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
	mov.d	w8,[w15++]
.LCFI44:
	mov.d	w0,w8
	.loc 1 1224 0
	rcall	_vTaskSuspendAll
.LBB42:
	.loc 1 1228 0
	mov	_xTickCount,w2
	.loc 1 1231 0
	mov	[w8],w1
	add	w9,w1,w0
	.loc 1 1233 0
	sub	w2,w1,[w15]
	.set ___BP___,50
	bra	geu,.L217
	.loc 1 1240 0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	leu,.L218
	.loc 1 1218 0
	mov	#1,w9
	sub	w2,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L219
	clr	w9
.L219:
	.loc 1 1265 0
	mov	w0,[w8]
	.loc 1 1267 0
	cp0	w9
	.set ___BP___,100
	bra	z,.L221
	bra	.L220
.L217:
	.loc 1 1254 0
	sub	w1,w0,[w15]
	.set ___BP___,50
	bra	gtu,.L222
	sub	w2,w0,[w15]
	.set ___BP___,50
	bra	ltu,.L222
	bra	.L218
.L220:
	.loc 1 1273 0
	sub	w0,w2,w0
	clr	w1
	rcall	_prvAddCurrentTaskToDelayedList
.L221:
.LBE42:
	.loc 1 1280 0
	rcall	_xTaskResumeAll
	.loc 1 1284 0
	cp0	w0
	.set ___BP___,39
	bra	nz,.L223
	.loc 1 1286 0
; 1286 "../../../Source/tasks.c" 1
	CALL _vPortYield			
NOP					  
.L223:
	.loc 1 1294 0
	mov	w9,w0
	mov.d	[--w15],w8
	return	
	.set ___PA___,0
.L222:
.LBB43:
	.loc 1 1265 0
	mov	w0,[w8]
	mov	#1,w9
	bra	.L220
.L218:
	mov	w0,[w8]
	clr	w9
	bra	.L221
.LBE43:
.LFE3:
	.size	_xTaskDelayUntil, .-_xTaskDelayUntil
	.global	_pxCurrentTCB	; export
	.section	.nbss,bss,near
	.align	2
	.type	_pxCurrentTCB,@object
	.size	_pxCurrentTCB, 2
_pxCurrentTCB:
	.skip	2
	.global	_uxCurrentNumberOfTasks	; export
	.align	2
	.type	_uxCurrentNumberOfTasks,@object
	.size	_uxCurrentNumberOfTasks, 2
_uxCurrentNumberOfTasks:
	.skip	2
	.global	_xTickCount	; export
	.align	2
	.type	_xTickCount,@object
	.size	_xTickCount, 2
_xTickCount:
	.skip	2
	.global	_uxTopReadyPriority	; export
	.align	2
	.type	_uxTopReadyPriority,@object
	.size	_uxTopReadyPriority, 2
_uxTopReadyPriority:
	.skip	2
	.global	_xSchedulerRunning	; export
	.align	2
	.type	_xSchedulerRunning,@object
	.size	_xSchedulerRunning, 2
_xSchedulerRunning:
	.skip	2
	.global	_xPendedTicks	; export
	.align	2
	.type	_xPendedTicks,@object
	.size	_xPendedTicks, 2
_xPendedTicks:
	.skip	2
	.global	_xYieldPending	; export
	.align	2
	.type	_xYieldPending,@object
	.size	_xYieldPending, 2
_xYieldPending:
	.skip	2
	.global	_xNumOfOverflows	; export
	.align	2
	.type	_xNumOfOverflows,@object
	.size	_xNumOfOverflows, 2
_xNumOfOverflows:
	.skip	2
	.global	_uxTaskNumber	; export
	.align	2
	.type	_uxTaskNumber,@object
	.size	_uxTaskNumber, 2
_uxTaskNumber:
	.skip	2
	.global	_xNextTaskUnblockTime	; export
	.align	2
	.type	_xNextTaskUnblockTime,@object
	.size	_xNextTaskUnblockTime, 2
_xNextTaskUnblockTime:
	.skip	2
	.global	_xIdleTaskHandle	; export
	.align	2
	.type	_xIdleTaskHandle,@object
	.size	_xIdleTaskHandle, 2
_xIdleTaskHandle:
	.skip	2
	.global	_uxTopUsedPriority	; export
	.section	.const,psv,page
	.align	2
	.type	_uxTopUsedPriority,@object
	.size	_uxTopUsedPriority, 2
_uxTopUsedPriority:
	.word	3
	.global	_uxSchedulerSuspended	; export
	.section	.nbss,bss,near
	.align	2
	.type	_uxSchedulerSuspended,@object
	.size	_uxSchedulerSuspended, 2
_uxSchedulerSuspended:
	.skip	2
	.section	.bss,bss
	.type	_pxReadyTasksLists,@object
	.size	_pxReadyTasksLists, 40
	.global	_pxReadyTasksLists
	.align	2
_pxReadyTasksLists:	.space	40
	.type	_xDelayedTaskList1,@object
	.size	_xDelayedTaskList1, 10
	.global	_xDelayedTaskList1
	.align	2
_xDelayedTaskList1:	.space	10
	.type	_xDelayedTaskList2,@object
	.size	_xDelayedTaskList2, 10
	.global	_xDelayedTaskList2
	.align	2
_xDelayedTaskList2:	.space	10
	.section	.nbss,bss,near
	.type	_pxDelayedTaskList,@object
	.size	_pxDelayedTaskList, 2
	.global	_pxDelayedTaskList
	.align	2
_pxDelayedTaskList:	.space	2
	.type	_pxOverflowDelayedTaskList,@object
	.size	_pxOverflowDelayedTaskList, 2
	.global	_pxOverflowDelayedTaskList
	.align	2
_pxOverflowDelayedTaskList:	.space	2
	.section	.bss,bss
	.type	_xPendingReadyList,@object
	.size	_xPendingReadyList, 10
	.global	_xPendingReadyList
	.align	2
_xPendingReadyList:	.space	10
	.type	_xSuspendedTaskList,@object
	.size	_xSuspendedTaskList, 10
	.global	_xSuspendedTaskList
	.align	2
_xSuspendedTaskList:	.space	10
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
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.byte	0x4
	.4byte	.LCFI0-.LFB29
	.byte	0x13
	.sleb128 -3
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
	.4byte	.LCFI1-.LFB1
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI4-.LCFI1
	.byte	0x8c
	.uleb128 0x7
	.byte	0x8a
	.uleb128 0x5
	.byte	0x88
	.uleb128 0x3
	.align	4
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI5-.LFB5
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
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
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.align	4
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.byte	0x4
	.4byte	.LCFI7-.LFB8
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
	.4byte	.LCFI8-.LFB9
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI9-.LCFI8
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
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.align	4
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.align	4
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.align	4
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.align	4
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.align	4
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.align	4
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.align	4
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.align	4
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.align	4
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.byte	0x4
	.4byte	.LCFI10-.LFB25
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
	.4byte	.LFB26
	.4byte	.LFE26-.LFB26
	.align	4
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB27
	.4byte	.LFE27-.LFB27
	.byte	0x4
	.4byte	.LCFI11-.LFB27
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI12-.LCFI11
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB28
	.4byte	.LFE28-.LFB28
	.align	4
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB30
	.4byte	.LFE30-.LFB30
	.byte	0x4
	.4byte	.LCFI13-.LFB30
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
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI14-.LFB2
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
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI15-.LFB0
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI16-.LCFI15
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI17-.LCFI16
	.byte	0x13
	.sleb128 -8
	.byte	0x4
	.4byte	.LCFI18-.LCFI17
	.byte	0x13
	.sleb128 -9
	.byte	0x8e
	.uleb128 0x8
	.byte	0x8c
	.uleb128 0x6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI19-.LCFI18
	.byte	0x13
	.sleb128 -10
	.byte	0x4
	.4byte	.LCFI20-.LCFI19
	.byte	0x2e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI21-.LCFI20
	.byte	0x13
	.sleb128 -9
	.align	4
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.align	4
.LEFDE44:
.LSFDE46:
	.4byte	.LEFDE46-.LASFDE46
.LASFDE46:
	.4byte	.Lframe0
	.4byte	.LFB31
	.4byte	.LFE31-.LFB31
	.align	4
.LEFDE46:
.LSFDE48:
	.4byte	.LEFDE48-.LASFDE48
.LASFDE48:
	.4byte	.Lframe0
	.4byte	.LFB32
	.4byte	.LFE32-.LFB32
	.align	4
.LEFDE48:
.LSFDE50:
	.4byte	.LEFDE50-.LASFDE50
.LASFDE50:
	.4byte	.Lframe0
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.byte	0x4
	.4byte	.LCFI22-.LFB19
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE50:
.LSFDE52:
	.4byte	.LEFDE52-.LASFDE52
.LASFDE52:
	.4byte	.Lframe0
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.byte	0x4
	.4byte	.LCFI23-.LFB13
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE52:
.LSFDE54:
	.4byte	.LEFDE54-.LASFDE54
.LASFDE54:
	.4byte	.Lframe0
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.byte	0x4
	.4byte	.LCFI24-.LFB18
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE54:
.LSFDE56:
	.4byte	.LEFDE56-.LASFDE56
.LASFDE56:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI25-.LFB6
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE56:
.LSFDE58:
	.4byte	.LEFDE58-.LASFDE58
.LASFDE58:
	.4byte	.Lframe0
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.align	4
.LEFDE58:
.LSFDE60:
	.4byte	.LEFDE60-.LASFDE60
.LASFDE60:
	.4byte	.Lframe0
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
	.align	4
.LEFDE60:
.LSFDE62:
	.4byte	.LEFDE62-.LASFDE62
.LASFDE62:
	.4byte	.Lframe0
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.byte	0x4
	.4byte	.LCFI26-.LFB37
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI27-.LCFI26
	.byte	0x13
	.sleb128 -6
	.byte	0x4
	.4byte	.LCFI28-.LCFI27
	.byte	0x13
	.sleb128 -8
	.byte	0x8c
	.uleb128 0x6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE62:
.LSFDE64:
	.4byte	.LEFDE64-.LASFDE64
.LASFDE64:
	.4byte	.Lframe0
	.4byte	.LFB38
	.4byte	.LFE38-.LFB38
	.byte	0x4
	.4byte	.LCFI29-.LFB38
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE64:
.LSFDE66:
	.4byte	.LEFDE66-.LASFDE66
.LASFDE66:
	.4byte	.Lframe0
	.4byte	.LFB39
	.4byte	.LFE39-.LFB39
	.align	4
.LEFDE66:
.LSFDE68:
	.4byte	.LEFDE68-.LASFDE68
.LASFDE68:
	.4byte	.Lframe0
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.byte	0x4
	.4byte	.LCFI30-.LFB40
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI31-.LCFI30
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE68:
.LSFDE70:
	.4byte	.LEFDE70-.LASFDE70
.LASFDE70:
	.4byte	.Lframe0
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.byte	0x4
	.4byte	.LCFI32-.LFB41
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI33-.LCFI32
	.byte	0x13
	.sleb128 -6
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
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.byte	0x4
	.4byte	.LCFI34-.LFB42
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI35-.LCFI34
	.byte	0x13
	.sleb128 -5
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE72:
.LSFDE74:
	.4byte	.LEFDE74-.LASFDE74
.LASFDE74:
	.4byte	.Lframe0
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.byte	0x4
	.4byte	.LCFI36-.LFB36
	.byte	0x12
	.uleb128 0xe
	.sleb128 -3
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI39-.LCFI36
	.byte	0x8c
	.uleb128 0x9
	.byte	0x8a
	.uleb128 0x7
	.byte	0x88
	.uleb128 0x5
	.align	4
.LEFDE74:
.LSFDE76:
	.4byte	.LEFDE76-.LASFDE76
.LASFDE76:
	.4byte	.Lframe0
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.byte	0x4
	.4byte	.LCFI40-.LFB35
	.byte	0x13
	.sleb128 -4
	.byte	0x4
	.4byte	.LCFI41-.LCFI40
	.byte	0x13
	.sleb128 -6
	.byte	0x8a
	.uleb128 0x4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE76:
.LSFDE78:
	.4byte	.LEFDE78-.LASFDE78
.LASFDE78:
	.4byte	.Lframe0
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.align	4
.LEFDE78:
.LSFDE80:
	.4byte	.LEFDE80-.LASFDE80
.LASFDE80:
	.4byte	.Lframe0
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.byte	0x4
	.4byte	.LCFI42-.LFB21
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE80:
.LSFDE82:
	.4byte	.LEFDE82-.LASFDE82
.LASFDE82:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI43-.LFB4
	.byte	0x13
	.sleb128 -3
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE82:
.LSFDE84:
	.4byte	.LEFDE84-.LASFDE84
.LASFDE84:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI44-.LFB3
	.byte	0x13
	.sleb128 -4
	.byte	0x88
	.uleb128 0x2
	.align	4
.LEFDE84:
	.section	.text,code
.Letext0:
	.file 2 "c:\\program files\\microchip\\xc16\\v2.10\\bin\\bin\\../..\\include/bits/alltypes.h"
	.file 3 "C:/Program Files/Microchip/MPLABX/v6.20/packs/Microchip/dsPIC33EV-GM-00X-10X_DFP/1.4.243/xc16/bin/..\\support\\dsPIC33E\\h/p33EV128GM106.h"
	.file 4 "../../../Source/include/projdefs.h"
	.file 5 "../../../Source/include/../../Source/portable/MPLAB/PIC24_dsPIC/portmacro.h"
	.file 6 "../../../Source/include/list.h"
	.file 7 "../../../Source/include/task.h"
	.section	.debug_info,info
	.4byte	0x1ea9
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
	.byte	0x1
	.asciz	"prvIdleTask"
	.byte	0x1
	.2byte	0xd63
	.byte	0x1
	.4byte	.LFB29
	.4byte	.LFE29
	.byte	0x1
	.byte	0x5f
	.4byte	0x840
	.uleb128 0x1a
	.4byte	.LASF5
	.byte	0x1
	.2byte	0xd63
	.4byte	0x38e
	.byte	0x1
	.byte	0x50
	.uleb128 0x1b
	.4byte	.LBB2
	.4byte	.LBE2
	.uleb128 0x1c
	.byte	0x1
	.asciz	"vApplicationIdleHook"
	.byte	0x1
	.2byte	0xd98
	.byte	0x1
	.byte	0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"prvInitialiseNewTask"
	.byte	0x1
	.2byte	0x330
	.byte	0x1
	.4byte	.LFB1
	.4byte	.LFE1
	.byte	0x1
	.byte	0x5f
	.4byte	0x90b
	.uleb128 0x1a
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x330
	.4byte	0x366
	.byte	0x1
	.byte	0x5d
	.uleb128 0x1d
	.asciz	"pcName"
	.byte	0x1
	.2byte	0x331
	.4byte	0x90b
	.byte	0x1
	.byte	0x51
	.uleb128 0x1d
	.asciz	"ulStackDepth"
	.byte	0x1
	.2byte	0x332
	.4byte	0x910
	.byte	0x6
	.byte	0x52
	.byte	0x93
	.uleb128 0x2
	.byte	0x53
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x1a
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x333
	.4byte	0x915
	.byte	0x1
	.byte	0x5c
	.uleb128 0x1a
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x334
	.4byte	0x3c2
	.byte	0x1
	.byte	0x55
	.uleb128 0x1a
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x335
	.4byte	0x91a
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1a
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x336
	.4byte	0x925
	.byte	0x1
	.byte	0x58
	.uleb128 0x1d
	.asciz	"xRegions"
	.byte	0x1
	.2byte	0x337
	.4byte	0x92b
	.byte	0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1e
	.4byte	.LASF3
	.byte	0x1
	.2byte	0x339
	.4byte	0x7a3
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1f
	.asciz	"x"
	.byte	0x1
	.2byte	0x33a
	.4byte	0x3c2
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x17
	.4byte	0x790
	.uleb128 0x17
	.4byte	0x1c3
	.uleb128 0x17
	.4byte	0x38e
	.uleb128 0x17
	.4byte	0x91f
	.uleb128 0xa
	.byte	0x2
	.4byte	0x54d
	.uleb128 0xa
	.byte	0x2
	.4byte	0x7dd
	.uleb128 0x17
	.4byte	0x930
	.uleb128 0xa
	.byte	0x2
	.4byte	0x936
	.uleb128 0x17
	.4byte	0x77a
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskPrioritySet"
	.byte	0x1
	.2byte	0x5e3
	.byte	0x1
	.4byte	.LFB5
	.4byte	.LFE5
	.byte	0x1
	.byte	0x5f
	.4byte	0x9f9
	.uleb128 0x1a
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x5e3
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x1d
	.asciz	"uxNewPriority"
	.byte	0x1
	.2byte	0x5e4
	.4byte	0x3c2
	.byte	0x1
	.byte	0x51
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x5e6
	.4byte	0x925
	.byte	0x1
	.byte	0x58
	.uleb128 0x1f
	.asciz	"uxCurrentBasePriority"
	.byte	0x1
	.2byte	0x5e7
	.4byte	0x3c2
	.byte	0x1
	.byte	0x50
	.uleb128 0x20
	.asciz	"uxPriorityUsedOnEntry"
	.byte	0x1
	.2byte	0x5e7
	.4byte	0x3c2
	.uleb128 0x1e
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x5e8
	.4byte	0x3a3
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1b
	.4byte	.LBB3
	.4byte	.LBE3
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x66c
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x539
	.uleb128 0x21
	.byte	0x1
	.asciz	"prvTaskIsTaskSuspended"
	.byte	0x1
	.2byte	0x6f3
	.byte	0x1
	.4byte	0x3a3
	.4byte	.LFB7
	.4byte	.LFE7
	.byte	0x1
	.byte	0x5f
	.4byte	0xa56
	.uleb128 0x1a
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x6f3
	.4byte	0xa56
	.byte	0x1
	.byte	0x51
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x6f5
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x6f6
	.4byte	0xa5b
	.byte	0x0
	.uleb128 0x17
	.4byte	0x54d
	.uleb128 0x17
	.4byte	0xa60
	.uleb128 0xa
	.byte	0x2
	.4byte	0xa66
	.uleb128 0x17
	.4byte	0x7dd
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskResume"
	.byte	0x1
	.2byte	0x721
	.byte	0x1
	.4byte	.LFB8
	.4byte	.LFE8
	.byte	0x1
	.byte	0x5f
	.4byte	0xabe
	.uleb128 0x1a
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x721
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x723
	.4byte	0xabe
	.uleb128 0x1b
	.4byte	.LBB4
	.4byte	.LBE4
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x735
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x925
	.uleb128 0x21
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
	.4byte	0xb3b
	.uleb128 0x1a
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x757
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF11
	.byte	0x1
	.2byte	0x759
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x75a
	.4byte	0xabe
	.uleb128 0x22
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x75b
	.4byte	0x3c2
	.uleb128 0x1b
	.4byte	.LBB5
	.4byte	.LBE5
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x78b
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x23
	.byte	0x1
	.asciz	"vTaskEndScheduler"
	.byte	0x1
	.2byte	0x81f
	.byte	0x1
	.4byte	.LFB11
	.4byte	.LFE11
	.byte	0x1
	.byte	0x5f
	.uleb128 0x23
	.byte	0x1
	.asciz	"vTaskSuspendAll"
	.byte	0x1
	.2byte	0x82a
	.byte	0x1
	.4byte	.LFB12
	.4byte	.LFE12
	.byte	0x1
	.byte	0x5f
	.uleb128 0x21
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
	.4byte	0xbb9
	.uleb128 0x1f
	.asciz	"xTicks"
	.byte	0x1
	.2byte	0x8f0
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0xc05
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x8ff
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.uleb128 0x22
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x900
	.4byte	0x3c2
	.byte	0x0
	.uleb128 0x24
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
	.uleb128 0x21
	.byte	0x1
	.asciz	"pcTaskGetName"
	.byte	0x1
	.2byte	0x924
	.byte	0x1
	.4byte	0xc7c
	.4byte	.LFB17
	.4byte	.LFE17
	.byte	0x1
	.byte	0x5f
	.4byte	0xc7c
	.uleb128 0x1d
	.asciz	"xTaskToQuery"
	.byte	0x1
	.2byte	0x924
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x926
	.4byte	0x925
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x79b
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskSwitchContext"
	.byte	0x1
	.2byte	0xbc1
	.byte	0x1
	.4byte	.LFB20
	.4byte	.LFE20
	.byte	0x1
	.byte	0x5f
	.4byte	0xcea
	.uleb128 0x1b
	.4byte	.LBB6
	.4byte	.LBE6
	.uleb128 0x1f
	.asciz	"uxTopPriority"
	.byte	0x1
	.2byte	0xbf6
	.4byte	0x3c2
	.byte	0x1
	.byte	0x50
	.uleb128 0x1b
	.4byte	.LBB7
	.4byte	.LBE7
	.uleb128 0x20
	.asciz	"pxConstList"
	.byte	0x1
	.2byte	0xbf6
	.4byte	0xcea
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0xcef
	.uleb128 0xa
	.byte	0x2
	.4byte	0x53f
	.uleb128 0x21
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
	.4byte	0xdbd
	.uleb128 0x1a
	.4byte	.LASF15
	.byte	0x1
	.2byte	0xc61
	.4byte	0xdbd
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LASF16
	.byte	0x1
	.2byte	0xc63
	.4byte	0x925
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xc64
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LBB8
	.4byte	.LBE8
	.4byte	0xd6c
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0xc75
	.4byte	0xcea
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB9
	.4byte	.LBE9
	.4byte	0xd88
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0xc79
	.4byte	0xcea
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB10
	.4byte	.LBE10
	.4byte	0xda4
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xc7a
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB11
	.4byte	.LBE11
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xc8e
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0xdc2
	.uleb128 0xa
	.byte	0x2
	.4byte	0xdc8
	.uleb128 0x17
	.4byte	0x53f
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskRemoveFromUnorderedEventList"
	.byte	0x1
	.2byte	0xca5
	.byte	0x1
	.4byte	.LFB24
	.4byte	.LFE24
	.byte	0x1
	.byte	0x5f
	.4byte	0xe8a
	.uleb128 0x1d
	.asciz	"pxEventListItem"
	.byte	0x1
	.2byte	0xca5
	.4byte	0x539
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF0
	.byte	0x1
	.2byte	0xca6
	.4byte	0xe8a
	.byte	0x1
	.byte	0x51
	.uleb128 0x1e
	.4byte	.LASF16
	.byte	0x1
	.2byte	0xca8
	.4byte	0x925
	.byte	0x1
	.byte	0x51
	.uleb128 0x25
	.4byte	.LBB12
	.4byte	.LBE12
	.4byte	0xe55
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0xcb5
	.4byte	0xcea
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB13
	.4byte	.LBE13
	.4byte	0xe71
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0xcc8
	.4byte	0xcea
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB14
	.4byte	.LBE14
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xcc9
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x3d5
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskSetTimeOutState"
	.byte	0x1
	.2byte	0xcd6
	.byte	0x1
	.4byte	.LFB25
	.4byte	.LFE25
	.byte	0x1
	.byte	0x5f
	.4byte	0xec7
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0xcd6
	.4byte	0xec7
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x17
	.4byte	0xecc
	.uleb128 0xa
	.byte	0x2
	.4byte	0x708
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskInternalSetTimeOutState"
	.byte	0x1
	.2byte	0xce2
	.byte	0x1
	.4byte	.LFB26
	.4byte	.LFE26
	.byte	0x1
	.byte	0x5f
	.4byte	0xf12
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0xce2
	.4byte	0xec7
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0xfa3
	.uleb128 0x1a
	.4byte	.LASF18
	.byte	0x1
	.2byte	0xcea
	.4byte	0xec7
	.byte	0x1
	.byte	0x59
	.uleb128 0x1d
	.asciz	"pxTicksToWait"
	.byte	0x1
	.2byte	0xceb
	.4byte	0xfa3
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xced
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.uleb128 0x1b
	.4byte	.LBB15
	.4byte	.LBE15
	.uleb128 0x1e
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xcf5
	.4byte	0xe8a
	.byte	0x1
	.byte	0x52
	.uleb128 0x1f
	.asciz	"xElapsedTime"
	.byte	0x1
	.2byte	0xcf6
	.4byte	0xe8a
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0xfa8
	.uleb128 0xa
	.byte	0x2
	.4byte	0x3d5
	.uleb128 0x23
	.byte	0x1
	.asciz	"vTaskMissedYield"
	.byte	0x1
	.2byte	0xd2b
	.byte	0x1
	.4byte	.LFB28
	.4byte	.LFE28
	.byte	0x1
	.byte	0x5f
	.uleb128 0x19
	.byte	0x1
	.asciz	"prvInitialiseTaskLists"
	.byte	0x1
	.2byte	0xe49
	.byte	0x1
	.4byte	.LFB30
	.4byte	.LFE30
	.byte	0x1
	.byte	0x5f
	.4byte	0x1009
	.uleb128 0x1e
	.4byte	.LASF4
	.byte	0x1
	.2byte	0xe4b
	.4byte	0x3c2
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"prvAddNewTaskToReadyList"
	.byte	0x1
	.2byte	0x402
	.byte	0x1
	.4byte	.LFB2
	.4byte	.LFE2
	.byte	0x1
	.byte	0x5f
	.4byte	0x105d
	.uleb128 0x1a
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x402
	.4byte	0x925
	.byte	0x1
	.byte	0x58
	.uleb128 0x1b
	.4byte	.LBB16
	.4byte	.LBE16
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x43c
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x10fe
	.uleb128 0x1a
	.4byte	.LASF6
	.byte	0x1
	.2byte	0x2d1
	.4byte	0x366
	.byte	0x1
	.byte	0x5e
	.uleb128 0x1d
	.asciz	"pcName"
	.byte	0x1
	.2byte	0x2d2
	.4byte	0x90b
	.byte	0x1
	.byte	0x5d
	.uleb128 0x1d
	.asciz	"usStackDepth"
	.byte	0x1
	.2byte	0x2d3
	.4byte	0x10fe
	.byte	0x1
	.byte	0x59
	.uleb128 0x1a
	.4byte	.LASF5
	.byte	0x1
	.2byte	0x2d4
	.4byte	0x915
	.byte	0x1
	.byte	0x5c
	.uleb128 0x1a
	.4byte	.LASF4
	.byte	0x1
	.2byte	0x2d5
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1a
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x2d6
	.4byte	0x91a
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1e
	.4byte	.LASF8
	.byte	0x1
	.2byte	0x2d8
	.4byte	0x925
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x2d9
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x17
	.4byte	0x1b3
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskStartScheduler"
	.byte	0x1
	.2byte	0x7a2
	.byte	0x1
	.4byte	.LFB10
	.4byte	.LFE10
	.byte	0x1
	.byte	0x5f
	.4byte	0x113a
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x7a4
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x23
	.byte	0x1
	.asciz	"prvCheckTasksWaitingTermination"
	.byte	0x1
	.2byte	0xe69
	.byte	0x1
	.4byte	.LFB31
	.4byte	.LFE31
	.byte	0x1
	.byte	0x5f
	.uleb128 0x23
	.byte	0x1
	.asciz	"prvResetNextTaskUnblockTime"
	.byte	0x1
	.2byte	0xf9f
	.byte	0x1
	.4byte	.LFB32
	.4byte	.LFE32
	.byte	0x1
	.byte	0x5f
	.uleb128 0x21
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
	.4byte	0x127d
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0xaa2
	.4byte	0x925
	.byte	0x1
	.byte	0x51
	.uleb128 0x1e
	.4byte	.LASF0
	.byte	0x1
	.2byte	0xaa3
	.4byte	0x3d5
	.byte	0x1
	.byte	0x52
	.uleb128 0x1f
	.asciz	"xSwitchRequired"
	.byte	0x1
	.2byte	0xaa4
	.4byte	0x3a3
	.byte	0x1
	.byte	0x56
	.uleb128 0x1b
	.4byte	.LBB17
	.4byte	.LBE17
	.uleb128 0x1e
	.4byte	.LASF19
	.byte	0x1
	.2byte	0xaaf
	.4byte	0xe8a
	.byte	0x1
	.byte	0x58
	.uleb128 0x25
	.4byte	.LBB19
	.4byte	.LBE19
	.4byte	0x1228
	.uleb128 0x22
	.4byte	.LASF17
	.byte	0x1
	.2byte	0xaef
	.4byte	0xcea
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB21
	.4byte	.LBE21
	.4byte	0x1244
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xaf8
	.4byte	0x9f9
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB22
	.4byte	.LBE22
	.4byte	0x1260
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0xae9
	.4byte	0xcea
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB23
	.4byte	.LBE23
	.uleb128 0x1f
	.asciz	"pxTemp"
	.byte	0x1
	.2byte	0xab7
	.4byte	0xcef
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1337
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x880
	.4byte	0x925
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x881
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.uleb128 0x25
	.4byte	.LBB25
	.4byte	.LBE25
	.4byte	0x12dc
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x899
	.4byte	0xcea
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB26
	.4byte	.LBE26
	.4byte	0x12f8
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x89b
	.4byte	0xcea
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB27
	.4byte	.LBE27
	.4byte	0x1314
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x89c
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB30
	.4byte	.LBE30
	.uleb128 0x1f
	.asciz	"xPendedCounts"
	.byte	0x1
	.2byte	0x8ba
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1395
	.uleb128 0x1d
	.asciz	"xTicksToCatchUp"
	.byte	0x1
	.2byte	0xa38
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x1f
	.asciz	"xYieldOccurred"
	.byte	0x1
	.2byte	0xa3a
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskSuspend"
	.byte	0x1
	.2byte	0x689
	.byte	0x1
	.4byte	.LFB6
	.4byte	.LFE6
	.byte	0x1
	.byte	0x5f
	.4byte	0x13f2
	.uleb128 0x1d
	.asciz	"xTaskToSuspend"
	.byte	0x1
	.2byte	0x689
	.4byte	0x54d
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x68b
	.4byte	0x925
	.byte	0x1
	.byte	0x58
	.uleb128 0x1b
	.4byte	.LBB31
	.4byte	.LBE31
	.uleb128 0x20
	.asciz	"x"
	.byte	0x1
	.2byte	0x6ae
	.4byte	0x3a3
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1433
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0xfb8
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1479
	.uleb128 0x1f
	.asciz	"uxReturn"
	.byte	0x1
	.2byte	0x1234
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1554
	.uleb128 0x1a
	.4byte	.LASF21
	.byte	0x1
	.2byte	0x12f1
	.4byte	0x54d
	.byte	0x1
	.byte	0x59
	.uleb128 0x1a
	.4byte	.LASF22
	.byte	0x1
	.2byte	0x12f2
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5c
	.uleb128 0x1d
	.asciz	"ulValue"
	.byte	0x1
	.2byte	0x12f3
	.4byte	0x1c3
	.byte	0x6
	.byte	0x5a
	.byte	0x93
	.uleb128 0x2
	.byte	0x5b
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x1d
	.asciz	"eAction"
	.byte	0x1
	.2byte	0x12f4
	.4byte	0x6ad
	.byte	0x1
	.byte	0x58
	.uleb128 0x1a
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x12f5
	.4byte	0x1554
	.byte	0x1
	.byte	0x5d
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x12f7
	.4byte	0x925
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x12f8
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF24
	.byte	0x1
	.2byte	0x12f9
	.4byte	0x193
	.byte	0x1
	.byte	0x50
	.uleb128 0x25
	.4byte	.LBB32
	.4byte	.LBE32
	.4byte	0x153b
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x133c
	.4byte	0xcea
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB33
	.4byte	.LBE33
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x133d
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x1c3
	.uleb128 0x21
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
	.4byte	0x1672
	.uleb128 0x1a
	.4byte	.LASF21
	.byte	0x1
	.2byte	0x136c
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF22
	.byte	0x1
	.2byte	0x136d
	.4byte	0x3c2
	.byte	0x1
	.byte	0x51
	.uleb128 0x1d
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
	.uleb128 0x1d
	.asciz	"eAction"
	.byte	0x1
	.2byte	0x136f
	.4byte	0x6ad
	.byte	0x1
	.byte	0x54
	.uleb128 0x1a
	.4byte	.LASF23
	.byte	0x1
	.2byte	0x1370
	.4byte	0x1554
	.byte	0x1
	.byte	0x55
	.uleb128 0x1a
	.4byte	.LASF25
	.byte	0x1
	.2byte	0x1371
	.4byte	0x1672
	.byte	0x1
	.byte	0x56
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1373
	.4byte	0x925
	.uleb128 0x1e
	.4byte	.LASF24
	.byte	0x1
	.2byte	0x1374
	.4byte	0x193
	.byte	0x1
	.byte	0x55
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x1375
	.4byte	0x3a3
	.byte	0x1
	.byte	0x54
	.uleb128 0x22
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x1376
	.4byte	0x3c2
	.uleb128 0x25
	.4byte	.LBB34
	.4byte	.LBE34
	.4byte	0x163d
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x13cf
	.4byte	0xcea
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB35
	.4byte	.LBE35
	.4byte	0x1659
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x13d0
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB36
	.4byte	.LBE36
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x13d6
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.byte	0x2
	.4byte	0x3a3
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskGenericNotifyGiveFromISR"
	.byte	0x1
	.2byte	0x13f7
	.byte	0x1
	.4byte	.LFB39
	.4byte	.LFE39
	.byte	0x1
	.byte	0x5f
	.4byte	0x174b
	.uleb128 0x1a
	.4byte	.LASF21
	.byte	0x1
	.2byte	0x13f7
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF22
	.byte	0x1
	.2byte	0x13f8
	.4byte	0x3c2
	.byte	0x1
	.byte	0x51
	.uleb128 0x1a
	.4byte	.LASF25
	.byte	0x1
	.2byte	0x13f9
	.4byte	0x1672
	.byte	0x1
	.byte	0x52
	.uleb128 0x22
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x13fb
	.4byte	0x925
	.uleb128 0x1e
	.4byte	.LASF24
	.byte	0x1
	.2byte	0x13fc
	.4byte	0x193
	.byte	0x1
	.byte	0x53
	.uleb128 0x22
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x13fd
	.4byte	0x3c2
	.uleb128 0x25
	.4byte	.LBB37
	.4byte	.LBE37
	.4byte	0x1716
	.uleb128 0x1e
	.4byte	.LASF17
	.byte	0x1
	.2byte	0x142a
	.4byte	0xcea
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x25
	.4byte	.LBB38
	.4byte	.LBE38
	.4byte	0x1732
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x142b
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.uleb128 0x1b
	.4byte	.LBB39
	.4byte	.LBE39
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x1431
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x17b9
	.uleb128 0x1a
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x1450
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF26
	.byte	0x1
	.2byte	0x1451
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1453
	.4byte	0x925
	.byte	0x1
	.byte	0x59
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x1454
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x184a
	.uleb128 0x1a
	.4byte	.LASF9
	.byte	0x1
	.2byte	0x1472
	.4byte	0x54d
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF26
	.byte	0x1
	.2byte	0x1473
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1d
	.asciz	"ulBitsToClear"
	.byte	0x1
	.2byte	0x1474
	.4byte	0x1c3
	.byte	0x6
	.byte	0x58
	.byte	0x93
	.uleb128 0x2
	.byte	0x59
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x1e
	.4byte	.LASF10
	.byte	0x1
	.2byte	0x1476
	.4byte	0x925
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1e
	.4byte	.LASF27
	.byte	0x1
	.2byte	0x1477
	.4byte	0x1c3
	.byte	0x6
	.byte	0x5a
	.byte	0x93
	.uleb128 0x2
	.byte	0x5b
	.byte	0x93
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"prvAddCurrentTaskToDelayedList"
	.byte	0x1
	.2byte	0x14b1
	.byte	0x1
	.4byte	.LFB42
	.4byte	.LFE42
	.byte	0x1
	.byte	0x5f
	.4byte	0x18e0
	.uleb128 0x1a
	.4byte	.LASF28
	.byte	0x1
	.2byte	0x14b1
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x1d
	.asciz	"xCanBlockIndefinitely"
	.byte	0x1
	.2byte	0x14b2
	.4byte	0x18e0
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1e
	.4byte	.LASF29
	.byte	0x1
	.2byte	0x14b4
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x14b5
	.4byte	0xe8a
	.byte	0x1
	.byte	0x59
	.uleb128 0x1b
	.4byte	.LBB40
	.4byte	.LBE40
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0x14d4
	.4byte	0x9f9
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.4byte	0x3a3
	.uleb128 0x21
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
	.4byte	0x19a1
	.uleb128 0x1a
	.4byte	.LASF30
	.byte	0x1
	.2byte	0x129b
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1d
	.asciz	"ulBitsToClearOnEntry"
	.byte	0x1
	.2byte	0x129c
	.4byte	0x1c3
	.byte	0x6
	.byte	0x58
	.byte	0x93
	.uleb128 0x2
	.byte	0x59
	.byte	0x93
	.uleb128 0x2
	.uleb128 0x1d
	.asciz	"ulBitsToClearOnExit"
	.byte	0x1
	.2byte	0x129d
	.4byte	0x1c3
	.byte	0x2
	.byte	0x7f
	.sleb128 -14
	.uleb128 0x1d
	.asciz	"pulNotificationValue"
	.byte	0x1
	.2byte	0x129e
	.4byte	0x1554
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1a
	.4byte	.LASF28
	.byte	0x1
	.2byte	0x129f
	.4byte	0x3d5
	.byte	0x1
	.byte	0x5c
	.uleb128 0x1e
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x12a1
	.4byte	0x3a3
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1a1d
	.uleb128 0x1a
	.4byte	.LASF30
	.byte	0x1
	.2byte	0x1253
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5a
	.uleb128 0x1d
	.asciz	"xClearCountOnExit"
	.byte	0x1
	.2byte	0x1254
	.4byte	0x3a3
	.byte	0x1
	.byte	0x5b
	.uleb128 0x1a
	.4byte	.LASF28
	.byte	0x1
	.2byte	0x1255
	.4byte	0x3d5
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF27
	.byte	0x1
	.2byte	0x1257
	.4byte	0x1c3
	.byte	0x6
	.byte	0x58
	.byte	0x93
	.uleb128 0x2
	.byte	0x59
	.byte	0x93
	.uleb128 0x2
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskPlaceOnUnorderedEventList"
	.byte	0x1
	.2byte	0xc24
	.byte	0x1
	.4byte	.LFB22
	.4byte	.LFE22
	.byte	0x1
	.byte	0x5f
	.4byte	0x1a93
	.uleb128 0x1a
	.4byte	.LASF15
	.byte	0x1
	.2byte	0xc24
	.4byte	0xcef
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF0
	.byte	0x1
	.2byte	0xc25
	.4byte	0xe8a
	.byte	0x1
	.byte	0x51
	.uleb128 0x1a
	.4byte	.LASF28
	.byte	0x1
	.2byte	0xc26
	.4byte	0xe8a
	.byte	0x1
	.byte	0x52
	.uleb128 0x1b
	.4byte	.LBB41
	.4byte	.LBE41
	.uleb128 0x1e
	.4byte	.LASF2
	.byte	0x1
	.2byte	0xc38
	.4byte	0x9f9
	.byte	0x1
	.byte	0x51
	.byte	0x0
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskPlaceOnEventList"
	.byte	0x1
	.2byte	0xc0b
	.byte	0x1
	.4byte	.LFB21
	.4byte	.LFE21
	.byte	0x1
	.byte	0x5f
	.4byte	0x1ada
	.uleb128 0x1a
	.4byte	.LASF15
	.byte	0x1
	.2byte	0xc0b
	.4byte	0xcea
	.byte	0x1
	.byte	0x50
	.uleb128 0x1a
	.4byte	.LASF28
	.byte	0x1
	.2byte	0xc0c
	.4byte	0xe8a
	.byte	0x1
	.byte	0x58
	.byte	0x0
	.uleb128 0x19
	.byte	0x1
	.asciz	"vTaskDelay"
	.byte	0x1
	.2byte	0x515
	.byte	0x1
	.4byte	.LFB4
	.4byte	.LFE4
	.byte	0x1
	.byte	0x5f
	.4byte	0x1b20
	.uleb128 0x1d
	.asciz	"xTicksToDelay"
	.byte	0x1
	.2byte	0x515
	.4byte	0xe8a
	.byte	0x1
	.byte	0x58
	.uleb128 0x1e
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x517
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.byte	0x0
	.uleb128 0x21
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
	.4byte	0x1bca
	.uleb128 0x1d
	.asciz	"pxPreviousWakeTime"
	.byte	0x1
	.2byte	0x4be
	.4byte	0xfa3
	.byte	0x1
	.byte	0x58
	.uleb128 0x1d
	.asciz	"xTimeIncrement"
	.byte	0x1
	.2byte	0x4bf
	.4byte	0xe8a
	.byte	0x1
	.byte	0x59
	.uleb128 0x1e
	.4byte	.LASF29
	.byte	0x1
	.2byte	0x4c1
	.4byte	0x3d5
	.byte	0x1
	.byte	0x50
	.uleb128 0x1e
	.4byte	.LASF20
	.byte	0x1
	.2byte	0x4c2
	.4byte	0x3a3
	.byte	0x1
	.byte	0x50
	.uleb128 0x1f
	.asciz	"xShouldDelay"
	.byte	0x1
	.2byte	0x4c2
	.4byte	0x3a3
	.byte	0x1
	.byte	0x59
	.uleb128 0x1b
	.4byte	.LBB42
	.4byte	.LBE42
	.uleb128 0x1e
	.4byte	.LASF19
	.byte	0x1
	.2byte	0x4cc
	.4byte	0xe8a
	.byte	0x1
	.byte	0x52
	.byte	0x0
	.byte	0x0
	.uleb128 0x26
	.asciz	"SRbits"
	.byte	0x3
	.byte	0xa0
	.4byte	0x1bda
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x358
	.uleb128 0x27
	.4byte	.LASF31
	.byte	0x1
	.2byte	0x149
	.4byte	0x1bed
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x925
	.uleb128 0xe
	.4byte	0x53f
	.4byte	0x1c02
	.uleb128 0xf
	.4byte	0x150
	.byte	0x3
	.byte	0x0
	.uleb128 0x27
	.4byte	.LASF32
	.byte	0x1
	.2byte	0x14f
	.4byte	0x1bf2
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF33
	.byte	0x1
	.2byte	0x150
	.4byte	0x53f
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF34
	.byte	0x1
	.2byte	0x151
	.4byte	0x53f
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF35
	.byte	0x1
	.2byte	0x152
	.4byte	0x1c3a
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0xcef
	.uleb128 0x27
	.4byte	.LASF36
	.byte	0x1
	.2byte	0x153
	.4byte	0x1c3a
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF37
	.byte	0x1
	.2byte	0x154
	.4byte	0x53f
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF38
	.byte	0x1
	.2byte	0x15f
	.4byte	0x53f
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF39
	.byte	0x1
	.2byte	0x16a
	.4byte	0x534
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF40
	.byte	0x1
	.2byte	0x16b
	.4byte	0x1c85
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x3d5
	.uleb128 0x27
	.4byte	.LASF41
	.byte	0x1
	.2byte	0x16c
	.4byte	0x534
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF42
	.byte	0x1
	.2byte	0x16d
	.4byte	0x1ca6
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	0x3a3
	.uleb128 0x27
	.4byte	.LASF43
	.byte	0x1
	.2byte	0x16e
	.4byte	0x1c85
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF44
	.byte	0x1
	.2byte	0x16f
	.4byte	0x1ca6
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF45
	.byte	0x1
	.2byte	0x170
	.4byte	0x1ca6
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF46
	.byte	0x1
	.2byte	0x171
	.4byte	0x3c2
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF47
	.byte	0x1
	.2byte	0x172
	.4byte	0x1c85
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF48
	.byte	0x1
	.2byte	0x173
	.4byte	0x54d
	.byte	0x1
	.byte	0x1
	.uleb128 0x27
	.4byte	.LASF49
	.byte	0x1
	.2byte	0x178
	.4byte	0x1d0d
	.byte	0x1
	.byte	0x1
	.uleb128 0x17
	.4byte	0x534
	.uleb128 0x27
	.4byte	.LASF50
	.byte	0x1
	.2byte	0x182
	.4byte	0x534
	.byte	0x1
	.byte	0x1
	.uleb128 0x26
	.asciz	"SRbits"
	.byte	0x3
	.byte	0xa0
	.4byte	0x1bda
	.byte	0x1
	.byte	0x1
	.uleb128 0x28
	.4byte	.LASF31
	.byte	0x1
	.2byte	0x149
	.4byte	0x1bed
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxCurrentTCB
	.uleb128 0x28
	.4byte	.LASF32
	.byte	0x1
	.2byte	0x14f
	.4byte	0x1bf2
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxReadyTasksLists
	.uleb128 0x28
	.4byte	.LASF33
	.byte	0x1
	.2byte	0x150
	.4byte	0x53f
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedTaskList1
	.uleb128 0x28
	.4byte	.LASF34
	.byte	0x1
	.2byte	0x151
	.4byte	0x53f
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xDelayedTaskList2
	.uleb128 0x28
	.4byte	.LASF35
	.byte	0x1
	.2byte	0x152
	.4byte	0x1c3a
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxDelayedTaskList
	.uleb128 0x28
	.4byte	.LASF36
	.byte	0x1
	.2byte	0x153
	.4byte	0x1c3a
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_pxOverflowDelayedTaskList
	.uleb128 0x28
	.4byte	.LASF37
	.byte	0x1
	.2byte	0x154
	.4byte	0x53f
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xPendingReadyList
	.uleb128 0x28
	.4byte	.LASF38
	.byte	0x1
	.2byte	0x15f
	.4byte	0x53f
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xSuspendedTaskList
	.uleb128 0x28
	.4byte	.LASF39
	.byte	0x1
	.2byte	0x16a
	.4byte	0x534
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxCurrentNumberOfTasks
	.uleb128 0x28
	.4byte	.LASF40
	.byte	0x1
	.2byte	0x16b
	.4byte	0x1c85
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xTickCount
	.uleb128 0x28
	.4byte	.LASF41
	.byte	0x1
	.2byte	0x16c
	.4byte	0x534
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxTopReadyPriority
	.uleb128 0x28
	.4byte	.LASF42
	.byte	0x1
	.2byte	0x16d
	.4byte	0x1ca6
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xSchedulerRunning
	.uleb128 0x28
	.4byte	.LASF43
	.byte	0x1
	.2byte	0x16e
	.4byte	0x1c85
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xPendedTicks
	.uleb128 0x28
	.4byte	.LASF44
	.byte	0x1
	.2byte	0x16f
	.4byte	0x1ca6
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xYieldPending
	.uleb128 0x28
	.4byte	.LASF45
	.byte	0x1
	.2byte	0x170
	.4byte	0x1ca6
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xNumOfOverflows
	.uleb128 0x28
	.4byte	.LASF46
	.byte	0x1
	.2byte	0x171
	.4byte	0x3c2
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxTaskNumber
	.uleb128 0x28
	.4byte	.LASF47
	.byte	0x1
	.2byte	0x172
	.4byte	0x1c85
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xNextTaskUnblockTime
	.uleb128 0x28
	.4byte	.LASF48
	.byte	0x1
	.2byte	0x173
	.4byte	0x54d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_xIdleTaskHandle
	.uleb128 0x28
	.4byte	.LASF49
	.byte	0x1
	.2byte	0x178
	.4byte	0x1d0d
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxTopUsedPriority
	.uleb128 0x28
	.4byte	.LASF50
	.byte	0x1
	.2byte	0x182
	.4byte	0x534
	.byte	0x1
	.byte	0x5
	.byte	0x3
	.4byte	_uxSchedulerSuspended
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
	.uleb128 0x1a
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
	.uleb128 0x1d
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
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
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
	.uleb128 0x22
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
	.uleb128 0x23
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
	.uleb128 0x24
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
	.uleb128 0x25
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
	.uleb128 0x26
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
	.uleb128 0x27
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
	.uleb128 0x28
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
	.4byte	0x60e
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x1ead
	.4byte	0x7eb
	.asciz	"prvIdleTask"
	.4byte	0x840
	.asciz	"prvInitialiseNewTask"
	.4byte	0x93b
	.asciz	"vTaskPrioritySet"
	.4byte	0x9fe
	.asciz	"prvTaskIsTaskSuspended"
	.4byte	0xa6b
	.asciz	"vTaskResume"
	.4byte	0xac3
	.asciz	"xTaskResumeFromISR"
	.4byte	0xb3b
	.asciz	"vTaskEndScheduler"
	.4byte	0xb5d
	.asciz	"vTaskSuspendAll"
	.4byte	0xb7d
	.asciz	"xTaskGetTickCount"
	.4byte	0xbb9
	.asciz	"xTaskGetTickCountFromISR"
	.4byte	0xc05
	.asciz	"uxTaskGetNumberOfTasks"
	.4byte	0xc30
	.asciz	"pcTaskGetName"
	.4byte	0xc82
	.asciz	"vTaskSwitchContext"
	.4byte	0xcf5
	.asciz	"xTaskRemoveFromEventList"
	.4byte	0xdcd
	.asciz	"vTaskRemoveFromUnorderedEventList"
	.4byte	0xe8f
	.asciz	"vTaskSetTimeOutState"
	.4byte	0xed2
	.asciz	"vTaskInternalSetTimeOutState"
	.4byte	0xf12
	.asciz	"xTaskCheckForTimeOut"
	.4byte	0xfae
	.asciz	"vTaskMissedYield"
	.4byte	0xfcf
	.asciz	"prvInitialiseTaskLists"
	.4byte	0x1009
	.asciz	"prvAddNewTaskToReadyList"
	.4byte	0x105d
	.asciz	"xTaskCreate"
	.4byte	0x1103
	.asciz	"vTaskStartScheduler"
	.4byte	0x113a
	.asciz	"prvCheckTasksWaitingTermination"
	.4byte	0x116a
	.asciz	"prvResetNextTaskUnblockTime"
	.4byte	0x1196
	.asciz	"xTaskIncrementTick"
	.4byte	0x127d
	.asciz	"xTaskResumeAll"
	.4byte	0x1337
	.asciz	"xTaskCatchUpTicks"
	.4byte	0x1395
	.asciz	"vTaskSuspend"
	.4byte	0x13f2
	.asciz	"xTaskGetCurrentTaskHandle"
	.4byte	0x1433
	.asciz	"uxTaskResetEventItemValue"
	.4byte	0x1479
	.asciz	"xTaskGenericNotify"
	.4byte	0x155a
	.asciz	"xTaskGenericNotifyFromISR"
	.4byte	0x1678
	.asciz	"vTaskGenericNotifyGiveFromISR"
	.4byte	0x174b
	.asciz	"xTaskGenericNotifyStateClear"
	.4byte	0x17b9
	.asciz	"ulTaskGenericNotifyValueClear"
	.4byte	0x184a
	.asciz	"prvAddCurrentTaskToDelayedList"
	.4byte	0x18e5
	.asciz	"xTaskGenericNotifyWait"
	.4byte	0x19a1
	.asciz	"ulTaskGenericNotifyTake"
	.4byte	0x1a1d
	.asciz	"vTaskPlaceOnUnorderedEventList"
	.4byte	0x1a93
	.asciz	"vTaskPlaceOnEventList"
	.4byte	0x1ada
	.asciz	"vTaskDelay"
	.4byte	0x1b20
	.asciz	"xTaskDelayUntil"
	.4byte	0x1d30
	.asciz	"pxCurrentTCB"
	.4byte	0x1d43
	.asciz	"pxReadyTasksLists"
	.4byte	0x1d56
	.asciz	"xDelayedTaskList1"
	.4byte	0x1d69
	.asciz	"xDelayedTaskList2"
	.4byte	0x1d7c
	.asciz	"pxDelayedTaskList"
	.4byte	0x1d8f
	.asciz	"pxOverflowDelayedTaskList"
	.4byte	0x1da2
	.asciz	"xPendingReadyList"
	.4byte	0x1db5
	.asciz	"xSuspendedTaskList"
	.4byte	0x1dc8
	.asciz	"uxCurrentNumberOfTasks"
	.4byte	0x1ddb
	.asciz	"xTickCount"
	.4byte	0x1dee
	.asciz	"uxTopReadyPriority"
	.4byte	0x1e01
	.asciz	"xSchedulerRunning"
	.4byte	0x1e14
	.asciz	"xPendedTicks"
	.4byte	0x1e27
	.asciz	"xYieldPending"
	.4byte	0x1e3a
	.asciz	"xNumOfOverflows"
	.4byte	0x1e4d
	.asciz	"uxTaskNumber"
	.4byte	0x1e60
	.asciz	"xNextTaskUnblockTime"
	.4byte	0x1e73
	.asciz	"xIdleTaskHandle"
	.4byte	0x1e86
	.asciz	"uxTopUsedPriority"
	.4byte	0x1e99
	.asciz	"uxSchedulerSuspended"
	.4byte	0x0
	.section	.debug_pubtypes,info
	.4byte	0x195
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x1ead
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
	.4byte	0x164
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
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
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
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
	.4byte	.LFB30
	.4byte	.LFE30-.LFB30
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.4byte	.LFB32
	.4byte	.LFE32-.LFB32
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
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
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,info
.LASF9:
	.asciz	"xTask"
.LASF26:
	.asciz	"uxIndexToClear"
.LASF19:
	.asciz	"xConstTickCount"
.LASF2:
	.asciz	"pxIndex"
.LASF25:
	.asciz	"pxHigherPriorityTaskWoken"
.LASF0:
	.asciz	"xItemValue"
.LASF20:
	.asciz	"xAlreadyYielded"
.LASF24:
	.asciz	"ucOriginalNotifyState"
.LASF45:
	.asciz	"xNumOfOverflows"
.LASF28:
	.asciz	"xTicksToWait"
.LASF50:
	.asciz	"uxSchedulerSuspended"
.LASF21:
	.asciz	"xTaskToNotify"
.LASF47:
	.asciz	"xNextTaskUnblockTime"
.LASF46:
	.asciz	"uxTaskNumber"
.LASF42:
	.asciz	"xSchedulerRunning"
.LASF23:
	.asciz	"pulPreviousNotificationValue"
.LASF1:
	.asciz	"pxPrevious"
.LASF10:
	.asciz	"pxTCB"
.LASF11:
	.asciz	"xYieldRequired"
.LASF43:
	.asciz	"xPendedTicks"
.LASF44:
	.asciz	"xYieldPending"
.LASF7:
	.asciz	"pxCreatedTask"
.LASF48:
	.asciz	"xIdleTaskHandle"
.LASF37:
	.asciz	"xPendingReadyList"
.LASF8:
	.asciz	"pxNewTCB"
.LASF30:
	.asciz	"uxIndexToWait"
.LASF40:
	.asciz	"xTickCount"
.LASF18:
	.asciz	"pxTimeOut"
.LASF22:
	.asciz	"uxIndexToNotify"
.LASF12:
	.asciz	"xReturn"
.LASF49:
	.asciz	"uxTopUsedPriority"
.LASF13:
	.asciz	"xTaskToResume"
.LASF4:
	.asciz	"uxPriority"
.LASF32:
	.asciz	"pxReadyTasksLists"
.LASF15:
	.asciz	"pxEventList"
.LASF41:
	.asciz	"uxTopReadyPriority"
.LASF6:
	.asciz	"pxTaskCode"
.LASF27:
	.asciz	"ulReturn"
.LASF29:
	.asciz	"xTimeToWake"
.LASF33:
	.asciz	"xDelayedTaskList1"
.LASF34:
	.asciz	"xDelayedTaskList2"
.LASF5:
	.asciz	"pvParameters"
.LASF31:
	.asciz	"pxCurrentTCB"
.LASF39:
	.asciz	"uxCurrentNumberOfTasks"
.LASF3:
	.asciz	"pxTopOfStack"
.LASF14:
	.asciz	"uxSavedInterruptStatus"
.LASF35:
	.asciz	"pxDelayedTaskList"
.LASF16:
	.asciz	"pxUnblockedTCB"
.LASF17:
	.asciz	"pxList"
.LASF38:
	.asciz	"xSuspendedTaskList"
.LASF36:
	.asciz	"pxOverflowDelayedTaskList"
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
