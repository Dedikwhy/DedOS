	.file	"first_draw.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"          .\n"
.LC1:
	.string	"         #\n"
.LC2:
	.string	"    #@@@@\n"
.LC3:
	.string	"   @    @\n"
.LC4:
	.string	"   #   @\n"
.LC5:
	.string	"   #@@@\n\n"
.LC6:
	.string	"$ "
.LC7:
	.string	"$\n\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB8:
	.text
.LHOTB8:
	.align 4
	.globl	first_draw
	.type	first_draw, @function
first_draw:
.LFB1:
	.cfi_startproc
	subl	$24, %esp
	.cfi_def_cfa_offset 28
	pushl	$9
	.cfi_def_cfa_offset 32
	call	setcolor
	movl	$.LC0, (%esp)
	call	print
	movl	$.LC1, (%esp)
	call	print
	movl	$.LC2, (%esp)
	call	print
	movl	$.LC3, (%esp)
	call	print
	movl	$.LC4, (%esp)
	call	print
	movl	$.LC5, (%esp)
	call	print
	movl	$0, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$1, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$2, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$3, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$4, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$5, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$6, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$7, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$8, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$9, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$10, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$11, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$12, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$13, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$14, (%esp)
	call	setcolor
	movl	$.LC6, (%esp)
	call	print
	movl	$15, (%esp)
	call	setcolor
	movl	$.LC7, (%esp)
	call	print
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	first_draw, .-first_draw
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.ident	"GCC: (GNU) 5.2.0"
