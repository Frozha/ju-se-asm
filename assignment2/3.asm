swp macro si, ax
    mov ax, [si]
    mov [si], ah
    inc si
    mov [si], al
    dec si
endm
printarr macro arra
    push si
    mov si, offset arra
    push cx
    mov cx, numofelem
    mov ah, 02h
    mov dx, '['
    int 21h
    mov dx, ' '
    int 21h
    prloop:
        mov dh, 0
        mov dl, [si]
        add dl, '0'
        int 21h
        mov dx, ' '
        int 21h
        inc si
    loop prloop
    mov dx, ']'
    int 21h
    pop cx
    pop si
endm
.model small
.stack 100h
.data
    arr1 db 2,8,4,1,3,7
    lastindex dw 5
    numofelem dw 6
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        
        mov cx, lastindex
        loop1:
            push cx
            mov ah, 02h
            mov dx, 10
            int 21h
            mov dx, 13
            int 21h
            mov si, offset arr1
            mov cx, lastindex
            printarr arr1
            loop2:
                mov dx, [si]
                cmp dl, dh
                jle finloop:
                swap:
                    swp si, ax
                finloop:
                    inc si
            loop loop2
            pop cx
        loop loop1
        mov ah, 4ch
        int 21h
    main endp
end main
