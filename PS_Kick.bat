echo off
echo PS_Kick.batを実行しています…


rem powershell -ExecutionPolicy RemoteSigned C:\work\powerShellテスト\test2.ps1
powershell -ExecutionPolicy RemoteSigned %~dp0\test1.ps1


echo 完了しました！
pause > nul
exit