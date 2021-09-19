;coding using simplified segment style 
;it will simply perform subtraction
.model small ;we are using the small model

.data ;the data here
num1 db 7
num2 db 2    

;code section begins
.code
.startup
  mov al,num1
  mov bl,num2
  sub al,bl
.exit

end  