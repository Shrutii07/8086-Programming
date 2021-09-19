;;moving a number in memory
;assume cs:code, ds:data
;data segment
;    num1 db 20
;data ends 
;code segment
;    start:
;    mov ax,data
;    mov ds,ax
;    mov ax,1000h
;    xor ax,ax
;    mov bx,offset num1 
;    mov ax,[bx] ;moving the data in ax  
;    mov [di],ax 
;code ends
;end start    

;moving using movsb
assume cs:code, ds:data
data segment
    arr1 db 1,2,3,4,5,6,7,8,9,0ah
data ends                     
code segment
    start:
    mov ax,data
    mov ds,ax
    mov ax,6000h
    mov es,ax
    mov si,offset arr1
    mov di,2000h
    mov cx,0ah  
    cld
    rep movsb
    
    mov ah,4ch
    int 21h
code ends
end start