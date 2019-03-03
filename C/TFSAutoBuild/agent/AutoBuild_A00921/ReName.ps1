#Script-Name�FReName.ps1
#
#����1�F�o�[�W�����ԍ��iyymmdd_300nnn�j
#
#�T�v�F����1�œn���ꂽ�o�[�W�����ԍ��̃t�H���_��(Debug)��t�����ă��l�[������
#


#�����𕶎���ɕϊ�
#�o�[�W�����ԍ��iyymmdd_300nnn�j
$strVerNo = $Args[0] -as [string]

$strReName1 = "C:\BuildLog\${strVerNo}"
$strReName2 = "C:\BuildSource\${strVerNo}"
$strReName3 = "C:\InstallImage\${strVerNo}_RTB"

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
    Rename-Item $strReName1 -NewName "${strVerNo}(Debug)" -ErrorAction Stop
    Rename-Item $strReName2 -NewName "${strVerNo}(Debug)" -ErrorAction Stop
    Rename-Item $strReName3 -NewName "${strVerNo}(Debug)" -ErrorAction Stop
} catch  {
    Write-Host "���l�[�����s!"
    exit 9
}

Write-Host "���l�[�������I"
exit 0