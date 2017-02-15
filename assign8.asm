.data
rowsize1:   .word 4
rowsize2:   .word 2
FirstArray: .double 1.0,2.0,3.0,4.0
            .double 6.0,7.0,8.0,9.0
            .double 11.0,12.0,12.0,4.0
            .double 15.0,16.0,17.0,18.0
SecondArray:  .double 1.0,3.0
              .double 4.0,6.0
              .double 8.0,9.0
              .double 10.0,11.0
ResultArray: .double  0.0

DATASIZE = 8

.text
.globl main
main:
  la $a0, FirstArray                    #load the base address of 1st array
  la $a1, SecondArray                   #""
  la $a2, ResultArray                   #""
  lw $t0, rowsize1                      #row size of 1st array
  addi $t0, $t0, -1
  lw $t1, rowsize2                      #""
  addi $t1, $t1, -1
  li $t2, 3                             #col size 1 - 1
  li $t3, 3                             #col size 2 - 1


  li $t4, 0
  loop1:
    beq $t4,  $t0,  exit1               #i
    li $t5, 0
      loop2:
        beq $t5, $t1, exit2             #j
        li $t6, 0
        li.d $f0, 0.0                    #sum
          loop3:

            beq $t6, $t3, exit3         #k
            mul $t7, $t4, 4
            add $t7, $t7, $t6
            mul $t7, $t7, DATASIZE
            add $t7, $t7, $a0

            l.d $f4, ($t7)

            mul $t8, $t6, 2
            add $t8, $t8, $t5
            mul $t8, $t8, DATASIZE
            add $t8, $t8, $a1

            l.d $f6, ($t8)

            mul.d $f2,  $f4,  $f6
            add.d $f0, $f0, $f2

            add $t6, $t6, 1
            b loop3
          exit3:
          s.d $f0, ($a2)
          add $a2, $a2, DATASIZE
        add $t5, $t5, 1
        b loop2
        exit2:
    add $t4, $t4, 1
    b loop1
    exit1:

  la $a2, ResultArray
  li $t0, 1
  print:
    beq $t0, 8, exit
    l.d $f12, ($a2)
    add $a2, DATASIZE

    li $v0, 3
    syscall

    b print
    exit:


  li $v0, 10
  syscall
.end main
