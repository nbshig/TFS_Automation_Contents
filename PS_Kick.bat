echo off
echo PS_Kick.bat�����s���Ă��܂��c


rem powershell -ExecutionPolicy RemoteSigned C:\work\powerShell�e�X�g\test2.ps1
powershell -ExecutionPolicy RemoteSigned %~dp0\test1.ps1


echo �������܂����I
pause > nul
exit