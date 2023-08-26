strprint macro str
    mov dx, offset str
    mov ah, 09h
    int 21h
endm

.model small
.stack 100h
.data
    inpnumstr db 100 dup("$")
    num db 0
    msg db "number in decimal : $"
    msgbin db "binary : $"
    msghex db "hexadeximal : $"
.code
    main proc
        mov ax, @data
        mov ds, ax

        strprint msg

        mov si, offset inpnumstr
        mov cl, 10
        mov dl, 0
        getnum:
            mov ah, 01h
            int 21h
            cmp al, 13
            je binary
            mov [si], al
            sub al, 48
            mov dl, al
            xor ax, ax
            mov al, num
            mul cl
            mov num, al
            add num, dl
            inc si
        jne getnum

        binary:

        xor ax, ax
        mov cl, 2
        mov al, num
        mov bl, 0

        tobinary:
            div cl
            mov bh, al
            xor al, al
            add ah, 48
            mov al, ah
            xor ah, ah
            push ax
            inc bl
            mov al, bh
            cmp al, 0
            jne tobinary
        
        printbin:
            call nextline
            strprint msgbin
            xor cx, cx
            mov cl, bl
            mov ah, 02
            crtstr:
                xor dx,dx
                pop dx
                int 21h
            loop crtstr

        hex:
        xor ax, ax
        mov cl, 16
        mov al, num
        mov bl, 0
        tohex:
            div cl
            xor dx,dx
            mov dl, ah
            cmp ah, 10
            jge hexi
                add dl, 48
            jmp conthex
            hexi:
                add dl, 87
            conthex:
                push dx
                inc bl
            xor ah,ah
            cmp al, 0
            jne tohex
        
        
        printhex:
            call nextline
            strprint msghex
            xor cx, cx
            xor dx, dx
            mov cl, bl
            mov ah, 02h
            poploop:
                pop dx
                int 21h
            loop poploop



        mov ah, 4ch
        int 21h
    main endp
    nextline proc
        mov dx, 10
        mov ah, 2
        int 21h
        mov dx, 13
        int 21h
        ret
    nextline endp
    end main


