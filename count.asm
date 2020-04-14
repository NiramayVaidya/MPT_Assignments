;count number of vowels and consonents in a string
.model small
.data
	str db "abcd$"
	msg1 db "string:$"
	msg2 db "vowel count:$"
	msg3 db "consonant count:$"
	new db 0AH, 0DH, "$"
	lv1 equ 41H
	uv1 equ 5BH
	lv2 equ 61H
	uv2 equ 7BH
	dollar equ 24H
	av1 equ 41H
	ev1 equ 45H
	iv1 equ 49H
	ov1 equ 4FH
	uv11 equ 55H
	av2 equ 61H
	ev2 equ 65H
	iv2 equ 69H
	ov2 equ 6FH
	uv22 equ 75H
.code
	mov bx, @data
	mov ds, bx
	lea si, str
	mov cx, 0000H
BACK:	cmp byte ptr [si], lv1
	jnc NEXT
	inc si
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
NEXT:	cmp byte ptr [si], uv1
	jnc NEXT_1
	jmp AHEAD
NEXT_1:	cmp byte ptr [si], lv2
	jnc NEXT_2
	inc si
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
NEXT_2:	cmp byte ptr [si], uv2
	jnc NEXT_3
	jmp AHEAD_1
NEXT_3: inc si
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
AHEAD:	cmp byte ptr [si], av1
	jnz N1
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
N1:	cmp byte ptr [si], ev1
	jnz N2
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
N2:	cmp byte ptr [si], iv1
	jnz N3
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
N3:	cmp byte ptr [si], ov1
	jnz N4
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
N4:	cmp byte ptr [si], uv11
	jnz N5
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK
N5:	inc ch
	inc si
	cmp byte ptr [si], dollar
	jz OVER_1
	jmp BACK

OVER_1:	jmp OVER

AHEAD_1:	cmp byte ptr [si], av2
	jnz M1
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER
	jmp BACK
M1:	cmp byte ptr [si], ev2
	jnz M2
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER
	jmp BACK
M2:	cmp byte ptr [si], iv2
	jnz M3
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER
	jmp BACK
M3:	cmp byte ptr [si], ov2
	jnz M4
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER
	jmp BACK
M4:	cmp byte ptr [si], uv22
	jnz M5
	call COUNT
	cmp byte ptr [si], dollar
	jz OVER
	jmp BACK
M5:	inc ch
	inc si
	cmp byte ptr [si], dollar
	jz OVER
	jmp BACK
OVER:	
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
	mov bx, cx
	mov cl, 04H
	mov al, bl
	add al, 00H
	daa
	mov ch, al
	and al, 0F0H
	ror al, cl
	add al, 30H
	mov dl, al
	mov ah, 02H
	int 21H
	mov al, ch
	and al, 0FH
	add al, 30H
	mov dl, al
	mov ah, 02H
	int 21H
	call NEWLINE
	lea dx, msg3
	mov ah, 09H
	int 21H
	call NEWLINE
	mov al, bh
	add al, 00H
	daa
	mov ch, al
	and al, 0F0H
	ror al, cl
	add al, 30H
	mov dl, al
	mov ah, 02H
	int 21H
	mov al, ch
	and al, 0FH
	add al, 30H
	mov dl, al
	mov ah, 02H
	int 21H 
	mov ah, 4CH
	int 21H

COUNT:
	inc cl
	inc si
	ret

NEWLINE:
	lea dx, new
	mov ah, 09H
	int 21H
	ret

	end
