
data segment
    
    square_head db 0,0,15,15,15,15,15,15,15,15,15,15,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0      
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,0,0,0,0,0,0,0,0,0,15,0,0
                db 0,0,15,15,15,15,15,15,15,15,15,15,15,0,0
     head_length equ 15 
     win_label_message db "Hurray, you win !!!$"
     lose_label_message db "Better Luck Next Time :($" 
     file_words db "hangman_words.txt"     
     File_handler dw 0
     buffer_word db 255 dup (0)
     random_no db 0
     word db 20 dup (0)  
     word_len db 0
     fail_label_message db "fails:$"
     fail_number db 0    
     correct_word db 20 dup (0)
     did_win db 0
     succeed db 0
     fail_place db 6
     hangmann_title db "   H A N G M A N$"
     
ends

stack segment
    dw 128 dup(0)
ends

code segment
    proc initialize_screen
        push ax
        mov ax,13h        ;enables screen mode
        int 10h
        pop ax
        ret
    endp
    
    proc man_head
        pusha ;push all the general purpose registers to the stack, prevents information loss
        lea si, square_head  ;to display the head of the hangman
        mov ah, 0ch ;change color for a pixel
        mov cx,213 ;column number
        mov dx, 55 ; row
        
        draw_head_loop:
            cmp dx, 55 + head_length ;check if all rows have been printed
            je draw_head_exit ;if yes then exit the loop else continue
            mov al, [si] ;moves the next value to al
            int 10h ;changes the color of that pixel
            inc cx ;increment column number
            inc si ;move to the next value
            cmp cx, 213 + head_length ;check if all columns have been printed
            je next_row ;if yes then move to next row
            jmp draw_head_loop ;else continue is same row
        next_row:
            inc dx ;increment row value
            mov cx, 213 ; start from the first column index again
            jmp draw_head_loop ;follow the same procedure for the previous row
            
        draw_head_exit:
            popa ;pop back all values from the stack
            ret
    man_head endp
    
    proc draw_base
        pusha
        mov ah,0ch     ;change colour of single pixel
        mov bh, 0000h
        mov al,15   ;pixel color value
        mov cx, 240 ;coloumn number
        mov dx, 120 ;row number
        
        part1:
            int 10h
            inc cx
            cmp cx,270
            jne part1 ;draw a straight line for 30 columns keeping row fixed
             
            mov cx,255 ;new column number
            
        part2:
            int 10h
            dec dx
            cmp dx, 45 
            jne part2 ;draw a straight line for 75 rows keeping column fixed
            
        part3:
            int 10h
            dec cx 
            cmp cx, 220 ;draw a straight line for 35 columns keeping row fixed
            jne part3
            
        part4:
            int 10h
            inc dx
            cmp dx,55
            jne part4  ;draw a straight line for 10 rows keeping columns fixed
            
        popa
        ret  
    draw_base endp
    
    proc draw_main_body   ;to be used to indicate progress
        pusha
        mov ah,0ch
        mov al,15
        mov dx,70     ;starting row
        mov cx,220    ;starting column
        
        main_body_loop:
            int 10h
            inc dx
            cmp dx,100       ;draw a straight line for 30 rows keeping column fixe
            jne main_body_loop
        popa
        ret   
    draw_main_body endp 
    
    proc first_hand
        pusha
        mov ah,0ch
        mov al,15
        mov dx,70     ;starting row
        mov cx,220    ;starting column
        
        first_hand_loop:
            int 10h
            inc dx
            inc cx          ;hand will be slanting so incrementing columns 
            cmp dx,85       ;draw a straight line for 15 rows
            jne first_hand_loop
        popa
        ret
    first_hand endp
    proc second_hand
        pusha
        mov ah,0ch
        mov al,15
        mov dx,70     ;starting row
        mov cx,220    ;starting column
        
        second_hand_loop:
        int 10h
        inc dx
        dec cx          ;hand will be slanting so decrementing columns
        cmp dx,85       ;draw a straight line for 15 rows
        jne second_hand_loop
        popa
        ret 
    second_hand endp
    proc first_leg
        pusha
        mov ah,0ch
        mov al,15
        mov dx,100     ;starting row
        mov cx,220    ;starting column
        
        first_leg_loop:
        int 10h
        inc dx
        inc cx          ;leg will be slanting so incrementing columns
        cmp dx,115       ;draw a straight line for 15 rows
        jne first_leg_loop
        popa
        ret   
     first_leg endp 
    
     proc second_leg
        pusha
        mov ah,0ch
        mov al,15
        mov dx,100     ;starting row
        mov cx,220    ;starting column
        
        second_leg_loop:
            int 10h
            inc dx
            dec cx          ;leg will be slanting so decrementing columns
            cmp dx,115       ;draw a straight line for 15 rows
            jne second_leg_loop
        popa
        ret
      endp second_leg    
    
    
    proc win
        pusha
   
        lea si, word    ; pointer to word
        mov dl, 4
        write_win:
            mov  dh, 20   ;Row
            xor  bh, bh   ;Display page set to 0
            mov  ah, 02h  ;SetCursorPosition 
            int  10h
            add dl, 4
       
            mov ah, 09h   ; write char
            mov cx, 1
            mov al, [si]
            inc si
            mov bl, 2h
            int 10h
            cmp [si], "$"
            jne write_win  
        
            lea si, win_label_message  ; pointer to win msg
            mov dl, 0
            xor cl, cl                                                
        write_label2:
            mov  dh, 24   ;Row
            mov  bh, 0    ;Display page
            mov  ah, 02h  ;SetCursorPosition
            int  10h
           
            mov al, [si]
            inc si
            ;mov  al, '3'
            mov  bl, 2h  ;Color is red
            xor  bh, bh    ;Display page
            mov  ah, 0Eh  ;Teletype
            int  10h
            inc dl
            cmp [si], "$"
            jne write_label2
        popa
        ret
    win endp  
    
    proc write_all_word
        pusha
   
        lea si, word
        mov dl, 4
        write_loop:
     
            mov  dh, 20   ;Row
            xor  bh, bh   ;Display page set to 0
            mov  ah, 02h  ;SetCursorPosition 
            int  10h
            add dl, 4
       
       
            mov ah, 09h    ; write char
            mov cx, 1       ; no of times to write char
            mov al, [si]
            inc si
            mov bl, 4h
            int 10h
            cmp [si], "$"   ; compare with end of string
            jne write_loop  ; loop till word ends
         
      
            lea si, lose_label_message  ; pointer to lose msg
            mov dl, 0
            xor cl, cl                                                
        write_label1:
            mov  dh, 24   ;Row
            mov  bh, 0    ;Display page
            mov  ah, 02h  ;SetCursorPosition
            int  10h
       
            mov al, [si]
            inc si
            ;mov  al, '3'
            mov  bl, 2h  ;Color is red
            xor  bh, bh    ;Display page
            mov  ah, 0Eh  ;Teletype
            int  10h
            inc dl
            cmp [si], "$"
            jne write_label1
        popa
        ret
    write_all_word endp
     
    open_read_file proc 
        pusha            ; contents of registers in stack
        ;opens file
        mov ah, 3Dh          ; open existing file
        lea dx, file_words    ; file pointer
        xor al, al           ; read file
        int 21h 
        mov offset File_handler, ax ;handler
        
        ;reads from file
        mov ah, 3Fh           ; read from file
        mov bx, [File_handler]  ; file handle
        mov cx, 255           ; no. of bytes to read
        lea dx, buffer_word        ; pointer to buffer
        int 21h
        popa                   ; return contents of register
        ret
    open_read_file endp  
    
    get_random_number proc 
        pusha
        mov ah, 2ch     ; get system time
                        
        int 21h     ; CH = hour. CL = minute. DH = second. DL = 1/100 seconds.
        mov ax, dx  ; get seconds accumulator
        add ah, al  ; add AH and AL
        xor dx, dx   ; clear DX
        mov bx, 10
        div bx      ; divide A by 10
        lea bx, random_no   ; get pointer for random number
        mov [bx], ah           ; store random number
        popa 
        ret
    get_random_number endp  
    
    get_random_word proc 
        pusha
        lea bx, random_no      ; pointer to random number
        mov cx, [bx]        ; get random number in Cx
        lea bx, buffer_word      ; get pointer to buffer
       loop_until_found:   ;0A (new line)
        inc bx
        mov ax, [bx]
        cmp al, 0Ah
        jne loop_until_found    ; loop until new line found
        dec cx                   ; decrement count
        cmp cx,0
        jne loop_until_found    ; loop for random number times
        
        inc bx 
        
    
        lea di, word          ;pointer to variable word
       collect_word:
        mov si, [bx]         ; data from buffer to si
        mov [di], si
        inc bx                ; increment buffer pointer
        inc di                ; increment destination pointer
        cmp si, 0A0Dh  ; 0A0D new line
        jne collect_word
        
        dec di
        mov [di], "$"        ; mov $ at the end of string
        
        popa 
        ret
    get_random_word endp    
    
    get_word_len proc 
        pusha
        
        lea bx, word    ; pointer to word
        xor cx, cx      ; clear count
       count:
        inc cx          ; increase count
        inc bx          ; increase pointer
        cmp [bx], "$"   ; compare character with "$" i.e. end of string
        jne count       ; if not equal jump to count
        
        lea bx, word_len  ; pointer to word_length
        mov [bx], cl      ; store word_length to variable
        
        
        popa
        ret
    get_word_len endp   
    
    proc fail_label
   
        lea si, fail_label_message
        mov dl, 0
        xor cl, cl
       write_label:
        ;mov  dl, cl   ;Column start at 3
        mov  dh, 22   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
       
        mov al, [si]
        inc si
        ;mov  al, '3'
        mov  bl, 0Ch  ;Color is red
        xor  bh, bh    ;Display page
        mov  ah, 0Eh  ;Teletype
        int  10h
        inc dl
        cmp [si], "$"
        jne write_label
        ret
    fail_label endp
    
    proc draw_lines
        pusha
        lea si, word_len
        mov bx, [si]
        
        mov ah, 0ch 
        mov al, 15    ; pixel color
        mov cx, 27     ; column
        mov dx, 170 ; row
        
       lines:
        call draw_line
        dec bx
        add cx, 12
        cmp bl, 0
        jne lines
        
        popa
        ret
    draw_lines endp
    proc draw_line
        push bx
        xor bx, bx
       making_line: 
        int 10h
        inc cx
        inc bx
        cmp bx, 20    
        jne making_line 
    
        pop bx
        ret
    draw_line endp
    
    proc check_win      ; compare correct_word by user with word
        pusha
   
        lea si, correct_word    ; pointer to user word
        lea bx, word            ; actual word
        cmp [bx], "$"      ; compare with eos
        je call_win     ; if reached eos user won 
        mov al, [si]
        mov dl, [bx]
        cmp al, dl
        je check_loop
   
   
      check_loop:
        inc si
        inc bx
        cmp [bx], "$"
        je call_win
        mov al, [si]
        mov dl, [bx]
        cmp al, dl
        je check_loop  
       
        exit_check:
        popa
        ret
           
      call_win:
        lea si, did_win         ; set did_win variable
        mov [si], 1
        call win
        jmp exit_check
    check_win endp  
    
    get_letter proc 
        pusha
        mov ah, 7h    ; character input
        int 21h
        
        lea si, correct_word
        
        mov cl, 1       ; count 
        
        lea bx, word    ; pointer to word
        cmp [bx], al    ; compare character to input letter
        je call_write_letter
        
       check_for_letter:
        inc cl            ; increase count
        inc bx            ; increase word pointer
        inc si            ; increase correct pointer
        cmp [bx], "$"     ; if string end char not found
        je call_get_fail
        cmp [bx], al
        je call_write_letter
        
        jne check_for_letter
       
       call_get_fail:
        push ax
        call get_fail      ; char not found
        jmp exit
       call_write_letter:
        mov [si], al       ; move char to correct variable
        push ax
        push cx
        call write_letter
        jmp check_for_letter
    
        
       exit:
        popa 
        ret        
    write_letter proc 
        mov bp, sp
        pusha
        
        lea si, succeed
        mov [si], 1
        
        mov cx, [bp+2]
        mov ax, 4
        mul cx
        
       
        mov  dl, al   ;Column start at al location
        mov  dh, 20   ;Row 
        xor  bh, bh   ;Display page set to 0
        mov  ah, 02h  ;SetCursorPosition in int 10h
        int  10h
        
        mov ax, [bp+4]
        ;mov  al, '3'
        mov bl, 15
        mov  bh, 0    ;Display page
        mov  ah, 0Eh  ;Teletype
        int  10h
        popa
        ret 4    
    write_letter endp
    
    get_fail proc   

        mov bp, sp
        pusha
        
        lea si, succeed
        cmp [si], 1
        je exit_get_fail
        
        
        lea si, fail_place
        mov dl, [si]
        ;mov dl, 6 ;column = 6
        mov ah, 02h
        xor bh, bh ;page = 0
        mov dh, 22 ;row = 24
        int 10h
        
        mov ah, 08h
        int 10h
        
        inc dl
        mov [si], dl

        mov al, [bp +2]
        mov ah, 09h
        mov bl, 0ch
        mov cx, 1
        int 10h
        
        lea si, fail_number
        inc [si]

       exit_get_fail:
        lea si, succeed
        mov [si], 0   
        popa
        ret 2
    
    get_fail endp
    
    proc hangman_display
        pusha
         lea si, hangmann_title
        mov dl, 0
        xor cl, cl                                                 
       write_label3:
        ;mov  dl, cl   ;Column start at 3
        mov  dh, 2   ;Row
        mov  bh, 0    ;Display page
        mov  ah, 02h  ;SetCursorPosition
        int  10h
       
        mov al, [si]
        inc si
        ;mov  al, '3'
        mov  bl, 2h  ;Color is red
        xor  bh, bh    ;Display page
        mov  ah, 0Eh  ;Teletype
        int  10h
        inc dl
        cmp [si], "$"
        jne write_label3
        popa
        ret 
    hangman_display endp 

    proc game
        pusha  ;push all the general purpose registers to the stack, prevents information loss
        call initialize_screen
        call hangman_display
        call draw_base
        call open_read_file
        call get_random_number     
        call get_random_word
        call get_word_len
        call draw_lines
        call fail_label
        
        main_game:
        call get_letter
        call check_win
        cmp [did_win],1     ; if win exit game
        je exit_game 
        lea bx, fail_number
        cmp [fail_number], 1  ; fail 1 time draw head
        je call_draw_head
        cmp [fail_number], 2    ; fail 2 time draw body
        je call_draw_main_body
        cmp [fail_number], 3
        je call_draw_first_hand     ;fail3 time draw hand
        cmp [fail_number], 4
        je call_draw_second_hand    ;fail 4 time draw another hand
        cmp [fail_number], 5        ; fail 5 time draw first leg
        je call_draw_first_leg
        cmp [fail_number], 6        ; fail 6 time draw seconf leg
        je call_draw_second_leg
        cmp [fail_number], 7        ; fail 7 time write all letters and print lose msg
        je call_write_all_word        
        jmp main_game
   
   
       
       call_draw_head:
        call man_head
        jmp main_game
       
       call_draw_main_body:
        call draw_main_body
        jmp main_game
       
       call_draw_first_hand:
        call first_hand
        jmp main_game
        
       call_draw_second_hand:
        call second_hand
        jmp main_game
        
       call_draw_first_leg:
        call first_leg
        jmp main_game
       
       call_draw_second_leg:
        call second_leg
        jmp main_game
       call_write_all_word:
        call write_all_word   
    exit_game:   
        popa        
        ret       
    game endp    
    
    
start:
    mov ax,data
    mov ds,ax
    
    call game
    
    mov ax,4c00h
    int 21h
   
ends
end start        
