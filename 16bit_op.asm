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
	msg8 db 10,13,"Enter 32bit(divident) no :$"
	msg9 db 10,13,"Enter 16bit(divisor) no :$"
	var1 dw 0000h
	var2 dw 0000h
	var3 dw 0000h
	res dw 0000h
	
.code
	mov ax,@data
	mov ds,ax

	mov ah,09h
	lea dx,msg1
	int 21h
	
	call input1
	mov var1,bx
	
	lea dx,msg2
	mov ah,09h
	int 21h

	call input1
	mov var2,bx
	
	lea dx,msg3
	mov ah,09h
	int 21h

	call sum
	call display1
	
	lea dx,msg4
	mov ah,09h
	int 21h
        
        call substract
	call display1
	
	lea dx,msg5
	mov ah,09h
	int 21h
	
	call multi
	call display1
	
	mov ax,var1
	mov res,ax
	call display1
	
	lea dx,msg8
	mov ah,09h
	int 21h
	
	call input1
	mov var1,bx

	call input1
	mov var2,bx
	
	lea dx,msg9
	mov ah,09h
	int 21h
	call input1
	mov var3,bx

	call division
	
	lea dx,msg6
	mov ah,09h
	int 21h

	mov ax,res
	mov var1,ax
	and res,000fh
	call display1

	lea dx,msg7
	mov ah,09h
	int 21h
	
	mov ax,var1
	mov res,ax
	and res,00f0h
	call display1

	
	mov ah,4ch
	int 21h
	

sum proc
	mov ax,var1
	add ax,var2
	mov res,ax
	ret
sum endp

substract proc
	mov ax,var1
	sub ax,var2
	mov res,ax
	ret
substract endp

multi proc
	mov ax,var1
	mul var2
	mov res,dx
	mov var1,ax
	ret
multi endp

division proc
	mov dx,var1
	mov ax,var2
	div var3
	mov res,ax
	ret
division endp

display1 proc
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
display1 endp
	
input1 proc

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
input1 endp

end

	
