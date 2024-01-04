struc CRITICAL_SECTION {
      .A		      dd ?
      .B		      dd ?
      .C		      dd ?
      .D		      dd ?
      .E		      dd ?
      .F		      dd ?
}
virtual at 0
	 CRITICAL_SECTION CRITICAL_SECTION
sizeof.CRITICAL_SECTION:
end virtual

struc PROCESSENTRY32 {
      .dwSize		      dd ?
      .cntUsage 	      dd ?
      .th32ProcessID	      dd ?
      .th32DefaultHeapID      dd ?
      .th32ModuleID	      dd ?
      .cntThreads	      dd ?
      .th32ParentProcessID    dd ?
      .pcPriClassBase	      dd ?
      .dwFlags		      dd ?
      .szExeFile	      db MAX_PATH dup (?)
}
virtual at 0
	 PROCESSENTRY32 PROCESSENTRY32
sizeof.PROCESSENTRY32:
end virtual

struc MODULEENTRY32 {
      .dwSize		      dd ?
      .th32ModuleID	      dd ?
      .th32ProcessID	      dd ?
      .GlblcntUsage	      dd ?
      .ProccntUsage	      dd ?
      .modBaseAddr	      dd ?
      .modBaseSize	      dd ?
      .hModule		      dd ?
      .szModule 	      db 256 dup (?)
      .szExePath	      db MAX_PATH dup (?)
}
virtual at 0
	 MODULEENTRY32 MODULEENTRY32
sizeof.MODULEENTRY32:
end virtual

struc CLIENT_ID {
      .UniqueProcess	      dd ?
      .UniqueThread	      dd ?
}

struc THREAD_BASIC_INFORMATION {
      .ExitStatus	      dd ?
      .TebBaseAddress	      dd ?
      .ClientId 	      CLIENT_ID
      .AffinityMask	      dd ?
      .Priority 	      dd ?
      .BasePriority	      dd ?
}
virtual at 0
	 THREAD_BASIC_INFORMATION THREAD_BASIC_INFORMATION
sizeof.THREAD_BASIC_INFORMATION:
end virtual

struc THREADENTRY32 {
      .dwSize		      dd ?
      .cntUsage 	      dd ?
      .th32ThreadID	      dd ?
      .th32OwnerProcessID     dd ?
      .tpBasePri	      dd ?
      .tpDeltaPri	      dd ?
      .dwFlags		      dd ?
}
virtual at 0
	 THREADENTRY32 THREADENTRY32
sizeof.THREADENTRY32:
end virtual

struc SECURITY_ATTRIBUTES {
      .nLength		      dd   ?
      .lpSecurityDescriptor   dd   ?
      .bInheritHandle	      dd   ?
}
virtual at 0
	 SECURITY_ATTRIBUTES SECURITY_ATTRIBUTES
sizeof.SECURITY_ATTRIBUTES:
end virtual

TH32CS_SNAPPROCESS = 2
TH32CS_SNAPTHREAD = 4
TH32CS_SNAPMODULE = 8
ThreadBasicInformation = 0
SEC_IMAGE = 0x01000000