

function Import_CSV() {

#�ϐ���`
$strConfigFile = "C:\TFSAutoBuild\agent\AutoBuild_A00921\Build_config.csv"
$strConfigFile = "C:\work\powerShell�e�X�g\Build_config.csv"

#�n�b�V���ϐ��̒�`
$hash = @{}

#�t�@�C���̑��݂��m�F����
if((Test-Path $strConfigFile) -eq $false){
    write-host("�G���[: config�t�@�C����������܂���: " + $strConfigFile)
    exit 2
}

#config�t�@�C����ǂݍ���Ńn�b�V���ɕϊ�����
Import-Csv $strConfigFile -Header "col1","col2" -Encoding Default | ForEach-Object { $hash.add($_.col1,$_.col2) }

return $hash
}
