@echo off

REM 19/03/01 CHG Start
REM cd "00_proj"
cd C:\�œK���I�v�V�����c�[��_�߂��p\00_proj
REM 19/03/01 CHG End

if exist *.bk  del /F /Q  *.bk

FOR /f %%b IN ('dir *.vbproj /b') DO (
	ren %%b %%b.bk
	REM 19/03/01 CHG Start
	REM call ..\�I�v�V����ver0.1.vbs %%b.bk
	cscript C:\�œK���I�v�V�����c�[��_�߂��p\�I�v�V����ver0.1.vbs %%b.bk
	REM 19/03/01 CHG End
	echo �ϊ����F%%~b
)

del /F /Q  ..\10_�œK��\*

move *.vbproj ..\10_�œK��

cd ..\

REM 19/03/01 DEL Start
REM pause
REM 19/03/01 DEL End