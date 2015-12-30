.data
	prompt: .asciiz "Postfix (input) : "
	error: .asciiz "Too many tokens"
	error2: .asciiz "Invalid postfix"
	error3: .asciiz "Divide by zero"
.text
	#final static int MAX = 20
	addi $s0, $zero, 20 #s0 = MAX
	#static int i=0
	addi $s1, $zero, 0

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
	
	
   do_while:
   	# Get next char
   	lb $t1, ($t0) #load a character (byte) in $t1 $t1 = ch
   	
   	bne $t1, 32 , notSpace
   	
   	
   notSpace:
   	addi $t2, $zero ,0 # number($t2) =0
   	
   while:
   	blt $t1, 48, exitWhile #Conditions
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
   	# if  ((ch == '+') || (ch == '-') ||(ch == '*')||(ch == '/')) 
   	beq $t1, 43, if_body
   	beq $t1, 43, if_body
   	beq $t1, 43, if_body
   	beq $t1, 43, if_body
   	b else_if #go to else_if
   	
   if_body:
   	b pop #call pop() function 
   	move $t4, $v0 # move the return value stored in $v0 to $t4=x2
   	b pop #pop()
   	move $t3, $v0 # move the return value stored in $v0 to $t3=x1
   	b calc # calc()
   	move $t2, $v0
   	b push
   	
   	j do_while
   	
   else_if:
   	#(ch != '=')
   	bne $t1, 61, push
   	
   	j do_while
   	

   
   	
   	
   push:
   	beq $s1, $s0, error_overflow
   	sw $t2 , stack($t7)#p[i] = result
   		addi $t7, $t7, 4  #go to space for next int
   	addi $s1, $s1, 1 # i++
   	
   	jr $ra
   pop:
   	beq $s1, $zero, error_underflow
   	lw $v0, stack($t7)
   		addi $t7, $t7, -4
   	addi $s1, $s1, -1 # i--
   
   	jr $ra
   calc:
   	addi $t5, $zero ,0
   	#Switch - cases :
   	beq $t1 ,43, c1_body
   	beq $t1, 45, c2_body
   	beq $t1, 42, c3_body
   	beq $t1, 47, c4_body
   	
   	addi $v0, $t5, $zero
   	
   	jr $ra			
   c1_body:		
   	#total($t5) = x1+x2; break;
	add $t5, $t3, $t4 
	j exit # change exit later on MArios
	
   c2_body:
   	#total= x1-x2; break;
   	sub $t5, $t3, $t4
   	j exit # change exit later on MArios
   
   c3_body:
   	#total= x1*x2; break;
   	mul $t5, $t3,$t4
	j exit # change exit later on MArios	
	
   c4_body:
   	#if (x2 != 0) total = x1/x2
	beq $t4 , $zero, error_divideByZero		
   	div $t5, $t3, $t4
   	j exit
   	
   error_overflow:
   	#Print error
   	li $v0, 4
   	la $a0, error
   	syscall
   	#System exit
   	li $v0,10
   	syscall
   		
   error_underflow:
   	#Print error
   	li $v0, 4
   	la $a0, error2
   	syscall
   	#System exit
   	li $v0,10
   	syscall

   error_divideByZero:
   	#Print error
   	li $v0, 4
   	la $a0, error3
   	syscall
   	#System exit
   	li $v0,10
   	syscall