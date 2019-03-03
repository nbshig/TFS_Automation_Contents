#Script-Name：Copy.ps1
#
#引数1：リポジトリ名
#
#概要：引数で渡されたリポジトリ名より、対象リポジトリのパスを選定して、該当リソースをマージフォルダへコピーする
#


#変数定義
$strAllResorce = "*"
$tf = '$tf'
$SVF_Image = "SVF\Images\"

#引数を文字列に変換
$strRepo = $Args[0] -as [string]

#ハッシュ変数の定義
$hash = @{}


#-- 共通モジュールロード
. "C:\TFSAutoBuild\agent\AutoBuild_A00921\Included.ps1"
#configファイルの読み込み
$hash = Import_CSV


#引数で渡されたキーと、対する値の確認
if ($hash[$strRepo] -ne $null) {
    $strリポジトリパス = $hash[$strRepo].ToString()
} else {
    #引数のキーと対になるべき値が存在しないため、異常終了とする。
    write-host("エラー: 引数で渡したキーと対になる値がconfigファイル上に定義されていません。キー→ " + $strRepo)
    Exit 2
}

##引数で渡されたキーと、対する値の確認（マージフォルダパスの準備）
if ($hash["SOLUTION"] -ne $null) {
    $strマージパス = $hash["SOLUTION"].ToString()
} else {
    #引数のキーと対になるべき値が存在しないため、異常終了とする。
    write-host("エラー: 引数で渡したキーと対になる値がconfigファイル上に定義されていません。キー→ SOLUTION")
    Exit 2
}


############################
#リソースのコピー
############################

if ("000" -eq $strRepo) {
    #"000"リポジトリの場合

    #"000"が一番最初にコピーするリポジトリになるので、SOLUTIONフォルダを作る
    #(COPY-ITEM でも強制的に作ることができるが、コピー先フォルダ(SOLUTION)の有無でコピー元のフォルダ含んでコピーするか否か挙動が変わってしまうので、
    # 最初からコピー先フォルダ(SOLUTION)を作る事とする。)
    if (test-path "C:\SOLUTION") {
        #本来、SOLUTIONフォルダが存在していてはいけないので異常終了とする。
        write-host("エラー: SOLUTIONフォルダが存在しています。")
        Exit 2
    } else {
        #SOLUTIONフォルダの作成
        New-Item C:\SOLUTION -ItemType Directory
    }

    #引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
    Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse 

    #コピー先フォルダ(SOLUTION)に不要なサブフォルダ($tf)もコピーしているので、削除する
    if ( Test-Path ${strマージパス}$tf ) {
        Remove-Item  ${strマージパス}$tf -Force -Recurse
    }

    #コピー先フォルダ(SOLUTION)に不要なサブフォルダもコピーしているので、削除する（なぜかImagesフォルダもTFSからダウンロードされる。表示上ないのに。。）
    if ( Test-Path C:\SOLUTION\SVF\Images ) {
        Remove-Item  C:\SOLUTION\SVF\Images -Force -Recurse
    }

    #000フォルダのリソースを削除する
    Remove-Item  ${strリポジトリパス}${strAllResorce} -Force -Recurse

} elseif ("100","300" -contains $strRepo) {
    #"100","300"リポジトリの場合

    #引数で渡されたリポジトリパスのリソースをマージ用フォルダにコピーする
    Copy-Item ${strリポジトリパス}${strAllResorce} $strマージパス -Force -Recurse 
    #Copy-Item ${strリポジトリパス} $strマージパス -Force -Recurse 

    #コピー先フォルダ(SOLUTION)に不要なサブフォルダ($tf)もコピーしているので、削除する
    if ( Test-Path ${strマージパス}$tf ) {
        Remove-Item  ${strマージパス}$tf -Force -Recurse
    }

    #コピー先フォルダ(SOLUTION)に不要なサブフォルダもコピーしているので、削除する（なぜかImagesフォルダもTFSからダウンロードされる。表示上ないのに。。）
    if ( Test-Path C:\SOLUTION\SVF\Images ) {
        Remove-Item  C:\SOLUTION\SVF\Images -Force -Recurse
    }

    ############################
    #引数で渡されたリポジトリの削除
    ############################

    #Write-Host ${strリポジトリパス}${strAllResorce}
    #pause
    #100,300フォルダのリソースを削除する
    Remove-Item  ${strリポジトリパス}${strAllResorce} -Force -Recurse 
    #Remove-Item  ${strリポジトリパス} -Force -Recurse 


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




