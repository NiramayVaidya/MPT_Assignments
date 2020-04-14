;find substring and delete it
.model small
.data
	str db "my name is khan$"
	substr db "name$"
	msg1 db "string:$"
	msg2 db "string after deletion of substring:$"
	msg3 db "substring not found$"
	new db 0AH, 0DH, "$"
	len db 04H
	dollar equ 24H
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
	lea si, substr
	lea di, str
	mov cl, len
BACK:	cmpsb
	jz AHEAD
	cmp byte ptr [di], dollar
	jz OVER_1
	mov cl, len
	lea si, substr
	jmp BACK
AHEAD:	dec cl
	jz OVER
	jmp BACK
OVER:	mov si, di
	mov cl, len
	mov ch, 00H
	sub si, cx
	mov bx, si
	mov si, di
	mov di, bx
	cmp byte ptr [si], dollar
	jz NEXT
BACK_1:	lodsb
	stosb
	cmp byte ptr [si], dollar
	jz NEXT
	jmp BACK_1
NEXT:	lodsb
	stosb
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str
	mov ah, 09H
	int 21H
BACK_2:	mov ah, 4CH
	int 21H
OVER_1:	lea dx, msg3
	mov ah, 09H
	int 21H
	jmp BACK_2

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

	end
