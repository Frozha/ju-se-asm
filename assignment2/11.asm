swap macro addrs1, addrs2
    push si
    push di
    push ax
    push bx

    mov si, addrs1
    mov di, addrs2

    mov ax, [si]
    mov bx, [di]
    mov word ptr [si], bx
    mov word ptr [di], ax 

    pop bx
    pop ax
    pop di
    pop si
endm
.model small
.stack 100h
.data
    num1 dw 12
    num2 dw 15
    msg1 db 'numbers in order before swap : $'
    msg2 db 'numbers in order after swap : $'
    newl db 10 , 13 , '$'
.code
    printword proc
        ;si must point to word
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
    main proc
        mov ax, @data
        mov ds, ax

        mov cx, offset num1
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        mov dx, offset num2
        
        mov si, cx
        call printword
        mov si, dx
        call printword

        swap cx, dx

        mov dx, offset newl
        mov ah, 09h
        int 21h
        mov dx, offset msg2
        mov ah, 09h
        int 21h

        mov si, offset num1
        call printword
        mov si, offset num2
        call printword
        
        mov ah, 4ch
        int 21h
    main endp
end main