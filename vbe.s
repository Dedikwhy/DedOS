	.file	"vbe.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	vbe_init
	.type	vbe_init, @function
vbe_init:
.LFB7:
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
	movl	20(%esp), %ebp
	xorl	%ecx, %ecx
	movl	$3320, %edi
	movl	$3324, %esi
	jmp	.L5
	.align 4
.L2:
	incl	%ecx
	cmpl	$32, %ecx
	je	.L6
.L5:
	movl	%ecx, %ebx
	sall	$11, %ebx
	movl	%ebx, %eax
	orl	$-2147483648, %eax
	movl	%edi, %edx
/APP
/  11 "src/vbe.c" 1
	outl %eax, %dx
/  0 "" 2
/NO_APP
	movl	%esi, %edx
/APP
/  15 "src/vbe.c" 1
	inl %dx, %eax
/  0 "" 2
/NO_APP
	incw	%ax
	je	.L2
	movl	%ebx, %eax
	orl	$-2147483640, %eax
	movl	%edi, %edx
/APP
/  11 "src/vbe.c" 1
	outl %eax, %dx
/  0 "" 2
/NO_APP
	movl	%esi, %edx
/APP
/  15 "src/vbe.c" 1
	inl %dx, %eax
/  0 "" 2
/NO_APP
	movl	%eax, %edx
	shrl	$24, %edx
	cmpl	$3, %edx
	jne	.L2
	shrl	$16, %eax
	testb	%al, %al
	jne	.L2
	movl	%ebx, %eax
	orl	$-2147483632, %eax
	movl	$3320, %edx
/APP
/  11 "src/vbe.c" 1
	outl %eax, %dx
/  0 "" 2
/NO_APP
	movl	$3324, %edx
/APP
/  15 "src/vbe.c" 1
	inl %dx, %eax
/  0 "" 2
/NO_APP
	andl	$-16, %eax
	movl	%eax, %ecx
	je	.L6
	movl	$4, %edi
	movl	$462, %esi
	movl	%edi, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$463, %ebx
	xorl	%eax, %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$1, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	%ebp, %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$2, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	24(%esp), %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$3, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	28(%esp), %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$6, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	%ebp, %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$7, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	24(%esp), %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	%edi, %eax
	movl	%esi, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	$65, %eax
	movl	%ebx, %edx
/APP
/  8 "src/vbe.c" 1
	outw %ax, %dx
/  0 "" 2
/NO_APP
	movl	%ecx, g_vbe
	movl	%ebp, g_vbe+4
	movl	24(%esp), %eax
	movl	%eax, g_vbe+8
	movl	28(%esp), %eax
	shrl	$3, %eax
	imull	%eax, %ebp
	movl	%ebp, g_vbe+12
	movl	$1, %eax
	popl	%ebx
	.cfi_remember_state
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
.L6:
	.cfi_restore_state
	xorl	%eax, %eax
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
.LFE7:
	.size	vbe_init, .-vbe_init
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	vbe_get_info
	.type	vbe_get_info, @function
vbe_get_info:
.LFB8:
	.cfi_startproc
	movl	$g_vbe, %eax
	ret
	.cfi_endproc
.LFE8:
	.size	vbe_get_info, .-vbe_get_info
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.local	g_vbe
	.comm	g_vbe,16,4
	.ident	"GCC: (GNU) 5.2.0"
