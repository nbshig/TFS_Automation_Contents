@ECHO OFF
REM ----------------------------------------------------
REM ���W���[�����@�F�v���W�F�N�g�t�@�C���R�s�[.bat
REM �@�\�@�@�@�@�@�FC:\SOLUTION�t�H���_��vbproj�t�@�C����
REM �@�@�@�@�@�@�@�@�S��C:\�œK���I�v�V�����c�[��\00_proj
REM �@�@�@�@�@�@�@�@�t�H���_�ɃR�s�[����B
REM ----------------------------------------------------

REM ----------------------------------------------------
REM �ϐ��Z�b�g
REM ----------------------------------------------------

SET SOLUTION_DIR=C:\SOLUTION
SET SAITEKI_DIR=C:\�œK���I�v�V�����c�[��_�߂��p\00_proj

REM ----------------------------------------------------
REM �`�F�b�N
REM ----------------------------------------------------

:CHECK_PROC

REM �R�s�[���t�H���_�L���`�F�b�N(������΃G���[)

IF NOT EXIST %SOLUTION_DIR% (
@ECHO  ERROR : **%SOLUTION_DIR%�����݂��܂���**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 1
REM 19/03/01 CHG End
)

REM �R�s�[�Ώ�VBPROJ�t�@�C���L���`�F�b�N(������΃G���[)

IF NOT EXIST %SOLUTION_DIR%\*.vbproj (
@ECHO  ERROR : **�v���W�F�N�g�t�@�C�������݂��܂���**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 2
REM 19/03/01 CHG End
)

REM �R�s�[��t�H���_�L���`�F�b�N(������΃G���[)

IF NOT EXIST %SAITEKI_DIR% (
@ECHO  ERROR : **%SAITEKI_DIR%�t�H���_�����݂��܂���**
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

COPY /-Y %SOLUTION_DIR%\*.vbproj %SAITEKI_DIR%

REM 19/03/01 CHG Start
REM @ECHO **�R�s�[����I��** �G���^�[�������Ċ������Ă�������
REM PAUSE
@ECHO **�R�s�[����I��**
REM 19/03/01 CHG End
GOTO :EOF

:EOF