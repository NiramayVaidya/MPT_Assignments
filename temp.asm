;testing
.model small
.data
	num db 99H
.code
	mov bx, @data
	mov ds, bx
	mov bl, num
	mov ah, 4CH
	int 21H
	end
