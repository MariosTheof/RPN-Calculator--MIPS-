.data
	prompt: .asciiz "Postfix (input) : "
.text
	#Print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	#Get the users input
	li $v0, 5
	syscall
	
	#Store input in $t0
	move $t0, $v0
	
	#Display input
	li $v0, 4
	move $a0, $t0
	syscall
	
	
   nextChar:
   	# Get next char
   	lb $t1, ($t0) #load a character (byte) in $t1 $t1 = ch
   	bne $t1, 32 , notSpace
   	
   notSpace:
   	addi $t2, $zero ,0 # number($t2) =0
   	
   while:
   	bgt $t1, 48, exitWhile
   	bgt $t1, 57, exitWhile
   	$t2 
   	
   	
   	
   	