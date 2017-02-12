.data
  array : .space 80          #Maximum 20 elements this array

.text
.globl main
.ent main

main:
#Taking inputs

  li $v0 , 5              # input N
  syscall
  add $s0, $v0, $zero     #$s0 store the value of no. of elements in the array
  sll $s0, $s0, 2

  li $t0, 0
  jal readelements
  li $t0, 0
  jal print
  div $a0, $s0, 4
  jal sort
  li $t0, 0
  jal print


  li $v0 , 10
  syscall
.end main

readelements:
  beq $t0,$s0,done
  li $v0 , 5
  syscall
  sw $v0, array($t0)
  add $t0, $t0, 4
  b readelements
done:
  jr $ra


print:

  beq $t0, $s0, done
  lw $a0, array($t0)
  li $v0, 1
  syscall
  add $t0, $t0, 4
  b print


.globl sort
.ent sort
  sort:
  add $s0, $a0, $zero
  li $t0, 0
  loop1:
    beq $t0, $s0, done
    li $t1, 0

    loop2:
      beq $t1, $s0, exit
      mul $t2, $t1, 4
      add $t3, $t2, 4
      lw $t5, array($t2)
      lw $t6, array($t3)
      bgt $t6, $t5, call
      add $t1, $t1, 4
      j loop2
      call:
      la $a0, array($t2)
      jal swap
      addi $t1, $t1, 1
      j loop2

    exit:
      addi $t0, $t0, 1
      j loop1

      jr $ra
.end sort

.globl swap
.ent swap
  swap:
        lw $t0, ($a0)
        add $a1, $a0, 4
        sw ($a1), ($a0)
        sw $t0, ($a1)
        jr $ra
.end swap
