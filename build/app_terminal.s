	.file	"app_terminal.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.type	io_clear, @function
io_clear:
.LFB8:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	64088(%eax), %edx
	movl	%edx, 64084(%eax)
	movl	$0, 64096(%eax)
	ret
	.cfi_endproc
.LFE8:
	.size	io_clear, .-io_clear
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.type	io_exit, @function
io_exit:
.LFB9:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	$1, 67780(%eax)
	ret
	.cfi_endproc
.LFE9:
	.size	io_exit, .-io_exit
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.type	on_close, @function
on_close:
.LFB29:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	72(%eax), %eax
	movl	$0, (%eax)
	ret
	.cfi_endproc
.LFE29:
	.size	on_close, .-on_close
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.align 4
	.type	view_top, @function
view_top:
.LFB11:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$16, %esp
	.cfi_def_cfa_offset 28
	movl	%eax, %ebx
	movl	64088(%eax), %esi
	addl	$64100, %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strlen
	addl	64364(%ebx), %eax
	movl	%eax, %ecx
	movl	$1717986919, %eax
	imull	%ecx
	movl	%edx, %eax
	sarl	$5, %eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	leal	-27(%esi,%eax), %eax
	movl	64084(%ebx), %edx
	subl	64096(%ebx), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	%edx, %eax
	jge	.L5
	movl	%edx, %eax
.L5:
	popl	%edx
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE11:
	.size	view_top, .-view_top
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.type	max_scroll, @function
max_scroll:
.LFB12:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$16, %esp
	.cfi_def_cfa_offset 28
	movl	%eax, %ebx
	movl	64088(%eax), %esi
	addl	$64100, %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strlen
	addl	64364(%ebx), %eax
	movl	%eax, %ecx
	movl	$1717986919, %eax
	imull	%ecx
	movl	%edx, %eax
	sarl	$5, %eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	leal	1(%esi,%eax), %eax
	subl	64084(%ebx), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$28, %eax
	jle	.L10
	subl	$28, %eax
	popl	%edx
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L10:
	.cfi_restore_state
	xorl	%eax, %eax
	popl	%edx
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE12:
	.size	max_scroll, .-max_scroll
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.type	insert, @function
insert:
.LFB16:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	movl	%eax, %ebx
	movl	64364(%eax), %eax
	testl	%ecx, %ecx
	jle	.L14
	cmpl	$198, %eax
	jg	.L14
	movl	64368(%ebx), %esi
	leal	64164(%ebx), %edi
	movl	%edx, %ebp
	leal	-1(%edx,%ecx), %edx
	movl	%edx, 12(%esp)
	jmp	.L15
	.align 4
.L18:
	incl	%ebp
	cmpl	$198, %eax
	jg	.L14
