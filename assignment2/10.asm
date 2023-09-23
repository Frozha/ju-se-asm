.model small
.stack 100h
.data
    file1 db "abc.txt",0
    file2 db "abc1.txt",0
    msg1 db "file doesn't exist$"
    msg2 db "rename successful$"
.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov dx, offset file1
    mov di, offset file2
    
    mov ah, 56h
    int 21h
    
    jc nofile
    mov dx, offset msg2 
    
    mov ah, 09
    int 21h
    jmp endk
    
    
    nofile:
    mov dx, offset msg1
    mov ah, 09
    int 21h
    
    endk:
        mov ah, 4ch
        int 21h
main endp
end main