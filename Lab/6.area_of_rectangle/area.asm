;fsd

Data Segment 
    msg1 db "Enter the Length : $"
    msg2 db 13, 10, "Enter the Breadth : $"
    space db 13, 10, "Area is : $"
    length db ?
    breadth db ?
    area1 db ?
    area2 db 00h
Data Ends

Code Segment
    Assume CS:Code, DS:Data
Start: MOV AX, Data
       MOV DS, AX 
       
       MOV AH, 09h
       LEA DX, msg1
       INT 21h
       
       
       MOV AH, 01h
       INT 21h
       
       SUB AL, 30h
       MOV CL, AL
       SUB CL, 01h 
       
       MOV AH, 09h
       LEA DX, msg2
       INT 21h
       
       
       MOV AH, 01h
       INT 21h  
       
       SUB AL, 30h
       
       MOV AH, 00h
       
       MOV CH, 00h
       MOV BX, AX
         
 Here: ADD AX, BX 
       DAA
       Loop Here
       
 disp: MOV AH, AL
       MOV Cl, 04h
       SHL AL, Cl
       SHR AL, Cl
       SHR AH, Cl 
       ADD AX, 3030h
        
       MOV area1, AL
       MOV area2, AH 
       
       MOV AH, 09h
       LEA DX, space
       INT 21h 
       
       MOV AH, 02h
       MOV DL, area2
       MOV DH, 00h
       INT 21h
       
       MOV AH, 02h
       MOV DL, area1
       MOV DH, 00h
       INT 21h
Code Ends
     End Start
     
     
     ;ssd
     
 .model small
.data
    arr1 db 12,1,14,15,22 
    cnt db 5
    msg1 db 13,10,'Enter the length: $',13,10  ;0dh,0ah
    msg2 db 13,10,'Enter the breadth: $',13,10     
    msg3 db 13,10,'The area of the rectangle is: $',13, 10
    msg4 db 13,10,'21$', 13,10   
.code
.startup   
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
    mov dx,offset msg3
    mov ah,9
    int 21h  
    mov al, bl   
    mov ah, 0
    mov bl, 10          
    div bl    
    mov bl, ah
    add al, 30h
    mov offset msg4[2], al
    add ah, 30h
    mov offset msg4[3], ah         
    mov dx,offset msg4
    mov ah,9
    int 21h
.exit  
end
