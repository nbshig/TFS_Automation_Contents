#���\�[�X�̈��k�A�ړ�����
#
#�����P�F�o�[�W�����ԍ��iyymmdd_300nnn)
#
#
#�r���h�����e���C�u�������\�[�X�����k���āA�z�z��֊i�[����B
#

#�����𕶎���ɕϊ�
#�o�[�W�����ԍ�
$strVerNo = $Args[0] -as [string]


#
#���\�[�X�̈��k(InstallImage)/�ړ�
#


#���k/�R�s�[���t�H���_(x64)
$strComp��_x64Dir = "C:\InstallImage\${strVerNo}_RTB(x64)\"

#���\�[�X�̈��k(x64)�@
Compress-Archive -path $strComp��_x64Dir -DestinationPath "${strVerNo}_RTB(x64).zip"


#���k/�R�s�[���t�H���_(Debug)
$strComp��_DebugDir = "C:\InstallImage\${strVerNo}_RTB(Debug)\"

#���\�[�X�̈��k(Debug)�@
Compress-Archive -path $strComp��_DebugDir -DestinationPath "${strVerNo}_RTB(Debug).zip"


#���\�[�X�̈ړ�

#(1) �o�b�`�Ǘ��T�[�o�[
$str�R�s�[��Dir = "\\H031S3274\Release"

#net use�ڑ�
net use Z: $str�R�s�[��Dir

#InstallImage(x64)�ɂ��ăR�s�[����
Copy-Item .\"${strVerNo}_RTB(x64).zip" $str�R�s�[��Dir

#net use�ؒf
net use z: /delete /y


#(2) Sharedocs
$str�R�s�[��Dir = "\\128.250.131.145\ShareDocs\30_�^�p\50_���\�[�X�Ǘ�\11_IT\01_���C�u����\02_InstallImage"

#net use�ڑ�
net use Z: $str�R�s�[��Dir

#InstallImage(x64),(Debug)�ɂ��Ĉړ�����
Move-Item .\"*.zip" $str�R�s�[��Dir

#net use�ؒf
net use z: /delete /y





#
#���\�[�X�̈��k(BuildSource)/�ړ�
#


#���k/�R�s�[���t�H���_(x64)
$strComp��_x64Dir = "C:\BuildSource\${strVerNo}(x64)\"

#���\�[�X�̈��k(x64)�@
Compress-Archive -path $strComp��_x64Dir -DestinationPath "${strVerNo}(x64).zip"


#���k/�R�s�[���t�H���_(Debug)
$strComp��_DebugDir = "C:\BuildSource\${strVerNo}(Debug)\"

#���\�[�X�̈��k(Debug)�@
Compress-Archive -path $strComp��_DebugDir -DestinationPath "${strVerNo}(Debug).zip"


#���\�[�X�̈ړ�
$str�R�s�[��Dir = "\\128.250.131.145\ShareDocs\30_�^�p\50_���\�[�X�Ǘ�\11_IT\01_���C�u����\01_Source"
#net use�ڑ�
net use Z: $str�R�s�[��Dir

#�����œn���ꂽ���|�W�g���p�X�̃��\�[�X���}�[�W�p�t�H���_�ɃR�s�[����
Move-Item .\"*.zip" $str�R�s�[��Dir

#net use�ؒf
net use z: /delete /y


Write-Host "���\�[�X�̈��k�A�ړ������I"
exit 0
