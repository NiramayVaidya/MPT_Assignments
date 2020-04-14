;check if input password matches stored password or not
.model small
.data
	password db "coep123$"
	prompt db "Enter Password: $"
	errmsg db "Incorrect Password$"
	validmsg db "Correct Password$"
.code
	mov bx, @data
	mov ds, bx
	lea dx, prompt
	mov ah, 09H
	int 21H
	mov cx, 0007H
	lea si, password
	mov bl, 00H
INPUT:	mov ah, 01H
	int 21H
	cmp al, [si]
	jnz BACK
	inc si
	dec cx 
	jnz INPUT
	cmp bl, 99H
	jz WRONG
	lea dx, validmsg
	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H
BACK:	mov bl, 99H
	inc si
	dec cx 
	jnz INPUT
WRONG:	lea dx, errmsg
	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H
	end
