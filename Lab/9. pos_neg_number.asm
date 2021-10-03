assume cs:code ds:data
data segment    
    arr1 db -13, 21, 17,-50, -5, 99      ; array
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
        CMP AL, 0       
        JG pos           
        INC negnos                
        JMP here                
        pos:    
            INC posnos   
        
        here:  
        INC SI            
        LOOP l1         
code ends 
end start
