echo off
echo Prepare_LocalBuild_Kick.batを実行しています…


powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Prepare_LocalBuild.ps1;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
exit %ERRORLEVEL%