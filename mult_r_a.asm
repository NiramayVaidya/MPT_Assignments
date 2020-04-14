.8086
.model small
.stack 256
.data
        msg1 db 10,13, "Enter first number: $"
        msg2 db 10,13, "Enter second number: $"
        msg3 db 10,13, "Result: $"
	var1 db 00h
	var2 db 00h
	res db 00h
.code
	mov ax, @data
	mov ds, ax

	mov dx, offset msg1
	mov ah, 09h
	int 21h
	call input
	mov var1, bl
	mov dx, offset msg2
	mov ah, 09h
	int 21h
	call input
	mov var2, bl
        mov dx, offset msg3
	mov ah, 09h
	int 21h
        call mulp
	mov res, dl
	call disp
	mov ax, 4c00h
	int 21h

 mulp proc
 	mov al, var1
 	mov bl, var2
 	xor dl, dl
 	mov cx, 0004h
 here:
 	dec cx
 	jz over
 	rcr bl, 01
        jc here1
        shl al,01
        jmp here
 here1: add dl, al
        shl al,01
 	jmp here
 over:
 	ret
 mulp endp

input proc

	mov ch,02h
	mov cl,04h
	mov bl,00h
 L1:shl bl,cl
	mov ah,01h
	int 21h
	cmp al,40h
	jbe L2
	sub al,07h
 L2:sub al,30h
	add bl,al
	dec ch
	jnz L1
	ret

input endp

disp proc

	mov ch, 02h
	mov cl, 04h
	mov bl, res
L5:	rol bl,cl
	mov dl,bl
	and dl,0fh
	cmp dl,09h
	jbe L6
	add dl,07h
L6:	add dl,30h
	mov ah,02h
	int 21h
	dec ch
	jnz L5
	ret

disp endp

end
