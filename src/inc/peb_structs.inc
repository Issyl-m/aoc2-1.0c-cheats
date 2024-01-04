struc LIST_ENTRY {
      .Flink dd ?
      .Blink dd ?
}
virtual at 0
	 LIST_ENTRY LIST_ENTRY
sizeof.LIST_ENTRY:
end virtual

struc LDR_DATA_TABLE_ENTRY {
      .InLoadOrderModuleList LIST_ENTRY
      .InMemoryOrderModuleList LIST_ENTRY
      .InInitialitationOrderModuleList LIST_ENTRY
      .DllBase dd ?
      .EntryPoint dd ?
      .Reserved3 dd ?
      .FullDllName dd ?
      .Reserved4 db 8 dup(?)
      .Reserved5 dd 3 dup(?)
      ._CheckSum dd ?
      .TimeDateStamp dd ?
}
virtual at 0
	 LDR_DATA_TABLE_ENTRY LDR_DATA_TABLE_ENTRY
sizeof.LDR_DATA_TABLE_ENTRY:
end virtual

struc PEB_LDR_DATA {
      ._Length dd ?
      .Initialized dd ?
      .SsHandle dd ?
      .InLoadOrderModuleList LIST_ENTRY
      .InMemoryOrderModuleList LIST_ENTRY
      .InInitializationOrderModuleList LIST_ENTRY
      .EntryInProgress dd ?
}
virtual at 0
	 PEB_LDR_DATA PEB_LDR_DATA
sizeof.PEB_LDR_DATA:
end virtual

struc PEB {
      .Reserved1 db 2 dup(?)
      .BeingDebugged db ?
      .Reserved2 db ?
      .Reserved3 dd 2 dup(?)
      .Ldr dd ?
      .ProcessParameters dd ?
      .Reserved4 db 104 dup(?)
      .Reserved5 dd 52 dup(?)
      .PostProcessInitRoutine dd ?
      .Reserved6 db 128 dup (?)
      .Reserved7 dd ?
      .SessionId dd ?
}
virtual at 0
	 PEB PEB
sizeof.PEB:
end virtual