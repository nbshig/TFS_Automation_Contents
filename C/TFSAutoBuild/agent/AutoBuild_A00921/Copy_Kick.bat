echo off
echo Copy_Kick.bat�����s���Ă��܂��c

rem %1:���|�W�g����

REM powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Copy.ps1 %1;exit $LASTEXITCODE"
powershell -ExecutionPolicy RemoteSigned "C:\work\powerShell�e�X�g\C_ver2\TFSAutoBuild\agent\AutoBuild_A00921\Copy.ps1 %1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I
pause
exit %ERRORLEVEL%