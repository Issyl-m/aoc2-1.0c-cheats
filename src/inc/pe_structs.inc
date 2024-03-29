struc IMAGE_DOS_HEADER {
      .e_magic			     dw ?
      .e_cblp			     dw ?
      .e_cp			     dw ?
      .e_crlc			     dw ?
      .e_cparhdr		     dw ?
      .e_minalloc		     dw ?
      .e_maxalloc		     dw ?
      .e_ss			     dw ?
      .e_sp			     dw ?
      .e_csum			     dw ?
      .e_ip			     dw ?
      .e_cs			     dw ?
      .e_lfarlc 		     dw ?
      .e_ovno			     dw ?
      .e_res			     dw 4 dup (?)
      .e_oemid			     dw ?
      .e_oeminfo		     dw ?
      .e_res2			     dw 10 dup (?)
      .e_lfanew 		     dd ?
}
virtual at 0
	 IMAGE_DOS_HEADER IMAGE_DOS_HEADER
sizeof.IMAGE_DOS_HEADER:
end virtual

struc IMAGE_DATA_DIRECTORY {
      .VirtualAddress		     dd ?
      .Size			     dd ?
}
virtual at 0
	 IMAGE_DATA_DIRECTORY IMAGE_DATA_DIRECTORY
sizeof.IMAGE_DATA_DIRECTORY:
end virtual

struc IMAGE_OPTIONAL_HEADER32 {
      .Magic			     dw ?
      .MajorLinkerVersion	     db ?
      .MinorLinkerVersion	     db ?
      .SizeOfCode		     dd ?
      .SizeOfInitializedData	     dd ?
      .SizeOfUninitializedData	     dd ?
      .AddressOfEntryPoint	     dd ?
      .BaseOfCode		     dd ?
      .BaseOfData		     dd ?
      .ImageBase		     dd ?
      .SectionAlignment 	     dd ?
      .FileAlignment		     dd ?
      .MajorOperatingSystemVersion   dw ?
      .MinorOperatingSystemVersion   dw ?
      .MajorImageVersion	     dw ?
      .MinorImageVersion	     dw ?
      .MajorSubsystemVersion	     dw ?
      .MinorSubsystemVersion	     dw ?
      .Win32VersionValue	     dd ?
      .SizeOfImage		     dd ?
      .SizeOfHeaders		     dd ?
      .CheckSum 		     dd ?
      .Subsystem		     dw ?
      .DllCharacteristics	     dw ?
      .SizeOfStackReserve	     dd ?
      .SizeOfStackCommit	     dd ?
      .SizeOfHeapReserve	     dd ?
      .SizeOfHeapCommit 	     dd ?
      .LoaderFlags		     dd ?
      .NumberOfDirectories	     dd ?
      .ExportTable		     IMAGE_DATA_DIRECTORY
      .ImportTable		     IMAGE_DATA_DIRECTORY
      .ResourceTable		     IMAGE_DATA_DIRECTORY
      .ExceptionTable		     IMAGE_DATA_DIRECTORY
      .CertificateFile		     IMAGE_DATA_DIRECTORY
      .RelocationTable		     IMAGE_DATA_DIRECTORY
      .DebugData		     IMAGE_DATA_DIRECTORY
      .ArchitectureData 	     IMAGE_DATA_DIRECTORY
      .GlobalPtr		     IMAGE_DATA_DIRECTORY
      .ThreadLocalStorageTable	     IMAGE_DATA_DIRECTORY
      .LoadConfigTable		     IMAGE_DATA_DIRECTORY
      .BoundImportTable 	     IMAGE_DATA_DIRECTORY
      .ImportAddressTable	     IMAGE_DATA_DIRECTORY
      .DelayImportDescriptor	     IMAGE_DATA_DIRECTORY
      .COMRuntimeHeader 	     IMAGE_DATA_DIRECTORY
      .Reserved 		     IMAGE_DATA_DIRECTORY
}
virtual at 0
	 IMAGE_OPTIONAL_HEADER32 IMAGE_OPTIONAL_HEADER32
sizeof.IMAGE_OPTIONAL_HEADER32:
end virtual

struc IMAGE_FILE_HEADER {
      .Machine			     dw ?
      .NumberOfSections 	     dw ?
      .TimeDateStamp		     dd ?
      .PointerToSymbolTable	     dd ?
      .NumberOfSymbols		     dd ?
      .SizeOfOptionalHeader	     dw ?
      .Characteristics		     dw ?
}
virtual at 0
	 IMAGE_FILE_HEADER IMAGE_FILE_HEADER
sizeof.IMAGE_FILE_HEADER:
end virtual

struc IMAGE_NT_HEADERS {
      .Signature		     dd ?
      .FileHeader		     IMAGE_FILE_HEADER
      .OptionalHeader		     IMAGE_OPTIONAL_HEADER32
}
virtual at 0
	 IMAGE_NT_HEADERS IMAGE_NT_HEADERS
sizeof.IMAGE_NT_HEADERS:
end virtual

struc IMAGE_SECTION_HEADER {
      .Name			     db 8 dup (?)
      .VirtualSize		     dd ?
      .VirtualAddress		     dd ?
      .SizeOfRawData		     dd ?
      .OffsetToRawData		     dd ?
      .OffsetToRelocations	     dd ?
      .OffsetToLinenumbers	     dd ?
      .NumberOfRelocations	     dw ?
      .NumberOfLinenumbers	     dw ?
      .Characteristics		     dd ?
}
virtual at 0
	 IMAGE_SECTION_HEADER IMAGE_SECTION_HEADER
sizeof.IMAGE_SECTION_HEADER:
end virtual

struc IMAGE_EXPORT_DIRECTORY {
      .Characteristics		     dd ?
      .TimeDateStamp		     dd ?
      .MajorVersion		     dw ?
      .MinorVersion		     dw ?
      .Name			     dd ?
      .Base			     dd ?
      .NumberOfFunctions	     dd ?
      .NumberOfNames		     dd ?
      .AddressOfFunctions	     dd ?
      .AddressOfNames		     dd ?
      .AddressOfNameOrdinals	     dd ?
}
virtual at 0
	 IMAGE_EXPORT_DIRECTORY IMAGE_EXPORT_DIRECTORY
sizeof.IMAGE_EXPORT_DIRECTORY:
end virtual

