# FileName: charLogical.s
# Author: Matthew Green
# Date: 11/01/2022
# Purpose: to determine if the user input is a character using logical variables

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

    # Check if input is within the range of uppercase letters, 0x41 to 0x5a
    MOV r2, #0
    CMP r1, #0x41
    ADDGE r2, #1 // sets r2 = 1 if r1 >= 0x41

    MOV r3, #0
    CMP r1, #0x5a
    ADDLE r3, #1 // sets r3 = 1 if r1 <= 0x5a

    AND r3, r3, r2 // sets r3 = 1 if both r2 and r3 are 1

    # Check if input is within the range of lowercase letters,, 0x61 to 0x7a
    MOV r0, #0
    CMP r1, #0x61
    ADDGE r0, #1 // sets r0 = 1 if r1 >= 0x61

    MOV r2, #0
    CMP r1, #0x7a
    ADDLE r2, #1 // sets r2 = 1 if r1 <= 0x7a

    AND r2, r2, r0 // sets r2 = 1 if both r0 and r2 are 1

    # Check if letter is either upper or lower case
    ORR r2, r2, r3 // sets r2 = 1 if either r2 or r3 is 1

    # Branch to notChar label if not a char to print one statement, else print another statement
    CMP r2, #0 
    BEQ notChar // r2 will equal 0 when the ORR above resulted in 0, ie the letter is neither upper or lower case

	# User input is a character
        LDR r0, =outputIsChar
        BL printf
        B endMessage

    # User input is not a character
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
    
