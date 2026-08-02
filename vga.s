	.file	"vga.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	vga_entry_color
	.type	vga_entry_color, @function
vga_entry_color:
.LFB0:
	.cfi_startproc
	movb	8(%esp), %al
	sall	$4, %eax
	orl	4(%esp), %eax
	ret
	.cfi_endproc
.LFE0:
	.size	vga_entry_color, .-vga_entry_color
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	clear
	.type	clear, @function
clear:
.LFB2:
	.cfi_startproc
	movzbl	terminal_color, %ecx
	sall	$8, %ecx
	orl	$32, %ecx
	movl	$753664, %eax
	.align 4
.L3:
	leal	160(%eax), %edx
	.align 4
.L4:
	movw	%cx, (%eax)
	addl	$2, %eax
	cmpl	%edx, %eax
	jne	.L4
	cmpl	$757664, %eax
	jne	.L3
	movl	$0, terminal_row
	movl	$0, terminal_column
	ret
	.cfi_endproc
.LFE2:
	.size	clear, .-clear
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	setcolor
	.type	setcolor, @function
setcolor:
.LFB3:
	.cfi_startproc
	movl	4(%esp), %eax
	movb	%al, terminal_color
	ret
	.cfi_endproc
.LFE3:
	.size	setcolor, .-setcolor
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.globl	putchar
	.type	putchar, @function
putchar:
.LFB5:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	12(%esp), %ecx
	cmpb	$10, %cl
	je	.L30
	cmpb	$13, %cl
	je	.L31
	cmpb	$8, %cl
	je	.L32
	cmpb	$9, %cl
	je	.L33
	movl	terminal_row, %edx
	movl	terminal_column, %eax
	leal	(%edx,%edx,4), %ebx
	sall	$4, %ebx
	addl	%eax, %ebx
	addl	%ebx, %ebx
	movzbl	terminal_color, %esi
	sall	$8, %esi
	movzbl	%cl, %ecx
	orl	%esi, %ecx
	movw	%cx, 753664(%ebx)
	incl	%eax
	movl	%eax, terminal_column
.L16:
	cmpl	$79, %eax
	jle	.L15
	movl	$0, terminal_column
	incl	%edx
	movl	%edx, terminal_row
.L15:
	cmpl	$24, %edx
	jle	.L9
	xorl	%ebx, %ebx
	movl	$753824, %eax
	.align 4
.L21:
	leal	160(%eax), %ecx
	addl	$80, %ebx
	.align 4
.L20:
	movw	(%eax), %dx
	movw	%dx, -160(%eax)
	addl	$2, %eax
	cmpl	%ecx, %eax
	jne	.L20
	cmpl	$1920, %ebx
	jne	.L21
	movzbl	terminal_color, %edx
	sall	$8, %edx
	orl	$32, %edx
	movl	$757504, %eax
	.align 4
.L23:
	movw	%dx, (%eax)
	addl	$2, %eax
	cmpl	$757664, %eax
	jne	.L23
	movl	$24, terminal_row
.L9:
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
.L32:
	.cfi_restore_state
	movl	terminal_column, %eax
	testl	%eax, %eax
	jle	.L34
	decl	%eax
	movl	%eax, terminal_column
	movl	terminal_row, %edx
	leal	(%edx,%edx,4), %ecx
	sall	$4, %ecx
	addl	%eax, %ecx
	addl	%ecx, %ecx
	movzbl	terminal_color, %ebx
	sall	$8, %ebx
	orl	$32, %ebx
	movw	%bx, 753664(%ecx)
	jmp	.L16
.L31:
	movl	$0, terminal_column
	movl	terminal_row, %edx
	jmp	.L15
.L30:
	movl	$0, terminal_column
	movl	terminal_row, %eax
	leal	1(%eax), %edx
	movl	%edx, terminal_row
	jmp	.L15
.L33:
	movl	terminal_column, %eax
	addl	$4, %eax
	andl	$-4, %eax
	movl	%eax, terminal_column
	movl	terminal_row, %edx
	jmp	.L16
.L34:
	movl	terminal_row, %edx
	jmp	.L15
	.cfi_endproc
.LFE5:
	.size	putchar, .-putchar
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.globl	write
	.type	write, @function
write:
.LFB6:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	movl	8(%esp), %ebx
	movsbl	(%ebx), %eax
	incl	%ebx
	testb	%al, %al
	je	.L35
	.align 4
.L39:
	pushl	%eax
	.cfi_def_cfa_offset 12
	call	putchar
	incl	%ebx
	movsbl	-1(%ebx), %eax
	popl	%edx
	.cfi_def_cfa_offset 8
	testb	%al, %al
	jne	.L39
.L35:
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE6:
	.size	write, .-write
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"(null)"
.LC6:
	.string	"0x"
.LC7:
	.string	"0123456789ABCDEF"
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.globl	print
	.type	print, @function
print:
.LFB9:
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
	subl	$72, %esp
	.cfi_def_cfa_offset 92
	leal	96(%esp), %eax
	movl	%eax, 4(%esp)
	movl	92(%esp), %eax
	movsbl	(%eax), %eax
	movl	$0, (%esp)
	testb	%al, %al
	je	.L42
	leal	39(%esp), %ebp
	jmp	.L68
	.align 4
