echo off
echo Run_BuildScript_Kick.bat�����s���Ă��܂��c

rem %1:�\�����[�V�����\��No(1(x64) or 4(Debug)) 

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Run_BuildScript %1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I
pause
exit %ERRORLEVEL%