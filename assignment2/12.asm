.model small
.stack 100h
.data
    matrix1 db 1, 2, 3, 4, 5, 6, 7, 8, 9    ; First 3x3 matrix
    matrix2 db 9, 8, 7, 6, 5, 4, 3, 2, 1    ; Second 3x3 matrix
    result db 0, 0, 0, 0, 0, 0, 0, 0, 0     ; Resultant matrix  
    temp db ?
    dim db 3
    dimw dw 3 
    newl db 10, 13,'$'
.code  
printword proc
    push ax
    push bx
    push cx
    push dx

    mov al, [si]
    mov ah, 0    
    mov cx, 10      
    mov bx, 0       
    
    rep1:   
        xor dx, dx       
        div cx           
        push dx          
        inc bx           
        test ax, ax      
        jnz rep1        
    
    printloop:
        pop dx          
        add dl, '0'     
        mov ah, 02h    
        int 21h         
        dec bx          
        jnz printloop    
    
    mov dl, ' '          
    mov ah, 02h          
    int 21h          
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
printword endp



matxprnt proc
    mov cx, dimw
    prloop1:     
        mov dx, offset newl
        mov ah, 09h
        int 21h
        push cx
        mov cx, dimw
        prloop2:
            mov si, di    
            call printword
            inc di
        loop prloop2
        pop cx
    loop prloop1 
            
    ret
matxprnt endp

main proc
    mov ax, @data
    mov ds, ax
   
    mov cx, dimw
    
    mov bx, offset matrix2
                     
    mov di, offset result 

    rowsel:   
        mov si, offset matrix1  
        mov ax, dimw
        sub ax, cx
        mul dim
        add si, ax
        push cx
        mov ch,0
        mov cl, dim
        colsel: 
            mov temp, 0
            mov bx, offset matrix2 
            mov ax, dimw
            sub ax, cx
            add bx, ax 
            push cx
            mov cx, dimw
            mov temp, 0 
            push si
            calc:
                    
                mov al, [si]
                mov dl, [bx]
                mov ah, 0
                mul dl
                add temp, al
                inc si 
                add bx, dimw
            loop calc 
            pop si
            mov al, temp
            mov [di], al
            inc di
            pop cx
        loop colsel
        pop cx
    loop rowsel
    
    mov di, offset result
    call matxprnt

    mov ah, 4Ch                 
    int 21h                     

main endp
end main
