;check if substring present or not
.model small
.data
	str1 db "coepcion, drama, coer$"
	str2 db "coep$"
	msg1 db "subtring present$"
	msg2 db "substring not present$"
	msg3 db "String to search in:$"
	msg4 db "String to be searched:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea dx, msg3
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str1
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, msg4
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str2
	mov ah, 09H
	int 21H
	call NEWLINE
	lea si, str2
	lea di, str1
	mov ch, 04H
BACK:	cmpsb
	jz AHEAD
	mov ch, 04H
	lea si, str2
	cmp byte ptr [di], 24H
	jz OVER_1
	jmp BACK
AHEAD:	dec ch
	cmp ch, 00H
	jz OVER
	jmp BACK
OVER:	lea dx, msg1
	mov ah, 09H
	int 21H
BACK_1:	mov ah, 4CH
	int 21H
OVER_1:	lea dx, msg2
	mov ah, 09H
	int 21H
	jmp BACK_1

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

	end	
	
