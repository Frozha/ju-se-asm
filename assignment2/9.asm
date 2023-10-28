.model small
.stack 100h
.data
    x db 42h
    y db 27h
    bcdres dw ?
    addreslt dw ?
    a dw ?
    b dw ?
    base10 db 10
    newl db 13, 10, '$'
    msg1 db 'sum of x and y using DAA : $'
    msg2 db 'sum of x and y using normal addition : $'
.code
    hexprint proc ;8bits
        ;data to print is pointed by si
        push ax
        push bx
        push cx
        push dx

        mov bl, [si]
        mov bh, [si]

        shr bh, 1
        shr bh, 1
        shr bh, 1
        shr bh, 1
        and bl, 00001111b
        ;bh has higher 4 bits
        ;bl has lower 4 bits

        mov dx, 0
        prhigh:
            mov dl, bh
            add dl, '0'
            cmp dl, '9'
            jle exechigh
            add dl, 7
        exechigh:
            mov ah, 02h
            int 21h
        
        prlow:
            mov dl, bl
            add dl, '0'
            cmp dl, '9'
            jle execlow
            add dl, 7
        execlow:
            mov ah, 02h
            int 21h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    hexprint endp
    bcdtodec proc ;8bits
        ;si points to bcd format
        ;di points to converted decimal
        push ax
        push bx
        push cx
        push dx

        mov dx, 0
        mov dl, base10
        mov bh, 0
        mov ch, 0
        
        mov bl, [si]
        mov cl, [si]
        shr bl, 1
        shr bl, 1
        shr bl, 1
        shr bl, 1
        and cl, 00001111b
        ;bl has higher 4 bits
        ;cl has lower 4 bits

        mov ax, 0
        mov al, bl
        mul dl
        add ax, cx

        mov word ptr [di], ax
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    bcdtodec endp
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

        mov ax, 0
        mov al, x   
        add al, y  
        daa 
        mov bcdres, ax 

        mov dx, offset msg1
        mov ah, 09h
        int 21h

        mov si, offset bcdres
        call hexprint

        mov si, offset x
        mov di, offset a
        call bcdtodec
        mov si, offset y
        mov di, offset b
        call bcdtodec

        mov ax, a
        add ax, b
        mov addreslt, ax
        
        mov dx, offset newl
        mov ah, 09h
        int 21h
        mov dx, offset msg2
        mov ah, 09h
        int 21h

        mov si, offset addreslt
        call printword

        mov ah, 4ch 
        int 21h
    main endp
end main