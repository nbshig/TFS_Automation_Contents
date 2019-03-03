#Script-Name�FPrepare_LocalBuild.ps1
#
#����1�F�o�[�W�����ԍ��iyymmdd_30xnnn�j
#
#�T�v�F�r���h���s�ix64�j��ɁA���[�J���p���C�u�������r���h����ׂ̏������s��
#


#�����𕶎���ɕϊ�
#�o�[�W�����ԍ�
$strVerNo = $Args[0] -as [string]

#
#SOLUTION�t�H���_�쐬
#
#�ȉ��̃t�H���_���R�s�[���āAC:\�����ɓ\��t����B
#C:\BuildSource\yymmdd_300nnn(x64)\Source
#�\��t�����t�H���_���uSOLUTION�v(���p�啶���j�Ƀ��l�[������B

#�R�s�[���t�H���_
$strOldFolder = "C:\BuildSource\${strVerNo}(x64)\Source"
#�R�s�[��t�H���_
$strNewFolder = "C:\SOLUTION"

if ((test-path $strOldFolder) -ne $true) {
    #�R�s�[���t�@�C�������݂��Ȃ��ꍇ�ُ͈�I���Ƃ���B
    write-host("�G���[: �R�s�[���t�H���_�����݂��܂���: " + $strOldFolder)
    exit 2
}

if (test-path $strNewFolder) {
    #�{���A�R�s�[��t�H���_�iSOLUTION�j�����݂��Ă��Ă͂����Ȃ��̂ňُ�I���Ƃ���B
    write-host("�G���[: SOLUTION�t�H���_�����݂��Ă��܂��B")
    Exit 2
} else {
    #���\�[�X�̃R�s�[�i"SOLUTION"�Ń��l�[���j
    Copy-Item $strOldFolder $strNewFolder -Force -Recurse 
}

#
#�œK���I�v�V�����c�[��_�߂��p�c�[���̎��{
#

#�s�v�t�@�C���̍폜
$str�œK���߂�Dir = "C:\�œK���I�v�V�����c�[��_�߂��p"

$strArray = @("00_proj","10_�œK��","�ϊ��O")
foreach($item in $strArray) {

    $strTmpPath = Join-Path $str�œK���߂�Dir $item

    if ( test-path "$strTmpPath\*" ) {
        Write-Host "$strTmpPath �̒��g����B"
        Write-Host "$strTmpPath �̒��g���폜���܂��B"
        Remove-Item "$strTmpPath\*" -Recurse -Force
    }
}

#
#�œK���I�v�V�����c�[��_�߂��p�c�[�����s
#

#�v���W�F�N�g�t�@�C���R�s�[.bat
$p = Start-Process "$str�œK���߂�Dir\�v���W�F�N�g�t�@�C���R�s�[_�r���h�������p.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "�G���[�F�v���W�F�N�g�t�@�C���R�s�[_�r���h�������p.bat�ňُ�I�������F" $p.ExitCode
    exit $p.ExitCode
}



#�œK���̒ǉ�.bat
$p = Start-Process "$str�œK���߂�Dir\�œK���̒ǉ�_�r���h�������p.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "�œK���̒ǉ�_�r���h�������p.bat�ňُ�I�������F" $p.ExitCode
    exit $p.ExitCode
}


#�v���W�F�N�g�t�@�C���R�s�[_�œK����.bat
$p = Start-Process "$str�œK���߂�Dir\�v���W�F�N�g�t�@�C���R�s�[_�œK����_�r���h�������p.bat" -ArgumentList "ALL" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "�v���W�F�N�g�t�@�C���R�s�[_�œK����.bat�ňُ�I�������F" $p.ExitCode
    exit $p.ExitCode
}

Write-Host "�r���h���s�iLocal�p�j�����������I�����܂���"
exit 0