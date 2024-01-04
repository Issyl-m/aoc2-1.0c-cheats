include 'C:\fasmw16726\INCLUDE\win32ax.inc'
entry app_base
section '.text' code readable writeable executable
;--------------------------------------------------------------------------------------------------------------------------------------------
;       Datos globales
;--------------------------------------------------------------------------------------------------------------------------------------------
include 'inc\structs.inc'
include 'inc\pe_structs.inc'
include 'inc\peb_structs.inc'
include 'inc\debug.inc'
include 'main.inc'
;--------------------------------------------------------------------------------------------------------------------------------------------
app_base:
fnGetProcessesToHook:
;-----------------------------------------------------------------------------------
; Buscar proceso para hookear
;-----------------------------------------------------------------------------------
	invoke GlobalAlloc,GPTR,sizeof.PROCESSENTRY32
	mov esi,eax
	xor edi,edi
fnSearchProcess:
	invoke Sleep,1
	invoke CloseHandle,edi
	virtual at esi
		 .esi.PROCESSENTRY32 PROCESSENTRY32
	end virtual
	mov [.esi.PROCESSENTRY32.dwSize],sizeof.PROCESSENTRY32
	invoke CreateToolhelp32Snapshot,TH32CS_SNAPPROCESS,0
	mov edi,eax
.NextProcess:
	invoke Process32Next,edi,esi
	or eax,eax
	jz fnSearchProcess

	invoke lstrcmpi,addr .esi.PROCESSENTRY32.szExeFile,'age2_x1.exe'
	or eax,eax
	jz .fnAddHandler
	jmp .NextProcess

	;voobly.exe->ntdll.ZwTerminateProcess (?)

.fnAddHandler:
		invoke OpenProcess,PROCESS_VM_OPERATION+PROCESS_CREATE_THREAD+PROCESS_VM_READ+PROCESS_VM_WRITE,0,[.esi.PROCESSENTRY32.th32ProcessID]
		mov ebx,eax

		invoke VirtualAllocEx,ebx,0,fnAddDetours.size,MEM_COMMIT+MEM_RESERVE,PAGE_EXECUTE_READWRITE
		push eax
		lea ecx,[eax+(fnAddDetours.fnMapHackShellcode-fnAddDetours)]
		mov [fnAddDetours._MapHackShellAddr+6],ecx
		invoke WriteProcessMemory,ebx,eax,fnAddDetours,fnAddDetours.size,0
		pop eax
		invoke CreateRemoteThread,ebx,0,0,eax,0,0,0

		invoke CloseHandle,ebx
		jmp .SearchSuccess

.SearchSuccess:
	retn
	;jmp .NextProcess
;////////////////////////////////////////////////////////////////////////////////////
proc fnAddDetours
	;-----------------------------------------
	locals
		;---------------------------------
		lpGlobalAlloc		      dd ?
		lpGlobalFree		      dd ?
		lpCloseHandle		      dd ?
		lpCreateMutexA		      dd ?
		lpAddVectoredExceptionHandler dd ?
		lpCreateToolhelp32Snapshot    dd ?
		lpThread32Next		      dd ?
		lpOpenThread		      dd ?
		lpGetThreadContext	      dd ?
		lpSetThreadContext	      dd ?
		;---------------------------------
		hThread 		      dd ?
		;---------------------------------
	endl
	;-----------------------------------------
	virtual at ebx
		.ebx.PEB PEB
	end virtual
	virtual at ebx
		.ebx.PEB_LDR_DATA PEB_LDR_DATA
	end virtual
	virtual at ebx
		.ebx.LIST_ENTRY LIST_ENTRY
	end virtual
	virtual at ebx
		.ebx.LDR_DATA_TABLE_ENTRY LDR_DATA_TABLE_ENTRY
	end virtual
	;-----------------------------------------
	mov ebx,[fs:0x30]
	mov ebx,[.ebx.PEB.Ldr]
	mov ebx,[.ebx.PEB_LDR_DATA.InLoadOrderModuleList]
	mov ebx,[.ebx.LIST_ENTRY.Flink]
	mov edi,[.ebx.LDR_DATA_TABLE_ENTRY.DllBase]
	mov ebx,[.ebx.LIST_ENTRY.Flink]
	mov ebx,[.ebx.LDR_DATA_TABLE_ENTRY.DllBase]

	stdcall .fnGetProcAddress,edi,0xaea8230c
	mov [lpAddVectoredExceptionHandler],eax

	stdcall .fnGetProcAddress,ebx,0x0002cc21
	mov [lpGlobalAlloc],eax

	stdcall .fnGetProcAddress,ebx,0x00016607
	mov [lpGlobalFree],eax

	stdcall .fnGetProcAddress,ebx,0x0002c30d
	mov [lpCloseHandle],eax

	stdcall .fnGetProcAddress,ebx,0x00058595
	mov [lpCreateMutexA],eax

	stdcall .fnGetProcAddress,ebx,0x5866e6aa
	mov [lpCreateToolhelp32Snapshot],eax

	stdcall .fnGetProcAddress,ebx,0x0005f168
	mov [lpThread32Next],eax

	stdcall .fnGetProcAddress,ebx,0x0001774a
	mov [lpOpenThread],eax

	stdcall .fnGetProcAddress,ebx,0x00581118
	mov [lpGetThreadContext],eax

	stdcall .fnGetProcAddress,ebx,0x005e1118
	mov [lpSetThreadContext],eax
	;-----------------------------------------
	invoke lpCreateMutexA,0,0,'Leideschaftslos'
	or eax,eax
	jz .EndOfFunction
	;-----------------------------------------
	call .functionBaseAddress
