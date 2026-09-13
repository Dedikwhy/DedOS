	.file	"gui.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"DedOS"
.LC1:
	.string	"DedOS Terminal"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.type	draw_taskbar, @function
draw_taskbar:
.LFB2:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	pushl	%eax
	.cfi_def_cfa_offset 16
	call	gfx_width
	movl	%eax, %ebx
	call	gfx_height
	movl	%eax, %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$857116
	.cfi_def_cfa_offset 32
	pushl	$32
	.cfi_def_cfa_offset 36
	pushl	%ebx
	.cfi_def_cfa_offset 40
	leal	-32(%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	pushl	$0
	.cfi_def_cfa_offset 48
	call	gfx_fill_rect
	subl	$20, %esi
	addl	$24, %esp
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	pushl	$857116
	.cfi_def_cfa_offset 32
	pushl	$16777215
	.cfi_def_cfa_offset 36
	pushl	$.LC0
	.cfi_def_cfa_offset 40
	pushl	%esi
	.cfi_def_cfa_offset 44
	pushl	$10
	.cfi_def_cfa_offset 48
	call	gfx_draw_string
	addl	$24, %esp
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	pushl	$857116
	.cfi_def_cfa_offset 32
	pushl	$11184810
	.cfi_def_cfa_offset 36
	pushl	$.LC1
	.cfi_def_cfa_offset 40
	pushl	%esi
	.cfi_def_cfa_offset 44
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%eax, %ebx
	sarl	%ebx
	subl	$60, %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	gfx_draw_string
	addl	$36, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	draw_taskbar, .-draw_taskbar
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.type	redraw_window_content, @function
redraw_window_content:
.LFB4:
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
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	movl	win, %eax
	addl	$8, %eax
	movl	%eax, 12(%esp)
	movl	win+4, %eax
	movl	rows, %edx
	testl	%edx, %edx
	jle	.L3
	leal	30(%eax), %esi
	xorl	%edi, %edi
	movl	$0, 8(%esp)
	movl	%edi, %ebp
	.align 4
.L7:
	movl	cols, %eax
	testl	%eax, %eax
	jle	.L8
	movl	12(%esp), %edi
	xorl	%ebx, %ebx
	.align 4
.L6:
	movb	attr_buf(%ebp,%ebx), %al
	subl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	$1
	.cfi_def_cfa_offset 60
	movb	%al, %dl
	shrb	$4, %dl
	movzbl	%dl, %edx
	pushl	PALETTE(,%edx,4)
	.cfi_def_cfa_offset 64
	andl	$15, %eax
	pushl	PALETTE(,%eax,4)
	.cfi_def_cfa_offset 68
	movsbl	text_buf(%ebp,%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	gfx_draw_char
	incl	%ebx
	addl	$8, %edi
	addl	$32, %esp
	.cfi_def_cfa_offset 48
	cmpl	%ebx, cols
	jg	.L6
.L8:
	incl	8(%esp)
	movl	8(%esp), %eax
	addl	$140, %ebp
	addl	$8, %esi
	cmpl	%eax, rows
	jg	.L7
.L3:
	addl	$28, %esp
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
	.cfi_endproc
.LFE4:
	.size	redraw_window_content, .-redraw_window_content
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.type	redraw_window, @function
redraw_window:
.LFB5:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$659222
	.cfi_def_cfa_offset 32
	pushl	win+12
	.cfi_def_cfa_offset 36
	pushl	win+8
	.cfi_def_cfa_offset 40
	pushl	win+4
	.cfi_def_cfa_offset 44
	pushl	win
	.cfi_def_cfa_offset 48
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 28
	pushl	$2908074
	.cfi_def_cfa_offset 32
	pushl	$22
	.cfi_def_cfa_offset 36
	movl	win+8, %eax
	subl	$4, %eax
	pushl	%eax
	.cfi_def_cfa_offset 40
	movl	win+4, %eax
	addl	$2, %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	movl	win, %eax
	addl	$2, %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	gfx_fill_rect
	addl	$24, %esp
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	pushl	$2908074
	.cfi_def_cfa_offset 32
	pushl	$16777215
	.cfi_def_cfa_offset 36
	pushl	$.LC1
	.cfi_def_cfa_offset 40
	movl	win+4, %eax
	addl	$9, %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	movl	win, %eax
	addl	$8, %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	gfx_draw_string
	addl	$20, %esp
	.cfi_def_cfa_offset 28
	pushl	$0
	.cfi_def_cfa_offset 32
	movl	win+12, %eax
	subl	$26, %eax
	pushl	%eax
	.cfi_def_cfa_offset 36
	movl	win+8, %eax
	subl	$4, %eax
	pushl	%eax
	.cfi_def_cfa_offset 40
	movl	win+4, %eax
	addl	$24, %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	movl	win, %eax
	addl	$2, %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	gfx_fill_rect
	addl	$44, %esp
	.cfi_def_cfa_offset 4
	jmp	redraw_window_content
	.cfi_endproc
.LFE5:
	.size	redraw_window, .-redraw_window
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.type	draw_cursor, @function
draw_cursor:
.LFB8:
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
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	movl	%eax, (%esp)
	movl	%edx, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%eax, %ebx
	negl	%ebx
	sall	$2, %ebx
	leal	1024(%ebx), %esi
	movl	%esi, 4(%esp)
	movl	%edx, %esi
	leal	16(%eax), %ebp
	.align 4
.L16:
	movl	(%esp), %edi
	.align 4
.L17:
	subl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	%esi
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	gfx_get_pixel
	movl	%eax, cursor_backup(%ebx,%edi,4)
	incl	%edi
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	cmpl	%ebp, %edi
	jne	.L17
	incl	%esi
	addl	$64, %ebx
	cmpl	4(%esp), %ebx
	jne	.L16
	movl	$1, cursor_backed_up
	movl	(%esp), %eax
	movl	%eax, cursor_last_x
	movl	12(%esp), %edx
	movl	%edx, cursor_last_y
	movl	$CURSOR_BITMAP+2, %ebp
	movl	$32768, %ebx
	movl	$32768, %esi
	movl	8(%esp), %edi
	movl	%ebp, 4(%esp)
	movl	%eax, %ebp
	.align 4
.L22:
	xorl	%ecx, %ecx
	jmp	.L20
	.align 4
.L19:
	incl	%ecx
	cmpl	$16, %ecx
	je	.L29
.L20:
	movl	%esi, %eax
	sarl	%cl, %eax
	testl	%ebx, %eax
	je	.L19
	pushl	%eax
	.cfi_def_cfa_offset 52
	pushl	$16777215
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	leal	(%ecx,%ebp), %eax
	movl	%ecx, 12(%esp)
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	gfx_put_pixel
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	movl	(%esp), %ecx
	incl	%ecx
	cmpl	$16, %ecx
	jne	.L20
.L29:
	incl	%edi
	movl	4(%esp), %eax
	cmpl	$CURSOR_BITMAP+32, %eax
	je	.L15
	movzwl	(%eax), %ebx
	addl	$2, %eax
	movl	%eax, 4(%esp)
	jmp	.L22
.L15:
	addl	$28, %esp
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
	.cfi_endproc
.LFE8:
	.size	draw_cursor, .-draw_cursor
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.type	put_char_at, @function
put_char_at:
.LFB11:
	.cfi_startproc
	testl	%eax, %eax
	js	.L34
	cmpl	rows, %eax
	jge	.L34
	testl	%edx, %edx
	js	.L34
	cmpl	cols, %edx
	jl	.L35
.L34:
	ret
	.align 4
.L35:
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%ecx, %edi
	leal	(%eax,%eax,4), %ebx
	leal	0(,%ebx,4), %esi
	sall	$5, %ebx
	subl	%esi, %ebx
	movb	%cl, text_buf(%edx,%ebx)
	movb	cur_attr, %cl
	movb	%cl, attr_buf(%edx,%ebx)
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$1
	.cfi_def_cfa_offset 28
	movb	%cl, %bl
	shrb	$4, %bl
	movzbl	%bl, %ebx
	pushl	PALETTE(,%ebx,4)
	.cfi_def_cfa_offset 32
	movl	%ecx, %ebx
	andl	$15, %ebx
	pushl	PALETTE(,%ebx,4)
	.cfi_def_cfa_offset 36
	movl	%edi, %ebx
	movsbl	%bl, %ecx
	pushl	%ecx
	.cfi_def_cfa_offset 40
	movl	win+4, %ecx
	leal	30(%ecx,%eax,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	movl	win, %eax
	leal	8(%eax,%edx,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	gfx_draw_char
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE11:
	.size	put_char_at, .-put_char_at
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.align 4
	.globl	gui_init
	.type	gui_init, @function
gui_init:
.LFB9:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$8, %esp
	.cfi_def_cfa_offset 16
	call	vbe_get_info
	pushl	12(%eax)
	.cfi_def_cfa_offset 20
	pushl	8(%eax)
	.cfi_def_cfa_offset 24
	pushl	4(%eax)
	.cfi_def_cfa_offset 28
	pushl	(%eax)
	.cfi_def_cfa_offset 32
	call	gfx_set_framebuffer
	movl	$820, win+8
	movl	$560, win+12
	call	gfx_width
	subl	$19, %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	win+8, %eax
	jle	.L48
.L37:
	call	gfx_height
	subl	$51, %eax
	cmpl	win+12, %eax
	jle	.L49
.L38:
	call	gfx_width
	subl	win+8, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, win
	call	gfx_height
	movl	win+12, %edx
	subl	$32, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%ecx, %eax
	sarl	%eax
	movl	%eax, win+4
	movl	$0, win+16
	movl	win+8, %eax
	movl	%eax, %ecx
	subl	$16, %ecx
	js	.L50
.L39:
	sarl	$3, %ecx
	movl	%ecx, cols
	movl	%edx, %eax
	subl	$38, %eax
	js	.L51
.L40:
	sarl	$3, %eax
	movl	%eax, rows
	cmpl	$140, %ecx
	jle	.L41
	movl	$140, cols
.L41:
	cmpl	$80, %eax
	jle	.L42
	movl	$80, rows
.L42:
	movb	cur_attr, %cl
	xorl	%edx, %edx
	.align 4
.L43:
	xorl	%eax, %eax
	.align 4
.L44:
	movb	$32, text_buf(%edx,%eax)
	movb	%cl, attr_buf(%edx,%eax)
	incl	%eax
	cmpl	$140, %eax
	jne	.L44
	addl	$140, %edx
	cmpl	$11200, %edx
	jne	.L43
	movl	$0, cur_col
	movl	$0, cur_row
	call	gfx_height
	movl	%eax, %ebx
	call	gfx_width
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$1780282
	.cfi_def_cfa_offset 32
	pushl	%ebx
	.cfi_def_cfa_offset 36
	pushl	%eax
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	$0
	.cfi_def_cfa_offset 48
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 16
	call	draw_taskbar
	call	redraw_window
	call	mouse_init
	call	mouse_get_y
	movl	%eax, %ebx
	call	mouse_get_x
	movl	%ebx, %edx
	call	draw_cursor
	movl	$1, gui_ready
	addl	$8, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
.L51:
	.cfi_restore_state
	leal	-31(%edx), %eax
	jmp	.L40
.L50:
	leal	-9(%eax), %ecx
	jmp	.L39
.L49:
	call	gfx_height
	subl	$52, %eax
	movl	%eax, win+12
	jmp	.L38
.L48:
	call	gfx_width
	subl	$20, %eax
	movl	%eax, win+8
	jmp	.L37
	.cfi_endproc
.LFE9:
	.size	gui_init, .-gui_init
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.globl	gui_putchar
	.type	gui_putchar, @function
gui_putchar:
.LFB12:
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
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	movl	48(%esp), %eax
	movl	gui_ready, %edx
	testl	%edx, %edx
	je	.L52
	cmpb	$10, %al
	je	.L77
	cmpb	$13, %al
	je	.L78
	cmpb	$8, %al
	je	.L79
	cmpb	$9, %al
	je	.L80
	movsbl	%al, %ecx
	movl	cur_col, %edx
	movl	cur_row, %eax
	call	put_char_at
	movl	cur_col, %eax
	incl	%eax
	movl	%eax, cur_col
.L76:
	movl	cur_row, %edx
	jmp	.L56
.L77:
	movl	$0, cur_col
	movl	cur_row, %eax
	leal	1(%eax), %edx
	movl	%edx, cur_row
	xorl	%eax, %eax
.L56:
	movl	cols, %ebp
	cmpl	%eax, %ebp
	jg	.L61
	movl	$0, cur_col
	incl	%edx
	movl	%edx, cur_row
.L61:
	movl	rows, %eax
	cmpl	%edx, %eax
	jg	.L52
	decl	%eax
	movl	%eax, 12(%esp)
	testl	%eax, %eax
	jle	.L68
	movl	$-140, %ecx
	movl	$1, 4(%esp)
	.align 4
.L67:
	movl	4(%esp), %eax
	movl	%eax, 8(%esp)
	testl	%ebp, %ebp
	jle	.L70
	movl	%ecx, %edx
	negl	%edx
	leal	text_buf(%edx), %eax
	addl	$attr_buf, %edx
	movl	%ebp, %edi
	subl	%ecx, %edi
	addl	$text_buf, %edi
	movl	$-140, %ebx
	subl	%ecx, %ebx
	movl	%ecx, (%esp)
	.align 4
.L66:
	movl	(%esp), %esi
	addl	%eax, %esi
	movb	(%eax), %cl
	movb	%cl, (%esi,%ebx)
	movl	(%esp), %esi
	addl	%edx, %esi
	movb	(%edx), %cl
	movb	%cl, (%esi,%ebx)
	incl	%eax
	incl	%edx
	cmpl	%edi, %eax
	jne	.L66
	movl	(%esp), %ecx
.L70:
	incl	4(%esp)
	subl	$140, %ecx
	movl	8(%esp), %edi
	cmpl	%edi, 12(%esp)
	jg	.L67
.L68:
	testl	%ebp, %ebp
	jle	.L65
	movb	cur_attr, %bl
	movl	12(%esp), %eax
	leal	(%eax,%eax,4), %eax
	leal	0(,%eax,4), %edx
	sall	$5, %eax
	subl	%edx, %eax
	movl	%eax, %ecx
	leal	text_buf(%eax), %eax
	leal	attr_buf(%ecx), %edx
	leal	text_buf(%ebp,%ecx), %ecx
	.align 4
.L71:
	movb	$32, (%eax)
	movb	%bl, (%edx)
	incl	%eax
	incl	%edx
	cmpl	%ecx, %eax
	jne	.L71
.L65:
	call	redraw_window_content
	movl	rows, %eax
	decl	%eax
	movl	%eax, cur_row
.L52:
	addl	$28, %esp
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
.L80:
	.cfi_restore_state
	movl	cur_col, %eax
	addl	$4, %eax
	andl	$-4, %eax
	movl	%eax, cur_col
	movl	cur_row, %edx
	jmp	.L56
.L78:
	movl	$0, cur_col
	movl	cur_row, %edx
	xorl	%eax, %eax
	jmp	.L56
.L79:
	movl	cur_col, %eax
	testl	%eax, %eax
	jle	.L76
	leal	-1(%eax), %edx
	movl	%edx, cur_col
	movl	$32, %ecx
	movl	cur_row, %eax
	call	put_char_at
	movl	cur_col, %eax
	movl	cur_row, %edx
	jmp	.L56
	.cfi_endproc
.LFE12:
	.size	gui_putchar, .-gui_putchar
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.globl	gui_clear_terminal
	.type	gui_clear_terminal, @function
gui_clear_terminal:
.LFB13:
	.cfi_startproc
	movl	gui_ready, %eax
	testl	%eax, %eax
	je	.L89
	movb	cur_attr, %cl
	xorl	%edx, %edx
	.align 4
.L83:
	xorl	%eax, %eax
	.align 4
.L84:
	movb	$32, text_buf(%edx,%eax)
	movb	%cl, attr_buf(%edx,%eax)
	incl	%eax
	cmpl	$140, %eax
	jne	.L84
	addl	$140, %edx
	cmpl	$11200, %edx
	jne	.L83
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	movl	$0, cur_col
	movl	$0, cur_row
	pushl	$0
	.cfi_def_cfa_offset 32
	movl	win+12, %eax
	subl	$26, %eax
	pushl	%eax
	.cfi_def_cfa_offset 36
	movl	win+8, %eax
	subl	$4, %eax
	pushl	%eax
	.cfi_def_cfa_offset 40
	movl	win+4, %eax
	addl	$24, %eax
	pushl	%eax
	.cfi_def_cfa_offset 44
	movl	win, %eax
	addl	$2, %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	gfx_fill_rect
	addl	$44, %esp
	.cfi_def_cfa_offset 4
.L89:
	ret
	.cfi_endproc
.LFE13:
	.size	gui_clear_terminal, .-gui_clear_terminal
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.globl	gui_setcolor
	.type	gui_setcolor, @function
gui_setcolor:
.LFB14:
	.cfi_startproc
	movl	4(%esp), %eax
	movb	%al, cur_attr
	ret
	.cfi_endproc
.LFE14:
	.size	gui_setcolor, .-gui_setcolor
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.globl	gui_on_mouse_update
	.type	gui_on_mouse_update, @function
gui_on_mouse_update:
.LFB15:
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
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	movl	48(%esp), %eax
	movl	%eax, 4(%esp)
	movl	52(%esp), %eax
	movl	%eax, 8(%esp)
	movl	56(%esp), %ebp
	movl	gui_ready, %eax
	testl	%eax, %eax
	jne	.L126
	addl	$28, %esp
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
.L126:
	.cfi_restore_state
	movl	cursor_backed_up, %eax
	testl	%eax, %eax
	je	.L93
	xorl	%ebx, %ebx
	.align 4
.L96:
	movl	%ebx, %esi
	sall	$4, %esi
	xorl	%edi, %edi
	.align 4
.L95:
	pushl	%eax
	.cfi_def_cfa_offset 52
	leal	(%edi,%esi), %edx
	pushl	cursor_backup(,%edx,4)
	.cfi_def_cfa_offset 56
	movl	cursor_last_y, %edx
	addl	%ebx, %edx
	pushl	%edx
	.cfi_def_cfa_offset 60
	movl	cursor_last_x, %edx
	addl	%edi, %edx
	pushl	%edx
	.cfi_def_cfa_offset 64
	call	gfx_put_pixel
	incl	%edi
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	cmpl	$16, %edi
	jne	.L95
	incl	%ebx
	cmpl	$16, %ebx
	jne	.L96
	movl	$0, cursor_backed_up
.L93:
	movl	win, %eax
	movl	4(%esp), %ecx
	cmpl	%ecx, %eax
	jg	.L112
	movl	win+8, %edx
	addl	%eax, %edx
	cmpl	%edx, %ecx
	jl	.L127
.L112:
	xorl	%edx, %edx
.L98:
	movl	win+16, %ebx
	testl	%ebx, %ebx
	jne	.L99
	testl	%ebp, %ebp
	je	.L100
	movl	prev_left_button, %ecx
	testl	%ecx, %ecx
	jne	.L100
	testl	%edx, %edx
	jne	.L128
.L100:
	movl	$0, win+16
.L107:
	movl	%ebp, prev_left_button
	movl	8(%esp), %edx
	movl	4(%esp), %eax
	addl	$28, %esp
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
	jmp	draw_cursor
.L99:
	.cfi_restore_state
	testl	%ebp, %ebp
	je	.L100
	movl	win+20, %eax
	movl	win+24, %edx
.L109:
	movl	8(%esp), %ebx
	subl	%edx, %ebx
	movl	4(%esp), %esi
	subl	%eax, %esi
	js	.L129
.L101:
	testl	%ebx, %ebx
	js	.L130
.L102:
	movl	win+8, %eax
	addl	%esi, %eax
	movl	%eax, %edi
	call	gfx_width
	cmpl	%eax, %edi
	jg	.L131
.L103:
	call	gfx_height
	subl	$31, %eax
	movl	win+12, %edx
	addl	%ebx, %edx
	cmpl	%edx, %eax
	jle	.L132
.L104:
	movl	win, %eax
	movl	win+4, %edx
	cmpl	%eax, %esi
	jne	.L106
	cmpl	%edx, %ebx
	je	.L107
.L106:
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$1780282
	.cfi_def_cfa_offset 64
	pushl	win+12
	.cfi_def_cfa_offset 68
	pushl	win+8
	.cfi_def_cfa_offset 72
	pushl	%edx
	.cfi_def_cfa_offset 76
	movl	%edx, 40(%esp)
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	movl	%esi, win
	movl	%ebx, win+4
	addl	$32, %esp
	.cfi_def_cfa_offset 48
	call	gfx_height
	subl	$31, %eax
	movl	12(%esp), %edx
	addl	win+12, %edx
	cmpl	%edx, %eax
	jg	.L108
	call	draw_taskbar
.L108:
	call	redraw_window
	jmp	.L107
.L127:
	movl	win+4, %edx
	movl	8(%esp), %ecx
	cmpl	%ecx, %edx
	jg	.L112
	addl	$23, %edx
	cmpl	%edx, %ecx
	setle	%dl
	movzbl	%dl, %edx
	jmp	.L98
.L128:
	movl	$1, win+16
	movl	4(%esp), %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%ecx, win+20
	movl	8(%esp), %edx
	subl	win+4, %edx
	movl	%edx, win+24
	jmp	.L109
.L132:
	call	gfx_height
	leal	-32(%eax), %ebx
	subl	win+12, %ebx
	jmp	.L104
.L131:
	call	gfx_width
	subl	win+8, %eax
	movl	%eax, %esi
	jmp	.L103
.L130:
	xorl	%ebx, %ebx
	jmp	.L102
.L129:
	xorl	%esi, %esi
	jmp	.L101
	.cfi_endproc
.LFE15:
	.size	gui_on_mouse_update, .-gui_on_mouse_update
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.local	prev_left_button
	.comm	prev_left_button,4,4
	.data
	.align 4
	.type	cursor_last_y, @object
	.size	cursor_last_y, 4
cursor_last_y:
	.long	-1000
	.align 4
	.type	cursor_last_x, @object
	.size	cursor_last_x, 4
cursor_last_x:
	.long	-1000
	.local	cursor_backed_up
	.comm	cursor_backed_up,4,4
	.local	cursor_backup
	.comm	cursor_backup,1024,32
	.section	.rodata
	.align 32
	.type	CURSOR_BITMAP, @object
	.size	CURSOR_BITMAP, 32
CURSOR_BITMAP:
	.value	-32768
	.value	-16384
	.value	-8192
	.value	-4096
	.value	-2048
	.value	-1024
	.value	-512
	.value	-256
	.value	-128
	.value	-2048
	.value	-10240
	.value	-29696
	.value	3072
	.value	1536
	.value	1536
	.value	0
	.local	gui_ready
	.comm	gui_ready,4,4
	.data
	.type	cur_attr, @object
	.size	cur_attr, 1
cur_attr:
	.byte	15
	.local	cur_row
	.comm	cur_row,4,4
	.local	cur_col
	.comm	cur_col,4,4
	.local	rows
	.comm	rows,4,4
	.local	cols
	.comm	cols,4,4
	.local	attr_buf
	.comm	attr_buf,11200,32
	.local	text_buf
	.comm	text_buf,11200,32
	.local	win
	.comm	win,28,4
	.section	.rodata
	.align 32
	.type	PALETTE, @object
	.size	PALETTE, 64
PALETTE:
	.long	0
	.long	170
	.long	43520
	.long	43690
	.long	11141120
	.long	11141290
	.long	11162880
	.long	11184810
	.long	5592405
	.long	5592575
	.long	5635925
	.long	5636095
	.long	16733525
	.long	16733695
	.long	16777045
	.long	16777215
	.ident	"GCC: (GNU) 5.2.0"
