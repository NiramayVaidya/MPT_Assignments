;block overlap
.model small
.data
	block1 db 11H, 22H, 33H, 44H, 55H
	block2 db 0AAH, 0BBH, 0CCH, 0DDH, 0EEH
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea si, block2
	lea di, block1
	lea bx, block2
	mov cl, 05H
BACK:	movsb
	mov byte ptr [bx], 00H
	inc bx
	loop BACK
	mov ah, 4CH
	int 21H

	end
