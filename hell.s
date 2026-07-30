	.file	"hell.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"HELL"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	M_Hell
	.type	M_Hell, @function
M_Hell:
.LFB0:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$207
	.cfi_def_cfa_offset 32
	call	setcolor
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	.align 4
.L2:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC0
	.cfi_def_cfa_offset 32
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	M_Hell, .-M_Hell
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.comm	hell_mode,4,4
	.ident	"GCC: (GNU) 5.2.0"
