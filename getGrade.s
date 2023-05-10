# FileName: getGrade.s
# Author: Matthew Green
# Date: 11/01/2022
# Purpose: to get a user's name and grade average and print their 
#          name and letter grade, or error if out of 0-100 bounds

.text
.global main
main:
    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # prompt for and scan user's name
    LDR r0, =prompt1
    BL printf

    LDR r0, =format1
    LDR r1, =name
    BL scanf

    # prompt and scan user's average
    LDR r0, =prompt2
    BL printf

    LDR r0, =format2
    LDR r1, =avg
    BL scanf
    
    # check if average is < 0 or > 100 and branch to error if so
    LDR r1, =avg
    LDR r1, [r1]
    MOV r0, #0
    CMP r1, r0
    BLT errorMsg

    MOV r0, #100
    CMP r1, r0
    BGT errorMsg

        # grade is valid; output the user's name, 
        # then output the letter grade depending on the grade average
        LDR r0, =outputName
        LDR r1, =name
        BL printf

        LDR r1, =avg
        LDR r1, [r1]

        # if the grade is > 90, branch to the msg saying the student gets an A
        MOV r0, #90
        CMP r1, r0
        BGE aMSG

        # if the grade is > 80, branch to the msg saying the student gets a B
        MOV r0, #80
        CMP r1, r0
        BGE bMSG

        # if the grade > 70, branch to the msg saying the student gets a C
        MOV r0, #70
        CMP r1, r0
        BGE cMSG

	# any other grade, the student gets an F.  print this out and branch to endIf
    	LDR r0, =fGrade
    	BL printf
    	B endIf

        # after printing the respective message, branch to endIf
    	cMSG:
            LDR r0, =cGrade
            BL printf
            B endIf

   	bMSG:
            LDR r0, =bGrade
            BL printf
            B endIf
    
    	aMSG:
            LDR r0, =aGrade
            BL printf
            B endIf
    
    # the score is either less than 0 or greater than 100; print an error message
    errorMsg:
        LDR r0, =outputError
        BL printf

    endIf:

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter your name: "
    prompt2: .asciz "Enter your grade average: "
    name: .space 40
    avg: .word 0
    format1: .asciz "%s"
    format2: .asciz "%d"
    outputName: .asciz "Your name is %s."
    outputError: .asciz "Error, grade average should be between 0 and 100\n"
    fGrade: .asciz " Your grade is F.\n"
    cGrade: .asciz " Your grade is C.\n"
    bGrade: .asciz " Your grade is B.\n"
    aGrade: .asciz " Your grade is A.\n"
