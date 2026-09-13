	.file	"vga.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	vga_set_gui_mode
	.type	vga_set_gui_mode, @function
vga_set_gui_mode:
.LFB0:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	%eax, s_gui_mode
	ret
	.cfi_endproc
.LFE0:
	.size	vga_set_gui_mode, .-vga_set_gui_mode
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	vga_entry_color
	.type	vga_entry_color, @function
vga_entry_color:
.LFB1:
	.cfi_startproc
	movb	8(%esp), %al
	sall	$4, %eax
	orl	4(%esp), %eax
	ret
	.cfi_endproc
.LFE1:
	.size	vga_entry_color, .-vga_entry_color
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	clear
	.type	clear, @function
clear:
.LFB3:
	.cfi_startproc
	movl	s_gui_mode, %eax
	testl	%eax, %eax
	jne	.L4
	movzbl	terminal_color, %ecx
	sall	$8, %ecx
	orl	$32, %ecx
	movl	$753664, %eax
	.align 4
.L5:
	leal	160(%eax), %edx
	.align 4
.L7:
	movw	%cx, (%eax)
	addl	$2, %eax
	cmpl	%edx, %eax
	jne	.L7
	cmpl	$757664, %eax
	jne	.L5
	movl	$0, terminal_row
	movl	$0, terminal_column
	ret
.L4:
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	gui_clear_terminal
	movl	$0, terminal_row
	movl	$0, terminal_column
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE3:
	.size	clear, .-clear
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.globl	setcolor
	.type	setcolor, @function
setcolor:
.LFB4:
	.cfi_startproc
	movl	4(%esp), %eax
	movb	%al, terminal_color
	movl	s_gui_mode, %edx
	testl	%edx, %edx
	jne	.L15
	ret
	.align 4
.L15:
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	jmp	gui_setcolor
	.cfi_endproc
.LFE4:
	.size	setcolor, .-setcolor
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.globl	putchar
	.type	putchar, @function
putchar:
.LFB6:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	12(%esp), %ecx
	movl	s_gui_mode, %eax
	testl	%eax, %eax
	jne	.L38
	cmpb	$10, %cl
	je	.L39
	cmpb	$13, %cl
	je	.L40
	cmpb	$8, %cl
	je	.L41
	cmpb	$9, %cl
	je	.L42
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
.L24:
	cmpl	$79, %eax
	jle	.L23
	movl	$0, terminal_column
	incl	%edx
	movl	%edx, terminal_row
.L23:
	cmpl	$24, %edx
	jle	.L16
	xorl	%ebx, %ebx
	movl	$753824, %eax
	.align 4
.L29:
	leal	160(%eax), %ecx
	addl	$80, %ebx
	.align 4
.L28:
	movw	(%eax), %dx
	movw	%dx, -160(%eax)
	addl	$2, %eax
	cmpl	%ecx, %eax
	jne	.L28
	cmpl	$1920, %ebx
	jne	.L29
	movzbl	terminal_color, %edx
	sall	$8, %edx
	orl	$32, %edx
	movl	$757504, %eax
	.align 4
.L31:
	movw	%dx, (%eax)
	addl	$2, %eax
	cmpl	$757664, %eax
	jne	.L31
	movl	$24, terminal_row
.L16:
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
.L40:
	.cfi_restore_state
	movl	$0, terminal_column
	movl	terminal_row, %edx
	jmp	.L23
.L39:
	movl	$0, terminal_column
	movl	terminal_row, %eax
	leal	1(%eax), %edx
	movl	%edx, terminal_row
	jmp	.L23
.L38:
	movsbl	%cl, %ecx
	movl	%ecx, 12(%esp)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	jmp	gui_putchar
.L41:
	.cfi_restore_state
	movl	terminal_column, %eax
	testl	%eax, %eax
	jle	.L43
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
	jmp	.L24
.L42:
	movl	terminal_column, %eax
	addl	$4, %eax
	andl	$-4, %eax
	movl	%eax, terminal_column
	movl	terminal_row, %edx
	jmp	.L24
.L43:
	movl	terminal_row, %edx
	jmp	.L23
	.cfi_endproc
.LFE6:
	.size	putchar, .-putchar
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.globl	write
	.type	write, @function
write:
.LFB7:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	movl	16(%esp), %ebx
	movsbl	(%ebx), %eax
	incl	%ebx
	testb	%al, %al
	je	.L44
	.align 4
.L48:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	putchar
	incl	%ebx
	movsbl	-1(%ebx), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testb	%al, %al
	jne	.L48
.L44:
	addl	$8, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE7:
	.size	write, .-write
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC6:
	.string	"(null)"
.LC7:
	.string	"0x"
.LC8:
	.string	"0123456789ABCDEF"
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.globl	print
	.type	print, @function
