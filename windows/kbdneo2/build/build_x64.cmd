@echo off

pushd ..\source

REM Build Bone, Neo, Qwertz

cd kbdbone
IF NOT EXIST x64 mkdir x64
call ..\..\build\build_variant_x64.cmd bone
cd ..

cd kbdneo2
IF NOT EXIST x64 mkdir x64
call ..\..\build\build_variant_x64.cmd neo2
cd ..

cd kbdgr2
IF NOT EXIST x64 mkdir x64
call ..\..\build\build_variant_x64.cmd gr2
cd ..

popd
