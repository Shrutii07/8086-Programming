;Full Segment
assume cs:code ds: data
data segment
    arr1 db 1,2,3,4
    arr2 db 5,6,7,8
    res db 4 dup <0> ;0,0,0,0
data ends

code segment
    start:
    mov ax, data
    mov ds, ax
    
    lea si, arr1  ; mov si, offset arr1
    lea di, arr2
    lea bx, res
    mov cx, 4
    
loop1:
    mov al, [si]
    add al, [di]
    mov [bx], al
    inc bx
    inc si
    inc di
    dec cl
    jnz loop1
    
    mov ah, 4ch
    int 21h

code ends
end start



;Simplified 
.model small
.data
    arr1 db 1,2,3,4
    arr2 db 5,6,7,8
    res db 4 dup <0> ;0,0,0,0
.code
.startup

    lea si, arr1  ; mov si, offset arr1
    lea di, arr2
    lea bx, res
    mov cx, 4
    
loop1:
    mov al, [si]
    add al, [di]
    mov [bx], al
    inc bx
    inc si
    inc di
    dec cl
    jnz loop1
    
    mov ah, 4ch
    int 21h

.exit
end
