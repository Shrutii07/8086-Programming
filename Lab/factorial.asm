       ASSUME DS:DATA,CS:CODE

DATA SEGMENT
    A DB 5  
    msg1 db "Factorial = $"
DATA ENDS    

CODE SEGMENT 
    sprint macro xx       ;macro to display
        pusha
        lea dx,xx
        mov ah,09h
        int 21h
        popa
    endm 
    
    START:
          MOV AX,DATA
          MOV DS,AX
          MOV AH,00
          MOV AL,A
     L1:  DEC A
          MUL A
          MOV CL,A
          CMP CL,01
          JNZ L1  
           
          sprint msg1
          call PRINT 
          call PRINT_NL 
          
           
          MOV AH,4CH
          INT 21H  
                   
                   
PRINT PROC		
	pusha
	;initialize count
	mov cx,0
	mov dx,0
	label1:
		; if ax is zero
		cmp ax,0
		je print1	
		
		;initialize bx to 10
		mov bx,10	
		
		; extract the last digit
		div bx				
		
		;push it in the stack
		push dx			
		
		;increment the count
		inc cx			
		
		;set dx to 0
		xor dx,dx
		jmp label1
	print1:
		;check if count
		;is greater than zero
		cmp cx,0
		je exit
		
		;pop the top of stack
		pop dx
		
		;add 48 so that it
		;represents the ASCII
		;value of digits
		add dx,48
		
		;interrupt to print a
		;character
		mov ah,02h
		int 21h
		
		;decrease the count
		dec cx
		jmp print1
exit:
popa
ret
PRINT ENDP  

PRINT_NL PROC
        PUSHA                     ; Printing New Line
     MOV AH , 2
     MOV DL , 0DH
     INT 21H
     MOV DL , 0AH
     INT 21H  
     POPA 
     RET
PRINT_NL ENDP
     
CODE ENDS
END START
