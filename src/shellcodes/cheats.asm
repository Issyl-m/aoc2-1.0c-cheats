.fnMapHackShellcode:
	push MAPHACK+5

	sub esp,0Ch

	mov ecx,[esp+10h]

	xor eax,eax
	mov [esp+4],eax
	mov [esp+8],eax

	mov dl,byte[ecx+0Dh]
	test dl,dl
	jbe ._maphackEndOfFunction

	push ebx ebp esi edi
._maphackNext:
	mov ecx,[ecx+14h]
	mov esi,[ecx+eax*4]
	test esi,esi
	jz @F

	mov cl,byte[esp+34h]
	xor bl,bl
	cmp cl,0Fh
	mov byte[esp+13h],bl
	mov byte[esp+12h],bl
	jz ._maphackLabel14

	mov edx,[esi+8h]
	cmp byte[edx+4],32h
	jb ._maphackLabel14

	mov al,byte[esi+138h]
	test al,al
	jz ._maphackLabel14

	mov eax,[esi+134h]
	mov edx,[ds:683C8Ch]
	test eax,edx
	jz ._maphackLabel1

	mov bl,1
	jmp ._maphackLabel2

._maphackLabel1:
	test [ds:683C88h],eax
	jz ._maphackLabel14

	mov byte[esp+13h],1
._maphackLabel2:
	mov byte[esp+12h],1
._maphackLabel14:
	mov eax,[esi+8]

	cmp word[eax+16h],22h
	jnz ._maphackLabel3

	mov bl,1
	mov byte[esp+12h],bl
._maphackLabel3:
	mov edi,[esi+0Ch]
	xor edx,edx
	mov dl,byte[eax+6Dh]
	mov al,byte[esp+12h]

	test al,al
	mov ebp,edx
	jz ._maphackLabel4

	test cl,cl
	jnz ._maphackLabel4

		mov ecx,[esp+30h]
		push 28h
		push 0
		mov eax,0x00423050
		call eax ;call age2_x1c.00423050

		mov cl,byte[esp+34h]
		jmp ._maphackLabel5

._maphackLabel4:
	cmp cl,0Fh
	jmp ._maphackLabel6
._maphackLabel5:
	test bl,bl
	jmp ._maphackLabel7
._maphackLabel6:
	cmp ebp,3
	jz ._maphackLabel7

	cmp cl,0Fh
	jz ._maphackLabel8

	mov eax,[6B4CE8h]
	mov dword[6B4CE8h],0
	mov [esp+14h],eax
._maphackLabel8:
	mov eax,[edi+160h]
	mov ecx,[esp+2Ch]
	mov edx,[esi]

	push eax
	mov eax,[esp+2Ch]
	push ecx
	mov ecx,[esp+2Ch]
	push eax
	push ecx
	mov ecx,esi
	call dword[edx+0Ch]

	cmp byte[esp+34],0Fh
	jz @F

	mov edx,[esp+14h]
	mov [ds:6B4CE8h],edx
	jmp @F

._maphackLabel7:
	cmp cl,80h
	jmp ._maphackLabel9
	mov al,byte[esp+13h]
	test al,al
	jz ._maphackLabel10

._maphackLabel9:
	cmp ebp,3
	jnz ._maphackLabel11

	mov eax,[edi+8Ch]
	mov edi,[edi+9Ch]
	movsx edx,word[eax+94h]
	mov eax,[eax+4Ch]
	mov edx,[eax+edx*4]
	mov eax,[edx+edi*4h+104h]
	test eax,eax
	jz ._maphackLabel10

	mov ecx,[esi+88h]
	mov eax,[esi]
	mov edx,[ecx+160h]
	mov ecx,[esp+2Ch]

	push edx
	mov edx,[esp+2Ch]
	push ecx
	mov ecx,[esp+2Ch]
	push edx
	push ecx
	mov ecx,esi
	call dword[eax+0Ch]
	jmp ._maphackLabel12

._maphackLabel11:
	test ebp,ebp
	jz ._maphackLabel13

	mov eax,[edi+160h]
	mov ecx,[esp+2Ch]
	mov edx,[esi]

	push eax
	mov eax,[esp+2Ch]
	push ecx
	mov ecx,[esp+2Ch]
	push eax
	push ecx
	mov ecx,esi
	call dword[edx+0Ch]
	jmp ._maphackLabel12

._maphackLabel13:
	mov al,byte[esi+36h]
	test al,al
	jz ._maphackLabel10

	mov edx,[esp+2Ch]
	mov eax,[esp+28h]
	mov ecx,[esp+24h]

	push edx
	push eax
	push ecx
	mov ecx,esi
	mov eax,0x004cf1c0
	call eax ;call age2_x1c.004cf1c0

._maphackLabel12:
	mov cl,byte[esp+34h]
._maphackLabel10:   
	mov al,byte[esp+12h]
	test al,al
	jz @F

	test cl,cl
	jnz @F

		mov ecx,[esp+30h]

		push 5
		push 0
		mov eax,0x00423050
		call eax ;call age2_x1c.00423050

	@@:

	mov ecx,[esp+20h]
	mov eax,[esp+18h]
	xor edx,edx
	inc eax
	mov dl,byte[ecx+0Dh]
	mov [esp+18h],eax

	cmp eax,edx
	jl ._maphackNext

	pop edi esi ebp ebx
._maphackEndOfFunction:
	add esp,0Ch
	retn 18h

.fnMapHackShellcode.size = $-.fnMapHackShellcode