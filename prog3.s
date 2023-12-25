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
main:	li 	$sp, 0x7ffffffc #stack pointer

	li 	$v0, 5	#load scan instruction
	syscall		#call
	sw 	$v0, m	#store into variable m

	li 	$v0, 5	#load scan decimal
	syscall		#call function
	sw 	$v0, n	#store into variable n

	li 	$v0, 5	#load scan decimal
	syscall		#call function
	sw	 $v0, factor	#store into factor

	
	
	lw 	$t0, m	#load m into register
	lw 	$t1, n	#load n into register
	lw 	$t2, factor	#load factor into register


	sw 	$t0, ($sp)	#load parameters
	sub 	$sp, $sp, 4	#dec sp

	sw 	$t1, ($sp)	#load parameters
	sub 	$sp, $sp, 4	#dec sp
	
	sw 	$t2, ($sp)	#load parameters
	sub 	$sp, $sp, 4	#dec sp
	

	jal	num_mult	#call num_mult function

	add 	$sp, $sp, 12	#reset sp

	move	$t7, $v0	#store result into temp
	sw 	$t7, temp	#store result into temp


	#print result
	la	 $a0, result_text	#parameter
	li	 $v0, 4			#load instruction
	syscall				#system call

	#print temp
	lw 	$a0, temp		#load variable
	li 	$v0, 1			#load instruction
	syscall				#system call

	#print newline
	li 	$v0, 11			#load instruction
	li 	$a0, 10			#load param
	syscall				#system call
	
	
	#return 0
	li 	$v0, 10			#return
	syscall				#system call



num_mult:

	sub	$sp, $sp, 8	#decrement stack pointer
	sw	$ra, 8($sp)	#store return address
	sw	$fp, 4($sp)	#store frame pointer
	add	$fp, $sp, 8	#add to frame pointer

	#im sure this isnt necessary because t0 - 2 have not been stored yet
	
	lw	$t0, 12($fp) #value 1
	lw	$t1, 8($fp) #value 2
	lw	$t2, 4($fp) #number
	li	$t3, 0	#0 to push to stack

	#store variables into stack again
	sw 	$t0, ($sp)	#store value1
	sub 	$sp, $sp, 4	#inc sp

	sw 	$t1, ($sp)	#store value2
	sub 	$sp, $sp, 4	#inc sp
	
	sw	$t2, ($sp)	#store num
	sub 	$sp, $sp, 4	#inc sp
	
	sw 	$t3, ($sp)	#store register into param
	sub 	$sp, $sp, 4	#inc sp
		
	jal 	num_mult_helper	#call num_mult_helper

	add 	$sp, $sp, 16	#reset stack pointer
		
	lw 	$ra, 8($sp)	#restore return address
	lw	$fp, 4($sp)	#restore frame pointer
	add	$sp, $sp, 8	#reset stack pointer
	jr	$ra		#return to main function

num_mult_helper:

	sub	$sp, $sp, 16	#stack pointer
	sw	$ra, 16($sp)	#set return address
	sw	$fp, 12($sp)	#frame pointer
	add	$fp, $sp, 16 	#set frame pointer

	#store -1 into result as a local var in the stack
	li 	$t4, -1		#store -1 into register
	sw 	$t4, 8($sp)	#store register into stack mem

	#note that next_value will be stored in 4($sp)

	#now load variables into registers for ease of use
	lw	$t0, 16($fp) #value 1
	lw	$t1, 12($fp) #value 2
	lw	$t2, 8($fp) #number
	lw	$t3, 4($fp) #cur_result


	beqz 	$t2, exit	#if num  == 0
	

num_mult_conditional:
	 
	ble 	$t0, $t1, num_mult_else 	#if (val1 > val2)

	move	$t4, $t3	#result = cur_result
	sw	$t4, 8($sp)	#continued here		

	j	exit	#jump to return segment

num_mult_else:

	add	$t5, $t0, 1	#val1 + 1
	sw	$t5, 4($sp)	#next val = above
	
	#recursive call preparation

	sw 	$t5, ($sp)	#add next_val to stack
	sub 	$sp, $sp, 4	#inc stack pointer

	sw 	$t1, ($sp)	#add val2 to stack
	sub 	$sp, $sp, 4	#inc stack pointer

	
	sw 	$t2, ($sp)	#add num to stack
	sub 	$sp, $sp, 4	#inc stack pointer

	
	sw 	$t3, ($sp)	#add curr_result to stack	
	sub 	$sp, $sp, 4	#add stack pointer

	jal	num_mult_helper	#call function
	add	$sp, $sp, 16	#pop arguments

	
	move	$t4, $v0	#store recursive call into result
	sw	$t4, 8($sp)	#result = num_mult_helper
	

	lw 	$t0, 16($fp)	#refresh val1
	lw	$t2, 8($fp)	#reload num for remainder check
	
	rem	$t6, $t0, $t2	#t6 = val1 mod num
	bnez 	$t6, exit	#if t6 != 0 



	add 	$t4, $t4, 1	#add result and store
	sw 	$t4, 8($sp) 	#result ++
	#j 	exit

exit:
	move	$v0, $t4	#set return value to be result
	lw 	$ra, 16($sp)	#reset return address
	lw	$fp, 12($sp)	#reset frame pointer
	add	$sp, $sp, 16	#reset stack pointer
	jr	$ra		#return to caller

	

	
	

	
	
	
	
