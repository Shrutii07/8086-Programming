;Full segment definition
assume cs:code ds: data
data segment  
    str1 db "Given string: $"
    msg1 db "bumblebee$" 
    str2 db "After converting vowel to uppercase:  $"
    msg2 db 10 DUP('$') 

data ends

code segment
    start:
    
    mov ax, data
    mov ds, ax 
    
     MOV AH , 09H
     LEA DX , str1
     INT 21H 
    
    ; Printing String in Lower Case
     MOV AH , 09H
     LEA DX , msg1
     INT 21H   
     
     ; Printing New Line
     MOV AH , 2
     MOV DL , 0DH
     INT 21H
     MOV DL , 0AH
     INT 21H
    
    mov SI, OFFSET msg1  
    MOV DI, OFFSET msg2
    
    mov bl,00
    
    loop1:
      MOV AL, [SI]
      CMP AL,'$'
      JZ FINAL   
    
      
      CMP AL,'a'
      JZ CHANGE   
      CMP AL,'e'
      JZ CHANGE   
      CMP AL,'i'
      JZ CHANGE   
      CMP AL,'o'
      JZ CHANGE   
      CMP AL,'u'
      JZ CHANGE
  
      JMP SAME
      
      JMP loop1
      
      
    CHANGE:
            SUB AL, 20h
            MOV [DI], AL 
            INC DI 
            INC SI 
            JMP loop1
            
    SAME:    
            MOV [DI], AL 
            INC DI 
            INC SI 
            JMP loop1
            
    FINAL:   

         MOV AH , 09H
         LEA DX , str2
         INT 21H
            ; Printing String in Upper Case
         MOV AH , 09H
         LEA DX , msg2
         INT 21H
          
          
         MOV AH , 4CH  ; Service Routine for Exit
         INT 21H
                    
        

code ends
end start
