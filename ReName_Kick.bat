echo off
echo PS_Kick.bat�����s���Ă��܂��c

rem powershell -ExecutionPolicy RemoteSigned %~dp0\test1.ps1
powershell -ExecutionPolicy RemoteSigned "C:\work\powerShell�e�X�g\work\ReName.ps1 %1 %2;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �������܂����I
pause > nul
rem exit
