

function Import_CSV() {

#変数定義
$strConfigFile = "C:\TFSAutoBuild\agent\AutoBuild_A00921\Build_config.csv"
$strConfigFile = "C:\work\powerShellテスト\Build_config.csv"

#ハッシュ変数の定義
$hash = @{}

#ファイルの存在を確認する
if((Test-Path $strConfigFile) -eq $false){
    write-host("エラー: configファイルが見つかりません: " + $strConfigFile)
    exit 2
}

#configファイルを読み込んでハッシュに変換する
Import-Csv $strConfigFile -Header "col1","col2" -Encoding Default | ForEach-Object { $hash.add($_.col1,$_.col2) }

return $hash
}
