;1's and 2's complement of a number
.model small
.data
	num db 0FH
	msg1 db "Number:$"
	msg2 db "1's complement:$"
	msg3 db "2's complement:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov cl, 04H
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	mov bh, num
	call PRINT
	call NEWLINE
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	mov bh, num
	xor bh, 0FFH
	call PRINT
	call NEWLINE
	lea dx, msg3
	mov ah, 09H
	int 21H
	call NEWLINE
	add bh, 01H
	call PRINT
	mov ah, 4CH
	int 21H

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

PRINT:	
	mov bl, 0F0H
	and bl, bh
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, bh
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	ret

CALC_OFFSET:
	cmp bl, 09H
	jc AHEAD
	jz AHEAD
	add bl, 37H
	jmp AHEAD_1
AHEAD:	add bl, 30H
AHEAD_1:	ret

	end
