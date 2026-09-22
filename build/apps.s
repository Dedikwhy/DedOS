	.file	"apps.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.type	open_notepad, @function
open_notepad:
.LFB3:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	call	app_notepad_open
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE3:
	.size	open_notepad, .-open_notepad
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.type	open_files, @function
open_files:
.LFB2:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	call	app_files_open
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	open_files, .-open_files
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"terminal"
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.globl	app_launch
	.type	app_launch, @function
app_launch:
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
	movl	16(%esp), %edi
	movl	$APP_LIST, %esi
	movl	$.LC2, %eax
	xorl	%ebx, %ebx
.L8:
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%edi
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L11
	incl	%ebx
	addl	$16, %esi
	cmpl	$4, %ebx
	je	.L7
	movl	(%esi), %eax
	jmp	.L8
	.align 4
.L7:
	xorl	%eax, %eax
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
.L11:
	.cfi_restore_state
	sall	$4, %ebx
	movl	APP_LIST+12(%ebx), %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	jmp	*%eax
	.cfi_endproc
.LFE4:
	.size	app_launch, .-app_launch
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.rodata.str1.1
.LC4:
	.string	".app"
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.globl	app_open_path
	.type	app_open_path, @function
app_open_path:
.LFB5:
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
	subl	$44, %esp
	.cfi_def_cfa_offset 60
	movl	60(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	je	.L20
	movl	%eax, %ebx
	cmpb	$0, 2088(%eax)
	jne	.L30
	subl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	$.LC4
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	str_ends_with
	movl	%eax, %esi
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	je	.L15
	pushl	%eax
	.cfi_def_cfa_offset 52
	pushl	$32
	.cfi_def_cfa_offset 56
	addl	$32, %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 60
	leal	12(%esp), %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 64
	call	strlcpy
	movl	%ebx, (%esp)
	call	strlen
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	je	.L18
	.align 4
.L25:
	decl	%eax
	movb	(%ebx,%eax), %dl
	cmpb	$10, %dl
	je	.L19
	cmpb	$32, %dl
	jne	.L18
.L19:
	movb	$0, (%ebx,%eax)
	testl	%eax, %eax
	jne	.L25
.L18:
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	%ebx
	.cfi_def_cfa_offset 64
	call	app_launch
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	negl	%eax
	movl	%eax, %esi
	movl	%esi, %eax
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
.L15:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	app_notepad_open
	addl	$16, %esp
	.cfi_def_cfa_offset 48
.L13:
	movl	%esi, %eax
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
.L30:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	app_files_open
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	xorl	%esi, %esi
	movl	%esi, %eax
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
.L20:
	.cfi_restore_state
	movl	$-1, %esi
	jmp	.L13
	.cfi_endproc
.LFE5:
	.size	app_open_path, .-app_open_path
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.globl	APP_COUNT
	.section	.rodata
	.align 4
	.type	APP_COUNT, @object
	.size	APP_COUNT, 4
APP_COUNT:
	.long	4
	.globl	APP_LIST
	.section	.rodata.str1.1
.LC6:
	.string	"Terminal"
.LC7:
	.string	"files"
.LC8:
	.string	"Files"
.LC9:
	.string	"notepad"
.LC10:
	.string	"Notepad"
.LC11:
	.string	"about"
.LC12:
	.string	"About"
	.section	.rodata
	.align 32
	.type	APP_LIST, @object
	.size	APP_LIST, 64
APP_LIST:
	.long	.LC2
	.long	.LC6
	.long	0
	.long	app_terminal_open
	.long	.LC7
	.long	.LC8
	.long	1
	.long	open_files
	.long	.LC9
	.long	.LC10
	.long	2
	.long	open_notepad
	.long	.LC11
	.long	.LC12
	.long	3
	.long	app_about_open
	.ident	"GCC: (GNU) 5.2.0"
