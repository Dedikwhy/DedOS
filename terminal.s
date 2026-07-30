	.file	"terminal.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"user> "
.LC1:
	.string	"help"
.LC2:
	.string	"Commands: \n"
.LC3:
	.string	"Help\n"
.LC4:
	.string	"Clear\n"
.LC5:
	.string	"Version\n"
.LC6:
	.string	"Exit\n"
.LC7:
	.string	"clear"
.LC8:
	.string	"version"
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC9:
	.string	"This version of DedOS = 0.1 :3\n"
	.section	.rodata.str1.1
.LC10:
	.string	"exit"
.LC11:
	.string	"hell"
.LC12:
	.string	"Unknown command\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB13:
	.text
.LHOTB13:
	.align 4
	.globl	terminal
	.type	terminal, @function
terminal:
.LFB1:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	first_draw
	.align 4
.L2:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	call	print
	popl	%eax
	.cfi_def_cfa_offset 28
	popl	%edx
	.cfi_def_cfa_offset 24
	pushl	$64
	.cfi_def_cfa_offset 28
	pushl	$cmd
	.cfi_def_cfa_offset 32
	call	scan
	popl	%ecx
	.cfi_def_cfa_offset 28
	popl	%eax
	.cfi_def_cfa_offset 24
	pushl	$.LC1
	.cfi_def_cfa_offset 28
	pushl	$cmd
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L11
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$.LC7
	.cfi_def_cfa_offset 28
	pushl	$cmd
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L12
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$.LC8
	.cfi_def_cfa_offset 28
	pushl	$cmd
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L13
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$.LC10
	.cfi_def_cfa_offset 28
	pushl	$cmd
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L1
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$.LC11
	.cfi_def_cfa_offset 28
	pushl	$cmd
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L8
	call	M_Hell
	jmp	.L2
	.align 4
.L11:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC2
	.cfi_def_cfa_offset 32
	call	print
	movl	$.LC3, (%esp)
	call	print
	movl	$.LC4, (%esp)
	call	print
	movl	$.LC5, (%esp)
	call	print
	movl	$.LC6, (%esp)
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	jmp	.L2
	.align 4
.L12:
	call	clear
	call	first_draw
	jmp	.L2
	.align 4
.L8:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC12
	.cfi_def_cfa_offset 32
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	jmp	.L2
	.align 4
.L13:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC9
	.cfi_def_cfa_offset 32
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	jmp	.L2
	.align 4
.L1:
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	terminal, .-terminal
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.comm	cmd,64,32
	.ident	"GCC: (GNU) 5.2.0"
