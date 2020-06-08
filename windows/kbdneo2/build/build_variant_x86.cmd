@echo off

if "%1"=="" (
	ECHO Dieses Skript ist nur zur internen Verwendung von build_x86 gedacht.
	EXIT /B
)

CL /c /IRelease\ /I..\..\inc /Zi /nologo /W4 /WX /diagnostics:column /O2 /Oy- /D _X86_=1 /D i386=1 /D STD_CALL /D WIN32_LEAN_AND_MEAN=1 /D _WIN32_WINNT=0x0A00 /D WINVER=0x0A00 /D WINNT=1 /D NTDDI_VERSION=0x0A000007 /D _WINDLL /Gm- /MD /GS /guard:cf /fp:precise /Zc:wchar_t- /Zc:forScope /Zc:inline /Fo"x86\\" /Fd"x86\vc142.pdb" /Gz /TC /analyze- /FC /errorReport:prompt kbd%1.c

RC /D _X86_=1 /D i386=1 /D STD_CALL /D WIN32_LEAN_AND_MEAN=1 /D _WIN32_WINNT=0x0A00 /D WINVER=0x0A00 /D WINNT=1 /D NTDDI_VERSION=0x0A000007 /l"0x0409" /Ix86\ /I..\..\inc /nologo /fo"x86\kbd%1.res" kbd%1.rc

LINK /ERRORREPORT:PROMPT /OUT:"x86\kbd%1.dll" /INCREMENTAL:NO /NOLOGO /WX kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /DEF:"kbd%1.def" /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /DEBUG /PDB:"x86\kbd%1.pdb" /TLBID:1 /NOENTRY /DYNAMICBASE /NXCOMPAT /IMPLIB:"x86\kbd%1.lib" /MACHINE:X86 /SAFESEH /guard:cf /IGNORE:4198,4010,4037,4039,4065,4070,4078,4087,4089,4221  -merge:.edata=.data -merge:.rdata=.data -merge:.text=.data -merge:.bss=.data -section:.data,re  /ignore:4254 /DLL x86\kbd%1.res x86\kbd%1.obj
