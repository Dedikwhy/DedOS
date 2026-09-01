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
	.string	"%s\n"
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.type	cmd_pwd, @function
cmd_pwd:
.LFB14:
	.cfi_startproc
	movl	$current_path, 8(%esp)
	movl	$.LC1, 4(%esp)
	jmp	print
	.cfi_endproc
.LFE14:
	.size	cmd_pwd, .-cmd_pwd
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1
.LC3:
	.string	"%s"
.LC4:
	.string	" "
.LC5:
	.string	"\n"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
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
	jle	.L4
	movl	$1, %ebx
	jmp	.L5
	.align 4
.L8:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC4
	.cfi_def_cfa_offset 32
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L5:
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	(%edi,%ebx,4)
	.cfi_def_cfa_offset 28
	pushl	$.LC3
	.cfi_def_cfa_offset 32
	call	print
	incl	%ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	%ebx, %esi
	jne	.L8
.L4:
	movl	$.LC5, 16(%esp)
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
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC7:
	.string	"This version of DedOS = 0.2 here! :3\n"
	.section	.rodata.str1.1
.LC8:
	.string	"New: RAM File System\n"
.LC9:
	.string	"Echo\n"
.LC10:
	.string	"Parser.\n"
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.type	cmd_version, @function
cmd_version:
.LFB3:
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
	movl	$.LC10, 32(%esp)
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE3:
	.size	cmd_version, .-cmd_version
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.str1.1
.LC12:
	.string	"Commands: \n"
.LC13:
	.string	"help\n"
.LC14:
	.string	"clear\n"
.LC15:
	.string	"version\n"
.LC16:
	.string	"echo <text>\n"
.LC17:
	.string	"ls\n"
.LC18:
	.string	"touch <file-name>\n"
.LC19:
	.string	"read <file-name>\n"
	.section	.rodata.str1.4
	.align 4
.LC20:
	.string	"write <file-name> <file-info>\n"
	.section	.rodata.str1.1
.LC21:
	.string	"rm <file-name>\n"
.LC22:
	.string	"mkdir <dir-name\n"
.LC23:
	.string	"cd <>\n"
.LC24:
	.string	"exit\n"
	.section	.text.unlikely
.LCOLDB25:
	.text
.LHOTB25:
	.align 4
	.type	cmd_help, @function
cmd_help:
.LFB1:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	print
	movl	$.LC13, (%esp)
	call	print
	movl	$.LC14, (%esp)
	call	print
	movl	$.LC15, (%esp)
	call	print
	movl	$.LC16, (%esp)
	call	print
	movl	$.LC17, (%esp)
	call	print
	movl	$.LC18, (%esp)
	call	print
	movl	$.LC19, (%esp)
	call	print
	movl	$.LC20, (%esp)
	call	print
	movl	$.LC21, (%esp)
	call	print
	movl	$.LC22, (%esp)
	call	print
	movl	$.LC23, (%esp)
	call	print
	movl	$.LC24, 32(%esp)
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE1:
	.size	cmd_help, .-cmd_help
	.section	.text.unlikely
.LCOLDE25:
	.text
.LHOTE25:
	.section	.rodata.str1.4
	.align 4
.LC26:
	.string	"Usage: write <filename> <text>\n"
	.section	.rodata.str1.1
.LC27:
	.string	"Wrote %d bytes to %s\n"
.LC28:
	.string	"File not found: %s\n"
	.section	.text.unlikely
.LCOLDB29:
	.text
.LHOTB29:
	.align 4
	.type	cmd_write, @function
cmd_write:
.LFB10:
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
	subl	$1036, %esp
	.cfi_def_cfa_offset 1056
	movl	1056(%esp), %edi
	movl	1060(%esp), %esi
	cmpl	$2, %edi
	jle	.L14
	movl	$3, %ebx
	xorl	%ebp, %ebp
	.align 4
.L15:
	movl	-4(%esi,%ebx,4), %ecx
	movb	(%ecx), %dl
	movl	%ebp, %eax
	testb	%dl, %dl
	je	.L17
	subl	%ebp, %ecx
	cmpl	$1021, %ebp
	jle	.L18
	jmp	.L19
	.align 4
