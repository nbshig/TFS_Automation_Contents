#Script-Name：LogCheck.ps1
#
#引数1：バージョン番号（yymmdd_30xnnn）
#引数2：ビルドバージョン（x64 or Debug）
#
#概要：ビルド実行後のログファイルについてチェックする
#

#変数定義
$strBuildLogDir = "C:\BuildLog\"

#ハッシュ変数の定義
$hash = @{}


#引数を文字列に変換

 #ログフォルダ名
$strBuildLogFolderName = $Args[0] -as [string]
#X64 or Debug
$strBuildLogVer = $Args[1] -as [string]
if ($strBuildLogVer = "x64") {
    #X64のとき
    $strBuildLogVer = "(${strBuildLogVer})"
} else {
    #Debugのとき（もしくは何も入っていないか、何か他の文字列が入っているとき）
    $strBuildLogVer = ""
}


# 処理対象のフォルダ
$targetFolder = "${strBuildLogDir}${strBuildLogFolderName}${strBuildLogVer}"

if ((Test-Path $targetFolder) -ne $true) {
    write-host("エラー: ログ確認対象フォルダが見つかりません: " + $targetFolder)
    exit 2
}

# $targetFolder内のファイル・フォルダのリストを取得する。
$itemList = Get-ChildItem $targetFolder;

$itemList | ForEach-Object { $hash.add($_.Name,$_.value) }

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
                $hash[$item.Name] = $true
                break
            }
        }
            if ( $hash[$item.Name] -ne $true ) {
                #ログファイル上に正常終了ログを発見できなかった
                $hash[$item.Name.tostring()] = $false
            }
    }
} 

if ( $hash.ContainsValue($false) ) {
    #FALSEが存在する場合、正常終了ログを発見出来なかったという事で、exit 3を返す
    Write-Host "異常終了を示すログファイルが存在します。確認してください。"
    exit 3
}

Write-Host "ログチェック終了"
exit 0