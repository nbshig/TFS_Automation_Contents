############################
#
#引数で渡されたリポジトリのリソースをマージフォルダへコピーする
#
############################

#変数定義
$strConfigFile = "C:\TFSAutoBuild\agent\AutoBuild_A00921\Build_config.csv"
$strAllResorce = "*"
$tf = '$tf'
$SVF_Image = "SVF\Images\"

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
#Read-Host "続けるにはENTERキーを押して下さい" 
#configファイルを読み込んでハッシュに変換する
Import-Csv $strConfigFile -Encoding Default | ForEach-Object { $hash.add($_.リポジトリ,$_.パス) }

#引数で渡されたリポジトリパスの準備
$strリポジトリパス = $hash[$strRepo].ToString()
#Write-Host $strリポジトリパス

#マージフォルダパスの準備
$strマージパス = $hash["SOLUTION"].ToString()
#Write-Host $strマージパス

############################
#リソースのコピー
############################

if ("000" -eq $strRepo) {
	#"000"リポジトリの場合

	#"000"が一番最初にコピーするリポジトリになるので、SOLUTIONフォルダを作る
	#(COPY-ITEM でも強制的に作ることができるが、コピー先フォルダ(SOLUTION)の有無でコピー元のフォルダ含んでコピーするか否か挙動が変わってしまうので、
	# 最初からコピー先フォルダ(SOLUTION)を作る事とする。)
	New-Item C:\SOLUTION -ItemType Directory

	#引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
	Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse 

	#コピー先フォルダ(SOLUTION)に不要なサブフォルダ($tf)もコピーしているので、削除する
	if ( Test-Path ${strマージパス}$tf ) {
		Remove-Item ${strマージパス}$tf -Force -Recurse
	}

	#コピー先フォルダ(SOLUTION)に不要なサブフォルダ()もコピーしているので、削除する（なぜかImagesフォルダもTFSからダウンロードされる。表示上ないのに。。）
	if ( Test-Path C:\SOLUTION\SVF\Images ) {
		Remove-Item C:\SOLUTION\SVF\Images -Force -Recurse
	}

	#000フォルダのリソースを削除する
	Remove-Item ${strリポジトリパス}${strAllResorce} -Force -Recurse

} elseif ("100","300" -contains $strRepo) {
	#"100","300"リポジトリの場合

	#引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
	Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse 
	#Copy-Item ${strリポジトリパス} $strマージパス -Force -Recurse 

	#コピー先フォルダ(SOLUTION)に不要なサブフォルダ($tf)もコピーしているので、削除する
	if ( Test-Path ${strマージパス}$tf ) {
		Remove-Item ${strマージパス}$tf -Force -Recurse
	}

	#コピー先フォルダ(SOLUTION)に不要なサブフォルダ()もコピーしているので、削除する（なぜかImagesフォルダもTFSからダウンロードされる。表示上ないのに。。）
	if ( Test-Path C:\SOLUTION\SVF\Images ) {
		Remove-Item C:\SOLUTION\SVF\Images -Force -Recurse
	}

	############################
	#引数で渡されたリポジトリの削除
	############################

	#Write-Host ${strリポジトリパス}${strAllResorce}
	#pause
	#100,300フォルダのリソースを削除する
	Remove-Item ${strリポジトリパス}${strAllResorce} -Force -Recurse 
	#Remove-Item ${strリポジトリパス} -Force -Recurse 


} elseif ("Images" -eq $strRepo) {
	#"Images"リポジトリの場合

	#Imageフォルダをマージ用フォルダにコピーする
	Copy-Item ${strリポジトリパス} ${strマージパス}${SVF_Image} -Force -Recurse


} else {
	#上記以外のリポジトリの場合（案件フォルダなど）
	#Write-Host "案件フォルダの場合"
	#pause

	#net use接続
	net use Z: \\128.250.131.145\ShareDocs

	#引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
	Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse
	#Copy-Item ${strリポジトリパス} $strマージパス -Force -Recurse 

	#net use切断
	net use z: /delete /y
}
