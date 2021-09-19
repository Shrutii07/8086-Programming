Data Segment 
    msg1 db "Enter the Length : $"
    msg2 db 13, 10, "Enter the Length : $"
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
