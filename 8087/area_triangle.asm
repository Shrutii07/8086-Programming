Data Segment
    base dd 9.9
    height dd 6.2
    half dd 0.5
    area dt ?
    areamsg db "Area of right angled triangle is: $"
    a dw ?
    b dt 100.00
    dot db ".$"
    msg4 db 10d,13d,"$"
Data Ends
    

Code Segment
    Assume CS:Code, DS:Data
Start:     

    scall macro xx, yy       ;macro to display
        lea dx,xx
        mov ah,yy
        int 21h
    endm
    
    displayreal macro xx,yy
        fld xx
        scall msg4,09h  
        scall yy,09h
        
        fld b             ;load 100.00
        fmulp st[1],st    ;multiply by 100.00
        fbstp xx      ;convert to BCD
    
        mov ax,word ptr xx
        call display4digit      ;display ax contents
    endm  
    
    mov ax, Data
    mov ds, ax

    finit
    fld base        ; load base
    fld height      ; load height
    fmul            ; multiply base and height
    fld half        ; load 0.5
    fmul            ; multiply half to result
    fstp area       ; store result in area
    
    displayreal area, areamsg
    

    mov ah, 4ch     ; terminate program
    int 21h
    
    
display4digit proc
    mov a,ax        ;ax has 4 digits to diaplay
    mov dl,ah       ;to display ah first

    mov ch,02h      ;count of digits
    rol dl,01
    rol dl,01
    rol dl,01
    rol dl,01
loop3:  and dl,0fh
    add dl,30h

    mov ah,02h
    int 21h

    mov ax,a        ;restore ax
    mov dl,ah

    dec ch
    jnz loop3

    scall dot,09h   ;display dot

    mov ax,a
    mov dl,al       ;to display al
    
    mov ch,02h      ;count of digits
    rol dl,01
    rol dl,01
    rol dl,01
    rol dl,01

loop4:  and dl,0fh      ;anding to extract last digit
    add dl,30h      ;convert to ascii-hex

    mov ah,02h      ;display dl contents
    int 21h

    mov ax,a
    mov dl,al

    dec ch
    jnz loop4
RET
display4digit Endp


Code Ends
     End Start
