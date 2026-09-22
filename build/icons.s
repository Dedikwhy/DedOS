	.file	"icons.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.type	page, @function
page:
.LFB1:
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
	subl	$24, %esp
	.cfi_def_cfa_offset 44
	movl	%eax, %ebp
	movl	%ecx, %ebx
	leal	(%ecx,%edx), %edi
	pushl	$11194321
	.cfi_def_cfa_offset 48
	leal	(%ecx,%ecx), %ecx
	addl	%ebx, %ecx
	leal	(%ecx,%ecx), %esi
	addl	%ebx, %esi
	addl	%esi, %esi
	pushl	%esi
	.cfi_def_cfa_offset 52
	leal	0(,%ebx,4), %esi
	leal	(%esi,%ebx), %eax
	addl	%eax, %eax
	pushl	%eax
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	addl	%ebp, %ecx
	pushl	%ecx
	.cfi_def_cfa_offset 64
	call	gfx_fill_rect
	leal	(%ebx,%ebx,8), %eax
	addl	%eax, %ebp
	addl	$20, %esp
	.cfi_def_cfa_offset 44
	pushl	$5996420
	.cfi_def_cfa_offset 48
	pushl	%esi
	.cfi_def_cfa_offset 52
	pushl	%esi
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	pushl	%ebp
	.cfi_def_cfa_offset 64
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 44
	pushl	$528660
	.cfi_def_cfa_offset 48
	pushl	%ebx
	.cfi_def_cfa_offset 52
	pushl	%ebx
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	pushl	%ebp
	.cfi_def_cfa_offset 64
	call	gfx_fill_rect
	addl	$44, %esp
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
.LFE1:
	.size	page, .-page
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	icon_draw
	.type	icon_draw, @function
icon_draw:
.LFB2:
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
	movl	60(%esp), %ebx
	testl	%ebx, %ebx
	js	.L19
.L4:
	sarl	$4, %ebx
	testl	%ebx, %ebx
	jle	.L20
.L5:
	cmpl	$8, %eax
	ja	.L3
	jmp	*.L8(,%eax,4)
	.section	.rodata
	.align 4
	.align 4
.L8:
	.long	.L7
	.long	.L9
	.long	.L10
	.long	.L11
	.long	.L9
	.long	.L12
	.long	.L13
	.long	.L14
	.long	.L15
	.text
	.align 4
