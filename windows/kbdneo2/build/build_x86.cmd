@echo off

pushd ..\source

REM Build Bone, Neo, Qwertz, Mine

cd kbdbone
IF NOT EXIST x86 mkdir x86
IF NOT EXIST x86-wow64 mkdir x86-wow64
call ..\..\build\build_variant_x86.cmd bone
call ..\..\build\build_variant_x86_wow64.cmd bone
cd ..

cd kbdneo2
IF NOT EXIST x86 mkdir x86
IF NOT EXIST x86-wow64 mkdir x86-wow64
call ..\..\build\build_variant_x86.cmd neo2
call ..\..\build\build_variant_x86_wow64.cmd neo2
cd ..

cd kbdgr2
IF NOT EXIST x86 mkdir x86
IF NOT EXIST x86-wow64 mkdir x86-wow64
call ..\..\build\build_variant_x86.cmd gr2
call ..\..\build\build_variant_x86_wow64.cmd gr2
cd ..

cd kbdmine
IF NOT EXIST x86 mkdir x86
IF NOT EXIST x86-wow64 mkdir x86-wow64
call ..\..\build\build_variant_x86.cmd mine
call ..\..\build\build_variant_x86_wow64.cmd mine
cd ..

popd
