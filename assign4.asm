.data
  minus:  .asciiz "-"
  plus:   .asciiz "+"
  dot:    .asciiz "."
  e:      .asciiz "e"
  n1:     .asciiz "N1 : "
  n2:     .asciiz "N2 : "
  d1:     .asciiz "D1 : "
  d2:     .asciiz "D2 : "
  result: .asciiz "RESULT : "
.text
.globl main
.ent main

main:
# taking inputs

  #To calculate q1
  la $a0 , n1
  li $v0 , 4              # print message
  syscall
  li $v0 , 7              # input n1
  syscall
  mov.d $f2 , $f0         # store n1 in $f2

  la $a0 , d1
  li $v0 , 4              # print message
  syscall
  li $v0 , 7              # input d1
  syscall
  mov.d $f4 , $f0         # store d1 in $f4

  div.d $f2 , $f2 , $f4   # store q1=n1/d1 in $f2

  #To calculate q2
  la $a0 , n2
  li $v0 , 4              # print message
  syscall
  li $v0 , 7              # input n2
  syscall
  mov.d $f4 , $f0         # store n2 in $f4

  la $a0 , d2
  li $v0 , 4              # print message
  syscall
  li $v0 , 7              # input d2
  syscall
  mov.d $f6 , $f0         # store d2 in $f6

  div.d $f4 , $f4 , $f6   # store q2=n2/d2 in $f4

  add.d $f12 , $f2 , $f4  # store q=q1+q2 in $f12

  la $a0 , result
  li $v0 , 4              # print message
  syscall

  li.d $f0 , 0.0
  c.le.d  $f0 , $f12
  bc1t L1                 # go to L1 if value is non-negative
  la $a0 , minus
  li $v0 , 4              # print -
  syscall
  abs.d $f12 , $f12       # store |q| in $f12
  L1:

    li.d $f0 , 100.0
    c.lt.d  $f0 , $f12
    bc1t L2               #go to L2 if q>100
      li.d $f4 , 100000000.00
      mul.d $f12 , $f12 , $f4  #adding bias of 8
      cvt.w.d $f0 , $f12
      mfc1 $a0 , $f0        #store floor(q) in $a0

      jal func              #$a0 is passed as an argument
      sub $v0 , $v0 , 8    #removing bias of 8
      j END

    L2:
      cvt.w.d $f0 , $f12
      mfc1 $a0 , $f0        #store floor(q) in $a0

      jal func              #$a0 is passed as an argument

    END:
        bgez $v0 , L3
        add $a0 , $v0 , $zero
        li $v0 , 1
        syscall
        j EXIT

        L3:
          la $a0 , plus
          li $v0 , 4              # print +
          syscall

          add $a0 , $v0 , $zero
          li $v0 , 1
          syscall

  EXIT:

  li $v0 , 10
  syscall
.end main

.globl func
.ent func

#input : An tnteger(atleast 3 digits) [$a0]
#return value : number of digits - 1
func:

  li $t0 , 0            # $t0 = i is loop counter (initialised here)
  add $t1 , $a0 , $zero # $t1 = $a0
  add $s0 , $a0 , $zero # save integer in $s0
  li $t2 , 1            # $t2 = 10^i
loop:
  div $t1 , $t1 , 10
  add $t0 , $t0 , 1     # increment counter
  mul $t2 , $t2 , 10
  bnez $t1  , loop      # exit if $t1=0
 # $t0=number of digits
  div $t2 , $t2 , 10
  div $a0 , $s0 , $t2   # store first digit in $a0

  li $v0 , 1
  syscall               # print first digit
  la $a0 , dot
  li $v0 , 4            # print .
  syscall

  div $t2 , $t2 , 100
  div $a0 , $s0 , $t2
  rem $a0 , $a0 , 100
  li $v0 , 1
  syscall               # print two digits after decimal place

  la $a0 , e
  li $v0 , 4            # print e
  syscall

  sub $v0 , $t0 , 1       #store return value in $v0

  jr $ra
.end func
