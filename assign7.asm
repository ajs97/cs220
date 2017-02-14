.data
    array: .word 1, 3, 5, 5 , 5, 45, 47, 47, 123, 1234  #array

.text

.globl main
.ent main
main:
    la $s0 , array
    li $s1 , 10                     # size of the array

    li $v0 , 5                     # input the key to be searched
    syscall
    move $s2 , $v0

    move $a0 , $s0                 # arguments : $a0 = array , $a1 = length of the array , $a2 = key
    move $a1 , $s1
    move $a2 , $s2
    jal BS                          # call BS($a0 , $a1 , $a2)

    move $a0 , $v0                  # print return value of BS
    li $v0 , 1
    syscall

    li $v0 , 10
    syscall
.end main

.globl BS
.ent BS
BS:                                 # BS function which we will call recursively : BS(array start address , length of array , key)
    beqz $a1 , L0                   # if array is empty
    li $t0 , 1
    beq $a1 , $t0 , L1              # if length==1

    divu $s0, $a1 , 2               # middle element

    mul $t0 , $s0 , 4
    add $t1 , $a0 , $t0
    lw $s1 , ($t1)                  # $s1 = value of middle element

    bgt $a2 , $s1 , BIG             # if key > $s1

    addi $sp , $sp , -8             #else
    sw $s0 , ($sp)
    sw $ra , 4($sp)
    bne $s1 , $a2 , NEQ             # if key != $s1
    addi $t0 , $s0 , 1              # $a1 = $s0 + 1 (taking the $s0 th element)
    move $a1 , $t0
    NEQ:
    move $a1 , $s0                  # $a1 = $s0 (not taking the $s0 th element)
    jal BS                          # call BS( $a0 , $a1 , key )
    lw $s0 , ($sp)
    lw $ra , 4($sp)
    addi $sp , $sp , 8
    j EXITBS

    L0:
        li $v0 , 0                  # key not found : return 0
        j EXITBS

    L1:
        lw $s1 , ($a0)
        li $v0 , 0                  # key not found : return 0
        bne $s1 , $a2 ,POS
        li $v0 , 1                  # key found : return 1
        POS:
        j EXITBS

    BIG:
        addi $sp , $sp , -8
        sw $s0 , ($sp)
        sw $ra , 4($sp)
        mul $t0 , $s0 , 4
        add $t1 , $a0 , $t0
        addi $t1 , $t1 , 4
        move $a0 , $t1
        sub $t0 , $a1 , $s0
        addi $t0 , $t0 , -1
        move $a1 , $t0
        jal BS                      # call BS( $a0 + $s0 + 1 , len - $s0 -1 , key )
        lw $s0 , ($sp)
        lw $ra , 4($sp)
        addi $sp , $sp , 8
        beqz $v0 , NOTF
        add $v0 , $v0 , $s0         # key found : return (BS( $a0 + $s0 + 1 , len - $s0 -1 , key ) + $s0 + 1) [giving offset for the output ]
        addi $v0 , $v0 , 1
        NOTF:                       # key not found : return BS( $a0 + $s0 + 1 , len - $s0 -1 , key ) [which is zero]
        j EXITBS


    EXITBS:
        jr $ra
.end BS
