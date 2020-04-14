;calculate the fibonacci sequence given the number of terms
;correct fibonacci sequence will not be displayed beyond 0A number of terms
.model small
.data
	terms db 0AH dup(?)
	cnt db 0AH
	msg1 db "No. of terms:$"
	msg2 db "Fibonacci sequence:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	lea si, terms
	mov cl, 04H
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_TERM
	call NEWLINE	
	mov al, 00H
	mov bl, 01H
	mov cl, cnt
BACK:	add al, bl
	daa
	mov [si], al
	mov al, bl
	mov bl, [si]
	inc si
	loop BACK
	lea dx, msg2
	mov ah, 09H
	int 21H
	mov cl, cnt
	call NEWLINE
	call PRINT_SEQ
	mov ah, 4CH
	int 21H

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

PRINT_TERM:
	mov al, cnt
	add al, 00H
	daa
	mov bl, 0F0H
	and bl, al
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	mov al, cnt
	add al, 00H
	daa
	and bl, al
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	ret

PRINT_SEQ:	
	lea di, terms
	mov ch, 04H
BACK_1:	mov bh, cl
	mov cl, ch
	mov bl, 0F0H
	and bl, [di]
	rol bl, cl
	mov cl, bh
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, [di]
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	call TAB
	inc di
	dec cl
	jnz BACK_1
	ret	

TAB:
	mov dl, 09H
	mov ah, 02H
	int 21H
	ret

CALC_OFFSET:
	cmp bl ,09H
	jc AHEAD
	jz AHEAD
	add bl, 37H
	jmp AHEAD_1
AHEAD:	add bl, 30H
AHEAD_1:	ret

	end
