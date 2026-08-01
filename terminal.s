	.file	"terminal.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.type	cmd_exit, @function
cmd_exit:
.LFB4:
	.cfi_startproc
	movl	$1, should_exit
	ret
	.cfi_endproc
.LFE4:
	.size	cmd_exit, .-cmd_exit
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%s"
.LC2:
	.string	" "
.LC3:
	.string	"\n"
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.type	cmd_echo, @function
cmd_echo:
.LFB6:
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
	movl	16(%esp), %esi
	movl	20(%esp), %edi
	cmpl	$1, %esi
	jle	.L3
	movl	$1, %ebx
	jmp	.L4
	.align 4
.L7:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC2
	.cfi_def_cfa_offset 32
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L4:
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	(%edi,%ebx,4)
	.cfi_def_cfa_offset 28
	pushl	$.LC1
	.cfi_def_cfa_offset 32
	call	print
	incl	%ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	%ebx, %esi
	jne	.L7
.L3:
	movl	$.LC3, 16(%esp)
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE6:
	.size	cmd_echo, .-cmd_echo
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC5:
	.string	"This version of DedOS = 0.1 :3\n"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.type	cmd_version, @function
cmd_version:
.LFB3:
	.cfi_startproc
	movl	$.LC5, 4(%esp)
	jmp	print
	.cfi_endproc
.LFE3:
	.size	cmd_version, .-cmd_version
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.1
.LC7:
	.string	"Commands: \n"
.LC8:
	.string	"help\n"
.LC9:
	.string	"clear\n"
.LC10:
	.string	"version\n"
.LC11:
	.string	"echo <text>\n"
.LC12:
	.string	"exit\n"
	.section	.text.unlikely
.LCOLDB13:
	.text
.LHOTB13:
	.align 4
	.type	cmd_help, @function
cmd_help:
.LFB1:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC7
	.cfi_def_cfa_offset 32
	call	print
	movl	$.LC8, (%esp)
	call	print
	movl	$.LC9, (%esp)
	call	print
	movl	$.LC10, (%esp)
	call	print
	movl	$.LC11, (%esp)
	call	print
	movl	$.LC12, 32(%esp)
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE1:
	.size	cmd_help, .-cmd_help
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.text.unlikely
.LCOLDB14:
	.text
.LHOTB14:
	.align 4
	.type	cmd_hell, @function
cmd_hell:
.LFB5:
	.cfi_startproc
	jmp	M_Hell
	.cfi_endproc
.LFE5:
	.size	cmd_hell, .-cmd_hell
	.section	.text.unlikely
.LCOLDE14:
	.text
.LHOTE14:
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.align 4
	.type	cmd_clear, @function
cmd_clear:
.LFB2:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	clear
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	jmp	first_draw
	.cfi_endproc
.LFE2:
	.size	cmd_clear, .-cmd_clear
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.rodata.str1.1
.LC16:
	.string	"help"
.LC17:
	.string	"user> "
.LC18:
	.string	"Unknown command: %s\n"
	.section	.text.unlikely
.LCOLDB19:
	.text
.LHOTB19:
	.align 4
	.globl	terminal
	.type	terminal, @function
terminal:
.LFB8:
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
	subl	$32, %esp
	.cfi_def_cfa_offset 48
	call	first_draw
	movl	should_exit, %ebx
	testl	%ebx, %ebx
	jne	.L14
	movl	%esp, %edi
	.align 4
.L24:
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$.LC17
	.cfi_def_cfa_offset 64
	call	print
	popl	%edx
	.cfi_def_cfa_offset 60
	popl	%ecx
	.cfi_def_cfa_offset 56
	pushl	$64
	.cfi_def_cfa_offset 60
	pushl	$cmd
	.cfi_def_cfa_offset 64
	call	scan
	addl	$12, %esp
	.cfi_def_cfa_offset 52
	pushl	$8
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	pushl	$cmd
	.cfi_def_cfa_offset 64
	call	tokenize
	movl	%eax, %esi
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	je	.L16
	movl	$.LC16, %eax
	xorl	%ebx, %ebx
.L19:
	subl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	%eax
	.cfi_def_cfa_offset 60
	pushl	12(%esp)
	.cfi_def_cfa_offset 64
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	je	.L28
	incl	%ebx
	cmpl	$6, %ebx
	je	.L18
	movl	commands(,%ebx,8), %eax
	jmp	.L19
	.align 4
.L18:
	subl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	8(%esp)
	.cfi_def_cfa_offset 60
	pushl	$.LC18
	.cfi_def_cfa_offset 64
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 48
.L16:
	movl	should_exit, %eax
	testl	%eax, %eax
	je	.L24
.L14:
	addl	$32, %esp
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
.L28:
	.cfi_restore_state
	subl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	pushl	%esi
	.cfi_def_cfa_offset 64
	call	*commands+4(,%ebx,8)
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	movl	should_exit, %eax
	testl	%eax, %eax
	je	.L24
	jmp	.L14
	.cfi_endproc
.LFE8:
	.size	terminal, .-terminal
	.section	.text.unlikely
.LCOLDE19:
	.text
.LHOTE19:
	.section	.rodata.str1.1
.LC20:
	.string	"clear"
.LC21:
	.string	"version"
.LC22:
	.string	"exit"
.LC23:
	.string	"hell"
.LC24:
	.string	"echo"
	.section	.rodata
	.align 32
	.type	commands, @object
	.size	commands, 48
commands:
	.long	.LC16
	.long	cmd_help
	.long	.LC20
	.long	cmd_clear
	.long	.LC21
	.long	cmd_version
	.long	.LC22
	.long	cmd_exit
	.long	.LC23
	.long	cmd_hell
	.long	.LC24
	.long	cmd_echo
	.local	should_exit
	.comm	should_exit,4,4
	.comm	cmd,64,32
	.ident	"GCC: (GNU) 5.2.0"
