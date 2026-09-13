	.file	"gfx.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	gfx_set_framebuffer
	.type	gfx_set_framebuffer, @function
gfx_set_framebuffer:
.LFB0:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	%eax, s_fb
	movl	8(%esp), %eax
	movl	%eax, s_width
	movl	12(%esp), %eax
	movl	%eax, s_height
	movl	16(%esp), %eax
	shrl	$2, %eax
	movl	%eax, s_pitch_px
	ret
	.cfi_endproc
.LFE0:
	.size	gfx_set_framebuffer, .-gfx_set_framebuffer
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	gfx_width
	.type	gfx_width, @function
gfx_width:
.LFB1:
	.cfi_startproc
	movl	s_width, %eax
	ret
	.cfi_endproc
.LFE1:
	.size	gfx_width, .-gfx_width
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	gfx_height
	.type	gfx_height, @function
gfx_height:
.LFB2:
	.cfi_startproc
	movl	s_height, %eax
	ret
	.cfi_endproc
.LFE2:
	.size	gfx_height, .-gfx_height
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.globl	gfx_put_pixel
	.type	gfx_put_pixel, @function
gfx_put_pixel:
.LFB3:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	8(%esp), %edx
	movl	s_fb, %ecx
	testl	%ecx, %ecx
	je	.L4
	testl	%eax, %eax
	js	.L4
	testl	%edx, %edx
	js	.L4
	cmpl	s_width, %eax
	jnb	.L4
	cmpl	s_height, %edx
	jnb	.L4
	imull	s_pitch_px, %edx
	addl	%edx, %eax
	movl	12(%esp), %edx
	movl	%edx, (%ecx,%eax,4)
.L4:
	ret
	.cfi_endproc
.LFE3:
	.size	gfx_put_pixel, .-gfx_put_pixel
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.globl	gfx_get_pixel
	.type	gfx_get_pixel, @function
gfx_get_pixel:
.LFB4:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	8(%esp), %edx
	movl	s_fb, %ecx
	testl	%ecx, %ecx
	je	.L16
	testl	%eax, %eax
	js	.L16
	testl	%edx, %edx
	js	.L16
	cmpl	s_width, %eax
	jnb	.L16
	cmpl	s_height, %edx
	jnb	.L16
	imull	s_pitch_px, %edx
	addl	%edx, %eax
	movl	(%ecx,%eax,4), %eax
	ret
	.align 4
.L16:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE4:
	.size	gfx_get_pixel, .-gfx_get_pixel
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.globl	gfx_fill_rect
	.type	gfx_fill_rect, @function
gfx_fill_rect:
.LFB5:
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
	subl	$8, %esp
	.cfi_def_cfa_offset 28
	movl	32(%esp), %ebp
	movl	36(%esp), %ecx
	movl	40(%esp), %edx
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	s_fb, %eax
	testl	%eax, %eax
	je	.L17
	testl	%ecx, %ecx
	jle	.L17
	testl	%edx, %edx
	jle	.L17
	movl	28(%esp), %edi
	testl	%edi, %edi
	js	.L33
	movl	%ebp, %esi
	testl	%ebp, %ebp
	js	.L34
.L21:
	addl	%edx, %ebp
	movl	s_width, %edx
	movl	28(%esp), %ebx
	addl	%ebx, %ecx
	cmpl	%edx, %ecx
	jg	.L35
	movl	s_height, %edx
	cmpl	%edx, %ebp
	jg	.L36
.L23:
	cmpl	%ebp, %esi
	jge	.L17
	movl	s_pitch_px, %ebx
	leal	0(,%ebx,4), %edx
	movl	%edx, (%esp)
	imull	%esi, %edx
	addl	%eax, %edx
	movl	4(%esp), %ebx
	.align 4
.L25:
	movl	%edi, %eax
	cmpl	%ecx, %edi
	jge	.L27
	.align 4
