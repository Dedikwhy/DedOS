	.file	"timer.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	timer_init
	.type	timer_init, @function
timer_init:
.LFB6:
	.cfi_startproc
	movb	$52, %al
/APP
/  6 "include/io.h" 1
	outb %al, $67
/  0 "" 2
/NO_APP
	xorl	%eax, %eax
/APP
/  6 "include/io.h" 1
	outb %al, $64
/  0 "" 2
/  6 "include/io.h" 1
	outb %al, $64
/  0 "" 2
/  6 "include/io.h" 1
	outb %al, $67
/  0 "" 2
/  12 "include/io.h" 1
	inb $64, %al
/  0 "" 2
/NO_APP
	movzbl	%al, %edx
/APP
/  12 "include/io.h" 1
	inb $64, %al
/  0 "" 2
/NO_APP
	sall	$8, %eax
	orl	%eax, %edx
	movw	%dx, s_last
	movl	$0, s_frac
	movl	$0, s_ms
	ret
	.cfi_endproc
.LFE6:
	.size	timer_init, .-timer_init
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	timer_ms
	.type	timer_ms, @function
timer_ms:
.LFB7:
	.cfi_startproc
	xorl	%eax, %eax
/APP
/  6 "include/io.h" 1
	outb %al, $67
/  0 "" 2
/  12 "include/io.h" 1
	inb $64, %al
/  0 "" 2
/NO_APP
	movzbl	%al, %edx
/APP
/  12 "include/io.h" 1
	inb $64, %al
/  0 "" 2
/NO_APP
	sall	$8, %eax
	orl	%edx, %eax
	movw	s_last, %dx
	subl	%eax, %edx
	movzwl	%dx, %edx
	addl	s_frac, %edx
	movl	%edx, s_frac
	movw	%ax, s_last
	movl	s_ms, %eax
	cmpl	$1192, %edx
	jbe	.L8
	incl	%eax
	jmp	.L5
	.align 4
.L6:
	movl	%ecx, %eax
.L5:
	subl	$1193, %edx
	leal	1(%eax), %ecx
	cmpl	$1192, %edx
	ja	.L6
	movl	%edx, s_frac
	movl	%eax, s_ms
	ret
.L8:
	ret
	.cfi_endproc
.LFE7:
	.size	timer_ms, .-timer_ms
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	rtc_get
	.type	rtc_get, @function
rtc_get:
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
	subl	$52, %esp
	.cfi_def_cfa_offset 72
	movl	72(%esp), %edi
	movl	$100000, %edx
	movb	$10, %cl
	jmp	.L10
	.align 4
.L12:
	decl	%edx
	je	.L11
.L10:
	movb	%cl, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	testb	%al, %al
	js	.L12
.L11:
	xorl	%eax, %eax
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movl	%eax, %esi
	movb	$2, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movb	%al, %bl
	movb	$4, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movb	%al, 32(%esp)
	movb	$7, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movb	%al, %cl
	movb	$8, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movb	%al, (%esp)
	movb	$9, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movb	%al, 16(%esp)
	movb	$11, %al
/APP
/  6 "include/io.h" 1
	outb %al, $112
/  0 "" 2
/  12 "include/io.h" 1
	inb $113, %al
/  0 "" 2
/NO_APP
	movb	%al, 51(%esp)
	movb	32(%esp), %dl
	andl	$127, %edx
	testb	$4, %al
	jne	.L13
	movl	%esi, %eax
	movzbl	%al, %eax
	sarl	$4, %eax
	leal	(%eax,%eax,4), %ebp
	andl	$15, %esi
	leal	(%esi,%ebp,2), %esi
	movzbl	%bl, %eax
	sarl	$4, %eax
	leal	(%eax,%eax,4), %ebp
	andl	$15, %ebx
	leal	(%ebx,%ebp,2), %ebx
	movzbl	%dl, %edx
	sarl	$4, %edx
	leal	(%edx,%edx,4), %edx
	movl	32(%esp), %ebp
	andl	$15, %ebp
	leal	0(%ebp,%edx,2), %edx
	movzbl	%cl, %eax
	sarl	$4, %eax
	leal	(%eax,%eax,4), %ebp
	andl	$15, %ecx
	leal	(%ecx,%ebp,2), %ecx
	movzbl	(%esp), %eax
	sarl	$4, %eax
	leal	(%eax,%eax,4), %ebp
	movl	(%esp), %eax
	andl	$15, %eax
	leal	(%eax,%ebp,2), %ebp
	movl	%ebp, %eax
	movb	%al, (%esp)
	movzbl	16(%esp), %eax
	sarl	$4, %eax
	leal	(%eax,%eax,4), %ebp
	movl	16(%esp), %eax
	andl	$15, %eax
	leal	(%eax,%ebp,2), %eax
	movb	%al, 16(%esp)
.L13:
	testb	$2, 51(%esp)
	jne	.L14
	cmpb	$12, %dl
	je	.L23
	cmpb	$0, 32(%esp)
	jns	.L14
.L24:
	addl	$12, %edx
.L14:
	movl	%esi, %eax
	movzbl	%al, %esi
	movl	%esi, 20(%edi)
	movzbl	%bl, %ebx
	movl	%ebx, 16(%edi)
	movzbl	%dl, %edx
	movl	%edx, 12(%edi)
	movzbl	%cl, %ecx
	movl	%ecx, 8(%edi)
	movzbl	(%esp), %eax
	movl	%eax, 4(%edi)
	movzbl	16(%esp), %eax
	addl	$2000, %eax
	movl	%eax, (%edi)
	addl	$52, %esp
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
	xorl	%edx, %edx
	cmpb	$0, 32(%esp)
	js	.L24
	jmp	.L14
	.cfi_endproc
.LFE10:
	.size	rtc_get, .-rtc_get
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.local	s_ms
	.comm	s_ms,4,4
	.local	s_frac
	.comm	s_frac,4,4
	.local	s_last
	.comm	s_last,2,2
	.ident	"GCC: (GNU) 5.2.0"
