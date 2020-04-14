.model small
.data
	str db 8 dup(?)
.code
	mov bx, @data
	mov ds, bx
	mov dx, offset str
	mov ah, 0AH
	int 21H
	lea dx, str
	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H
	end
