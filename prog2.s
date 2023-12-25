	#NAME: Justin Pham
	#UID: 118 649 726
	#TERP-Connect: jpham04@umd.edu
	#Section: 0307
	# Honor Plede: I swear that I have not given
	# or received unauthorized aid on this
	# assignment: Justin Pham

	.data
m:	.word 0
n:	.word 0
factor:	.word 0
temp:	.word 0
result_text:	.asciiz "Result: "


	.text
main:	li 	$sp, 0x7ffffffc #snit stack pointer

	
	
	#scan into m, n, and factor

	li 	$v0, 5	#load instruction
	syscall		#system call
	sw 	$v0, m	#store input to m

	li 	$v0, 5	#load instruction
	syscall		#system call
	sw 	$v0, n	#store input to n

	li 	$v0, 5	#load instruction
	syscall		#system call
	sw	 $v0, factor
			#store input to factor
		
	
	#load variables into stack (as params)
	lw 	$t0, m	#load m into reg
	lw 	$t1, n	#load n into reg
	lw 	$t2, factor
			#load factor into reg

	sw $t0, ($sp)	#add m to stack
	sub $sp, $sp, 4	#sub stack pointer

	sw $t1, ($sp)	#add n to stack
	sub $sp, $sp, 4	#sub stack pointer

	sw $t2, ($sp)	#add factor to stack
	sub $sp, $sp, 4	#sub stack pointer
	

	jal	num_multiples	#call num_mul
				#function
	sw 	$v0, temp	#store result
				#to temp variable

	add $sp, $sp, 12	#reset stack pointer

	#print result
	la	 $a0, result_text
	li	 $v0, 4
	syscall

	#print temp
	lw 	$a0, temp
	li 	$v0, 1
	syscall

	#print newline
	li 	$v0, 11
	li 	$a0, 10
	syscall
	
	
	#return 0
	li 	$v0, 10
	syscall

num_multiples:
	
	
	sub	$sp, $sp, 12	#sub stack pointer
	sw	$ra, 12($sp)	#store return address in stack
	sw	$fp, 8($sp)	#store frame pointer in stack
	add	$fp, $sp, 12	#set frame pointer of cur
	
	lw	$t0, 24($sp)	#value 1 loaded into register
	lw	$t1, 20($sp)	#value 2
	lw	$t2, 16($sp) 	#number

	li	$t3, -1		#result set to -1
	sw	$t3, 4($sp)	#store local var in stack

	#if number !-0
	bnez 	$t2, conditional
				#if num != 0 jump to loop
	j 	exit_function	#else jump to return

conditional:
	li 	$t3, 0		#result set to 0
	sw	$t3, 4($sp)	#save in stack


	#while loop herez
loop:	
	
	bgt 	$t0, $t1, exit_function
			#if val 1 > val2
			#exit loop
	
	rem	$t4, $t0, $t2	#calc remainder
	#if value % number == 0
	beqz 	$t4, increment_result
				#if rem == 0 inc res
	j	increment_value1
				#jump to inc

increment_result:
	add 	$t3, $t3, 1	#inc result
	sw	$t3, 4($sp)	#save to res
	j 	increment_value1
				#jump to inc

increment_value1:	
	add 	$t0, $t0, 1	#add 1 to value
	sw	$t0, 24($sp)	#save to value
	j 	loop		#jump back to condition
	
exit_function:	 
	move 	$v0, $t3 	#move local result
				#var to return

	lw	$ra, 12($sp)	#reset return addy
	lw	$fp, 8($sp)	#reset frame pointer
	add	$sp, $sp, 12	#reset stack pointer
	jr	$ra		#jump back to main

	
