;Arithmetic Series
;Full Segment Definition
assume CS:code DS:data 
data segment 
     n db 9    
     a db 2     
     d db 3    
data ends

code segment    
start:
       MOV CL, n     
       MOV CH,00
       MOV AL, a     
       
       MOV DI, 6500h   
       MOV [DI], AL    
       INC DI	       
       DEC CL	       
	   MOV BL, d             

	   
AP:    ADD AL, BL	    
       MOV [SI],AL     
	   MOV [DI], AL	   
	   INC DI          
	   
	   loop  AP      
code ends
     end start
