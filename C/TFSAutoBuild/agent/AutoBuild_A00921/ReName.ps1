#Script-Name�FReName.ps1
#
#
#
#�T�v�F����1�œn���ꂽ�o�[�W�����ԍ��̃t�H���_��(Debug)��t�����ă��l�[������
#


#�ϐ���`
$strBuildVerNo_Value = ""

#�n�b�V���ϐ��̒�`
$hash = @{}


#-- ���ʃ��W���[�����[�h
. "C:\TFSAutoBuild\agent\AutoBuild_A00921\Included.ps1"
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


$strReName1 = "C:\BuildLog\${strBuildVerNo_Value}"
$strReName2 = "C:\BuildSource\${strBuildVerNo_Value}"
$strReName3 = "C:\InstallImage\${strBuildVerNo_Value}_RTB"

#���l�[���J�n
Write-Host "�ȉ��̒ʂ胊�l�[������"
Write-Host "���l�[��1 �O�F$strReName1"
Write-Host "���l�[��1 ��F$strReName1(Debug)"

Write-Host "���l�[��2 �O�F$strReName2"
Write-Host "���l�[��2 ��F$strReName2(Debug)"

Write-Host "���l�[��3 �O�F$strReName3"
Write-Host "���l�[��3 ��F$strReName3(Debug)"

Write-Host "���l�[���J�n"

try {
    Rename-Item $strReName1 -NewName "${strBuildVerNo_Value}(Debug)" -ErrorAction Stop
    Rename-Item $strReName2 -NewName "${strBuildVerNo_Value}(Debug)" -ErrorAction Stop
    Rename-Item $strReName3 -NewName "${strBuildVerNo_Value}(Debug)" -ErrorAction Stop
} catch  {
    Write-Host "���l�[�����s!"
    exit 9
}

Write-Host "���l�[�������I"
exit 0