echo off
echo LogCheck_Kick.bat�����s���Ă��܂��c

rem %1:�\�����[�V�����\��No(x64 or Debug) 

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\LogCheck.ps1 %1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I
exit %ERRORLEVEL%