.L15:
	pushl	%edx
	.cfi_def_cfa_offset 52
	subl	%esi, %eax
	pushl	%eax
	.cfi_def_cfa_offset 56
	leal	(%edi,%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 60
	leal	1(%edi,%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	memmove
	movl	64368(%ebx), %eax
	leal	1(%eax), %esi
	movl	%esi, 64368(%ebx)
	movb	0(%ebp), %dl
	movb	%dl, 64164(%ebx,%eax)
	movl	64364(%ebx), %eax
	incl	%eax
	movl	%eax, 64364(%ebx)
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	cmpl	12(%esp), %ebp
	jne	.L18
.L14:
	movb	$0, 64164(%ebx,%eax)
	addl	$28, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE16:
	.size	insert, .-insert
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.type	cursor_cell.part.2, @function
cursor_cell.part.2:
.LFB33:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$40, %esp
	.cfi_def_cfa_offset 60
	movl	%eax, %edi
	movl	%edx, 20(%esp)
	movl	%ecx, 24(%esp)
	addl	$64100, %eax
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	strlen
	addl	64368(%edi), %eax
	movl	%eax, %esi
	movl	$1717986919, %eax
	imull	%esi
	sarl	$5, %edx
	movl	%esi, %eax
	sarl	$31, %eax
	movl	%edx, %ebp
	subl	%eax, %ebp
	movl	64088(%edi), %ebx
	addl	%ebp, %ebx
	movl	%edi, %eax
	call	view_top
	subl	%eax, %ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	cmpl	$27, %ebx
	ja	.L21
	leal	0(%ebp,%ebp,4), %eax
	sall	$4, %eax
	subl	%eax, %esi
	leal	4(,%esi,8), %eax
	movl	8(%esp), %edx
	movl	%eax, (%edx)
	leal	(%ebx,%ebx), %eax
	addl	%eax, %ebx
	leal	4(,%ebx,4), %eax
	movl	12(%esp), %ecx
	movl	%eax, (%ecx)
	movl	$1, %eax
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L21:
	.cfi_restore_state
	xorl	%eax, %eax
	addl	$28, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE33:
	.size	cursor_cell.part.2, .-cursor_cell.part.2
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.type	tick, @function
tick:
.LFB28:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$32, %esp
	.cfi_def_cfa_offset 44
	movl	44(%esp), %ebx
	movl	72(%ebx), %esi
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	gui_is_focused
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	je	.L23
	movl	36(%esp), %eax
	subl	67788(%esi), %eax
	cmpl	$499, %eax
	ja	.L36
.L23:
	addl	$20, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L36:
	.cfi_restore_state
	movl	36(%esp), %eax
	movl	%eax, 67788(%esi)
	xorl	%eax, %eax
	movl	67784(%esi), %edx
	testl	%edx, %edx
	sete	%al
	movl	%eax, 67784(%esi)
	movl	64096(%esi), %ecx
	testl	%ecx, %ecx
	jne	.L23
	leal	12(%esp), %ecx
	leal	8(%esp), %edx
	movl	%esi, %eax
	call	cursor_cell.part.2
	testl	%eax, %eax
	je	.L23
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$12
	.cfi_def_cfa_offset 48
	pushl	$8
	.cfi_def_cfa_offset 52
	pushl	32(%esp)
	.cfi_def_cfa_offset 56
	pushl	32(%esp)
	.cfi_def_cfa_offset 60
	pushl	%ebx
	.cfi_def_cfa_offset 64
	call	gui_invalidate_client
	addl	$32, %esp
	.cfi_def_cfa_offset 32
	jmp	.L23
	.cfi_endproc
.LFE28:
	.size	tick, .-tick
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.text.unlikely
.LCOLDB12:
	.text
.LHOTB12:
	.align 4
	.type	paint, @function
paint:
.LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$72, %esp
	.cfi_def_cfa_offset 92
	movl	92(%esp), %eax
	movl	72(%eax), %esi
	pushl	$330510
	.cfi_def_cfa_offset 96
	pushl	112(%esp)
	.cfi_def_cfa_offset 100
	pushl	112(%esp)
	.cfi_def_cfa_offset 104
	pushl	112(%esp)
	.cfi_def_cfa_offset 108
	pushl	112(%esp)
	.cfi_def_cfa_offset 112
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 80
	movl	%esi, %eax
	call	view_top
	movl	%eax, %edi
	leal	64100(%esi), %ebp
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebp
	.cfi_def_cfa_offset 96
	call	strlen
	movl	%eax, 28(%esp)
	movl	64088(%esi), %ebx
	movl	%ebp, (%esp)
	call	strlen
	addl	64364(%esi), %eax
	movl	%eax, %ecx
	movl	$1717986919, %eax
	imull	%ecx
	movl	%edx, %eax
	sarl	$5, %eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	leal	1(%ebx,%eax), %eax
	movl	%eax, 40(%esp)
	movl	%edi, 24(%esp)
	movl	104(%esp), %eax
	addl	$4, %eax
	movl	%eax, 36(%esp)
	movl	104(%esp), %eax
	addl	$340, %eax
	movl	%eax, 44(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	.align 4
.L42:
	movl	8(%esp), %ebx
	cmpl	%ebx, 24(%esp)
	jle	.L43
	pushl	$12
	.cfi_def_cfa_offset 84
	pushl	96(%esp)
	.cfi_def_cfa_offset 88
	pushl	28(%esp)
	.cfi_def_cfa_offset 92
	pushl	96(%esp)
	.cfi_def_cfa_offset 96
	call	gfx_visible
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	je	.L51
	movl	84(%esp), %eax
	leal	4(%eax), %ebx
	movl	8(%esp), %eax
	movl	$400, %edi
	cltd
	idivl	%edi
	leal	(%edx,%edx,4), %eax
	sall	$4, %eax
	leal	84(%esi,%eax), %edi
	xorl	%ebp, %ebp
	movl	20(%esp), %eax
	addl	$2, %eax
	movl	%eax, 16(%esp)
	movl	%esi, %eax
	movl	%ebx, %esi
	movl	%eax, %ebx
	jmp	.L50
	.align 4
.L70:
	movsbl	(%edi), %eax
	movzbl	32000(%edi), %edx
	cmpb	$32, %al
	je	.L46
	decl	%edx
	cmpl	$3, %edx
	jbe	.L68
.L56:
	movl	$11194321, %edx
.L49:
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	%edx
	.cfi_def_cfa_offset 100
	pushl	%eax
	.cfi_def_cfa_offset 104
	pushl	40(%esp)
	.cfi_def_cfa_offset 108
	pushl	%esi
	.cfi_def_cfa_offset 112
	call	gfx_char
	addl	$32, %esp
	.cfi_def_cfa_offset 80
.L46:
	incl	%ebp
	addl	$8, %esi
	incl	%edi
	cmpl	$80, %ebp
	je	.L69
.L50:
	movl	64088(%ebx), %eax
	cmpl	%eax, 8(%esp)
	jl	.L70
	movl	8(%esp), %ecx
	subl	%eax, %ecx
	leal	(%ecx,%ecx,4), %eax
	sall	$4, %eax
	addl	%ebp, %eax
	cmpl	%eax, 12(%esp)
	jle	.L47
	movsbl	64100(%ebx,%eax), %eax
	cmpb	$32, %al
	je	.L46
	movl	$14021621, %edx
	jmp	.L49
	.align 4
.L47:
	subl	12(%esp), %eax
	cmpl	64364(%ebx), %eax
	jge	.L46
	movsbl	64164(%ebx,%eax), %eax
	cmpb	$32, %al
	jne	.L56
	incl	%ebp
	addl	$8, %esi
	incl	%edi
	cmpl	$80, %ebp
	jne	.L50
	.align 4
.L69:
	movl	%ebx, %esi
.L51:
	incl	8(%esp)
	addl	$12, 20(%esp)
	movl	20(%esp), %eax
	cmpl	%eax, 28(%esp)
	jne	.L42
.L43:
	movl	64096(%esi), %edx
	testl	%edx, %edx
	je	.L71
.L37:
	addl	$60, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L68:
	.cfi_restore_state
	movl	CSWTCH.24(,%edx,4), %edx
	jmp	.L49
.L71:
	leal	44(%esp), %ecx
	leal	40(%esp), %edx
	movl	%esi, %eax
	call	cursor_cell.part.2
	testl	%eax, %eax
	je	.L37
	movl	84(%esp), %eax
	addl	%eax, 40(%esp)
	movl	88(%esp), %eax
	addl	%eax, 44(%esp)
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	92(%esp)
	.cfi_def_cfa_offset 96
	call	gui_is_focused
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	je	.L53
	movl	67784(%esi), %eax
	testl	%eax, %eax
	je	.L37
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	$14021621
	.cfi_def_cfa_offset 96
	pushl	$12
	.cfi_def_cfa_offset 100
	pushl	$8
	.cfi_def_cfa_offset 104
	pushl	68(%esp)
	.cfi_def_cfa_offset 108
	pushl	68(%esp)
	.cfi_def_cfa_offset 112
	call	gfx_fill_rect
	movl	64368(%esi), %eax
	addl	$32, %esp
	.cfi_def_cfa_offset 80
	cmpl	64364(%esi), %eax
	jge	.L37
	movsbl	64164(%esi,%eax), %eax
	cmpb	$32, %al
	je	.L37
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$330510
	.cfi_def_cfa_offset 100
	pushl	%eax
	.cfi_def_cfa_offset 104
	movl	68(%esp), %eax
	addl	$2, %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	pushl	68(%esp)
	.cfi_def_cfa_offset 112
	call	gfx_char
	addl	$32, %esp
	.cfi_def_cfa_offset 80
	jmp	.L37
.L53:
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	$14021621
	.cfi_def_cfa_offset 96
	pushl	$12
	.cfi_def_cfa_offset 100
	pushl	$8
	.cfi_def_cfa_offset 104
	pushl	68(%esp)
	.cfi_def_cfa_offset 108
	pushl	68(%esp)
	.cfi_def_cfa_offset 112
	call	gfx_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 80
	addl	$60, %esp
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE27:
	.size	paint, .-paint
	.section	.text.unlikely
.LCOLDE12:
	.text
.LHOTE12:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Paste"
.LC1:
	.string	"Clear"
.LC2:
	.string	"New Terminal"
	.section	.rodata
	.align 32
.LC13:
	.long	.LC0
	.long	-1
	.long	1
	.long	.LC1
	.long	-1
	.long	2
	.long	.LC2
	.long	0
	.long	3
	.section	.text.unlikely
.LCOLDB14:
	.text
.LHOTB14:
	.align 4
	.type	on_mouse, @function
on_mouse:
.LFB24:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subl	$48, %esp
	.cfi_def_cfa_offset 64
	movl	68(%esp), %edx
	movl	(%edx), %eax
	cmpl	$3, %eax
	je	.L79
	cmpl	$5, %eax
	je	.L80
	addl	$48, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L80:
	.cfi_restore_state
	leal	12(%esp), %edi
	movl	$.LC13, %esi
	movl	$9, %ecx
	rep movsl
	subl	$8, %esp
	.cfi_def_cfa_offset 72
	pushl	72(%esp)
	.cfi_def_cfa_offset 76
	pushl	$ctx_cb
	.cfi_def_cfa_offset 80
	pushl	$3
	.cfi_def_cfa_offset 84
	leal	32(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 88
	movl	88(%esp), %eax
	movl	8(%eax), %ecx
	movl	8(%edx), %eax
	leal	21(%ecx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 92
	movl	92(%esp), %eax
	movl	4(%eax), %ecx
	movl	4(%edx), %eax
	leal	1(%ecx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	gui_popup
	addl	$32, %esp
	.cfi_def_cfa_offset 64
	addl	$48, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L79:
	.cfi_restore_state
	movl	64(%esp), %eax
	movl	72(%eax), %esi
	movl	16(%edx), %eax
	leal	(%eax,%eax), %ebx
	addl	%ebx, %eax
	addl	64096(%esi), %eax
	movl	%eax, %ebx
	movl	%esi, %eax
	call	max_scroll
	testl	%ebx, %ebx
	js	.L77
	movl	%ebx, %edx
	cmpl	%eax, %ebx
	jle	.L74
	movl	%eax, %edx
.L74:
	movl	%edx, 64096(%esi)
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	pushl	4(%esi)
	.cfi_def_cfa_offset 80
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	addl	$48, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L77:
	.cfi_restore_state
	xorl	%edx, %edx
	jmp	.L74
	.cfi_endproc
.LFE24:
	.size	on_mouse, .-on_mouse
	.section	.text.unlikely
.LCOLDE14:
	.text
.LHOTE14:
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.align 4
	.type	newline, @function
newline:
.LFB4:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$8, %esp
	.cfi_def_cfa_offset 20
	movl	%eax, %ebx
	movl	$0, 64092(%eax)
	movl	64088(%eax), %eax
	incl	%eax
	movl	%eax, 64088(%ebx)
	movl	$400, %ecx
	cltd
	idivl	%ecx
	movl	%edx, %esi
	pushl	$80
	.cfi_def_cfa_offset 24
	pushl	$32
	.cfi_def_cfa_offset 28
	leal	5(%edx,%edx,4), %eax
	sall	$4, %eax
	leal	4(%ebx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	memset
	addl	$12, %esp
	.cfi_def_cfa_offset 20
	pushl	$80
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	leal	(%esi,%esi,4), %eax
	sall	$4, %eax
	leal	32084(%ebx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	memset
	movl	64088(%ebx), %eax
	movl	%eax, %edx
	subl	64084(%ebx), %edx
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	$399, %edx
	jle	.L81
	subl	$399, %eax
	movl	%eax, 64084(%ebx)
.L81:
	popl	%eax
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE4:
	.size	newline, .-newline
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.align 4
	.type	put, @function
put:
.LFB5:
	.cfi_startproc
	cmpb	$10, %dl
	je	.L94
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	movl	%ecx, %esi
	movl	%edx, %ecx
	movl	%eax, %ebx
	cmpb	$9, %dl
	je	.L91
	leal	-32(%edx), %eax
	cmpb	$94, %al
	ja	.L84
	movl	64092(%ebx), %edi
	cmpl	$79, %edi
	jg	.L95
.L90:
	movl	64088(%ebx), %eax
	movl	$400, %ebp
	cltd
	idivl	%ebp
	leal	(%edx,%edx,4), %eax
	sall	$4, %eax
	addl	%ebx, %eax
	addl	%edi, %eax
	movb	%cl, 84(%eax)
	movl	%esi, %edx
	movb	%dl, 32084(%eax)
	incl	%edi
	movl	%edi, 64092(%ebx)
.L84:
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L91:
	.cfi_restore_state
	movl	%esi, %ecx
	movl	$32, %edx
	movl	%ebx, %eax
	call	put
	testb	$3, 64092(%ebx)
	jne	.L91
	jmp	.L84
	.align 4
.L95:
	movl	%edx, 12(%esp)
	movl	%ebx, %eax
	call	newline
	movl	64092(%ebx), %edi
	movl	12(%esp), %ecx
	jmp	.L90
	.align 4
.L94:
	.cfi_def_cfa_offset 4
	.cfi_restore 3
	.cfi_restore 5
	.cfi_restore 6
	.cfi_restore 7
	jmp	newline
	.cfi_endproc
.LFE5:
	.size	put, .-put
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.align 4
	.type	commit_line, @function
commit_line:
.LFB18:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	pushl	%edx
	.cfi_def_cfa_offset 16
	movl	%eax, %ebx
	movsbl	64100(%eax), %edx
	leal	64100(%eax), %esi
	testb	%dl, %dl
	je	.L101
	.align 4
.L104:
	incl	%esi
	movl	$2, %ecx
	movl	%ebx, %eax
	call	put
	movsbl	(%esi), %edx
	testb	%dl, %dl
	jne	.L104
.L101:
	movl	64364(%ebx), %eax
	movb	$0, 64164(%ebx,%eax)
	leal	64164(%ebx), %esi
	movsbl	64164(%ebx), %edx
	testb	%dl, %dl
	je	.L96
	.align 4
.L103:
	incl	%esi
	xorl	%ecx, %ecx
	movl	%ebx, %eax
	call	put
	movsbl	(%esi), %edx
	testb	%dl, %dl
	jne	.L103
.L96:
	popl	%eax
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE18:
	.size	commit_line, .-commit_line
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.align 4
	.type	io_out, @function
io_out:
.LFB7:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	16(%esp), %edi
	movl	20(%esp), %ebx
	movl	24(%esp), %esi
	movsbl	(%ebx), %edx
	testb	%dl, %dl
	je	.L109
	.align 4
.L113:
	incl	%ebx
	movl	%esi, %ecx
	movl	%edi, %eax
	call	put
	movsbl	(%ebx), %edx
	testb	%dl, %dl
	jne	.L113
.L109:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE7:
	.size	io_out, .-io_out
	.section	.text.unlikely
.LCOLDE18:
	.text
.LHOTE18:
	.section	.text.unlikely
.LCOLDB19:
	.text
.LHOTB19:
	.align 4
	.type	make_prompt, @function
make_prompt:
.LFB14:
	.cfi_startproc
	subl	$32, %esp
	.cfi_def_cfa_offset 36
	pushl	$64
	.cfi_def_cfa_offset 40
	leal	64100(%eax), %edx
	pushl	%edx
	.cfi_def_cfa_offset 44
	leal	8(%eax), %edx
	movl	%eax, 24(%esp)
	pushl	%edx
	.cfi_def_cfa_offset 48
	call	shell_prompt
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	12(%esp), %eax
	movl	64092(%eax), %edx
	testl	%edx, %edx
	jne	.L119
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L119:
	.cfi_restore_state
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	jmp	newline
	.cfi_endproc
.LFE14:
	.size	make_prompt, .-make_prompt
	.section	.text.unlikely
.LCOLDE19:
	.text
.LHOTE19:
	.section	.rodata.str1.1
.LC20:
	.string	"^C"
	.section	.text.unlikely
.LCOLDB21:
	.text
.LHOTB21:
	.align 4
	.type	on_key, @function
on_key:
.LFB22:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$220, %esp
	.cfi_def_cfa_offset 240
	movl	244(%esp), %ebp
	movl	240(%esp), %eax
	movl	72(%eax), %esi
	movb	2(%ebp), %bl
	andl	$2, %ebx
	movw	0(%ebp), %ax
	leal	-262(%eax), %edi
	movl	$1, 67784(%esi)
	call	timer_ms
	movl	%eax, 67788(%esi)
	cmpw	$1, %di
	jbe	.L121
	movl	$0, 64096(%esi)
.L121:
	testb	%bl, %bl
	je	.L122
	movw	0(%ebp), %ax
	subl	$97, %eax
	cmpw	$21, %ax
	ja	.L156
	movzwl	%ax, %eax
	jmp	*.L125(,%eax,4)
	.section	.rodata
	.align 4
	.align 4
.L125:
	.long	.L147
	.long	.L156
	.long	.L126
	.long	.L156
	.long	.L148
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L128
	.long	.L129
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L156
	.long	.L130
	.long	.L131
	.text
	.align 4
.L140:
	cmpw	$257, %ax
	jne	.L185
	movl	67576(%esi), %eax
	movl	67572(%esi), %edx
	cmpl	%edx, %eax
	jge	.L156
	incl	%eax
	movl	%eax, 67576(%esi)
	cmpl	%eax, %edx
	je	.L186
	leal	(%eax,%eax,4), %eax
	leal	(%eax,%eax,4), %eax
	leal	64372(%esi,%eax,8), %eax
.L161:
	leal	64164(%esi), %ebx
	pushl	%edx
	.cfi_def_cfa_offset 244
	pushl	$200
	.cfi_def_cfa_offset 248
.L182:
	pushl	%eax
	.cfi_def_cfa_offset 252
	pushl	%ebx
	.cfi_def_cfa_offset 256
	call	strlcpy
	movl	%ebx, (%esp)
	call	strlen
	movl	%eax, 64368(%esi)
	movl	%eax, 64364(%esi)
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	.align 4
.L156:
	subl	$12, %esp
	.cfi_def_cfa_offset 252
	pushl	4(%esi)
	.cfi_def_cfa_offset 256
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 240
.L120:
	addl	$220, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L122:
	.cfi_restore_state
	testb	$4, 2(%ebp)
	jne	.L120
	movw	0(%ebp), %ax
	cmpw	$259, %ax
	je	.L137
	ja	.L138
	cmpw	$256, %ax
	je	.L139
	ja	.L140
	cmpw	$8, %ax
	je	.L141
	cmpw	$10, %ax
	jne	.L136
	pushl	%eax
	.cfi_def_cfa_offset 244
	pushl	$200
	.cfi_def_cfa_offset 248
	leal	64164(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 252
	leal	20(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 256
	call	strlcpy
	movl	%esi, %eax
	call	commit_line
	movl	%esi, %eax
	call	newline
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	cmpb	$0, 8(%esp)
	je	.L152
	movl	67572(%esi), %eax
	testl	%eax, %eax
	jne	.L187
.L153:
	leal	1(%eax), %edx
	movl	%edx, 67572(%esi)
	pushl	%edi
	.cfi_def_cfa_offset 244
	pushl	$200
	.cfi_def_cfa_offset 248
	pushl	%ebx
	.cfi_def_cfa_offset 252
	leal	(%eax,%eax,4), %eax
	leal	(%eax,%eax,4), %eax
	leal	64372(%esi,%eax,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 240
.L152:
	movl	67572(%esi), %eax
	movl	%eax, 67576(%esi)
	movl	$0, 64368(%esi)
	movl	$0, 64364(%esi)
	movb	$0, 64164(%esi)
	subl	$8, %esp
	.cfi_def_cfa_offset 248
	pushl	%ebx
	.cfi_def_cfa_offset 252
	leal	8(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	shell_exec
	movl	%esi, %eax
	call	make_prompt
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	movl	67780(%esi), %ecx
	testl	%ecx, %ecx
	je	.L156
	subl	$12, %esp
	.cfi_def_cfa_offset 252
	pushl	252(%esp)
	.cfi_def_cfa_offset 256
	call	gui_close_window
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	jmp	.L120
	.align 4
.L138:
	cmpw	$262, %ax
	je	.L145
	ja	.L146
	cmpw	$260, %ax
	je	.L147
	cmpw	$261, %ax
	je	.L148
.L136:
	leal	-32(%eax), %edx
	cmpw	$94, %dx
	ja	.L120
	movb	%al, 8(%esp)
	movl	$1, %ecx
	leal	8(%esp), %edx
	movl	%esi, %eax
	call	insert
	jmp	.L156
	.align 4
.L148:
	movl	64364(%esi), %eax
	movl	%eax, 64368(%esi)
	jmp	.L156
	.align 4
.L147:
	movl	$0, 64368(%esi)
	jmp	.L156
	.align 4
.L126:
	movl	%esi, %eax
	call	commit_line
	movl	$94, %edx
	movl	$.LC20, %ebx
	.align 4
.L132:
	incl	%ebx
	movl	$1, %ecx
	movl	%esi, %eax
	call	put
	movsbl	(%ebx), %edx
	testb	%dl, %dl
	jne	.L132
	movl	%esi, %eax
	call	newline
	movl	$0, 64368(%esi)
	movl	$0, 64364(%esi)
	movb	$0, 64164(%esi)
	movl	67572(%esi), %eax
	movl	%eax, 67576(%esi)
	jmp	.L156
	.align 4
.L128:
	movl	64368(%esi), %eax
	movl	%eax, 64364(%esi)
	movb	$0, 64164(%esi,%eax)
	jmp	.L156
	.align 4
.L131:
	call	clipboard_get
	movb	(%eax), %dl
	xorl	%ecx, %ecx
	testb	%dl, %dl
	je	.L133
	cmpb	$10, %dl
	jne	.L134
	jmp	.L133
	.align 4
.L188:
	cmpb	$10, %bl
	je	.L133
.L134:
	incl	%ecx
	movb	(%eax,%ecx), %bl
	testb	%bl, %bl
	jne	.L188
.L133:
	movl	%eax, %edx
	movl	%esi, %eax
	call	insert
	jmp	.L156
	.align 4
.L130:
	movl	$0, 64368(%esi)
	movl	$0, 64364(%esi)
	movb	$0, 64164(%esi)
	jmp	.L156
	.align 4
.L129:
	movl	64088(%esi), %eax
	movl	%eax, 64084(%esi)
	movl	$0, 64096(%esi)
	jmp	.L156
	.align 4
.L146:
	cmpw	$263, %ax
	je	.L149
	cmpw	$265, %ax
	jne	.L136
	movl	64368(%esi), %eax
	movl	64364(%esi), %edx
	cmpl	%edx, %eax
	jge	.L156
	leal	64164(%esi), %ecx
	pushl	%ebp
	.cfi_def_cfa_offset 244
	subl	%eax, %edx
	pushl	%edx
	.cfi_def_cfa_offset 248
	leal	1(%ecx,%eax), %edx
	pushl	%edx
	.cfi_def_cfa_offset 252
	addl	%ecx, %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	memmove
	decl	64364(%esi)
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	jmp	.L156
	.align 4
.L185:
	cmpw	$258, %ax
	jne	.L136
	movl	64368(%esi), %eax
	testl	%eax, %eax
	jle	.L156
	decl	%eax
	movl	%eax, 64368(%esi)
	jmp	.L156
	.align 4
.L149:
	movl	64096(%esi), %eax
	leal	-26(%eax), %ebx
	movl	%esi, %eax
	call	max_scroll
	testl	%ebx, %ebx
	js	.L169
.L184:
	cmpl	%ebx, %eax
	jle	.L164
	movl	%ebx, %eax
.L164:
	movl	%eax, 64096(%esi)
	jmp	.L156
	.align 4
.L141:
	movl	64368(%esi), %eax
	testl	%eax, %eax
	jle	.L156
	leal	64164(%esi), %ecx
	pushl	%edx
	.cfi_def_cfa_offset 244
	movl	64364(%esi), %edx
	subl	%eax, %edx
	incl	%edx
	pushl	%edx
	.cfi_def_cfa_offset 248
	leal	(%ecx,%eax), %edx
	pushl	%edx
	.cfi_def_cfa_offset 252
	leal	-1(%ecx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	memmove
	decl	64368(%esi)
	decl	64364(%esi)
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	jmp	.L156
	.align 4
.L145:
	movl	64096(%esi), %eax
	leal	26(%eax), %ebx
	movl	%esi, %eax
	call	max_scroll
	testl	%ebx, %ebx
	jns	.L184
.L169:
	xorl	%eax, %eax
	jmp	.L164
	.align 4
.L139:
	movl	67576(%esi), %eax
	testl	%eax, %eax
	jle	.L156
	leal	64164(%esi), %ebx
	cmpl	67572(%esi), %eax
	je	.L189
.L159:
	decl	%eax
	movl	%eax, 67576(%esi)
	pushl	%ecx
	.cfi_remember_state
	.cfi_def_cfa_offset 244
	pushl	$200
	.cfi_def_cfa_offset 248
	leal	(%eax,%eax,4), %eax
	leal	(%eax,%eax,4), %eax
	leal	64372(%esi,%eax,8), %eax
	jmp	.L182
	.align 4
.L137:
	.cfi_restore_state
	movl	64368(%esi), %eax
	cmpl	64364(%esi), %eax
	jge	.L156
	incl	%eax
	movl	%eax, 64368(%esi)
	jmp	.L156
.L187:
	subl	$8, %esp
	.cfi_def_cfa_offset 248
	pushl	%ebx
	.cfi_def_cfa_offset 252
	leal	-5(%eax,%eax,4), %eax
	leal	(%eax,%eax,4), %eax
	leal	64372(%esi,%eax,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	testl	%eax, %eax
	je	.L152
	movl	67572(%esi), %eax
	cmpl	$16, %eax
	jne	.L153
	pushl	%ebp
	.cfi_def_cfa_offset 244
	pushl	$3000
	.cfi_def_cfa_offset 248
	leal	64572(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 252
	leal	64372(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	memmove
	movl	67572(%esi), %eax
	decl	%eax
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	jmp	.L153
.L186:
	leal	67580(%esi), %eax
	jmp	.L161
.L189:
	pushl	%edi
	.cfi_def_cfa_offset 244
	pushl	$200
	.cfi_def_cfa_offset 248
	pushl	%ebx
	.cfi_def_cfa_offset 252
	leal	67580(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 256
	call	strlcpy
	movl	67576(%esi), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 240
	jmp	.L159
	.cfi_endproc
.LFE22:
	.size	on_key, .-on_key
	.section	.text.unlikely
.LCOLDE21:
	.text
.LHOTE21:
	.section	.rodata.str1.1
.LC22:
	.string	"DedOS 0.4 shell\n"
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC23:
	.string	"Type 'help' for a list of commands.\n\n"
	.section	.rodata.str1.1
.LC24:
	.string	"Terminal"
	.section	.text.unlikely
.LCOLDB25:
	.text
.LHOTB25:
	.align 4
	.globl	app_terminal_open
	.type	app_terminal_open, @function
app_terminal_open:
.LFB30:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$s_terms, %eax
	xorl	%edi, %edi
.L193:
	movl	(%eax), %edx
	testl	%edx, %edx
	je	.L200
	incl	%edi
	addl	$67792, %eax
	cmpl	$4, %edi
	jne	.L193
	xorl	%eax, %eax
.L194:
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L200:
	.cfi_restore_state
	movl	%edi, %edx
	sall	$4, %edx
	movl	%edi, %eax
	sall	$9, %eax
	addl	%edx, %eax
	addl	%edi, %eax
	addl	%eax, %eax
	addl	%edi, %eax
	leal	(%edi,%eax,4), %ebx
	sall	$4, %ebx
	leal	s_terms(%ebx), %esi
	pushl	%eax
	.cfi_def_cfa_offset 20
	pushl	$67792
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	%esi
	.cfi_def_cfa_offset 32
	call	memset
	movl	$1, s_terms(%ebx)
	movl	$1, 67784(%esi)
	call	timer_ms
	movl	%eax, 67788(%esi)
	addl	$12, %esp
	.cfi_def_cfa_offset 20
	pushl	$80
	.cfi_def_cfa_offset 24
	pushl	$32
	.cfi_def_cfa_offset 28
	leal	s_terms+84(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	memset
	addl	$12, %esp
	.cfi_def_cfa_offset 20
	pushl	$80
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	addl	$s_terms+32084, %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	memset
	pushl	$80
	.cfi_def_cfa_offset 36
	pushl	%esi
	.cfi_def_cfa_offset 40
	pushl	$IO
	.cfi_def_cfa_offset 44
	leal	8(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	shell_init
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	movl	$68, %edx
	movl	$.LC22, %ebx
	.align 4
.L192:
	incl	%ebx
	movl	$2, %ecx
	movl	%esi, %eax
	call	put
	movsbl	(%ebx), %edx
	testb	%dl, %dl
	jne	.L192
	movl	$84, %edx
	movl	$.LC23, %ebx
	.align 4
.L195:
	incl	%ebx
	movl	$1, %ecx
	movl	%esi, %eax
	call	put
	movsbl	(%ebx), %edx
	testb	%dl, %dl
	jne	.L195
	movl	%esi, %eax
	call	make_prompt
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%esi
	.cfi_def_cfa_offset 32
	pushl	$344
	.cfi_def_cfa_offset 36
	pushl	$648
	.cfi_def_cfa_offset 40
	pushl	$.LC24
	.cfi_def_cfa_offset 44
	pushl	$APP
	.cfi_def_cfa_offset 48
	call	gui_create_window
	movl	%edi, %ecx
	sall	$4, %ecx
	movl	%edi, %edx
	sall	$9, %edx
	addl	%ecx, %edx
	addl	%edi, %edx
	addl	%edx, %edx
	addl	%edi, %edx
	leal	(%edi,%edx,4), %edx
	sall	$4, %edx
	movl	%eax, s_terms+4(%edx)
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L194
	movl	$0, s_terms(%edx)
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE30:
	.size	app_terminal_open, .-app_terminal_open
	.section	.text.unlikely
.LCOLDE25:
	.text
.LHOTE25:
	.section	.text.unlikely
.LCOLDB26:
	.text
.LHOTB26:
	.align 4
	.type	ctx_cb, @function
ctx_cb:
.LFB23:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movw	$0, 12(%esp)
	movb	$2, 14(%esp)
	cmpl	$3, 36(%esp)
	je	.L207
	cmpl	$1, 36(%esp)
	je	.L205
	movl	$108, %eax
.L204:
	movw	%ax, 12(%esp)
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	leal	20(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	pushl	44(%esp)
	.cfi_def_cfa_offset 48
	call	on_key
	addl	$16, %esp
	.cfi_def_cfa_offset 32
.L201:
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L205:
	.cfi_restore_state
	movl	$118, %eax
	jmp	.L204
	.align 4
.L207:
	call	app_terminal_open
	jmp	.L201
	.cfi_endproc
.LFE23:
	.size	ctx_cb, .-ctx_cb
	.section	.text.unlikely
.LCOLDE26:
	.text
.LHOTE26:
	.section	.rodata
	.align 4
	.type	CSWTCH.24, @object
	.size	CSWTCH.24, 16
CSWTCH.24:
	.long	5996420
	.long	14021621
	.long	14708826
	.long	8378592
	.align 4
	.type	APP, @object
	.size	APP, 20
APP:
	.long	paint
	.long	on_key
	.long	on_mouse
	.long	tick
	.long	on_close
	.align 4
	.type	IO, @object
	.size	IO, 12
IO:
	.long	io_out
	.long	io_clear
	.long	io_exit
	.local	s_terms
	.comm	s_terms,271168,32
	.ident	"GCC: (GNU) 5.2.0"
