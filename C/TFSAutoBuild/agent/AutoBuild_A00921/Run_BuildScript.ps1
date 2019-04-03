#Script-Name�FRun_BuildScript.ps1
#
#����1 : �\�����[�V�����\��No(1(x64) or 4(Debug)) 
#
#�T�v�FBuildScript_�J��_�r���h�������p.bat�����s����
#�@�@�@(�p�����[�^�̋��ʉ���}��ׂ�Build_config.csv��ǂݍ��ނׂ�PowerShell����̌Ăяo���Ƃ���)
#

Write-Host "Run_BuildScript.ps1 �J�n"

#�ϐ���`
$strBuildVerNo_Value = ""
$strBuildScriptPath_Value = ""

#�����𕶎���ɕϊ�
$strSolConfigNo = $Args[0] -as [string]

#�n�b�V���ϐ��̒�`
$hash = @{}


#-- ���ʃ��W���[�����[�h
. "C:\TFSAutoBuild\agent\AutoBuild_A00921\Include.ps1"
#config�t�@�C���̓ǂݍ���
$hash = Import_CSV

#�L�[�ƁA�΂���l�̊m�F
if ($hash["BuildVerNo"] -ne $null) {
    $strBuildVerNo_Value = $hash["BuildVerNo"].ToString()
} else {
    #�L�[�Ƒ΂ɂȂ�ׂ��l�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: �L�[�Ƒ΂ɂȂ�l��config�t�@�C����ɒ�`����Ă��܂���B�L�[�� BuildVerNo")
    Exit 2
}

if ($hash["BuildScriptPath"] -ne $null) {
    $strBuildScriptPath_Value = $hash["BuildScriptPath"].ToString()
} else {
    #�����̃L�[�Ƒ΂ɂȂ�ׂ��l�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: �����œn�����L�[�Ƒ΂ɂȂ�l��config�t�@�C����ɒ�`����Ă��܂���B�L�[�� BuildScriptPath")
    Exit 2
}

#
#BuildScript_�J��_�r���h�������p.bat�̎��s
#

if ( Test-Path "${strBuildScriptPath_Value}BuildScript_�J��_�r���h�������p.bat" ) {
    $p = Start-Process "${strBuildScriptPath_Value}BuildScript_�J��_�r���h�������p.bat" -ArgumentList $strBuildVerNo_Value,$strSolConfigNo -PassThru -Wait

    if ( $p.ExitCode -ne 0 ) {
        Write-Host "�G���[�FBuildScript_�J��_�r���h�������p.bat�ňُ�I�������F" $p.ExitCode
        exit $p.ExitCode
    }
} else {
    write-host("�G���[: �p�X�̌�肪����܂��B�p�X�� " + "${strBuildScriptPath_Value}BuildScript_�J��_�r���h�������p.bat")
    Exit 2
} 

Write-Host "Run_BuildScript.ps1���I�����܂���"
exit 0