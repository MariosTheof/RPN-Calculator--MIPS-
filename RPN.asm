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
	
	
   
   	# Get next char
   	lb $t1, ($t0) #load a character (byte) in $t1 $t1 = ch
   	bne $t1, 32 , notSpace
   	
   notSpace:
   	addi $t2, $zero ,0 # number($t2) =0
   	
   while:
   	bgt $t1, 48, exitWhile #Conditions
   	bgt $t1, 57, exitWhile
   	
   	
   	mul $t2, $t2, 10 # number = 10*number + (ch-48)
   	sub $t1, $t1, -48
   	add $t2, $t2, $t1
   	
    nextChar:
   	# Get next char
   	lb $t1, ($t0) #load a character (byte) in $t1 $t1 = ch
   	bne $t1, 32 , notSpace
   	addi $t0, $t0, 1 # input ++ so it points to the next character
   	
   	j while
   	
   exitWhile:
   	
   	
   	
   	
   	
