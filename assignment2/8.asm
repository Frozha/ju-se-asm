.model small
.stack 100h
.data
    num1 dd 2147483647
    num2 dd 2147483647     
    result dd ? 
    msg1 db 'overflow$' 
    msg2 db 'result in hex : $'
.code  
    printhex proc
        push ax
        push bx
        push cx
        push dx
        
        mov dl, [si]
        
        mov bl, dl  
        shr dl, 1
        shr dl, 1
        shr dl, 1
        shr dl, 1   
        and bl, 0Fh 
    
        add dl, '0'
        cmp dl, '9'
        jle prnt
        add dl, 7 
        prnt:
        mov ah, 02h 
        int 21h
    
        mov dl, bl
        add dl, '0'
        cmp dl, '9'
        jle prnt2 
        add dl, 7 
        prnt2:
        mov ah, 02h 
        int 21h
    
    
        pop dx
        pop cx
        pop bx
        pop ax
    
        ret
    printhex endp  
    main proc   
        mov ax, @data
        mov ds, ax         
        
        mov cx, num1
        mov si, offset num1
        mov dx, [si+2]
        
        mov ax, num2
        mov si, offset num2
        mov bx, [si+2]
        
        add dx, bx
        jc ovrflw
        add cx, ax
        jnc saveres
        add dx, 1
        jc ovrflw
        
        saveres:
            push dx 
            mov dx, offset msg2
            mov ah, 09h
            int 21h
            pop dx 
            mov si, offset result
            mov word ptr[si+2], dx
            add result, cx 
            add si,3
            call printhex 
            dec si
            call printhex 
            dec si
            call printhex
            dec si
            call printhex
            mov dx, 'h'
            mov ah, 02h
            int 21h
            
            jmp trmin
            
        ovrflw:
            mov dx, offset msg1
            mov ah, 09h
            int 21h
        trmin:
        mov ah,4ch
        int 21h
    main endp
end main