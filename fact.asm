;finding factorial of a number
;this code will not give correct answer of factorial beyond 0008H number 
.model small
.data
	num dw 0008H
	fact dw ?
	msg1 db "number:$"
	msg2 db "factorial of the number:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov cl, 04H

	;msg1
	lea dx, msg1
	mov ah, 09H
	int 21H

	;newline
	lea dx, new
	mov ah, 09H
	int 21H

	;num
	mov bx, 0F000H
	and bx, num
	rol bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 0F00H
	and bx, num
	add cl, 04H
	rol bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 00F0H
	and bx, num
	sub cl, 04H
	ror bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 000FH
	add cl, 04H
	and bx, num
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H

	;newline
	lea dx, new
	mov ah, 09H
	int 21H
	
	mov ax, num
BACK:	dec num
	mul num
	mov cx, num
	cmp cx, 0001H
	jnz BACK
	mov si, ax

	;msg2
	lea dx, msg2
	mov ah, 09H
	int 21H

	;newline
	lea dx, new
	mov ah, 09H
	int 21H

	mov cl, 08H
	rol si, cl
	mov fact, si
	mov cl, 04H

	;factorial
	mov bx, 00F0H
	and bx, fact
	ror bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 000FH
	and bx, fact
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 0F000H
	and bx, fact
	rol bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 0F00H
	add cl, 04H
	and bx, fact
	rol bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov ah, 4CH
	int 21H

CALC_OFFSET:
	cmp bx, 0009H
	jc AHEAD
	jz AHEAD
	add bx, 0037H
	jmp AHEAD_1
AHEAD:	add bx, 0030H
AHEAD_1:	ret

	end
