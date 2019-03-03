echo off
echo LogCheck_Kick.batを実行しています…

rem %1:バージョン番号(yymmdd_3xxnnn)
rem %2:X64 or Debug

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\LogCheck.ps1 %1 %2;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
exit %ERRORLEVEL%