.L34:
	cmpl	$1022, %eax
	je	.L19
.L18:
	incl	%eax
	movb	%dl, -1(%esp,%eax)
	movb	(%ecx,%eax), %dl
	testb	%dl, %dl
	jne	.L34
.L17:
	cmpl	%ebx, %edi
	jle	.L20
	cmpl	$1021, %eax
	jg	.L28
	leal	1(%eax), %ebp
	movb	$32, (%esp,%eax)
	incl	%ebx
	jmp	.L15
	.align 4
.L19:
	cmpl	%ebx, %edi
	jle	.L20
.L28:
	movl	%eax, %ebp
	incl	%ebx
	jmp	.L15
.L20:
	movb	$0, (%esp,%eax)
	pushl	%ecx
	.cfi_def_cfa_offset 1060
	pushl	%eax
	.cfi_def_cfa_offset 1064
	leal	8(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 1068
	pushl	4(%esi)
	.cfi_def_cfa_offset 1072
	call	fs_write
	addl	$16, %esp
	.cfi_def_cfa_offset 1056
	testl	%eax, %eax
	js	.L23
	pushl	%edx
	.cfi_def_cfa_offset 1060
	pushl	4(%esi)
	.cfi_def_cfa_offset 1064
	pushl	%eax
	.cfi_def_cfa_offset 1068
	pushl	$.LC27
	.cfi_def_cfa_offset 1072
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 1056
	addl	$1036, %esp
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
.L14:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 1068
	pushl	$.LC26
	.cfi_def_cfa_offset 1072
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 1056
	addl	$1036, %esp
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
.L23:
	.cfi_restore_state
	subl	$8, %esp
	.cfi_def_cfa_offset 1064
	pushl	4(%esi)
	.cfi_def_cfa_offset 1068
	pushl	$.LC28
	.cfi_def_cfa_offset 1072
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 1056
	addl	$1036, %esp
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
.LFE10:
	.size	cmd_write, .-cmd_write
	.section	.text.unlikely
.LCOLDE29:
	.text
.LHOTE29:
	.section	.text.unlikely
.LCOLDB30:
	.text
.LHOTB30:
	.align 4
	.type	cmd_ls, @function
cmd_ls:
.LFB7:
	.cfi_startproc
	movl	$current_path, 4(%esp)
	jmp	fs_list
	.cfi_endproc
.LFE7:
	.size	cmd_ls, .-cmd_ls
	.section	.text.unlikely
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely
.LCOLDB31:
	.text
.LHOTB31:
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
.LCOLDE31:
	.text
.LHOTE31:
	.section	.text.unlikely
.LCOLDB32:
	.text
.LHOTB32:
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
.LCOLDE32:
	.text
.LHOTE32:
	.section	.rodata.str1.1
.LC33:
	.string	"Current directory: %s\n"
.LC34:
	.string	"No such directory: %s\n"
	.section	.text.unlikely
.LCOLDB35:
	.text
.LHOTB35:
	.align 4
	.type	cmd_cd, @function
cmd_cd:
.LFB13:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	20(%esp), %ebx
	cmpl	$1, 16(%esp)
	jle	.L43
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$current_path
	.cfi_def_cfa_offset 28
	pushl	4(%ebx)
	.cfi_def_cfa_offset 32
	call	fs_cd
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L44
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L44:
	.cfi_restore_state
	movl	4(%ebx), %eax
	movl	%eax, 20(%esp)
	movl	$.LC34, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L43:
	.cfi_restore_state
	movl	$current_path, 20(%esp)
	movl	$.LC33, 16(%esp)
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE13:
	.size	cmd_cd, .-cmd_cd
	.section	.text.unlikely
.LCOLDE35:
	.text
.LHOTE35:
	.section	.rodata.str1.1
.LC36:
	.string	"Usage: mkdir <dirname>\n"
.LC37:
	.string	"Directory created: %s\n"
.LC38:
	.string	"Could not create directory\n"
	.section	.text.unlikely
.LCOLDB39:
	.text
.LHOTB39:
	.align 4
	.type	cmd_mkdir, @function
cmd_mkdir:
.LFB12:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	20(%esp), %ebx
	cmpl	$1, 16(%esp)
	jle	.L49
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$current_path
	.cfi_def_cfa_offset 28
	pushl	4(%ebx)
	.cfi_def_cfa_offset 32
	call	fs_mkdir
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L50
	movl	$.LC38, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L50:
	.cfi_restore_state
	movl	4(%ebx), %eax
	movl	%eax, 20(%esp)
	movl	$.LC37, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L49:
	.cfi_restore_state
	movl	$.LC36, 16(%esp)
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE12:
	.size	cmd_mkdir, .-cmd_mkdir
	.section	.text.unlikely
.LCOLDE39:
	.text
.LHOTE39:
	.section	.rodata.str1.1
.LC40:
	.string	"Usage: cat <filename>\n"
	.section	.text.unlikely
.LCOLDB41:
	.text
.LHOTB41:
	.align 4
	.type	cmd_read, @function
cmd_read:
.LFB9:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	20(%esp), %ebx
	cmpl	$1, 16(%esp)
	jle	.L55
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	4(%ebx)
	.cfi_def_cfa_offset 32
	call	fs_get
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L53
	addl	$32, %eax
	movl	%eax, 20(%esp)
	movl	$.LC1, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L55:
	.cfi_restore_state
	movl	$.LC40, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L53:
	.cfi_restore_state
	movl	4(%ebx), %eax
	movl	%eax, 20(%esp)
	movl	$.LC28, 16(%esp)
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE9:
	.size	cmd_read, .-cmd_read
	.section	.text.unlikely
.LCOLDE41:
	.text
.LHOTE41:
	.section	.rodata.str1.1
.LC42:
	.string	"Usage: touch <filename>\n"
.LC43:
	.string	"File created: %s\n"
.LC44:
	.string	"File already exists!\n"
.LC45:
	.string	"Disk full!\n"
	.section	.text.unlikely
.LCOLDB46:
	.text
.LHOTB46:
	.align 4
	.type	cmd_touch, @function
cmd_touch:
.LFB8:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	20(%esp), %ebx
	cmpl	$1, 16(%esp)
	jle	.L61
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$current_path
	.cfi_def_cfa_offset 28
	pushl	4(%ebx)
	.cfi_def_cfa_offset 32
	call	fs_create
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L62
	incl	%eax
	je	.L63
	movl	$.LC45, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L61:
	.cfi_restore_state
	movl	$.LC42, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L62:
	.cfi_restore_state
	movl	4(%ebx), %eax
	movl	%eax, 20(%esp)
	movl	$.LC43, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L63:
	.cfi_restore_state
	movl	$.LC44, 16(%esp)
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE8:
	.size	cmd_touch, .-cmd_touch
	.section	.text.unlikely
.LCOLDE46:
	.text
.LHOTE46:
	.section	.rodata.str1.1
.LC47:
	.string	"Usage: rm <filename>\n"
.LC48:
	.string	"Deleted file: %s\n"
	.section	.text.unlikely
.LCOLDB49:
	.text
.LHOTB49:
	.align 4
	.type	cmd_rm, @function
cmd_rm:
.LFB11:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	20(%esp), %ebx
	cmpl	$1, 16(%esp)
	jle	.L68
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	4(%ebx)
	.cfi_def_cfa_offset 32
	call	fs_remove
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	movl	4(%ebx), %eax
	movl	%eax, 20(%esp)
	js	.L66
	movl	$.LC48, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L66:
	.cfi_restore_state
	movl	$.LC28, 16(%esp)
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.align 4
.L68:
	.cfi_restore_state
	movl	$.LC47, 16(%esp)
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	print
	.cfi_endproc
.LFE11:
	.size	cmd_rm, .-cmd_rm
	.section	.text.unlikely
.LCOLDE49:
	.text
.LHOTE49:
	.section	.rodata.str1.1
.LC50:
	.string	"help"
.LC51:
	.string	"user> "
.LC52:
	.string	"Unknown command: %s\n"
	.section	.text.unlikely
.LCOLDB53:
	.text
.LHOTB53:
	.align 4
	.globl	terminal
	.type	terminal, @function
terminal:
.LFB16:
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
	subl	$96, %esp
	.cfi_def_cfa_offset 112
	call	first_draw
	movl	should_exit, %ebx
	testl	%ebx, %ebx
	jne	.L69
	movl	%esp, %edi
	.align 4
.L79:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	$.LC51
	.cfi_def_cfa_offset 128
	call	print
	popl	%edx
	.cfi_def_cfa_offset 124
	popl	%ecx
	.cfi_def_cfa_offset 120
	pushl	$64
	.cfi_def_cfa_offset 124
	pushl	$cmd
	.cfi_def_cfa_offset 128
	call	scan
	addl	$12, %esp
	.cfi_def_cfa_offset 116
	pushl	$24
	.cfi_def_cfa_offset 120
	pushl	%edi
	.cfi_def_cfa_offset 124
	pushl	$cmd
	.cfi_def_cfa_offset 128
	call	tokenize
	movl	%eax, %esi
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	testl	%eax, %eax
	je	.L71
	movl	$.LC50, %eax
	xorl	%ebx, %ebx
	jmp	.L74
	.align 4
.L84:
	movl	commands(,%ebx,8), %eax
.L74:
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
	je	.L83
	incl	%ebx
	cmpl	$14, %ebx
	jne	.L84
	subl	$8, %esp
	.cfi_def_cfa_offset 120
	pushl	8(%esp)
	.cfi_def_cfa_offset 124
	pushl	$.LC52
	.cfi_def_cfa_offset 128
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 112
.L71:
	movl	should_exit, %eax
	testl	%eax, %eax
	je	.L79
.L69:
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
.L83:
	.cfi_restore_state
	subl	$8, %esp
	.cfi_def_cfa_offset 120
	pushl	%edi
	.cfi_def_cfa_offset 124
	pushl	%esi
	.cfi_def_cfa_offset 128
	call	*commands+4(,%ebx,8)
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L71
	.cfi_endproc
.LFE16:
	.size	terminal, .-terminal
	.section	.text.unlikely
.LCOLDE53:
	.text
.LHOTE53:
	.section	.rodata.str1.1
.LC54:
	.string	"clear"
.LC55:
	.string	"version"
.LC56:
	.string	"exit"
.LC57:
	.string	"hell"
.LC58:
	.string	"echo"
.LC59:
	.string	"ls"
.LC60:
	.string	"touch"
.LC61:
	.string	"read"
.LC62:
	.string	"write"
.LC63:
	.string	"rm"
.LC64:
	.string	"mkdir"
.LC65:
	.string	"cd"
.LC66:
	.string	"pwd"
	.section	.rodata
	.align 32
	.type	commands, @object
	.size	commands, 112
commands:
	.long	.LC50
	.long	cmd_help
	.long	.LC54
	.long	cmd_clear
	.long	.LC55
	.long	cmd_version
	.long	.LC56
	.long	cmd_exit
	.long	.LC57
	.long	cmd_hell
	.long	.LC58
	.long	cmd_echo
	.long	.LC59
	.long	cmd_ls
	.long	.LC60
	.long	cmd_touch
	.long	.LC61
	.long	cmd_read
	.long	.LC62
	.long	cmd_write
	.long	.LC63
	.long	cmd_rm
	.long	.LC64
	.long	cmd_mkdir
	.long	.LC65
	.long	cmd_cd
	.long	.LC66
	.long	cmd_pwd
	.globl	current_path
	.data
	.align 32
	.type	current_path, @object
	.size	current_path, 64
current_path:
	.string	"/"
	.zero	62
	.local	should_exit
	.comm	should_exit,4,4
	.comm	cmd,64,32
	.ident	"GCC: (GNU) 5.2.0"
