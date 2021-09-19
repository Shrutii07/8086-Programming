;full segment style
;adding the elements of an array                                                    
             
data segment
    
    array       dd      1h,2h,3h,4h,5h,6h,7h,8h,9h,ah
    sum         dd      ?   
    
data ends 



code segment
    
    assume cs:code, ds:data
    
    start:  mov ax, data                   
            mov ds, ax 
             
            xor ax, ax                     ;clearing ax
            xor dx, dx                     ;clearing dx
            mov si, 0                      ;clearing si  
            
            mov cx, 10                     ;updating cx with size of the array
            
 addition:  add ax,word ptr array[si]      ;adding lower word
            adc dx,word ptr array[si+2]    ;adding upper word
            add si,4
            loop addition 
            
            mov word ptr sum, ax           ;storing the lower word in memory
            mov word ptr sum + 2, dx       ;storing the upper word in memory
    
            
code ends

    end start