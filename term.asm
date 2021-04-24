.data
filePrompt: .asciiz "Enter the name of the file: "
inputFile: .space 100
textIn: .space 100
x: .word 0x014B4824
 
.text 

lw $s0, x                    
addiu $t0, $zero, 31           
li $t1, 1                     
sll $t1, $t1, 31            
li $v0, 1                   

loop: 

beq $t0, -1, stopLoop  
and $t3, $s0, $t1       
beq $t0, $0, printBit   
srlv $t3, $t3, $t0      

printBit: 
move $a0, $t3            
syscall                  
 
subi $t0, $t0, 1         
srl $t1, $t1, 1           
j loop 
  
stopLoop: 
#
sll $t4, $t1, 26

#
srl, $t5, $t1, 26

li $t3, 100000
beq $t4, $t1, Add #jump to and and find the register values
li $t3, 100010
beq $t4, $t1, Sub #jump to and and find the register values
li $t3, 000010
beq $t4, $t1, Srl
li $t3, 000000
beq $t4, $t1, Sll
li $t3, 100100
beq $t4, $t1, And
li $t3, 100101
beq $t4, $t1, Or
li $t3, 100111
beq $t4, $t1, Nor
li $t3, 101010
beq $t4, $t1, Slt

Add: 
#R format = 3 registers
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Sub:
#R format = 3 registers
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Srl: 
#R format = 2 registers & 1 constant
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Sll: 
#R format = 2 registers & 1 constant
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

And:
#R format = 3 registers
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Or:
#R format = 3 registers
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Nor: 
#R format = 3 registers
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Slt: 
#R format = 3 registers
#solve for registers by reoeating the value for jumping for each register
#found in bits 5 - 0

Beq: 
#R format = 2 registers & 1 Label
#solve for registers by reoeating the value for jumping for each register
#found in bits 31-29

Bne: 
#R format = 2 registers & 1 Label
#solve for registers by reoeating the value for jumping for each register
#found in bits 31-29




#INVALID CODE
#code used for reading and outputting a file
main:
  # Open (for reading) a file
  li $v0, 13       # system call for open file
  la $a0, fout     # output file name
  li $a1, 0        # flags
  syscall          # open a file (file descriptor returned in $v0)

  move $t0, $v0    # save file descriptor in $t0		
  
  
  # Read to file just opened  
  li $v0, 14       # system call for read to file
  la $a1, buffer   # address of buffer from which to write
  li $a2, 10       # hardcoded buffer length
  move $a0, $t0    # put the file descriptor in $a0		
  syscall          # write to file

  # Get the value from certain address

  la $a0, buffer #load the address into $a0

  li $v0, 4		# print the string out
  syscall  

  # Close the file 
  li $v0, 16       # system call for close file
  move $a0, $t0    # Restore fd
  syscall          # close file

  li $v0, 10 		# end the file
  syscall 


#INVALID CODE
#code to translate from binary to decimal
getNum:
li $v0,4        # Print string system call
la $a0,msg1         #"Please insert value (A > 0) : "
syscall

la $a0, empty
li $a1, 16              # load 16 as max length to read into $a1
li $v0,8                # 8 is string system call
syscall

la $a0, empty
li $v0, 4               # print string
syscall

li $t4, 0               # initialize sum to 0

startConvert:
  la $t1, empty
  li $t9, 16                # initialize counter to 16

firstByte:
  lb $a0, ($t1)      # load the first byte
  blt $a0, 48, printSum 
  addi $t1, $t1, 1          # increment offset
  subi $a0, $a0, 48         # subtract 48 to convert to int value
  beq $a0, 0, isZero
  beq $a0, 1, isOne
  j convert     # 

isZero:
   subi $t9, $t9, 1 # decrement counter
   j firstByte

 isOne:                   # do 2^counter 
   li $t8, 1               # load 1
   sllv $t5, $t8, $t9    # shift left by counter = 1 * 2^counter, store in $t5
   add $t4, $t4, $t5         # add sum to previous sum 

   move $a0, $t4        # load sum
   li $v0, 1              # print int
   syscall
   subi $t9, $t9, 1 # decrement counter
   j firstByte

convert:

printSum:
   srlv $t4, $t4, $t9
   la $a0, sumMsg
   li $v0, 4
   syscall

 move $a0, $t4      # load sum
 li $v0, 1      # print int
 syscall

exitProgram: li $v0, 10
syscall
