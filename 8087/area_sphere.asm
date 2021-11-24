.model small
.data
    radius dd 2.4
    four dd 4.0
    area dt ?
    areamsg db "Area of sphere is: $"
    a dw ?
    b dt 100.00
    dot db ".$"
    eol db 10d,13d,"$"

    
scall macro xx, yy          ;macro to display string
        lea dx,xx
        mov ah,yy
        int 21h
endm

displayreal macro xx,yy     ; macro to convert variable value to BCD
    fld xx
    scall eol,09h  
    scall yy,09h
    
    fld b                   ;load 100.00
    fmulp st[1],st          ;multiply by 100.00
    fbstp xx                ;convert to BCD

    mov ax,word ptr xx
    call display4digit      ;display ax contents
endm

.code
.startup
    mov ax, @data
    mov ds, ax

    ;8087 instructions to compute area of sphere ;area = 4*pi*r*r

    finit
    fld radius          ; loading the radius
    fmul st, st(0)      ; radius squared
    fldpi               ;loading pi
    fmul                ; pi* r^2
    fld four            ; loading 4
    fmul                ; 4*pi*r^2
    fstp area           ; popping final value to the area variable
    
    displayreal area, areamsg       ;displaying the result
    
    mov ah, 4ch         ; MS DOS interrupt to
    int 21h             ; return control to the operating system
    
    
display4digit proc      ;procedure to print the value on console
    mov a,ax            ;ax has 4 digits to display
    mov dl,ah           ;to display ah first

    mov ch,02h          ;count of digits
    mov cl, 4
    rol dl, cl

loop3:  and dl,0fh
    add dl,30h

    mov ah,02h
    int 21h

    mov ax,a            ;restore ax
    mov dl,ah

    dec ch
    jnz loop3

    scall dot,09h       ;display dot

    mov ax,a
    mov dl,al           ;to display al
    
    mov ch,02h          ;count of digits
    mov cl, 4
    rol dl, cl

loop4:  and dl,0fh      ;anding to extract last digit
    add dl,30h          ;convert to ascii-hex

    mov ah,02h          ;display dl contents
    int 21h

    mov ax,a
    mov dl,al

    dec ch
    jnz loop4
ret
endp

end
