#Script-Name�FLogCheck.ps1
#
#����1�F�o�[�W�����ԍ��iyymmdd_30xnnn�j
#����2�F�r���h�o�[�W�����ix64 or Debug�j
#
#�T�v�F�r���h���s��̃��O�t�@�C���ɂ��ă`�F�b�N����
#

#�ϐ���`
$strBuildLogDir = "C:\BuildLog\"

#�n�b�V���ϐ��̒�`
$hash = @{}


#�����𕶎���ɕϊ�

 #���O�t�H���_��
$strBuildLogFolderName = $Args[0] -as [string]
#X64 or Debug
$strBuildLogVer = $Args[1] -as [string]
if ($strBuildLogVer = "x64") {
    #X64�̂Ƃ�
    $strBuildLogVer = "(${strBuildLogVer})"
} else {
    #Debug�̂Ƃ��i�������͉��������Ă��Ȃ����A�������̕����񂪓����Ă���Ƃ��j
    $strBuildLogVer = ""
}


# �����Ώۂ̃t�H���_
$targetFolder = "${strBuildLogDir}${strBuildLogFolderName}${strBuildLogVer}"

if ((Test-Path $targetFolder) -ne $true) {
    write-host("�G���[: ���O�m�F�Ώۃt�H���_��������܂���: " + $targetFolder)
    exit 2
}

# $targetFolder���̃t�@�C���E�t�H���_�̃��X�g���擾����B
$itemList = Get-ChildItem $targetFolder;

$itemList | ForEach-Object { $hash.add($_.Name,$_.value) }

foreach($item in $itemList) {
    if($item.PSIsContainer) {
        # �t�H���_�̏ꍇ�́A�z��O�B�����Ȃ�
    } else {
        # �t�@�C���̏ꍇ�̏���
        Write-Host ($item.Name + "���`�F�b�N�J�n")
        #�Ōォ��20�s���擾
        $arr_str�s = Get-Content ( join-path ${targetFolder} $item.Name.tostring() ) -Encoding string | Select-Object -last 20

        foreach ($i in $arr_str�s) {

            #if ($i -match "^(?=.*\d)(?!.*20).*$") {�@�����K�\���̂��׋��i1�s�̒��ɐ��l������A���A20�ȊO�̐��l�ł���P�[�X�j
            if ($i -match ("0 ���s|�v���R���p�C�������I��|�r���h�X�N���v�g��������I��")) {
                Write-Host ($item.Name + "�́A����I��")
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
    #FALSE�����݂���ꍇ�A����I�����O�𔭌��o���Ȃ������Ƃ������ŁAexit 3��Ԃ�
    Write-Host "�ُ�I�����������O�t�@�C�������݂��܂��B�m�F���Ă��������B"
    exit 3
}

Write-Host "���O�`�F�b�N�I��"
exit 0