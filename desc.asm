;arrange array in descending order
.model small
.data
	array db 0CBH, 0F1H, 55H, 89H, 0AEH
	msg1 db "Array:$"
	msg2 db "Sorted descending array:$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov cl, 05H
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_ARRAY
	call NEWLINE
	mov cx, 0505H
BACK_1:	lea bx, array
BACK:	mov al, [bx]
	dec cl
	jz AHEAD	
	inc bx
	cmp al, [bx]
	jnc BACK
	mov ah, [bx]
	mov [bx], al
	mov [bx - 0001H], ah
	jmp BACK
AHEAD:	dec ch
	jz FINISH
	mov cl, ch
	jmp BACK_1
FINISH:	mov cl, 05H
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_ARRAY
	mov ah, 4CH
	int 21H

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

PRINT_ARRAY:
	lea di, array
	mov ch, 04H
BACK_2:	mov bh, cl
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
	jnz BACK_2
	ret

TAB:
	mov dl, 09H
	mov ah, 02H
	int 21H
	ret

CALC_OFFSET:
	cmp bl ,09H
	jc AHEAD_1
	jz AHEAD_1
	add bl, 37H
	jmp AHEAD_2
AHEAD_1:	add bl, 30H
AHEAD_2:	ret

	end
