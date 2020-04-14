;compare two strings
.model small
.data
	str1 db "coep123$"
	str2 db "coep123$"
	msg1 db "The two strings are equal$"
	msg2 db "The two strings are not equal$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea si, str1
	lea di, str2
	mov cx, 0008H
	repz cmpsb
	cmp cl, 00H
	jz AHEAD
	lea dx, msg2
BACK_1:	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H
AHEAD:	lea dx, msg1
	jmp BACK_1

	end
