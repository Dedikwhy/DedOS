	.file	"shell.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.type	cmd_clear, @function
cmd_clear:
.LFB6:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	(%eax), %edx
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	jmp	*4(%edx)
	.cfi_endproc
.LFE6:
	.size	cmd_clear, .-cmd_clear
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.type	cmd_exit, @function
cmd_exit:
.LFB26:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	(%eax), %edx
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	jmp	*8(%edx)
	.cfi_endproc
.LFE26:
	.size	cmd_exit, .-cmd_exit
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.type	cmd_about, @function
cmd_about:
.LFB21:
	.cfi_startproc
	jmp	app_about_open
	.cfi_endproc
.LFE21:
	.size	cmd_about, .-cmd_about
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.type	cmd_terminal, @function
cmd_terminal:
.LFB20:
	.cfi_startproc
	jmp	app_terminal_open
	.cfi_endproc
.LFE20:
	.size	cmd_terminal, .-cmd_terminal
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.globl	sh_print
	.type	sh_print, @function
sh_print:
.LFB2:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$260, %esp
	.cfi_def_cfa_offset 272
	movl	272(%esp), %ebx
	leal	284(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 276
	pushl	284(%esp)
	.cfi_def_cfa_offset 280
	pushl	$256
	.cfi_def_cfa_offset 284
	leal	12(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 288
	call	kvsnprintf
	addl	$12, %esp
	.cfi_def_cfa_offset 276
	movl	(%ebx), %eax
	pushl	280(%esp)
	.cfi_def_cfa_offset 280
	pushl	%esi
	.cfi_def_cfa_offset 284
	pushl	4(%ebx)
	.cfi_def_cfa_offset 288
	call	*(%eax)
	addl	$276, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	sh_print, .-sh_print
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"HELL "
.LC6:
	.string	"\n"
.LC7:
	.string	"...okay, back to work.\n"
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.type	cmd_hell, @function
cmd_hell:
.LFB24:
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
	movl	32(%esp), %ebp
	movl	$10, %edi
	movl	$1717986919, %esi
	.align 4
.L8:
	xorl	%ebx, %ebx
	cmpl	$4, 8(%ebp)
	jle	.L12
	.align 4
.L13:
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	$.LC5
	.cfi_def_cfa_offset 40
	pushl	$3
	.cfi_def_cfa_offset 44
	pushl	%ebp
	.cfi_def_cfa_offset 48
	call	sh_print
	incl	%ebx
	movl	8(%ebp), %ecx
	movl	%ecx, %eax
	imull	%esi
	movl	%edx, %eax
	sarl	%eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	cmpl	%ebx, %eax
	jg	.L13
.L12:
	pushl	%eax
	.cfi_def_cfa_offset 36
	pushl	$.LC6
	.cfi_def_cfa_offset 40
	pushl	$3
	.cfi_def_cfa_offset 44
	pushl	%ebp
	.cfi_def_cfa_offset 48
	call	sh_print
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	decl	%edi
	jne	.L8
	movl	$.LC7, 40(%esp)
	movl	$1, 36(%esp)
	movl	%ebp, 32(%esp)
	addl	$12, %esp
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
	jmp	sh_print
	.cfi_endproc
.LFE24:
	.size	cmd_hell, .-cmd_hell
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.str1.1
.LC9:
	.string	"up %dh %02dm %02ds\n"
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.type	cmd_uptime, @function
cmd_uptime:
.LFB23:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	call	timer_ms
	movl	%eax, %ecx
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	movl	$274877907, %eax
	mull	%ecx
	movl	%edx, %eax
	shrl	$6, %eax
	movl	$60, %ebx
	xorl	%edx, %edx
	divl	%ebx
	pushl	%edx
	.cfi_def_cfa_offset 28
	movl	$1172812403, %eax
	mull	%ecx
	movl	%edx, %eax
	shrl	$14, %eax
	xorl	%edx, %edx
	divl	%ebx
	pushl	%edx
	.cfi_def_cfa_offset 32
	movl	$-1792967503, %ebx
	movl	%ecx, %eax
	mull	%ebx
	movl	%edx, %eax
	shrl	$21, %eax
	pushl	%eax
	.cfi_def_cfa_offset 36
	pushl	$.LC9
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	44(%esp)
	.cfi_def_cfa_offset 48
	call	sh_print
	addl	$40, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE23:
	.size	cmd_uptime, .-cmd_uptime
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC11:
	.string	"%04d-%02d-%02d %02d:%02d:%02d\n"
	.section	.text.unlikely
.LCOLDB12:
	.text
.LHOTB12:
	.align 4
	.type	cmd_date, @function
cmd_date:
.LFB22:
	.cfi_startproc
	subl	$56, %esp
	.cfi_def_cfa_offset 60
	leal	20(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	rtc_get
	popl	%eax
	.cfi_def_cfa_offset 60
	pushl	40(%esp)
	.cfi_def_cfa_offset 64
	pushl	40(%esp)
	.cfi_def_cfa_offset 68
	pushl	40(%esp)
	.cfi_def_cfa_offset 72
	pushl	40(%esp)
	.cfi_def_cfa_offset 76
	pushl	40(%esp)
	.cfi_def_cfa_offset 80
	pushl	40(%esp)
	.cfi_def_cfa_offset 84
	pushl	$.LC11
	.cfi_def_cfa_offset 88
	pushl	$0
	.cfi_def_cfa_offset 92
	pushl	92(%esp)
	.cfi_def_cfa_offset 96
	call	sh_print
	addl	$92, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE22:
	.size	cmd_date, .-cmd_date
	.section	.text.unlikely
.LCOLDE12:
	.text
.LHOTE12:
	.section	.rodata.str1.1
.LC13:
	.string	"0.4"
.LC14:
	.string	"DedOS %s\n"
	.section	.rodata.str1.4
	.align 4
.LC15:
	.string	"x86, Ring 0, VBE framebuffer desktop, RAM filesystem\n"
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.align 4
	.type	cmd_version, @function
cmd_version:
.LFB7:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %ebx
	pushl	$.LC13
	.cfi_def_cfa_offset 20
	pushl	$.LC14
	.cfi_def_cfa_offset 24
	pushl	$2
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	sh_print
	movl	$.LC15, 40(%esp)
	movl	$1, 36(%esp)
	movl	%ebx, 32(%esp)
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	sh_print
	.cfi_endproc
.LFE7:
	.size	cmd_version, .-cmd_version
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.rodata.str1.1
.LC17:
	.string	"Super, Alt+F1"
.LC18:
	.string	"DedOS menu"
.LC19:
	.string	"  %-20s %s\n"
	.section	.text.unlikely
.LCOLDB20:
	.text
.LHOTB20:
	.align 4
	.type	cmd_keys, @function
cmd_keys:
.LFB25:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	pushl	%edx
	.cfi_def_cfa_offset 16
	movl	16(%esp), %esi
	movl	$k.1529+12, %ebx
	movl	$.LC17, %edx
	movl	$.LC18, %eax
	jmp	.L25
	.align 4
.L27:
	movl	(%ebx), %eax
	movl	-4(%ebx), %edx
	addl	$8, %ebx
.L25:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	$.LC19
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	cmpl	$k.1529+84, %ebx
	jne	.L27
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
.LFE25:
	.size	cmd_keys, .-cmd_keys
	.section	.text.unlikely
.LCOLDE20:
	.text
.LHOTE20:
	.section	.rodata.str1.1
.LC21:
	.string	"%s: %s\n"
	.section	.text.unlikely
.LCOLDB22:
	.text
.LHOTB22:
	.align 4
	.type	err.part.0, @function
err.part.0:
.LFB30:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	%ecx
	.cfi_def_cfa_offset 32
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	$.LC21
	.cfi_def_cfa_offset 40
	pushl	$3
	.cfi_def_cfa_offset 44
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	sh_print
	addl	$44, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE30:
	.size	err.part.0, .-err.part.0
	.section	.text.unlikely
.LCOLDE22:
	.text
.LHOTE22:
	.section	.rodata.str1.1
.LC23:
	.string	"%s: %s: %s\n"
	.section	.text.unlikely
.LCOLDB24:
	.text
.LHOTB24:
	.align 4
	.type	err, @function
err:
.LFB3:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %ebx
	testl	%ebx, %ebx
	je	.L31
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%ecx
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	$.LC23
	.cfi_def_cfa_offset 40
	pushl	$3
	.cfi_def_cfa_offset 44
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L31:
	.cfi_restore_state
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	err.part.0
	.cfi_endproc
.LFE3:
	.size	err, .-err
	.section	.text.unlikely
.LCOLDE24:
	.text
.LHOTE24:
	.section	.rodata.str1.1
.LC25:
	.string	"path too long"
	.section	.text.unlikely
.LCOLDB26:
	.text
.LHOTB26:
	.align 4
	.type	path_of, @function
path_of:
.LFB4:
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
	movl	%eax, %ebx
	movl	%edx, %edi
	movl	%ecx, %esi
	pushl	%edx
	.cfi_def_cfa_offset 20
	pushl	20(%esp)
	.cfi_def_cfa_offset 24
	pushl	%ecx
	.cfi_def_cfa_offset 28
	addl	$12, %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	fs_resolve
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	js	.L39
	xorl	%eax, %eax
.L36:
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
.L39:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%esi
	.cfi_def_cfa_offset 32
	movl	$.LC25, %ecx
	movl	%edi, %edx
	movl	%ebx, %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	movl	$-1, %eax
	jmp	.L36
	.cfi_endproc
.LFE4:
	.size	path_of, .-path_of
	.section	.text.unlikely
.LCOLDE26:
	.text
.LHOTE26:
	.section	.rodata.str1.1
.LC27:
	.string	"notepad"
.LC28:
	.string	"is a directory"
	.section	.text.unlikely
.LCOLDB29:
	.text
.LHOTB29:
	.align 4
	.type	cmd_notepad, @function
cmd_notepad:
.LFB19:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %esi
	cmpl	$1, 84(%esp)
	jle	.L46
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	4(%esi), %ecx
	leal	12(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 96
	movl	$.LC27, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L40
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	fs_is_dir
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	je	.L43
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%esi)
	.cfi_def_cfa_offset 96
	movl	$.LC28, %ecx
	movl	$.LC27, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
.L40:
	addl	$68, %esp
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
.L46:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	$0
	.cfi_def_cfa_offset 96
	call	app_notepad_open
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
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
.L43:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	app_notepad_open
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE19:
	.size	cmd_notepad, .-cmd_notepad
	.section	.text.unlikely
.LCOLDE29:
	.text
.LHOTE29:
	.section	.rodata.str1.1
.LC30:
	.string	"files"
.LC31:
	.string	"not a directory"
	.section	.text.unlikely
.LCOLDB32:
	.text
.LHOTB32:
	.align 4
	.type	cmd_files, @function
cmd_files:
.LFB18:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %esi
	cmpl	$1, 84(%esp)
	jle	.L53
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	4(%esi), %ecx
	leal	12(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 96
	movl	$.LC30, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L47
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	fs_is_dir
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	jne	.L50
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%esi)
	.cfi_def_cfa_offset 96
	movl	$.LC31, %ecx
	movl	$.LC30, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
.L47:
	addl	$68, %esp
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
.L53:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	92(%esp), %eax
	addl	$12, %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	app_files_open
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
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
.L50:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	app_files_open
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
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
	.size	cmd_files, .-cmd_files
	.section	.text.unlikely
.LCOLDE32:
	.text
.LHOTE32:
	.section	.rodata.str1.1
.LC33:
	.string	"usage: open <path>"
.LC34:
	.string	"open"
.LC35:
	.string	"no such file or directory"
	.section	.text.unlikely
.LCOLDB36:
	.text
.LHOTB36:
	.align 4
	.type	cmd_open, @function
cmd_open:
.LFB17:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %esi
	cmpl	$1, 84(%esp)
	jle	.L60
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	4(%esi), %ecx
	leal	12(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 96
	movl	$.LC34, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L54
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	app_open_path
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L61
.L54:
	addl	$68, %esp
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
.L60:
	.cfi_restore_state
	movl	$.LC33, %ecx
	movl	$.LC34, %edx
	movl	80(%esp), %eax
	call	err.part.0
	addl	$68, %esp
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
.L61:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%esi)
	.cfi_def_cfa_offset 96
	movl	$.LC35, %ecx
	movl	$.LC34, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	jmp	.L54
	.cfi_endproc
.LFE17:
	.size	cmd_open, .-cmd_open
	.section	.text.unlikely
.LCOLDE36:
	.text
.LHOTE36:
	.section	.rodata.str1.1
.LC37:
	.string	"usage: rm <path>"
.LC38:
	.string	"rm"
.LC39:
	.string	"directory not empty"
.LC40:
	.string	"cannot remove /"
.LC41:
	.string	"/"
	.section	.text.unlikely
.LCOLDB42:
	.text
.LHOTB42:
	.align 4
	.type	cmd_rm, @function
cmd_rm:
.LFB16:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %ebx
	cmpl	$1, 84(%esp)
	jle	.L77
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	4(%ebx), %ecx
	leal	12(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 96
	movl	$.LC38, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L62
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	fs_remove
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	cmpl	$-2, %eax
	je	.L66
	testl	%eax, %eax
	je	.L67
	cmpl	$-3, %eax
	je	.L78
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	movl	$.LC35, %ecx
	movl	$.LC38, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
.L67:
	movl	80(%esp), %eax
	leal	12(%eax), %ebx
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	fs_is_dir
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	je	.L79
.L62:
	addl	$68, %esp
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
.L77:
	.cfi_restore_state
	movl	$.LC37, %ecx
	movl	$.LC38, %edx
	movl	80(%esp), %eax
	call	err.part.0
	addl	$68, %esp
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
.L79:
	.cfi_restore_state
	pushl	%eax
	.cfi_def_cfa_offset 84
	pushl	$64
	.cfi_def_cfa_offset 88
	pushl	$.LC41
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
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
.L66:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	movl	$.LC39, %ecx
	movl	$.LC38, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	jmp	.L67
	.align 4
.L78:
	movl	$.LC40, %ecx
	movl	$.LC38, %edx
	movl	80(%esp), %eax
	call	err.part.0
	jmp	.L67
	.cfi_endproc
.LFE16:
	.size	cmd_rm, .-cmd_rm
	.section	.text.unlikely
.LCOLDE42:
	.text
.LHOTE42:
	.section	.rodata.str1.1
.LC43:
	.string	"usage: write <file> <text...>"
.LC44:
	.string	"write"
.LC45:
	.string	"filesystem full"
	.section	.rodata.str1.4
	.align 4
.LC46:
	.string	"cannot create (no such directory?)"
	.section	.rodata.str1.1
.LC47:
	.string	"not a file"
	.section	.text.unlikely
.LCOLDB48:
	.text
.LHOTB48:
	.align 4
	.type	cmd_write, @function
cmd_write:
.LFB15:
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
	subl	$2124, %esp
	.cfi_def_cfa_offset 2144
	movl	2152(%esp), %ebx
	cmpl	$2, 2148(%esp)
	jg	.L81
	movl	$.LC43, %ecx
	movl	$.LC44, %edx
	movl	2144(%esp), %eax
	call	err.part.0
.L80:
	addl	$2124, %esp
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
.L81:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 2156
	movl	4(%ebx), %ecx
	leal	12(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 2160
	movl	$.LC44, %edx
	movl	2160(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 2144
	testl	%eax, %eax
	js	.L80
	movl	$3, %edi
	xorl	%ebp, %ebp
	movl	-4(%ebx,%edi,4), %ecx
	movb	(%ecx), %dl
	testb	%dl, %dl
	je	.L96
	.align 4
.L104:
	cmpl	$2046, %ebp
	je	.L86
	movl	%ebp, %eax
	subl	%ebp, %ecx
	jmp	.L85
	.align 4
.L103:
	cmpl	$2046, %eax
	je	.L86
.L85:
	incl	%eax
	movb	%dl, 63(%esp,%eax)
	movb	(%ecx,%eax), %dl
	testb	%dl, %dl
	jne	.L103
.L84:
	cmpl	%edi, 2148(%esp)
	jle	.L87
	cmpl	$2046, %eax
	je	.L97
	leal	1(%eax), %ebp
	movb	$32, 64(%esp,%eax)
	incl	%edi
.L106:
	movl	-4(%ebx,%edi,4), %ecx
	movb	(%ecx), %dl
	testb	%dl, %dl
	jne	.L104
.L96:
	movl	%ebp, %eax
	jmp	.L84
	.align 4
.L86:
	cmpl	%edi, 2148(%esp)
	jle	.L105
.L97:
	movl	$2046, %ebp
	incl	%edi
	jmp	.L106
.L105:
	movl	$2046, %eax
.L87:
	leal	1(%eax), %edi
	movb	$10, 64(%esp,%eax)
	movb	$0, 64(%esp,%edi)
	subl	$12, %esp
	.cfi_def_cfa_offset 2156
	pushl	%esi
	.cfi_def_cfa_offset 2160
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 2144
	testl	%eax, %eax
	je	.L107
.L90:
	pushl	%eax
	.cfi_def_cfa_offset 2148
	pushl	%edi
	.cfi_def_cfa_offset 2152
	leal	72(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 2156
	pushl	%esi
	.cfi_def_cfa_offset 2160
	call	fs_write
	addl	$16, %esp
	.cfi_def_cfa_offset 2144
	testl	%eax, %eax
	jns	.L80
	subl	$12, %esp
	.cfi_def_cfa_offset 2156
	pushl	4(%ebx)
	.cfi_def_cfa_offset 2160
	movl	$.LC47, %ecx
	movl	$.LC44, %edx
	movl	2160(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 2144
	jmp	.L80
.L107:
	subl	$12, %esp
	.cfi_def_cfa_offset 2156
	pushl	%esi
	.cfi_def_cfa_offset 2160
	call	fs_create
	addl	$16, %esp
	.cfi_def_cfa_offset 2144
	cmpl	$-2, %eax
	je	.L108
	testl	%eax, %eax
	jns	.L90
	subl	$12, %esp
	.cfi_def_cfa_offset 2156
	pushl	4(%ebx)
	.cfi_def_cfa_offset 2160
	movl	$.LC46, %ecx
	movl	$.LC44, %edx
	movl	2160(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 2144
	jmp	.L80
.L108:
	movl	$.LC45, %ecx
	movl	$.LC44, %edx
	movl	2144(%esp), %eax
	call	err.part.0
	jmp	.L80
	.cfi_endproc
.LFE15:
	.size	cmd_write, .-cmd_write
	.section	.text.unlikely
.LCOLDE48:
	.text
.LHOTE48:
	.section	.rodata.str1.1
.LC49:
	.string	"usage: mkdir <dir>"
.LC50:
	.string	"mkdir"
.LC51:
	.string	"already exists"
	.section	.text.unlikely
.LCOLDB52:
	.text
.LHOTB52:
	.align 4
	.type	cmd_mkdir, @function
cmd_mkdir:
.LFB14:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %ebx
	cmpl	$1, 84(%esp)
	jle	.L123
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	4(%ebx), %ecx
	leal	12(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 96
	movl	$.LC50, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L109
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	fs_mkdir
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	cmpl	$-1, %eax
	je	.L113
	testl	%eax, %eax
	je	.L109
	cmpl	$-2, %eax
	je	.L124
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	movl	$.LC46, %ecx
	movl	$.LC50, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
.L109:
	addl	$68, %esp
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
.L123:
	.cfi_restore_state
	movl	$.LC49, %ecx
	movl	$.LC50, %edx
	movl	80(%esp), %eax
	call	err.part.0
	addl	$68, %esp
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
.L113:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	movl	$.LC51, %ecx
	movl	$.LC50, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	jmp	.L109
	.align 4
.L124:
	movl	$.LC45, %ecx
	movl	$.LC50, %edx
	movl	80(%esp), %eax
	call	err.part.0
	jmp	.L109
	.cfi_endproc
.LFE14:
	.size	cmd_mkdir, .-cmd_mkdir
	.section	.text.unlikely
.LCOLDE52:
	.text
.LHOTE52:
	.section	.rodata.str1.1
.LC53:
	.string	"usage: touch <file>"
.LC54:
	.string	"touch"
	.section	.text.unlikely
.LCOLDB55:
	.text
.LHOTB55:
	.align 4
	.type	cmd_touch, @function
cmd_touch:
.LFB13:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %ebx
	cmpl	$1, 84(%esp)
	jle	.L139
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	movl	4(%ebx), %ecx
	leal	12(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 96
	movl	$.LC54, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L125
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	fs_create
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	cmpl	$-1, %eax
	je	.L129
	testl	%eax, %eax
	je	.L125
	cmpl	$-2, %eax
	je	.L140
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	movl	$.LC46, %ecx
	movl	$.LC54, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
.L125:
	addl	$68, %esp
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
.L139:
	.cfi_restore_state
	movl	$.LC53, %ecx
	movl	$.LC54, %edx
	movl	80(%esp), %eax
	call	err.part.0
	addl	$68, %esp
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
.L129:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	movl	$.LC51, %ecx
	movl	$.LC54, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	jmp	.L125
	.align 4
.L140:
	movl	$.LC45, %ecx
	movl	$.LC54, %edx
	movl	80(%esp), %eax
	call	err.part.0
	jmp	.L125
	.cfi_endproc
.LFE13:
	.size	cmd_touch, .-cmd_touch
	.section	.text.unlikely
.LCOLDE55:
	.text
.LHOTE55:
	.section	.rodata.str1.1
.LC56:
	.string	"~"
.LC57:
	.string	"cd"
.LC58:
	.string	"no such directory"
	.section	.text.unlikely
.LCOLDB59:
	.text
.LHOTB59:
	.align 4
	.type	cmd_cd, @function
cmd_cd:
.LFB10:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	88(%esp), %esi
	cmpl	$1, 84(%esp)
	jle	.L148
	movl	4(%esi), %ecx
.L142:
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	leal	12(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 96
	movl	$.LC57, %edx
	movl	96(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	js	.L141
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%ebx
	.cfi_def_cfa_offset 96
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	je	.L151
	cmpb	$0, 2088(%eax)
	jne	.L146
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%esi)
	.cfi_def_cfa_offset 96
	movl	$.LC31, %ecx
	movl	$.LC57, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
.L141:
	addl	$68, %esp
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
.L148:
	.cfi_restore_state
	movl	$.LC56, %ecx
	jmp	.L142
	.align 4
.L151:
	xorl	%eax, %eax
	cmpl	$1, 84(%esp)
	setg	%al
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	(%esi,%eax,4)
	.cfi_def_cfa_offset 96
	movl	$.LC58, %ecx
	movl	$.LC57, %edx
	movl	96(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	jmp	.L141
	.align 4
.L146:
	pushl	%eax
	.cfi_def_cfa_offset 84
	pushl	$64
	.cfi_def_cfa_offset 88
	pushl	%ebx
	.cfi_def_cfa_offset 92
	movl	92(%esp), %eax
	addl	$12, %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE10:
	.size	cmd_cd, .-cmd_cd
	.section	.text.unlikely
.LCOLDE59:
	.text
.LHOTE59:
	.section	.rodata.str1.1
.LC60:
	.string	" "
.LC61:
	.string	"%s%s"
.LC62:
	.string	""
	.section	.text.unlikely
.LCOLDB63:
	.text
.LHOTB63:
	.align 4
	.type	cmd_echo, @function
cmd_echo:
.LFB8:
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
	movl	32(%esp), %edi
	movl	36(%esp), %esi
	movl	40(%esp), %ebp
	cmpl	$1, %esi
	jle	.L153
	movl	$1, %ebx
	jmp	.L156
	.align 4
.L154:
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$.LC60
	.cfi_def_cfa_offset 48
	pushl	-4(%ebp,%ebx,4)
	.cfi_def_cfa_offset 52
	pushl	$.LC61
	.cfi_def_cfa_offset 56
	pushl	$0
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 32
.L156:
	incl	%ebx
	cmpl	%ebx, %esi
	jne	.L154
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$.LC62
	.cfi_def_cfa_offset 48
	pushl	-4(%ebp,%esi,4)
	.cfi_def_cfa_offset 52
	pushl	$.LC61
	.cfi_def_cfa_offset 56
	pushl	$0
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 32
.L153:
	movl	$.LC6, 40(%esp)
	movl	$0, 36(%esp)
	movl	%edi, 32(%esp)
	addl	$12, %esp
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
	jmp	sh_print
	.cfi_endproc
.LFE8:
	.size	cmd_echo, .-cmd_echo
	.section	.text.unlikely
.LCOLDE63:
	.text
.LHOTE63:
	.section	.rodata.str1.1
.LC64:
	.string	"usage: cat <file>"
.LC65:
	.string	"cat"
.LC66:
	.string	"no such file"
.LC67:
	.string	"%s"
	.section	.text.unlikely
.LCOLDB68:
	.text
.LHOTB68:
	.align 4
	.type	cmd_cat, @function
cmd_cat:
.LFB12:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$84, %esp
	.cfi_def_cfa_offset 96
	movl	104(%esp), %ebx
	cmpl	$1, 100(%esp)
	jle	.L171
	subl	$12, %esp
	.cfi_def_cfa_offset 108
	movl	4(%ebx), %ecx
	leal	28(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 112
	movl	$.LC65, %edx
	movl	112(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	testl	%eax, %eax
	js	.L160
	subl	$12, %esp
	.cfi_def_cfa_offset 108
	pushl	%esi
	.cfi_def_cfa_offset 112
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	testl	%eax, %eax
	je	.L172
	cmpb	$0, 2088(%eax)
	jne	.L173
	leal	32(%eax), %edx
	movl	%eax, 12(%esp)
	pushl	%edx
	.cfi_def_cfa_offset 100
	pushl	$.LC67
	.cfi_def_cfa_offset 104
	pushl	$0
	.cfi_def_cfa_offset 108
	pushl	108(%esp)
	.cfi_def_cfa_offset 112
	call	sh_print
	movl	28(%esp), %eax
	movl	2080(%eax), %edx
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	testl	%edx, %edx
	je	.L160
	cmpb	$10, 31(%eax,%edx)
	je	.L160
	pushl	%eax
	.cfi_def_cfa_offset 100
	pushl	$.LC6
	.cfi_def_cfa_offset 104
	pushl	$0
	.cfi_def_cfa_offset 108
	pushl	108(%esp)
	.cfi_def_cfa_offset 112
	call	sh_print
	addl	$16, %esp
	.cfi_def_cfa_offset 96
.L160:
	addl	$84, %esp
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
.L171:
	.cfi_restore_state
	movl	$.LC64, %ecx
	movl	(%ebx), %edx
	movl	96(%esp), %eax
	call	err.part.0
	addl	$84, %esp
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
.L173:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 108
	pushl	4(%ebx)
	.cfi_def_cfa_offset 112
	movl	$.LC28, %ecx
	movl	$.LC65, %edx
	movl	112(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	addl	$84, %esp
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
.L172:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 108
	pushl	4(%ebx)
	.cfi_def_cfa_offset 112
	movl	$.LC66, %ecx
	movl	$.LC65, %edx
	movl	112(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	jmp	.L160
	.cfi_endproc
.LFE12:
	.size	cmd_cat, .-cmd_cat
	.section	.text.unlikely
.LCOLDE68:
	.text
.LHOTE68:
	.section	.rodata.str1.1
.LC69:
	.string	"%s\n"
	.section	.text.unlikely
.LCOLDB70:
	.text
.LHOTB70:
	.align 4
	.type	cmd_pwd, @function
cmd_pwd:
.LFB9:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %eax
	leal	12(%eax), %edx
	pushl	%edx
	.cfi_def_cfa_offset 20
	pushl	$.LC69
	.cfi_def_cfa_offset 24
	pushl	$0
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	sh_print
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE9:
	.size	cmd_pwd, .-cmd_pwd
	.section	.text.unlikely
.LCOLDE70:
	.text
.LHOTE70:
	.section	.rodata.str1.1
.LC71:
	.string	"."
.LC72:
	.string	"-l"
.LC73:
	.string	"ls"
.LC74:
	.string	"(empty)\n"
.LC75:
	.string	"-"
.LC76:
	.string	"d %6s  %s/\n"
.LC77:
	.string	"- %6u  %s\n"
.LC78:
	.string	"%s%s  "
	.section	.text.unlikely
.LCOLDB79:
	.text
.LHOTB79:
	.align 4
	.type	cmd_ls, @function
cmd_ls:
.LFB11:
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
	subl	$348, %esp
	.cfi_def_cfa_offset 368
	movl	376(%esp), %esi
	cmpl	$1, 372(%esp)
	jle	.L197
	movl	$1, %edi
	movl	$.LC71, %ebp
	xorl	%ebx, %ebx
	jmp	.L179
	.align 4
.L208:
	movl	(%esi,%edi,4), %ebp
	incl	%edi
	cmpl	%edi, 372(%esp)
	je	.L177
.L179:
	subl	$8, %esp
	.cfi_def_cfa_offset 376
	pushl	$.LC72
	.cfi_def_cfa_offset 380
	pushl	(%esi,%edi,4)
	.cfi_def_cfa_offset 384
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	testl	%eax, %eax
	jne	.L208
	movl	$1, %ebx
	incl	%edi
	cmpl	%edi, 372(%esp)
	jne	.L179
.L177:
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	leal	28(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 384
	movl	%ebp, %ecx
	movl	$.LC73, %edx
	movl	384(%esp), %eax
	call	path_of
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	testl	%eax, %eax
	js	.L176
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	pushl	%esi
	.cfi_def_cfa_offset 384
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	testl	%eax, %eax
	je	.L209
	cmpb	$0, 2088(%eax)
	jne	.L182
	pushl	%ebp
	.cfi_def_cfa_offset 372
	pushl	$.LC69
	.cfi_def_cfa_offset 376
	pushl	$0
	.cfi_def_cfa_offset 380
	pushl	380(%esp)
	.cfi_def_cfa_offset 384
	call	sh_print
	addl	$16, %esp
	.cfi_def_cfa_offset 368
.L176:
	addl	$348, %esp
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
.L182:
	.cfi_restore_state
	pushl	%edi
	.cfi_def_cfa_offset 372
	pushl	$64
	.cfi_def_cfa_offset 376
	leal	88(%esp), %ebp
	pushl	%ebp
	.cfi_def_cfa_offset 380
	pushl	%esi
	.cfi_def_cfa_offset 384
	call	fs_readdir
	movl	%eax, 20(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	cmpl	$0, %eax
	je	.L183
	jle	.L194
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	.L193
	.align 4
.L210:
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	pushl	%eax
	.cfi_def_cfa_offset 384
	pushl	$.LC75
	.cfi_def_cfa_offset 388
	pushl	$.LC76
	.cfi_def_cfa_offset 392
	pushl	$4
	.cfi_def_cfa_offset 396
	pushl	396(%esp)
	.cfi_def_cfa_offset 400
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 368
.L189:
	incl	%esi
	cmpl	%esi, 4(%esp)
	je	.L194
.L193:
	testl	%ebx, %ebx
	je	.L187
	movl	0(%ebp,%esi,4), %eax
	cmpb	$0, 2088(%eax)
	jne	.L210
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	pushl	%eax
	.cfi_def_cfa_offset 384
	pushl	2080(%eax)
	.cfi_def_cfa_offset 388
	pushl	$.LC77
	.cfi_def_cfa_offset 392
	pushl	$0
	.cfi_def_cfa_offset 396
	pushl	396(%esp)
	.cfi_def_cfa_offset 400
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 368
	incl	%esi
	cmpl	%esi, 4(%esp)
	jne	.L193
.L194:
	testl	%ebx, %ebx
	jne	.L176
	pushl	%eax
	.cfi_def_cfa_offset 372
	pushl	$.LC6
	.cfi_def_cfa_offset 376
	pushl	$0
	.cfi_def_cfa_offset 380
	pushl	380(%esp)
	.cfi_def_cfa_offset 384
	call	sh_print
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	jmp	.L176
.L183:
	pushl	%ecx
	.cfi_def_cfa_offset 372
	pushl	$.LC74
	.cfi_def_cfa_offset 376
	pushl	$1
	.cfi_def_cfa_offset 380
	pushl	380(%esp)
	.cfi_def_cfa_offset 384
	call	sh_print
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	jmp	.L176
	.align 4
.L187:
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	pushl	0(%ebp,%esi,4)
	.cfi_def_cfa_offset 384
	call	strlen
	movl	0(%ebp,%esi,4), %ecx
	movb	2088(%ecx), %dl
	movb	%dl, 27(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	testb	%dl, %dl
	setne	%dl
	movzbl	%dl, %edx
	addl	%edx, %eax
	movl	%eax, 12(%esp)
	testl	%edi, %edi
	je	.L190
	leal	1(%edi,%eax), %eax
	movl	368(%esp), %edx
	cmpl	8(%edx), %eax
	jge	.L211
.L190:
	cmpb	$0, 11(%esp)
	je	.L212
	movl	$.LC41, %edx
	movl	$4, %eax
.L196:
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	pushl	%edx
	.cfi_def_cfa_offset 384
	pushl	%ecx
	.cfi_def_cfa_offset 388
	pushl	$.LC78
	.cfi_def_cfa_offset 392
	pushl	%eax
	.cfi_def_cfa_offset 396
	pushl	396(%esp)
	.cfi_def_cfa_offset 400
	call	sh_print
	movl	44(%esp), %eax
	leal	2(%edi,%eax), %edi
	addl	$32, %esp
	.cfi_def_cfa_offset 368
	jmp	.L189
	.align 4
.L212:
	movl	$.LC62, %edx
	xorl	%eax, %eax
	jmp	.L196
.L197:
	movl	$.LC71, %ebp
	xorl	%ebx, %ebx
	jmp	.L177
.L211:
	pushl	%edx
	.cfi_def_cfa_offset 372
	pushl	$.LC6
	.cfi_def_cfa_offset 376
	pushl	$0
	.cfi_def_cfa_offset 380
	pushl	380(%esp)
	.cfi_def_cfa_offset 384
	call	sh_print
	movl	0(%ebp,%esi,4), %ecx
	movb	2088(%ecx), %al
	movb	%al, 27(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	xorl	%edi, %edi
	jmp	.L190
.L209:
	subl	$12, %esp
	.cfi_def_cfa_offset 380
	pushl	%ebp
	.cfi_def_cfa_offset 384
	movl	$.LC35, %ecx
	movl	$.LC73, %edx
	movl	384(%esp), %eax
	call	err
	addl	$16, %esp
	.cfi_def_cfa_offset 368
	jmp	.L176
	.cfi_endproc
.LFE11:
	.size	cmd_ls, .-cmd_ls
	.section	.text.unlikely
.LCOLDE79:
	.text
.LHOTE79:
	.section	.rodata.str1.1
.LC80:
	.string	"help"
	.section	.text.unlikely
.LCOLDB81:
	.text
.LHOTB81:
	.align 4
	.type	cmd_help, @function
cmd_help:
.LFB5:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	pushl	%ecx
	.cfi_def_cfa_offset 16
	movl	16(%esp), %esi
	movl	$.LC80, %eax
	movl	$COMMANDS, %ebx
	jmp	.L216
	.align 4
.L221:
	movl	4(%ebx), %eax
.L216:
	testl	%eax, %eax
	je	.L214
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	8(%ebx)
	.cfi_def_cfa_offset 32
	pushl	%eax
	.cfi_def_cfa_offset 36
	pushl	$.LC19
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	sh_print
	addl	$32, %esp
	.cfi_def_cfa_offset 16
.L214:
	addl	$16, %ebx
	movl	(%ebx), %edx
	testl	%edx, %edx
	jne	.L221
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
.LFE5:
	.size	cmd_help, .-cmd_help
	.section	.text.unlikely
.LCOLDE81:
	.text
.LHOTE81:
	.section	.rodata.str1.1
.LC82:
	.string	"/home"
	.section	.text.unlikely
.LCOLDB83:
	.text
.LHOTB83:
	.align 4
	.globl	shell_init
	.type	shell_init, @function
shell_init:
.LFB27:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	8(%esp), %edx
	movl	%edx, (%eax)
	movl	12(%esp), %edx
	movl	%edx, 4(%eax)
	movl	16(%esp), %edx
	movl	%edx, 8(%eax)
	movl	$64, 12(%esp)
	movl	$.LC82, 8(%esp)
	addl	$12, %eax
	movl	%eax, 4(%esp)
	jmp	strlcpy
	.cfi_endproc
.LFE27:
	.size	shell_init, .-shell_init
	.section	.text.unlikely
.LCOLDE83:
	.text
.LHOTE83:
	.section	.rodata.str1.4
	.align 4
.LC84:
	.string	"%s: command not found (try 'help')\n"
	.section	.text.unlikely
.LCOLDB85:
	.text
.LHOTB85:
	.align 4
	.globl	shell_exec
	.type	shell_exec, @function
shell_exec:
.LFB28:
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
	subl	$100, %esp
	.cfi_def_cfa_offset 116
	pushl	$24
	.cfi_def_cfa_offset 120
	leal	8(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 124
	pushl	128(%esp)
	.cfi_def_cfa_offset 128
	call	tokenize
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	testl	%eax, %eax
	je	.L223
	movl	%eax, %esi
	movl	$.LC80, %eax
	movl	$COMMANDS, %ebx
	jmp	.L226
	.align 4
.L225:
	addl	$16, %ebx
	movl	(%ebx), %eax
	testl	%eax, %eax
	je	.L233
.L226:
	subl	$8, %esp
	.cfi_def_cfa_offset 120
	pushl	%eax
	.cfi_def_cfa_offset 124
	pushl	12(%esp)
	.cfi_def_cfa_offset 128
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	testl	%eax, %eax
	jne	.L225
	pushl	%eax
	.cfi_def_cfa_offset 116
	pushl	%edi
	.cfi_def_cfa_offset 120
	pushl	%esi
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	*12(%ebx)
	addl	$16, %esp
	.cfi_def_cfa_offset 112
.L223:
	addl	$96, %esp
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
.L233:
	.cfi_restore_state
	pushl	(%esp)
	.cfi_def_cfa_offset 116
	pushl	$.LC84
	.cfi_def_cfa_offset 120
	pushl	$3
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	sh_print
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	addl	$96, %esp
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
	.cfi_endproc
.LFE28:
	.size	shell_exec, .-shell_exec
	.section	.text.unlikely
.LCOLDE85:
	.text
.LHOTE85:
	.section	.rodata.str1.1
.LC86:
	.string	"/home/"
.LC87:
	.string	"ded@dedos:%s$ "
	.section	.text.unlikely
.LCOLDB88:
	.text
.LHOTB88:
	.align 4
	.globl	shell_prompt
	.type	shell_prompt, @function
shell_prompt:
.LFB29:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$92, %esp
	.cfi_def_cfa_offset 104
	movl	104(%esp), %esi
	leal	12(%esi), %ebx
	pushl	$.LC82
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	testl	%eax, %eax
	je	.L239
	pushl	%ecx
	.cfi_def_cfa_offset 100
	pushl	$6
	.cfi_def_cfa_offset 104
	pushl	$.LC86
	.cfi_def_cfa_offset 108
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	strncmp
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	testl	%eax, %eax
	je	.L240
	pushl	%eax
	.cfi_def_cfa_offset 100
	pushl	$66
	.cfi_def_cfa_offset 104
	pushl	%ebx
	.cfi_def_cfa_offset 108
	leal	26(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 96
.L236:
	pushl	%ebx
	.cfi_def_cfa_offset 100
	pushl	$.LC87
	.cfi_def_cfa_offset 104
	pushl	112(%esp)
	.cfi_def_cfa_offset 108
	pushl	112(%esp)
	.cfi_def_cfa_offset 112
	call	ksnprintf
	addl	$100, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L240:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -12
	.cfi_offset 6, -8
	movb	$126, 14(%esp)
	pushl	%edx
	.cfi_def_cfa_offset 100
	pushl	$65
	.cfi_def_cfa_offset 104
	addl	$17, %esi
	pushl	%esi
	.cfi_def_cfa_offset 108
	leal	27(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 112
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	leal	14(%esp), %ebx
	jmp	.L236
	.align 4
.L239:
	pushl	%ebx
	.cfi_def_cfa_offset 100
	pushl	$66
	.cfi_def_cfa_offset 104
	pushl	$.LC56
	.cfi_def_cfa_offset 108
	leal	26(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 112
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 96
	jmp	.L236
	.cfi_endproc
.LFE29:
	.size	shell_prompt, .-shell_prompt
	.section	.text.unlikely
.LCOLDE88:
	.text
.LHOTE88:
	.section	.rodata.str1.1
.LC89:
	.string	"Alt+F2, Ctrl+Alt+T"
.LC90:
	.string	"new Terminal"
.LC91:
	.string	"Alt+F3, Ctrl+Alt+F"
.LC92:
	.string	"Files"
.LC93:
	.string	"Ctrl+Alt+N"
.LC94:
	.string	"Notepad"
.LC95:
	.string	"Alt+Tab"
	.section	.rodata.str1.4
	.align 4
.LC96:
	.string	"next window (Shift: send to back)"
	.section	.rodata.str1.1
.LC97:
	.string	"Alt+1..9"
.LC98:
	.string	"focus window by number"
.LC99:
	.string	"Alt+F4"
.LC100:
	.string	"close window"
.LC101:
	.string	"Alt+C"
.LC102:
	.string	"center window"
.LC103:
	.string	"Ctrl+Alt+Arrows"
.LC104:
	.string	"move window"
.LC105:
	.string	"Right click"
	.section	.rodata.str1.4
	.align 4
.LC106:
	.string	"context menu (desktop, window, apps)"
	.section	.rodata
	.align 32
	.type	k.1529, @object
	.size	k.1529, 80
k.1529:
	.long	.LC17
	.long	.LC18
	.long	.LC89
	.long	.LC90
	.long	.LC91
	.long	.LC92
	.long	.LC93
	.long	.LC94
	.long	.LC95
	.long	.LC96
	.long	.LC97
	.long	.LC98
	.long	.LC99
	.long	.LC100
	.long	.LC101
	.long	.LC102
	.long	.LC103
	.long	.LC104
	.long	.LC105
	.long	.LC106
	.section	.rodata.str1.1
.LC107:
	.string	"list commands"
.LC108:
	.string	"ls [-l] [path]"
.LC109:
	.string	"list directory"
.LC110:
	.string	"cd [path]"
.LC111:
	.string	"change directory (~ = /home)"
.LC112:
	.string	"pwd"
.LC113:
	.string	"print working directory"
.LC114:
	.string	"cat <file>"
.LC115:
	.string	"print file (also: read)"
.LC116:
	.string	"read"
.LC117:
	.string	"touch <file>"
.LC118:
	.string	"create empty file"
.LC119:
	.string	"mkdir <dir>"
.LC120:
	.string	"create directory"
.LC121:
	.string	"write <file> <txt>"
.LC122:
	.string	"replace file contents"
.LC123:
	.string	"rm <path>"
.LC124:
	.string	"remove file or empty dir"
.LC125:
	.string	"echo"
.LC126:
	.string	"echo <text>"
.LC127:
	.string	"print text"
.LC128:
	.string	"open <path>"
.LC129:
	.string	"open in Files / Notepad / app"
.LC130:
	.string	"files [path]"
.LC131:
	.string	"open Files"
.LC132:
	.string	"notepad [file]"
.LC133:
	.string	"open Notepad (also: edit)"
.LC134:
	.string	"edit"
.LC135:
	.string	"terminal"
.LC136:
	.string	"open another Terminal"
.LC137:
	.string	"about"
.LC138:
	.string	"about DedOS"
.LC139:
	.string	"keys"
.LC140:
	.string	"list hotkeys"
.LC141:
	.string	"version"
.LC142:
	.string	"print version"
.LC143:
	.string	"date"
.LC144:
	.string	"current date and time"
.LC145:
	.string	"uptime"
.LC146:
	.string	"time since boot"
.LC147:
	.string	"clear"
.LC148:
	.string	"clear the screen (Ctrl+L)"
.LC149:
	.string	"hell"
.LC150:
	.string	"exit"
.LC151:
	.string	"close this Terminal"
	.section	.rodata
	.align 32
	.type	COMMANDS, @object
	.size	COMMANDS, 400
COMMANDS:
	.long	.LC80
	.long	.LC80
	.long	.LC107
	.long	cmd_help
	.long	.LC73
	.long	.LC108
	.long	.LC109
	.long	cmd_ls
	.long	.LC57
	.long	.LC110
	.long	.LC111
	.long	cmd_cd
	.long	.LC112
	.long	.LC112
	.long	.LC113
	.long	cmd_pwd
	.long	.LC65
	.long	.LC114
	.long	.LC115
	.long	cmd_cat
	.long	.LC116
	.long	0
	.long	0
	.long	cmd_cat
	.long	.LC54
	.long	.LC117
	.long	.LC118
	.long	cmd_touch
	.long	.LC50
	.long	.LC119
	.long	.LC120
	.long	cmd_mkdir
	.long	.LC44
	.long	.LC121
	.long	.LC122
	.long	cmd_write
	.long	.LC38
	.long	.LC123
	.long	.LC124
	.long	cmd_rm
	.long	.LC125
	.long	.LC126
	.long	.LC127
	.long	cmd_echo
	.long	.LC34
	.long	.LC128
	.long	.LC129
	.long	cmd_open
	.long	.LC30
	.long	.LC130
	.long	.LC131
	.long	cmd_files
	.long	.LC27
	.long	.LC132
	.long	.LC133
	.long	cmd_notepad
	.long	.LC134
	.long	0
	.long	0
	.long	cmd_notepad
	.long	.LC135
	.long	.LC135
	.long	.LC136
	.long	cmd_terminal
	.long	.LC137
	.long	.LC137
	.long	.LC138
	.long	cmd_about
	.long	.LC139
	.long	.LC139
	.long	.LC140
	.long	cmd_keys
	.long	.LC141
	.long	.LC141
	.long	.LC142
	.long	cmd_version
	.long	.LC143
	.long	.LC143
	.long	.LC144
	.long	cmd_date
	.long	.LC145
	.long	.LC145
	.long	.LC146
	.long	cmd_uptime
	.long	.LC147
	.long	.LC147
	.long	.LC148
	.long	cmd_clear
	.long	.LC149
	.long	0
	.long	0
	.long	cmd_hell
	.long	.LC150
	.long	.LC150
	.long	.LC151
	.long	cmd_exit
	.long	0
	.long	0
	.long	0
	.long	0
	.ident	"GCC: (GNU) 5.2.0"
