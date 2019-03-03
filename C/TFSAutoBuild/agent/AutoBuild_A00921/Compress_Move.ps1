#Script-Name：Compress_Move.ps1
#
#引数1：バージョン番号（yymmdd_300nnn)
#
#
#概要：ビルドした各ライブラリリソースを圧縮して、配布先へ格納する。
#

#引数を文字列に変換
#バージョン番号
$strVerNo = $Args[0] -as [string]


#
#リソースの圧縮(InstallImage)
#

Write-Host "InstallImageの圧縮 開始"

#圧縮/コピー元フォルダ(x64)
if ((Test-Path "C:\InstallImage\${strVerNo}_RTB(x64)") -ne $true) {
    write-host("エラー: 圧縮/コピー元フォルダ(InstallImage - x64)が見つかりません: " + "C:\InstallImage\${strVerNo}_RTB(x64)")
    exit 2
}

$strComp元_x64Dir = "C:\InstallImage\${strVerNo}_RTB(x64)\"

#リソースの圧縮(x64)　
try {
    Write-Host  "C:\InstallImage\${strVerNo}_RTB(x64)  圧縮開始"
    Compress-Archive -path $strComp元_x64Dir -DestinationPath "${strVerNo}_RTB(x64).zip" -ErrorAction stop
    Write-Host  "C:\InstallImage\${strVerNo}_RTB(x64)  圧縮終了"
} catch {
    Write-Host "リソースの圧縮(InstallImage - x64)　失敗!"
    exit 9
}

#圧縮/コピー元フォルダ(Debug)
if ((Test-Path "C:\InstallImage\${strVerNo}_RTB(Debug)") -ne $true) {
    write-host("エラー: 圧縮/コピー元フォルダ(InstallImage - Debug)が見つかりません: " + "C:\InstallImage\${strVerNo}_RTB(Debug)")
    exit 2
}
$strComp元_DebugDir = "C:\InstallImage\${strVerNo}_RTB(Debug)\"

#リソースの圧縮(Debug)
try {
    Write-Host  "C:\InstallImage\${strVerNo}_RTB(Debug)  圧縮開始"
    Compress-Archive -path $strComp元_DebugDir -DestinationPath "${strVerNo}_RTB(Debug).zip" -ErrorAction stop
    Write-Host  "C:\InstallImage\${strVerNo}_RTB(Debug)  圧縮終了"
} catch {
    Write-Host "リソースの圧縮(InstallImage - Debug)　失敗!"
    exit 9
}

Write-Host "InstallImageの圧縮 終了"

#
#リソースの移動(InstallImage)
#

Write-Host "InstallImageの移動 開始"

#(1) バッチ管理サーバー
$strコピー先Dir = "\\H031S3274\Release"

#net use接続
net use Z: $strコピー先Dir

#InstallImage(x64)について、バッチ管理サーバーへコピーする
try {
    Copy-Item .\"${strVerNo}_RTB(x64).zip" $strコピー先Dir -ErrorAction stop
} catch {
    Write-Host "バッチ管理サーバーへのコピー　失敗!(InstallImage)"
    exit 9
}

#net use切断
net use z: /delete /y
$strコピー先Dir = $null


#(2) Sharedocs
$strコピー先Dir = "\\128.250.131.145\ShareDocs\30_運用\50_リソース管理\11_IT\01_ライブラリ\02_InstallImage"

#net use接続
net use Z: $strコピー先Dir

#InstallImage(x64),(Debug)について移動する
try {
    Move-Item .\"*.zip" $strコピー先Dir -ErrorAction stop
} catch {
    Write-Host "Sharedocsへの移動　失敗!(InstallImage)"
    exit 9
}


#net use切断
net use z: /delete /y

$strComp元_x64Dir = $null
$strComp元_DebugDir = $null
$strコピー先Dir = $null

Write-Host "InstallImageの移動 終了"



#
#リソースの圧縮(BuildSource)
#
Write-Host "BuildSourceの圧縮 開始"

#圧縮/コピー元フォルダ(x64)
if ((Test-Path "C:\BuildSource\${strVerNo}(x64)") -ne $true) {
    write-host("エラー: 圧縮/コピー元フォルダ(BuildSource - x64)が見つかりません: " + "C:\BuildSource\${strVerNo}(x64)")
    exit 2
}
$strComp元_x64Dir = "C:\BuildSource\${strVerNo}(x64)\"

#リソースの圧縮(x64)
try {
    Write-Host  "C:\BuildSource\${strVerNo}(x64)  圧縮開始"
    Compress-Archive -path $strComp元_x64Dir -DestinationPath "${strVerNo}(x64).zip" -ErrorAction stop
    Write-Host  "C:\BuildSource\${strVerNo}(x64)  圧縮終了"
} catch {
    Write-Host "リソースの圧縮(BuildSource - x64)　失敗!"
    exit 9
}


#圧縮/コピー元フォルダ(Debug)
if ((Test-Path "C:\BuildSource\${strVerNo}(Debug)") -ne $true) {
    write-host("エラー: 圧縮/コピー元フォルダ(BuildSource - Debug)が見つかりません: " + "C:\BuildSource\${strVerNo}(Debug)")
    exit 2
}
$strComp元_DebugDir = "C:\BuildSource\${strVerNo}(Debug)\"

#リソースの圧縮(Debug)　
try {
    Write-Host  "C:\BuildSource\${strVerNo}(Debug)  圧縮開始"
    Compress-Archive -path $strComp元_DebugDir -DestinationPath "${strVerNo}(Debug).zip" -ErrorAction stop
    Write-Host  "C:\BuildSource\${strVerNo}(Debug)  圧縮終了"
} catch {
    Write-Host "リソースの圧縮(BuildSource - Debug)　失敗!"
    exit 9
}

Write-Host "BuildSourceの圧縮 終了"


#
#リソースの移動(BuildSource)
#
Write-Host "BuildSourceの移動 開始"

$strコピー先Dir = "\\128.250.131.145\ShareDocs\30_運用\50_リソース管理\11_IT\01_ライブラリ\01_Source"
#net use接続
net use Z: $strコピー先Dir

#引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
Move-Item .\"*.zip" $strコピー先Dir

#BuildSource(x64),(Debug)について移動する
try {
    Move-Item .\"*.zip" $strコピー先Dir -ErrorAction stop
} catch {
    Write-Host "Sharedocsへの移動　失敗!(BuildSource)"
    exit 9
}


#net use切断
net use z: /delete /y

$strComp元_x64Dir = $null
$strComp元_DebugDir = $null
$strコピー先Dir = $null

Write-Host "BuildSourceの移動 終了"


#
#不要ライブラリの削除
#

#C:\SOLUTIONフォルダが存在していれば削除する
if ( Test-Path "C:\SOLUTION" ) {
    Write-Host "SOLUTIONフォルダの削除 開始"

    Remove-Item "C:\SOLUTION" -Force -Recurse

    Write-Host "SOLUTIONフォルダの削除 終了"
}


Write-Host "リソースの圧縮、移動処理終了"
exit 0