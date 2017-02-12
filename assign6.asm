.data
    array: .word 1

.text
.globl main
.ent main

main:
    li $v0 , 5
    syscall
    move $s0 , $v0
    la $s1 , array
    li $t0 , 0
LOOP1:
    bge $t0 , $s0 , ELOOP1
    li $v0 , 5
    syscall
    mul $t1 , $t0 , 4
    add $t2 , $s1 , $t1
    sw $v0 , ($t2)
    addi $t0 , $t0 , 1
    j LOOP1
ELOOP1:

    move $a0 , $s0
    move $a1 , $s1
    jal sort

    move $t0 , $zero            # $t0 act as counter (initialised to 0 here)
LOOP2:
    bge $t0 , $s0 , ELOOP2        # exit loop condition
    mul $t1 , $t0 , 4
    add $t2 , $s1 , $t1
    lw $a0 , ($t2)              # loading the respective element from the array
    li $v0 , 1                  # printing the integer
    syscall
    li $a0 , 32                 # printing space after each integer
    li $v0 , 11
    syscall
    addi $t0 , $t0 , 1          # increment counter
    j LOOP2
ELOOP2:

    li $v0 , 10
    syscall
.end main

.globl sort
.ent sort
sort:
    li $s4 , 1
    ble $a0 , $s4 , ELOOP3
LOOP3:
    bge $s4 , $a0 , ELOOP3
    addi $s3 , $a0 , -1
    li $s5 , 0
    LOOP4:
        bge $s5 , $s3 , ELOOP4
        mul $t2 , $s5 , 4
        addi $t3 , $t2 , 4
        add $t2 , $a1 , $t2
        add $t3 , $a1 , $t3
        lw $t4 , ($t2)
        lw $t5 , ($t3)
        ble $t4 , $t5 , noswap

        addu $sp , $sp , -4
        sw $ra , ($sp)
        move $a2 , $t2
        move $a3 , $t3
        jal swap
        lw $ra , ($sp)
        addu $sp , $sp , 4

    noswap:
        addi $s5 , $s5 , 1
        j LOOP4
    ELOOP4:
    addi $s4 , $s4 , 1
    j LOOP3
ELOOP3:
    jr $ra
.end sort

.globl swap
.ent swap
swap:
        lw $t0, ($a2)
        lw $t1 , ($a3)
        sw $t0 , ($a3)
        sw $t1, ($a2)
        jr $ra
.end swap
