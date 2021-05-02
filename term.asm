.data
filename: .asciiz "testArch.txt"
errorMessage: .asciiz "ERROR: unrecognized opcode"
buffer: .space 9
numericalValue: .word
endl: .asciiz "\n"
opcode: .word
immediate: .word

.text
main:
	la $s1,buffer
	
	li $v0,13     # syscall for open file
	la $a0,filename   # input file name
	li $a1,0      # read flag
	li $a2,0      # ignore mode 	
	syscall       # open file 
	move $s0,$v0  # save the file descriptor 
    
readData:
	#Load the file for reading
	li $v0,14
	move $a0, $s0 #Pass file descriptor as an argument
	move $a1,$s1 #Pass the buffer that will store the string as an argument
	li $a2,9
	syscall
	blez $v0, program_finished #if nothing is read from the file end the program
	addi $s3,$s3,9
	add $s3,$s3,$t1
	
	la $t6,buffer
	addi $t3,$zero,0
	addi $t5,$zero,0
	stringLoop:
		addi $t4, $zero,0 #store 0 in $t4, $t4 will store each character from the string
		add $s7, $t6, $t3 # $s7 = t3th character in the string
		lb $t4, 0($s7) #cload character into $t4
		beq $t3, 8, postLoop #if loop counter == 8 stop the loop
		bgt $t4, 58, letter #if the character read is deemed to be a letter, then go to branch letter
		sub $t4, $t4, 48 # else subtract 48 from the char (gets numerical value from char '0' = 0, '1' = 1 etc.).
		process:
		#t5 has total
		sll $t5,$t5,4 #multiply total by 16
		add $t5,$t5,$t4 #add value of $t4 to the total
		addi $t3,$t3,1#increment loop counter
		j stringLoop
		
		
		
		
	

		
	
	postLoop:
	j readData
		
	letter:
	sub $t4, $t4, 87
	j process
	
	#
	srl $t3, $t1, 26
	
	li $t3, 10000000000000000000000000000000
	beq $t4, $t1, Add #jump to and and find the register values
	li $t3, 10001000000000000000000000000000
	beq $t4, $t1, Sub #jump to and and find the register values
	li $t3, 00001000000000000000000000000000
	beq $t4, $t1, Srl
	li $t3, 00000000000000000000000000000000
	beq $t4, $t1, Sll
	li $t3, 10010000000000000000000000000000
	beq $t4, $t1, And
	li $t3, 10010100000000000000000000000000
	beq $t4, $t1, Or
	li $t3, 10011100000000000000000000000000
	beq $t4, $t1, Nor
	li $t3, 10101000000000000000000000000000
	beq $t4, $t1, Slt
	
Add: 
#Register 3
sll $t3, $t1, 16
srl $t4, $t3, 11
move $t4, $t5
j RegisterBranch
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Sub: 
#Register 3
sll $t3, $t1, 16
srl $t4, $t3, 11
move $t4, $t5
j RegisterBranch
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Div:
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

And:
#Register 3
sll $t3, $t1, 16
srl $t4, $t3, 11
move $t4, $t5
j RegisterBranch
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Or:
#Register 3
sll $t3, $t1, 16
srl $t4, $t3, 11
move $t4, $t5
j RegisterBranch
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Nor:
#Register 3
sll $t3, $t1, 16
srl $t4, $t3, 11
move $t4, $t5
j RegisterBranch
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Slt:
#Register 3
sll $t3, $t1, 16
srl $t4, $t3, 11
move $t4, $t5
j RegisterBranch
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Bne: 
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

Beq:
#Register 1
sll $t3, $t1, 6
srl $t4, $t3, 21
move $t4, $t5
j RegisterBranch
#Register 2
sll $t3, $t1, 11
srl $t4, $t3, 16
move $t4, $t5
j RegisterBranch

RegisterBranch:
li $t6, 00000000000000000000000000000000
beq $t5, $t6 ,$Zero

li $t6, 00000000000000000000000000000001
beq $t5, $t6 ,$At

li $t6, 00000000000000000000000000000010
beq $t5, $t6 ,$V0

li $t6, 00000000000000000000000000000011
beq $t5, $t6 ,$V1

li $t6, 00000000000000000000000000000100
beq $t5, $t6 ,$A0

li $t6, 00000000000000000000000000000101
beq $t5, $t6 ,$A1

li $t6, 00000000000000000000000000000110
beq $t5, $t6 ,$A2

