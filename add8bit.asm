;add two 8 bit hex numbers
.model small
.data
	msg1 db "The two hex numbers to be added are:$"
	msg2 db "The result of the addition in hex is:$"
	;this gives an error
	;newline db 0AH, 0DH, "$"
	num1 db 0AH
	num2 db 2CH
	num3 dw ?
.code
	mov ax, @data
	mov ds, ax
	mov cl, 04H
	;print msg1
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_FIRST_NUM
	call NEWLINE
	call PRINT_SECOND_NUM
	call NEWLINE
	;print msg2
	lea dx, msg2
	mov ah, 09H
	int 21H
	call NEWLINE
	mov bl, num1
	mov bh, num2
	add bh, bl
	jc TEMP
	and bl, 00H
	mov num3, bx
BACK:	mov cl, 04H
	call PRINT_ANS
	mov ah, 4CH
	int 21H	
TEMP:	and bl, 00H
	mov num3, bx
	or num3, 0001H
	jmp BACK

NEWLINE:
	mov dl, 0AH
	mov ah, 02H
	int 21H
	mov dl, 0DH
	mov ah, 02H
	int 21H
	ret

PRINT_FIRST_NUM:	
	mov bl, 0F0H
	and bl, num1
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, num1
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	ret

PRINT_SECOND_NUM:
	mov bl, 0F0H
	and bl, num2
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, num2
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	ret

PRINT_ANS:
	mov bx, 00F0H
	and bx, num3
	ror bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 000FH
	and bx, num3
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	;if value starts with A, B, C, D, E or F then put a 0 prior to it
	;otherwise the 8086 assembler does not recognize the value
	mov bx, 0F000H
	and bx, num3
	rol bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bx, 0F00H
	add cl, 04H
	and bx, num3
	rol bx, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	ret

CALC_OFFSET:
	cmp bx, 0009H
	jc AHEAD
	jz AHEAD
	add bx, 0037H
	jmp AHEAD_1
AHEAD:	add bx, 0030H
AHEAD_1:	ret
	
	end
