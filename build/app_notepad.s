	.file	"app_notepad.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.type	layout_of, @function
layout_of:
.LFB5:
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
	testl	%edx, %edx
	jle	.L8
	leal	72(%eax), %ebx
	leal	72(%eax,%edx), %edi
	xorl	%esi, %esi
	xorl	%ebp, %ebp
	jmp	.L7
	.align 4
.L3:
	cmpl	$66, %esi
	je	.L5
	incl	%esi
.L4:
	incl	%ebx
	cmpl	%edi, %ebx
	je	.L12
.L7:
	cmpb	$10, (%ebx)
	jne	.L3
	incl	%ebp
	xorl	%esi, %esi
	incl	%ebx
	cmpl	%edi, %ebx
	jne	.L7
.L12:
	cmpl	$66, %esi
	je	.L13
.L2:
	movl	%ebp, (%ecx)
	movl	20(%esp), %eax
	movl	%esi, (%eax)
	popl	%ebx
	.cfi_remember_state
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
.L5:
	.cfi_restore_state
	incl	%ebp
	movl	$1, %esi
	jmp	.L4
.L13:
	cmpl	2120(%eax), %edx
	jge	.L2
	cmpb	$10, 72(%eax,%edx)
	je	.L2
	incl	%ebp
	xorl	%esi, %esi
	movl	%ebp, (%ecx)
	movl	20(%esp), %eax
	movl	%esi, (%eax)
	popl	%ebx
	.cfi_remember_state
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
.L8:
	.cfi_restore_state
	xorl	%esi, %esi
	xorl	%ebp, %ebp
	jmp	.L2
	.cfi_endproc
.LFE5:
	.size	layout_of, .-layout_of
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.type	move_vertical, @function
move_vertical:
.LFB15:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	2124(%eax), %ecx
	testl	%ecx, %ecx
	jle	.L15
	leal	-1(%ecx), %ebx
	cmpb	$10, 72(%eax,%ebx)
	jne	.L48
	jmp	.L54
	.align 4
.L19:
	leal	-1(%ebx), %esi
	cmpb	$10, 72(%eax,%esi)
	je	.L55
	movl	%esi, %ebx
.L48:
	testl	%ebx, %ebx
	jne	.L19
	testl	%edx, %edx
	js	.L20
	movl	%ecx, %esi
.L21:
	movl	2120(%eax), %ebx
	cmpl	%ebx, %ecx
	jl	.L51
	jmp	.L23
	.align 4
.L45:
	incl	%ecx
	cmpl	%ebx, %ecx
	je	.L23
.L51:
	cmpb	$10, 72(%eax,%ecx)
	jne	.L45
	incl	%ecx
	cmpl	%ebx, %ecx
	jge	.L43
	movl	%ecx, %edx
	cmpb	$10, 72(%eax,%ecx)
	jne	.L44
	jmp	.L43
	.align 4
.L56:
	cmpb	$10, 72(%eax,%edx)
	je	.L52
.L44:
	incl	%edx
	cmpl	%ebx, %edx
	jne	.L56
.L52:
	subl	%ecx, %edx
.L35:
	cmpl	%edx, %esi
	jle	.L37
	movl	%edx, %esi
.L37:
	addl	%esi, %ecx
	movl	%ecx, 2124(%eax)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L55:
	.cfi_restore_state
	movl	%ecx, %esi
	subl	%ebx, %esi
.L17:
	testl	%edx, %edx
	jns	.L21
.L26:
	leal	-1(%ebx), %ecx
	testl	%ecx, %ecx
	jle	.L41
	subl	$2, %ebx
	cmpb	$10, 72(%eax,%ebx)
	jne	.L49
	jmp	.L41
	.align 4
.L31:
	leal	-1(%ebx), %edx
	cmpb	$10, 72(%eax,%edx)
	je	.L57
	movl	%edx, %ebx
.L49:
	testl	%ebx, %ebx
	jne	.L31
.L28:
	cmpl	%ecx, %esi
	jle	.L32
	movl	%ecx, %esi
.L32:
	addl	%esi, %ebx
	movl	%ebx, 2124(%eax)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L23:
	.cfi_restore_state
	movl	%ebx, 2124(%eax)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L20:
	.cfi_restore_state
	movl	$0, 2124(%eax)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
.L57:
	.cfi_restore_state
	subl	%ebx, %ecx
	jmp	.L28
.L15:
	testl	%edx, %edx
	jns	.L58
	testl	%ecx, %ecx
	je	.L20
	movl	%ecx, %ebx
	xorl	%esi, %esi
	jmp	.L26
.L54:
	movl	%ecx, %ebx
	xorl	%esi, %esi
	jmp	.L17
.L43:
	xorl	%edx, %edx
	jmp	.L35
.L41:
	movl	%ecx, %ebx
	xorl	%ecx, %ecx
	jmp	.L28
