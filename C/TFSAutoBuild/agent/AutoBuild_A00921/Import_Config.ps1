#Script-Name：Import_Config.ps1
#
#
#
#概要：Configファイルの読み込み
#

function putMessage($mText){
    Write-Host((Get-Date).ToString("yyyy/MM/dd HH:mm:ss.fff ")+$mText)
}
 
#変数定義
$strConfigFile = "C:\TFSAutoBuild\agent\AutoBuild_A00921\Build_config.csv"

############################
#configファイルの読み込み
############################

#ハッシュ変数の定義
$hash = @{}

#ファイルの存在を確認する
if((Test-Path $strConfigFile) -eq $false){
    write-host("エラー: configファイルが見つかりません: " + $strConfigFile)
    exit 2
}    
#configファイルを読み込んでハッシュに変換する
Import-Csv $strConfigFile -Encoding Default | ForEach-Object { $hash.add($_.Key,$_.Value) }

#ビルドバージョンNoの準備
if ($hash["BuildVerNo"] -ne $null) {
    $BuildVerNo = $hash["BuildVerNo"].ToString()
} else {
    #Keyと対になるべきValueが存在しないため、異常終了とする。
    write-host("Keyと対になるValueがconfigファイル上に定義されていません。Key→BuildVerNo ")
    Exit 2
}