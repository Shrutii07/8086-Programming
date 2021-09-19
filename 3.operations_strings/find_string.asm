;full segment style
;see whether a given byte is there in a string or not
assume cs:code ds:data
data segment
    byte1 equ 25h ;check if "byte1" is there in "string" or not
    count equ 10 ;length of the string
    string db 12h,13h,20h,02h,25h,0ah
ends
code segment
    start: mov ax,@data
    mov ds,ax
    mov es,ax
    mov cx,count
    mov di,offset string
    mov bl,00h
    mov al,byte1
    scan1: nop
    scasb
    jz one
    inc bl
    loop scan1
    one: mov ah,4ch
    int 21h
ends
