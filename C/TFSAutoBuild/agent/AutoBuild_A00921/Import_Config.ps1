#Script-Name�FImport_Config.ps1
#
#
#
#�T�v�FConfig�t�@�C���̓ǂݍ���
#

function putMessage($mText){
    Write-Host((Get-Date).ToString("yyyy/MM/dd HH:mm:ss.fff ")+$mText)
}
 
#�ϐ���`
$strConfigFile = "C:\TFSAutoBuild\agent\AutoBuild_A00921\Build_config.csv"

############################
#config�t�@�C���̓ǂݍ���
############################

#�n�b�V���ϐ��̒�`
$hash = @{}

#�t�@�C���̑��݂��m�F����
if((Test-Path $strConfigFile) -eq $false){
    write-host("�G���[: config�t�@�C����������܂���: " + $strConfigFile)
    exit 2
}    
#config�t�@�C����ǂݍ���Ńn�b�V���ɕϊ�����
Import-Csv $strConfigFile -Encoding Default | ForEach-Object { $hash.add($_.Key,$_.Value) }

#�r���h�o�[�W����No�̏���
if ($hash["BuildVerNo"] -ne $null) {
    $BuildVerNo = $hash["BuildVerNo"].ToString()
} else {
    #Key�Ƒ΂ɂȂ�ׂ�Value�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("Key�Ƒ΂ɂȂ�Value��config�t�@�C����ɒ�`����Ă��܂���BKey��BuildVerNo ")
    Exit 2
}