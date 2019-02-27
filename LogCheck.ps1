

#�ϐ���`
$strBuildLogDir = "C:\BuildLog\"

#�n�b�V���ϐ��̒�`
$hash = @{}


#�����𕶎���ɕϊ�

 #���O�t�H���_��
$strBuildLogFolderName = $Args[0] -as [string]
#X64 or Debug
$strBuildLogVer = $Args[1] -as [string]
$strBuildLogVer = "(${strBuildLogVer})"


# �����Ώۂ̃t�H���_
$targetFolder = "${strBuildLogDir}${strBuildLogFolderName}${strBuildLogVer}"
 
# $targetFolder���̃t�@�C���E�t�H���_�̃��X�g���擾����B
$itemList = Get-ChildItem $targetFolder;

$itemList | ForEach-Object { $hash.add($_.Name,$_.value) }

foreach($item in $itemList) {
    if($item.PSIsContainer) {
        # �t�H���_�̏ꍇ�́A�z��O�B�����Ȃ�
    } else {
        # �t�@�C���̏ꍇ�̏���
        Write-Host ($item.Name + "���`�F�b�N�J�n!")
        #�Ōォ��20�s���擾
        $arr_str�s = Get-Content ( join-path ${targetFolder} $item.Name.tostring() ) -Encoding string | Select-Object -last 20

        foreach ($i in $arr_str�s) {
            #Write-Host $i

            #if ($i -match "^(?=.*\d)(?!.*20).*$") {
            #1�s�̒��ɐ��l������A���A20�ȊO�ł��鐔�l�ł���ꍇ
            if ($i -match ("0 ���s|�v���R���p�C�������I��|�r���h�X�N���v�g��������I��")) {
                Write-Host ($item.Name + "�́A����I��!")
                $hash[$item.Name] = $true
                break
            }
        }
            if ( $hash[$item.Name] -ne $true ) {
                #���O�t�@�C����ɐ���I�����O�𔭌��ł��Ȃ�����
                $hash[$item.Name.tostring()] = $false
            }
    }
} 

if ( $hash.ContainsValue($false) ) {
    #FALSE�����݂���ꍇ�A����I�����O�𔭌��o���Ȃ������Ƃ������ŁAexit 1��Ԃ�
    Write-Host "�ُ�I�����������O�t�@�C�������݂��܂��B�m�F���Ă��������B"
    exit 1
}

Write-Host "�ŏI�s�܂œ��B�I"
exit 0