.functionBaseAddress:
	pop ebx

	invoke lpAddVectoredExceptionHandler,1,addr ebx+(.fnDetourHandler-.functionBaseAddress)
	;-----------------------------------------
.fnGetThreads:
	invoke lpGlobalAlloc,GPTR,sizeof.THREADENTRY32
	mov edi,eax
	invoke lpGlobalAlloc,GPTR,sizeof.CONTEXT_X86_
	mov ebx,eax

	virtual at edi
		 .edi.THREADENTRY32 THREADENTRY32
	end virtual
	mov [.edi.THREADENTRY32.dwSize],sizeof.THREADENTRY32

	invoke lpCreateToolhelp32Snapshot,TH32CS_SNAPTHREAD,0
	mov esi,eax
.fnGetThreadsLoop:
	invoke lpThread32Next,esi,edi
	or eax,eax
	jz .NoMoreThreads

	mov eax,[fs:0x18]
	mov eax,[eax+0x20]
	cmp eax,[.edi.THREADENTRY32.th32OwnerProcessID]
	jnz .fnGetThreadsLoop

		invoke lpOpenThread,THREAD_ALL_ACCESS,0,[.edi.THREADENTRY32.th32ThreadID]
		mov [hThread],eax

		virtual at ebx
			.ebx.CONTEXT_X86 CONTEXT_X86_
		end virtual

		mov [.ebx.CONTEXT_X86.ContextFlags],CONTEXT_DEBUG_REGISTERS
		invoke lpGetThreadContext,eax,ebx
		or eax,eax
		jz @F

			mov [.ebx.CONTEXT_X86.DR0],MINI_MAPHACK
			mov [.ebx.CONTEXT_X86.DR1],MAPHACK
			mov [.ebx.CONTEXT_X86.DR2],DARKZONEHACK
			mov [.ebx.CONTEXT_X86.DR3],0x11223344;DELETEHACK/CONTROLHACK
			mov [.ebx.CONTEXT_X86.DR6],0
			mov [.ebx.CONTEXT_X86.DR7],(0x1 or 0x4 or 0x10 or 0x40)

			invoke lpSetThreadContext,[hThread],ebx

		@@:
		invoke lpCloseHandle,[hThread]
		jmp .fnGetThreadsLoop

.NoMoreThreads:
	invoke lpCloseHandle,esi
	invoke lpGlobalFree,ebx
	invoke lpGlobalFree,edi
	jmp .fnGetThreads

.EndOfFunction:
	ret
;//////////////////////////////
.fnGetProcAddress:
	push ebp
	mov ebp,esp

	push ebx edi esi

	mov edi,[ebp+0x08]
	virtual at edi
		 .IMAGE_DOS_HEADER IMAGE_DOS_HEADER
	end virtual
	mov ebx,[.IMAGE_DOS_HEADER.e_lfanew]
	add ebx,edi
	virtual at ebx
		 .IMAGE_NT_HEADERS IMAGE_NT_HEADERS
	end virtual

	mov ebx,[.IMAGE_NT_HEADERS.OptionalHeader.ExportTable.VirtualAddress]
	add ebx,edi
	virtual at ebx
		 .IMAGE_EXPORT_DIRECTORY IMAGE_EXPORT_DIRECTORY
	end virtual

	xor ecx,ecx
