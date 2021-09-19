;simplified style
;just displays the given message
                  
.model small 

.data
message db  '8086 microprocessor and interfacing$' ;$ is used to as string termination character
;a $ should be there at the end of every message to be displayed   

.code 
.startup      
mov ah,09h ;interrupt to display a string	 
mov dx,offset message ;offset addres of "message"		 
int 21h ;pointing to the message and running it                 
mov ah,0
int 16h
.exit 
end