;finding length of a string and reversing it
.model small
.data
	str db "coep123$"
	strrev db "        "
	msg1 db "Print string:$"
	msg2 db "Print reversed string:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov es, bx
	lea di, str
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, str
	mov ah, 09H
	int 21H
	call NEWLINE
	mov cx, 00FFH
	mov al, 24H
BACK:	inc ch
	scasb
	loopnz BACK
	dec ch
	mov al, ch
	mov cl, ch
	mov ch, 00H
	dec di
	mov bl, [di]
	dec di
	mov si, di
	lea di, strrev
BACK_1:	movsb
	sub si, 0002H
	loop BACK_1
	mov [di], bl
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	lea dx, strrev
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
