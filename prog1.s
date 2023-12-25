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
result:	 .word -1
	
result_prompt:	.asciiz "Result: "
#new_line:	.asciiz "\n"

	.text
main: 
	# Read m, n, and factor from input

	li 	$v0, 5	#Read integer system call
	syscall		#System call
	sw 	$v0, m	#Store result into m
	
	

	li 	$v0, 5 	#Load system instruction
	syscall		#System call
	sw 	$v0, n	#Store result into n


	li 	$v0, 5	#Load system instruction
	syscall		#System call
	sw 	$v0, factor	#Store into factor


	#check if factor is zero

	lw 	$t0, factor	#load into factor
	bnez 	$t0, not_zero	#if t != 0 branch	

	#else branch
	j 	print_res	#else jump to end and print
	


not_zero:
	#change instruction to 0
	li 	$t0, 0		#load 0 into register
	sw 	$t0, result	#store 0 into result
	j 	loop_start	#jump to loop

loop_start:
	
	lw 	$t0, m		#load m into reg
	lw 	$t1, n		#load n into reg
	lw 	$t2, factor	#load factor into reg

	bgt 	$t0, $t1, print_res	# if( m > n )
				#jump to print result

	#if m % factor is 0
	rem 	$t3, $t0, $t2	#t3 = m mod n
	beqz 	$t3, increment	#if m mod n == 0
				#jump to increment
	j 	loop_end	#jump to end of loop.

increment:
	lw 	$t4, result 
	add 	$t4, $t4, 1
	sw 	$t4, result	#result++
	#j 	loop_end

loop_end:	
	lw 	$t4, m		# m++
	add 	$t4, $t4, 1
	sw 	$t4, m

	j 	loop_start	#jump back to loop
				#condition
	

print_res:
	
	li 	$v0, 4		# load instruction
	la 	$a0, result_prompt
	syscall			# syscall

	lw 	$a0, result	#load decimal as param
	li 	$v0, 1		#load instruction
	syscall			#system call

	li 	$v0, 11		#code to print new line
	li 	$a0, 10 
	syscall

	li 	$v0, 10		#return 0
	syscall
