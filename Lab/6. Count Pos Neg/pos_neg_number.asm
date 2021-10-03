data segment    
    arr1 db -13, 35, -17, 0, -5, 99    ; array
    negnos db 0         
    posnos db 0         
data ends      

code segment                    
start:      
    MOV AX,data
    MOV ds, AX     
    MOV SI, offset arr1 
    MOV CL, 6            
    l1:                  
        MOV AL, [SI]     
        SHL AL, 01       
        JC ne           
        INC posnos                
        JMP here                
        ne:    
            INC negnos   
        
        here:  
        INC SI            
        LOOP l1         
code ends 
end start
