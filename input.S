.text
.global _start
@ as -o my.o 003.S
@ ld -o my my.o
@ ./my
_start:
		ldr r0,_adds
		ldr r3,_puts
		blx r3
		ldr r0,_adds3
		ldr r2,_filesp
		mov r1,#2
		ldr r3,_open
		blx r3
		mov r4,r0
		push {r4}
		mov r1,r4
		ldr r0,_adds2
		ldr r3,_getkey
		blx r3
		pop {r4}
		ldr r3,_adds2
		ldr r0,[r3]
		ldr r3,_inkey
		str r0,[r3]
	fors:
		push {r4}
		mov r1,r4
		ldr r0,_adds2
		ldr r3,_getkey
		blx r3
		pop {r4}
		ldr r3,_adds2
		ldr r0,[r3]
		ldr r2,_inkey
		ldr r1,[r2]
		cmp r1,r0
		beq fors
	forss:
		push {r4}
		ldr r0,_adds2
		ldr r3,_puts
		blx r3
		pop {r4}
		mov r0,r4
		ldr r3,_close
		blx r3
		
_exit:
	mov r7, #1              
	swi #0                  
_lens:
	@ r1=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r0,#0
	mov r3,r1
	lenss:
		ldrb r1,[r3]
		cmp r1,#0
		beq lensss
		add r3,r3,#1
		add r0,r0,#1
		b lenss 
	lensss:
	sub sp,fp,#4
	pop {fp,pc}
_putss:
	@ r0=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r7,r0
	mov r1,r0	
	ldr r3,_len
	blx r3
	mov r2,r0
	mov r0, #1            
	mov r1,r7
	mov r7, #4              
	swi #0                  
	sub sp,fp,#4
	pop {fp,pc}
_putcc:
	@ r0=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r1,r0
	mov r2, #1
	mov r0, #1            
	mov r7, #4              
	swi #0                  
	sub sp,fp,#4
	pop {fp,pc}
	
_strcpys:
	@ r0=string
	@ r1=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r3,r0
	mov r2,r1
	_strcpyss:
		ldrb r1,[r3]
		strb r1,[r2]
		cmp r1,#0
		beq _strcpysss
		add r3,r3,#1
		add r2,r2,#1
		b _strcpyss
	_strcpysss:
	sub sp,fp,#4
	pop {fp,pc}


_intdivs:
	@ r0=number1
	@ r1=number2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r2,#0
	_intdivs2:
		cmp r0,r1
		blt _intdivs3
		sub r0,r0,r1
		add r2,r2,#1
		cmp r0,r1
		bal _intdivs2
	_intdivs3:
	mov r1,r0
	mov r0,r2
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	sub sp,fp,#4
	pop {fp,pc}
_strs:
	@ r0=adds
	@ r1=number
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r3,r0
	mov r4,r1
	ldr r5,_divnn
	_strs2:
		mov r0,r4
		ldr r1,[r5]
		ldr r2,_intdiv
		blx r2
		mov r4,r1
		add r0,r0,#48
		str r0,[r3]
		add r3,r3,#1
		ldr r1,[r5]
		cmp r1,#1
		beq _strs3
		add r5,r5,#4
		bal _strs2
	_strs3:
	mov r0,#0
	str r0,[r3]
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_lcases:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	lcases2:
			ldrb r1,[r0]
			cmp r1,#65
			blt lcases4
			cmp r1,#90
			bgt lcases4
			add r1,r1,#32
			strb r1,[r0]
		lcases4:
		cmp r1,#0
		beq lcases3
		add r0,r0,#1
		bal lcases2
	lcases3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_ucases:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	ucases2:
			ldrb r1,[r0]
			cmp r1,#97
			blt ucases4
			cmp r1,#122
			bgt ucases4
			sub r1,r1,#32
			strb r1,[r0]
		ucases4:
		cmp r1,#0
		beq ucases3
		add r0,r0,#1
		bal ucases2
	ucases3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_strcats:
	@ r0=string
	@ r1=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r7,r0
	mov r5,r1
	ldr r6,_len
	blx r6
	add r1,r5,r0
	mov r0,r7
	ldr r6,_strcpy
	blx r6
	sub sp,fp,#4
	pop {fp,pc}
_fills:
	@ r1=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r3,r0
	fillss:
		strb r1,[r3]
		add r3,r3,#1
		sub r2,r2,#1
		cmp r2,#0
		bne fillss
	fillsss:
	sub sp,fp,#4
	pop {fp,pc}
_findchars:
	@ r0=adds
	@ r1=chr
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r3,#0
	_findchars2:
		ldrb r4,[r0]
		cmp r4,r1
		bne _findchars4
		mov r0,r3
		b _findchars3
		_findchars4:
		cmp r4,#0
		beq _findchars5
		add r0,r0,#1
		add r3,r3,#1
		b _findchars2
		_findchars5:
		mov r0,#0
		sub r0,r0,#1
	_findchars3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_comps:
	@ r0=string1
	@ r1=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	_comps2:
		ldrb r3,[r0]
		ldrb r4,[r1]
		add r0,r0,#1
		add r1,r1,#1
		cmp r4,#0
		beq _comps4
		cmp r3,r4
		beq _comps2
		mov r0,#0
		sub r0,r0,#1
		b _comps3
		_comps4:
		mov r0,#0
	_comps3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_findstrs:
	@ r0=adds
	@ r1=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7,#0
	mov r3,r0
	mov r4,r1
	mov r6,#0
	sub r6,r6,#1
	_findstrs2:
		ldrb r1,[r4]
		ldr r5,_findchar
		blx r5
		cmp r0,r6
		beq _findstrs6
		add r3,r3,r0
		add r7,r7,r0
		mov r0,r3
		mov r1,r4
		ldr r5,_comp
		blx r5
		cmp r0,#0
		beq _findstrs7
		add r3,r3,#1
		mov r0,r3
		add r7,r7,#1
		b _findstrs2
		_findstrs6:
		mov r0,r6
		b _findstrs3
		_findstrs7:
		mov r0,r7
		b _findstrs3
	_findstrs3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
getkeys:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r4,r1
	mov r1,r0
	mov r2,#1
	mov r0,r4
	mov r7, #3              
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_creates:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7, #8
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_opens:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7, #5
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_closes:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7, #6
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_writes:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7, #4
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_reads:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7, #3
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}

.word _reads
_write:
.word _writes
_close:
.word _closes
_open:
.word _opens
_create:
.word _creates
_getkey:
.word getkeys
_findstr:
.word _findstrs
_comp:
.word _comps
_findchar:
.word _findchars
_fill:
.word _fills
_strcat:
.word _strcats
_lcase:
.word _lcases
_ucase:
.word _ucases
_divnn:
.word _divn
_divn:
.word 100000000,10000000,1000000,100000,10000,1000,100,10,1
_str:
.word _strs
_intdiv:
.word _intdivs
_strcpy:
.word _strcpys
_puts:
.word _putss 
_putc:
.word _putcc
_len:
.word _lens 
_adds:
.word _string
_adds2:
.word _string2
_adds3:
.word _string3
_adds4:
.word _string4
_inkey:
.word _inkeys
_filesp:
.word 511
.data
_inkeys:
.asciz "\0\0\0\0\0\0\0\0\0\0\0 \n\n\n\0\0--------------------------------\0"
_string:
.asciz "\033[42;30m\npress a key then enter\n\n\0"
_string2:
.asciz " \n\n\n\0\0--------------------------------\0"
_string3:
.asciz "/dev/stdin\0--------------------------------\0"
_string4:
.asciz "\033[42;30m\nlike\n\n\0"