.L28:
	movl	%ebx, (%edx,%eax,4)
	incl	%eax
	cmpl	%ecx, %eax
	jne	.L28
.L27:
	incl	%esi
	addl	(%esp), %edx
	cmpl	%ebp, %esi
	jne	.L25
.L17:
	addl	$8, %esp
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
.L36:
	.cfi_restore_state
	movl	%edx, %ebp
	jmp	.L23
.L35:
	movl	%edx, %ecx
	movl	s_height, %edx
	cmpl	%edx, %ebp
	jle	.L23
	jmp	.L36
.L34:
	xorl	%esi, %esi
	jmp	.L21
.L33:
	xorl	%edi, %edi
	movl	%ebp, %esi
	testl	%ebp, %ebp
	jns	.L21
	jmp	.L34
	.cfi_endproc
.LFE5:
	.size	gfx_fill_rect, .-gfx_fill_rect
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.globl	gfx_draw_hline
	.type	gfx_draw_hline, @function
gfx_draw_hline:
.LFB6:
	.cfi_startproc
	pushl	16(%esp)
	.cfi_def_cfa_offset 8
	pushl	$1
	.cfi_def_cfa_offset 12
	pushl	20(%esp)
	.cfi_def_cfa_offset 16
	pushl	20(%esp)
	.cfi_def_cfa_offset 20
	pushl	20(%esp)
	.cfi_def_cfa_offset 24
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE6:
	.size	gfx_draw_hline, .-gfx_draw_hline
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.align 4
	.globl	gfx_draw_vline
	.type	gfx_draw_vline, @function
gfx_draw_vline:
.LFB7:
	.cfi_startproc
	pushl	16(%esp)
	.cfi_def_cfa_offset 8
	pushl	16(%esp)
	.cfi_def_cfa_offset 12
	pushl	$1
	.cfi_def_cfa_offset 16
	pushl	20(%esp)
	.cfi_def_cfa_offset 20
	pushl	20(%esp)
	.cfi_def_cfa_offset 24
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE7:
	.size	gfx_draw_vline, .-gfx_draw_vline
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.globl	gfx_draw_rect
	.type	gfx_draw_rect, @function
