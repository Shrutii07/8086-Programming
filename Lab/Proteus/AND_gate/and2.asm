 DATA SEGMENT		; FULL SEGMENT DEFINITION
 PORTA EQU 60H
 PORTB EQU 62H
 PORTC EQU 64H
 CWR EQU 66H
 DATA ENDS
 
CODE    SEGMENT 
   MOV AX,DATA
   MOV DS,AX
   ORG 0000H

START:
    MOV AL,82H		; PORT A OUTPUT. PORT B INPUT, MODE 0
    MOV DX,CWR		; SETTING CONTROL REGISTER
    OUT DX,AL
    
   L1:
   MOV DX,PORTB
   IN AL,DX
   AND AL, 11000000B    ; DISCARDING INPUTS FROM A0-A5
   CMP AL, 11000000B	; COMPARING WITH 11000000B, ONLY CASE OF LED ON
   JZ LEDON			; LED ON IF EQUAL AS 
   MOV DX,PORTA		;ADDRESS OF PORT A
   MOV AL, 00H		; ALL BITS ZERO
   OUT DX,AL			; OUTPUT AT PORT A
   JMP L1				; JUMP FOR CONTINUOUS OPERATION
   
   LEDON:
   MOV DX, PORTA
   MOV AL, 80H		; SETTING 7TH BIT ONE AND REST BIT ZERO
   OUT DX, AL
   JMP L1				; JUMP FOR CONTINUOUS OPERATION
CODE    ENDS
END







.MODEL SMALL		; SIMPLIFIED SEGMENT MODEL
.DATA
 PORTA EQU 60H
 PORTB EQU 62H
 PORTC EQU 64H
 CWR EQU 66H
  
.CODE 
   MOV AX,@DATA
   MOV DS,AX
   ORG 0000H

.STARTUP
    MOV AL,82H		; PORT A OUTPUT. PORT B INPUT, MODE 0
    MOV DX,CWR		; SETTING CONTROL REGISTER
    OUT DX,AL
    
   L1:
   MOV DX,PORTB
   IN AL,DX
   AND AL, 11000000B    ; DISCARDING INPUTS FROM A0-A5
   CMP AL, 11000000B	; COMPARING WITH 11000000B, ONLY CASE OF LED ON
   JZ LEDON			; LED ON IF EQUAL AS 
   MOV DX,PORTA		;ADDRESS OF PORT A
   MOV AL, 00H		; ALL BITS ZERO
   OUT DX,AL			; OUTPUT AT PORT A
   JMP L1				; JUMP FOR CONTINUOUS OPERATION
   
   LEDON:
   MOV DX, PORTA
   MOV AL, 80H		; SETTING 7TH BIT ONE AND REST BIT ZERO
   OUT DX, AL
   JMP L1
.EXIT
END					; JUMP FOR CONTINUOUS OPERATION