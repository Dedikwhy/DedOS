	.file	"app_files.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.type	on_close, @function
on_close:
.LFB23:
	.cfi_startproc
	movl	4(%esp), %eax
	movl	72(%eax), %eax
	movl	$0, (%eax)
	ret
	.cfi_endproc
.LFE23:
	.size	on_close, .-on_close
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC9:
	.string	"/"
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.type	refresh, @function
refresh:
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
	subl	$16, %esp
	.cfi_def_cfa_offset 36
	movl	%eax, %esi
	leal	588(%eax), %ebp
	leal	8(%eax), %ebx
	pushl	$64
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	fs_readdir
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	js	.L15
	movl	%eax, %edi
.L3:
	movl	%edi, 844(%esi)
	movl	$-1, 848(%esi)
	testl	%edi, %edi
	jle	.L8
	leal	852(%esi), %ebp
	xorl	%ebx, %ebx
	.align 4
.L7:
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	588(%esi,%ebx,4)
	.cfi_def_cfa_offset 48
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L6
	movl	%ebx, 848(%esi)
.L6:
	incl	%ebx
	cmpl	%ebx, %edi
	jne	.L7
	movl	848(%esi), %eax
	testl	%eax, %eax
	js	.L8
.L5:
	movl	884(%esi), %ebx
	movl	4(%esi), %eax
	movl	24(%eax), %ecx
	subl	$68, %ecx
	movl	$954437177, %eax
	imull	%ecx
	movl	%edx, %eax
	sarl	$2, %eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	subl	%eax, %edi
	cmpl	%edi, %ebx
	jle	.L9
	movl	%edi, 884(%esi)
	movl	%edi, %ebx
.L9:
	testl	%ebx, %ebx
	jns	.L10
	movl	$0, 884(%esi)
.L10:
	movl	$-1, 888(%esi)
	call	fs_generation
	movl	%eax, 940(%esi)
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
.L8:
	.cfi_restore_state
	movb	$0, 852(%esi)
	jmp	.L5
.L15:
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	$64
	.cfi_def_cfa_offset 40
	pushl	$.LC9
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	strlcpy
	addl	$12, %esp
	.cfi_def_cfa_offset 36
	pushl	$64
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	%ebx
	.cfi_def_cfa_offset 48
	call	fs_readdir
	movl	%eax, %edi
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	jmp	.L3
	.cfi_endproc
.LFE7:
	.size	refresh, .-refresh
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.type	tick, @function
tick:
.LFB20:
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
	movl	16(%esp), %ebx
	movl	72(%ebx), %esi
	movl	940(%esi), %edi
	call	fs_generation
	cmpl	%eax, %edi
	je	.L16
	movl	%esi, %eax
	call	refresh
	movl	%ebx, 16(%esp)
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
	jmp	gui_invalidate_window
	.align 4
.L16:
	.cfi_restore_state
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
.LFE20:
	.size	tick, .-tick
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.str1.1
.LC12:
	.string	"Files - %s"
	.section	.text.unlikely
.LCOLDB13:
	.text
.LHOTB13:
	.align 4
	.type	set_title, @function
