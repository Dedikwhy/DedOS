	.file	"string.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	strcmp
	.type	strcmp, @function
strcmp:
.LFB0:
	.cfi_startproc
	movl	4(%esp), %ecx
	movl	8(%esp), %edx
	movzbl	(%ecx), %eax
	testb	%al, %al
	jne	.L9
	jmp	.L6
	.align 4
.L11:
	incl	%ecx
	incl	%edx
	movzbl	(%ecx), %eax
	testb	%al, %al
	je	.L6
.L9:
	cmpb	(%edx), %al
	je	.L11
	movzbl	(%edx), %edx
	subl	%edx, %eax
	ret
	.align 4
.L6:
	xorl	%eax, %eax
	movzbl	(%edx), %edx
	subl	%edx, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	strcmp, .-strcmp
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	strlen
	.type	strlen, @function
strlen:
.LFB1:
	.cfi_startproc
	movl	4(%esp), %edx
	xorl	%eax, %eax
	cmpb	$0, (%edx)
	je	.L15
	.align 4
.L14:
	incl	%eax
	cmpb	$0, (%edx,%eax)
	jne	.L14
	ret
.L15:
	ret
	.cfi_endproc
.LFE1:
	.size	strlen, .-strlen
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.ident	"GCC: (GNU) 5.2.0"
