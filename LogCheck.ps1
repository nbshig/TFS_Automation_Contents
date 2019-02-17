Get-ExecutionPolicy
#Set-ExecutionPolicy RemoteSigned

$arr_str行 = Get-Content C:\work\powerShellテスト\正規表現検証.txt -Encoding string | Select-Object -last 2

foreach ($i in $arr_str行) {
    Write-Host $i

    if ($i -match "^(?=.*\d)(?!.*20).*$") {
        #1行の中に数値がある、かつ、20以外である数値である場合
        Write-Host "マッチした!"
    }
}