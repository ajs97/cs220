.data
    binary : .space 33

.text
.globl main
.ent main

main:
    li $v0 , 5                      # input integer
    syscall
    add $s0 , $v0 , $zero           # store input integer in $s0

    la $s1 , binary                 # $s1 stores address of string
    sb $zero , 32($s1)              # adding null character at the end of string
    addi $t2 , $zero , -1           # $t2 = -1
    li $s2 , 31                     # $s2 will be counter to go from end of the string to start

LOOP:
    beq $s2 , $t2 , EXIT            # exit loop if reached at $s2=-1 (end of the string)
    divu $s0 , $s0 , 2              # divide by 2 (unsigned)
    mfhi $t0
    addi $t0 , $t0 , 48             # to get ascci char '0'/'1'
    add $t1 , $s1 , $s2
    sb $t0 , ($t1)                  # storing the byte in respective memory
    addi $s2 , $s2 , -1             # decrement counter ($s2)
    j LOOP

EXIT:
    add $a0 , $s1 , $zero           # print string
    li $v0 , 4
    syscall

    li $v0 , 10
    syscall
.end main
