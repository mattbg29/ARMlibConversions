# FileName: charNoLogical.s
# Author: Matthew Green
# Date: 11/01/2022
# Purpose: to determine if the user input is a character without using logical variables

.text
.global main
main:
    # Push
    SUB sp, sp, #4
    STR lr, [sp]

    # Prompt for and scan user input
    LDR r0, =prompt
    BL printf

    LDR r0, =format
    LDR r1, =input
    BL scanf

    LDR r1, =input
    LDR r1, [r1]

    # Check if r1 < 0x41, the smallest upper-case char,
    # and branch to notChar if so
    CMP r1, #0x41
    BLT notChar

    # Check if r1 <= 0x5a, the largest upper-case char,
    # and branch to isChar if so
    CMP r1, #0x5a
    BLE isChar

    # Check if r1 < 0x61, the smallest lower-case char, 
    # and branch to notChar if so
    CMP r1, #0x61
    BLT notChar

    # Check if r1 > 0x7a, the largest lower-case char, 
    # and branch to notChar if so
    CMP r1, #0x7a
    BGT notChar
   
    # User input is a character.  Print as such and branch to the end.
    isChar: 
        LDR r0, =outputIsChar
        BL printf
        B endMessage

    # User input is not a character.  Print as such.
    notChar:
        LDR r0, =outputNotChar
        BL printf
    
    endMessage:

    # Pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "Enter a letter or number\n"
    input: .word 0
    format: .asciz "%c"
    outputNotChar: .asciz "This is not a character\n"
    outputIsChar: .asciz "This is a character\n"
    
