#Script-Name：Prepare_LocalBuild.ps1
#
#
#
#概要：ビルド実行（x64）後に、ローカル用ライブラリをビルドする為の準備を行う
#


#変数定義
$strBuildVerNo_Value = ""

#ハッシュ変数の定義
$hash = @{}


#-- 共通モジュールロード
. "C:\TFSAutoBuild\agent\AutoBuild_A00921\Include.ps1"
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



#
#SOLUTIONフォルダ作成
#
#以下のフォルダをコピーして、C:\直下に貼り付ける。
#C:\BuildSource\yymmdd_300nnn(x64)\Source
#貼り付けたフォルダを「SOLUTION」(半角大文字）にリネームする。

#コピー元フォルダ
$strOldFolder = "C:\BuildSource\${strBuildVerNo_Value}(x64)\Source"
#コピー先フォルダ
$strNewFolder = "C:\SOLUTION"

if ((test-path $strOldFolder) -ne $true) {
    #コピー元ファイルが存在しない場合は異常終了とする。
    write-host("エラー: コピー元フォルダが存在しません: " + $strOldFolder)
    exit 2
}

if (test-path $strNewFolder) {
    #本来、コピー先フォルダ（SOLUTION）が存在していてはいけないので異常終了とする。
    write-host("エラー: SOLUTIONフォルダが存在しています。")
    Exit 2
} else {
    #リソースのコピー（"SOLUTION"でリネーム）
    Copy-Item $strOldFolder $strNewFolder -Force -Recurse 
}

#
#最適化オプションツール_戻し用ツールの実施
#

#不要ファイルの削除
$str最適化戻しDir = "C:\最適化オプションツール_戻し用"

$strArray = @("00_proj","10_最適化","変換前")
foreach($item in $strArray) {

    $strTmpPath = Join-Path $str最適化戻しDir $item

    if ( test-path "$strTmpPath\*" ) {
        Write-Host "$strTmpPath の中身あり。"
        Write-Host "$strTmpPath の中身を削除します。"
        Remove-Item "$strTmpPath\*" -Recurse -Force
    }
}

#
#最適化オプションツール_戻し用ツール実行
#

#プロジェクトファイルコピー.bat
$p = Start-Process "$str最適化戻しDir\プロジェクトファイルコピー_ビルド自動化用.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "エラー：プロジェクトファイルコピー_ビルド自動化用.batで異常終了発生：" $p.ExitCode
    exit $p.ExitCode
}



#最適化の追加.bat
$p = Start-Process "$str最適化戻しDir\最適化の追加_ビルド自動化用.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "最適化の追加_ビルド自動化用.batで異常終了発生：" $p.ExitCode
    exit $p.ExitCode
}


#プロジェクトファイルコピー_最適化後.bat
$p = Start-Process "$str最適化戻しDir\プロジェクトファイルコピー_最適化後_ビルド自動化用.bat" -ArgumentList "ALL" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "プロジェクトファイルコピー_最適化後.batで異常終了発生：" $p.ExitCode
    exit $p.ExitCode
}

Write-Host "ビルド実行（Local用）準備処理が終了しました"
exit 0