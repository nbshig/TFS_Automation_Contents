############################
#
#引数で渡されたリポジトリのリソースをマージフォルダへコピーする
#
############################

#変数定義
$strConfigFile = "C:\work\powerShellテスト\Build_config.csv"
$strAllResorce = "*"

#引数を文字列に変換
$strRepo = $Args[0] -as [string]
#Write-Host $strRepo
############################
#configファイルの読み込み
############################

#ハッシュ変数の定義
$hash = @{}


#ファイルの存在を確認する
if((Test-Path $strConfigFile) -eq $false){
    write-host("ERROR: Not found configFile: " + $strConfigFile)
    exit 9
}    

#configファイルを読み込んでハッシュに変換する
Import-Csv $strConfigFile -Encoding Default | ForEach-Object { $hash.add($_.リポジトリ,$_.パス) }

#引数で渡されたリポジトリパスの準備
$strリポジトリパス = $hash[$strRepo].ToString()
#Write-Host $strリポジトリパス

#マージフォルダパスの準備
$strマージパス = $hash["マージ"].ToString()
#Write-Host $strマージパス

############################
#リソースのコピー
############################

if ("000","100","300" -contains $strRepo) {
    #"000","100","300"リポジトリの場合
    #Write-Host '"000","100","300"リポジトリの場合'
    #pause
    #引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
    Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse 

    ############################
    #引数で渡されたリポジトリの削除
    ############################

    #Write-Host ${strリポジトリパス}${strAllResorce}
    #pause
    #000フォルダのリソースを削除する
    Remove-Item  ${strリポジトリパス}${strAllResorce} -Force -Recurse 

} else {
    #上記以外のリポジトリの場合（案件フォルダなど）
    #Write-Host "案件フォルダの場合"
    #pause

    #net use接続
    net use Z: \\192.168.11.7\C$

    #引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
    Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse 
    #pause

    #net use切断
    net use Z: /delete
}