.GetFunctionAddressLoop:
	cmp ecx,[.IMAGE_EXPORT_DIRECTORY.NumberOfNames]
	ja .ErrorNotFound

		mov esi,[.IMAGE_EXPORT_DIRECTORY.AddressOfNameOrdinals]
		add esi,edi
		movzx esi,word[esi+ecx*2]

		mov edx,[.IMAGE_EXPORT_DIRECTORY.AddressOfNames]
		add edx,edi
		mov edx,[edx+ecx*4]
		add edx,edi

		inc ecx

		push ebx edi esi

		mov esi,edx
		xor eax,eax ; h
		inc eax
		xor ebx,ebx ; g
.Hash:
		movzx edi,byte[esi]
		or edi,edi
		jz .fnHashSuccess

			shl eax,1
			add eax,edi

			mov edx,eax
			and edx,0xF0000000
			cmp ebx,edx
			jnz @F

				mov edx,ebx
				shr edx,24
				xor eax,edx
			@@:
			mov edx,ebx
			not edx
			and eax,edx

			inc esi
			jmp .Hash
.fnHashSuccess:
		pop esi edi ebx

		cmp [ebp+0x0C],eax
		jnz .GetFunctionAddressLoop

			mov eax,[.IMAGE_EXPORT_DIRECTORY.AddressOfFunctions]
			add eax,edi
			mov eax,[eax+esi*4]
			add eax,edi
			jmp .fnGetProcAddressSuccess

.ErrorNotFound:
	xor eax,eax
.fnGetProcAddressSuccess:
	pop esi edi ebx
	leave
	retn 8
;//////////////////////////////
.fnDetourHandler:
	push ebp
	mov ebp,esp
	;-----------------------------------------
	virtual at eax
		 .eax.EXCEPTION_POINTERS EXCEPTION_POINTERS
	end virtual
	virtual at eax
		 .eax.EXCEPTION_RECORD EXCEPTION_RECORD
	end virtual
	virtual at ecx
		 .ecx.CONTEXT_X86_ CONTEXT_X86_
	end virtual
	;-----------------------------------------
	mov eax,[ebp+8]
	mov ecx,[.eax.EXCEPTION_POINTERS.lpContext]
	mov eax,[.eax.EXCEPTION_POINTERS.lpExceptionRecord]

	cmp [.eax.EXCEPTION_RECORD.ExceptionCode],EXCEPTION_SINGLE_STEP
	jnz .ExceptionContinueSearch

		cmp [.ecx.CONTEXT_X86_.eip],MINI_MAPHACK
		jnz @F

			add [.ecx.CONTEXT_X86_.eip],2 ; NOPNOP
			jmp .ExceptionContinueExecution

		@@:

		cmp [.ecx.CONTEXT_X86_.eip],MAPHACK
		jnz @F

._MapHackShellAddr:	mov [.ecx.CONTEXT_X86_.eip],0x00000000 ; .fnMapHackShellcode
			jmp .ExceptionContinueExecution

		@@:

		cmp [.ecx.CONTEXT_X86_.eip],DARKZONEHACK
		jnz @F

			mov [.ecx.CONTEXT_X86_.ecx],0xFFFFFFFF
			add [.ecx.CONTEXT_X86_.eip],6 ; 0041D59A  |. 8B88 28010000     MOV ECX,DWORD PTR DS:[EAX+128]
			jmp .ExceptionContinueExecution

		@@:
	;-----------------------------------------
.ExceptionContinueSearch:
	xor eax,eax
	jmp .ExceptionHandled

.ExceptionContinueExecution:
	xor eax,eax
	dec eax

.ExceptionHandled:
	mov esp,ebp
	pop ebp
	retn 4
;//////////////////////////////
	include 'shellcodes\cheats.asm'
endp
fnAddDetours.size = $-fnAddDetours
;////////////////////////////////////////////////////////////////////////////////////

;--------------------------------------------------------------------------------------------------------------------------------------------
section '.idata' import data readable writeable
library kernel32,'kernel32.dll'

 import kernel32,\
	GlobalAlloc,'GlobalAlloc',\
	GlobalFree,'GlobalFree',\
	CreateToolhelp32Snapshot,'CreateToolhelp32Snapshot',\
	Process32Next,'Process32Next',\
	Sleep,'Sleep',\
	lstrcmpi,'lstrcmpi',\
	CloseHandle,'CloseHandle',\
	OpenProcess,'OpenProcess',\
	VirtualAllocEx,'VirtualAllocEx',\
	WriteProcessMemory,'WriteProcessMemory',\
	CreateRemoteThread,'CreateRemoteThread'