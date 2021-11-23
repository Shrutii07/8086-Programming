; invert pyramid

.model small
.stack 100h
.data
star db ?
blank db ?   

.code    
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 5
    mov bh, 9
    mov bl, 0
    
    mov star, bh
    mov blank, bl
    
    l1:
    cmp blank, 0
    je l2
    
    mov ah, 2
    mov dl, 32
    int 21h
    dec blank
    
    jmp l1
    
    l2:
    mov ah, 2
    mov dl, "*"
    int 21h
    dec star
    cmp star, 0
    jne l2
    
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    
    dec bh
    dec bh
    mov star, bh
    
    inc bl
    mov blank, bl
    loop l1
    
    exit:
    mov ah, 4ch
    int 21h
    main endp
end main
