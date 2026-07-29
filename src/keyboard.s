	.file	"keyboard.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	keyboard_get_char
	.type	keyboard_get_char, @function
keyboard_get_char:
.LFB1:
	.cfi_startproc
	.align 4
.L2:
/APP
/  8 "keyboard.h" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	testb	$1, %al
	je	.L2
/APP
/  8 "keyboard.h" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	testb	%al, %al
	js	.L2
	movzbl	%al, %eax
	movb	scancode_ascii(%eax), %al
	testb	%al, %al
	je	.L2
	ret
	.cfi_endproc
.LFE1:
	.size	keyboard_get_char, .-keyboard_get_char
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	scan
	.type	scan, @function
scan:
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
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %ebp
	movl	36(%esp), %eax
	leal	-1(%eax), %ebx
	xorl	%edi, %edi
.L12:
	cmpl	%ebx, %edi
	jge	.L17
	.align 4
.L13:
/APP
/  8 "keyboard.h" 1
	inb $100, %al
/  0 "" 2
/NO_APP
	testb	$1, %al
	je	.L13
/APP
/  8 "keyboard.h" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	testb	%al, %al
	js	.L13
	movzbl	%al, %eax
	movsbl	scancode_ascii(%eax), %eax
	testb	%al, %al
	je	.L13
	cmpb	$10, %al
	je	.L26
	cmpb	$8, %al
	jne	.L18
	testl	%edi, %edi
	jle	.L12
	decl	%edi
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$8
	.cfi_def_cfa_offset 48
	call	putchar
	movl	$32, (%esp)
	call	putchar
	movl	$8, (%esp)
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	cmpl	%ebx, %edi
	jl	.L13
.L17:
	movb	$0, 0(%ebp,%edi)
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
.L18:
	.cfi_restore_state
	leal	1(%edi), %esi
	movb	%al, 0(%ebp,%edi)
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	%esi, %edi
	jmp	.L12
.L26:
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$10
	.cfi_def_cfa_offset 48
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	jmp	.L17
	.cfi_endproc
.LFE2:
	.size	scan, .-scan
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.rodata
	.align 32
	.type	scancode_ascii, @object
	.size	scancode_ascii, 128
scancode_ascii:
	.byte	0
	.byte	27
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	48
	.byte	45
	.byte	61
	.byte	8
	.byte	9
	.byte	113
	.byte	119
	.byte	101
	.byte	114
	.byte	116
	.byte	121
	.byte	117
	.byte	105
	.byte	111
	.byte	112
	.byte	91
	.byte	93
	.byte	10
	.byte	0
	.byte	97
	.byte	115
	.byte	100
	.byte	102
	.byte	103
	.byte	104
	.byte	106
	.byte	107
	.byte	108
	.byte	59
	.byte	39
	.byte	96
	.byte	0
	.byte	92
	.byte	122
	.byte	120
	.byte	99
	.byte	118
	.byte	98
	.byte	110
	.byte	109
	.byte	44
	.byte	46
	.byte	47
	.byte	0
	.byte	42
	.byte	0
	.byte	32
	.zero	70
	.ident	"GCC: (GNU) 5.2.0"
