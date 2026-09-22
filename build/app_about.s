	.file	"app_about.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.type	on_close, @function
on_close:
.LFB6:
	.cfi_startproc
	movl	$0, s_win
	ret
	.cfi_endproc
.LFE6:
	.size	on_close, .-on_close
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.type	tick, @function
tick:
.LFB5:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %ebx
	movl	$274877907, %ecx
	movl	%ecx, %eax
	mull	20(%esp)
	movl	%edx, %eax
	shrl	$6, %eax
	cmpl	s_last_sec, %eax
	je	.L2
	movl	%eax, s_last_sec
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$20
	.cfi_def_cfa_offset 32
	pushl	20(%ebx)
	.cfi_def_cfa_offset 36
	pushl	$170
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	gui_invalidate_client
	addl	$32, %esp
	.cfi_def_cfa_offset 16
.L2:
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE5:
	.size	tick, .-tick
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"DedOS"
.LC3:
	.string	"0.4"
.LC4:
	.string	"Version %s"
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC5:
	.string	"A small experimental operating system."
	.section	.rodata.str1.1
.LC6:
	.string	"x86 - Ring 0 - flat memory"
.LC7:
	.string	"VBE framebuffer 1024x768x32"
	.section	.rodata.str1.4
	.align 4
.LC8:
	.string	"PS/2 keyboard and mouse - RAM filesystem"
	.section	.rodata.str1.1
.LC9:
	.string	"Uptime: %02d:%02d:%02d"
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.type	paint, @function
paint:
.LFB4:
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
	movl	96(%esp), %ebx
	movl	100(%esp), %esi
	movl	104(%esp), %edi
	pushl	$462353
	.cfi_def_cfa_offset 96
	pushl	$74
	.cfi_def_cfa_offset 100
	pushl	%edi
	.cfi_def_cfa_offset 104
	pushl	%esi
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$5
	.cfi_def_cfa_offset 96
	pushl	$11194321
	.cfi_def_cfa_offset 100
	pushl	$.LC2
	.cfi_def_cfa_offset 104
	leal	17(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	leal	-200(%edi), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	addl	%ebx, %eax
	pushl	%eax
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$32, %esp
	.cfi_def_cfa_offset 80
	pushl	$2968144
	.cfi_def_cfa_offset 84
	pushl	%edi
	.cfi_def_cfa_offset 88
	leal	74(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	gfx_hline
	pushl	$.LC3
	.cfi_def_cfa_offset 100
	pushl	$.LC4
	.cfi_def_cfa_offset 104
	pushl	$40
	.cfi_def_cfa_offset 108
	leal	36(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 112
	call	ksnprintf
	addl	$20, %ebx
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$11194321
	.cfi_def_cfa_offset 100
	pushl	%edi
	.cfi_def_cfa_offset 104
	leal	92(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$11194321
	.cfi_def_cfa_offset 100
	pushl	$.LC5
	.cfi_def_cfa_offset 104
	leal	108(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$5996420
	.cfi_def_cfa_offset 100
	pushl	$.LC6
	.cfi_def_cfa_offset 104
	leal	132(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$5996420
	.cfi_def_cfa_offset 100
	pushl	$.LC7
	.cfi_def_cfa_offset 104
	leal	144(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$5996420
	.cfi_def_cfa_offset 100
	pushl	$.LC8
	.cfi_def_cfa_offset 104
	leal	156(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$32, %esp
	.cfi_def_cfa_offset 80
	call	timer_ms
	movl	%eax, %ecx
	subl	$8, %esp
	.cfi_def_cfa_offset 88
	movl	$274877907, %eax
	mull	%ecx
	movl	%edx, %eax
	shrl	$6, %eax
	movl	$60, %ebp
	xorl	%edx, %edx
	divl	%ebp
	pushl	%edx
	.cfi_def_cfa_offset 92
	movl	$1172812403, %eax
	mull	%ecx
	movl	%edx, %eax
	shrl	$14, %eax
	xorl	%edx, %edx
	divl	%ebp
	pushl	%edx
	.cfi_def_cfa_offset 96
	movl	$-1792967503, %ebp
	movl	%ecx, %eax
	mull	%ebp
	movl	%edx, %eax
	shrl	$21, %eax
	pushl	%eax
	.cfi_def_cfa_offset 100
	pushl	$.LC9
	.cfi_def_cfa_offset 104
	pushl	$40
	.cfi_def_cfa_offset 108
	pushl	%edi
	.cfi_def_cfa_offset 112
	call	ksnprintf
	addl	$20, %esp
	.cfi_def_cfa_offset 92
	pushl	$1
	.cfi_def_cfa_offset 96
	pushl	$11194321
	.cfi_def_cfa_offset 100
	pushl	%edi
	.cfi_def_cfa_offset 104
	addl	$180, %esi
	pushl	%esi
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	gfx_text_scaled
	addl	$92, %esp
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
.LFE4:
	.size	paint, .-paint
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata.str1.1
.LC11:
	.string	"About DedOS"
	.section	.text.unlikely
.LCOLDB12:
	.text
.LHOTB12:
	.align 4
	.globl	app_about_open
	.type	app_about_open, @function
app_about_open:
.LFB7:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	movl	s_win, %eax
	testl	%eax, %eax
	je	.L9
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	gui_focus_window
	movl	s_win, %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L9:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	pushl	$210
	.cfi_def_cfa_offset 36
	pushl	$380
	.cfi_def_cfa_offset 40
	pushl	$.LC11
	.cfi_def_cfa_offset 44
	pushl	$APP
	.cfi_def_cfa_offset 48
	call	gui_create_window
	movl	%eax, s_win
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE7:
	.size	app_about_open, .-app_about_open
	.section	.text.unlikely
.LCOLDE12:
	.text
.LHOTE12:
	.section	.rodata
	.align 4
	.type	APP, @object
	.size	APP, 20
APP:
	.long	paint
	.long	0
	.long	0
	.long	tick
	.long	on_close
	.local	s_last_sec
	.comm	s_last_sec,4,4
	.local	s_win
	.comm	s_win,4,4
	.ident	"GCC: (GNU) 5.2.0"
