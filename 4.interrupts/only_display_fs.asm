;full segment style
;just displays the given message
                  
assume cs:code, ds:data
data segment
    msg1 db 'microprocessor$',13,10
data ends

code segment
    start: mov ax,data
    mov ds,ax
    mov dx,offset msg1
    mov ah,09h
    int 21h
    mov ah,0
    int 16h
code ends  
end start