.L58:
	xorl	%esi, %esi
	jmp	.L21
	.cfi_endproc
.LFE15:
	.size	move_vertical, .-move_vertical
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.align 4
	.type	on_close, @function
on_close:
.LFB21:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	72(%eax), %eax
	movl	$0, (%eax)
	ret
	.cfi_endproc
.LFE21:
	.size	on_close, .-on_close
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.type	tick, @function
tick:
.LFB19:
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
	movl	16(%esp), %ebx
	movl	20(%esp), %edi
	movl	72(%ebx), %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	gui_is_focused
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L60
	movl	%edi, %eax
	subl	2180(%esi), %eax
	cmpl	$499, %eax
	ja	.L66
.L60:
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
.L66:
	.cfi_restore_state
	movl	%edi, 2180(%esi)
	xorl	%eax, %eax
	movl	2176(%esi), %edx
	testl	%edx, %edx
	sete	%al
	movl	%eax, 2176(%esi)
	movl	%ebx, 16(%esp)
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	jmp	gui_invalidate_window
	.cfi_endproc
.LFE19:
	.size	tick, .-tick
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Save"
.LC1:
	.string	"Copy Line"
.LC2:
	.string	"Cut Line"
.LC3:
	.string	"Paste"
	.section	.rodata
	.align 32
.LC9:
	.long	.LC0
	.long	-1
	.long	1
	.long	.LC1
	.long	-1
	.long	2
	.long	.LC2
	.long	-1
	.long	3
	.long	.LC3
	.long	-1
	.long	4
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.type	on_mouse, @function
on_mouse:
.LFB18:
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
	subl	$92, %esp
	.cfi_def_cfa_offset 112
	movl	116(%esp), %ebx
	movl	112(%esp), %eax
	movl	72(%eax), %esi
	movl	(%ebx), %eax
	cmpl	$5, %eax
	je	.L86
	cmpl	$3, %eax
	je	.L87
	decl	%eax
	je	.L88
.L67:
	addl	$92, %esp
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
.L88:
	.cfi_restore_state
	movl	8(%ebx), %ecx
	testl	%ecx, %ecx
	js	.L67
	movl	112(%esp), %eax
	movl	24(%eax), %eax
	movl	%eax, 8(%esp)
	subl	$20, %eax
	cmpl	%eax, %ecx
	jge	.L67
	subl	$6, %ecx
	movl	$715827883, %eax
	imull	%ecx
	movl	%edx, %edi
	sarl	%edi
	sarl	$31, %ecx
	subl	%ecx, %edi
	addl	2128(%esi), %edi
	movl	4(%ebx), %edx
	movl	%edx, %eax
	subl	$2, %eax
	js	.L89
.L73:
	sarl	$3, %eax
	movl	%eax, 8(%esp)
	js	.L90
.L74:
	movl	2120(%esi), %eax
	movl	%eax, 12(%esp)
	testl	%eax, %eax
	js	.L75
	xorl	%ebx, %ebx
	leal	32(%esp), %ebp
	jmp	.L79
	.align 4
.L76:
	jl	.L91
.L78:
	incl	%ebx
	cmpl	%ebx, 2120(%esi)
	jl	.L75
.L79:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	%ebp
	.cfi_def_cfa_offset 128
	leal	44(%esp), %ecx
	movl	%ebx, %edx
	movl	%esi, %eax
	call	layout_of
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	cmpl	28(%esp), %edi
	jne	.L76
	movl	8(%esp), %eax
	cmpl	%eax, 32(%esp)
	jl	.L78
	movl	%ebx, 12(%esp)
	.align 4
.L75:
	movl	12(%esp), %eax
	movl	%eax, 2124(%esi)
	movl	$1, 2176(%esi)
	call	timer_ms
	movl	%eax, 2180(%esi)
