	.file	"hotkeys.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.align 4
	.globl	hotkey_handle
	.type	hotkey_handle, @function
hotkey_handle:
.LFB0:
	.cfi_startproc
	movl	4(%esp), %eax
	cmpb	$29, %al
	je	.L12
	cmpb	$-99, %al
	je	.L13
	cmpb	$56, %al
	je	.L14
	cmpb	$-72, %al
	je	.L15
	cmpb	$42, %al
	je	.L7
	cmpb	$54, %al
	je	.L7
	cmpb	$-86, %al
	je	.L10
	cmpb	$-74, %al
	je	.L10
	ret
	.align 4
.L15:
	movl	$0, alt_pressed
	movl	$0, layout_combo_used
	ret
	.align 4
.L10:
	movl	$0, shift_pressed
	movl	$0, layout_combo_used
	ret
	.align 4
.L12:
	movl	$1, ctrl_pressed
	ret
	.align 4
.L7:
	movl	alt_pressed, %eax
	testl	%eax, %eax
	je	.L9
	movl	layout_combo_used, %ecx
	testl	%ecx, %ecx
	jne	.L9
	xorl	%eax, %eax
	movl	rus_layout, %edx
	testl	%edx, %edx
	sete	%al
	movl	%eax, rus_layout
	movl	$1, layout_combo_used
.L9:
	movl	$1, shift_pressed
	ret
	.align 4
.L13:
	movl	$0, ctrl_pressed
	ret
	.align 4
.L14:
	movl	$1, alt_pressed
	ret
	.cfi_endproc
.LFE0:
	.size	hotkey_handle, .-hotkey_handle
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.align 4
	.globl	hotkey_is_russian
	.type	hotkey_is_russian, @function
hotkey_is_russian:
.LFB1:
	.cfi_startproc
	movl	rus_layout, %eax
	ret
	.cfi_endproc
.LFE1:
	.size	hotkey_is_russian, .-hotkey_is_russian
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.align 4
	.globl	hotkey_set_russian
	.type	hotkey_set_russian, @function
hotkey_set_russian:
.LFB2:
	.cfi_startproc
	xorl	%eax, %eax
	movl	4(%esp), %edx
	testl	%edx, %edx
	setne	%al
	movl	%eax, rus_layout
	ret
	.cfi_endproc
.LFE2:
	.size	hotkey_set_russian, .-hotkey_set_russian
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely
.LCOLDB3:
	.text
.LHOTB3:
	.align 4
	.globl	hotkey_toggle_layout
	.type	hotkey_toggle_layout, @function
hotkey_toggle_layout:
.LFB3:
	.cfi_startproc
	xorl	%eax, %eax
	movl	rus_layout, %edx
	testl	%edx, %edx
	sete	%al
	movl	%eax, rus_layout
	ret
	.cfi_endproc
.LFE3:
	.size	hotkey_toggle_layout, .-hotkey_toggle_layout
	.section	.text.unlikely
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely
.LCOLDB4:
	.text
.LHOTB4:
	.align 4
	.globl	hotkey_is_ctrl_pressed
	.type	hotkey_is_ctrl_pressed, @function
hotkey_is_ctrl_pressed:
.LFB4:
	.cfi_startproc
	movl	ctrl_pressed, %eax
	ret
	.cfi_endproc
.LFE4:
	.size	hotkey_is_ctrl_pressed, .-hotkey_is_ctrl_pressed
	.section	.text.unlikely
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely
.LCOLDB5:
	.text
.LHOTB5:
	.align 4
	.globl	hotkey_is_alt_pressed
	.type	hotkey_is_alt_pressed, @function
hotkey_is_alt_pressed:
.LFB5:
	.cfi_startproc
	movl	alt_pressed, %eax
	ret
	.cfi_endproc
.LFE5:
	.size	hotkey_is_alt_pressed, .-hotkey_is_alt_pressed
	.section	.text.unlikely
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.align 4
	.globl	hotkey_is_shift_pressed
	.type	hotkey_is_shift_pressed, @function
hotkey_is_shift_pressed:
.LFB6:
	.cfi_startproc
	movl	shift_pressed, %eax
	ret
	.cfi_endproc
.LFE6:
	.size	hotkey_is_shift_pressed, .-hotkey_is_shift_pressed
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.align 4
	.globl	hotkey_ctrl_c
	.type	hotkey_ctrl_c, @function
hotkey_ctrl_c:
.LFB19:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE19:
	.size	hotkey_ctrl_c, .-hotkey_ctrl_c
	.section	.text.unlikely
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.globl	hotkey_ctrl_v
	.type	hotkey_ctrl_v, @function
hotkey_ctrl_v:
.LFB17:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE17:
	.size	hotkey_ctrl_v, .-hotkey_ctrl_v
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely
.LCOLDB9:
	.text
.LHOTB9:
	.align 4
	.globl	hotkey_ctrl_l
	.type	hotkey_ctrl_l, @function
hotkey_ctrl_l:
.LFB15:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE15:
	.size	hotkey_ctrl_l, .-hotkey_ctrl_l
	.section	.text.unlikely
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.align 4
	.globl	hotkey_alt_f1
	.type	hotkey_alt_f1, @function
hotkey_alt_f1:
.LFB13:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE13:
	.size	hotkey_alt_f1, .-hotkey_alt_f1
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.align 4
	.globl	hotkey_alt_f2
	.type	hotkey_alt_f2, @function
hotkey_alt_f2:
.LFB11:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE11:
	.size	hotkey_alt_f2, .-hotkey_alt_f2
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.local	layout_combo_used
	.comm	layout_combo_used,4,4
	.local	rus_layout
	.comm	rus_layout,4,4
	.local	shift_pressed
	.comm	shift_pressed,4,4
	.local	alt_pressed
	.comm	alt_pressed,4,4
	.local	ctrl_pressed
	.comm	ctrl_pressed,4,4
	.ident	"GCC: (GNU) 5.2.0"
