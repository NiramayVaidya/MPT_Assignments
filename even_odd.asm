.8086
.model small
.stack 512
.data
	msg db 0ah, 0dh, "Enter The Number: $"
    a db 00h
	ev db 0ah, 0dh,"Given Number Is Even$"
	odd db 0ah, 0dh,"Given Number Is odd$"
.code
	mov ax, @data
    mov ds, ax
 	mov ah, 09h
	mov dx, offset msg
	int 21h
	call inp 
	rcr bl, 01h
	jc ode
	mov dx, offset ev
	mov ah, 09h
	int 21h
	jmp ok
	ode:
	mov dx, offset odd
	mov ah, 09h
	int 21h
	ok:
	mov ah, 4ch
	int 21h
	
inp proc
	xor bx, bx	
	mov cl, 04h
	mov ch, 02h
   here:
	mov ah, 01h
	int 21h
	cmp al, 41h
	jb numer
	sub al, 07h
	sub al, 30h
	jmp next
   numer: 
	sub al, 30h
   next:	
	shl bl, cl
	add bl, al
	dec ch
	cmp ch, 00h
	jnz here
	ret
inp endp
	
	
	end