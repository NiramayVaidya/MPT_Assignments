;add two 32 bit hex numbers
.model small
.data
	num1 dw 9999H, 9999H
	num2 dw 9999H, 9999H
	num3 dw ?
.code
	mov ax, @data
	mov ds, ax
	mov si, num1 + 2
	mov di, num2 + 2
	mov cl, 08H
	clc
	adc di, si
	rol di, cl
	mov num3 + 4, di
	mov si, num1
	mov di, num2
	adc di, si
	jc TEMP
	mov num3 + 2, di
	mov num3, 0000H
BACK:	mov ah, 4CH
	int 21H
TEMP:	rol di, cl
	mov num3 + 2, di
	mov num3, 0100H
	jmp BACK

	end
