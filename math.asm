;performing mathematical operations
;(a+b)*(c+d)
;(a*b)+(c*d)
;limitations- does not work when the mathematical operations generate
;a hex number having 3 or more hex digits
.model small
.data
	a db 0AH
	b db 02H
	c db 0FH
	d db 05H
	msg1 db "Numbers: a, b, c, d$"
	exp1 db "(a+b)*(c+d):$"
	exp2 db "(a*b)+(c*d):$"
	new db 0AH, 0DH, "$"
.code
	mov bx, @data
	mov ds, bx
	mov cl, 04H
	lea dx, msg1
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_NUMS
	call NEWLINE
	mov al, a
	add al, b
	mov ah, c
	add ah, d
	mul ah
	mov bh, al
	lea dx, exp1
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_ANS
	call NEWLINE
	mov al, a
	mov bl, b
	mul bl
	mov bh, al
	mov al, c
	mov bl, d
	mul bl
	add al, bh
	mov bh, al
	lea dx, exp2
	mov ah, 09H
	int 21H
	call NEWLINE
	call PRINT_ANS
	mov ah, 4CH
	int 21H

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

PRINT_ANS:	
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

PRINT_NUMS:	
	mov bl, 0F0H
	and bl, a
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, a
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	call TAB
	mov bl, 0F0H
	and bl, b
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, b
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	call TAB
	mov bl, 0F0H
	and bl, c
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, c
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	call TAB
	mov bl, 0F0H
	and bl, d
	rol bl, cl
	call CALC_OFFSET
	mov dl, bl
	mov ah, 02H
	int 21H
	mov bl, 0FH
	and bl, d
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

TAB: 
	mov dl, 09H
	mov ah, 02H
	int 21H
	ret
	
	end
