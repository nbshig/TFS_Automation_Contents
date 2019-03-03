@echo off

REM 19/03/01 CHG Start
REM cd "00_proj"
cd C:\最適化オプションツール_戻し用\00_proj
REM 19/03/01 CHG End

if exist *.bk  del /F /Q  *.bk

FOR /f %%b IN ('dir *.vbproj /b') DO (
	ren %%b %%b.bk
	REM 19/03/01 CHG Start
	REM call ..\オプションver0.1.vbs %%b.bk
	cscript C:\最適化オプションツール_戻し用\オプションver0.1.vbs %%b.bk
	REM 19/03/01 CHG End
	echo 変換中：%%~b
)

del /F /Q  ..\10_最適化\*

move *.vbproj ..\10_最適化

cd ..\

REM 19/03/01 DEL Start
REM pause
REM 19/03/01 DEL End