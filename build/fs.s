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
	subl	$12, %esp
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
.L6:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L13
.L8:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L6
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%edi
	.cfi_def_cfa_offset 28
	leal	1065(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	jne	.L6
	movl	1056(%ebx), %edx
	cmpb	$0, 1064(%ebx)
	jne	.L10
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
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	jne	.L8
	.align 4
.L13:
	testl	%esi, %esi
	je	.L14
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
.L10:
	.cfi_restore_state
	movl	$.LC1, %eax
	jmp	.L7
	.align 4
.L14:
	movl	$.LC5, 16(%esp)
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	jmp	print
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
	movl	$ramdisk, %ebx
	jmp	.L17
	.align 4
.L19:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L44
.L17:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L19
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
	jne	.L19
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
	jne	.L19
	movl	$-1, %eax
	jmp	.L20
	.align 4
.L44:
	movl	$ramdisk+1060, %edx
	xorl	%ecx, %ecx
	.align 4
.L26:
	movl	(%edx), %eax
	testl	%eax, %eax
	je	.L45
	incl	%ecx
	addl	$1132, %edx
	cmpl	$16, %ecx
	jne	.L26
	movl	$-2, %eax
.L20:
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
.L45:
	.cfi_restore_state
	movb	(%edi), %bl
	testb	%bl, %bl
	je	.L28
	leal	(%ecx,%ecx,4), %ebp
	leal	0(,%ebp,8), %edx
	subl	%ebp, %edx
	leal	(%ecx,%edx,4), %edx
	addl	%edx, %edx
	leal	(%edx,%ecx), %ebp
	sall	$2, %ebp
	xorl	%edx, %edx
	jmp	.L23
	.align 4
.L46:
	cmpl	$31, %edx
	je	.L22
.L23:
	movb	%bl, ramdisk(%ebp,%edx)
	incl	%edx
	movb	(%edi,%edx), %bl
	testb	%bl, %bl
	jne	.L46
.L22:
	leal	(%ecx,%ecx,4), %edi
	leal	0(,%edi,8), %ebx
	subl	%edi, %ebx
	leal	(%ecx,%ebx,4), %ebx
	leal	(%ebx,%ebx), %edi
	addl	%ecx, %edi
	sall	$2, %edi
	movb	$0, ramdisk(%edx,%edi)
	movl	$0, ramdisk+1056(%edi)
	movb	$0, ramdisk+32(%edi)
	movb	$0, ramdisk+1064(%edi)
	movl	$1, ramdisk+1060(%edi)
	movb	(%esi), %bl
	xorl	%edx, %edx
	testb	%bl, %bl
	jne	.L25
	jmp	.L24
	.align 4
.L47:
	cmpl	$63, %edx
	je	.L24
.L25:
	movb	%bl, ramdisk+1065(%edi,%edx)
	incl	%edx
	movb	(%esi,%edx), %bl
	testb	%bl, %bl
	jne	.L47
.L24:
	leal	(%ecx,%ecx,4), %esi
	leal	0(,%esi,8), %ebx
	subl	%esi, %ebx
	leal	(%ecx,%ebx,4), %ebx
	addl	%ebx, %ebx
	addl	%ebx, %ecx
	movb	$0, ramdisk+1065(%edx,%ecx,4)
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
.L28:
	.cfi_restore_state
	xorl	%edx, %edx
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
	jmp	.L55
	.align 4
.L49:
	incl	%esi
	addl	$1132, %ebx
	cmpl	$16, %esi
	je	.L59
.L55:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L49
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
	jne	.L49
	movl	40(%esp), %eax
	cmpl	$1023, %eax
	jbe	.L50
	movl	$1023, %eax
.L51:
	leal	(%esi,%esi,4), %ecx
	leal	0(,%ecx,8), %edx
	subl	%ecx, %edx
	leal	(%esi,%edx,4), %edx
	addl	%edx, %edx
	leal	(%edx,%esi), %ecx
	sall	$2, %ecx
	xorl	%edx, %edx
	.align 4
.L53:
	movb	(%edi,%edx), %bl
	movb	%bl, ramdisk+32(%ecx,%edx)
	incl	%edx
	cmpl	%eax, %edx
	jne	.L53
.L54:
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
.L59:
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
.L50:
	.cfi_restore_state
	testl	%eax, %eax
	jne	.L51
	jmp	.L54
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
	jmp	.L62
	.align 4
.L64:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L67
.L62:
	movl	1060(%ebx), %ecx
	testl	%ecx, %ecx
	je	.L64
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
	jne	.L64
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
.L67:
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
	je	.L71
	cmpb	$0, (%edi)
	je	.L71
	movl	$ramdisk, %ebx
	xorl	%esi, %esi
	jmp	.L73
	.align 4
.L72:
	incl	%esi
	addl	$1132, %ebx
	cmpl	$16, %esi
	je	.L71
.L73:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L72
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
	jne	.L72
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
.L71:
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
	je	.L79
	cmpb	$0, (%edi)
	je	.L79
	movl	$ramdisk, %ebx
	jmp	.L81
	.align 4
.L83:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L107
.L81:
	movl	1060(%ebx), %eax
	testl	%eax, %eax
	je	.L83
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
	jne	.L83
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
	jne	.L83
	movl	$-2, %eax
	jmp	.L78
	.align 4
.L107:
	movl	$ramdisk+1060, %edx
	xorl	%ecx, %ecx
	.align 4
.L89:
	movl	(%edx), %eax
	testl	%eax, %eax
	je	.L108
	incl	%ecx
	addl	$1132, %edx
	cmpl	$16, %ecx
	jne	.L89
.L79:
	movl	$-1, %eax
.L78:
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
.L108:
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
	jne	.L86
	jmp	.L85
	.align 4
.L109:
	cmpl	$31, %edx
	je	.L85
.L86:
	movb	%bl, ramdisk(%ebp,%edx)
	incl	%edx
	movb	(%edi,%edx), %bl
	testb	%bl, %bl
	jne	.L109
.L85:
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
	jne	.L88
	jmp	.L87
	.align 4
.L110:
	cmpl	$63, %edx
	je	.L87
.L88:
	movb	%bl, ramdisk+1065(%edi,%edx)
	incl	%edx
	movb	(%esi,%edx), %bl
	testb	%bl, %bl
	jne	.L110
.L87:
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
	jne	.L112
	movl	%eax, %esi
	movb	$47, (%edi)
	movb	$0, 1(%edi)
.L113:
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
.L112:
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
	je	.L131
	movl	$ramdisk, %ebx
	jmp	.L121
	.align 4
.L120:
	addl	$1132, %ebx
	cmpl	$ramdisk+18112, %ebx
	je	.L132
.L121:
	movl	1060(%ebx), %ecx
	testl	%ecx, %ecx
	je	.L120
	cmpb	$0, 1064(%ebx)
	je	.L120
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
	jne	.L120
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
	jne	.L120
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
	jmp	.L113
	.align 4
.L132:
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
.L131:
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
	je	.L113
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	%edi
	.cfi_def_cfa_offset 48
	call	strlen
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	cmpl	$1, %eax
	jle	.L115
	decl	%eax
	leal	(%edi,%eax), %edx
	cmpb	$47, (%edx)
	jne	.L119
	jmp	.L133
	.align 4
.L135:
	decl	%eax
.L119:
	testl	%eax, %eax
	je	.L134
.L117:
	movl	%eax, %edx
	cmpb	$47, -1(%edi,%eax)
	jne	.L135
.L118:
	movb	$0, (%edi,%edx)
	xorl	%esi, %esi
	jmp	.L113
.L134:
	xorl	%edx, %edx
	jmp	.L118
.L115:
	movl	%eax, %edx
	testl	%eax, %eax
	jg	.L117
	jmp	.L118
.L133:
	movb	$0, (%edx)
	jmp	.L117
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
