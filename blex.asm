;block exchange
.model small
.data
	block1 db 11H, 22H, 33H, 44H, 55H
	block2 db 0AAH, 0BBH, 0CCH, 0DDH, 0EEH
.code
	mov bx, @data
	mov ds, bx
	lea si, block1
	lea di, block2
	mov cl, 05H
BACK:	mov bl, [si]
	mov bh, [di]
	mov [si], bh
	mov [di], bl
	inc si
	inc di
	dec cl
	jnz BACK
	mov ah, 4CH
	int 21H

	end