gfx_draw_rect:
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
	pushl	%eax
	.cfi_def_cfa_offset 24
	movl	24(%esp), %ebx
	movl	28(%esp), %esi
	movl	32(%esp), %eax
	movl	36(%esp), %ebp
	movl	40(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 28
	pushl	$1
	.cfi_def_cfa_offset 32
	pushl	%eax
	.cfi_def_cfa_offset 36
	movl	%eax, 12(%esp)
	pushl	%esi
	.cfi_def_cfa_offset 40
	pushl	%ebx
	.cfi_def_cfa_offset 44
	call	gfx_fill_rect
	pushl	%edi
	.cfi_def_cfa_offset 48
	pushl	$1
	.cfi_def_cfa_offset 52
	movl	28(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 56
	movl	%eax, 32(%esp)
	leal	-1(%esi,%ebp), %edx
	pushl	%edx
	.cfi_def_cfa_offset 60
	pushl	%ebx
	.cfi_def_cfa_offset 64
	call	gfx_fill_rect
	addl	$40, %esp
	.cfi_def_cfa_offset 24
	pushl	%edi
	.cfi_def_cfa_offset 28
	pushl	%ebp
	.cfi_def_cfa_offset 32
	pushl	$1
	.cfi_def_cfa_offset 36
	pushl	%esi
	.cfi_def_cfa_offset 40
	pushl	%ebx
	.cfi_def_cfa_offset 44
	call	gfx_fill_rect
	movl	%edi, 60(%esp)
	movl	%ebp, 56(%esp)
	movl	$1, 52(%esp)
	movl	%esi, 48(%esp)
	movl	20(%esp), %eax
	leal	-1(%ebx,%eax), %eax
	movl	%eax, 44(%esp)
	addl	$24, %esp
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
	jmp	gfx_fill_rect
	.cfi_endproc
.LFE8:
	.size	gfx_draw_rect, .-gfx_draw_rect
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.globl	gfx_draw_char
	.type	gfx_draw_char, @function
gfx_draw_char:
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
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	movl	40(%esp), %edx
	movl	52(%esp), %ebp
	testb	%dl, %dl
	js	.L47
	movsbl	%dl, %edx
	testl	%ebp, %ebp
	jle	.L53
.L43:
	leal	font8x8_basic(,%edx,8), %eax
	movl	%eax, 4(%esp)
	movl	36(%esp), %esi
	addl	$8, %eax
	movl	%eax, 8(%esp)
	.align 4
.L46:
	movl	4(%esp), %eax
	movzbl	(%eax), %eax
	movl	%eax, (%esp)
	movl	32(%esp), %edi
	xorl	%ebx, %ebx
	movl	%ebp, 52(%esp)
	movl	%edi, %ebp
	movl	52(%esp), %edi
	jmp	.L45
	.align 4
.L55:
	movl	44(%esp), %edx
.L44:
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	%edi
	.cfi_def_cfa_offset 40
	pushl	%edi
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	pushl	%ebp
	.cfi_def_cfa_offset 52
	call	gfx_fill_rect
	incl	%ebx
	addl	%edi, %ebp
	addl	$20, %esp
	.cfi_def_cfa_offset 32
	cmpl	$8, %ebx
	je	.L54
.L45:
	movl	(%esp), %edx
	movb	%bl, %cl
	sarl	%cl, %edx
	andl	$1, %edx
	jne	.L55
	movl	48(%esp), %edx
	jmp	.L44
	.align 4
.L54:
	movl	%edi, %ebp
	incl	4(%esp)
	movl	4(%esp), %eax
	addl	%edi, %esi
	cmpl	%eax, 8(%esp)
	jne	.L46
	addl	$12, %esp
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
.L47:
	.cfi_restore_state
	movl	$63, %edx
	testl	%ebp, %ebp
	jg	.L43
.L53:
	movl	$1, %ebp
	jmp	.L43
	.cfi_endproc
.LFE9:
	.size	gfx_draw_char, .-gfx_draw_char
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.globl	gfx_draw_string
	.type	gfx_draw_string, @function
gfx_draw_string:
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
	pushl	%edx
	.cfi_def_cfa_offset 24
	movl	24(%esp), %ebx
	movl	32(%esp), %edx
	movl	40(%esp), %ebp
	movl	44(%esp), %esi
	movsbl	(%edx), %eax
	testb	%al, %al
	je	.L56
	leal	0(,%esi,8), %ecx
	movl	%ecx, (%esp)
	leal	1(%edx), %edi
	movl	%ebx, %esi
	movl	%edi, %ebx
	movl	44(%esp), %edi
	.align 4
.L58:
	pushl	%edi
	.cfi_def_cfa_offset 28
	pushl	%ebp
	.cfi_def_cfa_offset 32
	pushl	44(%esp)
	.cfi_def_cfa_offset 36
	pushl	%eax
	.cfi_def_cfa_offset 40
	pushl	44(%esp)
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	gfx_draw_char
	addl	24(%esp), %esi
	incl	%ebx
	movsbl	-1(%ebx), %eax
	addl	$24, %esp
	.cfi_def_cfa_offset 24
	testb	%al, %al
	jne	.L58
.L56:
	popl	%eax
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
.LFE10:
	.size	gfx_draw_string, .-gfx_draw_string
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.globl	gfx_blit_up
	.type	gfx_blit_up, @function
gfx_blit_up:
.LFB11:
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
	subl	$16, %esp
	.cfi_def_cfa_offset 36
	movl	40(%esp), %edi
	movl	52(%esp), %eax
	movl	s_fb, %ebp
	testl	%ebp, %ebp
	je	.L62
	testl	%eax, %eax
	jle	.L62
	movl	44(%esp), %ecx
	testl	%ecx, %ecx
	jle	.L62
	movl	48(%esp), %edx
	testl	%edx, %edx
	jle	.L62
	movl	48(%esp), %edx
	addl	%edi, %edx
	subl	%eax, %edx
	movl	%edx, (%esp)
	cmpl	%edx, %edi
	jge	.L62
	movl	s_pitch_px, %edx
	leal	0(,%edx,4), %esi
	movl	%esi, 4(%esp)
	addl	%edi, %eax
	imull	%eax, %edx
	movl	36(%esp), %ecx
	addl	%edx, %ecx
	sall	$2, %ecx
	movl	%edi, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	imull	%esi, %eax
	movl	%eax, 8(%esp)
	movl	44(%esp), %eax
	sall	$2, %eax
	movl	%eax, 12(%esp)
	.align 4
.L66:
	movl	8(%esp), %eax
	leal	(%ecx,%eax), %esi
	leal	0(%ebp,%ecx), %eax
	movl	12(%esp), %ebx
	addl	%ecx, %ebx
	addl	%ebp, %ebx
	movl	%edi, 40(%esp)
	.align 4
.L65:
	movl	%eax, %edx
	subl	%ecx, %edx
	movl	(%eax), %edi
	movl	%edi, (%edx,%esi)
	addl	$4, %eax
	cmpl	%eax, %ebx
	jne	.L65
	movl	40(%esp), %edi
	incl	%edi
	addl	4(%esp), %ecx
	cmpl	%edi, (%esp)
	jne	.L66
.L62:
	addl	$16, %esp
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
.LFE11:
	.size	gfx_blit_up, .-gfx_blit_up
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.local	s_pitch_px
	.comm	s_pitch_px,4,4
	.local	s_height
	.comm	s_height,4,4
	.local	s_width
	.comm	s_width,4,4
	.local	s_fb
	.comm	s_fb,4,4
	.globl	font8x8_basic
	.data
	.align 32
	.type	font8x8_basic, @object
	.size	font8x8_basic, 1024
font8x8_basic:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	60
	.byte	60
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	0
	.byte	54
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	54
	.byte	54
	.byte	127
	.byte	54
	.byte	127
	.byte	54
	.byte	54
	.byte	0
	.byte	12
	.byte	62
	.byte	3
	.byte	30
	.byte	48
	.byte	31
	.byte	12
	.byte	0
	.byte	0
	.byte	99
	.byte	51
	.byte	24
	.byte	12
	.byte	102
	.byte	99
	.byte	0
	.byte	28
	.byte	54
	.byte	28
	.byte	110
	.byte	59
	.byte	51
	.byte	110
	.byte	0
	.byte	6
	.byte	6
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	12
	.byte	6
	.byte	6
	.byte	6
	.byte	12
	.byte	24
	.byte	0
	.byte	6
	.byte	12
	.byte	24
	.byte	24
	.byte	24
	.byte	12
	.byte	6
	.byte	0
	.byte	0
	.byte	102
	.byte	60
	.byte	-1
	.byte	60
	.byte	102
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	63
	.byte	12
	.byte	12
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.byte	63
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	0
	.byte	96
	.byte	48
	.byte	24
	.byte	12
	.byte	6
	.byte	3
	.byte	1
	.byte	0
	.byte	62
	.byte	99
	.byte	115
	.byte	123
	.byte	111
	.byte	103
	.byte	62
	.byte	0
	.byte	12
	.byte	14
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	63
	.byte	0
	.byte	30
	.byte	51
	.byte	48
	.byte	28
	.byte	6
	.byte	51
	.byte	63
	.byte	0
	.byte	30
	.byte	51
	.byte	48
	.byte	28
	.byte	48
	.byte	51
	.byte	30
	.byte	0
	.byte	56
	.byte	60
	.byte	54
	.byte	51
	.byte	127
	.byte	48
	.byte	120
	.byte	0
	.byte	63
	.byte	3
	.byte	31
	.byte	48
	.byte	48
	.byte	51
	.byte	30
	.byte	0
	.byte	28
	.byte	6
	.byte	3
	.byte	31
	.byte	51
	.byte	51
	.byte	30
	.byte	0
	.byte	63
	.byte	51
	.byte	48
	.byte	24
	.byte	12
	.byte	12
	.byte	12
	.byte	0
	.byte	30
	.byte	51
	.byte	51
	.byte	30
	.byte	51
	.byte	51
	.byte	30
	.byte	0
	.byte	30
	.byte	51
	.byte	51
	.byte	62
	.byte	48
	.byte	24
	.byte	14
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	0
	.byte	0
	.byte	12
	.byte	12
	.byte	6
	.byte	24
	.byte	12
	.byte	6
	.byte	3
	.byte	6
	.byte	12
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	63
	.byte	0
	.byte	0
	.byte	63
	.byte	0
	.byte	0
	.byte	6
	.byte	12
	.byte	24
	.byte	48
	.byte	24
	.byte	12
	.byte	6
	.byte	0
	.byte	30
	.byte	51
	.byte	48
	.byte	24
	.byte	12
	.byte	0
	.byte	12
	.byte	0
	.byte	62
	.byte	99
	.byte	123
	.byte	123
	.byte	123
	.byte	3
	.byte	30
	.byte	0
	.byte	12
	.byte	30
	.byte	51
	.byte	51
	.byte	63
	.byte	51
	.byte	51
	.byte	0
	.byte	63
	.byte	102
	.byte	102
	.byte	62
	.byte	102
	.byte	102
	.byte	63
	.byte	0
	.byte	60
	.byte	102
	.byte	3
	.byte	3
	.byte	3
	.byte	102
	.byte	60
	.byte	0
	.byte	31
	.byte	54
	.byte	102
	.byte	102
	.byte	102
	.byte	54
	.byte	31
	.byte	0
	.byte	127
	.byte	70
	.byte	22
	.byte	30
	.byte	22
	.byte	70
	.byte	127
	.byte	0
	.byte	127
	.byte	70
	.byte	22
	.byte	30
	.byte	22
	.byte	6
	.byte	15
	.byte	0
	.byte	60
	.byte	102
	.byte	3
	.byte	3
	.byte	115
	.byte	102
	.byte	124
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	63
	.byte	51
	.byte	51
	.byte	51
	.byte	0
	.byte	30
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	30
	.byte	0
	.byte	120
	.byte	48
	.byte	48
	.byte	48
	.byte	51
	.byte	51
	.byte	30
	.byte	0
	.byte	103
	.byte	102
	.byte	54
	.byte	30
	.byte	54
	.byte	102
	.byte	103
	.byte	0
	.byte	15
	.byte	6
	.byte	6
	.byte	6
	.byte	70
	.byte	102
	.byte	127
	.byte	0
	.byte	99
	.byte	119
	.byte	127
	.byte	127
	.byte	107
	.byte	99
	.byte	99
	.byte	0
	.byte	99
	.byte	103
	.byte	111
	.byte	123
	.byte	115
	.byte	99
	.byte	99
	.byte	0
	.byte	28
	.byte	54
	.byte	99
	.byte	99
	.byte	99
	.byte	54
	.byte	28
	.byte	0
	.byte	63
	.byte	102
	.byte	102
	.byte	62
	.byte	6
	.byte	6
	.byte	15
	.byte	0
	.byte	30
	.byte	51
	.byte	51
	.byte	51
	.byte	59
	.byte	30
	.byte	56
	.byte	0
	.byte	63
	.byte	102
	.byte	102
	.byte	62
	.byte	54
	.byte	102
	.byte	103
	.byte	0
	.byte	30
	.byte	51
	.byte	7
	.byte	14
	.byte	56
	.byte	51
	.byte	30
	.byte	0
	.byte	63
	.byte	45
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	30
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	63
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	30
	.byte	12
	.byte	0
	.byte	99
	.byte	99
	.byte	99
	.byte	107
	.byte	127
	.byte	119
	.byte	99
	.byte	0
	.byte	99
	.byte	99
	.byte	54
	.byte	28
	.byte	28
	.byte	54
	.byte	99
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	30
	.byte	12
	.byte	12
	.byte	30
	.byte	0
	.byte	127
	.byte	99
	.byte	49
	.byte	24
	.byte	76
	.byte	102
	.byte	127
	.byte	0
	.byte	30
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	30
	.byte	0
	.byte	3
	.byte	6
	.byte	12
	.byte	24
	.byte	48
	.byte	96
	.byte	64
	.byte	0
	.byte	30
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	30
	.byte	0
	.byte	8
	.byte	28
	.byte	54
	.byte	99
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	12
	.byte	12
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	48
	.byte	62
	.byte	51
	.byte	110
	.byte	0
	.byte	7
	.byte	6
	.byte	6
	.byte	62
	.byte	102
	.byte	102
	.byte	59
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	51
	.byte	3
	.byte	51
	.byte	30
	.byte	0
	.byte	56
	.byte	48
	.byte	48
	.byte	62
	.byte	51
	.byte	51
	.byte	110
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	51
	.byte	63
	.byte	3
	.byte	30
	.byte	0
	.byte	28
	.byte	54
	.byte	6
	.byte	15
	.byte	6
	.byte	6
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	110
	.byte	51
	.byte	51
	.byte	62
	.byte	48
	.byte	31
	.byte	7
	.byte	6
	.byte	54
	.byte	110
	.byte	102
	.byte	102
	.byte	103
	.byte	0
	.byte	12
	.byte	0
	.byte	14
	.byte	12
	.byte	12
	.byte	12
	.byte	30
	.byte	0
	.byte	48
	.byte	0
	.byte	48
	.byte	48
	.byte	48
	.byte	51
	.byte	51
	.byte	30
	.byte	7
	.byte	6
	.byte	102
	.byte	54
	.byte	30
	.byte	54
	.byte	103
	.byte	0
	.byte	14
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	51
	.byte	127
	.byte	127
	.byte	107
	.byte	99
	.byte	0
	.byte	0
	.byte	0
	.byte	31
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	0
	.byte	0
	.byte	0
	.byte	30
	.byte	51
	.byte	51
	.byte	51
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	59
	.byte	102
	.byte	102
	.byte	62
	.byte	6
	.byte	15
	.byte	0
	.byte	0
	.byte	110
	.byte	51
	.byte	51
	.byte	62
	.byte	48
	.byte	120
	.byte	0
	.byte	0
	.byte	59
	.byte	110
	.byte	102
	.byte	6
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	62
	.byte	3
	.byte	30
	.byte	48
	.byte	31
	.byte	0
	.byte	8
	.byte	12
	.byte	62
	.byte	12
	.byte	12
	.byte	44
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	51
	.byte	110
	.byte	0
	.byte	0
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	30
	.byte	12
	.byte	0
	.byte	0
	.byte	0
	.byte	99
	.byte	107
	.byte	127
	.byte	127
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	99
	.byte	54
	.byte	28
	.byte	54
	.byte	99
	.byte	0
	.byte	0
	.byte	0
	.byte	51
	.byte	51
	.byte	51
	.byte	62
	.byte	48
	.byte	31
	.byte	0
	.byte	0
	.byte	63
	.byte	25
	.byte	12
	.byte	38
	.byte	63
	.byte	0
	.byte	56
	.byte	12
	.byte	12
	.byte	7
	.byte	12
	.byte	12
	.byte	56
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	7
	.byte	12
	.byte	12
	.byte	56
	.byte	12
	.byte	12
	.byte	7
	.byte	0
	.byte	110
	.byte	59
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.ident	"GCC: (GNU) 5.2.0"
