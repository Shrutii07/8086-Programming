.model small
.data                                          
    cnt db 7
    star db 3,"$"  ;0dh,0ah
    new db 13,10,'$'  
    
.code
.startup   
start:        
    mov cl,cnt         
    mov bl, 1
loop1:
    mov ch, bl      
loop2:
    mov dx,offset star
    mov ah,9
    int 21h      
      
    dec ch
    jnz loop2
    
    mov dx,offset new
    mov ah,9
    int 21h
    
    inc bl
    dec cl
    jnz loop1  
            
    mov dx,offset new
    mov ah,9
    int 21h    
         
.exit  
end
