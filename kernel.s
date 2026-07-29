	.file	"kernel.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	kernel_main
	.type	kernel_main, @function
kernel_main:
.LFB1:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	clear
	call	disable_cursor
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	jmp	terminal
	.cfi_endproc
.LFE1:
	.size	kernel_main, .-kernel_main
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.ident	"GCC: (GNU) 5.2.0"
