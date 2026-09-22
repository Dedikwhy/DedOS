	.file	"input.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	input_poll
	.type	input_poll, @function
input_poll:
.LFB5:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	$64, %ebx
	jmp	.L5
	.align 4
.L10:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	movzbl	%al, %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	mouse_feed
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	decl	%ebx
	je	.L1
.L5:
/APP
/  12 "include/io.h" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	movb	%al, %dl
	testb	$1, %al
	je	.L1
/APP
/  12 "include/io.h" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	andl	$32, %edx
	jne	.L10
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	movzbl	%al, %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	kbd_feed
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	decl	%ebx
	jne	.L5
.L1:
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE5:
	.size	input_poll, .-input_poll
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.ident	"GCC: (GNU) 5.2.0"
