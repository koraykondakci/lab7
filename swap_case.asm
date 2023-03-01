# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

# DO NOT MODIFY THE MAIN PROGRAM
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
    move $s0, $a0

    addiu $sp, $sp, -24
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $ra, 20($sp)

    li $s1, 0
    move $s2, $a0
    add $s3, $s1, $s2
    lbu $s0, 0($s3)
    li $s4, 4

loop:
    beq $s0, $zero, loopEnd 

    # if letter is upper case
    li $t3, 65  # t3 = 'A'
    li $t4, 90  # t4 = 'Z'
    sge $t5, $s0, $t3         
    sle $t6, $s0, $t4         
    and $t7, $t5, $t6,        
    bne $t7, $zero, isUpper     
    
    # if letter is lower case
    li $t3, 97   # t3 = 'a'
    li $t4, 122  # t4 = 'z'
    sge $t5, $s0, $t3         
    sle $t6, $s0, $t4         
    and $t7, $t5, $t6,        
    bne $t7, $zero, isLower     

notLetter:
    j goToNext

isUpper:
    li $v0, 11
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    addiu $s0, $s0, 32
    sb $s0, 0($s2) 
    li $v0, 11
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    jal ConventionCheck
    j goToNext

isLower:
    li $v0, 11
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    addiu $s0, $s0, -32
    sb $s0, 0($s2) 
    li $v0, 11
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    jal ConventionCheck
    j goToNext

goToNext:
    addi $s1, $s1, 1
    add $s2, $s1, $s3
    lbu $s0, 0($s2)
    j loop
    
loopEnd:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $ra, 20($sp)
    addiu $sp, $sp, 24
    
    # Do not remove this line - it should be the last line in your function code
    jr $ra