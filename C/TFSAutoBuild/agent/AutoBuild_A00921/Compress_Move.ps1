#Script-Name�FCompress_Move.ps1
#
#����1�F�o�[�W�����ԍ��iyymmdd_300nnn)
#
#
#�T�v�F�r���h�����e���C�u�������\�[�X�����k���āA�z�z��֊i�[����B
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



#
#���\�[�X�̈��k(InstallImage)
#

Write-Host "InstallImage�̈��k �J�n"

#���k/�R�s�[���t�H���_(x64)
if ((Test-Path "C:\InstallImage\${strBuildVerNo_Value}_RTB(x64)") -ne $true) {
    write-host("�G���[: ���k/�R�s�[���t�H���_(InstallImage - x64)��������܂���: " + "C:\InstallImage\${strBuildVerNo_Value}_RTB(x64)")
    exit 2
}

$strComp��_x64Dir = "C:\InstallImage\${strBuildVerNo_Value}_RTB(x64)\"

#���\�[�X�̈��k(x64)�@
try {
    Write-Host  "C:\InstallImage\${strBuildVerNo_Value}_RTB(x64)  ���k�J�n"
    Compress-Archive -path $strComp��_x64Dir -DestinationPath "${strBuildVerNo_Value}_RTB(x64).zip" -ErrorAction stop
    Write-Host  "C:\InstallImage\${strBuildVerNo_Value}_RTB(x64)  ���k�I��"
} catch {
    Write-Host "���\�[�X�̈��k(InstallImage - x64)�@���s!"
    exit 9
}

#���k/�R�s�[���t�H���_(Debug)
if ((Test-Path "C:\InstallImage\${strBuildVerNo_Value}_RTB(Debug)") -ne $true) {
    write-host("�G���[: ���k/�R�s�[���t�H���_(InstallImage - Debug)��������܂���: " + "C:\InstallImage\${strBuildVerNo_Value}_RTB(Debug)")
    exit 2
}
$strComp��_DebugDir = "C:\InstallImage\${strBuildVerNo_Value}_RTB(Debug)\"

#���\�[�X�̈��k(Debug)
try {
    Write-Host  "C:\InstallImage\${strBuildVerNo_Value}_RTB(Debug)  ���k�J�n"
    Compress-Archive -path $strComp��_DebugDir -DestinationPath "${strBuildVerNo_Value}_RTB(Debug).zip" -ErrorAction stop
    Write-Host  "C:\InstallImage\${strBuildVerNo_Value}_RTB(Debug)  ���k�I��"
} catch {
    Write-Host "���\�[�X�̈��k(InstallImage - Debug)�@���s!"
    exit 9
}

Write-Host "InstallImage�̈��k �I��"

#
#���\�[�X�̈ړ�(InstallImage)
#

Write-Host "InstallImage�̈ړ� �J�n"

