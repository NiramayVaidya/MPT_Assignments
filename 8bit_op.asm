.model small
.stack 100h
.data
	msg1 db 10,13,"Enter 1st no :$"
	msg2 db 10,13,"Enter 2nd no :$"
	msg3 db 10,13,"Addition :$"
	msg4 db 10,13,"Substraction :$"
	msg5 db 10,13,"Multiplication :$"
	msg6 db 10,13,"Quotient is :$"
	msg7 db 10,13,"Remainder is :$"
	msg8 db 10,13,"Enter 16bit(divident) no :$"
	msg9 db 10,13,"Enter 8bit(divisor) no :$"
	var1 db 00h
	var2 db 00h
	var3 dw 0000h
	res db 00h
	mres dw 0000h
.code
	mov ax, @data
	mov ds, ax
	
	mov ah, 09h
	lea dx,msg1
	int 21h
	
	call input1 
	mov var1, bl
	
	mov ah, 09h
	lea dx,msg2
	int 21h
	
	call input1 
	mov var2, bl
	
	mov ah, 09h
	lea dx,msg3
	int 21h
	
	call addn
	
	call disp

	mov ah, 09h
	lea dx,msg4
	int 21h
	
	call subn
	
	call disp
	
	mov ah, 09h
	lea dx,msg5
	int 21h
	
	call muln
	
	call disp1
		
	mov ah, 09h
	lea dx,msg8
	int 21h

	call input2
	mov var3, bx

	mov ah, 09h
	lea dx,msg9
	int 21h
		
	call input1
	mov var2, bl
	
	mov ah, 09h
	lea dx,msg6
	int 21h
	
	call divn
	
	call disp
	
	mov ah, 09h
	lea dx,msg7
	int 21h
	
	mov res, bh
	
	call disp
	
	mov ah,4ch
	int 21h	


addn proc

	mov al,var1
	mov bl,var2
	add al,bl	
	mov res, al
	ret

addn endp

subn proc

	mov al,var1
	mov bl,var2
	sub al,bl	
	mov res, al
	ret

subn endp

muln proc

	mov al,var1
	mov bl,var2
	mul bl	
	mov mres, ax
	ret

muln endp

divn proc
	mov ax, var3
	mov bl, var2	
	div bl	
	mov res, al
	mov bh, ah
	ret

divn endp

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