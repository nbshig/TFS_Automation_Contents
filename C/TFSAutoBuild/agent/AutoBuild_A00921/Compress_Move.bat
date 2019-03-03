echo off
echo Compress_Move.batを実行しています…

rem %1:バージョン番号(yymmdd_3xxnnn)

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Compress_Move.ps1 %1;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
exit %ERRORLEVEL%