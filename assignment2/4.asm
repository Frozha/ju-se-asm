.model small
.stack 100h
.data
    arr1 db 25,4,54,255,3,5,7,12,3,21
    msg1 db 'enter 8-bit key to search in array : $'                                          
    msg2 db ' (overflow) key too large! $'
    msg3 db 'key not found in array$'
    msg4 db 'key found at index : $'
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        
        mov cx, 10 
        mov dx, 0
        uinput:
            mov ah, 01h
            int 21h
            cmp al, 13
            je linsrch
            sub al, '0'
            mov bl, al
            mov al, dl
            mov ah, 0
            mul cl
            jc overflw 
            add al, bl
            ;cmp ah, 0
            jc overflw
            mov dl, al
        jmp uinput
        overflw:
            mov dx, offset msg2
            mov ah, 09h
            int 21h
            jmp trmin
        linsrch:
            mov cx, 10
            mov si, offset arr1
            srloop:
                cmp dl, [si]
                je found
                inc si
            loop srloop
            mov dl, 13
            mov ah, 02h
            int 21h
            mov dl, 10
            int 21h
            mov dx, offset msg3
            mov ah, 09h
            int 21h
            jmp trmin
            found:
                mov dl, 13
                mov ah, 02h
                int 21h
                mov dl, 10
                int 21h
                mov dx, offset msg4
                mov ah, 09h
                int 21h
                mov dx, si
                add dl, '0'
                mov ah, 02h
                int 21h
            
            
        
        trmin:
            mov ah, 4ch
            int 21h
    main endp
end main