.L78:
	incl	(%esp)
	movl	(%esp), %eax
	movl	92(%esp), %ebx
	addl	%eax, %ebx
	movb	(%ebx), %al
	cmpb	$100, %al
	je	.L46
	jg	.L47
	cmpb	$37, %al
	je	.L48
	cmpb	$99, %al
	jne	.L45
	movl	4(%esp), %eax
	leal	4(%eax), %ebx
	movsbl	(%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	putchar
	popl	%eax
	.cfi_def_cfa_offset 92
	movl	%ebx, 4(%esp)
	.align 4
.L53:
	incl	(%esp)
	movl	(%esp), %eax
	movl	92(%esp), %edi
	movsbl	(%edi,%eax), %eax
	testb	%al, %al
	je	.L42
.L68:
	cmpb	$37, %al
	je	.L78
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	putchar
	popl	%eax
	.cfi_def_cfa_offset 92
	jmp	.L53
	.align 4
.L47:
	cmpb	$115, %al
	je	.L50
	cmpb	$120, %al
	jne	.L45
	movl	4(%esp), %edi
	movl	%edi, %eax
	addl	$4, %edi
	movl	%edi, 4(%esp)
	movl	(%eax), %ebx
	movl	$.LC6, %esi
	movl	$48, %eax
	.align 4
.L59:
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	putchar
	incl	%esi
	movsbl	(%esi), %eax
	popl	%edx
	.cfi_def_cfa_offset 92
	testb	%al, %al
	jne	.L59
	testl	%ebx, %ebx
	je	.L79
	leal	23(%esp), %edi
	movl	$.LC7, %esi
	movl	$17, %ecx
	rep movsb
	xorl	%eax, %eax
	.align 4
.L61:
	incl	%eax
	movl	%ebx, %edx
	andl	$15, %edx
	movb	23(%esp,%edx), %cl
	movb	%cl, 0(%ebp,%eax)
	shrl	$4, %ebx
	jne	.L61
	leal	39(%esp,%eax), %ebx
	.align 4
.L62:
	movsbl	(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	putchar
	decl	%ebx
	popl	%esi
	.cfi_def_cfa_offset 92
	cmpl	%ebp, %ebx
	jne	.L62
	jmp	.L53
	.align 4
.L42:
	addl	$72, %esp
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
	.align 4
.L50:
	.cfi_restore_state
	movl	4(%esp), %esi
	movl	%esi, %eax
	addl	$4, %esi
	movl	%esi, 4(%esp)
	movl	(%eax), %ebx
	testl	%ebx, %ebx
	je	.L80
.L52:
	movsbl	(%ebx), %eax
	testb	%al, %al
	je	.L53
	incl	%ebx
	.align 4
.L54:
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	putchar
	incl	%ebx
	movsbl	-1(%ebx), %eax
	popl	%edx
	.cfi_def_cfa_offset 92
	testb	%al, %al
	jne	.L54
	jmp	.L53
	.align 4
.L46:
	movl	4(%esp), %eax
	leal	4(%eax), %esi
	movl	%esi, 4(%esp)
	movl	(%eax), %ebx
	testl	%ebx, %ebx
	je	.L81
	js	.L82
.L56:
	xorl	%ecx, %ecx
	movl	$10, %esi
	movl	$1717986919, %edi
	.align 4
.L57:
	incl	%ecx
	movl	%ebx, %eax
	cltd
	idivl	%esi
	addl	$48, %edx
	movb	%dl, 0(%ebp,%ecx)
	movl	%ebx, %eax
	imull	%edi
	movl	%edx, %eax
	sarl	$2, %eax
	sarl	$31, %ebx
	subl	%ebx, %eax
	movl	%eax, %ebx
	jne	.L57
	leal	39(%esp,%ecx), %ebx
	.align 4
.L58:
	movsbl	(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	putchar
	decl	%ebx
	popl	%ecx
	.cfi_def_cfa_offset 92
	cmpl	%ebx, %ebp
	jne	.L58
	jmp	.L53
	.align 4
.L45:
	pushl	$37
	.cfi_def_cfa_offset 96
	call	putchar
	movsbl	(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 100
	call	putchar
	popl	%edx
	.cfi_def_cfa_offset 96
	popl	%ecx
	.cfi_def_cfa_offset 92
	jmp	.L53
	.align 4
.L48:
	pushl	$37
	.cfi_def_cfa_offset 96
	call	putchar
	popl	%ebx
	.cfi_def_cfa_offset 92
	jmp	.L53
.L79:
	pushl	$48
	.cfi_def_cfa_offset 96
	call	putchar
	popl	%edi
	.cfi_def_cfa_offset 92
	jmp	.L53
.L81:
	pushl	$48
	.cfi_def_cfa_offset 96
	call	putchar
	popl	%edi
	.cfi_def_cfa_offset 92
	jmp	.L53
.L80:
	movl	$.LC5, %ebx
	jmp	.L52
.L82:
	pushl	$45
	.cfi_def_cfa_offset 96
	call	putchar
	negl	%ebx
	popl	%esi
	.cfi_def_cfa_offset 92
	jmp	.L56
	.cfi_endproc
.LFE9:
	.size	print, .-print
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.globl	disable_cursor
	.type	disable_cursor, @function
disable_cursor:
.LFB11:
	.cfi_startproc
	movl	$980, %edx
	movb	$10, %al
/APP
/  165 "src/vga.c" 1
	outb %al, %dx
/  0 "" 2
/NO_APP
	movl	$981, %edx
	movb	$32, %al
/APP
/  165 "src/vga.c" 1
	outb %al, %dx
/  0 "" 2
/NO_APP
	ret
	.cfi_endproc
.LFE11:
	.size	disable_cursor, .-disable_cursor
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.data
	.type	terminal_color, @object
	.size	terminal_color, 1
terminal_color:
	.byte	10
	.local	terminal_column
	.comm	terminal_column,4,4
	.local	terminal_row
	.comm	terminal_row,4,4
	.ident	"GCC: (GNU) 5.2.0"
