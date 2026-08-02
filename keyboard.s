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
	movl	4(%esp), %eax
	cmpb	$42, %al
	je	.L2
	cmpb	$54, %al
	je	.L2
	cmpb	$-86, %al
	je	.L5
	cmpb	$-74, %al
	je	.L5
	cmpb	last_scancode, %al
	je	.L11
	movb	%al, last_scancode
	testb	%al, %al
	js	.L11
	cmpb	$57, %al
	ja	.L11
	movzbl	%al, %eax
	movl	shift_pressed, %edx
	testl	%edx, %edx
	jne	.L13
	movb	scancode_to_ascii_lower(%eax), %al
	ret
	.align 4
.L11:
	xorl	%eax, %eax
	ret
	.align 4
.L5:
	movl	$0, shift_pressed
	movb	%al, last_scancode
	xorl	%eax, %eax
	ret
	.align 4
.L2:
	movl	$1, shift_pressed
	movb	%al, last_scancode
	xorl	%eax, %eax
	ret
	.align 4
.L13:
	movb	scancode_to_ascii_upper(%eax), %al
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
	.globl	keyboard_handler
	.type	keyboard_handler, @function
keyboard_handler:
.LFB2:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
/APP
/  8 "include/keyboard.h" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	movzbl	%al, %eax
	pushl	%eax
	.cfi_def_cfa_offset 20
	call	keyboard_get_char
	popl	%edx
	.cfi_def_cfa_offset 16
	testb	%al, %al
	je	.L14
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	movsbl	%al, %eax
	pushl	%eax
	.cfi_def_cfa_offset 32
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 16
.L14:
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	keyboard_handler, .-keyboard_handler
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	scan
	.type	scan, @function
scan:
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
	movl	36(%esp), %eax
	leal	-1(%eax), %esi
	xorl	%ebx, %ebx
	testl	%esi, %esi
	jg	.L25
	jmp	.L21
	.align 4
.L36:
	testl	%ebx, %ebx
	je	.L22
	decl	%ebx
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$8
	.cfi_def_cfa_offset 48
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	.align 4
.L22:
/APP
/  90 "src/keyboard.c" 1
	nop
/  0 "" 2
/NO_APP
	cmpl	%esi, %ebx
	jge	.L21
.L25:
/APP
/  8 "include/keyboard.h" 1
	inb $96, %al
/  0 "" 2
/NO_APP
	movzbl	%al, %eax
	pushl	%eax
	.cfi_def_cfa_offset 36
	call	keyboard_get_char
	popl	%edx
	.cfi_def_cfa_offset 32
	testb	%al, %al
	je	.L22
	cmpb	$10, %al
	je	.L35
	cmpb	$8, %al
	je	.L36
	leal	1(%ebx), %ebp
	movb	%al, (%edi,%ebx)
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	movsbl	%al, %eax
	pushl	%eax
	.cfi_def_cfa_offset 48
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	%ebp, %ebx
	jmp	.L22
	.align 4
.L35:
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	$10
	.cfi_def_cfa_offset 48
	call	putchar
	addl	$16, %esp
	.cfi_def_cfa_offset 32
.L21:
	movb	$0, (%edi,%ebx)
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
.LFE3:
	.size	scan, .-scan
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.local	last_scancode
	.comm	last_scancode,1,1
	.local	shift_pressed
	.comm	shift_pressed,4,4
	.section	.rodata
	.align 32
	.type	scancode_to_ascii_upper, @object
	.size	scancode_to_ascii_upper, 58
scancode_to_ascii_upper:
	.byte	0
	.byte	27
	.byte	33
	.byte	64
	.byte	35
	.byte	36
	.byte	37
	.byte	94
	.byte	38
	.byte	42
	.byte	40
	.byte	41
	.byte	95
	.byte	43
	.byte	8
	.byte	9
	.byte	81
	.byte	87
	.byte	69
	.byte	82
	.byte	84
	.byte	89
	.byte	85
	.byte	73
	.byte	79
	.byte	80
	.byte	123
	.byte	125
	.byte	10
	.byte	0
	.byte	65
	.byte	83
	.byte	68
	.byte	70
	.byte	71
	.byte	72
	.byte	74
	.byte	75
	.byte	76
	.byte	58
	.byte	34
	.byte	126
	.byte	0
	.byte	124
	.byte	90
	.byte	88
	.byte	67
	.byte	86
	.byte	66
	.byte	78
	.byte	77
	.byte	60
	.byte	62
	.byte	63
	.byte	0
	.byte	42
	.byte	0
	.byte	32
	.align 32
	.type	scancode_to_ascii_lower, @object
	.size	scancode_to_ascii_lower, 58
scancode_to_ascii_lower:
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
	.ident	"GCC: (GNU) 5.2.0"
