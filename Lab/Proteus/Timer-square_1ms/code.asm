ASSUME CS:CODE,  DS:DATA

 DATA SEGMENT
	COUNTER0 EQU 69H
	COUNTER1 EQU 6BH
	COUNTER2 EQU 6DH
	CWR EQU 6FH
DATA ENDS

CODE SEGMENT
     MOV AX, DATA
     MOV DS, AX
    ORG 0000H

START:
    ; --> Square Wave :: MOD 3 of 8253
	MOV AL, 10110111b	; 10 [counter 2], 11[ 2 byte data], 011 [ with mod 3], 1 [BCD]
	OUT  CWR, AL		; configure the counter 2 of 8253
	
    MOV AL, 0D0h		
	OUT COUNTER2, AL		; Send first byte of Counter 2
	MOV AL, 07h		
	OUT COUNTER2, AL		; Send second byte of Counter 2
	
ENDLESS:
        JMP ENDLESS
CODE    ENDS
        END START
