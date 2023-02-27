# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text

conv:
    # TODO: Write your function code here
    # a0 = x, a1 = y, v0 = z, t0 = i
    li $v0, 0
    li, $t0, 8

loop:
    beq $t0, $zero, done
    sll $t1, $a0, 3
    sub $v0, $v0, $t1
    add $v0, $v0, $a1
    slt $t2, $a0, 2
    bne $t2, $zero, loop
    sub $a1, $a1, 1
    addi $a0, $a0, 1
    addi $t0, $t0, -1
    j loop

done:
    jr $ra


main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall
