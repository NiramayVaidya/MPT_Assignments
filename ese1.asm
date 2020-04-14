.model small
.data
	array dw 1234H, 4321H
.code
	mov bx, @data
	mov ds, bx
	lea bx, array
	mov ax, [bx]
	cmp ax, [bx + 0002H]
	mov ah, 4CH
	int 21H

	end
