;Full Segment
assume cs:code ds: data

data segment 
    matrix1 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h
            
    matrix2 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h 
            
    result dw 9 dup<?>
data ends

code segment 
start: 
    mov ax,data 
    mov ds, ax
     
    mov si,0 
    mov ax,0 
    mov bx,0 
    mov cx,3 
   
loop1: 
    mov si, 0 
    push cx 
    mov cx, 3 
    
loop2: 
    mov ax,matrix1[bx][si] 
    add ax,matrix2[bx][si] 
    mov result[bx][si], ax 
    inc si 
    inc si 
    loop loop2
    add bx, 6
    pop cx
    loop loop1
    
code ends 
end start





;Simplified
.model small
.data
    matrix1 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h
            
    matrix2 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h 
            
    result dw 9 dup<?>
.code
.startup
     
    mov si,0 
    mov ax,0 
    mov bx,0 
    mov cx,3 
   
loop1: 
    mov si, 0 
    push cx 
    mov cx, 3 
    
loop2: 
    mov ax,matrix1[bx][si] 
    add ax,matrix2[bx][si] 
    mov result[bx][si], ax 
    inc si 
    inc si 
    loop loop2
    add bx, 6
    pop cx
    loop loop1
.exit
end
