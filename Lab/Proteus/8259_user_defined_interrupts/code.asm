CODE    SEGMENT PARA 'CODE'
        ASSUME CS:CODE, DS:DATA, SS:STAK
	
STAK    SEGMENT PARA STACK 'STACK'
        DW 20 DUP(?)
STAK    ENDS

DATA    SEGMENT PARA 'DATA'
; 0 for lighting, 1 otherwise
DIGITS  DB 0C0h, 0F9h, 0A4h, 0B0h, 99h, 92h, 82h, 0F8h, 80h, 90h, 088h, 080h, 0C6h, 0C0h, 86h, 8Eh		; 0 to F
DATA    ENDS

;;;; Be careful 13 = HEX(D) looks like 0 

START PROC
   MOV AX, DATA
   MOV DS, AX

      ;; Address of 8253: 78h
      ;; Addrss of  8255: 70h
      ;; Address of 8259: 10h
      MOV AL, 80h			; 1000 0000b
      OUT 76h, AL			; Setup 8255 as all ports mo0 output
      CALL SETUP_8253
      CALL INSERT_ISR_INTO_VECTOR_TABLE
      CALL SETUP_8259
      STI
      XOR AX,AX
ENDLESS:
      CALL SHOW_AX
      
      CMP AX, 0fh
      JNZ ENDLESS
      MOV AX, 0h		; MAke AX 0 after reaching 15		
      
      JMP ENDLESS   
RET
START ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		Common Anode Seven Segmeent	; 0 for lighting, 1 otherwise
SHOW_AX PROC NEAR
   PUSH AX
   
   XOR BX, BX
   MOV BL, AL
   MOV AL, DIGITS[BX]
   OUT 72h, AL				; 8255's Port B at 72h	
   
   POP AX
RET
SHOW_AX ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETUP_8253 PROC NEAR
	;; SETUP 8253 So that Counter 1 output creates 1hz output

	; --> Used to Divide 4Mhz Clock to 2000 so that we get 2Khz Output
        MOV AL, 00110101b	; 00 [counter 0], 11[ 2 byte data], 010 [ with mod 2], 1 [BCD] 
	OUT 7Eh, AL		; configure the counter 0 of 8253
	
	; --> Pulse Wave  :: MOD 2 of 8253
	MOV AL, 01110101b	; 01 [counter 1], 11[ 2 byte data], 010 [ with mod 2], 1 [BCD]
	OUT 7Eh, AL		; configure the counter 1 of 8253
	
	MOV AL, 00h		
	OUT 78h, AL		; Send first byte of Counter 0
	MOV AL, 20h		
	OUT 78h, AL		; Send second byte of Counter 0
	;;--> Counter0 : 2000h	; send BCD 2000 to counter 0
	
	MOV AL, 00h		
	OUT 7Ah, AL		; Send first byte of Counter 1
	MOV AL, 20h		
	OUT 7Ah, AL		; Send second byte of Counter 1
	;;--> Counter1	: 2000h ; send BCD 2000 to counter 1	
RET
SETUP_8253 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SETUP_8259 PROC NEAR

MOV AL, 00010011b		; ICW1 : Edge Triggered - 1 Master - ICW4 Kullan 
OUT 10h, AL			; SET InputControlWord1

MOV AL, 40h			; ICW2 : 40h
OUT 12h, AL			; SET InputControlWord2

MOV AL, 03h			; AEOI(Automatic Interrupt) = 1, PM(2 Acknowledge) = 1
OUT 12h, AL			; SET InputControlWord4

RET
SETUP_8259 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INSERT_ISR_INTO_VECTOR_TABLE PROC NEAR
   XOR AX, AX
   MOV ES, AX
   MOV AL, 40H
   MOV AH, 4
   MUL AH
   MOV BX, AX
   LEA AX, INC_AX_PER_15_SEC
   MOV WORD PTR ES:[BX], AX
   MOV AX, CS
   MOV WORD PTR ES:[BX+2], AX 
RET
INSERT_ISR_INTO_VECTOR_TABLE ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Interrupt Routine
INC_AX_PER_15_SEC PROC FAR
   INC AX
IRET
INC_AX_PER_15_SEC ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

CODE    ENDS
        END START