print:
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
	subl	$92, %esp
	.cfi_def_cfa_offset 112
	leal	116(%esp), %eax
	movl	%eax, 12(%esp)
	movl	112(%esp), %eax
	movsbl	(%eax), %eax
	movl	$0, 8(%esp)
	testb	%al, %al
	je	.L51
	leal	47(%esp), %ebp
	jmp	.L77
	.align 4
.L87:
	incl	8(%esp)
	movl	8(%esp), %eax
	movl	112(%esp), %ebx
	addl	%eax, %ebx
	movb	(%ebx), %al
	cmpb	$100, %al
	je	.L55
	jg	.L56
	cmpb	$37, %al
	je	.L57
	cmpb	$99, %al
	jne	.L54
	movl	12(%esp), %eax
	leal	4(%eax), %ebx
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	movsbl	(%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	movl	%ebx, 12(%esp)
	.align 4
.L62:
	incl	8(%esp)
	movl	8(%esp), %eax
	movl	112(%esp), %edi
	movsbl	(%edi,%eax), %eax
	testb	%al, %al
	je	.L51
.L77:
	cmpb	$37, %al
	je	.L87
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L62
	.align 4
.L56:
	cmpb	$115, %al
	je	.L59
	cmpb	$120, %al
	jne	.L54
	movl	12(%esp), %edi
	movl	%edi, %eax
	addl	$4, %edi
	movl	%edi, 12(%esp)
	movl	(%eax), %ebx
	movl	$.LC7, %esi
	movl	$48, %eax
	.align 4
.L68:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	putchar
	incl	%esi
	movsbl	(%esi), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	testb	%al, %al
	jne	.L68
	testl	%ebx, %ebx
	je	.L88
	leal	31(%esp), %edi
	movl	$.LC8, %esi
	movl	$17, %ecx
	rep movsb
	xorl	%eax, %eax
	.align 4
.L70:
	incl	%eax
	movl	%ebx, %edx
	andl	$15, %edx
	movb	31(%esp,%edx), %cl
	movb	%cl, 0(%ebp,%eax)
	shrl	$4, %ebx
	jne	.L70
	leal	47(%esp,%eax), %ebx
	.align 4
.L71:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	movsbl	(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	putchar
	decl	%ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	cmpl	%ebp, %ebx
	jne	.L71
	jmp	.L62
	.align 4
.L51:
	addl	$92, %esp
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
.L59:
	.cfi_restore_state
	movl	12(%esp), %esi
	movl	%esi, %eax
	addl	$4, %esi
	movl	%esi, 12(%esp)
	movl	(%eax), %ebx
	testl	%ebx, %ebx
	je	.L89
.L61:
	movsbl	(%ebx), %eax
	testb	%al, %al
	je	.L62
	incl	%ebx
	.align 4
.L63:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	putchar
	incl	%ebx
	movsbl	-1(%ebx), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	testb	%al, %al
	jne	.L63
	jmp	.L62
	.align 4
.L55:
	movl	12(%esp), %eax
	leal	4(%eax), %esi
	movl	%esi, 12(%esp)
	movl	(%eax), %ebx
	testl	%ebx, %ebx
	je	.L90
	js	.L91
.L65:
	xorl	%ecx, %ecx
	movl	$10, %esi
	movl	$1717986919, %edi
	.align 4
.L66:
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
	jne	.L66
	leal	47(%esp,%ecx), %ebx
	.align 4
.L67:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	movsbl	(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	putchar
	decl	%ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	cmpl	%ebx, %ebp
	jne	.L67
	jmp	.L62
	.align 4
.L54:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	$37
	.cfi_def_cfa_offset 128
	call	putchar
	movsbl	(%ebx), %eax
	movl	%eax, (%esp)
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L62
	.align 4
.L57:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	$37
	.cfi_def_cfa_offset 128
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L62
.L88:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	$48
	.cfi_def_cfa_offset 128
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L62
.L90:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	$48
	.cfi_def_cfa_offset 128
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L62
.L89:
	movl	$.LC6, %ebx
	jmp	.L61
.L91:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	$45
	.cfi_def_cfa_offset 128
	call	putchar
	negl	%ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L65
	.cfi_endproc
.LFE10:
	.size	print, .-print
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.globl	disable_cursor
	.type	disable_cursor, @function
disable_cursor:
.LFB12:
	.cfi_startproc
	movl	$980, %edx
	movb	$10, %al
/APP
/  184 "src/vga.c" 1
	outb %al, %dx
/  0 "" 2
/NO_APP
	movl	$981, %edx
	movb	$32, %al
/APP
/  184 "src/vga.c" 1
	outb %al, %dx
/  0 "" 2
/NO_APP
	ret
	.cfi_endproc
.LFE12:
	.size	disable_cursor, .-disable_cursor
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.local	s_gui_mode
	.comm	s_gui_mode,4,4
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
