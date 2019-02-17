############################
#
#�����œn���ꂽ���|�W�g���̃��\�[�X���}�[�W�t�H���_�փR�s�[����
#
############################

#�ϐ���`
$strConfigFile = "C:\work\powerShell�e�X�g\Build_config.csv"
$strAllResorce = "*"

#�����𕶎���ɕϊ�
$strRepo = $Args[0] -as [string]
#Write-Host $strRepo
############################
#config�t�@�C���̓ǂݍ���
############################

#�n�b�V���ϐ��̒�`
$hash = @{}


#�t�@�C���̑��݂��m�F����
if((Test-Path $strConfigFile) -eq $false){
    write-host("ERROR: Not found configFile: " + $strConfigFile)
    exit 9
}    

#config�t�@�C����ǂݍ���Ńn�b�V���ɕϊ�����
Import-Csv $strConfigFile -Encoding Default | ForEach-Object { $hash.add($_.���|�W�g��,$_.�p�X) }

#�����œn���ꂽ���|�W�g���p�X�̏���
$str���|�W�g���p�X = $hash[$strRepo].ToString()
#Write-Host $str���|�W�g���p�X

#�}�[�W�t�H���_�p�X�̏���
$str�}�[�W�p�X = $hash["�}�[�W"].ToString()
#Write-Host $str�}�[�W�p�X

############################
#���\�[�X�̃R�s�[
############################

if ("000","100","300" -contains $strRepo) {
    #"000","100","300"���|�W�g���̏ꍇ
    #Write-Host '"000","100","300"���|�W�g���̏ꍇ'
    #pause
    #�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
    Copy-Item ${str���|�W�g���p�X}${strAllResorce} $str�}�[�W�p�X -Force -Recurse 

    ############################
    #�����œn���ꂽ���|�W�g���̍폜
    ############################

    #Write-Host ${str���|�W�g���p�X}${strAllResorce}
    #pause
    #000�t�H���_�̃��\�[�X���폜����
    Remove-Item  ${str���|�W�g���p�X}${strAllResorce} -Force -Recurse 

} else {
    #��L�ȊO�̃��|�W�g���̏ꍇ�i�Č��t�H���_�Ȃǁj
    #Write-Host "�Č��t�H���_�̏ꍇ"
    #pause

    #net use�ڑ�
    net use Z: \\192.168.11.7\C$

    #�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
    Copy-Item ${str���|�W�g���p�X}${strAllResorce} $str�}�[�W�p�X -Force -Recurse 
    #pause

    #net use�ؒf
    net use Z: /delete
}




