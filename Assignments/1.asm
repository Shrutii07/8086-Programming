;Write an ALP to display how many numbers stored in a data block (10 bytes) lie between 5 and 20.

data segment
    ;creating variables for displaying the messages
    msg1 db "Enter the numbers : $"
    msg2 db 13, 10, "The count of numbers between 5 and 10 is : $"   
    ; creating an empty array to store all the inputs
    res db 10 dup <0>
    ; creating a variable to store the count of number between 5 and 20
    ;cnt db 00h 
    
data ends    
code segment  
assume cs:code, ds:data
start:
mov ax, data
mov ds, ax 
mov dh, 0h ;count of elements between 5 and 20
mov dl, 10 ;to incorporate double digit numbers 
mov bl, 0  ;temporary storage of double digit numbers
mov bh,11  ;count of elements
lea si, res  
mov ch,0
count: 
    dec bh       ; decremented the count
    cmp bh,0     ; checking if the number of inputs taken are                10 
    mov AH, 09h  
    lea DX, msg1 ; displaying msg1
    int 21h 
    je exit     ;exits if 10 inputs are taken
    jmp scanNum  ; else jumps to scanNum
        
scanNum:

    mov ah, 01h
    int 21h

    cmp al, 13   ; Check if user pressed ENTER KEY
    je  check 

    mov ah, 0                                      
    sub al, 48   ; ASCII to DECIMAL

    mov cl, al
    mov al, bl   ; Store the previous value in AL
    mov dl,10
    mul dl       ; multiply the previous value with 10

    add al, cl   ; previous value + new value ( after previous value is multiplied with 10 )
    mov bl, al
      
    jmp scanNum 
         
check:
;check if bl is between 5 and 20
    mov [si],bl
    inc si
    ;cmp ch,0
    ;je new
    mov al,bl    ; moving the input number to al
    sub al,6     ;checking if the number is less than or equal               to 5
    jc delete    ; if less than 6 then deleting the element
    mov al,bl
    sub al,20    ; checking if the number is less than 20
    jc print     ; if less than 0 then goes to print
    mov ax,0000h ; clearing accumulator
    mov bl,00h   ; clearing bl for next input
    jmp count    ; move back to count loop
    
delete:
    mov ax,0000h ; clearing accumulator
    mov bl,00h   ; clearing bl for next input
    jmp count    ; move back to count

print:
    mov ax,0000h ; clearing accumulator
    mov bl,00h   ; clearing bl for next input
    inc ch      ; incremented count variable
    jmp count    ; jump back to count loop
    
exit:
    
    add ch,48    ; for ASCII to Decimal conversion
    mov AH, 09h   
    lea DX, msg2  ; display msg2
    INT 21h 
   
    MOV AH, 02h
    MOV DL, ch   ; display the count stored in CH 
    MOV DH, 00h
    INT 21h 
    
    mov ah, 04ch 
    int 21h
    
code ends 
end start
