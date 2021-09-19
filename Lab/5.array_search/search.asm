;finding an element in array 
;if found display num available else num not available 

;Full Segment Definition
assume cs:code ds: data
data segment 
    arr1 db 12,1,14,99,15,22 
    cnt db 99
    msg1 db 13,10,'Num available$',13,10        ;0dh,0ah 
    msg2 db 13,10,'Num not available$',13,10 
data ends
 
code segment
start:
    mov ax,data 
    mov ds, ax
    
    mov cl,cnt 
    mov di,offset arr1 
    chk: 
    mov al,99                       ;number to check in array 
    mov ah,[di] 
    cmp al,ah 
    jz disp1 
    inc di 
    dec cl 
    jnz chk  
    
    disp2: mov dx,offset msg2 
    mov ah,9 
    int 21h 
    .exit 
    
    disp1: mov dx,offset msg1 
    mov ah,9 
    int 21h 
code ends 
end start

;Simplified segment definition
.model small 
.data 
    arr1 db 12,1,14,99,15,22 
    cnt db 99
    msg1 db 13,10,'Num available$',13,10        ;0dh,0ah 
    msg2 db 13,10,'Num not available$',13,10 
.code 
.startup 
start: 
    mov cl,cnt 
    mov di,offset arr1 
    chk: 
    mov al,15 ;number to check in array 
    mov ah,[di] 
    cmp al,ah 
    jz disp1 
    inc di 
    dec cl 
    jnz chk  
    
    disp2: mov dx,offset msg2 
    mov ah,9 
    int 21h 
    .exit 
    
    disp1: mov dx,offset msg1 
    mov ah,9 
    int 21h 
.exit 
end
