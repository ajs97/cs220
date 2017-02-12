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

ELOOP1:
    li $v0 , 10
    syscall
.end main
