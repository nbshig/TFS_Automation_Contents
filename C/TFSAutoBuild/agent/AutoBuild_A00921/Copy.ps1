#Script-Name�FCopy.ps1
#
#����1�F���|�W�g����
#
#�T�v�F�����œn���ꂽ���|�W�g�������A�Ώۃ��|�W�g���̃p�X��I�肵�āA�Y�����\�[�X���}�[�W�t�H���_�փR�s�[����
#


#�ϐ���`
$strAllResorce = "*"
$tf = '$tf'
$SVF_Image = "SVF\Images\"

#�����𕶎���ɕϊ�
$strRepo = $Args[0] -as [string]

#�n�b�V���ϐ��̒�`
$hash = @{}


#-- ���ʃ��W���[�����[�h
. "C:\TFSAutoBuild\agent\AutoBuild_A00921\Included.ps1"
#config�t�@�C���̓ǂݍ���
$hash = Import_CSV


#�����œn���ꂽ�L�[�ƁA�΂���l�̊m�F
if ($hash[$strRepo] -ne $null) {
    $str���|�W�g���p�X = $hash[$strRepo].ToString()
} else {
    #�����̃L�[�Ƒ΂ɂȂ�ׂ��l�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: �����œn�����L�[�Ƒ΂ɂȂ�l��config�t�@�C����ɒ�`����Ă��܂���B�L�[�� " + $strRepo)
    Exit 2
}

##�����œn���ꂽ�L�[�ƁA�΂���l�̊m�F�i�}�[�W�t�H���_�p�X�̏����j
if ($hash["SOLUTION"] -ne $null) {
    $str�}�[�W�p�X = $hash["SOLUTION"].ToString()
} else {
    #�����̃L�[�Ƒ΂ɂȂ�ׂ��l�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: �����œn�����L�[�Ƒ΂ɂȂ�l��config�t�@�C����ɒ�`����Ă��܂���B�L�[�� SOLUTION")
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




