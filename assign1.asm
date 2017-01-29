.data
    input: .space 1000              # allocate memory to store input string

.text
.globl main
.ent main

main:
    la $a0 , input                  # $a0 stores address of string
    li $a1 , 1000
    li $v0 , 8                      # read string
    syscall

    li $s0 , 0                      # $s0 is loop counter (initialised here)
Loop:
    add $s1 , $s0 , $a0             # $s1 = address of current character
    lb $s2 , 0($s1)                 # $s2 = ASCII value of the character

    beq $s2 , $zero , EXIT          # exit loop if null character is found

    slti $t0 , $s2 , 123            # current char < 'z'
    beq $t0 , $zero , L1            # go to L1 if not

    slti $t1 , $s2 , 97             # current char < 'a'
    bne $t1 , $zero , L1            # go to L1 if true

    addi $t2 , $s2 , -32            # convert to upper case
    sb $t2 , 0($s1)                 # store converted in memory

L1:
    addi $s0 , $s0 , 1              # increment counter
    j Loop                          # loop

EXIT:
    li $v0 , 4                      # print (converted)  string
    syscall

    li $v0 , 10
    syscall
.end main