li $t6, 00000000000000000000000000000111
beq $t5, $t6 ,$A3

li $t6, 00000000000000000000000000001000
beq $t5, $t6 ,$T0

li $t6, 00000000000000000000000000001001
beq $t5, $t6 ,$T1

li $t6, 00000000000000000000000000001010
beq $t5, $t6 ,$T2

li $t6, 00000000000000000000000000001011
beq $t5, $t6 ,$T3

li $t6, 00000000000000000000000000001100
beq $t5, $t6 ,$T4

li $t6, 00000000000000000000000000001101
beq $t5, $t6 ,$T5

li $t6, 00000000000000000000000000001110
beq $t5, $t6 ,$T6

li $t6, 00000000000000000000000000001111
beq $t5, $t6 ,$T7

li $t6, 00000000000000000000000000010000
beq $t5, $t6 ,$S0

li $t6, 00000000000000000000000000010001
beq $t5, $t6 ,$S1

li $t6, 00000000000000000000000000010010
beq $t5, $t6 ,$S2

li $t6, 00000000000000000000000000010011
beq $t5, $t6 ,$S3

li $t6, 00000000000000000000000000010100
beq $t5, $t6 ,$S4

li $t6, 00000000000000000000000000010101
beq $t5, $t6 ,$S5

li $t6, 00000000000000000000000000010110
beq $t5, $t6 ,$S6

li $t6, 00000000000000000000000000010111
beq $t5, $t6 ,$S7

li $t6, 00000000000000000000000000011000
beq $t5, $t6 ,$T8

li $t6, 00000000000000000000000000011001
beq $t5, $t6 ,$T9

li $t6, 00000000000000000000000000011010
beq $t5, $t6 ,$K0

li $t6, 00000000000000000000000000011011
beq $t5, $t6 ,$K1

li $t6, 00000000000000000000000000011100
beq $t5, $t6 ,$GP

li $t6, 00000000000000000000000000011101
beq $t5, $t6 ,$SP

li $t6, 00000000000000000000000000011110
beq $t5, $t6 ,$FP

li $t6, 00000000000000000000000000011111
beq $t5, $t6 ,$RA


$Zero:
#Print out Register $0 in the output file
#5 bits

$AT:
#Print out Register $1 in the output file
#5 bits 

$V0:
#Print out Register $2 in the output file
#5 bits 

$V1:
#Print out Register $3 in the output file
#5 bits 

$A0:
#Print out Register $4 in the output file
#5 bits 

$A1:
#Print out Register $5 in the output file
#5 bits 

$A2:
#Print out Register $6 in the output file
#5 bits 

$A3:
#Print out Register $7 in the output file
#5 bits 

$T0:
#Print out Register $8 in the output file
#5 bits 

$T1:
#Print out Register $9 in the output file
#5 bits 

$T2:
#Print out Register $10 in the output file
#5 bits 

$T3:
#Print out Register $11 in the output file
#5 bits 

$T4:
#Print out Register $12 in the output file
#5 bits 

$T5:
#Print out Register $13 in the output file
#5 bits 

$T6:
#Print out Register $14 in the output file
#5 bits 

$T7:
#Print out Register $15 in the output file
#5 bits 

$S0:
#Print out Register $16 in the output file
#5 bits 

$S1:
#Print out Register $17 in the output file
#5 bits 

$S2:
#Print out Register $18 in the output file
#5 bits 

$S3:
#Print out Register $19 in the output file
#5 bits 

$S4:
#Print out Register $20 in the output file
#5 bits 

$S5:
#Print out Register $21 in the output file
#5 bits 

$S6:
#Print out Register $22 in the output file
#5 bits 

$S7:
#Print out Register $23 in the output file
#5 bits 

$T8:
#Print out Register $24 in the output file
#5 bits 

$T9:
#Print out Register $25 in the output file
#5 bits 

$K0:
#Print out Register $26 in the output file
#5 bits 

$K1:
#Print out Register $27 in the output file
#5 bits 

$GP:
#Print out Register $28 in the output file
#5 bits 

$SP:
#Print out Register $29 in the output file
#5 bits 

$FP:
#Print out Register $30 in the output file
#5 bits 

$RA:
#Print out Register $31 in the output file
#5 bits 

program_finished:
# Close the file 
  li $v0, 16       # system call for close file
  move $a0, $s0    # Restore fd
  syscall          # close file

  li $v0, 10 		# end the file
  syscall 
    
    
    
    
