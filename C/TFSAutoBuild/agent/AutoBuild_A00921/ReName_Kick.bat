echo off
echo ReName_Kick.bat�����s���Ă��܂��c

rem %1:�o�[�W�����ԍ��iyymmdd_300nnn�j

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\ReName.ps1 %1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I
exit %ERRORLEVEL%