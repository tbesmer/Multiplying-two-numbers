# this program prints out the maximum of two numbers 
# The two numbers are read through the keyboard 
.text
.globl main

main:
# Display primpt1
li $v0, 4
la $a0, prompt1
syscall

li $v0, 5 # read keyboard into $v0 (number x is number to test)
syscall

move $t0,$v0 # move the first number from $v0 in $t0

# Display the prmopt2 (string)
li $v0, 4
la $a0, prompt2
syscall

# read keyboard into $v0 
li $v0, 5 
syscall

# move the second number from $v0 in $t1
move $t1,$v0 

	# $t0 - Multiplier 
	
	# $t1 -  Multiplicand
	
	# $t7 - Result we have to change this later
	
	# $t4 - The mask for the right bit
	
	# $t3 - The LSB of the multiplier


li $t7, 0	# Initialize the result so tjat we are sure it is zero, Also helps with 0 multiples
li $t4, 1	# a 1 Register
li $t3, 0	# Initialize the LSB resultso that we are sure it is zero

Loop:
	beq $t1, $zero, End_State	# If the multiplier is zero we finished because the answer is zero
	
	and $t3, $t4, $t1			# Get the LSB
	
	beq $t3, 1, Add_A_To_C	# If the LSB is not zero, and thus 1, we add the multiplicand to the result
	
	beq $t3, 0, Shift	# If the LSB is zero, thus we only need to do shifts 

	Add_A_To_C: 
	
			addu $t7, $t7, $t0		

	Shift:
	
		sll $t0, $t0, 1			# Shift left the multiplicand
		
		srl $t1, $t1, 1			# Shift right the multiplier

j Loop			# Back to the loop

	End_State:
# Return in $t7 

 
move $s7, $t7 #Move the answer to s7 because temp regs aren't guarrentied to not change on syscalls


L1: 
li $v0, 4 
la $a0, answer
syscall


# print integer function call 1 
# put the answer into $a0
li $v0, 1 
move $a0, $s7
syscall

#exit
end: li $v0, 10 
syscall 
 
.data
prompt1:
 .asciiz "Enter the first number: "
prompt2:
 .asciiz "Enter the second number: "
answer:
 .asciiz "The producd of those numbers is: "
