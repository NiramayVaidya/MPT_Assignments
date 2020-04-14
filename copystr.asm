.8086
.model small
.stack 256
.data
        mx db "abcde$"
        my db "      "
.code
        mov ax,@data
        mov ds,ax
        mov es,ax
        mov si,offset mx
        mov di,offset my
        mov bl,24h
 again: cld
        lodsb
        cmp al, 24h
        jz done
        stosb
        jmp again
  done: mov [di],bl
        mov dx,offset my
        mov ah,09h
        int 21h
        mov ax,4c00h
        int 21h
        end
