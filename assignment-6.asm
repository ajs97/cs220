.data
  array : .space 80          #Maximum 20 elements this array

.text
.globl main
.ent main

main:
#Taking inputs

  li $v0 , 5              # input N
  syscall
  add $s4, $v0, $zero     #$s0 store the value of no. of elements in the array
  sll $a0, $s4, 2

  jal readelements
  move $a0, $s4
  jal sort
  li $t0, 0
  sll $t3 , $s4 , 2
print:
  beq $t0, $t3, exit
  lw $a0, array($t0)
  li $v0, 1
  syscall
  add $t0, $t0, 4
  j print
exit:

  li $v0 , 10
  syscall
.end main

.globl readelements
.ent readelements

readelements:
    li $t0 , 0
Loop1:
    beq $t0,$a0,done
    li $v0 , 5
    syscall
    sw $v0, array($t0)
    add $t0, $t0, 4
    j Loop1
done:
    jr $ra
.end readelements

.globl sort
.ent sort
  sort:
  add $s0, $a0, $zero
  li $t0, 0
  la $s6 , array
  loop1:
    beq $t0, $s0, exit1
    li $t1, 0
    addi $t4 , $s0 , -2
    loop2:
      beq $t1, $t4, EXIT
      mul $t2, $t1, 4
      add $t3, $t2, 4
      add $t5 , $s6 , $t2
      lw $t5, ($t5)
      add $t6 , $s6 , $t3
      lw $t6, ($t6)
      bgt $t5, $t6, call
      add $t1, $t1, 1
      j loop2
      call:
      la $a0, array($t2)
      add $a1, $a0, 4
      jal swap
      addi $t1, $t1, 1
      j loop2

    EXIT:
      addi $t0, $t0, 1
      j loop1
exit1:
      jr $ra
.end sort

.globl swap
.ent swap
  swap:
        lw $t0, ($a0)
        lw $t1 , ($a1)
        sw $t0 , ($a1)
        sw $t1, ($a0)
        jr $ra
.end swap
