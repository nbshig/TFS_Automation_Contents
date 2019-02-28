#ビルド実行（Local用）準備処理
#
#引数１：バージョン番号（yymmdd_300nnn)
#
#
#ビルド実行（x64）後に、ローカル用ライブラリをビルドする為の準備処理
#


#引数を文字列に変換
#バージョン番号
$strVerNo = $Args[0] -as [string]

#
#SOLUTIONフォルダ作成
#
#以下のフォルダをコピーして、C:\直下に貼り付ける。
#C:\BuildSource\yymmdd_300nnn(x64)\Source
#貼り付けたフォルダを「SOLUTION」(半角大文字）にリネームする。

#コピー元フォルダ
$strOldFolder = "C:\BuildSource\${strVerNo}(x64)\Source"
#コピー先フォルダ
$strNewFolder = "C:\SOLUTION"

Copy-Item $strOldFolder $strNewFolder -Force -Recurse 



#
#最適化オプションツール_戻し用ツールの実施
#

#不要ファイルの削除
$str最適化戻しDir = "C:\最適化オプションツール_戻し用"

$strArray = @("00_proj","10_最適化","変換前")
foreach($item in $strArray) {

    $strTmpPath = Join-Path $str最適化戻しDir $item

    if ( test-path "$strTmpPath\*" ) {
        Write-Host "$strTmpPath の中身を削除します。"
        Remove-Item "$strTmpPath\*" -Recurse -Force
    }
}

#
#最適化オプションツール_戻し用ツール実行
#

#プロジェクトファイルコピー.bat
$p = Start-Process "C:\work\powerShellテスト\test.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "プロジェクトファイルコピー.batで異常終了発生：" $p.ExitCode
    exit $p.ExitCode
}


#最適化の追加.bat
$p = Start-Process "C:\work\powerShellテスト\test.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "最適化の追加.batで異常終了発生：" $p.ExitCode
    exit $p.ExitCode
}


#プロジェクトファイルコピー_最適化後.bat
$p = Start-Process "C:\work\powerShellテスト\test.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "プロジェクトファイルコピー_最適化後.batで異常終了発生：" $p.ExitCode
    exit $p.ExitCode
}

Write-Host "ビルド実行（Local用）準備処理が完了しました！"
exit 0
