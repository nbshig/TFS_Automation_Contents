Get-ExecutionPolicy
#Set-ExecutionPolicy RemoteSigned

$arr_str行 = Get-Content C:\work\powerShellテスト\正規表現検証.txt -Encoding string | Select-Object -last 20

foreach ($i in $arr_str行) {
    Write-Host $i

    #if ($i -match "^(?=.*\d)(?!.*20).*$") {
        #1行の中に数値がある、かつ、20以外である数値である場合
    if ($i -match ("0 失敗|プリコンパイル処理終了|ビルドスクリプト処理正常終了")) {
        Write-Host "正常終了!"
        exit 0
    }
}

#最終行まで到達した場合、正常終了ログを発見出来なかったという事で、exit 1を返す
Write-Host "最終行まで到達！"
exit 1