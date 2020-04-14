;check functioning of xlat instruction
.model small
.data
	num db 11H, 22H, 33H, 44H, 55H
.code
	mov bx, @data
	mov ds, bx
	mov bx, offset num
	mov al, 02H
	xlat
	mov ah, 4CH
	int 21H
	end
