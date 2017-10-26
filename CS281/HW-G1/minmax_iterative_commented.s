	.file	1 "minmax_iterative.c"
	.globl	A
	.data
	.align	2
A:
	.word	11
	.word	2
	.word	33
	.word	4
	.word	15
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.rdata
	.align	2
$LC0:
	.ascii	"MinMaxIt = \000"
	.sdata
	.align	2
$LC1:
	.ascii	"  \000"
	.align	2
$LC2:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	main
	.ent	main

# main function
# This function is run when the program is run.

# It is meant to set up and run the function MinMaxIt(),
# and is then supposed to display the results of running MinMaxIt().

# The way this was converted from C is very clear. In the same way, it sets up the variables, before running the appropriate math functions and then print functions.

main:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0

	# Readies memory/registers for function

	subu	$sp,$sp,32		# subtracts 32 from value at $sp and stores it in $sp
	sw	$31,28($sp)		    # stores contents of $31 at the address
	sw	$fp,24($sp)		    # stores contents of $fp at the address
	move	$fp,$sp 		# moves $sp to $fp
	jal	__main		        # run main function
	addu	$2,$fp,20		# adds register $fp and 20 and stores it in register $2
	la	$4,					# loads address $4
	li	$5,10			    # 0xa
	addu	$6,$fp,16	 	# add register $fp and 16 and stores it in register $6
	move	$7,$2			# move register $2 to $7

	# Run the math function

	jal	MinMaxIt 			# runs function MinMaxIt

	# Run the functions that print the results

	la	$4,$LC0 			# loads $LC0 into $4
	jal	print_str 			# runs function print_str
	lw	$4,16($fp) 			# loads word at address to $4
	jal	print_int 			# runs function print_int
	la	$4,$LC1 			# loads $LC1 into $4 
	jal	print_str 			# runs function print_str
	lw	$4,20($fp) 			# loads word at address to $4
	jal	print_int 			# runs function print_int
	la	$4,$LC2				# loads $LC2 into $4
	jal	print_str 			# runs function print_str
	move	$2,$0 			# moves register $0 to $2
	move	$sp,$fp 		# moves register $fp to $sp
	lw	$31,28($sp) 		# loads word at register to $31
	lw	$fp,24($sp) 		# loads word at register to $fp
	addu	$sp,$sp,32 		# adds 32 to $sp
	j	$31					# jumps to address $31
	.end	main
	.align	2
	.globl	MinMaxIt
	.ent	MinMaxIt

# MinMaxIt function
# This function is run when called within main.

# This is a math function that is designed to locate the minimum and maximum values in an array. 

MinMaxIt:
	.frame	$fp,16,$31		# vars= 0, regs= 4/0, args= 0, extra= 0
	.mask	0x40e00000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,16		# subtract 16 from register $sp

	# Find the minumum by descending the ladder

	sw	$fp,12($sp) 		# save word at address $fp to 12($sp)
	sw	$23,8($sp)			# save word at address $23 to 8($sp)
	sw	$22,4($sp)			# save word at address $22 to 4($sp)
	sw	$21,0($sp)			# save word at address $21 to 0($sp)

	move	$fp,$sp 		# move $sp to $fp

	# Find the maximum by ascending the ladder

	sw	$4,16($fp) 			# save word at address $4 to 16($fp)
	sw	$5,20($fp) 			# save word at address $5 to 20($fp)
	sw	$6,24($fp) 			# save word at address $6 to 24($fp)
	sw	$7,28($fp) 			# save word at address $7 to 29($fp)

	# Save the result to the original address

	lw	$2,16($fp)			# load word at address 16($fp) to $2
	lw	$21,0($2)			# load word at address 0($2) to $21
	lw	$3,16($fp)			# load word at address 16($fp) to $3
	lw	$22,0($3)			# load word at address 0($3) to $22
	lw	$2,16($fp)			# load word at address 16($fp) to $2
	addu	$23,$2,4		# add 4 to $2 and store it in $23

$L3:
	lw	$2,20($fp)
	sll	$2,$2,2
	lw	$3,16($fp)
	addu	$2,$3,$2
	sltu	$2,$23,$2
	bne	$2,$0,$L6
	j	$L4
$L6:
	lw	$2,0($23)
	slt	$2,$2,$21
	beq	$2,$0,$L7
	lw	$21,0($23)
$L7:
	lw	$2,0($23)
	slt	$2,$22,$2
	beq	$2,$0,$L5
	lw	$22,0($23)
