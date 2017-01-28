.data


.text
.globl main
.ent main

main:
    li $v0 , 5              # input integer x
    syscall
    add $s0 , $v0 , $zero   # store x in $s0

    li $v0 , 5              # input integer y
    syscall
    add $s1 , $v0 , $zero   # store y in $s1

    mul $t0 , $s0 , -5      # $t0 = $s0 * -5  [$t0 = -5 * x]
    mul $t1 , $s1 , -7      # $t1 = $s1 * -7  [$t1 = -7 * y ]
    add $s2 , $t0 , $t1     # $s2 = $t0 + $t1 [u = -5 * x  +  -7 * y]

    slti $t0 , $s2 , -35    # if u($s2) < -35
    bne $t0 , $zero , L1    # go to L1

    slti $t0 , $s2 , 35     # if u($s2) not < 35
    beq $t0 , $zero , L2    # go to L2

    add $a0 , $s2 , $zero   # else $a0 = u($s2)
    j EXIT                  # go to exit

L1:
    li $a0 , -35            # set $a0 (output) = -35
    j EXIT
L2:
    li $a0 , 35             # set $a0 = 35
    j EXIT
EXIT:
    li $v0 , 1              # print output ($a0)
    syscall

    li $v0 , 10
    syscall
.end main
