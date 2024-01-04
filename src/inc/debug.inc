struc EXCEPTION_POINTERS {
      .lpExceptionRecord      dd ?
      .lpContext	      dd ?
}

struc EXCEPTION_RECORD {
      .ExceptionCode	      dd ?
      .ExceptionFlags	      dd ?
      .lpExceptionRecord      dd ?
      .ExceptionAddress       dd ?
      .NumberParameters       dd ?
      .ExceptionInformation   dd 15 dup (?)
}

struc FLOATING_SAVE_AREA {
      .ControlWord	      dd ?
      .StatusWord	      dd ?
      .TagWord		      dd ?
      .ErrorOffset	      dd ?
      .ErrorSelector	      dd ?
      .DataOffset	      dd ?
      .DataSelector	      dd ?
      .RegisterArea	      db 80 dup (?)
      .Cr0NpxState	      dd ?
}

MAXIMUM_SUPPORTED_EXTENSION = 512
struc CONTEXT_X86_ {
      .ContextFlags	      dd ?
      .DR0		      dd ?
      .DR1		      dd ?
      .DR2		      dd ?
      .DR3		      dd ?
      .DR6		      dd ?
      .DR7		      dd ?
      .FloatSave	      FLOATING_SAVE_AREA
      .SegGS		      dd ?
      .SegFS		      dd ?
      .SegES		      dd ?
      .SegDS		      dd ?
      .edi		      dd ?
      .esi		      dd ?
      .ebx		      dd ?
      .edx		      dd ?
      .ecx		      dd ?
      .eax		      dd ?
      .ebp		      dd ?
      .eip		      dd ?
      .SegCS		      dd ?
      .EFLAGS		      dd ?
      .esp		      dd ?
      .SegSS		      dd ?
      .ExtendedRegisters      db MAXIMUM_SUPPORTED_EXTENSION dup (?)
}
virtual at 0
	 CONTEXT_X86_ CONTEXT_X86_
sizeof.CONTEXT_X86_:
end virtual

EXCEPTION_MAXIMUM_PARAMETERS = 15
struc EXCEPTION_RECORD {
      .ExceptionCode	      dd ?
      .ExceptionFlags	      dd ?
      .ExceptionRecord	      dd ?
      .ExceptionAddress       dd ?
      .NumberParameters       dd ?
      .ExceptionInformation   dd EXCEPTION_MAXIMUM_PARAMETERS dup (?)
} 

struc EXCEPTION_DEBUG_INFO {
      .ExceptionRecord	      EXCEPTION_RECORD
      .dwFirstChance	      dd ?
}

struc DEBUG_EVENT {
      .dwDebugEventCode       dd ?
      .dwProcessId	      dd ?
      .dwThreadId	      dd ?
      .u		      EXCEPTION_DEBUG_INFO
}
virtual at 0
	 DEBUG_EVENT DEBUG_EVENT
sizeof.DEBUG_EVENT:
end virtual

THREAD_ALL_ACCESS = 0x000F0000 or 0x00100000 or 0x3FF
CONTEXT_DEBUG_REGISTERS = 0x00010010
CONTEXT_FULL = 0x10007

EXCEPTION_DEBUG_EVENT = 1

EXCEPTION_BREAKPOINT = 0x80000003
EXCEPTION_SINGLE_STEP = 0x80000004

DBG_CONTINUE = 0x00010002
DBG_EXCEPTION_NOT_HANDLED = 0x80010001