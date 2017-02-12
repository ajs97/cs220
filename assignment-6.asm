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
  jal BubbleSort
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


BubbleSort:
  li $t0, 8
  loop1:
    beq $t0, $s0, done
    li $t1 4
    mul $t4, $t0, 4
    sub $s1, $s0, $t4     #check tihs line trying to do $s1= $s0-$t0*4
    loop2:
      beq $t1, $s1, exit
      sub $t2, $t1, 4
      lw $t5, array($t2)
      lw $t6, array($t1)
      bgt $t5, $t6, swap
      add $t1, $t1, 4
      j loop2

    exit:
      addi $t0, $t0, 4
      j loop1

      swap:
        lw $t5, array($t2)
        lw $t6, array($t1)
        sw $t5, array($t1)
        sw $t6, array($t2)
        add $t1, $t1, 4
        j loop2
