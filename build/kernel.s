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
	subl	$16, %esp
	.cfi_def_cfa_offset 20
	pushl	$32
	.cfi_def_cfa_offset 24
	pushl	$768
	.cfi_def_cfa_offset 28
	pushl	$1024
	.cfi_def_cfa_offset 32
	call	vbe_init
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L6
	call	clear
	call	disable_cursor
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	jmp	terminal
	.align 4
.L6:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	call	vga_set_gui_mode
	call	gui_init
	addl	$16, %esp
	.cfi_def_cfa_offset 16
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
