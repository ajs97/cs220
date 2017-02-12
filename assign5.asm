.data
    fib : .word 20


.text
.globl main
.ent main

main:
    li $v0 , 5
    syscall
    move $s0 , $v0              # store input integer in $s0

    la $s1 , fib                # $s1 = address of fib array
    addi $t0 , $zero , 1

    blt $s0 , 1 , PRINT         # storing first element
    sw $t0 , ($s1)

    blt $s0 , 2 , PRINT         # storing second element
    sw $t0 , 4($s1)

    addi $s2 , $zero , 2        # $s2 act as counter (initialised to 2 here)

LOOP1:
    bge $s2 , $s0 , PRINT       # exit loop if $s2 >= n
    add $t0 , $s2 , -1
    add $t1 , $s2 , -2
    mul $t0 , $t0 , 4
    mul $t1 , $t1 , 4
    add $t2 , $s1 , $t0
    add $t3 , $s1 , $t1
    lw $t0 , ($t2)              # loading previous two elements from the memory
    lw $t1 , ($t3)
    add $t2 , $t0 ,$t1          # adding those two elements
    mul $t5 , $s2 , 4
    add $t3 , $s1 , $t5         # storing next element in the array
    sw $t2 , ($t3)
    addi $s2 , $s2 , 1          # increment the counter
    j LOOP1


PRINT:
    move $s2 , $zero            # $s2 act as counter (initialised to 0 here)
LOOP2:
    bge $s2 , $s0 , EXIT        # exit loop condition
    mul $t0 , $s2 , 4
    add $t1 , $s1 , $t0
    lw $a0 , ($t1)              # loading the respective element from the array
    li $v0 , 1                  # printing the integer
    syscall
    li $a0 , 32                 # printing space after each integer
    li $v0 , 11
    syscall
    addi $s2 , $s2 , 1          # increment counter
    j LOOP2

EXIT:
    li $v0 , 10
    syscall
.end main
