.model small
.stack 100h
.data
    wrd1 dw 47
    wrd2 dw 92
.code
printwrd proc
    push ax
    push bx
    push cx
    push dx

    mov ax, [si]   
    mov bx, 10     
    mov cx, 0   
    
rep:   
    cmp ax, bx
    jl exrep
    div bx
    inc cx
    push dx
    jmp rep
    
exrep:
    inc cx
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
printwrd endp
   
swapwrds proc
    push bx  
    push cx 
    push dx

    mov cx, [si] 
    mov dx, [di]
    mov bx, si
    mov word[bx], dx
    mov bx, di
    mov word[bx], cx
    
    pop dx     
    pop cx
    pop bx
    ret
swapwrds endp

main proc
    mov ax, @data
    mov ds, ax 
    mov di, offset wrd1
    mov si, offset wrd1
    call printwrd 
    mov si, offset wrd2
    call printwrd 
                 
    
    call swapwrds

    mov si, offset wrd1
    call printwrd 
    mov si, offset wrd2
    call printwrd
    
    mov ah, 4ch
    int 21h

main endp
end main