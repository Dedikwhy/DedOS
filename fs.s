	.file	"fs.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	fs_init
	.type	fs_init, @function
fs_init:
.LFB1:
	.cfi_startproc
	movl	$ramdisk+1060, %eax
	.align 4
.L2:
	movl	$0, (%eax)
	movl	$0, -4(%eax)
	movb	$0, 4(%eax)
	movb	$0, -1060(%eax)
	movb	$0, -1028(%eax)
	movb	$0, 5(%eax)
	addl	$1132, %eax
	cmpl	$ramdisk+19172, %eax
	jne	.L2
	ret
	.cfi_endproc
.LFE1:
	.size	fs_init, .-fs_init
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"[DIR]"
.LC2:
	.string	""
.LC3:
	.string	"--- Filesystem (RAM) ---\n"
.LC4:
	.string	"  %s %s (%d bytes)\n"
.LC5:
	.string	"  (empty)\n"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.globl	fs_list
	.type	fs_list, @function
fs_list:
.LFB2:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$16, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC3
	.cfi_def_cfa_offset 32
	call	print
	movl	$ramdisk, %ebx
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	xorl	%esi, %esi
	jmp	.L8
	.align 4
.L14:
	movl	$.LC2, %eax
.L7:
	pushl	%edx
	.cfi_def_cfa_offset 20
	pushl	%eax
	.cfi_def_cfa_offset 24
	pushl	%ebx
	.cfi_def_cfa_offset 28
	pushl	$.LC4
	.cfi_def_cfa_offset 32
	call	print
	incl	%esi
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L6:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L13
.L8:
	movl	1060(%ebx), %edx
	testl	%edx, %edx
	je	.L6
	movl	1056(%ebx), %edx
	cmpb	$0, 1064(%ebx)
	je	.L14
	movl	$.LC1, %eax
	jmp	.L7
	.align 4
.L13:
	testl	%esi, %esi
	jne	.L5
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	$.LC5
	.cfi_def_cfa_offset 32
	call	print
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L5:
	popl	%eax
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
	.size	fs_list, .-fs_list
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.align 4
	.globl	fs_create
	.type	fs_create, @function
fs_create:
.LFB3:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	16(%esp), %esi
	movl	$ramdisk, %ebx
	jmp	.L17
	.align 4
.L20:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L37
.L17:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L20
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%esi
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L20
	movl	$-1, %eax
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L37:
	.cfi_restore_state
	movl	$ramdisk+1060, %ecx
	xorl	%edx, %edx
	.align 4
.L24:
	movl	(%ecx), %eax
	testl	%eax, %eax
	je	.L38
	incl	%edx
	addl	$1132, %ecx
	cmpl	$16, %edx
	jne	.L24
	movl	$-2, %eax
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L38:
	.cfi_restore_state
	movb	(%esi), %bl
	testb	%bl, %bl
	je	.L26
	leal	(%edx,%edx,4), %edi
	leal	0(,%edi,8), %ecx
	subl	%edi, %ecx
	leal	(%edx,%ecx,4), %ecx
	addl	%ecx, %ecx
	leal	(%ecx,%edx), %edi
	sall	$2, %edi
	xorl	%ecx, %ecx
	jmp	.L23
	.align 4
.L39:
	cmpl	$31, %ecx
	je	.L22
.L23:
	movb	%bl, ramdisk(%edi,%ecx)
	incl	%ecx
	movb	(%esi,%ecx), %bl
	testb	%bl, %bl
	jne	.L39
.L22:
	leal	(%edx,%edx,4), %esi
	leal	0(,%esi,8), %ebx
	subl	%esi, %ebx
	leal	(%edx,%ebx,4), %ebx
	addl	%ebx, %ebx
	addl	%ebx, %edx
	leal	ramdisk(,%edx,4), %edx
	movb	$0, (%edx,%ecx)
	movl	$0, 1056(%edx)
	movb	$0, 32(%edx)
	movb	$0, 1064(%edx)
	movl	$1, 1060(%edx)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
.L26:
	.cfi_restore_state
	xorl	%ecx, %ecx
	jmp	.L22
	.cfi_endproc
.LFE3:
	.size	fs_create, .-fs_create
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.globl	fs_write
	.type	fs_write, @function
fs_write:
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
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %ebp
	movl	36(%esp), %edi
	movl	$ramdisk, %ebx
	xorl	%esi, %esi
	jmp	.L47
	.align 4
.L41:
	incl	%esi
	addl	$1132, %ebx
	cmpl	$16, %esi
	je	.L51
.L47:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L41
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L41
	movl	40(%esp), %eax
	cmpl	$1023, %eax
	jbe	.L42
	movl	$1023, %eax
