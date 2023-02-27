# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"
	space: .asciiz " "

.text
printA:
    # TODO: Write your function code here
	move $t0, $a0
	sub $t1, $a1, 1
	li $t2, 0

loop:
	slt $t3, $t1, $t2
	bne $t3, $zero, loop_exit
	sll $t4, $t1, 2
	add $t5, $t0, $t4
	lw $t6, 0($t5)
	li $v0, 1
	move $a0, $t6
	syscall
	li $v0, 4
	la $a0, space
	syscall
	sub $t1, $t1, 1
	j loop

loop_exit:
	jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printA

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
    syscall
