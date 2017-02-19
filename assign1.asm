.data
.text
.globl main
.ent main

main:
    li $v0 , 5              # input integer x
    syscall
    add $a0 , $v0 , $zero   # store x in $a0

    li $v0 , 5              # input integer y
    syscall
    add $a1 , $v0 , $zero   # store y in $a1

    jal func                # function call
    add $a0 , $v0 , $zero   # store output of func in ($a0)
    li $v0 , 1              # print output ($a0)
    syscall

    li $v0 , 10
    syscall
.end main

.globl func
.ent func
func:

mul $t0 , $a0 , -5      # $t0 = $a0 * -5  [$t0 = -5 * x]
mul $t1 , $a1 , -7      # $t1 = $a1 * -7  [$t1 = -7 * y ]
add $v0 , $t0 , $t1     # $v0 = $t0 + $t1 [u = -5 * x  +  -7 * y]

slti $t0 , $v0 , -35    # if u($v0) < -35
bne $t0 , $zero , L1    # go to L1

slti $t0 , $v0 , 35     # if u($v0) not < 35
beq $t0 , $zero , L2    # go to L2

                        # else output u($v0)
j EXIT                  # go to exit

L1:
li $v0 , -35            # set $v0 (output) = -35
j EXIT
L2:
li $v0 , 35             # set $v0 (output) = 35
j EXIT

EXIT:
  jr $ra
.end func
