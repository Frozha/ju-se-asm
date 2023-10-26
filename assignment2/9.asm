.model small
.data
    x db 01000010b  ;42 in bcd  
    y db 00100111b  ;27 in bcd
    a db ?
    b db ?   
    result1 db ?
    result2 db ?  
    newl db 13, 10, '$'
    msg1 db 'sum of x and y using DAA : $'
    msg2 db 'sum of x and y using normal addition : $'
.code
printhex proc
    push ax
    push bx
    push cx
    push dx
    
    mov dl, [si]
    
    mov bl, dl  
    shr dl, 4   
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

bcdtodec proc;8bit only
    push ax
    push bx
    push dx
    
    mov bx, 10
    mov dl, [si]
    mov dh,dl
    shr dh, 4
    and dl, 00001111b
    mov ax,0
    mov al, dh
    mul bl
    add al, dl
    mov byte [di], al
    
    pop dx
    pop bx
    pop ax
    ret
bcdtodec endp


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
    rep:   
        cmp al, bl
        jl exrep
        div bl
        inc cx
        mov dl, ah
        mov dh, 0
        push dx
        jmp rep  
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
    mov al, x   
    add al, y  
    
    daa        
    
    mov result1, al
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    mov si, offset result1 
    call printhex

    mov si, offset x
    mov di, offset a 
    call bcdtodec
    
    mov si, offset y   
    mov di, offset b
    call bcdtodec 
    
    mov ah,09h  
    mov dx, offset newl
    int 21h
    mov dx, offset msg2
    int 21h
      
    mov dl, a
    add dl, b 
    mov result2, dl       
    mov si, offset result2   
    call printdb
    
    mov ah, 4Ch  ; Exit program
    int 21h
main endp
end main