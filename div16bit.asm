.model small
.stack 100h
.data
	msg1 db 10,13, "Enter 32bit number:$"
	msg2 db 10,13, "Enter the 16bit number:$"
	msg3 db 10,13, "Quotient:$"
	msg4 db 10,13, "Remainder:$"
	v1 dw 0000h
	v2 dw 0000h
	v3 dw 0000h
	res dw 0000h
.code
	mov ax,@data
	mov ds,ax

	lea dx,msg1
	mov ah,09h
	int 21h

	call input
	mov v1,bx
	
	call input
	mov v2,bx

	lea dx,msg2
	mov ah,09h
	int 21h

	call input
	mov v3,bx

	mov ax,v2
	mov dx,v1

	call division
	
	lea dx,msg3
	mov ah,09h
	int 21h

	mov ax,v1
	mov res,ax

	call disp
	
	lea dx,msg4
	mov ah,09h
	int 21h

	mov ax,v2
	mov res,ax
	call disp

	mov ah,4ch
	int 21h

division proc
	div v3
	mov v1,ax
	mov v2,dx
	ret
division endp

disp proc
	mov ch,04h
	mov cl,04h
	mov bx,res
L1:	rol bx,cl
	mov dl,bl
	and dl,0fh
	cmp dl,09h
	jbe L2
	add ah,07h
L2:	add dl,30h
	mov ah,02h
	int 21h
	dec ch
	jnz L1
	ret
disp endp
	
input proc

	mov ch,04h
	mov cl,04h
	mov bx,0000h
L3:	shl bx,cl
	mov ah,01h
	int 21h
	cmp al,40h
	jbe L4
	sub al,07h
L4:	sub al,30h
	mov ah,00h
	add bx,ax
	dec ch
	jnz L3
	ret
input endp

end