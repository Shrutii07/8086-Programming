.model small 
.data
    ; Storing a,b,c in the memory location 
    ; dd stands for real4
    pi dd 03.14
    r dd 02.00  
    cnst dd 01.33
    area dd 00.00
    
    msg db 13, 10, "Vol : $"
    nline db 13, 10, '$'
    hundo dt 100.00        
    buff db "__.__$"

scall macro xx, yy
  lea dx, xx
  mov ah, yy
  int 21h
endm


displayreal macro xx, yy 
    
    scall nline, 09h
    scall yy, 09h
    
    fld xx
    fld hundo
    fmulp st(1), st
    fbstp xx      
    
    
    mov ax, word ptr xx 
    ; need LM.NP , 4 digit output number
    
    LEA SI, buff

    
    MOV BX, AX 
    MOV CL, 4   ; needed for shifting bits right later 
    
    
    
    
    MOV AX, BX
    SHR AH, CL   ; shift 4 bits to the right
    AND AH, 00001111b ; first digit i.e L
    ADD AH, 30h
    MOV [SI], AH
    INC SI
    
     
    
    
    MOV AX, BX
    AND AH, 00001111b ; second digit i.e M
    ADD AH, 30h
    MOV [SI], AH
    INC SI
    

    INC SI  ; '.' symbol preinserted
         
         
    MOV AX, BX
    SHR AL, CL   ; shift 4 bits to the right
    AND AL, 00001111b ; first digit i.e L
    ADD AL, 30h
    MOV [SI], AL
    INC SI
                    
    MOV AX, BX                
    AND AL, 00001111b ; fourth digit i.e P
    ADD AL, 30h
    MOV [SI], AL 
    INC SI
    
  
    scall buff, 09h    
endm



.code 
start: 
        mov ax,@data
        mov ds,ax

        Finit ; Intiailise the 8087 co-processor 
        Fld r ; Load pi to the stack 
        FLD pi
        Fmul st, st(1) ; Multiply the top of the stack 
        ;st(0)= 3.14*r
        Fld r ; Load b to the stack 
        ;st(0) = r st(1) = 3.14*r
        Fmul st, st(1) ; Multiply the top of the stack 

        Fld r ; Load b to the stack 
        ;st(0) = r st(1) = 3.14*r
        Fmul st, st(1)
        ;st(0) = 3.14*r*r
        Fld cnst ; Load h to the stack
        Fmul st, st(1) ; Multiply the top of the stack
        Fst area ; store a copy in area variable  
        
        displayreal area, msg
        
        
        MOV AH, 4Ch
        MOV AL, 01h
        INT 21h       ; terminating the program

end start  
