	.model tiny
	.code
	.386
	org 100h
begin:
	mov ebx, x
	signNum:
		shl ebx, 1
		jnc expon
		mov sNumber, 1
	expon:
		push ebx
		and ebx, 0FF000000h
		shr ebx, 24
		sub bx, 127
		mov exp, bx
		pop ebx
		push ebx
	mant:
		and ebx, 00FFFFFEh
		shr ebx, 1
		push ebx
		pop mantissa
	output:
		push 0
		mov ah, 2
		mov cl, sNumber 
		add cl, '0'
		mov dx, cx
		int 21h
		mov ah, 9
		mov dx, offset tab
		int 21h
		movsx eax, exp
		push eax
		call outnumber
		mov ah, 9
		mov dx, offset tab
		int 21h
		mov ah, 2
		push mantissa
		call outnumber
		mov ah, 2
		mov dl, 0ah
		int 21h
	outputSecond:
		mov ah, 9
		mov dx, offset one
		int 21h
		mov ah, 2
		mov cl, sNumber 
		add cl, '0'
		mov dx, cx
		int 21h
		mov ah, 9
		mov dx, offset two
		int 21h
		movsx eax, exp
		push eax
		call outnumber
		mov ah, 9
		mov dx, offset three
		int 21h
		mov cx, 0
		call outfract
		mov ah, 2
		mov dl, 0ah
		int 21h
	outputThird:
		call outint
		mov ah, 2
		mov dl, ','
		int 21h
		mov cx, exp
		call outfract
	
	int	20h
	
	ReadFirstBits proc
		mov di, cx
		pop dx
		pop cx
		push dx
		push di
		xor dx, dx
		cmp cx, 0
		je OutRet
		loopOrder:
			shl ebx, 1
			jnc BitIsNull
			sub cx, 1
			push ebx
			mov bx, offset T
			mov al, cl
			xlat
			pop ebx
			or dl, al
			add cx, 1
			BitIsNull:
			loop loopOrder
		OutRet:
		xor al, al
		mov al, dl
		pop cx
		ret
	ReadFirstBits endp

	ReadLastBits proc
		mov di, cx
		pop dx
		pop cx
		push dx
		push di
		xor dx, dx
		mov di, 7
		sub di, cx
		test di, di
		js OutRt
		lRLB:
			shr ebx, 1
			jnc BitNull
			push ebx
			mov bx, offset T
			mov al, cl
			xlat
			pop ebx
			or dl, al
			BitNull:
			add cx, 1
			cmp cx, 8
			jne lRLB
		OutRt:
		xor al, al
		mov al, dl
		pop cx
		ret
	ReadLastBits endp
	
	outnumber proc
		pop si
		pop eax
		push si
		push ecx
		test eax, eax
		jns work
		mov  ecx, eax
		mov     ah, 02h
		mov     dl, '-'
		int     21h
		mov  eax, ecx
		neg  eax
		work:
		push di
		mov	ecx, 10
		mov di, offset len_str - 1
		rpt:
			mov	dx, 0
			div	ecx
			xchg eax,edx
			add	al, '0'
			mov [di], al
			dec di
			xchg eax,edx
			cmp	eax,0
			jne	rpt
		inc di
		mov	ah,9
		mov	dx, di   ; Заносим в DX адрес начала строки
		int	21h
		pop di
		pop ecx
		ret
		String db	1000 dup (?)
		len_str	db '$'
	outnumber endp
	
	outint proc
		mov ebx, mantissa
		or ebx, 00800000h ;возврат единицы
		shl ebx, 8
		
		mov ax, exp
		test ax, ax ;проверка на отриц. экспоненты
		js makeint

		xor ax, ax ;перенос мантиссы в массив байт
		xor dx, dx
		mov ax, exp
		add ax, 1
		mov cx, 8
		div cx
		add ax, 1
		mov SizeMst, ax
		push dx
		call ReadFirstBits
		mov Mst[0], al
		mov cx, SizeMst
		sub cx, 1
		cmp cx, 0
		je makeint
		loopoutint:
			xor dx, dx
			push 8
			call ReadFirstBits
			mov dx, SizeMst
			sub dx, cx
			mov di, dx
			mov Mst[di], al
		loop loopoutint
	makeint:
		xor eax, eax  ;начинаем деление на 10, стремимся к десятичной системе
		xor cx, cx
		mov bl, 10
		xor dx, dx
		GetDecNum:
			mov di, 0
			DivTen:
				mov al, Mst[di]
				div bl
				mov Mst[di], al
				add di, 1
				cmp di, SizeMst
				jne DivTen
			mov al, ah
			xor ah, ah
			push ax
			inc dx
			mov di, 0
			CheckOnNull:
				cmp Mst[di], 0   ;проверка на обнуленные байты
				jne GetDecNum
				add di, 1
				cmp di, SizeMst
				jne CheckOnNull
		mov cx, dx
		loop1:
			pop dx
			push 0
			push dx
			call outnumber
			loop loop1
		mov SizeMst, 1
		ret
	outint endp
	
	outfract proc
		mov ebx, mantissa
		or ebx, 00800000h
		xor ax, ax
		xor dx, dx
		;mov cx, 0;Exponenta
		mov SizeMst, 1
		add cx, 1
		mov ax, 24
		sub ax, cx
		test ax, ax
		js makefract
		mov cx, 8
		div cx
		cmp dx, 0
		mov SizeMst, ax
		add ax, 1
		mov SizeMst, ax
		mov ax, 8
		sub ax, dx
		push ax
		call ReadLastBits
		mov Mst[0], al
		mov cx, SizeMst
		sub cx, 1
		cmp cx, 0
		je makefract
		loopoutfract:
			xor dx, dx
			push 0
			call ReadLastBits
			mov dx, SizeMst
			sub dx, cx
			mov di, dx
			mov Mst[di], al
		loop loopoutfract
	makefract:
		xor eax, eax
		xor cx, cx
		mov bl, 10
		xor eax, eax
		xor dx, dx

		mov di, 0
		MulTen:
			mov al, Mst[di]
			mov cl, ah
			mul bl
			add ax, cx
			mov Mst[di], al
			add di, 1
			cmp di, SizeMst
			jne MulTen
		mov al, ah
		xor ah, ah
		push 0
		push ax
		call outnumber
		mov di, 0
		xor ax, ax
		CheckOnNull1:
			cmp Mst[di], 0
			jne MulTen
			add di, 1
			cmp di, SizeMst
			jne CheckOnNull1
		ret
	outfract endp

	
	mantissa equ dword ptr [bp-2]
	exp dw 0
	T db 00000001b, 00000010b, 00000100b, 00001000b, 00010000b, 00100000b, 01000000b, 10000000b
	Mst db 20 dup (0)
	ten db 10
	SizeMst dw 0
	sNumber db 0
	x dd 0.625
	tab db '  $'
	one db '(-1)^$'
	two db '*2^$'
	three db '*1,$'
	ttt dd 8388608
	tenten dd 10
	
end Begin