.L10:
	movl	%ebx, %ecx
	movl	56(%esp), %edx
	movl	52(%esp), %eax
	call	page
	leal	(%ebx,%ebx), %ebp
	leal	0(%ebp,%ebx), %eax
	addl	%eax, %eax
	leal	(%eax,%ebx), %edi
	addl	56(%esp), %edi
	leal	0(,%ebx,4), %edx
	leal	(%edx,%ebx), %esi
	movl	%edx, 8(%esp)
	addl	52(%esp), %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%eax
	.cfi_def_cfa_offset 72
	movl	%eax, 28(%esp)
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebp, %edi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	movl	24(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	movl	28(%esp), %edx
	pushl	%edx
	.cfi_def_cfa_offset 72
.L17:
	addl	%ebp, %edi
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
.L3:
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
	.align 4
.L20:
	.cfi_restore_state
	movl	$1, %ebx
	jmp	.L5
	.align 4
.L19:
	addl	$15, %ebx
	jmp	.L4
	.align 4
.L14:
	leal	(%ebx,%ebx), %edx
	leal	(%edx,%ebx), %eax
	sall	$2, %eax
	movl	56(%esp), %edi
	addl	%edx, %edi
	movl	%edx, %esi
	movl	%edx, 4(%esp)
	addl	52(%esp), %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%eax
	.cfi_def_cfa_offset 68
	pushl	%eax
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	leal	0(,%ebx,4), %ebp
	leal	0(%ebp,%ebx), %eax
	addl	%ebx, %edi
	addl	%eax, %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%eax
	.cfi_def_cfa_offset 68
	movl	%eax, 28(%esp)
	movl	24(%esp), %edx
	pushl	%edx
	.cfi_def_cfa_offset 72
	movl	%edx, 28(%esp)
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebp, %edi
	movl	36(%esp), %edx
	subl	%edx, %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebp
	.cfi_def_cfa_offset 68
	pushl	%ebx
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	movl	40(%esp), %eax
	addl	%eax, %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebp
	.cfi_def_cfa_offset 68
	pushl	%ebx
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%ebp
	.cfi_def_cfa_offset 72
	addl	%ebp, %edi
	pushl	%edi
	.cfi_def_cfa_offset 76
	subl	%ebp, %esi
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
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
	.align 4
.L15:
	.cfi_restore_state
	leal	(%ebx,%ebx), %eax
	leal	(%eax,%ebx), %ebp
	leal	0(,%ebp,4), %edx
	movl	56(%esp), %esi
	addl	%eax, %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%edx
	.cfi_def_cfa_offset 68
	pushl	%edx
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	addl	80(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	leal	0(%ebp,%ebp), %eax
	leal	0(,%ebx,4), %edx
	leal	(%edx,%ebx), %ecx
	movl	%edx, 44(%esp)
	addl	%ebp, %esi
	movl	%ecx, 36(%esp)
	movl	84(%esp), %edi
	addl	%ecx, %edi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%eax
	.cfi_def_cfa_offset 72
	movl	%eax, 32(%esp)
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	movl	24(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 68
	movl	%eax, 28(%esp)
	pushl	%ebx
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	36(%esp), %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	movl	28(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	movl	28(%esp), %edx
	pushl	%edx
	.cfi_def_cfa_offset 68
	pushl	%ebx
	.cfi_def_cfa_offset 72
	subl	%ebp, %esi
	pushl	%esi
	.cfi_def_cfa_offset 76
	movl	32(%esp), %ecx
	movl	%ecx, %edi
	addl	%ecx, %edi
	movl	80(%esp), %eax
	addl	%edi, %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
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
	.align 4
.L7:
	.cfi_restore_state
	leal	(%ebx,%ebx), %ebp
	leal	0(%ebp,%ebx), %eax
	leal	0(,%eax,4), %edx
	movl	56(%esp), %edi
	addl	%ebp, %edi
	movl	52(%esp), %esi
	addl	%ebx, %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%edx
	.cfi_def_cfa_offset 68
	movl	%edx, 24(%esp)
	addl	%eax, %eax
	addl	%ebx, %eax
	addl	%eax, %eax
	pushl	%eax
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebp, %edi
	addl	%ebx, %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$330510
	.cfi_def_cfa_offset 64
	leal	(%ebx,%ebx,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 68
	movl	24(%esp), %edx
	pushl	%edx
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebp, %edi
	addl	%ebp, %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%ebx
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebx, %edi
	leal	(%ebx,%esi), %eax
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%ebx
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%eax
	.cfi_def_cfa_offset 80
	movl	%eax, 36(%esp)
	call	gfx_fill_rect
	addl	%ebx, %edi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%ebx
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	leal	0(,%ebx,4), %edx
	pushl	%edx
	.cfi_def_cfa_offset 72
	addl	%edi, %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 76
	movl	32(%esp), %eax
	addl	%eax, %ebp
	pushl	%ebp
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
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
	.align 4
.L9:
	.cfi_restore_state
	leal	(%ebx,%ebx), %edx
	leal	(%edx,%ebx), %eax
	movl	%edx, 4(%esp)
	movl	56(%esp), %edi
	addl	%eax, %edi
	movl	52(%esp), %esi
	addl	%ebx, %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$5996420
	.cfi_def_cfa_offset 64
	pushl	%eax
	.cfi_def_cfa_offset 68
	leal	(%eax,%eax), %ebp
	pushl	%ebp
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebx, %ebp
	addl	%ebp, %ebp
	movl	36(%esp), %edx
	addl	%edx, %edi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	leal	(%ebx,%ebx,8), %eax
	pushl	%eax
	.cfi_def_cfa_offset 68
	pushl	%ebp
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$14021621
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%ebp
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
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
	.align 4
.L11:
	.cfi_restore_state
	leal	(%ebx,%ebx), %ebp
	leal	0(%ebp,%ebx), %eax
	leal	0(,%eax,4), %edx
	movl	%eax, 4(%esp)
	movl	56(%esp), %esi
	addl	%ebp, %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%edx
	.cfi_def_cfa_offset 68
	pushl	%edx
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	movl	80(%esp), %edx
	addl	%ebp, %edx
	pushl	%edx
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	%ebp, %esi
	movl	36(%esp), %eax
	leal	(%eax,%eax), %edi
	addl	%ebx, %edi
	addl	84(%esp), %edi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebp
	.cfi_def_cfa_offset 68
	pushl	%ebp
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	leal	(%ebx,%ebx,4), %edx
	pushl	%edx
	.cfi_def_cfa_offset 68
	pushl	%ebp
	.cfi_def_cfa_offset 72
	movl	28(%esp), %eax
	addl	%eax, %esi
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	%edi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
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
	.align 4
.L12:
	.cfi_restore_state
	movl	%ebx, %ecx
	movl	56(%esp), %edx
	movl	52(%esp), %eax
	call	page
	leal	(%ebx,%ebx,4), %eax
	movl	56(%esp), %ecx
	leal	(%ecx,%ebx,8), %edi
	leal	(%ebx,%ebx), %ebp
	leal	0(%ebp,%ebx), %esi
	addl	%esi, %esi
	addl	52(%esp), %esi
	subl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	pushl	%eax
	.cfi_def_cfa_offset 72
	movl	%eax, 28(%esp)
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%ebx
	.cfi_def_cfa_offset 68
	movl	24(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 72
	jmp	.L17
	.align 4
.L13:
	.cfi_restore_state
	leal	(%ebx,%ebx), %eax
	leal	(%eax,%ebx), %esi
	leal	0(,%esi,4), %edx
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	pushl	$11194321
	.cfi_def_cfa_offset 64
	pushl	%edx
	.cfi_def_cfa_offset 68
	pushl	%edx
	.cfi_def_cfa_offset 72
	movl	80(%esp), %edx
	addl	%eax, %edx
	pushl	%edx
	.cfi_def_cfa_offset 76
	addl	80(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	leal	(%esi,%esi), %eax
	leal	0(,%ebx,4), %ebp
	leal	0(%ebp,%ebx), %esi
	movl	88(%esp), %edi
	addl	%esi, %edi
	addl	84(%esp), %esi
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$397332
	.cfi_def_cfa_offset 64
	pushl	%eax
	.cfi_def_cfa_offset 68
	pushl	%eax
	.cfi_def_cfa_offset 72
	pushl	%edi
	.cfi_def_cfa_offset 76
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 60
	pushl	$5996420
	.cfi_def_cfa_offset 64
	pushl	%ebp
	.cfi_def_cfa_offset 68
	pushl	%ebp
	.cfi_def_cfa_offset 72
	addl	%ebx, %edi
	pushl	%edi
	.cfi_def_cfa_offset 76
	addl	%esi, %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 80
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 48
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
.LFE2:
	.size	icon_draw, .-icon_draw
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.ident	"GCC: (GNU) 5.2.0"
