.data
  result: .space 100
.text
.globl main
.ent main

main:
  la $a0 , result 

  #To calculate q1

  li $v0 , 7              # input n1
  syscall
  mov.d $f2 , $f0         # store n1 in $f2

  li $v0 , 7              # input d1
  syscall
  mov.d $f4 , $f0         # store d1 in $f4

  div.d $f2 , $f2 , $f4   # store q1=n1/d1 in $f2

  #To calculate q2
  li $v0 , 7              # input n2
  syscall
  mov.d $f4 , $f0         # store n2 in $f4

  li $v0 , 7              # input d2
  syscall
  mov.d $f6 , $f0         # store d2 in $f6

  div.d $f4 , $f4 , $f6   # store q2=n2/d2 in $f4

  add.d $f12 , $f2 , $f4  # store q=q1+q2 in $f12




  li $v0 , 10
  syscall
.end main
