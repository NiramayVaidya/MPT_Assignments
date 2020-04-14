.model small
.stack 100h
.data
        msg1 db 10,13,"Enter 16bit no :$"
        msg2 db 10,13,"Enter 8bit no :$"
        msg3 db 10,13,"Multiplication Result:$"
        var1 db 00h
        var2 dw 0000h
        res dw 0000h
	mres dw 0000h
.code
	mov ax, @data
	mov ds, ax
	
	mov ah, 09h
        lea dx,msg1
	int 21h
	
        call input2 
        mov var2, bx
	
	mov ah, 09h
	lea dx,msg2
	int 21h
	
	call input1 
        mov var1, bl
	
	mov ah, 09h
        lea dx,msg3
	int 21h
        mov dx,0000h
	call muln

        call disp
	call disp1
     
	mov ah,4ch
	int 21h	

muln proc

        mov ax,var2
        mov bl,var1
        mov bh,00h
        mul bx
        mov res,dx
	mov mres, ax
	ret

muln endp

input1 proc

	mov ch,02h
	mov cl,04h
	mov bl,00h
L1:	shl bl,cl
	mov ah,01h
	int 21h
	cmp al,40h
	jbe L2
	sub al,07h
L2:	sub al,30h
	add bl,al
	dec ch
	jnz L1
	ret

input1 endp

input2 proc

	mov ch, 04h
	mov cl, 04h
	mov bx, 0000h
L3:	shl bx, cl
	mov ah, 01h
	int 21h
	cmp al,	40h
	jbe L4
	sub al, 07h
L4:	sub al, 30h
	mov ah, 00h
	add bx, ax
	dec ch
	jnz L3
	ret

input2 endp		


disp proc

	mov ch, 04h
	mov cl, 04h
        mov bx, res
L5:     rol bx, cl
	mov dl, bl
	and dl, 0fh
	cmp dl, 09h
        jbe L6
	add dl, 07h

	
L6:     add dl, 30h
	mov ah, 02h
	int 21h
	dec ch
        jnz L5
	ret

disp endp

disp1 proc

	mov ch, 04h
	mov cl, 04h
	mov bx, mres
L7:	rol bx, cl
	mov dl, bl
	and dl, 0fh
	cmp dl, 09h
	jbe L8
	add dl, 07h

	
L8:	add dl, 30h
	mov ah, 02h
	int 21h
	dec ch
	jnz L7
	ret

disp1 endp
end