$L5:
	addu	$23,$23,4
	j	$L3
$L4:
	lw	$2,28($fp)
	sw	$22,0($2)
	lw	$3,24($fp)
	sw	$21,0($3)
	move	$2,$0
	move	$sp,$fp
	lw	$fp,12($sp)
	lw	$23,8($sp)
	lw	$22,4($sp)
	lw	$21,0($sp)
	addu	$sp,$sp,16
	j	$31
	.end	MinMaxIt
	.align	2
	.globl	__main
	.ent	__main
__main:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	move	$2,$0
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__main
	.align	2
	.globl	dummy
	.ent	dummy
dummy:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	move	$2,$0
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	dummy
	.align	2
	.globl	print_int
	.ent	print_int
print_int:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	sw	$fp,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	li	$2,1			# 0x1
	sw	$2,0($fp)
	lw	$3,0($fp)
	lw	$2,16($fp)
 #APP
	add $a0,$2,$zero
	add $v0,$3,$zero
	syscall
 #NO_APP
	lw	$2,16($fp)
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	print_int
	.align	2
	.globl	print_hex
	.ent	print_hex
print_hex:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	lw	$4,40($fp)
	addu	$5,$fp,16
	jal	itox
	addu	$4,$fp,16
	jal	print_str
	lw	$2,40($fp)
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addu	$sp,$sp,40
	j	$31
	.end	print_hex
	.align	2
	.globl	print_str
	.ent	print_str
print_str:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	sw	$fp,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	li	$2,4			# 0x4
	sw	$2,0($fp)
	lw	$3,0($fp)
	lw	$2,16($fp)
 #APP
	add $a0,$2,$zero
	add $v0,$3,$zero
	syscall
 #NO_APP
	move	$2,$0
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	print_str
	.align	2
	.globl	itox
	.ent	itox
itox:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$5,28($fp)
	li	$2,7			# 0x7
	sw	$2,4($fp)
	sw	$0,0($fp)
$L15:
	lw	$2,0($fp)
	slt	$2,$2,8
	bne	$2,$0,$L18
	j	$L16
$L18:
	lw	$2,24($fp)
	andi	$2,$2,0xf
	sw	$2,8($fp)
	lw	$2,8($fp)
	slt	$2,$2,10
	beq	$2,$0,$L19
	lw	$3,28($fp)
	lw	$2,4($fp)
	addu	$3,$3,$2
	lbu	$2,8($fp)
	addu	$2,$2,48
	sb	$2,0($3)
	j	$L20
$L19:
	lw	$3,28($fp)
	lw	$2,4($fp)
	addu	$3,$3,$2
	lbu	$2,8($fp)
	addu	$2,$2,55
	sb	$2,0($3)
$L20:
	lw	$2,24($fp)
	sra	$2,$2,4
	sw	$2,24($fp)
	lw	$2,4($fp)
	addu	$2,$2,-1
	sw	$2,4($fp)
	lw	$2,0($fp)
	addu	$2,$2,1
	sw	$2,0($fp)
	j	$L15
$L16:
	lw	$2,28($fp)
	addu	$2,$2,8
	sb	$0,0($2)
	lw	$2,24($fp)
	move	$sp,$fp
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	itox
	.align	2
	.globl	print_stack
	.ent	print_stack
print_stack:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	li	$2,42			# 0x2a
	sw	$2,28($fp)
	addu	$2,$fp,40
	sw	$2,16($fp)
	lw	$2,16($fp)
	sw	$2,20($fp)
	lw	$4,20($fp)
	jal	print_hex
	la	$4,$LC2
	jal	print_str
	lw	$2,16($fp)
	addu	$2,$2,-80
	sw	$2,16($fp)
	sw	$0,24($fp)
$L22:
	lw	$2,24($fp)
	slt	$2,$2,82
	bne	$2,$0,$L25
	j	$L23
$L25:
	lw	$2,16($fp)
	sw	$2,20($fp)
	lw	$4,20($fp)
	jal	print_hex
	la	$4,$LC1
	jal	print_str
	lw	$2,16($fp)
	lw	$2,0($2)
	sw	$2,20($fp)
	lw	$4,20($fp)
	jal	print_hex
	la	$4,$LC2
	jal	print_str
	lw	$2,16($fp)
	addu	$2,$2,4
	sw	$2,16($fp)
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	j	$L22
$L23:
	lw	$2,28($fp)
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addu	$sp,$sp,40
	j	$31
	.end	print_stack
