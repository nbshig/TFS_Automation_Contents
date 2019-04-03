#Script-Name：LogCheck.ps1
#
#引数1：ソリューション構成No(1:x64 or 4:Debug) 
#
#概要：ビルド実行後のログファイルについてチェックする
#

#変数定義
$strBuildVerNo_Value = ""
$strBuildLogPath_Value = ""

#ハッシュ変数の定義
$hash = @{}
$hash_LogList = @{}

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

if ($hash["BuildLogPath"] -ne $null) {
    $strBuildLogPath_Value = $hash["BuildLogPath"].ToString()
} else {
    #引数のキーと対になるべき値が存在しないため、異常終了とする。
    write-host("エラー: 引数で渡したキーと対になる値がconfigファイル上に定義されていません。キー→ BuildLogPath")
    Exit 2
}



#引数を文字列に変換

#X64 or Debug
$strSolConfigNo = $Args[0] -as [string]
if ($strSolConfigNo -eq "1") {
    #X64のとき
    $strSolConfigNo = "(x64)"
} else {
    #Debugのとき（もしくは何も入っていないか、何か他の文字列が入っているとき）
    $strSolConfigNo = ""
}


# 処理対象のフォルダ
$targetFolder = "${strBuildLogPath_Value}${strBuildVerNo_Value}${strSolConfigNo}"

if ((Test-Path $targetFolder) -ne $true) {
    write-host("エラー: ログ確認対象フォルダが見つかりません: " + $targetFolder)
    exit 2
}

# $targetFolder内のファイル・フォルダのリストを取得する。
$itemList = Get-ChildItem $targetFolder;

$itemList | ForEach-Object { $hash_LogList.add($_.Name,$_.value) }

foreach($item in $itemList) {
    if($item.PSIsContainer) {
        # フォルダの場合は、想定外。処理なし
    } else {
        # ファイルの場合の処理
        Write-Host ($item.Name + "をチェック開始")
        #最後から20行を取得
        $arr_str行 = Get-Content ( join-path ${targetFolder} $item.Name.tostring() ) -Encoding string | Select-Object -last 20

        foreach ($i in $arr_str行) {

            #if ($i -match "^(?=.*\d)(?!.*20).*$") {　←正規表現のお勉強（1行の中に数値がある、かつ、20以外の数値であるケース）
            if ($i -match ("0 失敗|プリコンパイル処理終了|ビルドスクリプト処理正常終了")) {
                Write-Host ($item.Name + "は、正常終了")
                $hash_LogList[$item.Name] = $true
                break
            }
        }
            if ( $hash_LogList[$item.Name] -ne $true ) {
                #ログファイル上に正常終了ログを発見できなかった
                $hash_LogList[$item.Name.tostring()] = $false
            }
    }
} 

if ( $hash_LogList.ContainsValue($false) ) {
    #FALSEが存在する場合、正常終了ログを発見出来なかったという事で、exit 3を返す
    Write-Host "異常終了を示すログファイルが存在します。確認してください。"
    exit 3
}

Write-Host "ログチェック終了"
exit 0