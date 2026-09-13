	.file	"mouse.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.type	mouse_wait.part.0, @function
mouse_wait.part.0:
.LFB10:
	.cfi_startproc
	movl	$100000, %edx
	jmp	.L5
	.align 4
.L11:
	decl	%edx
	je	.L1
.L5:
/APP
/  11 "src/mouse.c" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	testb	$2, %al
	jne	.L11
.L1:
	ret
	.cfi_endproc
.LFE10:
	.size	mouse_wait.part.0, .-mouse_wait.part.0
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	mouse_init
	.type	mouse_init, @function
mouse_init:
.LFB5:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	mouse_wait.part.0
	movb	$-88, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $100
/  0 "" 2
/NO_APP
	call	mouse_wait.part.0
	movb	$32, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $100
/  0 "" 2
/NO_APP
	movl	$100000, %edx
	jmp	.L14
	.align 4
.L25:
	decl	%edx
	je	.L13
.L14:
/APP
/  11 "src/mouse.c" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	testb	$1, %al
	je	.L25
.L13:
/APP
/  11 "src/mouse.c" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	andl	$-33, %eax
	movb	%al, %cl
	call	mouse_wait.part.0
	movb	$96, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $100
/  0 "" 2
/NO_APP
	call	mouse_wait.part.0
	movb	%cl, %al
	orl	$2, %eax
/APP
/  15 "src/mouse.c" 1
	outb %al, $96
/  0 "" 2
/NO_APP
	call	mouse_wait.part.0
	movb	$-44, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $100
/  0 "" 2
/NO_APP
	call	mouse_wait.part.0
	movb	$-10, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $96
/  0 "" 2
/NO_APP
	movl	$100000, %edx
	jmp	.L16
	.align 4
.L26:
	decl	%edx
	je	.L15
.L16:
/APP
/  11 "src/mouse.c" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	testb	$1, %al
	je	.L26
.L15:
/APP
/  11 "src/mouse.c" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	call	mouse_wait.part.0
	movb	$-44, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $100
/  0 "" 2
/NO_APP
	call	mouse_wait.part.0
	movb	$-12, %al
/APP
/  15 "src/mouse.c" 1
	outb %al, $96
/  0 "" 2
/NO_APP
	movl	$100000, %edx
	jmp	.L18
	.align 4
.L27:
	decl	%edx
	je	.L17
.L18:
/APP
/  11 "src/mouse.c" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	testb	$1, %al
	je	.L27
.L17:
/APP
/  11 "src/mouse.c" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	call	gfx_width
	cmpl	s_x, %eax
	jle	.L28
.L19:
	call	gfx_height
	cmpl	s_y, %eax
	jg	.L12
	call	gfx_height
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, s_y
.L12:
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L28:
	.cfi_restore_state
	call	gfx_width
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, s_x
	jmp	.L19
	.cfi_endproc
.LFE5:
	.size	mouse_init, .-mouse_init
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	mouse_poll
	.type	mouse_poll, @function
mouse_poll:
.LFB6:
	.cfi_startproc
/APP
/  11 "src/mouse.c" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	andl	$33, %eax
	cmpb	$33, %al
	je	.L43
.L42:
	ret
	.align 4
.L43:
/APP
/  11 "src/mouse.c" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	movl	packet_idx, %ecx
	leal	1(%ecx), %edx
	movl	%edx, packet_idx
	movb	%al, packet(%ecx)
	cmpl	$2, %edx
	jle	.L42
	movl	$0, packet_idx
	movb	packet, %al
	testb	$8, %al
	je	.L42
	testb	$-64, %al
	jne	.L42
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	andl	$1, %eax
	movl	%eax, s_left
	movsbl	packet+2, %eax
	movsbl	packet+1, %edx
	addl	s_x, %edx
	movl	%edx, s_x
	movl	s_y, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%ecx, s_y
	testl	%edx, %edx
	js	.L44
.L33:
	testl	%eax, %eax
	js	.L45
.L34:
	call	gfx_width
	cmpl	s_x, %eax
	jle	.L46
.L35:
	call	gfx_height
	movl	s_y, %edx
	cmpl	%edx, %eax
	jle	.L47
.L36:
	pushl	%eax
	.cfi_def_cfa_offset 20
	pushl	s_left
	.cfi_def_cfa_offset 24
	pushl	%edx
	.cfi_def_cfa_offset 28
	pushl	s_x
	.cfi_def_cfa_offset 32
	call	gui_on_mouse_update
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L46:
	.cfi_def_cfa_offset 16
	call	gfx_width
	decl	%eax
	movl	%eax, s_x
	jmp	.L35
	.align 4
.L47:
	call	gfx_height
	leal	-1(%eax), %edx
	movl	%edx, s_y
	jmp	.L36
	.align 4
.L45:
	movl	$0, s_y
	jmp	.L34
	.align 4
.L44:
	movl	$0, s_x
	jmp	.L33
	.cfi_endproc
.LFE6:
	.size	mouse_poll, .-mouse_poll
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.globl	mouse_get_x
	.type	mouse_get_x, @function
mouse_get_x:
.LFB7:
	.cfi_startproc
	movl	s_x, %eax
	ret
	.cfi_endproc
.LFE7:
	.size	mouse_get_x, .-mouse_get_x
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.globl	mouse_get_y
	.type	mouse_get_y, @function
mouse_get_y:
.LFB8:
	.cfi_startproc
	movl	s_y, %eax
	ret
	.cfi_endproc
.LFE8:
	.size	mouse_get_y, .-mouse_get_y
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.globl	mouse_get_left_button
	.type	mouse_get_left_button, @function
mouse_get_left_button:
.LFB9:
	.cfi_startproc
	movl	s_left, %eax
	ret
	.cfi_endproc
.LFE9:
	.size	mouse_get_left_button, .-mouse_get_left_button
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.local	s_left
	.comm	s_left,4,4
	.data
	.align 4
	.type	s_y, @object
	.size	s_y, 4
s_y:
	.long	300
	.align 4
	.type	s_x, @object
	.size	s_x, 4
s_x:
	.long	400
	.local	packet_idx
	.comm	packet_idx,4,4
	.local	packet
	.comm	packet,3,1
	.ident	"GCC: (GNU) 5.2.0"
