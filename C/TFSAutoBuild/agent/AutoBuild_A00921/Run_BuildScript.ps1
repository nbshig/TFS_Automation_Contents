#Script-Name：Run_BuildScript.ps1
#
#引数1 : ソリューション構成No(1(x64) or 4(Debug)) 
#
#概要：BuildScript_開発_ビルド自動化用.batを実行する
#　　　(パラメータの共通化を図る為にBuild_config.csvを読み込むべくPowerShellからの呼び出しとする)
#

Write-Host "Run_BuildScript.ps1 開始"

#変数定義
$strBuildVerNo_Value = ""
$strBuildScriptPath_Value = ""

#引数を文字列に変換
$strSolConfigNo = $Args[0] -as [string]

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

if ($hash["BuildScriptPath"] -ne $null) {
    $strBuildScriptPath_Value = $hash["BuildScriptPath"].ToString()
} else {
    #引数のキーと対になるべき値が存在しないため、異常終了とする。
    write-host("エラー: 引数で渡したキーと対になる値がconfigファイル上に定義されていません。キー→ BuildScriptPath")
    Exit 2
}

#
#BuildScript_開発_ビルド自動化用.batの実行
#

if ( Test-Path "${strBuildScriptPath_Value}BuildScript_開発_ビルド自動化用.bat" ) {
    $p = Start-Process "${strBuildScriptPath_Value}BuildScript_開発_ビルド自動化用.bat" -ArgumentList $strBuildVerNo_Value,$strSolConfigNo -PassThru -Wait

    if ( $p.ExitCode -ne 0 ) {
        Write-Host "エラー：BuildScript_開発_ビルド自動化用.batで異常終了発生：" $p.ExitCode
        exit $p.ExitCode
    }
} else {
    write-host("エラー: パスの誤りがあります。パス→ " + "${strBuildScriptPath_Value}BuildScript_開発_ビルド自動化用.bat")
    Exit 2
} 

Write-Host "Run_BuildScript.ps1が終了しました"
exit 0