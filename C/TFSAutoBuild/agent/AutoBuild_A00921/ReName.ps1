#Script-Name：ReName.ps1
#
#
#
#概要：引数1で渡されたバージョン番号のフォルダに(Debug)を付加してリネームする
#


#変数定義
$strBuildVerNo_Value = ""

#ハッシュ変数の定義
$hash = @{}


#-- 共通モジュールロード
. "C:\TFSAutoBuild\agent\AutoBuild_A00921\Included.ps1"
#configファイルの読み込み
$hash = Import_CSV

#キーと、対する値の確認
if ($hash["BuildVerNo"] -ne $null) {
    $strBuildVerNo_Value = $hash["BuildVerNo"].ToString()
} else {
    #キーと対になるべき値が存在しないため、異常終了とする。
    write-host("エラー: キーと対になる値がconfigファイル上に定義されていません。キー→ BuildVerNo")
    Exit 2
}


$strReName1 = "C:\BuildLog\${strBuildVerNo_Value}"
$strReName2 = "C:\BuildSource\${strBuildVerNo_Value}"
$strReName3 = "C:\InstallImage\${strBuildVerNo_Value}_RTB"

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
    Rename-Item $strReName1 -NewName "${strBuildVerNo_Value}(Debug)" -ErrorAction Stop
    Rename-Item $strReName2 -NewName "${strBuildVerNo_Value}(Debug)" -ErrorAction Stop
    Rename-Item $strReName3 -NewName "${strBuildVerNo_Value}(Debug)" -ErrorAction Stop
} catch  {
    Write-Host "リネーム失敗!"
    exit 9
}

Write-Host "リネーム成功！"
exit 0