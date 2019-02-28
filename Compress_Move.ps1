#リソースの圧縮、移動処理
#
#引数１：バージョン番号（yymmdd_300nnn)
#
#
#ビルドした各ライブラリリソースを圧縮して、配布先へ格納する。
#

#引数を文字列に変換
#バージョン番号
$strVerNo = $Args[0] -as [string]


#
#リソースの圧縮(InstallImage)/移動
#


#圧縮/コピー元フォルダ(x64)
$strComp元_x64Dir = "C:\InstallImage\${strVerNo}_RTB(x64)\"

#リソースの圧縮(x64)　
Compress-Archive -path $strComp元_x64Dir -DestinationPath "${strVerNo}_RTB(x64).zip"


#圧縮/コピー元フォルダ(Debug)
$strComp元_DebugDir = "C:\InstallImage\${strVerNo}_RTB(Debug)\"

#リソースの圧縮(Debug)　
Compress-Archive -path $strComp元_DebugDir -DestinationPath "${strVerNo}_RTB(Debug).zip"


#リソースの移動

#(1) バッチ管理サーバー
$strコピー先Dir = "\\H031S3274\Release"

#net use接続
net use Z: $strコピー先Dir

#InstallImage(x64)についてコピーする
Copy-Item .\"${strVerNo}_RTB(x64).zip" $strコピー先Dir

#net use切断
net use z: /delete /y


#(2) Sharedocs
$strコピー先Dir = "\\128.250.131.145\ShareDocs\30_運用\50_リソース管理\11_IT\01_ライブラリ\02_InstallImage"

#net use接続
net use Z: $strコピー先Dir

#InstallImage(x64),(Debug)について移動する
Move-Item .\"*.zip" $strコピー先Dir

#net use切断
net use z: /delete /y





#
#リソースの圧縮(BuildSource)/移動
#


#圧縮/コピー元フォルダ(x64)
$strComp元_x64Dir = "C:\BuildSource\${strVerNo}(x64)\"

#リソースの圧縮(x64)　
Compress-Archive -path $strComp元_x64Dir -DestinationPath "${strVerNo}(x64).zip"


#圧縮/コピー元フォルダ(Debug)
$strComp元_DebugDir = "C:\BuildSource\${strVerNo}(Debug)\"

#リソースの圧縮(Debug)　
Compress-Archive -path $strComp元_DebugDir -DestinationPath "${strVerNo}(Debug).zip"


#リソースの移動
$strコピー先Dir = "\\128.250.131.145\ShareDocs\30_運用\50_リソース管理\11_IT\01_ライブラリ\01_Source"
#net use接続
net use Z: $strコピー先Dir

#引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
Move-Item .\"*.zip" $strコピー先Dir

#net use切断
net use z: /delete /y


Write-Host "リソースの圧縮、移動処理！"
exit 0