.L43:
	leal	(%esi,%esi,4), %ecx
	leal	0(,%ecx,8), %edx
	subl	%ecx, %edx
	leal	(%esi,%edx,4), %edx
	addl	%edx, %edx
	leal	(%edx,%esi), %ecx
	sall	$2, %ecx
	xorl	%edx, %edx
	.align 4
.L45:
	movb	(%edi,%edx), %bl
	movb	%bl, ramdisk+32(%ecx,%edx)
	incl	%edx
	cmpl	%eax, %edx
	jne	.L45
.L46:
	leal	(%esi,%esi,4), %ecx
	leal	0(,%ecx,8), %edx
	subl	%ecx, %edx
	leal	(%esi,%edx,4), %edx
	addl	%edx, %edx
	addl	%edx, %esi
	leal	ramdisk(,%esi,4), %edx
	movb	$0, 32(%edx,%eax)
	movl	%eax, 1056(%edx)
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
	.align 4
.L51:
	.cfi_restore_state
	movl	$-1, %eax
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
.L42:
	.cfi_restore_state
	testl	%eax, %eax
	jne	.L43
	jmp	.L46
	.cfi_endproc
.LFE4:
	.size	fs_write, .-fs_write
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.globl	fs_get
	.type	fs_get, @function
fs_get:
.LFB5:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	movl	16(%esp), %esi
	movl	$ramdisk, %ebx
	jmp	.L54
	.align 4
.L56:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L59
.L54:
	movl	1060(%ebx), %ecx
	testl	%ecx, %ecx
	je	.L56
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%esi
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L56
	movl	%ebx, %eax
	popl	%edx
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L59:
	.cfi_restore_state
	xorl	%eax, %eax
	popl	%edx
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE5:
	.size	fs_get, .-fs_get
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.globl	fs_remove
	.type	fs_remove, @function
fs_remove:
.LFB6:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	16(%esp), %edi
	testl	%edi, %edi
	je	.L63
	cmpb	$0, (%edi)
	je	.L63
	movl	$ramdisk, %ebx
	xorl	%esi, %esi
	jmp	.L65
	.align 4
.L64:
	incl	%esi
	addl	$1132, %ebx
	cmpl	$16, %esi
	je	.L63
.L65:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L64
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%edi
	.cfi_def_cfa_offset 28
	pushl	%ebx
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L64
	leal	(%esi,%esi,4), %ecx
	leal	0(,%ecx,8), %edx
	subl	%ecx, %edx
	leal	(%esi,%edx,4), %edx
	addl	%edx, %edx
	addl	%esi, %edx
	sall	$2, %edx
	movl	$0, ramdisk+1060(%edx)
	movb	$0, ramdisk(%edx)
	movb	$0, ramdisk+32(%edx)
	movl	$0, ramdisk+1056(%edx)
	movb	$0, ramdisk+1064(%edx)
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.align 4
.L63:
	.cfi_restore_state
	movl	$-1, %eax
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
.LFE6:
	.size	fs_remove, .-fs_remove
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.globl	fs_mkdir
	.type	fs_mkdir, @function
fs_mkdir:
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
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %edi
	movl	36(%esp), %esi
	testl	%edi, %edi
	je	.L71
	cmpb	$0, (%edi)
	je	.L71
	movl	$ramdisk, %ebx
	jmp	.L73
	.align 4
