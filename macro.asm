;test macro functionality with macro defined in same file
;test macro functionality with macro defined in different file exit.maci
.model small
.include C:~/Documents/sem4/MPT/MASM/exit.mac
print macro;
	mov ah, 09H;
	int 21H;
endm;
.data
	string db "coep123$"
.code
	mov bx, @data
	mov ds, bx
	lea dx, string
	print
	exit
	end