#(1) �o�b�`�Ǘ��T�[�o�[
$str�R�s�[��Dir = "\\H031S3274\Release"

#net use�ڑ�
net use Z: $str�R�s�[��Dir

#InstallImage(x64)�ɂ��āA�o�b�`�Ǘ��T�[�o�[�փR�s�[����
try {
    Copy-Item .\"${strBuildVerNo_Value}_RTB(x64).zip" $str�R�s�[��Dir -ErrorAction stop
} catch {
    Write-Host "�o�b�`�Ǘ��T�[�o�[�ւ̃R�s�[�@���s!(InstallImage)"
    exit 9
}

#net use�ؒf
net use z: /delete /y
$str�R�s�[��Dir = $null


#(2) Sharedocs
$str�R�s�[��Dir = "\\128.250.131.145\ShareDocs\30_�^�p\50_���\�[�X�Ǘ�\11_IT\01_���C�u����\02_InstallImage"

#net use�ڑ�
net use Z: $str�R�s�[��Dir

#InstallImage(x64),(Debug)�ɂ��Ĉړ�����
try {
    Move-Item .\"*.zip" $str�R�s�[��Dir -ErrorAction stop
} catch {
    Write-Host "Sharedocs�ւ̈ړ��@���s!(InstallImage)"
    exit 9
}


#net use�ؒf
net use z: /delete /y

$strComp��_x64Dir = $null
$strComp��_DebugDir = $null
$str�R�s�[��Dir = $null

Write-Host "InstallImage�̈ړ� �I��"



#
#���\�[�X�̈��k(BuildSource)
#
Write-Host "BuildSource�̈��k �J�n"

#���k/�R�s�[���t�H���_(x64)
if ((Test-Path "C:\BuildSource\${strBuildVerNo_Value}(x64)") -ne $true) {
    write-host("�G���[: ���k/�R�s�[���t�H���_(BuildSource - x64)��������܂���: " + "C:\BuildSource\${strBuildVerNo_Value}(x64)")
    exit 2
}
$strComp��_x64Dir = "C:\BuildSource\${strBuildVerNo_Value}(x64)\"

#���\�[�X�̈��k(x64)
try {
    Write-Host  "C:\BuildSource\${strBuildVerNo_Value}(x64)  ���k�J�n"
    Compress-Archive -path $strComp��_x64Dir -DestinationPath "${strBuildVerNo_Value}(x64).zip" -ErrorAction stop
    Write-Host  "C:\BuildSource\${strBuildVerNo_Value}(x64)  ���k�I��"
} catch {
    Write-Host "���\�[�X�̈��k(BuildSource - x64)�@���s!"
    exit 9
}


#���k/�R�s�[���t�H���_(Debug)
if ((Test-Path "C:\BuildSource\${strBuildVerNo_Value}(Debug)") -ne $true) {
    write-host("�G���[: ���k/�R�s�[���t�H���_(BuildSource - Debug)��������܂���: " + "C:\BuildSource\${strBuildVerNo_Value}(Debug)")
    exit 2
}
$strComp��_DebugDir = "C:\BuildSource\${strBuildVerNo_Value}(Debug)\"

#���\�[�X�̈��k(Debug)�@
try {
    Write-Host  "C:\BuildSource\${strBuildVerNo_Value}(Debug)  ���k�J�n"
    Compress-Archive -path $strComp��_DebugDir -DestinationPath "${strBuildVerNo_Value}(Debug).zip" -ErrorAction stop
    Write-Host  "C:\BuildSource\${strBuildVerNo_Value}(Debug)  ���k�I��"
} catch {
    Write-Host "���\�[�X�̈��k(BuildSource - Debug)�@���s!"
    exit 9
}

Write-Host "BuildSource�̈��k �I��"


#
#���\�[�X�̈ړ�(BuildSource)
#
Write-Host "BuildSource�̈ړ� �J�n"

$str�R�s�[��Dir = "\\128.250.131.145\ShareDocs\30_�^�p\50_���\�[�X�Ǘ�\11_IT\01_���C�u����\01_Source"
#net use�ڑ�
net use Z: $str�R�s�[��Dir

#�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
Move-Item .\"*.zip" $str�R�s�[��Dir

#BuildSource(x64),(Debug)�ɂ��Ĉړ�����
try {
    Move-Item .\"*.zip" $str�R�s�[��Dir -ErrorAction stop
} catch {
    Write-Host "Sharedocs�ւ̈ړ��@���s!(BuildSource)"
    exit 9
}


#net use�ؒf
net use z: /delete /y

$strComp��_x64Dir = $null
$strComp��_DebugDir = $null
$str�R�s�[��Dir = $null

Write-Host "BuildSource�̈ړ� �I��"


#
#�s�v���C�u�����̍폜
#

#C:\SOLUTION�t�H���_�����݂��Ă���΍폜����
if ( Test-Path "C:\SOLUTION" ) {
    Write-Host "SOLUTION�t�H���_�̍폜 �J�n"

    Remove-Item "C:\SOLUTION" -Force -Recurse

    Write-Host "SOLUTION�t�H���_�̍폜 �I��"
}


Write-Host "���\�[�X�̈��k�A�ړ������I��"
exit 0