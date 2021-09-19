;;xlat example for ascii
;.model small
;.data
;table1 db '0123456789abcdef' ;table
;num1 db 6 ;ascii is needed
;res1 db ? ;ascii is stored here
;.code
;.startup
;mov al,num1
;mov bx,offset table1 
;xlat
;mov res1,al 
;mov dl,al
;mov ah,02h ;display character in dl
;int 21h
;.exit
;end  

;xlat encryption example
;input num 0 1 2 3 4 5 6 7 8 9 
;encrp num 9 4 6 2 7 8 3 1 0 5
.model small
.data
table1 db '9462783105'
num1 db 1
.code
.startup
mov bx,offset table1
mov al,num1
xlat
mov dl,al 
mov ah,2 ;display the encrypted value
int 21h
.exit
end