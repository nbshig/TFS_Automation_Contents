echo off
echo PS_Kick.batを実行しています…

rem powershell -ExecutionPolicy RemoteSigned %~dp0\test1.ps1
powershell -ExecutionPolicy RemoteSigned "C:\work\powerShellテスト\work\ReName.ps1 %1 %2;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 完了しました！
pause > nul
rem exit