.L84:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	addl	$92, %esp
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
.L87:
	.cfi_restore_state
	movl	16(%ebx), %eax
	leal	(%eax,%eax), %edx
	addl	%edx, %eax
	subl	%eax, 2128(%esi)
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	movl	2120(%esi), %edx
	leal	44(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 128
	leal	44(%esp), %ecx
	movl	%esi, %eax
	call	layout_of
	movl	44(%esp), %edx
	movl	2128(%esi), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	cmpl	%edx, %eax
	jle	.L71
	movl	%edx, 2128(%esi)
	movl	%edx, %eax
.L71:
	testl	%eax, %eax
	jns	.L84
	movl	$0, 2128(%esi)
	jmp	.L84
	.align 4
.L86:
	leal	32(%esp), %edi
	movl	$.LC9, %esi
	movl	$12, %ecx
	rep movsl
	subl	$8, %esp
	.cfi_def_cfa_offset 120
	pushl	120(%esp)
	.cfi_def_cfa_offset 124
	pushl	$ctx_cb
	.cfi_def_cfa_offset 128
	pushl	$4
	.cfi_def_cfa_offset 132
	leal	52(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 136
	movl	136(%esp), %eax
	movl	8(%eax), %edx
	movl	8(%ebx), %eax
	leal	21(%edx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 140
	movl	140(%esp), %eax
	movl	4(%eax), %edx
	movl	4(%ebx), %eax
	leal	1(%edx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 144
	call	gui_popup
	addl	$32, %esp
	.cfi_def_cfa_offset 112
	jmp	.L67
	.align 4
.L91:
	testl	%ebx, %ebx
	jle	.L81
	leal	-1(%ebx), %eax
	movl	%eax, 12(%esp)
	jmp	.L75
.L81:
	movl	$0, 12(%esp)
	jmp	.L75
	.align 4
.L90:
	movl	$0, 8(%esp)
	jmp	.L74
	.align 4
.L89:
	leal	5(%edx), %eax
	jmp	.L73
	.cfi_endproc
.LFE18:
	.size	on_mouse, .-on_mouse
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.type	erase, @function
erase:
.LFB13:
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
	subl	$16, %esp
	.cfi_def_cfa_offset 36
	movl	%eax, %ebx
	movl	%edx, %edi
	movl	%ecx, %ebp
	leal	72(%eax), %esi
	movl	2120(%eax), %eax
	subl	%ecx, %eax
	incl	%eax
	pushl	%eax
	.cfi_def_cfa_offset 40
	leal	(%esi,%ecx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	addl	%edx, %esi
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	memmove
	movl	%edi, %eax
	subl	%ebp, %eax
	addl	%eax, 2120(%ebx)
	movl	%edi, 2124(%ebx)
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
.LFE13:
	.size	erase, .-erase
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.text.unlikely
.LCOLDB12:
	.text
.LHOTB12:
	.align 4
	.type	insert, @function
insert:
.LFB12:
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
	movl	2120(%eax), %eax
	testl	%ecx, %ecx
	jle	.L96
	cmpl	$2046, %eax
	jg	.L96
	movl	2124(%ebx), %esi
	leal	72(%ebx), %edi
	movl	%edx, %ebp
	leal	-1(%edx,%ecx), %edx
	movl	%edx, 12(%esp)
	jmp	.L97
	.align 4
.L100:
	incl	%ebp
	cmpl	$2046, %eax
	jg	.L96
.L97:
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
	movl	2124(%ebx), %eax
	leal	1(%eax), %esi
	movl	%esi, 2124(%ebx)
	movb	0(%ebp), %dl
	movb	%dl, 72(%ebx,%eax)
	movl	2120(%ebx), %eax
	incl	%eax
	movl	%eax, 2120(%ebx)
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	cmpl	12(%esp), %ebp
	jne	.L100
.L96:
	movb	$0, 72(%ebx,%eax)
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
.LFE12:
	.size	insert, .-insert
	.section	.text.unlikely
.LCOLDE12:
	.text
.LHOTE12:
	.section	.rodata.str1.1
.LC13:
	.string	"Ln %d, Col %d   %d/%d bytes"
.LC14:
	.string	"modified"
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.align 4
	.type	paint, @function
paint:
.LFB20:
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
	subl	$124, %esp
	.cfi_def_cfa_offset 144
	movl	144(%esp), %eax
	movl	72(%eax), %esi
	movl	2120(%esi), %ecx
	movl	2128(%esi), %eax
	movl	%eax, 12(%esp)
	testl	%ecx, %ecx
	js	.L137
	leal	73(%esi), %ebp
	xorl	%ebx, %ebx
	movl	$0, 28(%esp)
	movl	$0, 16(%esp)
	xorl	%edi, %edi
	movl	$0, 8(%esp)
	movl	152(%esp), %eax
	addl	$6, %eax
	movl	%eax, 20(%esp)
	movl	148(%esp), %eax
	addl	$6, %eax
	movl	%eax, 24(%esp)
	cmpl	%ebx, 2124(%esi)
	je	.L138
	.align 4
.L106:
	cmpl	%ebx, %ecx
	je	.L103
.L141:
	movsbl	-1(%ebp), %eax
	cmpb	$10, %al
	je	.L139
	movl	8(%esp), %edx
	subl	12(%esp), %edx
	cmpl	$25, %edx
	ja	.L109
	leal	-32(%eax), %ecx
	cmpb	$94, %cl
	jbe	.L110
	movl	$63, %eax
.L110:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$1
	.cfi_def_cfa_offset 160
	pushl	$11194321
	.cfi_def_cfa_offset 164
	pushl	%eax
	.cfi_def_cfa_offset 168
	leal	(%edx,%edx), %eax
	addl	%eax, %edx
	movl	44(%esp), %eax
	leal	2(%eax,%edx,4), %eax
	pushl	%eax
	.cfi_def_cfa_offset 172
	movl	52(%esp), %eax
	leal	(%eax,%edi,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_char
	movl	2128(%esi), %eax
	movl	%eax, 44(%esp)
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	movl	2120(%esi), %ecx
.L109:
	incl	%edi
	incl	%ebx
	cmpl	%ebx, %ecx
	jl	.L103
	cmpl	$66, %edi
	je	.L140
.L105:
	incl	%ebp
.L147:
	cmpl	%ebx, 2124(%esi)
	jne	.L106
.L138:
	movl	%edi, 28(%esp)
	movl	8(%esp), %eax
	movl	%eax, 16(%esp)
	cmpl	%ebx, %ecx
	jne	.L141
	.align 4
.L103:
	movl	16(%esp), %eax
	subl	12(%esp), %eax
	cmpl	$25, %eax
	jbe	.L142
.L113:
	movl	152(%esp), %ebx
	addl	160(%esp), %ebx
	leal	-20(%ebx), %edi
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$858654
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	176(%esp)
	.cfi_def_cfa_offset 168
	pushl	%edi
	.cfi_def_cfa_offset 172
	pushl	176(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	pushl	$5996420
	.cfi_def_cfa_offset 148
	pushl	160(%esp)
	.cfi_def_cfa_offset 152
	pushl	%edi
	.cfi_def_cfa_offset 156
	pushl	160(%esp)
	.cfi_def_cfa_offset 160
	call	gfx_hline
	movl	2124(%esi), %edi
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%edi, %edi
	jle	.L116
	leal	72(%esi), %edx
	leal	72(%esi,%edi), %ecx
	movl	$1, %eax
	jmp	.L118
	.align 4
.L117:
	incl	%edx
	cmpl	%edx, %ecx
	je	.L143
.L118:
	cmpb	$10, (%edx)
	jne	.L117
	incl	%eax
	incl	%edx
	cmpl	%edx, %ecx
	jne	.L118
.L143:
	movl	2120(%esi), %ebp
	leal	-1(%edi), %edx
	cmpb	$10, 72(%esi,%edx)
	jne	.L131
	jmp	.L144
	.align 4
.L122:
	leal	-1(%edx), %ecx
	cmpb	$10, 72(%esi,%ecx)
	je	.L145
	movl	%ecx, %edx
.L131:
	testl	%edx, %edx
	jne	.L122
	incl	%edi
.L121:
	pushl	%edx
	.cfi_def_cfa_offset 148
	pushl	$2047
	.cfi_def_cfa_offset 152
	pushl	%ebp
	.cfi_def_cfa_offset 156
	pushl	%edi
	.cfi_def_cfa_offset 160
	pushl	%eax
	.cfi_def_cfa_offset 164
	pushl	$.LC13
	.cfi_def_cfa_offset 168
	pushl	$80
	.cfi_def_cfa_offset 172
	leal	60(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 176
	call	ksnprintf
	subl	$14, %ebx
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	movl	168(%esp), %eax
	subl	$130, %eax
	pushl	%eax
	.cfi_def_cfa_offset 160
	pushl	$5996420
	.cfi_def_cfa_offset 164
	pushl	%edi
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	movl	176(%esp), %eax
	addl	$8, %eax
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_text_fit
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	cmpb	$0, 2136(%esi)
	jne	.L146
	movl	2132(%esi), %eax
	testl	%eax, %eax
	je	.L101
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$1
	.cfi_def_cfa_offset 160
	pushl	$5996420
	.cfi_def_cfa_offset 164
	pushl	$.LC14
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	movl	176(%esp), %eax
	movl	184(%esp), %esi
	leal	-72(%eax,%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	addl	$32, %esp
	.cfi_def_cfa_offset 144
.L101:
	addl	$124, %esp
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
.L140:
	.cfi_restore_state
	cmpl	%ebx, %ecx
	jle	.L105
	cmpb	$10, 0(%ebp)
	je	.L105
	incl	8(%esp)
	xorl	%edi, %edi
	incl	%ebp
	jmp	.L147
	.align 4
.L139:
	incl	8(%esp)
	incl	%ebx
	cmpl	%ecx, %ebx
	jg	.L103
	xorl	%edi, %edi
	incl	%ebp
	jmp	.L147
.L145:
	subl	%edx, %edi
	incl	%edi
	jmp	.L121
.L142:
	movl	148(%esp), %edi
	movl	28(%esp), %ebx
	leal	6(%edi,%ebx,8), %ebx
	leal	(%eax,%eax), %edx
	addl	%edx, %eax
	movl	152(%esp), %edi
	leal	6(%edi,%eax,4), %edi
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	156(%esp)
	.cfi_def_cfa_offset 160
	call	gui_is_focused
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	je	.L114
	movl	2176(%esi), %ecx
	testl	%ecx, %ecx
	je	.L113
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$11194321
	.cfi_def_cfa_offset 160
	pushl	$12
	.cfi_def_cfa_offset 164
	pushl	$2
	.cfi_def_cfa_offset 168
	pushl	%edi
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	jmp	.L113
.L146:
	addl	$2136, %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	%esi
	.cfi_def_cfa_offset 160
	call	gfx_text_width
	movl	$1, (%esp)
	pushl	$11194321
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	movl	176(%esp), %esi
	movl	184(%esp), %edi
	leal	-8(%esi,%edi), %edx
	subl	%eax, %edx
	pushl	%edx
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	addl	$124, %esp
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
.L114:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$5996420
	.cfi_def_cfa_offset 160
	pushl	$12
	.cfi_def_cfa_offset 164
	pushl	$8
	.cfi_def_cfa_offset 168
	pushl	%edi
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	jmp	.L113
.L137:
	movl	$0, 28(%esp)
	movl	$0, 16(%esp)
	jmp	.L103
.L144:
	movl	$1, %edi
	jmp	.L121
.L116:
	movl	2120(%esi), %ebp
	movl	$1, %edi
	movl	$1, %eax
	jmp	.L121
	.cfi_endproc
.LFE20:
	.size	paint, .-paint
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.rodata.str1.1
.LC16:
	.string	"Untitled"
.LC17:
	.string	"*"
.LC18:
	.string	""
.LC19:
	.string	"Notepad - %s%s"
	.section	.text.unlikely
.LCOLDB20:
	.text
.LHOTB20:
	.align 4
	.type	update_title, @function
update_title:
.LFB10:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$52, %esp
	.cfi_def_cfa_offset 64
	movl	%eax, %ebx
	cmpb	$0, 8(%eax)
	jne	.L154
	movl	$.LC16, %eax
.L149:
	movl	2132(%ebx), %edx
	testl	%edx, %edx
	jne	.L152
	movl	$.LC18, %edx
.L150:
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	pushl	%edx
	.cfi_def_cfa_offset 80
	pushl	%eax
	.cfi_def_cfa_offset 84
	pushl	$.LC19
	.cfi_def_cfa_offset 88
	pushl	$40
	.cfi_def_cfa_offset 92
	leal	36(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	ksnprintf
	addl	$24, %esp
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	4(%ebx)
	.cfi_def_cfa_offset 80
	call	gui_set_title
	addl	$68, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L152:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -12
	.cfi_offset 6, -8
	movl	$.LC17, %edx
	jmp	.L150
	.align 4
.L154:
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	leal	8(%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	fs_basename
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	jmp	.L149
	.cfi_endproc
.LFE10:
	.size	update_title, .-update_title
	.section	.text.unlikely
.LCOLDE20:
	.text
.LHOTE20:
	.section	.rodata.str1.1
.LC21:
	.string	"/home/note.txt"
.LC22:
	.string	"/home/note%d.txt"
.LC23:
	.string	"Cannot create file"
.LC24:
	.string	"Saved"
.LC25:
	.string	"Line copied"
.LC26:
	.string	"    "
.LC27:
	.string	"\n"
	.section	.text.unlikely
.LCOLDB28:
	.text
.LHOTB28:
	.align 4
	.type	on_key, @function
on_key:
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
	subl	$44, %esp
	.cfi_def_cfa_offset 64
	movl	68(%esp), %ebp
	movl	64(%esp), %eax
	movl	72(%eax), %esi
	movl	2132(%esi), %eax
	movl	%eax, 4(%esp)
	movb	2(%ebp), %bl
	andl	$2, %ebx
	movl	$1, 2176(%esi)
	call	timer_ms
	movl	%eax, 2180(%esi)
	movb	$0, 2136(%esi)
	testb	%bl, %bl
	je	.L156
	movw	0(%ebp), %ax
	cmpw	$115, %ax
	je	.L158
	jbe	.L254
	cmpw	$118, %ax
	jne	.L255
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	pushl	$s_clip
	.cfi_def_cfa_offset 80
	call	strlen
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	testl	%eax, %eax
	jne	.L256
.L250:
	movl	2124(%esi), %edx
.L168:
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	leal	40(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	leal	40(%esp), %ecx
	movl	%esi, %eax
	call	layout_of
	movl	2128(%esi), %edx
	movl	40(%esp), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	cmpl	%eax, %edx
	jle	.L204
	movl	%eax, 2128(%esi)
	movl	%eax, %edx
.L204:
	addl	$25, %edx
	cmpl	%edx, %eax
	jle	.L205
	subl	$25, %eax
	movl	%eax, 2128(%esi)
.L205:
	movl	4(%esp), %eax
	cmpl	2132(%esi), %eax
	jne	.L206
	testb	%bl, %bl
	je	.L207
.L206:
	movl	%esi, %eax
	call	update_title
.L207:
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	pushl	76(%esp)
	.cfi_def_cfa_offset 80
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 64
.L155:
	addl	$44, %esp
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
.L156:
	.cfi_restore_state
	testb	$4, 2(%ebp)
	jne	.L155
	movw	0(%ebp), %ax
	cmpw	$258, %ax
	je	.L181
	jbe	.L257
	cmpw	$261, %ax
	je	.L189
	jbe	.L258
	cmpw	$263, %ax
	je	.L193
	jb	.L194
	cmpw	$265, %ax
	jne	.L180
	movl	2124(%esi), %edx
	cmpl	2120(%esi), %edx
	jge	.L168
	leal	1(%edx), %ecx
	movl	%esi, %eax
	call	erase
	jmp	.L247
	.align 4
.L257:
	cmpw	$10, %ax
	je	.L183
	ja	.L184
	cmpw	$8, %ax
	je	.L185
	cmpw	$9, %ax
	jne	.L180
	movl	$4, %ecx
	movl	$.LC26, %edx
.L248:
	movl	%esi, %eax
	call	insert
	jmp	.L247
	.align 4
.L255:
	cmpw	$120, %ax
	jne	.L155
.L160:
	movl	2124(%esi), %eax
	testl	%eax, %eax
	jle	.L208
	leal	-1(%eax), %edi
	cmpb	$10, 72(%esi,%edi)
	jne	.L231
	jmp	.L208
	.align 4
.L174:
	leal	-1(%edi), %edx
	cmpb	$10, 71(%esi,%edi)
	je	.L169
	movl	%edx, %edi
.L231:
	testl	%edi, %edi
	jne	.L174
.L169:
	movl	2120(%esi), %ecx
	cmpl	%eax, %ecx
	jg	.L252
	jmp	.L209
	.align 4
.L226:
	incl	%eax
	cmpl	%eax, %ecx
	je	.L171
.L252:
	cmpb	$10, 72(%esi,%eax)
	jne	.L226
.L209:
	movl	%eax, %ecx
.L171:
	movl	%ecx, %edx
	subl	%edi, %edx
	cmpl	$255, %edx
	jle	.L176
	movl	$255, %edx
.L176:
	movl	%ecx, 12(%esp)
	pushl	%ecx
	.cfi_def_cfa_offset 68
	pushl	%edx
	.cfi_def_cfa_offset 72
	movl	%edx, 16(%esp)
	leal	72(%esi,%edi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 76
	pushl	$s_clip
	.cfi_def_cfa_offset 80
	call	memcpy
	movl	24(%esp), %edx
	movb	$0, s_clip(%edx)
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	cmpw	$120, 0(%ebp)
	jne	.L177
	movl	12(%esp), %ecx
	cmpl	%ecx, 2120(%esi)
	jg	.L259
.L178:
	movl	%edi, %edx
	movl	%esi, %eax
	call	erase
.L247:
	movl	$1, 2132(%esi)
	movb	$0, 2136(%esi)
	movl	$1, 2176(%esi)
	call	timer_ms
	movl	%eax, 2180(%esi)
	jmp	.L250
	.align 4
.L158:
	leal	8(%esi), %ebp
	cmpb	$0, 8(%esi)
	jne	.L163
	movl	$2, %eax
	movl	$1, %edi
	movb	%bl, 8(%esp)
	movl	%edi, %ebx
	movl	%eax, %edi
	.align 4
.L164:
	cmpl	$1, %ebx
	je	.L260
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	$.LC22
	.cfi_def_cfa_offset 72
	pushl	$64
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	ksnprintf
	movl	%ebp, (%esp)
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	testl	%eax, %eax
	je	.L238
	cmpl	$100, %edi
	je	.L238
.L166:
	incl	%ebx
	incl	%edi
	jmp	.L164
.L260:
	pushl	%eax
	.cfi_def_cfa_offset 68
	pushl	$64
	.cfi_def_cfa_offset 72
	pushl	$.LC21
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	strlcpy
	movl	%ebp, (%esp)
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	testl	%eax, %eax
	jne	.L166
	.align 4
.L238:
	movb	8(%esp), %bl
.L163:
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	testl	%eax, %eax
	je	.L261
.L167:
	pushl	%edi
	.cfi_def_cfa_offset 68
	pushl	2120(%esi)
	.cfi_def_cfa_offset 72
	leal	72(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	fs_write
	movl	$0, 2132(%esi)
	addl	$12, %esp
	.cfi_def_cfa_offset 68
	pushl	$40
	.cfi_def_cfa_offset 72
	pushl	$.LC24
	.cfi_def_cfa_offset 76
.L249:
	leal	2136(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	strlcpy
	movl	2124(%esi), %edx
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	jmp	.L168
	.align 4
.L254:
	cmpw	$99, %ax
	je	.L160
	jmp	.L155
	.align 4
.L177:
	pushl	%eax
	.cfi_remember_state
	.cfi_def_cfa_offset 68
	pushl	$40
	.cfi_def_cfa_offset 72
	pushl	$.LC25
	.cfi_def_cfa_offset 76
	jmp	.L249
	.align 4
.L184:
	.cfi_restore_state
	cmpw	$256, %ax
	je	.L187
	cmpw	$257, %ax
	jne	.L180
	movl	$1, %edx
	movl	%esi, %eax
	call	move_vertical
	movl	2124(%esi), %edx
	jmp	.L168
	.align 4
.L258:
	cmpw	$259, %ax
	je	.L191
	cmpw	$260, %ax
	jne	.L180
	movl	2124(%esi), %eax
	testl	%eax, %eax
	jle	.L215
	leal	-1(%eax), %edx
	cmpb	$10, 72(%esi,%edx)
	jne	.L232
	jmp	.L215
	.align 4
.L199:
	leal	-1(%edx), %eax
	cmpb	$10, 71(%esi,%edx)
	je	.L200
	movl	%eax, %edx
.L232:
	testl	%edx, %edx
	jne	.L199
.L200:
	movl	%edx, 2124(%esi)
	jmp	.L168
	.align 4
.L259:
	incl	%ecx
	jmp	.L178
	.align 4
.L185:
	movl	2124(%esi), %edx
	testl	%edx, %edx
	jle	.L168
	leal	-1(%edx), %eax
	movl	%edx, %ecx
	movl	%eax, %edx
	movl	%esi, %eax
	call	erase
	jmp	.L247
	.align 4
.L194:
	movl	$24, %edi
	.align 4
.L202:
	movl	$-1, %edx
	movl	%esi, %eax
	call	move_vertical
	decl	%edi
	jne	.L202
	jmp	.L250
	.align 4
.L191:
	movl	2124(%esi), %edx
	cmpl	2120(%esi), %edx
	jge	.L168
	incl	%edx
	movl	%edx, 2124(%esi)
	jmp	.L168
	.align 4
.L187:
	movl	$-1, %edx
	movl	%esi, %eax
	call	move_vertical
	movl	2124(%esi), %edx
	jmp	.L168
	.align 4
.L256:
	movl	%eax, %ecx
	movl	$s_clip, %edx
	jmp	.L248
	.align 4
.L180:
	leal	-32(%eax), %edx
	cmpw	$94, %dx
	ja	.L155
	movb	%al, 28(%esp)
	movl	$1, %ecx
	leal	28(%esp), %edx
	jmp	.L248
	.align 4
.L193:
	movl	$24, %edi
	.align 4
.L203:
	movl	$1, %edx
	movl	%esi, %eax
	call	move_vertical
	decl	%edi
	jne	.L203
	jmp	.L250
	.align 4
.L189:
	movl	2124(%esi), %eax
	movl	2120(%esi), %edx
	cmpl	%eax, %edx
	jg	.L253
	jmp	.L215
	.align 4
.L262:
	incl	%eax
	cmpl	%eax, %edx
	je	.L200
.L253:
	cmpb	$10, 72(%esi,%eax)
	jne	.L262
.L215:
	movl	%eax, %edx
	jmp	.L200
	.align 4
.L181:
	movl	2124(%esi), %edx
	testl	%edx, %edx
	jle	.L168
	decl	%edx
	movl	%edx, 2124(%esi)
	jmp	.L168
	.align 4
.L183:
	movl	$1, %ecx
	movl	$.LC27, %edx
	jmp	.L248
	.align 4
.L261:
	subl	$12, %esp
	.cfi_def_cfa_offset 76
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	fs_create
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	testl	%eax, %eax
	jns	.L167
	pushl	%ebp
	.cfi_def_cfa_offset 68
	pushl	$40
	.cfi_def_cfa_offset 72
	pushl	$.LC23
	.cfi_def_cfa_offset 76
	leal	2136(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	strlcpy
	movb	$0, 8(%esi)
	movl	2124(%esi), %edx
	addl	$16, %esp
	.cfi_def_cfa_offset 64
	jmp	.L168
.L208:
	movl	%eax, %edi
	jmp	.L169
	.cfi_endproc
.LFE16:
	.size	on_key, .-on_key
	.section	.text.unlikely
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely
.LCOLDB29:
	.text
.LHOTB29:
	.align 4
	.type	ctx_cb, @function
ctx_cb:
.LFB17:
	.cfi_startproc
	subl	$36, %esp
	.cfi_def_cfa_offset 40
	movl	44(%esp), %eax
	movsbw	keys.1512(%eax), %ax
	movw	%ax, 20(%esp)
	movb	$2, 22(%esp)
	leal	20(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	pushl	44(%esp)
	.cfi_def_cfa_offset 48
	call	on_key
	addl	$44, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE17:
	.size	ctx_cb, .-ctx_cb
	.section	.text.unlikely
.LCOLDE29:
	.text
.LHOTE29:
	.section	.text.unlikely
.LCOLDB30:
	.text
.LHOTB30:
	.align 4
	.globl	clipboard_get
	.type	clipboard_get, @function
clipboard_get:
.LFB3:
	.cfi_startproc
	movl	$s_clip, %eax
	ret
	.cfi_endproc
.LFE3:
	.size	clipboard_get, .-clipboard_get
	.section	.text.unlikely
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely
.LCOLDB31:
	.text
.LHOTB31:
	.align 4
	.globl	clipboard_set
	.type	clipboard_set, @function
clipboard_set:
.LFB4:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	20(%esp), %ebx
	cmpl	$255, %ebx
	jle	.L267
	movl	$255, %ebx
.L267:
	pushl	%eax
	.cfi_def_cfa_offset 20
	pushl	%ebx
	.cfi_def_cfa_offset 24
	pushl	24(%esp)
	.cfi_def_cfa_offset 28
	pushl	$s_clip
	.cfi_def_cfa_offset 32
	call	memcpy
	movb	$0, s_clip(%ebx)
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE4:
	.size	clipboard_set, .-clipboard_set
	.section	.text.unlikely
.LCOLDE31:
	.text
.LHOTE31:
	.section	.rodata.str1.1
.LC32:
	.string	"Notepad"
	.section	.text.unlikely
.LCOLDB33:
	.text
.LHOTB33:
	.align 4
	.globl	app_notepad_open
	.type	app_notepad_open, @function
app_notepad_open:
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
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	movl	$s_pads, %eax
	xorl	%ebp, %ebp
.L273:
	movl	(%eax), %edx
	testl	%edx, %edx
	je	.L282
	incl	%ebp
	addl	$2184, %eax
	cmpl	$4, %ebp
	jne	.L273
	xorl	%eax, %eax
.L274:
	addl	$12, %esp
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
.L282:
	.cfi_restore_state
	leal	0(%ebp,%ebp), %esi
	leal	(%esi,%ebp), %eax
	leal	(%eax,%eax,8), %eax
	leal	0(%ebp,%eax,4), %eax
	leal	(%eax,%eax,4), %eax
	addl	%ebp, %eax
	addl	%eax, %eax
	leal	(%eax,%eax), %edi
	leal	s_pads(%edi), %ebx
	pushl	%eax
	.cfi_def_cfa_offset 36
	pushl	$2184
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	memset
	movl	$1, s_pads(%edi)
	movl	$1, 2176(%ebx)
	call	timer_ms
	movl	%eax, 2180(%ebx)
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %eax
	testl	%eax, %eax
	je	.L272
	pushl	%ecx
	.cfi_def_cfa_offset 36
	pushl	$64
	.cfi_def_cfa_offset 40
	pushl	40(%esp)
	.cfi_def_cfa_offset 44
	leal	8(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	strlcpy
	popl	%eax
	.cfi_def_cfa_offset 44
	pushl	44(%esp)
	.cfi_def_cfa_offset 48
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	je	.L272
	cmpb	$0, 2088(%eax)
	je	.L283
.L272:
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	pushl	$344
	.cfi_def_cfa_offset 52
	pushl	$540
	.cfi_def_cfa_offset 56
	pushl	$.LC32
	.cfi_def_cfa_offset 60
	pushl	$APP
	.cfi_def_cfa_offset 64
	call	gui_create_window
	addl	%ebp, %esi
	leal	(%esi,%esi,8), %ecx
	leal	0(%ebp,%ecx,4), %ecx
	leal	(%ecx,%ecx,4), %ecx
	leal	0(%ebp,%ecx), %edx
	addl	%edx, %edx
	addl	%edx, %edx
	leal	s_pads(%edx), %esi
	movl	%eax, 4(%esi)
	addl	$32, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	je	.L284
	movl	%ebx, %eax
	call	update_title
	movl	4(%esi), %eax
	addl	$12, %esp
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
.L283:
	.cfi_restore_state
	movl	2080(%eax), %ecx
	movl	%ecx, 2120(%ebx)
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	%ecx
	.cfi_def_cfa_offset 40
	addl	$32, %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	addl	$s_pads+72, %edi
	pushl	%edi
	.cfi_def_cfa_offset 48
	call	memcpy
	movl	2120(%ebx), %eax
	addl	%ebx, %eax
	movb	$0, 72(%eax)
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	jmp	.L272
	.align 4
.L284:
	movl	$0, s_pads(%edx)
	jmp	.L274
	.cfi_endproc
.LFE22:
	.size	app_notepad_open, .-app_notepad_open
	.section	.text.unlikely
.LCOLDE33:
	.text
.LHOTE33:
	.section	.rodata
	.align 4
	.type	keys.1512, @object
	.size	keys.1512, 5
keys.1512:
	.byte	0
	.byte	115
	.byte	99
	.byte	120
	.byte	118
	.align 4
	.type	APP, @object
	.size	APP, 20
APP:
	.long	paint
	.long	on_key
	.long	on_mouse
	.long	tick
	.long	on_close
	.local	s_clip
	.comm	s_clip,256,32
	.local	s_pads
	.comm	s_pads,8736,32
	.ident	"GCC: (GNU) 5.2.0"
