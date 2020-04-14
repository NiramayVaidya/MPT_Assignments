;concatenate two strings
.model small
.data
	str1 db "This is$"
	str2 db " coep$"
	msg1 db "Individual strings are:$"
	msg2 db "After concatenation, the string is:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str1
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str2
	mov ah, 09H
	int 21H
	call NEWLINE
	mov al, 24H
	mov cx, 00FFH
	lea di, str1
	repnz scasb
	dec di
	lea si, str2
	mov cx, 00FFH
BACK:	cmp [si], al
	jz AHEAD
	movsb
	loop BACK
AHEAD:	movsb
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str1
	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

	end
