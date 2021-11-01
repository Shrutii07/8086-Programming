 .model small
.data
    arr1 db 12,1,14,15,22 
    cnt db 5
    msg1 db 13,10,'Enter the base length: $',13,10  ;0dh,0ah
    msg2 db 13,10,'Enter the height: $',13,10     
    msg3 db 13,10,'The area of the triangle is: $',13, 10
    msg4 db 13,10,'21$', 13,10   
.code
mov ax,@data
mov ds, ax   
start:   
    mov dx,offset msg1
    mov ah,9
    int 21h    
    mov ah, 1h
    int 21h                    
    sub al, 30h                    
    mov bl, al           
    mov dx,offset msg2
    mov ah,9
    int 21h      
    mov ah, 1h
    int 21h       
    sub al, 30h    
    mul bl     
    mov bl, al  
    mov bh, ah  
    mov dx,offset msg3
    mov ah,9
    int 21h  
    mov al, bl
    mov ah, 0
    mov bl, 2          
    div bl   
    mov ah, 0
    mov bl, 10          
    div bl    
    mov bl, ah
    add al, 30h
    ;mov offset msg4[2], al
    add ah, 30h
    ;mov offset msg4[3], ah         
    ;mov dx,offset msg4
    ;mov ah,9
    ;int 21h
    
    mov dl,al
    mov bh, ah
    mov ah,02h
    int 21h 
    mov dl,bh
    mov ah,02h
    int 21h
  
end
