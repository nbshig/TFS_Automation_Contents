echo off
echo Prepare_LocalBuild_Kick.bat�����s���Ă��܂��c


powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Prepare_LocalBuild.ps1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I
exit %ERRORLEVEL%