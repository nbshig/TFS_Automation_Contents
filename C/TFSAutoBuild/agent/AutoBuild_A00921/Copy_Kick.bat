echo off
echo Copy_Kick.batを実行しています…

rem %1:リポジトリ名

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Copy.ps1 %1;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
exit %ERRORLEVEL%