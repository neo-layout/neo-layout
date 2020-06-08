@echo off

pushd ..\source

REM Build Bone, Neo, Qwertz

cd kbdbone
IF NOT EXIST x86 mkdir x86
call ..\..\build\build_variant_x86.cmd bone
cd ..

cd kbdneo2
IF NOT EXIST x86 mkdir x86
call ..\..\build\build_variant_x86.cmd neo2
cd ..

cd kbdgr2
IF NOT EXIST x86 mkdir x86
call ..\..\build\build_variant_x86.cmd gr2
cd ..

popd
