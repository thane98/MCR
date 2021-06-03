@echo off

set PATH=%PATH%;bin

if exist "code.bin" (
	goto runBuild
)
echo ERROR: code.bin not found
exit 1

:runBuild
echo Building MCR
echo ----------------------

rmdir /s/q build
mkdir build
mkdir build\exefs
mkdir build\romfs
mkdir build\romfs\Scripts

echo Compiling Exalt scripts...
java -jar bin\exc.jar source\mcr.exl -o build\romfs\Scripts\mcr.cmb

echo Creating code patch...
armips source\mcr.s

echo Done