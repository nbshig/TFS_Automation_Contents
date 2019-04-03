#Script-Name�FLogCheck.ps1
#
#����1�F�\�����[�V�����\��No(1:x64 or 4:Debug) 
#
#�T�v�F�r���h���s��̃��O�t�@�C���ɂ��ă`�F�b�N����
#

#�ϐ���`
$strBuildVerNo_Value = ""
$strBuildLogPath_Value = ""

#�n�b�V���ϐ��̒�`
$hash = @{}
$hash_LogList = @{}

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

if ($hash["BuildLogPath"] -ne $null) {
    $strBuildLogPath_Value = $hash["BuildLogPath"].ToString()
} else {
    #�����̃L�[�Ƒ΂ɂȂ�ׂ��l�����݂��Ȃ����߁A�ُ�I���Ƃ���B
    write-host("�G���[: �����œn�����L�[�Ƒ΂ɂȂ�l��config�t�@�C����ɒ�`����Ă��܂���B�L�[�� BuildLogPath")
    Exit 2
}



#�����𕶎���ɕϊ�

#X64 or Debug
$strSolConfigNo = $Args[0] -as [string]
if ($strSolConfigNo -eq "1") {
    #X64�̂Ƃ�
    $strSolConfigNo = "(x64)"
} else {
    #Debug�̂Ƃ��i�������͉��������Ă��Ȃ����A�������̕����񂪓����Ă���Ƃ��j
    $strSolConfigNo = ""
}


# �����Ώۂ̃t�H���_
$targetFolder = "${strBuildLogPath_Value}${strBuildVerNo_Value}${strSolConfigNo}"

if ((Test-Path $targetFolder) -ne $true) {
    write-host("�G���[: ���O�m�F�Ώۃt�H���_��������܂���: " + $targetFolder)
    exit 2
}

# $targetFolder���̃t�@�C���E�t�H���_�̃��X�g���擾����B
$itemList = Get-ChildItem $targetFolder;

$itemList | ForEach-Object { $hash_LogList.add($_.Name,$_.value) }

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
                $hash_LogList[$item.Name] = $true
                break
            }
        }
            if ( $hash_LogList[$item.Name] -ne $true ) {
                #���O�t�@�C����ɐ���I�����O�𔭌��ł��Ȃ�����
                $hash_LogList[$item.Name.tostring()] = $false
            }
    }
} 

if ( $hash_LogList.ContainsValue($false) ) {
    #FALSE�����݂���ꍇ�A����I�����O�𔭌��o���Ȃ������Ƃ������ŁAexit 3��Ԃ�
    Write-Host "�ُ�I�����������O�t�@�C�������݂��܂��B�m�F���Ă��������B"
    exit 3
}

Write-Host "���O�`�F�b�N�I��"
exit 0