;Get a string as an input from the user and reverse it and display on the screen.    
Data Segment 
    msg1 db "Enter a String : $"
    msg2 db 0Ah, 0Dh, "The reversed string is : $"
    str db 08 dup('$') 
Data Ends

Extra Segment
    rev_str db 07 dup(00), '$'
Extra Ends
    
Code Segment
    Assume CS:Code, DS:Data, ES:Extra
Start: mov ax, Data
       mov ds, ax
       mov ax, Extra
       mov es, ax
       
       mov ah, 09h
       lea dx, msg1
       int 21h
       
       lea dx, str
       mov ah, 0Ah
       mov data, 04h
       int 21h 
       
       MOV al, str[01h]  ; AL will now contain the elements.
       MOV ah, 00h ; Now AX would contain the count.
       mov cx, ax ; Transfereing the coung to the CX register. 
       
       
       
       lea si, str + 02h
       lea di, rev_str + 06h 
       
 Here: cld
       lodsb
       std
       stosb
       loop here
       
       MOV al, str[01h]  ; AL will now contain the elements.
       MOV ah, 00h ; Now AX would contain the count.
       mov cx, ax ; Transfereing the coung to the CX register.  
       inc cx
       
       mov si, di
       inc si
       
       lea di, str 
       
       mov ax, data
       mov es, ax
       
       mov ax, extra
       mov ds, ax 
       
       cld
       
       rep movsb 
       
       mov ax, data
       mov ds, ax
       
       
       mov ah, 09h
       lea dx, msg2
       int 21h  
               
       mov ah, 09h
       lea dx, str
       int 21h         
       
       
       
Code Ends
     End Start
