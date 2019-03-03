#Script-Name�FCopy.ps1
#
#����1�F���|�W�g����
#
#�T�v�F�����œn���ꂽ���|�W�g�������A�Ώۃ��|�W�g���̃��\�[�X���}�[�W�t�H���_�փR�s�[����
#


#�ϐ���`
$strConfigFile = "C:\TFSAutoBuild\agent\AutoBuild_A00921\Build_config.csv"
$strAllResorce = "*"
$tf = '$tf'
$SVF_Image = "SVF\Images\"

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
    write-host("�G���[: config�t�@�C����������܂���: " + $strConfigFile)
    exit 2
}    
#Read-Host "������ɂ�ENTER�L�[�������ĉ�����" 
#config�t�@�C����ǂݍ���Ńn�b�V���ɕϊ�����
Import-Csv $strConfigFile -Encoding Default | ForEach-Object { $hash.add($_.Key,$_.Value) }

#�����œn���ꂽ���|�W�g���p�X�̏���
if ($hash[$strRepo] -ne $null) {
    $str���|�W�g���p�X = $hash[$strRepo].ToString()
} else {
    #���|�W�g�����Ƒ΂ɂȂ�ׂ����|�W�g���p�X�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: �����œn�������|�W�g�����Ƒ΂ɂȂ郊�|�W�g���p�X��config�t�@�C����ɒ�`����Ă��܂���B���|�W�g������ " + $strRepo)
    Exit 2
}

#�}�[�W�t�H���_�p�X�̏���
if ($hash["SOLUTION"] -ne $null) {
    $str�}�[�W�p�X = $hash["SOLUTION"].ToString()
} else {
    #���|�W�g�����Ƒ΂ɂȂ�ׂ����|�W�g���p�X�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: ���|�W�g�����Ƒ΂ɂȂ郊�|�W�g���p�X��config�t�@�C����ɒ�`����Ă��܂���B���|�W�g������ SOLUTION")
    Exit 2
}


############################
#���\�[�X�̃R�s�[
############################

if ("000" -eq $strRepo) {
    #"000"���|�W�g���̏ꍇ

    #"000"����ԍŏ��ɃR�s�[���郊�|�W�g���ɂȂ�̂ŁASOLUTION�t�H���_�����
    #(COPY-ITEM �ł������I�ɍ�邱�Ƃ��ł��邪�A�R�s�[��t�H���_(SOLUTION)�̗L���ŃR�s�[���̃t�H���_�܂�ŃR�s�[���邩�ۂ��������ς���Ă��܂��̂ŁA
    # �ŏ�����R�s�[��t�H���_(SOLUTION)����鎖�Ƃ���B)
    if (test-path "C:\SOLUTION") {
        #�{���ASOLUTION�t�H���_�����݂��Ă��Ă͂����Ȃ��̂ňُ�I���Ƃ���B
        write-host("�G���[: SOLUTION�t�H���_�����݂��Ă��܂��B")
        Exit 2
    } else {
        #SOLUTION�t�H���_�̍쐬
        New-Item C:\SOLUTION -ItemType Directory
    }

    #�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
    Copy-Item ${str���|�W�g���p�X}${strAllResorce} $str�}�[�W�p�X -Force -Recurse 

    #�R�s�[��t�H���_(SOLUTION)�ɕs�v�ȃT�u�t�H���_($tf)���R�s�[���Ă���̂ŁA�폜����
    if ( Test-Path ${str�}�[�W�p�X}$tf ) {
        Remove-Item  ${str�}�[�W�p�X}$tf -Force -Recurse
    }

    #�R�s�[��t�H���_(SOLUTION)�ɕs�v�ȃT�u�t�H���_���R�s�[���Ă���̂ŁA�폜����i�Ȃ���Images�t�H���_��TFS����_�E�����[�h�����B�\����Ȃ��̂ɁB�B�j
    if ( Test-Path C:\SOLUTION\SVF\Images ) {
        Remove-Item  C:\SOLUTION\SVF\Images -Force -Recurse
    }

    #000�t�H���_�̃��\�[�X���폜����
    Remove-Item  ${str���|�W�g���p�X}${strAllResorce} -Force -Recurse

} elseif ("100","300" -contains $strRepo) {
    #"100","300"���|�W�g���̏ꍇ

    #�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
    Copy-Item ${str���|�W�g���p�X}${strAllResorce} $str�}�[�W�p�X -Force -Recurse 
    #Copy-Item ${str���|�W�g���p�X} $str�}�[�W�p�X -Force -Recurse 

    #�R�s�[��t�H���_(SOLUTION)�ɕs�v�ȃT�u�t�H���_($tf)���R�s�[���Ă���̂ŁA�폜����
    if ( Test-Path ${str�}�[�W�p�X}$tf ) {
        Remove-Item  ${str�}�[�W�p�X}$tf -Force -Recurse
    }

    #�R�s�[��t�H���_(SOLUTION)�ɕs�v�ȃT�u�t�H���_���R�s�[���Ă���̂ŁA�폜����i�Ȃ���Images�t�H���_��TFS����_�E�����[�h�����B�\����Ȃ��̂ɁB�B�j
    if ( Test-Path C:\SOLUTION\SVF\Images ) {
        Remove-Item  C:\SOLUTION\SVF\Images -Force -Recurse
    }

    ############################
    #�����œn���ꂽ���|�W�g���̍폜
    ############################

    #Write-Host ${str���|�W�g���p�X}${strAllResorce}
    #pause
    #100,300�t�H���_�̃��\�[�X���폜����
    Remove-Item  ${str���|�W�g���p�X}${strAllResorce} -Force -Recurse 
    #Remove-Item  ${str���|�W�g���p�X} -Force -Recurse 


} elseif ("Images" -eq $strRepo) {
    #"Images"���|�W�g���̏ꍇ

    #Image�t�H���_���}�[�W�p�t�H���_�ɃR�s�[����
    Copy-Item ${str���|�W�g���p�X} ${str�}�[�W�p�X}${SVF_Image} -Force -Recurse


} else {
    #��L�ȊO�̃��|�W�g���̏ꍇ�i�Č��t�H���_�Ȃǁj
    #Write-Host "�Č��t�H���_�̏ꍇ"
    #pause

    #net use�ڑ�
    net use Z: \\128.250.131.145\ShareDocs

    #�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
    Copy-Item ${str���|�W�g���p�X}${strAllResorce} $str�}�[�W�p�X -Force -Recurse
    #Copy-Item ${str���|�W�g���p�X} $str�}�[�W�p�X -Force -Recurse 

    #net use�ؒf
    net use z: /delete /y
}




