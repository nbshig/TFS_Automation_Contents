echo off
echo Run_BuildScript_Kick.batを実行しています…

rem %1:ソリューション構成No(1(x64) or 4(Debug)) 

powershell -ExecutionPolicy RemoteSigned "C:\TFSAutoBuild\agent\AutoBuild_A00921\Run_BuildScript %1;exit $LASTEXITCODE"

echo Powershellから受け取った戻り値→%ERRORLEVEL%

echo 終了しました！
pause
exit %ERRORLEVEL%