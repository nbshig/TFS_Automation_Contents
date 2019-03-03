#Script-Name：ReName.ps1
#
#引数1：バージョン番号（yymmdd_300nnn）
#
#概要：引数1で渡されたバージョン番号のフォルダに(Debug)を付加してリネームする
#


#引数を文字列に変換
#バージョン番号（yymmdd_300nnn）
$strVerNo = $Args[0] -as [string]

$strReName1 = "C:\BuildLog\${strVerNo}"
$strReName2 = "C:\BuildSource\${strVerNo}"
$strReName3 = "C:\InstallImage\${strVerNo}_RTB"

#リネーム開始
Write-Host "以下の通りリネームする"
Write-Host "リネーム1 前：$strReName1"
Write-Host "リネーム1 後：$strReName1(Debug)"

Write-Host "リネーム2 前：$strReName2"
Write-Host "リネーム2 後：$strReName2(Debug)"

Write-Host "リネーム3 前：$strReName3"
Write-Host "リネーム3 後：$strReName3(Debug)"

Write-Host "リネーム開始"

try {
    Rename-Item $strReName1 -NewName "${strVerNo}(Debug)" -ErrorAction Stop
    Rename-Item $strReName2 -NewName "${strVerNo}(Debug)" -ErrorAction Stop
    Rename-Item $strReName3 -NewName "${strVerNo}(Debug)" -ErrorAction Stop
} catch  {
    Write-Host "リネーム失敗!"
    exit 9
}

Write-Host "リネーム成功！"
exit 0