echo off
echo ReName_Kick.bat�����s���Ă��܂��c


powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\ReName.ps1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I


echo Compress_Move_Kick.bat�����s���Ă��܂��c

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Compress_Move.ps1;exit $LASTEXITCODE"

echo Powershell����󂯎�����߂�l��%ERRORLEVEL%

echo �I�����܂����I


exit %ERRORLEVEL%