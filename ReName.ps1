#リネーム処理
#
#引数１：リネーム前パス名
#引数２：リネーム後パス名
#
#ReName_Kick.bat では、引数のパス名を""で囲むようにしてください。
#


#引数を文字列に変換
#リネーム元フォルダ
$strOldFolder = $Args[0] -as [string]
#リネーム先フォルダ
$strNewFolder = $Args[1] -as [string]

#リネーム開始
Write-Host "リネーム前：$strOldFolder"
Write-Host "リネーム後：$strNewFolder"

Write-Host "リネーム開始"

try {
    Rename-Item $strOldFolder -NewName $strNewFolder -ErrorAction Stop
} catch  {
    Write-Host "リネーム失敗!"
    exit 9
}

Write-Host "リネーム成功！"

exit 0
