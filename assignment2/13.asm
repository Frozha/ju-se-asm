.model small
.stack 100h
.data
    cols db ?
    rows db ?
    msg1 db 0dh,0ah,'Total no of rows =','$'
    msg2 db 0dh,0ah,'Total no of columns =','$'
    msg3 db 0dh,0ah,'Press any key to clear screen','$'
    newl db 10, 13, '$'
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
        mov ah, 0fh
        int 10h
        mov cols, ah

        mov dx, offset msg2
        mov ah, 09h
        int 21h
        mov si, offset cols
        call printdb
        
        push ds
        mov ax, 0040h
        mov ds, ax
        mov si, 004ch
        mov ax, [si]
        pop ds
        
        mov cx, 0
        mov cl, cols
        shr al, 1
        div cl
        mov ah, 0
        mov cl, 2
        div cl
        mov rows, al

        mov dx, offset msg1
        mov ah, 09h
        int 21h
        mov si, offset rows
        call printdb

        mov dx, offset msg3
        mov ah, 09h
        int 21h
        mov ah, 01h
        int 21h
        mov cx, 0
        mov cl, rows
        mov dx, offset newl
        mov ah, 09h
        clrsc:
            int 21h
        loop clrsc

        mov ah, 4ch
        int 21h
    main endp
end main
