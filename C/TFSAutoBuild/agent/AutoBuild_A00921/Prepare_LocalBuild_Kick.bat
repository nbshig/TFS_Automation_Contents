echo off
echo Prepare_LocalBuild_Kick.bat�����s���Ă��܂��c

rem %1:�o�[�W�����ԍ�(yymmdd_3xxnnn)

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Prepare_LocalBuild.ps1 %1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I
exit %ERRORLEVEL%