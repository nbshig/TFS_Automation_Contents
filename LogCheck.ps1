

#変数定義
$strBuildLogDir = "C:\BuildLog\"

#ハッシュ変数の定義
$hash = @{}


#引数を文字列に変換

 #ログフォルダ名
$strBuildLogFolderName = $Args[0] -as [string]
#X64 or Debug
$strBuildLogVer = $Args[1] -as [string]
$strBuildLogVer = "(${strBuildLogVer})"


# 処理対象のフォルダ
$targetFolder = "${strBuildLogDir}${strBuildLogFolderName}${strBuildLogVer}"
 
# $targetFolder内のファイル・フォルダのリストを取得する。
$itemList = Get-ChildItem $targetFolder;

$itemList | ForEach-Object { $hash.add($_.Name,$_.value) }

foreach($item in $itemList) {
    if($item.PSIsContainer) {
        # フォルダの場合は、想定外。処理なし
    } else {
        # ファイルの場合の処理
        Write-Host ($item.Name + "をチェック開始!")
        #最後から20行を取得
        $arr_str行 = Get-Content ( join-path ${targetFolder} $item.Name.tostring() ) -Encoding string | Select-Object -last 20

        foreach ($i in $arr_str行) {
            #Write-Host $i

            #if ($i -match "^(?=.*\d)(?!.*20).*$") {
            #1行の中に数値がある、かつ、20以外である数値である場合
            if ($i -match ("0 失敗|プリコンパイル処理終了|ビルドスクリプト処理正常終了")) {
                Write-Host ($item.Name + "は、正常終了!")
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
    #FALSEが存在する場合、正常終了ログを発見出来なかったという事で、exit 1を返す
    Write-Host "異常終了を示すログファイルが存在します。確認してください。"
    exit 1
}

Write-Host "最終行まで到達！"
exit 0
