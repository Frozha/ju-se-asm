.model small
.stack 100h
.data
    m db 48
    n db 60
    res db ?  
    msg1 db 'G.C.D. = $' 
.code
    printdb proc
        push ax
        push bx
        push cx
        push dx

        mov al, [si]
        mov ah, 0
        mov bl, 10  
        mov bh, 0   
        mov cx, 0   
        rep1:   
            cmp al, bl
            jl exrep
            div bl
            inc cx
            mov dl, ah
            mov dh, 0
            push dx
            jmp rep1  
        exrep:
            inc cx
            mov dl, al
            mov dh, 0
            push ax   
        printloop:
            pop dx
            add dl, '0'
            mov ah, 02h
            int 21h
        loop printloop 
        mov dl, ' '
        mov ah, 02h
        int 21h
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    printdb endp

    main proc
        mov ax, @data
        mov ds, ax

        mov ax, 0
        mov al, m
        mov bx, 0
        mov bl, n
        
        cmp al, bl
        jge loop1

        mov dl, al
        mov al, bl
        mov bl, dl

        loop1:
            div bl
            mov al, bl
            mov bl, ah
            cmp ah, 0
            mov ah, 0
            jne loop1

        mov res, al  
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        mov si, offset res
        call printdb
        mov ah, 4ch
        int 21h       

    main endp
end main
