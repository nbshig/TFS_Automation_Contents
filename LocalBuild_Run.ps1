#�r���h���s�iLocal�p�j��������
#
#�����P�F�o�[�W�����ԍ��iyymmdd_300nnn)
#
#
#�r���h���s�ix64�j��ɁA���[�J���p���C�u�������r���h����ׂ̏�������
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

Copy-Item $strOldFolder $strNewFolder -Force -Recurse 



#
#�œK���I�v�V�����c�[��_�߂��p�c�[���̎��{
#

#�s�v�t�@�C���̍폜
$str�œK���߂�Dir = "C:\�œK���I�v�V�����c�[��_�߂��p"

$strArray = @("00_proj","10_�œK��","�ϊ��O")
foreach($item in $strArray) {

    $strTmpPath = Join-Path $str�œK���߂�Dir $item

    if ( test-path "$strTmpPath\*" ) {
        Write-Host "$strTmpPath �̒��g���폜���܂��B"
        Remove-Item "$strTmpPath\*" -Recurse -Force
    }
}

#
#�œK���I�v�V�����c�[��_�߂��p�c�[�����s
#

#�v���W�F�N�g�t�@�C���R�s�[.bat
$p = Start-Process "C:\work\powerShell�e�X�g\test.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "�v���W�F�N�g�t�@�C���R�s�[.bat�ňُ�I�������F" $p.ExitCode
    exit $p.ExitCode
}


#�œK���̒ǉ�.bat
$p = Start-Process "C:\work\powerShell�e�X�g\test.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "�œK���̒ǉ�.bat�ňُ�I�������F" $p.ExitCode
    exit $p.ExitCode
}


#�v���W�F�N�g�t�@�C���R�s�[_�œK����.bat
$p = Start-Process "C:\work\powerShell�e�X�g\test.bat" -PassThru -Wait

if ( $p.ExitCode -ne 0 ) {
    Write-Host "�v���W�F�N�g�t�@�C���R�s�[_�œK����.bat�ňُ�I�������F" $p.ExitCode
    exit $p.ExitCode
}

Write-Host "�r���h���s�iLocal�p�j�����������������܂����I"
exit 0
