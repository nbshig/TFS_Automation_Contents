echo off
echo Copy_Kick.batを実行しています…

rem %1:リポジトリ名

REM powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Copy.ps1 %1;exit $LASTEXITCODE"
powershell -ExecutionPolicy RemoteSigned "C:\work\powerShellテスト\C_ver2\TFSAutoBuild\agent\AutoBuild_A00921\Copy.ps1 %1;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
pause
exit %ERRORLEVEL%