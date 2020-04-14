.8086
.model small
.stack 256
.data
	msg1 db 10,15,"Enter elements of first array$"
	msg2 db 10,15,"Enter elements of second array$"
	msg3 db 10,15,"Addition of arrays is:$"
	msg4 db 10,15,"Subtraction of arrays is:$"
	var1 db 00h
	var2 db 00h
	var3 db 00h
	var4 db 00h
	var5 db 00h
	var6 db 00h
	var7 db 00h
	var8 db 00h
	var11 db 00h
	var12 db 00h
	var21 db 00h
	var22 db 00h
	sub11 db 00h
	sub12 db 00h
	sub21 db 00h
	sub22 db 00h
.code
	mov ax, @data
	mov ds, ax
	mov dx, offset msg1
	mov ah,09h
	int 21h
	call input
 	mov var1, bl
 	call input 
 	mov var2, bl
 	call input
 	mov var3, bl
 	call input
 	mov var4, bl
 	mov dx, offset msg2
	mov ah,09h
	int 21h
	call input
 	mov var5, bl
 	call input 
 	mov var6, bl
 	call input
 	mov var7, bl
 	call input
 	mov var8, bl
 	call addition
 	call substraction
 	mov ah, 09h
 	mov dx, offset msg3
        int 21h
 	mov bl, var11
        call disp
 	mov bl, var12
        call disp
 	mov bl, var21
        call disp
 	mov bl, var22
        call disp

 	mov ah, 09h
 	mov dx, offset msg4
 	int 21h
 	mov bl, sub11
        call disp
 	mov bl, sub12
        call disp
 	mov bl, sub21
        call disp
 	mov bl, sub22
        call disp
 	mov ax, 4c00h
 	int 21h

addition proc
	mov al, var1
	add al, var5
	mov var11, al
	mov al, var2
	add al, var6
	mov var12, al
	mov al, var3
	add al, var7
	mov var21, al
	mov al, var4
	add al, var8
	mov var22, al
addition endp

substraction proc
	mov al, var1
	sub al, var5
	mov sub11, al
	mov al, var2
	sub al, var6
	mov sub12, al
	mov al, var3
	sub al, var7
	mov sub21, al
	mov al, var4
	sub al, var8
	mov sub22, al
substraction endp

input proc

	mov ch,02h
	mov cl,04h
	mov bl,00h
L1:	shl bl,cl
	mov ah,01h
	int 21h
	cmp al,40h
	jbe L2
	sub al,07h
L2:	sub al,30h
	add bl,al
	dec ch
	jnz L1
	ret

input endp

disp proc

	mov ch, 02h
	mov cl, 04h
L5:	rol bl,cl
	mov dl,bl
	and dl,0fh
	cmp dl,09h
	jbe L6
	add dl,07h
L6:	add dl,30h
	mov ah,02h
	int 21h
	dec ch
	jnz L5
	ret

disp endp

end
