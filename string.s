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
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	tokenize
	.type	tokenize, @function
tokenize:
.LFB2:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	12(%esp), %edx
	movl	16(%esp), %esi
	movl	20(%esp), %ebx
	movb	(%edx), %cl
	xorl	%eax, %eax
	testb	%cl, %cl
	je	.L32
	.align 4
.L50:
	cmpl	%ebx, %eax
	jge	.L32
	cmpb	$32, %cl
	jne	.L25
	.align 4
.L39:
	incl	%edx
	movb	(%edx), %cl
	cmpb	$32, %cl
	je	.L39
	testb	%cl, %cl
	je	.L32
.L25:
	incl	%eax
	movl	%edx, -4(%esi,%eax,4)
	movb	(%edx), %cl
	testb	%cl, %cl
	jne	.L48
	jmp	.L32
	.align 4
.L49:
	incl	%edx
	movb	(%edx), %cl
	testb	%cl, %cl
	je	.L32
.L48:
	cmpb	$32, %cl
	jne	.L49
	movb	$0, (%edx)
	movb	1(%edx), %cl
	incl	%edx
	testb	%cl, %cl
	jne	.L50
.L32:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	tokenize, .-tokenize
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.ident	"GCC: (GNU) 5.2.0"
