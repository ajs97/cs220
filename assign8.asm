.data
<<<<<<< HEAD
rowsize1:   .word 4
rowsize2:   .word 2
FirstArray: .double 1.0,1.0,1.0,1.0
            .double 1.0,1.0,1.0,1.0
            .double 1.0,1.0,1.0,1.0
            .double 1.0,1.0,1.0,1.0
SecondArray:  .double 1.0,1.0
              .double 1.0,1.0
              .double 1.0,1.0
              .double 1.0,1.0
=======

Newline:     .asciiz   "\n"
Space:       .asciiz   "\t"

nrows1:   .word 4
ncols1:   .word 4

FirstArray: .double 1.0,2.0,3.0,4.0
            .double 6.0,7.0,8.0,9.0
            .double 11.0,12.0,12.0,4.0
            .double 15.0,16.0,17.0,18.0

nrows2:   .word 4
ncols2:   .word 2

SecondArray:  .double 1.0,3.0
              .double 4.0,6.0
              .double 8.0,9.0
              .double 10.0,11.0
>>>>>>> 0fb51202b1c312c756e2741e5124a4fd7f4382aa
ResultArray: .double  0.0

DATASIZE = 8

.text
.globl main
main:
  la $s0, FirstArray                    #load the base address of 1st array
  la $s1, SecondArray                   #     ""
  la $s2, ResultArray                   #     ""
  la $s3, Space
  la $s4, Newline
  lw $t0, nrows1                      #nrows in 1st array
  lw $t1, nrows2                      #      ""
  lw $t2, ncols1                      #ncols in 1st array
  lw $t3, ncols2                      #      ""

  li $t4, 0
  loop1:
    beq $t4,  $t0,  exit1               #$t4=i=0..(nrows1-1)
    li $t5, 0
      loop2:
        beq $t5, $t3, exit2             #$t5=j=0..(ncols2-1)
        li $t6, 0
        li.d $f0, 0.0                    #sum
          loop3:
            beq $t6, $t2, exit3         #$t6=k=0..(ncols1-1)

            mul $t7, $t4, $t2
            add $t7, $t7, $t6
            mul $t7, $t7, DATASIZE
            add $t7, $t7, $s0

            l.d $f4, ($t7)

            mul $t8, $t6, $t3
            add $t8, $t8, $t5
            mul $t8, $t8, DATASIZE
            add $t8, $t8, $s1

            l.d $f6, ($t8)

            mul.d $f2,  $f4,  $f6
            add.d $f0, $f0, $f2

            add $t6, $t6, 1
            j loop3
          exit3:
          s.d $f0, ($s2)
          add $s2, $s2, DATASIZE
        add $t5, $t5, 1
        j loop2
        exit2:


    add $t4, $t4, 1
    j loop1
    exit1:

    la $s2, ResultArray
    li $t4, 0
    L1:
      beq $t4,  $t0,  esc1               #$t4=i=0..(nrows1-1)
      li $t5, 0
        L2:
          beq $t5, $t3, esc2             #$t5=j=0..(ncols2-1)

          li $v0, 3             # print (i,j)th element
          l.d $f12, ($s2)
          syscall

<<<<<<< HEAD
    li $v0, 3
    syscall
    addi $t0 , $t0 ,1
    b print
    exit:
=======
          move $a0, $s3         # print space
          li $v0, 4
          syscall

          add $s2, $s2, DATASIZE
        add $t5, $t5, 1
        j L2
        esc2:

        move $a0, $s4
        li $v0, 4
        syscall
    add $t4, $t4, 1
    j L1
    esc1:
>>>>>>> 0fb51202b1c312c756e2741e5124a4fd7f4382aa


  li $v0, 10
  syscall
.end main
