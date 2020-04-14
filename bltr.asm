;block transfer
.model small
.data
	block1 db 11H, 22H, 33H, 44H, 55H
	block2 db 5 dup(?)
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea si, block1
	lea di, block2
	lea bx, block1
	mov cl, 05H
BACK:	movsb
	mov byte ptr [bx], 00H
	inc bx
	loop BACK
	mov ah, 4Ch
	int 21H

	end
	