.L75:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L99
.L73:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L75
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%esi
	.cfi_def_cfa_offset 44
	leal	1065(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L75
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%edi
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L75
	movl	$-2, %eax
	jmp	.L70
	.align 4
.L99:
	movl	$ramdisk+1060, %edx
	xorl	%ecx, %ecx
	.align 4
.L81:
	movl	(%edx), %eax
	testl	%eax, %eax
	je	.L100
	incl	%ecx
	addl	$1132, %edx
	cmpl	$16, %ecx
	jne	.L81
.L71:
	movl	$-1, %eax
.L70:
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
	.align 4
.L100:
	.cfi_restore_state
	leal	(%ecx,%ecx,4), %ebx
	leal	0(,%ebx,8), %edx
	subl	%ebx, %edx
	leal	(%ecx,%edx,4), %edx
	leal	(%edx,%edx), %ebp
	addl	%ecx, %ebp
	sall	$2, %ebp
	movl	$1, ramdisk+1060(%ebp)
	movb	$1, ramdisk+1064(%ebp)
	movl	$0, ramdisk+1056(%ebp)
	movb	(%edi), %bl
	xorl	%edx, %edx
	testb	%bl, %bl
	jne	.L78
	jmp	.L77
	.align 4
.L101:
	cmpl	$31, %edx
	je	.L77
.L78:
	movb	%bl, ramdisk(%ebp,%edx)
	incl	%edx
	movb	(%edi,%edx), %bl
	testb	%bl, %bl
	jne	.L101
.L77:
	leal	(%ecx,%ecx,4), %edi
	leal	0(,%edi,8), %ebx
	subl	%edi, %ebx
	leal	(%ecx,%ebx,4), %ebx
	leal	(%ebx,%ebx), %edi
	addl	%ecx, %edi
	sall	$2, %edi
	movb	$0, ramdisk(%edx,%edi)
	movb	(%esi), %bl
	xorl	%edx, %edx
	testb	%bl, %bl
	jne	.L80
	jmp	.L79
	.align 4
.L102:
	cmpl	$63, %edx
	je	.L79
.L80:
	movb	%bl, ramdisk+1065(%edi,%edx)
	incl	%edx
	movb	(%esi,%edx), %bl
	testb	%bl, %bl
	jne	.L102
.L79:
	leal	(%ecx,%ecx,4), %esi
	leal	0(,%esi,8), %ebx
	subl	%esi, %ebx
	leal	(%ecx,%ebx,4), %ebx
	addl	%ebx, %ebx
	addl	%ebx, %ecx
	movb	$0, ramdisk+1065(%edx,%ecx,4)
	addl	$12, %esp
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
.LFE7:
	.size	fs_mkdir, .-fs_mkdir
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.str1.1
.LC12:
	.string	"/"
.LC13:
	.string	".."
	.section	.text.unlikely
.LCOLDB14:
	.text
.LHOTB14:
	.align 4
	.globl	fs_cd
	.type	fs_cd, @function
fs_cd:
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
	subl	$20, %esp
	.cfi_def_cfa_offset 40
	movl	40(%esp), %ebp
	movl	44(%esp), %edi
	pushl	$.LC12
	.cfi_def_cfa_offset 44
	pushl	%ebp
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L104
	movl	%eax, %esi
	movb	$47, (%edi)
	movb	$0, 1(%edi)
.L105:
	movl	%esi, %eax
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
	.align 4
.L104:
	.cfi_restore_state
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	$.LC13
	.cfi_def_cfa_offset 44
	pushl	%ebp
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	je	.L123
	movl	$ramdisk, %ebx
	jmp	.L113
	.align 4
.L112:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L124
.L113:
	movl	1060(%ebx), %ecx
	testl	%ecx, %ecx
	je	.L112
	cmpb	$0, 1064(%ebx)
	je	.L112
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%edi
	.cfi_def_cfa_offset 44
	leal	1065(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L112
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	strcmp
	movl	%eax, %esi
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L112
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	%edi
	.cfi_def_cfa_offset 48
	call	strcat
	popl	%eax
	.cfi_def_cfa_offset 44
	popl	%edx
	.cfi_def_cfa_offset 40
	pushl	$.LC12
	.cfi_def_cfa_offset 44
	pushl	%edi
	.cfi_def_cfa_offset 48
	call	strcat
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	jmp	.L105
	.align 4
.L124:
	movl	$-1, %esi
	movl	%esi, %eax
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
	.align 4
.L123:
	.cfi_restore_state
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	$.LC12
	.cfi_def_cfa_offset 44
	pushl	%edi
	.cfi_def_cfa_offset 48
	call	strcmp
	movl	%eax, %esi
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	je	.L105
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	%edi
	.cfi_def_cfa_offset 48
	call	strlen
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	cmpl	$1, %eax
	jle	.L107
	decl	%eax
	leal	(%edi,%eax), %edx
	cmpb	$47, (%edx)
	jne	.L111
	jmp	.L125
	.align 4
.L127:
	decl	%eax
.L111:
	testl	%eax, %eax
	je	.L126
.L109:
	movl	%eax, %edx
	cmpb	$47, -1(%edi,%eax)
	jne	.L127
.L110:
	movb	$0, (%edi,%edx)
	xorl	%esi, %esi
	jmp	.L105
.L126:
	xorl	%edx, %edx
	jmp	.L110
.L107:
	movl	%eax, %edx
	testl	%eax, %eax
	jg	.L109
	jmp	.L110
.L125:
	movb	$0, (%edx)
	jmp	.L109
	.cfi_endproc
.LFE8:
	.size	fs_cd, .-fs_cd
	.section	.text.unlikely
.LCOLDE14:
	.text
.LHOTE14:
	.local	ramdisk
	.comm	ramdisk,18112,32
	.ident	"GCC: (GNU) 5.2.0"
