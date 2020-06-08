@echo off

if "%1"=="" (
	ECHO Dieses Skript ist nur zur internen Verwendung von build_x64 gedacht.
	EXIT /B
)

CL /c /Ix64\ /I..\..\inc /Zi /nologo /W4 /WX /diagnostics:column /O2 /D _WIN64 /D _AMD64_ /D AMD64 /D WIN32_LEAN_AND_MEAN=1 /D _WIN32_WINNT=0x0A00 /D WINVER=0x0A00 /D WINNT=1 /D NTDDI_VERSION=0x0A000007 /D _WINDLL /Gm- /MD /GS /guard:cf /fp:precise /Zc:wchar_t- /Zc:forScope /Zc:inline /Fo"x64\\" /Fd"x64\vc142.pdb" /Gz /TC /FC /errorReport:prompt kbd%1%.c

RC /D _WIN64 /D _AMD64_=1 /D AMD64 /D WIN32_LEAN_AND_MEAN=1 /D _WIN32_WINNT=0x0A00 /D WINVER=0x0A00 /D WINNT=1 /D NTDDI_VERSION=0x0A000007 /l"0x0409" /Ix64 /I..\..\inc /nologo /fo"x64\kbd%1.res" kbd%1.rc

LINK /ERRORREPORT:PROMPT /OUT:"x64\kbd%1.dll" /INCREMENTAL:NO /NOLOGO /WX kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /DEF:"kbd%1.def" /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /DEBUG /PDB:"x64\kbd%1.pdb" /TLBID:1 /NOENTRY /DYNAMICBASE /NXCOMPAT /IMPLIB:"x64\kbd%1.lib" /MACHINE:X64 /guard:cf /IGNORE:4198,4010,4037,4039,4065,4070,4078,4087,4089,4221,4108,4088,4218,4218,4235  -merge:.edata=.data -merge:.rdata=.data -merge:.text=.data -merge:.bss=.data -section:.data,re  /ignore:4254 /DLL x64\kbd%1.res x64\kbd%1.obj
