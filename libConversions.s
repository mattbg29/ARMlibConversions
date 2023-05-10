# FileName: libConversions.s
# Author: Matthew Green
# Date: 11/01/2022
# Purpose: Function for use on Module 9 assignment

.global findMaxOf3

###########################
# Function: findMaxOf3
# Purpose: to find the max of 3 input numbers
# Input: r0, r1, r2: 3 numbers to compare
# Output: r0 - a pointer to the largest number that was input

.text 
findMaxOf3:
    # push and store r4, r5, r6 so that we can safely use these for our inputs
    SUB sp, sp, #16
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #12]

    # safely store r0, r1, r2 into r4, r5, r6
    MOV r4, r0
    MOV r5, r1
    MOV r6, r2

    # compare r4 to r5 and r4 to r6; if r4 is bigger than both, r4 is the largest
    # else, have to compare r5 to r6
    MOV r0, #0
    CMP r4, r5
    ADDGT r0, #1 // r0 = 1 if r4 > r5

    MOV r1, #0
    CMP r4, r6
    ADDGT r1, #1 // r1 = 1 if r4 > r6

    AND r1, r1, r0 // r1 = 1 if both r0 and r1 = 1, eg if r4 is bigger than r5 and r6
    MOV r2, #1
    CMP r1, r2
    BEQ r4Largest // if r1 = 1, r4 is the largest

    # Once here, r4 is not the largest, so we need to compare r5 and r6
    CMP r5, r6
    BGT r5Largest 
    
    	# r6 is the largest
	MOV r0, r6
	B endIf

    # r4 is the largest
    r4Largest:
        MOV r0, r4
        B endIf

    # r5 is the largest
    r5Largest:
        MOV r0, r5

    endIf:

    # pop
    LDR lr, [sp] 
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    LDR r6, [sp, #12]
    ADD sp, sp, #16
    MOV pc, lr

.data

#END findMaxOf3
