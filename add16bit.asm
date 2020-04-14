;add two 16 bit hex numbers
.model small
.data
	num1 dw 9999H
	num2 dw 9999H
	num3 dw ?
.code
	mov ax, @data
	mov ds, ax
	mov si, num1
	mov di, num2
	mov cl, 08H
	add di, si
	jc TEMP
	rol di, cl
	mov num3 + 2, di
	mov num3, 0000H
BACK:	mov ah, 4CH
	int 21H
TEMP:	rol di, cl
	mov num3 + 2, di
	mov num3, 0100H
	jmp BACK

	end
