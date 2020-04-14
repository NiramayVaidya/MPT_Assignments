;find smallest number in given set of numbers
.model small
.stack 100H
.data
	msg1 db "Array:$"
	msg2 db "Smallest element is:$"
	;newline db 10,13,"$"
	;newline name for a reference variable does not work
	;assembler gives an error
	nl db 10, 13, "$"
	array db 0F2H, 6AH, 0C8H, 6EH, 0BBH, 14H
	smallest db ?
.code
	mov bx, @data
	mov ds, bx
	mov cl, 06H
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_ARRAY
	call NEWLINE
	mov cl, 06H
	lea bx, array
	mov al, [bx]
BACK:	dec cl
	jz FINISH
	inc bx
	cmp [bx], al
	jnc BACK
	mov al, [bx]
	jmp BACK
FINISH:	mov smallest, al
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_SMALLEST
	mov ah, 4CH
	int 21H

NEWLINE:
	;mov dl, 0AH
	;mov ah, 02H
	;int 21H
	;mov dl, 0DH
	;mov ah, 02H
	;int 21H
	lea dx, newline
	mov ah, 09H
	int 21H
	ret

PRINT_ARRAY:
	lea di, array
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

PRINT_SMALLEST:
	mov bl, 0F0H
	and bl, smallest
	mov cl, 04H
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, smallest
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	ret
	
TAB proc
	mov dl, 09H
	mov ah, 02H
	int 21H
	ret
TAB endp

CALC_OFFSET:
	cmp bl ,09H
	jc AHEAD
	jz AHEAD
	add bl, 37H
	jmp AHEAD_1
AHEAD:	add bl, 30H
AHEAD_1:	ret
	
	end
