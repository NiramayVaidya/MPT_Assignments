;check if a string is a palindrome
.model small
.data
	str db "coeppeoc$"
	new db 0AH, 0DH, "$"
	msg1 db "String:$"
	msg2 db "String is a palindrome$"
	msg3 db "String is not a palindrome$"
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str
	mov ah, 09H
	int 21H
	call NEWLINE
	lea di, str
	lea si, str
	mov cx, 0000H
	mov al, 24H
BACK:	scasb
	jz AHEAD
	inc cl
	jmp BACK
AHEAD:	sub di, 0002H
	mov al, cl
	mov ah, 00H
	mov bl, 02H
	div bl
	mov cl, al
BACK_1:	cmpsb
	jnz	OVER
	sub di, 0002H
	dec cl
	jnz BACK_1
	lea dx, msg2
BACK_2:	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H
OVER:	lea dx, msg3
	jmp BACK_2

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

	end
