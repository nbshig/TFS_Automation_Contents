@ECHO OFF
REM ----------------------------------------------------
REM ���W���[�����@�F�v���W�F�N�g�t�@�C���R�s�[_�œK����.bat
REM �@�\�@�@�@�@�@�FC:\�œK���I�v�V�����c�[��\10_�œK��
REM �@�@�@�@�@�@�@�@�t�H���_��vbproj�t�@�C����S��
REM �@�@�@�@�@�@�@�@C:\SOLUTION�t�H���_�ɏ㏑���R�s�[����B�@�@�@�@�@�@�@�@
REM ----------------------------------------------------

REM ----------------------------------------------------
REM �ϐ��Z�b�g
REM ----------------------------------------------------

SET SOLUTION_DIR=C:\SOLUTION
SET SAITEKI_AFTER_DIR=C:\�œK���I�v�V�����c�[��_�߂��p\10_�œK��

REM ----------------------------------------------------
REM �`�F�b�N
REM ----------------------------------------------------

:CHECK_PROC

REM �R�s�[���t�H���_�L���`�F�b�N(������΃G���[)

IF NOT EXIST %SAITEKI_AFTER_DIR% (
@ECHO  ERROR : **%SAITEKI_AFTER_DIR%�����݂��܂���**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 1
REM 19/03/01 CHG End
)

REM �R�s�[�Ώ�VBPROJ�t�@�C���L���`�F�b�N(������΃G���[)

IF NOT EXIST %SAITEKI_AFTER_DIR%\*.vbproj (
@ECHO  ERROR : **�v���W�F�N�g�t�@�C�������݂��܂���**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 2
REM 19/03/01 CHG End
)

REM �R�s�[��t�H���_�L���`�F�b�N(������΃G���[)

IF NOT EXIST %SOLUTION_DIR% (
@ECHO  ERROR : **%SOLUTION_DIR%�t�H���_�����݂��܂���**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 3
REM 19/03/01 CHG End
)

REM ----------------------------------------------------
REM ���C������(�R�s�[)
REM ----------------------------------------------------

:MEIN_PROC
REM 19/03/01 CHG Start
REM COPY /-Y %SAITEKI_AFTER_DIR%\*.vbproj %SOLUTION_DIR%
COPY /Y %SAITEKI_AFTER_DIR%\*.vbproj %SOLUTION_DIR%
REM 19/03/01 CHG End
@ECHO **�R�s�[����I��** �G���^�[�������Ċ������Ă�������
REM 19/03/01 DEL Start
REM pause
REM 19/03/01 DEL End

GOTO :EOF

:EOF