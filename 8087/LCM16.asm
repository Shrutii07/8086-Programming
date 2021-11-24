; ASSIGNMENT-1 | Group-4
; ALP to find LCM of two 16 bit numbers. 
; Numbers are available in memory locations 
; after they are provided by the user. 
; Store the result in another memory location 

; Full-segment format
assume ds: data, cs:code
data segment
    ; Messages to be displayed
    msg01 db 13,10,"Note: The no.s entered should be a 16-bit 
    ...            number from 0000 to FFFF.$",13,10
    msg02 db 13,10,"      and ensure that the LCM of the 16-bit
    ...            no.s do not exceed FFFF.$",13,10
    msg03 db 13,10,"This code is written in full-Segment format.$"
    msgln db 13,10,"$",13,10
    msg1 db 13,10,"Enter the first number: $",13,10
    msg2 db 13,10,"Enter the second number: $",13,10
    msg3 db 13,10,"The L.C.M is equal to: $",13,10 
    msgf db 13,10, "Yay!!$",13,10
    ; Main variables
    num2 dw ?
    num1 dw ?
    lcm dw ?
    
    ; Tempory variables used for display purpose
    hx db 16
    a1 db ?
    a2 db ?
    tm db ?
data ends

code segment
start: 
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}
    ; Defining a macro for displaying any message
    message macro msg
        lea dx,msg
        mov ah,9
        int 21h
    endm
    
    mov ax,data
    mov ds,ax
    
    message msg01
    message msg02
    message msg03
    message msgln
    
    ; Taking input from the user
    message msg1
    call read_inp
    mov num1,ax
    ; Taking input from the user
    message msg2
    call read_inp
    mov num2,ax
    
    ; Moving the two numbers to AX and BX resp.
    mov ax,num1
    mov bx,num2
    
    compare:
    cmp ax,bx    ; Compare the two no.s
    je fin       ; Jump to final step if equal
    jb swap      ; Swap the numbers if no. in AX<BX
    
    rep_div:
    sub dx,dx    ; Make DX = 0
    div bx       ; Divide AX by BX
    cmp dx,0     ; Check if Remainder is Zero
    je fin       ; Jump to the final step if rem =0
    mov ax,dx    ; Else, move remainder to AX and,
    jmp compare  ; Compare the numbers again.
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}    
    swap:
    xchg ax,bx   ; Swap the values of AX & BX
    jmp rep_div  ; Jump to rep_div
    
    fin:   
    mov ax, num1 ; Move num-1 to AX
    mul num2     ; Multiply num-1 and num-2
    div bx       ; Divide the product with HCF
    mov lcm,ax   ; Store the result
    
    ; Displaying the LCM 
    message msg3
    mov ax,lcm
    mov a1,al
    mov tm,ah
    call disp
    mov ah,a1
    mov tm,ah
    call disp
    message msgln
    message msgf
    ; DOS interupt for exit
    mov ah,4ch
    int 21h
    
    ; Function to display a 16-bit number
    disp proc near
        sub ax,ax
        mov al,tm
        div hx
        mov dx,ax
        cmp dl,0Ah
        jb dp1
        add dl,37h
        jmp dn1  
        dp1:
        add dl,30h 
        dn1:
        mov ah,2
        int 21h
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}        
        mov dl,dh
        cmp dl,0Ah
        jb dp2
        add dl,37h
        jmp dn2  
        dp2:
        add dl,30h
        dn2: 
        mov ah,2
        int 21h
        ret    
    disp endp
    
    ; Function to read a 16-bit number
    read_inp proc near
        ;Read MSB
        mov ah,1
        int 21h
        mov dl,al
        cmp dl,40h
        jb n101
        sub dl,37h
        jmp nx101
        n101:
        sub dl,30h
        nx101:
        sub ax,ax
        mov al,dl
        mul hx
        mov tm,al
        
        mov ah,1
        int 21h
        mov dl,al
        cmp dl,40h ; 0 to 9 => 30h to 39h
        jb n102
        sub dl,37h ; A to F => 41h to 46h
        jmp nx102
        n102:
        sub dl,30h
\end{minted}
\end{tcolorbox}
\begin{tcolorbox}
\begin{minted}{asm}
        nx102:
        mov al,tm
        add al,dl
        mov a2,al
        ;-------------
        ;Read LSB
        mov ah,1
        int 21h
        mov dl,al
        cmp dl,40h
        jb n201
        sub dl,37h
        jmp nx201
        n201:
        sub dl,30h
        nx201:
        sub ax,ax
        mov al,dl
        mul hx
        mov tm,al
        
        mov ah,1
        int 21h
        mov dl,al
        cmp dl,40h
        jb n202
        sub dl,37h
        jmp nx202
        n202:
        sub dl,30h
        nx202:
        mov al,tm
        add al,dl
        mov a1,al
        
        mov ah,a2
        mov al,a1
        ret        
    read_inp endp
code ends
end start
