# FileName: findMaxOfThree.s
# Author: Matthew Green
# Date: 11/01/2022
# Purpose: to get three numbers from a user and return the largest, using the function
#          findMaxOf3 in libConversions

.text
.global main
main:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # prompt and scan 3 values from user
    LDR r0, =prompt1
    BL printf
    LDR r0, =format
    LDR r1, =num1
    BL scanf

    LDR r0, =prompt2
    BL printf
    LDR r0, =format
    LDR r1, =num2
    BL scanf

    LDR r0, =prompt3
    BL printf
    LDR r0, =format
    LDR r1, =num3
    BL scanf

    # load inputs and call findMaxOf3
    LDR r0, =num1
    LDR r0, [r0]
    LDR r1, =num2
    LDR r1, [r1]
    LDR r2, =num3
    LDR r2, [r2]
    BL findMaxOf3

    # move the function output (the largest number) to r1 and print the result
    MOV r1, r0
    LDR r0, =output
    BL printf 

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter the first number: "
    prompt2: .asciz "Enter the second number: "
    prompt3: .asciz "Enter the third number: "
    format: .asciz "%d"
    num1: .word 0
    num2: .word 0
    num3: .word 0
    output: .asciz "The largest number entered is: %d\n"