set_title:
.LFB8:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$52, %esp
	.cfi_def_cfa_offset 64
	movl	%eax, %ebx
	leal	8(%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 68
	pushl	$.LC12
	.cfi_def_cfa_offset 72
	pushl	$40
	.cfi_def_cfa_offset 76
	leal	20(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 80
	call	ksnprintf
	popl	%eax
	.cfi_def_cfa_offset 76
	popl	%edx
	.cfi_def_cfa_offset 72
	pushl	%esi
	.cfi_def_cfa_offset 76
	pushl	4(%ebx)
	.cfi_def_cfa_offset 80
	call	gui_set_title
	addl	$68, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE8:
	.size	set_title, .-set_title
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.rodata.str1.1
.LC14:
	.string	""
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.align 4
	.type	select_row.part.3, @function
select_row.part.3:
.LFB28:
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
	movl	%eax, %esi
	movb	$0, 900(%eax)
	movl	%edx, 848(%eax)
	testl	%edx, %edx
	js	.L22
	movl	%edx, %ebx
	pushl	%edx
	.cfi_def_cfa_offset 20
	pushl	$32
	.cfi_def_cfa_offset 24
	pushl	588(%eax,%ebx,4)
	.cfi_def_cfa_offset 28
	leal	852(%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strlcpy
	movl	4(%esi), %ecx
	movl	24(%ecx), %eax
	leal	-68(%eax), %edi
	movl	$954437177, %eax
	imull	%edi
	sarl	$2, %edx
	sarl	$31, %edi
	subl	%edi, %edx
	movl	884(%esi), %eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	%eax, %ebx
	jge	.L23
	movl	%ebx, 884(%esi)
	movl	%ebx, %eax
.L23:
	addl	%edx, %eax
	cmpl	%eax, %ebx
	jl	.L24
	subl	%edx, %ebx
	incl	%ebx
	movl	%ebx, 884(%esi)
.L24:
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%ecx
	.cfi_def_cfa_offset 32
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 16
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
.L22:
	.cfi_restore_state
	pushl	%eax
	.cfi_def_cfa_offset 20
	pushl	$32
	.cfi_def_cfa_offset 24
	pushl	$.LC14
	.cfi_def_cfa_offset 28
	leal	852(%esi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strlcpy
	movl	4(%esi), %ecx
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%ecx
	.cfi_def_cfa_offset 32
	call	gui_invalidate_window
	addl	$16, %esp
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
.LFE28:
	.size	select_row.part.3, .-select_row.part.3
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.rodata.str1.1
.LC16:
	.string	"/%s"
.LC17:
	.string	"%s/%s"
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.align 4
	.type	join, @function
join:
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
	movl	%eax, %ebx
	movl	%edx, %edi
	movl	%ecx, %esi
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	$.LC9
	.cfi_def_cfa_offset 28
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L31
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%edi
	.cfi_def_cfa_offset 32
	pushl	%ebx
	.cfi_def_cfa_offset 36
	pushl	$.LC17
	.cfi_def_cfa_offset 40
	pushl	$64
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	ksnprintf
	addl	$32, %esp
	.cfi_def_cfa_offset 16
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
.L31:
	.cfi_restore_state
	pushl	%edi
	.cfi_def_cfa_offset 20
	pushl	$.LC16
	.cfi_def_cfa_offset 24
	pushl	$64
	.cfi_def_cfa_offset 28
	pushl	%esi
	.cfi_def_cfa_offset 32
	call	ksnprintf
	addl	$16, %esp
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
.LFE6:
	.size	join, .-join
	.section	.text.unlikely
.LCOLDE18:
	.text
.LHOTE18:
	.section	.rodata.str1.1
.LC19:
	.string	"folder%d"
.LC20:
	.string	"untitled%d.txt"
.LC21:
	.string	"folder"
.LC22:
	.string	"untitled.txt"
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC23:
	.string	"Cannot create (filesystem full?)"
	.section	.text.unlikely
.LCOLDB24:
	.text
.LHOTB24:
	.align 4
	.type	make_new, @function
make_new:
.LFB16:
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
	subl	$124, %esp
	.cfi_def_cfa_offset 144
	movl	%eax, 4(%esp)
	movl	%edx, 8(%esp)
	addl	$8, %eax
	movl	%eax, (%esp)
	testl	%edx, %edx
	je	.L33
	movl	$.LC19, %ebp
	movl	$.LC21, 12(%esp)
.L36:
	movl	$2, %ebx
	leal	16(%esp), %edi
	leal	48(%esp), %esi
	.align 4
.L37:
	leal	-1(%ebx), %eax
	cmpl	$1, %eax
	je	.L54
	pushl	%eax
	.cfi_def_cfa_offset 148
	pushl	%ebp
	.cfi_def_cfa_offset 152
	pushl	$32
	.cfi_def_cfa_offset 156
	pushl	%edi
	.cfi_def_cfa_offset 160
	call	ksnprintf
	movl	%esi, %ecx
	movl	%edi, %edx
	movl	16(%esp), %eax
	call	join
	movl	%esi, (%esp)
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	je	.L42
	cmpl	$100, %ebx
	je	.L42
.L39:
	incl	%ebx
	jmp	.L37
.L54:
	pushl	%eax
	.cfi_def_cfa_offset 148
	pushl	$32
	.cfi_def_cfa_offset 152
	pushl	20(%esp)
	.cfi_def_cfa_offset 156
	pushl	%edi
	.cfi_def_cfa_offset 160
	call	strlcpy
	movl	%esi, %ecx
	movl	%edi, %edx
	movl	16(%esp), %eax
	call	join
	movl	%esi, (%esp)
	call	fs_stat
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	jne	.L39
	.align 4
.L42:
	movl	8(%esp), %ebx
	testl	%ebx, %ebx
	je	.L55
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	%esi
	.cfi_def_cfa_offset 160
	call	fs_mkdir
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	jne	.L56
.L44:
	pushl	%eax
	.cfi_def_cfa_offset 148
	pushl	$32
	.cfi_def_cfa_offset 152
	pushl	%edi
	.cfi_def_cfa_offset 156
	movl	16(%esp), %edi
	movl	%edi, %eax
	addl	$852, %eax
	pushl	%eax
	.cfi_def_cfa_offset 160
	call	strlcpy
	movl	%edi, %eax
	call	refresh
	movl	848(%edi), %edx
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	cmpl	$-1, %edx
	jl	.L32
	cmpl	844(%edi), %edx
	jl	.L57
.L32:
	addl	$124, %esp
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
.L55:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	%esi
	.cfi_def_cfa_offset 160
	call	fs_create
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L44
.L56:
	pushl	%edx
	.cfi_def_cfa_offset 148
	pushl	$40
	.cfi_def_cfa_offset 152
	pushl	$.LC23
	.cfi_def_cfa_offset 156
	movl	16(%esp), %esi
	movl	%esi, %eax
	addl	$900, %eax
	pushl	%eax
	.cfi_def_cfa_offset 160
	call	strlcpy
	popl	%ecx
	.cfi_def_cfa_offset 156
	pushl	4(%esi)
	.cfi_def_cfa_offset 160
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	addl	$124, %esp
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
.L33:
	.cfi_restore_state
	movl	$.LC20, %ebp
	movl	$.LC22, 12(%esp)
	jmp	.L36
.L57:
	movl	4(%esp), %eax
	call	select_row.part.3
	addl	$124, %esp
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
.LFE16:
	.size	make_new, .-make_new
	.section	.text.unlikely
.LCOLDE24:
	.text
.LHOTE24:
	.section	.text.unlikely
.LCOLDB25:
	.text
.LHOTB25:
	.align 4
	.type	navigate, @function
navigate:
.LFB9:
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
	movl	%eax, %ebx
	movl	%edx, %esi
	movl	%ecx, %edi
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%edx
	.cfi_def_cfa_offset 32
	call	fs_is_dir
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L58
	testl	%edi, %edi
	leal	8(%ebx), %edi
	jne	.L71
.L61:
	pushl	%eax
	.cfi_def_cfa_offset 20
	pushl	$64
	.cfi_def_cfa_offset 24
	pushl	%esi
	.cfi_def_cfa_offset 28
	pushl	%edi
	.cfi_def_cfa_offset 32
	call	strlcpy
	movb	$0, 852(%ebx)
	movb	$0, 900(%ebx)
	movl	$0, 884(%ebx)
	movl	%ebx, %eax
	call	refresh
	movl	%ebx, %eax
	call	set_title
	popl	%edx
	.cfi_def_cfa_offset 28
	pushl	4(%ebx)
	.cfi_def_cfa_offset 32
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L58:
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
	subl	$8, %esp
	.cfi_def_cfa_offset 24
	pushl	%edi
	.cfi_def_cfa_offset 28
	pushl	%esi
	.cfi_def_cfa_offset 32
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	testl	%eax, %eax
	je	.L61
	movl	584(%ebx), %eax
	cmpl	$8, %eax
	je	.L72
.L63:
	incl	%eax
	movl	%eax, 584(%ebx)
	pushl	%ecx
	.cfi_def_cfa_offset 20
	pushl	$64
	.cfi_def_cfa_offset 24
	pushl	%edi
	.cfi_def_cfa_offset 28
	sall	$6, %eax
	leal	8(%ebx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	jmp	.L61
	.align 4
.L72:
	pushl	%eax
	.cfi_def_cfa_offset 20
	pushl	$448
	.cfi_def_cfa_offset 24
	leal	136(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 28
	leal	72(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	memmove
	movl	584(%ebx), %eax
	decl	%eax
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	jmp	.L63
	.cfi_endproc
.LFE9:
	.size	navigate, .-navigate
	.section	.text.unlikely
.LCOLDE25:
	.text
.LHOTE25:
	.section	.text.unlikely
.LCOLDB26:
	.text
.LHOTB26:
	.align 4
	.type	go_back, @function
go_back:
.LFB11:
	.cfi_startproc
	movl	584(%eax), %edx
	testl	%edx, %edx
	jne	.L82
	ret
	.align 4
.L82:
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$72, %esp
	.cfi_def_cfa_offset 84
	movl	%eax, %ebx
	leal	-1(%edx), %eax
	movl	%eax, 584(%ebx)
	pushl	$64
	.cfi_def_cfa_offset 88
	sall	$6, %edx
	leal	8(%ebx,%edx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 92
	leal	12(%esp), %esi
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	strlcpy
	xorl	%ecx, %ecx
	movl	%esi, %edx
	movl	%ebx, %eax
	call	navigate
	addl	$84, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE11:
	.size	go_back, .-go_back
	.section	.text.unlikely
.LCOLDE26:
	.text
.LHOTE26:
	.section	.rodata.str1.1
.LC27:
	.string	".."
	.section	.text.unlikely
.LCOLDB28:
	.text
.LHOTB28:
	.align 4
	.type	go_up, @function
go_up:
.LFB10:
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
	subl	$72, %esp
	.cfi_def_cfa_offset 88
	movl	%eax, %ebx
	leal	8(%eax), %esi
	pushl	$.LC9
	.cfi_def_cfa_offset 92
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	testl	%eax, %eax
	jne	.L90
	addl	$64, %esp
	.cfi_remember_state
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
	.align 4
.L90:
	.cfi_restore_state
	pushl	%eax
	.cfi_def_cfa_offset 84
	leal	4(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 88
	pushl	$.LC27
	.cfi_def_cfa_offset 92
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	fs_resolve
	movl	$1, %ecx
	movl	%edi, %edx
	movl	%ebx, %eax
	call	navigate
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$64, %esp
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
.LFE10:
	.size	go_up, .-go_up
	.section	.text.unlikely
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely
.LCOLDB29:
	.text
.LHOTB29:
	.align 4
	.type	open_entry.part.7, @function
open_entry.part.7:
.LFB32:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	%eax, %ebx
	leal	(%eax,%edx,4), %esi
	movl	588(%esi), %edx
	addl	$8, %eax
	movl	%esp, %ecx
	call	join
	movl	588(%esi), %eax
	cmpb	$0, 2088(%eax)
	je	.L92
	movl	$1, %ecx
	movl	%esp, %edx
	movl	%ebx, %eax
	call	navigate
	addl	$68, %esp
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
.L92:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	leal	12(%esp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	app_open_path
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
	.cfi_def_cfa_offset 12
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE32:
	.size	open_entry.part.7, .-open_entry.part.7
	.section	.text.unlikely
.LCOLDE29:
	.text
.LHOTE29:
	.section	.rodata.str1.1
.LC34:
	.string	"/home"
.LC0:
	.string	"Open"
	.section	.rodata
	.align 4
.LC30:
	.long	.LC0
	.long	-1
	.long	1
	.section	.rodata.str1.1
.LC2:
	.string	"Delete"
	.section	.rodata
	.align 4
.LC31:
	.long	.LC2
	.long	-1
	.long	2
	.section	.rodata.str1.1
.LC4:
	.string	"New Folder"
	.section	.rodata
	.align 4
.LC32:
	.long	.LC4
	.long	4
	.long	3
	.section	.rodata.str1.1
.LC6:
	.string	"New File"
	.section	.rodata
	.align 4
.LC33:
	.long	.LC6
	.long	5
	.long	4
	.section	.text.unlikely
.LCOLDB35:
	.text
.LHOTB35:
	.align 4
	.type	on_mouse, @function
on_mouse:
.LFB19:
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
	movl	116(%esp), %edi
	movl	112(%esp), %eax
	movl	72(%eax), %ebp
	movl	24(%eax), %eax
	leal	-68(%eax), %ecx
	movl	$954437177, %eax
	imull	%ecx
	movl	%edx, %eax
	sarl	$2, %eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, 20(%esp)
	movl	8(%edi), %eax
	movl	%eax, 8(%esp)
	cmpl	$47, %eax
	jg	.L96
	movl	4(%edi), %ebx
	movl	844(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$0, 28(%esp)
	movl	$-1, %esi
.L97:
	cmpl	16(%esp), %esi
	jl	.L101
	movl	$-1, %esi
.L101:
	movl	$6, %ecx
	movl	$56, %edx
	movl	$-1, 12(%esp)
	movl	8(%esp), %eax
	subl	$5, %eax
	movl	%eax, 24(%esp)
	xorl	%eax, %eax
.L104:
	cmpl	%ebx, %ecx
	jg	.L102
	addl	%edx, %ecx
	cmpl	%ebx, %ecx
	jle	.L102
	cmpl	$19, 24(%esp)
	jbe	.L147
	.align 4
.L102:
	incl	%eax
	cmpl	$3, %eax
	je	.L103
	movl	bw.1420(,%eax,4), %edx
	movl	bx.1419(,%eax,4), %ecx
	jmp	.L104
	.align 4
.L103:
	cmpl	$5, (%edi)
	ja	.L110
	movl	(%edi), %eax
	jmp	*.L107(,%eax,4)
	.section	.rodata
	.align 4
	.align 4
.L107:
	.long	.L110
	.long	.L106
	.long	.L108
	.long	.L109
	.long	.L139
	.long	.L111
	.text
	.align 4
.L109:
	movl	16(%edi), %eax
	leal	(%eax,%eax), %edx
	addl	%edx, %eax
	movl	884(%ebp), %edi
	subl	%eax, %edi
	movl	%edi, %eax
	movl	16(%esp), %edx
	subl	20(%esp), %edx
	cmpl	%edx, %edi
	jg	.L118
	movl	%edi, 884(%ebp)
.L119:
	testl	%eax, %eax
	js	.L148
.L120:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 112
.L110:
	cmpl	888(%ebp), %esi
	je	.L149
.L136:
	movl	%esi, 888(%ebp)
	movl	12(%esp), %eax
	movl	%eax, 892(%ebp)
.L146:
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 112
.L95:
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
.L96:
	.cfi_restore_state
	movl	20(%esp), %eax
	leal	(%eax,%eax,8), %eax
	leal	48(%eax,%eax), %eax
	movl	4(%edi), %ebx
	cmpl	%eax, 8(%esp)
	jge	.L150
	movl	112(%esp), %eax
	movl	20(%eax), %eax
	movl	844(%ebp), %edx
	movl	%edx, 16(%esp)
	cmpl	20(%esp), %edx
	jg	.L151
	xorl	%edx, %edx
	subl	%edx, %eax
	cmpl	%eax, %ebx
	jl	.L100
.L156:
	movl	$0, 28(%esp)
	movl	$-1, %esi
	jmp	.L97
	.align 4
.L147:
	movl	%eax, 12(%esp)
	jmp	.L102
	.align 4
.L150:
	movl	844(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$0, 28(%esp)
	movl	$-1, %esi
	jmp	.L97
	.align 4
.L149:
	movl	12(%esp), %eax
	cmpl	892(%ebp), %eax
	jne	.L136
	jmp	.L95
	.align 4
.L139:
	movl	$-1, 12(%esp)
	movl	$-1, %esi
	cmpl	888(%ebp), %esi
	jne	.L136
	jmp	.L149
	.align 4
.L106:
	movl	12(%esp), %eax
	cmpl	$-1, %eax
	je	.L121
	testl	%eax, %eax
	jne	.L122
	xorl	%eax, %eax
	movl	584(%ebp), %ebx
	testl	%ebx, %ebx
	setg	%al
.L123:
	testl	%eax, %eax
	jne	.L125
.L121:
	movl	28(%esp), %ecx
	testl	%ecx, %ecx
	je	.L126
	cmpl	$-1, %esi
	jl	.L127
	cmpl	844(%ebp), %esi
	jl	.L152
.L127:
	movl	20(%edi), %edx
	testl	%edx, %edx
	je	.L95
	testl	%esi, %esi
	js	.L95
	cmpl	844(%ebp), %esi
	jge	.L95
	movl	%esi, %edx
	movl	%ebp, %eax
	call	open_entry.part.7
	jmp	.L95
	.align 4
.L108:
	movl	896(%ebp), %ebx
	testl	%ebx, %ebx
	js	.L95
	movl	$-1, 896(%ebp)
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	cmpl	%ebx, 12(%esp)
	jne	.L95
	movl	12(%esp), %eax
	testl	%eax, %eax
	je	.L153
	cmpl	$1, 12(%esp)
	je	.L154
	movl	$1, %ecx
	movl	$.LC34, %edx
	movl	%ebp, %eax
	call	navigate
	jmp	.L95
	.align 4
.L111:
	testl	%esi, %esi
	js	.L112
	cmpl	16(%esp), %esi
	jl	.L155
	movl	8(%esp), %edx
.L113:
	leal	32(%esp), %eax
	movl	$.LC30, %esi
	movl	$3, %ecx
	movl	%eax, %edi
	rep movsl
	leal	44(%esp), %edi
	movl	$.LC31, %esi
	movl	$3, %ecx
	rep movsl
.L114:
	subl	$8, %esp
	.cfi_def_cfa_offset 120
	pushl	%ebp
	.cfi_def_cfa_offset 124
	pushl	$ctx_cb
	.cfi_def_cfa_offset 128
	pushl	$2
	.cfi_def_cfa_offset 132
	pushl	%eax
	.cfi_def_cfa_offset 136
	movl	136(%esp), %eax
	movl	8(%eax), %eax
	leal	21(%edx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 140
	movl	140(%esp), %eax
	movl	4(%eax), %eax
	leal	1(%ebx,%eax), %eax
	pushl	%eax
	.cfi_def_cfa_offset 144
	call	gui_popup
	addl	$32, %esp
	.cfi_def_cfa_offset 112
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
.L151:
	.cfi_restore_state
	movl	$14, %edx
	subl	%edx, %eax
	cmpl	%eax, %ebx
	jge	.L156
.L100:
	movl	8(%esp), %eax
	leal	-48(%eax), %ecx
	movl	$954437177, %eax
	imull	%ecx
	movl	%edx, %esi
	sarl	$2, %esi
	sarl	$31, %ecx
	subl	%ecx, %esi
	addl	884(%ebp), %esi
	movl	$1, 28(%esp)
	jmp	.L97
	.align 4
.L118:
	movl	%edx, 884(%ebp)
	movl	%edx, %eax
	jmp	.L119
	.align 4
.L126:
	movl	844(%ebp), %eax
	movl	20(%esp), %ebx
	cmpl	%ebx, %eax
	jle	.L95
	movl	112(%esp), %edx
	movl	20(%edx), %esi
	movl	%esi, 8(%esp)
	movl	%esi, %edx
	subl	$14, %edx
	cmpl	%edx, 4(%edi)
	jl	.L95
	movl	8(%edi), %ecx
	cmpl	$47, %ecx
	jle	.L95
	movl	%ebx, %edi
	leal	(%ebx,%ebx,8), %edx
	leal	48(%edx,%edx), %ebx
	cmpl	%ebx, %ecx
	jge	.L95
	movl	884(%ebp), %ebx
	addl	$48, %edx
	cmpl	%edx, %ecx
	jge	.L141
	movl	%edi, %edx
	negl	%edx
.L130:
	addl	%edx, %ebx
	subl	20(%esp), %eax
	cmpl	%eax, %ebx
	jg	.L131
	movl	%ebx, 884(%ebp)
.L132:
	testl	%ebx, %ebx
	jns	.L146
	movl	$0, 884(%ebp)
	jmp	.L146
	.align 4
.L122:
	cmpl	$1, 12(%esp)
	je	.L124
.L125:
	movl	12(%esp), %eax
	movl	%eax, 896(%ebp)
	subl	$12, %esp
	.cfi_def_cfa_offset 124
	pushl	124(%esp)
	.cfi_def_cfa_offset 128
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	jmp	.L95
.L152:
	movl	%esi, %edx
	movl	%ebp, %eax
	call	select_row.part.3
	jmp	.L127
	.align 4
.L148:
	movl	$0, 884(%ebp)
	jmp	.L120
	.align 4
.L112:
	movl	28(%esp), %esi
	testl	%esi, %esi
	jne	.L115
	cmpl	$47, 8(%esp)
	jle	.L95
.L115:
	leal	32(%esp), %eax
	movl	$.LC32, %esi
	movl	$3, %ecx
	movl	%eax, %edi
	rep movsl
	leal	44(%esp), %edi
	movl	$.LC33, %esi
	movl	$3, %ecx
	rep movsl
	movl	8(%esp), %edx
	jmp	.L114
.L155:
	movl	%esi, %edx
	movl	%ebp, %eax
	call	select_row.part.3
	movl	8(%edi), %edx
	movl	4(%edi), %ebx
	jmp	.L113
.L124:
	subl	$8, %esp
	.cfi_def_cfa_offset 120
	pushl	$.LC9
	.cfi_def_cfa_offset 124
	leal	8(%ebp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 128
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 112
	testl	%eax, %eax
	setne	%al
	movzbl	%al, %eax
	jmp	.L123
.L131:
	movl	%eax, 884(%ebp)
	movl	%eax, %ebx
	jmp	.L132
.L141:
	movl	20(%esp), %edx
	jmp	.L130
.L153:
	movl	%ebp, %eax
	call	go_back
	jmp	.L95
.L154:
	movl	%ebp, %eax
	call	go_up
	jmp	.L95
	.cfi_endproc
.LFE19:
	.size	on_mouse, .-on_mouse
	.section	.text.unlikely
.LCOLDE35:
	.text
.LHOTE35:
	.section	.text.unlikely
.LCOLDB36:
	.text
.LHOTB36:
	.align 4
	.type	on_key, @function
on_key:
.LFB18:
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
	movl	16(%esp), %eax
	movl	20(%esp), %esi
	movl	72(%eax), %edi
	movb	2(%esi), %bl
	andl	$4, %ebx
	movl	24(%eax), %ecx
	subl	$68, %ecx
	movl	$954437177, %eax
	imull	%ecx
	sarl	$2, %edx
	sarl	$31, %ecx
	subl	%ecx, %edx
	movw	(%esi), %ax
	cmpw	$258, %ax
	je	.L159
	jbe	.L191
	cmpw	$261, %ax
	je	.L166
	jbe	.L192
	cmpw	$262, %ax
	je	.L169
	cmpw	$263, %ax
	jne	.L157
	addl	848(%edi), %edx
	movl	844(%edi), %eax
	cmpl	%eax, %edx
	jl	.L179
	leal	-1(%eax), %edx
	cmpl	$-1, %edx
	jl	.L157
.L180:
	movl	%edi, %eax
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
	jmp	select_row.part.3
	.align 4
.L191:
	.cfi_restore_state
	cmpw	$10, %ax
	je	.L161
	jbe	.L193
	cmpw	$256, %ax
	je	.L164
	cmpw	$257, %ax
	jne	.L157
	movl	848(%edi), %edx
	testl	%edx, %edx
	js	.L194
	incl	%edx
	movl	844(%edi), %eax
	cmpl	%eax, %edx
	jl	.L180
	leal	-1(%eax), %edx
	cmpl	$-1, %edx
	jl	.L157
.L176:
	cmpl	%edx, %eax
	jle	.L157
	jmp	.L180
	.align 4
.L164:
	testb	%bl, %bl
	jne	.L163
	movl	848(%edi), %edx
	testl	%edx, %edx
	js	.L195
	cmpl	$1, %edx
	adcl	$-1, %edx
	movl	844(%edi), %eax
.L190:
	cmpl	%eax, %edx
	jl	.L180
.L157:
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
.L169:
	.cfi_restore_state
	movl	848(%edi), %eax
	subl	%edx, %eax
	movl	%eax, %edx
	js	.L196
.L178:
	cmpl	%edx, 844(%edi)
	jle	.L157
	jmp	.L180
	.align 4
.L192:
	cmpw	$260, %ax
	jne	.L157
	movl	844(%edi), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	sete	%dl
	negl	%edx
	jmp	.L190
	.align 4
.L193:
	cmpw	$8, %ax
	jne	.L157
.L163:
	movl	%edi, %eax
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
	jmp	go_up
	.align 4
.L166:
	.cfi_restore_state
	movl	844(%edi), %eax
	leal	-1(%eax), %edx
	cmpl	$-1, %edx
	jge	.L180
	jmp	.L157
	.align 4
.L161:
	movl	848(%edi), %edx
	testl	%edx, %edx
	js	.L157
	cmpl	%edx, 844(%edi)
	jle	.L157
	movl	%edi, %eax
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
	jmp	open_entry.part.7
	.align 4
.L159:
	.cfi_restore_state
	testb	%bl, %bl
	je	.L157
	movl	%edi, %eax
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
	jmp	go_back
	.align 4
.L179:
	.cfi_restore_state
	cmpl	$-1, %edx
	jl	.L157
	jmp	.L180
	.align 4
.L194:
	movl	844(%edi), %eax
	xorl	%edx, %edx
	jmp	.L176
	.align 4
.L195:
	movl	844(%edi), %eax
	leal	-1(%eax), %edx
	cmpl	$-1, %edx
	jl	.L157
	jmp	.L190
	.align 4
.L196:
	xorl	%edx, %edx
	jmp	.L178
	.cfi_endproc
.LFE18:
	.size	on_key, .-on_key
	.section	.text.unlikely
.LCOLDE36:
	.text
.LHOTE36:
	.section	.rodata.str1.1
.LC37:
	.string	"Folder is not empty"
	.section	.text.unlikely
.LCOLDB38:
	.text
.LHOTB38:
	.align 4
	.type	ctx_cb, @function
ctx_cb:
.LFB17:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$68, %esp
	.cfi_def_cfa_offset 80
	movl	80(%esp), %ebx
	movl	84(%esp), %eax
	cmpl	$2, %eax
	je	.L199
	jle	.L208
	cmpl	$3, %eax
	je	.L202
	cmpl	$4, %eax
	jne	.L197
	xorl	%edx, %edx
	movl	%ebx, %eax
	call	make_new
.L197:
	addl	$68, %esp
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
.L202:
	.cfi_restore_state
	movl	$1, %edx
	movl	%ebx, %eax
	call	make_new
	addl	$68, %esp
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
.L208:
	.cfi_restore_state
	decl	%eax
	jne	.L197
	movl	848(%ebx), %edx
	testl	%edx, %edx
	js	.L197
	cmpl	844(%ebx), %edx
	jge	.L197
	movl	%ebx, %eax
	call	open_entry.part.7
	jmp	.L197
	.align 4
.L199:
	movl	848(%ebx), %eax
	testl	%eax, %eax
	js	.L197
	movl	%esp, %esi
	movl	588(%ebx,%eax,4), %edx
	leal	8(%ebx), %eax
	movl	%esp, %ecx
	call	join
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	%esi
	.cfi_def_cfa_offset 96
	call	fs_remove
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	cmpl	$-2, %eax
	je	.L209
	movb	$0, 900(%ebx)
.L206:
	movb	$0, 852(%ebx)
	movl	%ebx, %eax
	call	refresh
	subl	$12, %esp
	.cfi_def_cfa_offset 92
	pushl	4(%ebx)
	.cfi_def_cfa_offset 96
	call	gui_invalidate_window
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	addl	$68, %esp
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
.L209:
	.cfi_restore_state
	pushl	%eax
	.cfi_def_cfa_offset 84
	pushl	$40
	.cfi_def_cfa_offset 88
	pushl	$.LC37
	.cfi_def_cfa_offset 92
	leal	900(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 96
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 80
	jmp	.L206
	.cfi_endproc
.LFE17:
	.size	ctx_cb, .-ctx_cb
	.section	.text.unlikely
.LCOLDE38:
	.text
.LHOTE38:
	.section	.rodata.str1.1
.LC39:
	.string	"< Back"
.LC40:
	.string	"s"
.LC41:
	.string	"Name"
.LC42:
	.string	"Size"
.LC43:
	.string	".app"
.LC44:
	.string	"-"
.LC45:
	.string	"%u B"
.LC46:
	.string	"(empty)"
.LC47:
	.string	"%s  (folder)"
.LC48:
	.string	"%s  %u bytes"
.LC49:
	.string	"%d item%s"
	.section	.text.unlikely
.LCOLDB50:
	.text
.LHOTB50:
	.align 4
	.type	paint, @function
paint:
.LFB22:
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
	subl	$136, %esp
	.cfi_def_cfa_offset 156
	movl	156(%esp), %eax
	movl	72(%eax), %ebp
	movl	24(%eax), %ecx
	subl	$68, %ecx
	movl	$954437177, %eax
	imull	%ecx
	movl	%edx, %eax
	sarl	$2, %eax
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, 16(%esp)
	pushl	$858654
	.cfi_def_cfa_offset 160
	pushl	$30
	.cfi_def_cfa_offset 164
	pushl	176(%esp)
	.cfi_def_cfa_offset 168
	pushl	176(%esp)
	.cfi_def_cfa_offset 172
	pushl	176(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	pushl	$2968144
	.cfi_def_cfa_offset 148
	pushl	160(%esp)
	.cfi_def_cfa_offset 152
	movl	160(%esp), %eax
	addl	$29, %eax
	pushl	%eax
	.cfi_def_cfa_offset 156
	pushl	160(%esp)
	.cfi_def_cfa_offset 160
	call	gfx_hline
	movl	168(%esp), %eax
	addl	$5, %eax
	movl	%eax, 36(%esp)
	movl	168(%esp), %eax
	addl	$11, %eax
	movl	%eax, 40(%esp)
	leal	8(%ebp), %eax
	movl	%eax, 44(%esp)
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	movl	$56, %esi
	movl	$6, %ebx
	movl	$.LC39, (%esp)
	xorl	%edi, %edi
	movl	%ebp, 8(%esp)
	addl	148(%esp), %ebx
	testl	%edi, %edi
	jne	.L211
.L258:
	movl	8(%esp), %eax
	movl	584(%eax), %ebp
	xorl	%eax, %eax
	testl	%ebp, %ebp
	setg	%al
.L212:
	testl	%eax, %eax
	jne	.L213
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$990498
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	movl	44(%esp), %ebp
	pushl	%ebp
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$2968144
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	pushl	%ebp
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	xorl	%ebp, %ebp
	movl	$5996420, %edx
.L244:
	movl	%edx, 16(%esp)
	movl	24(%esp), %eax
	leal	(%eax,%ebp), %ecx
	movl	%ecx, 12(%esp)
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	12(%esp)
	.cfi_def_cfa_offset 160
	call	gfx_text_width
	movl	$1, (%esp)
	movl	32(%esp), %edx
	pushl	%edx
	.cfi_def_cfa_offset 164
	pushl	20(%esp)
	.cfi_def_cfa_offset 168
	movl	36(%esp), %ecx
	pushl	%ecx
	.cfi_def_cfa_offset 172
	subl	%eax, %esi
	movl	%esi, %eax
	shrl	$31, %eax
	addl	%eax, %esi
	sarl	%esi
	addl	%esi, %ebx
	addl	%ebx, %ebp
	pushl	%ebp
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	incl	%edi
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	cmpl	$3, %edi
	je	.L217
	movl	labels.1572(,%edi,4), %eax
	movl	%eax, (%esp)
	movl	bx.1419(,%edi,4), %ebx
	movl	bw.1420(,%edi,4), %esi
	addl	148(%esp), %ebx
	testl	%edi, %edi
	je	.L258
.L211:
	cmpl	$1, %edi
	je	.L259
.L213:
	movl	8(%esp), %eax
	cmpl	%edi, 892(%eax)
	je	.L260
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$990498
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	movl	44(%esp), %ebp
	pushl	%ebp
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$2968144
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	pushl	%ebp
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	xorl	%ebp, %ebp
	movl	$11194321, %edx
	jmp	.L244
	.align 4
.L260:
	movl	8(%esp), %eax
	cmpl	%edi, 896(%eax)
	je	.L252
	xorl	%ebp, %ebp
	movl	$1716792, %eax
.L243:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	%eax
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	pushl	44(%esp)
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$2968144
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	pushl	44(%esp)
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	movl	$11194321, %edx
	jmp	.L244
	.align 4
.L217:
	movl	8(%esp), %ebp
	movl	148(%esp), %eax
	leal	174(%eax), %ebx
	movl	156(%esp), %eax
	leal	-180(%eax), %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$528660
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	movl	44(%esp), %edi
	pushl	%edi
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$2968144
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	%esi
	.cfi_def_cfa_offset 168
	pushl	%edi
	.cfi_def_cfa_offset 172
	pushl	%ebx
	.cfi_def_cfa_offset 176
	call	gfx_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	movl	168(%esp), %eax
	subl	$192, %eax
	pushl	%eax
	.cfi_def_cfa_offset 160
	pushl	$11194321
	.cfi_def_cfa_offset 164
	pushl	48(%esp)
	.cfi_def_cfa_offset 168
	pushl	48(%esp)
	.cfi_def_cfa_offset 172
	movl	176(%esp), %eax
	addl	$180, %eax
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_text_fit
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$858654
	.cfi_def_cfa_offset 160
	pushl	$18
	.cfi_def_cfa_offset 164
	pushl	176(%esp)
	.cfi_def_cfa_offset 168
	movl	176(%esp), %eax
	addl	$30, %eax
	pushl	%eax
	.cfi_def_cfa_offset 172
	pushl	176(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	pushl	$5996420
	.cfi_def_cfa_offset 148
	pushl	160(%esp)
	.cfi_def_cfa_offset 152
	movl	160(%esp), %eax
	addl	$47, %eax
	pushl	%eax
	.cfi_def_cfa_offset 156
	pushl	160(%esp)
	.cfi_def_cfa_offset 160
	call	gfx_hline
	movl	168(%esp), %eax
	leal	35(%eax), %ebx
	movl	164(%esp), %eax
	addl	$28, %eax
	movl	%eax, 44(%esp)
	movl	$1, (%esp)
	pushl	$5996420
	.cfi_def_cfa_offset 164
	pushl	$.LC41
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	movl	180(%esp), %eax
	addl	188(%esp), %eax
	movl	%eax, 76(%esp)
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$1
	.cfi_def_cfa_offset 160
	pushl	$5996420
	.cfi_def_cfa_offset 164
	pushl	$.LC42
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	subl	$74, %eax
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	movl	184(%esp), %eax
	addl	$48, %eax
	movl	%eax, 72(%esp)
	movl	844(%ebp), %eax
	movl	%eax, 68(%esp)
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	cmpl	4(%esp), %eax
	jle	.L245
	movl	$14, %eax
.L219:
	movl	156(%esp), %edx
	subl	%eax, %edx
	movl	%edx, 24(%esp)
	movl	4(%esp), %ecx
	testl	%ecx, %ecx
	jle	.L246
	movl	884(%ebp), %esi
	cmpl	%esi, 36(%esp)
	jle	.L246
	movl	40(%esp), %edi
	movl	$0, (%esp)
	leal	48(%esp), %eax
	movl	%eax, 8(%esp)
	movl	24(%esp), %eax
	movl	148(%esp), %ecx
	leal	-60(%eax,%ecx), %eax
	movl	%eax, 32(%esp)
	movl	%edi, %eax
	movl	%esi, %edi
	movl	%eax, %esi
	jmp	.L223
	.align 4
.L265:
	pushl	%edx
	.cfi_def_cfa_offset 148
	pushl	$16
	.cfi_def_cfa_offset 152
	pushl	$.LC44
	.cfi_def_cfa_offset 156
	pushl	20(%esp)
	.cfi_def_cfa_offset 160
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	cmpl	%edi, 12(%esp)
	je	.L261
.L249:
	movl	$5996420, %eax
.L233:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$1
	.cfi_def_cfa_offset 160
	pushl	%eax
	.cfi_def_cfa_offset 164
	pushl	28(%esp)
	.cfi_def_cfa_offset 168
	pushl	40(%esp)
	.cfi_def_cfa_offset 172
	pushl	60(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	addl	$32, %esp
	.cfi_def_cfa_offset 144
.L225:
	incl	(%esp)
	movl	(%esp), %eax
	cmpl	4(%esp), %eax
	je	.L262
	movl	(%esp), %edi
	addl	884(%ebp), %edi
	movl	844(%ebp), %eax
	addl	$18, %esi
	cmpl	%eax, %edi
	jge	.L220
.L223:
	pushl	$18
	.cfi_def_cfa_offset 148
	pushl	160(%esp)
	.cfi_def_cfa_offset 152
	pushl	%esi
	.cfi_def_cfa_offset 156
	pushl	160(%esp)
	.cfi_def_cfa_offset 160
	call	gfx_visible
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	je	.L225
	movl	588(%ebp,%edi,4), %ebx
	movl	848(%ebp), %eax
	movl	%eax, 12(%esp)
	cmpl	%edi, %eax
	je	.L263
	cmpl	%edi, 888(%ebp)
	je	.L264
.L228:
	movl	$11194321, 20(%esp)
.L227:
	cmpb	$0, 2088(%ebx)
	je	.L229
	movl	$4, %eax
.L230:
	pushl	$16
	.cfi_def_cfa_offset 148
	leal	1(%esi), %edx
	pushl	%edx
	.cfi_def_cfa_offset 152
	movl	156(%esp), %ecx
	leal	6(%ecx), %edx
	pushl	%edx
	.cfi_def_cfa_offset 156
	pushl	%eax
	.cfi_def_cfa_offset 160
	call	icon_draw
	leal	5(%esi), %eax
	movl	%eax, %edx
	movl	%eax, 32(%esp)
	movl	40(%esp), %eax
	subl	$98, %eax
	movl	%eax, (%esp)
	pushl	36(%esp)
	.cfi_def_cfa_offset 164
	pushl	%ebx
	.cfi_def_cfa_offset 168
	pushl	%edx
	.cfi_def_cfa_offset 172
	pushl	56(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_text_fit
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	cmpb	$0, 2088(%ebx)
	jne	.L265
	pushl	2080(%ebx)
	.cfi_def_cfa_offset 148
	pushl	$.LC45
	.cfi_def_cfa_offset 152
	pushl	$16
	.cfi_def_cfa_offset 156
	pushl	20(%esp)
	.cfi_def_cfa_offset 160
	call	ksnprintf
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	cmpl	%edi, 12(%esp)
	jne	.L249
.L261:
	movl	$397332, %eax
	jmp	.L233
	.align 4
.L229:
	subl	$8, %esp
	.cfi_def_cfa_offset 152
	pushl	$.LC43
	.cfi_def_cfa_offset 156
	pushl	%ebx
	.cfi_def_cfa_offset 160
	call	str_ends_with
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	cmpl	$1, %eax
	sbbl	%eax, %eax
	addl	$6, %eax
	jmp	.L230
.L246:
	movl	36(%esp), %eax
	leal	48(%esp), %ecx
	movl	%ecx, 8(%esp)
	.align 4
.L220:
	testl	%eax, %eax
	je	.L266
.L235:
	movl	4(%esp), %edx
	cmpl	%edx, 36(%esp)
	jg	.L267
.L236:
	movl	152(%esp), %ebx
	addl	160(%esp), %ebx
	leal	-20(%ebx), %esi
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$858654
	.cfi_def_cfa_offset 160
	pushl	$20
	.cfi_def_cfa_offset 164
	pushl	176(%esp)
	.cfi_def_cfa_offset 168
	pushl	%esi
	.cfi_def_cfa_offset 172
	pushl	176(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	pushl	$5996420
	.cfi_def_cfa_offset 148
	pushl	160(%esp)
	.cfi_def_cfa_offset 152
	pushl	%esi
	.cfi_def_cfa_offset 156
	pushl	160(%esp)
	.cfi_def_cfa_offset 160
	call	gfx_hline
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	cmpb	$0, 900(%ebp)
	jne	.L268
	movl	848(%ebp), %eax
	testl	%eax, %eax
	js	.L240
	movl	588(%ebp,%eax,4), %eax
	cmpb	$0, 2088(%eax)
	jne	.L269
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	2080(%eax)
	.cfi_def_cfa_offset 160
	pushl	%eax
	.cfi_def_cfa_offset 164
	pushl	$.LC48
	.cfi_def_cfa_offset 168
	pushl	$64
	.cfi_def_cfa_offset 172
	pushl	36(%esp)
	.cfi_def_cfa_offset 176
	call	ksnprintf
	addl	$32, %esp
	.cfi_def_cfa_offset 144
.L239:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	movl	168(%esp), %eax
	subl	$16, %eax
	pushl	%eax
	.cfi_def_cfa_offset 160
	pushl	$11194321
	.cfi_def_cfa_offset 164
	pushl	28(%esp)
	.cfi_def_cfa_offset 168
	subl	$14, %ebx
	pushl	%ebx
	.cfi_def_cfa_offset 172
	movl	176(%esp), %eax
	addl	$8, %eax
	pushl	%eax
	.cfi_def_cfa_offset 176
	call	gfx_text_fit
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	addl	$124, %esp
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
.L263:
	.cfi_restore_state
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$11194321
	.cfi_def_cfa_offset 160
	pushl	$18
	.cfi_def_cfa_offset 164
	pushl	44(%esp)
	.cfi_def_cfa_offset 168
	pushl	%esi
	.cfi_def_cfa_offset 172
	pushl	176(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	movl	$397332, 20(%esp)
	jmp	.L227
	.align 4
.L264:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$1254955
	.cfi_def_cfa_offset 160
	pushl	$18
	.cfi_def_cfa_offset 164
	pushl	44(%esp)
	.cfi_def_cfa_offset 168
	pushl	%esi
	.cfi_def_cfa_offset 172
	pushl	176(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	jmp	.L228
	.align 4
.L245:
	xorl	%eax, %eax
	jmp	.L219
	.align 4
.L269:
	pushl	%eax
	.cfi_def_cfa_offset 148
	pushl	$.LC47
	.cfi_def_cfa_offset 152
	pushl	$64
	.cfi_def_cfa_offset 156
	pushl	20(%esp)
	.cfi_def_cfa_offset 160
	call	ksnprintf
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	jmp	.L239
	.align 4
.L262:
	movl	844(%ebp), %eax
	testl	%eax, %eax
	jne	.L235
.L266:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$1
	.cfi_def_cfa_offset 160
	pushl	$5996420
	.cfi_def_cfa_offset 164
	pushl	$.LC46
	.cfi_def_cfa_offset 168
	movl	176(%esp), %eax
	addl	$54, %eax
	pushl	%eax
	.cfi_def_cfa_offset 172
	pushl	56(%esp)
	.cfi_def_cfa_offset 176
	call	gfx_text_scaled
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	movl	4(%esp), %edx
	cmpl	%edx, 36(%esp)
	jle	.L236
.L267:
	movl	44(%esp), %eax
	leal	-14(%eax), %esi
	movl	%edx, %edi
	leal	(%edx,%edx,8), %ebx
	addl	%ebx, %ebx
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$858654
	.cfi_def_cfa_offset 160
	pushl	%ebx
	.cfi_def_cfa_offset 164
	pushl	$14
	.cfi_def_cfa_offset 168
	pushl	64(%esp)
	.cfi_def_cfa_offset 172
	pushl	%esi
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	pushl	$5996420
	.cfi_def_cfa_offset 148
	pushl	%ebx
	.cfi_def_cfa_offset 152
	pushl	48(%esp)
	.cfi_def_cfa_offset 156
	pushl	%esi
	.cfi_def_cfa_offset 160
	call	gfx_vline
	movl	844(%ebp), %ecx
	movl	%edi, %eax
	imull	%ebx, %eax
	cltd
	idivl	%ecx
	movl	%eax, %esi
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	cmpl	$15, %eax
	jg	.L237
	movl	$16, %esi
.L237:
	movl	%ebx, %eax
	subl	%esi, %eax
	imull	884(%ebp), %eax
	subl	4(%esp), %ecx
	cltd
	idivl	%ecx
	movl	40(%esp), %ebx
	addl	%eax, %ebx
	movl	44(%esp), %edi
	subl	$12, %edi
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	$2773336
	.cfi_def_cfa_offset 160
	pushl	%esi
	.cfi_def_cfa_offset 164
	pushl	$10
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	pushl	%edi
	.cfi_def_cfa_offset 176
	call	gfx_fill_rect
	addl	$20, %esp
	.cfi_def_cfa_offset 156
	pushl	$2968144
	.cfi_def_cfa_offset 160
	pushl	%esi
	.cfi_def_cfa_offset 164
	pushl	$10
	.cfi_def_cfa_offset 168
	pushl	%ebx
	.cfi_def_cfa_offset 172
	pushl	%edi
	.cfi_def_cfa_offset 176
	call	gfx_rect
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	jmp	.L236
	.align 4
.L252:
	movl	$1, %ebp
	movl	$2773336, %eax
	jmp	.L243
	.align 4
.L240:
	movl	844(%ebp), %eax
	cmpl	$1, %eax
	je	.L270
	movl	$.LC40, %edx
.L242:
	subl	$12, %esp
	.cfi_def_cfa_offset 156
	pushl	%edx
	.cfi_def_cfa_offset 160
	pushl	%eax
	.cfi_def_cfa_offset 164
	pushl	$.LC49
	.cfi_def_cfa_offset 168
	pushl	$64
	.cfi_def_cfa_offset 172
	pushl	36(%esp)
	.cfi_def_cfa_offset 176
	call	ksnprintf
	addl	$32, %esp
	.cfi_def_cfa_offset 144
	jmp	.L239
	.align 4
.L268:
	pushl	%eax
	.cfi_def_cfa_offset 148
	pushl	$64
	.cfi_def_cfa_offset 152
	leal	900(%ebp), %eax
	pushl	%eax
	.cfi_def_cfa_offset 156
	pushl	20(%esp)
	.cfi_def_cfa_offset 160
	call	strlcpy
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	jmp	.L239
	.align 4
.L259:
	subl	$8, %esp
	.cfi_def_cfa_offset 152
	pushl	$.LC9
	.cfi_def_cfa_offset 156
	pushl	40(%esp)
	.cfi_def_cfa_offset 160
	call	strcmp
	addl	$16, %esp
	.cfi_def_cfa_offset 144
	testl	%eax, %eax
	setne	%al
	movzbl	%al, %eax
	jmp	.L212
.L270:
	movl	$.LC14, %edx
	jmp	.L242
	.cfi_endproc
.LFE22:
	.size	paint, .-paint
	.section	.text.unlikely
.LCOLDE50:
	.text
.LHOTE50:
	.section	.rodata.str1.1
.LC51:
	.string	"Files"
	.section	.text.unlikely
.LCOLDB52:
	.text
.LHOTB52:
	.align 4
	.globl	app_files_open
	.type	app_files_open, @function
app_files_open:
.LFB24:
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
	movl	$s_files, %eax
	xorl	%ebx, %ebx
.L275:
	movl	(%eax), %esi
	testl	%esi, %esi
	je	.L282
	incl	%ebx
	addl	$944, %eax
	cmpl	$4, %ebx
	jne	.L275
	xorl	%eax, %eax
.L276:
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
.L282:
	.cfi_restore_state
	leal	(%ebx,%ebx), %ebp
	leal	0(%ebp,%ebx), %eax
	addl	%eax, %eax
	addl	%ebx, %eax
	leal	(%ebx,%eax,4), %edx
	addl	%edx, %edx
	addl	%ebx, %edx
	sall	$4, %edx
	movl	%edx, %edi
	leal	s_files(%edx), %esi
	pushl	%edx
	.cfi_def_cfa_offset 36
	pushl	$944
	.cfi_def_cfa_offset 40
	pushl	$0
	.cfi_def_cfa_offset 44
	pushl	%esi
	.cfi_def_cfa_offset 48
	call	memset
	movl	$1, s_files(%edi)
	movl	$-1, 896(%esi)
	movl	$-1, 892(%esi)
	movl	$-1, 888(%esi)
	movl	$-1, 848(%esi)
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %ecx
	testl	%ecx, %ecx
	je	.L274
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	44(%esp)
	.cfi_def_cfa_offset 48
	call	fs_is_dir
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L279
.L274:
	movl	$.LC34, %edi
.L277:
	pushl	%eax
	.cfi_def_cfa_offset 36
	pushl	$64
	.cfi_def_cfa_offset 40
	pushl	%edi
	.cfi_def_cfa_offset 44
	addl	%ebx, %ebp
	addl	%ebp, %ebp
	addl	%ebx, %ebp
	leal	(%ebx,%ebp,4), %eax
	addl	%eax, %eax
	addl	%eax, %ebx
	sall	$4, %ebx
	leal	s_files(%ebx), %edi
	leal	8(%edi), %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	strlcpy
	movl	%esi, (%esp)
	pushl	$380
	.cfi_def_cfa_offset 52
	pushl	$560
	.cfi_def_cfa_offset 56
	pushl	$.LC51
	.cfi_def_cfa_offset 60
	pushl	$APP
	.cfi_def_cfa_offset 64
	call	gui_create_window
	movl	%eax, 4(%edi)
	addl	$32, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	je	.L283
	movl	%esi, %eax
	call	refresh
	movl	%esi, %eax
	call	set_title
	movl	4(%edi), %eax
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
.L279:
	.cfi_restore_state
	movl	32(%esp), %edi
	jmp	.L277
	.align 4
.L283:
	movl	$0, s_files(%ebx)
	jmp	.L276
	.cfi_endproc
.LFE24:
	.size	app_files_open, .-app_files_open
	.section	.text.unlikely
.LCOLDE52:
	.text
.LHOTE52:
	.section	.rodata.str1.1
.LC53:
	.string	"Up"
.LC54:
	.string	"Home"
	.section	.rodata
	.align 4
	.type	labels.1572, @object
	.size	labels.1572, 12
labels.1572:
	.long	.LC39
	.long	.LC53
	.long	.LC54
	.align 4
	.type	bw.1420, @object
	.size	bw.1420, 12
bw.1420:
	.long	56
	.long	42
	.long	52
	.align 4
	.type	bx.1419, @object
	.size	bx.1419, 12
bx.1419:
	.long	6
	.long	66
	.long	114
	.align 4
	.type	APP, @object
	.size	APP, 20
APP:
	.long	paint
	.long	on_key
	.long	on_mouse
	.long	tick
	.long	on_close
	.local	s_files
	.comm	s_files,3776,32
	.ident	"GCC: (GNU) 5.2.0"
