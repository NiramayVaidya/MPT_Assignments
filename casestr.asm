;change case of a string
;assumption that the input is string contains only characters,
;no error checking done
.model small
.data
	str db "cOeP$"
	new db 0AH, 0DH, "$"
	msg1 db "String:$"
	msg2 db "String with changed case:$"
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
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	mov cl, 04H
	mov al, 5AH
	lea di, str
BACK:	scasb
	jc AHEAD
	dec di
	add byte ptr [di], 20H
BACK_1:	inc di
	dec cl
	jnz BACK
	lea dx, str
	mov ah, 09H
	int 21H
	mov ah, 4CH
	int 21H
AHEAD:	dec di
	sub byte ptr [di], 20H
	jmp BACK_1

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret
	
	end
