#���l�[������
#
#�����P�F���l�[���O�p�X��
#�����Q�F���l�[����p�X��
#
#ReName_Kick.bat �ł́A�����̃p�X����""�ň͂ނ悤�ɂ��Ă��������B
#


#�����𕶎���ɕϊ�
#���l�[�����t�H���_
$strOldFolder = $Args[0] -as [string]
#���l�[����t�H���_
$strNewFolder = $Args[1] -as [string]

#���l�[���J�n
Write-Host "���l�[���O�F$strOldFolder"
Write-Host "���l�[����F$strNewFolder"

Write-Host "���l�[���J�n"

try {
    Rename-Item $strOldFolder -NewName $strNewFolder -ErrorAction Stop
} catch  {
    Write-Host "���l�[�����s!"
    exit 9
}

Write-Host "���l�[�������I"

exit 0
