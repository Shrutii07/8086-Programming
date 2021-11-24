.model small
.data
     num  dw 2132h 
     msg1 db "nibble wise palindrome$"
     msg2 db "not nibble wise palindrome$"
    
.code
.startup
        mov ax,@data
        mov ds,ax
        
        mov ax,num
        mov cl,04   ; load num of bits in nibble
        
        ror al,cl   ; rotate to swap nibbles
        cmp ah,al   ; compare rotated byte with upper byte
        je palindrome
        
        lea dx,msg2
        mov ah,09h
        int 21h
        jmp over
 
 palindrome: lea dx,msg1
             mov ah,09h
             int 21h
over:
.exit
