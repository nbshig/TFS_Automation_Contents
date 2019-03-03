echo off
echo ReName_Kick.batを実行しています…

rem %1:バージョン番号（yymmdd_300nnn）

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\ReName.ps1 %1;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
exit %ERRORLEVEL%