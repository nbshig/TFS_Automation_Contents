rem @ECHO OFF
TITLE BuildScript_�J��

REM //�ύX����
REM 2017/03/28 ��ՍX��(�S��) �t�@�C�����ύX�A
REM                           �{�ԗp�r���h�X�N���v�g�ɍ��킹��Config�ނ̃R�s�[������ǉ��A
REM                           �����[�X�t���O�������폜
rem 2019/02/22 A00921�r���h�������Ή�
rem                           %1:�r���hVerNo(�`���FYYMMDD_XXXXXX)
rem                           %2:�\�����[�V�����\��No(�`���F)

REM //�ϐ��ݒ�
SET LOGFILE=%~n0.log
SET SOLUTION_DIR=C:\SOLUTION
SET BUILD_NO=Nothing
SET BUILDMODE=Nothing
SET APPVERSION=Nothing
SET Temp_InstallImage=C:\InstallImage
SET SOURCE_BACKUP=C:\BuildSource
SET LOG_DIR=C:\BuildLog
SET TOTAL_ERRFLG=0
REM 2017/03/28 ��ՍX��(�S��) CHG Start
REM SET Conf_Dir=\\h031s459\Release\�J���pconfig
SET Conf_Dir=\\h031s3274\Release\�J���pconfig
REM 2017/03/28 ��ՍX��(�S��) CHG End

REM //�r���hVerNo.����
@ECHO *********************************
@ECHO �r���hVerNo.����͂��Ă�������
@ECHO �`���FYYMMDD_XXXXXX 
@ECHO *********************************
:VerInput_Return
rem 2019/02/22 CHK Start
rem SET /P  APPVERSION=No:
set APPVERSION=%1
rem 2019/02/22 CHK End
echo %APPVERSION%
echo %~dp0
REM //�r���hVerNo.�`�F�b�N
rem 2019/02/22 CHK Start
rem IF %APPVERSION%==Nothing (
rem @ECHO �r���hVerNo.�����͂���Ă��܂���
rem pause
rem GOTO VerInput_Return
rem )
IF "%APPVERSION%"=="" (
	@ECHO %date% %time% �r���hVerNo.�����͂���Ă��܂��� >> %LOG_DIR%\%LOGFILE%
	EXIT /b 1
)
rem 2019/02/22 CHK End

CALL :PROC_APPVERSION_CHECK %Temp_InstallImage%\%APPVERSION%
CALL :PROC_APPVERSION_CHECK %RTB_InstallImage%\%APPVERSION%_RTB
CALL :PROC_APPVERSION_CHECK %SOURCE_BACKUP%\%APPVERSION%
CALL :PROC_APPVERSION_CHECK %LOG_DIR%\%APPVERSION%

REM //�r���h�\�����[�V�����\���̑I��
CLS
rem 2019/02/22 DEL Start
rem @ECHO **********************************************
rem @ECHO �Ώۂ̃\�����[�V�����\��No.����͂��Ă�������
rem @ECHO **********************************************
rem TYPE %~dp0Sub_Module\Const_Sln.ini
rem @ECHO .
rem :ConstSln_Return
rem SET /P BUILD_NO=No�F
rem 2019/02/22 DEL End
rem 2019/02/22 CHG Start
rem IF %BUILD_NO%==Nothing @ECHO No�����͂���Ă��܂��� & GOTO ConstSln_Return
set BUILD_NO=%2
if "%BUILD_NO%"=="" (
	@ECHO %date% %time%  �\�����[�V�����\��No.�����͂���Ă��܂��� >> %LOG_DIR%\%LOGFILE%
	EXIT /b 1
)

rem 2019/02/22 CHG End
REM ///ini�t�@�C���ύX�ɔ���skip�s���̕ύX -----2009/06/24 �ύX_Start-----
FOR /F "eol=; skip=4 tokens=1-2 delims=," %%i in (%~dp0Sub_Module\Const_Sln.ini) do IF %BUILD_NO%==%%i (
REM ///ini�t�@�C���ύX�ɔ���skip�s���̕ύX -----2009/06/24 �ύX_End-----
        SET BUILDMODE=%%j
)
IF %BUILDMODE%==Nothing (
rem 2019/02/22 CHG Sart
rem @ECHO ---- �h�m�o�t�s �d�q�q�n�q �I�I�I�I ----
rem @ECHO �\�����[�V�����\��No.������������܂���
rem @ECHO ----------------------------------------
rem 2019/02/22 CHG End
@ECHO ---- �h�m�o�t�s �d�q�q�n�q �I�I�I�I ---- >> %LOG_DIR%\%LOGFILE%
@ECHO �\�����[�V�����\��No.������������܂��� >> %LOG_DIR%\%LOGFILE%
@ECHO ---------------------------------------- >> %LOG_DIR%\%LOGFILE%
SET BUILD_NO=Nothing
rem 2019/02/22 CHG Start
rem GOTO ConstSln_Return
rem EXIT 1
EXIT /b 1
rem 2019/02/22 CHG End
)

REM //�ϐ��ݒ肻�̂Q
SET RTB_InstallImage=%Temp_InstallImage%\%APPVERSION%_RTB
SET Temp_InstallImage=%Temp_InstallImage%\%APPVERSION%_TEMP
SET SOURCE_BACKUP=%SOURCE_BACKUP%\%APPVERSION%
SET LOG_DIR=%LOG_DIR%\%APPVERSION%

REM //�r���h�����J�n�\��
CLS
IF NOT EXIST %LOG_DIR% MKDIR %LOG_DIR%
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
@ECHO  //�r���h�X�N���v�g�����J�n // >> %LOG_DIR%\%LOGFILE%
@ECHO  //�r���h�X�N���v�g�����J�n //
REM //�J�n�����\��
@ECHO %date% >> %LOG_DIR%\%LOGFILE%
@ECHO %time% >> %LOG_DIR%\%LOGFILE%
@ECHO %date% 
@ECHO %time%
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO �r���hVerNo.�@�@�@�F%APPVERSION% >> %LOG_DIR%\%LOGFILE%
@ECHO �r���hVerNo.�@�@�@�F%APPVERSION%
@ECHO �\�����[�V�����\���F%BUILDMODE% >> %LOG_DIR%\%LOGFILE%
@ECHO �\�����[�V�����\���F%BUILDMODE%
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************


REM -----2015/01/16�폜_START-----
REM -----2009/11/09�ǉ�_START-----
REM //"Symantec AntiVirus �T�[�r�X"��~
REM @ECHO "Symantec AntiVirus �T�[�r�X"���~���܂��B
REM net stop "Symantec AntiVirus" >> %LOG_DIR%\%LOGFILE%
REM IF ERRORLEVEL 1 (
REM 	@ECHO "Symantec AntiVirus �T�[�r�X"���~�o���܂���ł����B
REM 	@ECHO "Symantec AntiVirus �T�[�r�X"���蓮�Œ�~��A�����L�[�������Đ�ɐi��ł��������B
REM 	PAUSE
REM ) else (
REM 	@ECHO "Symantec AntiVirus �T�[�r�X"�͐���ɒ�~����܂����B
REM )
REM -----2009/11/09�ǉ�_END-----
REM -----2015/01/16�폜_END-----

REM //VSWebCache�폜
rem 2019/02/22 CHG Start
rem @ECHO VSWebCache�t�H���_���폜 >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time% VSWebCache�t�H���_���폜 >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO VSWebCache�t�H���_���폜
%~dp0Sub_Module\DelWebCache.vbs >> %LOG_DIR%\%LOGFILE%
IF ERRORLEVEL 1 (
SET TOTAL_ERRFLG=1
rem 2019/02/22 CHG Start
rem @ECHO VSWebCache�t�H���_�폜_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time% VSWebCache�t�H���_�폜_NG >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO VSWebCache�t�H���_�폜_NG
rem 2019/02/22 DEL Start
rem @ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
rem @ECHO VSWebCache�t�H���_���폜��A�����L�[�������Đ�ɐi��ł�������
rem @ECHO VSWebCache�t�H���_�p�X�FC:\Users\[�A�J�E���g��]\VSWebCache
rem PAUSE
rem 2019/02/22 DEL End
rem 2019/02/22 CHG Start
rem @ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ---- >> %LOG_DIR%\%LOGFILE%
rem @ECHO VSWebCache�t�H���_�p�X�FC:\Users\[�A�J�E���g��]\VSWebCache >> %LOG_DIR%\%LOGFILE%
rem ) ELSE (
rem @ECHO VSWebCache�t�H���_�폜_OK >> %LOG_DIR%\%LOGFILE%
rem @ECHO VSWebCache�t�H���_�폜_OK
rem )
@ECHO %date% %time%  ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ---- >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  VSWebCache�t�H���_�p�X�FC:\Users\[�A�J�E���g��]\VSWebCache >> %LOG_DIR%\%LOGFILE%
exit 1
) ELSE (
@ECHO %date% %time%  VSWebCache�t�H���_�폜_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  VSWebCache�t�H���_�폜_OK
)
rem 2019/02/22 CHG End
REM //�r���h�\�[�X�o�b�N�A�b�v
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
rem 2019/02/22 CHG Start
rem @ECHO �r���h�\�[�X�o�b�N�A�b�v >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  �r���h�\�[�X�o�b�N�A�b�v >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO �r���h�\�[�X�o�b�N�A�b�v
CALL :PROC_COPY %SOLUTION_DIR% %SOURCE_BACKUP%\Source\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
rem 2019/02/22 CHG Start
rem @ECHO �r���h�\�[�X�o�b�N�A�b�v_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  �r���h�\�[�X�o�b�N�A�b�v_NG >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO �r���h�\�[�X�o�b�N�A�b�v_NG
rem 2019/02/22 CHG Start
rem @ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
rem @ECHO %SOLUTION_DIR%\ �� %SOURCE_BACKUP%\Source\ �ɃR�s�[���Ă�������
rem @ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
rem PAUSE
@ECHO %date% %time%  ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ---- >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  �X�N���v�g�G���[�ɂȂ����̂ŁAPowerShell�ŋ����I�ɃR�s�[���� >> %LOG_DIR%\%LOGFILE%
rem �X�N���v�g�G���[�ɂȂ����̂ŁAPowerShell�ŋ����I�ɃR�s�[����
	powershell -ExecutionPolicy RemoteSigned -Command "try { copy-item %SOLUTION_DIR%\* %SOURCE_BACKUP%\Source\ -Force -Recurse  -ErrorAction:Stop }catch { exit 9 };exit $LASTEXITCODE"
	IF ERRORLEVEL 1 (
		@ECHO %date% %time%   PowerShell�ɂ�鋭���R�s�[_NG Powershell����󂯎�����߂�l��%ERRORLEVEL%
		@ECHO %date% %time%   �������f
		@ECHO %SOLUTION_DIR%\ �� %SOURCE_BACKUP%\Source\ �ɃR�s�[���Ă�������
		@ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
		PAUSE
	) ELSE (
		@ECHO %date% %time%  PowerShell�ɂ�鋭���R�s�[���� >> %LOG_DIR%\%LOGFILE%
	)
rem 2019/02/22 CHG End
) ELSE (
rem 2019/02/22 CHG Start
rem @ECHO �r���h�\�[�X�o�b�N�A�b�v_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  �r���h�\�[�X�o�b�N�A�b�v_OK >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO �r���h�\�[�X�o�b�N�A�b�v_OK
)

REM //InstallImage�e���|�����t�H���_�쐬
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
rem 2019/02/22 CHG Start
rem @ECHO InstallImage�e���|�����t�H���_�쐬 >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  InstallImage�e���|�����t�H���_�쐬 >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO InstallImage�e���|�����t�H���_�쐬
CALL :PROC_COPY %SOLUTION_DIR%\XSD %Temp_InstallImage%\Data\XSD\
CALL :PROC_COPY %SOLUTION_DIR%\SVF %Temp_InstallImage%\Data\SVF\
CALL :PROC_COPY %SOLUTION_DIR%\EXCEL\�� %Temp_InstallImage%\Data\\EXCEL\
CALL :PROC_COPY %SOLUTION_DIR%\EXCEL\�w�} %Temp_InstallImage%\Data\\EXCEL\
CALL :PROC_COPY %SOLUTION_DIR%\EXCEL\���� %Temp_InstallImage%\Data\\EXCEL\
CALL :PROC_COPY %SOLUTION_DIR%\Others\IEWebControls\webctrl_client %Temp_InstallImage%\Data\\Web\webctrl_client\
CALL :PROC_COPY %SOLUTION_DIR%\Configs %Temp_InstallImage%\Configs\
CALL :PROC_COPY %SOLUTION_DIR%\ReleaseScripts %Temp_InstallImage%\ReleaseScripts\
CALL :PROC_COPY %SOLUTION_DIR%\Scripts %Temp_InstallImage%\Scripts\
REM 2017/03/28 ��ՍX��(�S��) DEL Start
REM CALL :PROC_RLSTRG LibRls_E
REM CALL :PROC_RLSTRG LibRls
REM 2017/03/28 ��ՍX��(�S��) DEL End
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
rem 2019/02/22 CHG Start
rem @ECHO InstallImage�e���|�����t�H���_�쐬_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  InstallImage�e���|�����t�H���_�쐬_NG >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO InstallImage�e���|�����t�H���_�쐬_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO �R�s�[�Ɏ��s���Ă���t�H���_�� %Temp_InstallImage% �ɃR�s�[���Ă�������
@ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
rem 2019/02/22 CHG Start
rem (�R�����g�̂�)���s�����f�B���N�g��������ł��Ȃ����߁A�����I�ȃR�s�[�͍s��Ȃ��i����PowerShell�ŃR�s�[�����̂����l�ɁApause�����Ƃ��ׂ��H�j
rem 2019/02/22 CHG end
PAUSE
) ELSE (
rem 2019/02/22 CHG Start
rem @ECHO InstallImage�e���|�����t�H���_�쐬_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  InstallImage�e���|�����t�H���_�쐬_OK >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO InstallImage�e���|�����t�H���_�쐬_OK
)

REM //bin�t�H���_�쐬
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
rem 2019/02/22 CHG Start
rem @ECHO bin�t�H���_�쐬 >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  bin�t�H���_�쐬 >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO bin�t�H���_�쐬
CALL :PROC_COPY %SOLUTION_DIR%\bin_Refer\* %SOLUTION_DIR%\bin\ 
REM //2015/10/19 A00855 ADD START
CALL :PROC_COPY C:\CC01"(dev)"\CC01.dll %SOLUTION_DIR%\bin\
REM //2015/10/19 A00855 ADD END
IF %ERRFLG%==1 (
rem 2019/02/22 CHK Start
rem SET TOTAL_ERRFLG=1
rem @ECHO bin�t�H���_�쐬_NG >> %LOG_DIR%\%LOGFILE%
rem @ECHO bin�t�H���_�쐬_NG
rem @ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
rem @ECHO %SOLUTION_DIR%\bin_Refer\ �� %SOLUTION_DIR%\bin\ �ɃR�s�[���Ă�������
rem @ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
rem PAUSE

rem �X�N���v�g�G���[�ɂȂ����̂ŁAPowerShell�ŋ����I�ɃR�s�[����
	powershell -ExecutionPolicy RemoteSigned -Command "try { copy-item %SOLUTION_DIR%\bin_Refer\* %SOLUTION_DIR%\bin\ -Force -Recurse  -ErrorAction:Stop }catch { exit 9 };exit $LASTEXITCODE"
	IF ERRORLEVEL 1 (
		@ECHO %date% %time%   PowerShell�ɂ�鋭���R�s�[_NG Powershell����󂯎�����߂�l��%ERRORLEVEL%
		@ECHO %date% %time%   �������f
		@ECHO %SOLUTION_DIR%\bin_Refer\ �� %SOLUTION_DIR%\bin\ �ɃR�s�[���Ă�������
		@ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
		PAUSE
	) ELSE (
		@ECHO %date% %time%  PowerShell�ɂ�鋭���R�s�[���� >> %LOG_DIR%\%LOGFILE%
	)
rem 2019/02/22 CHK End
) ELSE (
rem 2019/02/22 CHK Start
rem @ECHO bin�t�H���_�쐬_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  bin�t�H���_�쐬_OK >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHK End
@ECHO bin�t�H���_�쐬_OK
)

REM //�E�B���X�o�X�^�[�X�g�b�v
rem @ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
rem @ECHO --------------------------------------------------------------------------
rem @ECHO �E�B���X�o�X�^�[�X�g�b�v >> %LOG_DIR%\%LOGFILE%
rem @ECHO �E�B���X�o�X�^�[�X�g�b�v
rem NET stop "OfficeScanNT RealTime Scan"  >> %LOG_DIR%\%LOGFILE%

REM //���O�r���h
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A_���O�r���h.sln

REM //�o�b�`�@�\�r���h
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A.sln

REM //Web�@�\�r���h
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A_Web.sln

REM //�v���R���p�C���pRTBWeb�t�H���_�쐬
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO �v���R���p�C���pWeb�t�H���_�쐬 >> %LOG_DIR%\%LOGFILE%
@ECHO �v���R���p�C���pWeb�t�H���_�쐬
@ECHO �yRTB�z >> %LOG_DIR%\%LOGFILE%
@ECHO �yRTB�z
CALL :PROC_COPY %SOLUTION_DIR%\Web %SOLUTION_DIR%\RTB_Web\
CALL :PROC_COPY %SOLUTION_DIR%\bin_Refer %SOLUTION_DIR%\RTB_Web\bin\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO �v���R���p�C���pWeb�t�H���_�쐬_NG >> %LOG_DIR%\%LOGFILE%
@ECHO �v���R���p�C���pWeb�t�H���_�쐬_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO �R�s�[�Ɏ��s���Ă���t�H���_�� %SOLUTION_DIR%\RTB_Web\ �ɃR�s�[���Ă�������
@ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
PAUSE
) ELSE (
@ECHO �v���R���p�C���pWeb�t�H���_�쐬_OK >> %LOG_DIR%\%LOGFILE%
@ECHO �v���R���p�C���pWeb�t�H���_�쐬_OK
)

REM //RTBWeb�t�H���_�v���R���p�C��
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_PRECOMPILE %SOLUTION_DIR%\RTB_Web

REM //�T�[�o�[�����Ď�(PING)�@�\�r���h
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A_02.sln

REM //�E�B���X�o�X�^�[�X�^�[�g
rem @ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
rem @ECHO --------------------------------------------------------------------------
rem @ECHO �E�B���X�o�X�^�[�X�^�[�g >> %LOG_DIR%\%LOGFILE%
rem @ECHO �E�B���X�o�X�^�[�X�^�[�g
rem NET start "OfficeScanNT RealTime Scan"  >> %LOG_DIR%\%LOGFILE%

REM //bin�t�H���_�R�s�[
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO bin�t�H���_�R�s�[ >> %LOG_DIR%\%LOGFILE%
@ECHO bin�t�H���_�R�s�[
CALL :PROC_COPY %SOLUTION_DIR%\bin\* %SOURCE_BACKUP%\Release\
CALL :PROC_COPY %SOLUTION_DIR%\bin\* %Temp_InstallImage%\Data\Exec\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO bin�t�H���_�R�s�[_NG >> %LOG_DIR%\%LOGFILE%
@ECHO bin�t�H���_�R�s�[_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO �R�s�[�����s���Ă���t�H���_�� %SOLUTION_DIR%\bin\ ���R�s�[���Ă�������
@ECHO �R�s�[������A�����L�[�������Ď��̏����ɐi��ł�������
PAUSE
) ELSE (
@ECHO bin�t�H���_�R�s�[_OK >> %LOG_DIR%\%LOGFILE%
@ECHO bin�t�H���_�R�s�[_OK
)

REM //InstallImage�e���|�����t�H���_�J�X�^�}�C�Y
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO InstallImage�e���|�����t�H���_�J�X�^�}�C�Y >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImage�e���|�����t�H���_�J�X�^�}�C�Y
CALL :PROC_FILEDEL %Temp_InstallImage%\Data\Exec\Interop.COMAPQ6Lib.dll
CALL :PROC_COPY %SOLUTION_DIR%\Scripts\Program\CMD\J69AE0_CMD.bat %Temp_InstallImage%\Data\Exec\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO InstallImage�e���|�����t�H���_�J�X�^�}�C�Y_NG >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImage�e���|�����t�H���_�J�X�^�}�C�Y_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO ���s���Ă���J�X�^�}�C�Y���e���s���Ă�������
@ECHO ������A�����L�[�������Ď��̏����ɐi��ł�������
PAUSE
) ELSE (
@ECHO InstallImage�e���|�����t�H���_�J�X�^�}�C�Y_OK >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImage�e���|�����t�H���_�J�X�^�}�C�Y_OK
)

REM //�Е�InstallImage�쐬
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO �Е�InstallImage�쐬 >> %LOG_DIR%\%LOGFILE%
@ECHO �Е�InstallImage�쐬
@ECHO �yRTB�z >> %LOG_DIR%\%LOGFILE%
@ECHO �yRTB�z
CALL :PROC_COPY %Temp_InstallImage% %RTB_InstallImage%\
REM 2017/03/28 ��ՍX��(�S��) CHG Start
REM CALL :PROC_COPY %RTB_InstallImage%\Configs\�{�� %RTB_InstallImage%\Configs\�Б�\
CALL :PROC_COPY %RTB_InstallImage%\Configs\�{�� %RTB_InstallImage%\Configs\�������Z\
CALL :PROC_COPY %Temp_InstallImage%\Configs\�������Z %RTB_InstallImage%\Configs\�������Z\
REM 2017/03/28 ��ՍX��(�S��) CHG End
REM //2013/03/27 T-031-12-253-02 ADD START
CALL :PROC_COPY %RTB_InstallImage%\Configs\�{�� %RTB_InstallImage%\Configs\�Ȗ؍Б�\
CALL :PROC_COPY %Temp_InstallImage%\Configs\�Ȗ؍Б� %RTB_InstallImage%\Configs\�Ȗ؍Б�\
REM //2013/03/27 T-031-12-253-02 ADD END
CALL :PROC_COPY %SOLUTION_DIR%\RTB_Web %RTB_InstallImage%\Data\Web\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO �Е�InstallImage�쐬_NG >> %LOG_DIR%\%LOGFILE%
@ECHO �Е�InstallImage�쐬_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO ���s���Ă���R�s�[�������s���Ă�������
@ECHO ������A�����L�[�������Ď��̏����ɐi��ł�������
PAUSE
) ELSE (
@ECHO �Е�InstallImage�쐬_OK >> %LOG_DIR%\%LOGFILE%
@ECHO �Е�InstallImage�쐬_OK
CALL :PROC_DEL %Temp_InstallImage%
)

REM //InstallImage�t�@�C���ꗗ�쐬
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO InstallImage�t�@�C���ꗗ�쐬 >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImage�t�@�C���ꗗ�쐬
@ECHO �yRTB�z >> %LOG_DIR%\%LOGFILE%
@ECHO �yRTB�z
CALL :PROC_IstImgOUTPUT %RTB_InstallImage%
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO InstallImage�t�@�C���ꗗ�쐬_NG >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImage�t�@�C���ꗗ�쐬_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO ���s���Ă���Ђ�InstallImage�t�@�C���ꗗ���쐬���Ă�������
@ECHO �쐬��A�����L�[�������Ď��̏����ɐi��ł�������
PAUSE
) ELSE (
@ECHO InstallImage�t�@�C���ꗗ�쐬_OK >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImage�t�@�C���ꗗ�쐬_OK
)

REM //�r���h�����I���\��
IF %TOTAL_ERRFLG%==1 (
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
@ECHO  //�r���h�X�N���v�g�����G���[�I�� // >> %LOG_DIR%\%LOGFILE%
@ECHO  //�r���h�X�N���v�g�����G���[�I�� //
@ECHO  �x���F�r���h��ƒ��ɃG���[�����������ƂőΉ�������Ƃɂ��āA
@ECHO  �ēx�m�F���s���Ă�������
@ECHO  �{�ԃr���h���ɂ̓G���[�����������ꍇ�́A�S�čŏ������蒼���Ă�������
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
PAUSE
GOTO END
)


REM ///�J��Config�t�@�C���R�s�[�����ǉ�_Start/// -----2010/01/19-----
REM ///x64�r���h�݈̂ȉ��̏��������s����B///
REM ///�x�����ϐ��ɑΉ�_Start/// -----2010/04/12-----
SET ERRFLG=0
IF %BUILD_NO%==1 (
	CALL :PROC_COPY %Conf_Dir%\�J�� %RTB_InstallImage%\Configs\�J��\
)
IF %BUILD_NO%==1 (
	IF %ERRFLG%==1 (
		SET TOTAL_ERRFLG=1
		@ECHO �J���pConfig�R�s�[����_NG >> %LOG_DIR%\%LOGFILE%
		@ECHO �J���pConfig�R�s�[����_NG
		@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
		@ECHO �蓮�� %Conf_Dir%\�J�� ���� %RTB_InstallImage%\Configs\ ��
		@ECHO �J���pConfig�̃R�s�[���s���ĉ������B
		@ECHO ������A�����L�[�������Ď��̏����ɐi��ł��������B
		PAUSE
	) ELSE (
		@ECHO �J���pConfig�R�s�[����_OK >> %LOG_DIR%\%LOGFILE%
		@ECHO �J���pConfig�R�s�[����_OK
	)
)
REM ///�x�����ϐ��ɑΉ�_End/// -----2010/04/12-----
REM ///�J��Config�t�@�C���R�s�[�����ǉ�_End/// -----2010/01/19-------

REM ///�t�@�C�����l�[���y�сA�f���[�g�������ɔ��������ǉ�/// -----2009/06/24 �ǉ�_Start-----
SET ERRFLG=0
IF %BUILD_NO%==1 CALL :PROC_ReName_x64
IF %BUILD_NO%==2 CALL :PROC_ReName_AnyCPU
REM ///�t�@�C�����l�[���y�сA�f���[�g�������ɔ��������ǉ�/// -----2009/06/24 �ǉ�_End-------

@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
@ECHO  //�r���h�X�N���v�g��������I�� // >> %LOG_DIR%\%LOGFILE%
@ECHO %date% >> %LOG_DIR%\%LOGFILE%
@ECHO %time% >> %LOG_DIR%\%LOGFILE%
@ECHO  //�r���h�X�N���v�g��������I�� //
REM //�I�������\��
@ECHO %date% 
@ECHO %time%
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************


GOTO END

REM ------------------------------------- 
REM �T�u���W���[��
REM ------------------------------------- 
REM //�r���hVerNo.�t�H���_�`�F�b�N
:PROC_APPVERSION_CHECK
IF EXIST %1 (
rem 2019/02/22 CHK Start
rem @ECHO  �r���hVerNo.���d�����Ă��܂� >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time% �r���hVerNo.���d�����Ă��܂� >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHK End
SET APPVERSION=Nothing
rem 2019/02/22 DEL Start
rem GOTO VerInput_Return
rem 2019/02/22 DEL End
EXIT 1
)
GOTO :EOF

REM //�t�H���_�R�s�[����
:PROC_COPY
@ECHO %1 �� %2 �փR�s�[ >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �� %2 �փR�s�[
XCOPY /S /E /V /H /Q /Y /G /R %1 %2 >> %LOG_DIR%\%LOGFILE%
IF ERRORLEVEL 1 (
SET TOTAL_ERRFLG=1
@ECHO �R�s�[_NG >> %LOG_DIR%\%LOGFILE%
@ECHO �R�s�[_NG
SET ERRFLG=1
)
GOTO :EOF

REM //�t�@�C���폜����
:PROC_FILEDEL
@ECHO %1 ���폜 >> %LOG_DIR%\%LOGFILE%
@ECHO %1 ���폜
DEL /F %1  >> %LOG_DIR%\%LOGFILE%
IF EXIST %1 (
SET TOTAL_ERRFLG=1
@ECHO �t�@�C���폜_NG >> %LOG_DIR%\%LOGFILE%
@ECHO �t�@�C���폜_NG
SET ERRFLG=1
)
GOTO :EOF

REM //�t�H���_�폜����
:PROC_DEL
@ECHO %1 ���폜 >> %LOG_DIR%\%LOGFILE%
@ECHO %1 ���폜
RMDIR /S /Q %1  >> %LOG_DIR%\%LOGFILE%
IF EXIST %1 (
SET TOTAL_ERRFLG=1
@ECHO �t�H���_�폜_NG >> %LOG_DIR%\%LOGFILE%
@ECHO �t�H���_�폜_NG
SET ERRFLG=1
)
GOTO :EOF

REM 2017/03/28 ��ՍX��(�S��) DEL Start
REM //�����[�X�g���K�t�@�C���쐬����
REM :PROC_RLSTRG
REM @ECHO %Temp_InstallImage%\%1 �֍쐬 >> %LOG_DIR%\%LOGFILE%
REM @ECHO %Temp_InstallImage%\%1 �֍쐬
REM @ECHO %DATE% > %Temp_InstallImage%\%1
REM IF NOT EXIST %Temp_InstallImage%\%1 (
REM @ECHO �쐬_NG >> %LOG_DIR%\%LOGFILE%
REM @ECHO �쐬_NG
REM SET ERRFLG=1
REM )
REM GOTO :EOF
REM 2017/03/28 ��ՍX��(�S��) DEL End

REM //�\�����[�V�����r���h����
:PROC_Build
SET BAT_ERRFLG=0
@ECHO %1 �r���h >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �r���h
CALL %~dp0\Sub_Module\Build.bat %1 %LOG_DIR% %BUILDMODE%
IF %BAT_ERRFLG% == 1 (
SET TOTAL_ERRFLG=1
@ECHO %1 �r���h_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �r���h_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO ���L�̍�Ƃ��s���A�����㉽���L�[�������Ď��̏����ɐi��ł�������
@ECHO �y��Ɠ��e�z
@ECHO ���\�����[�V�����P�ʂł̎蓮�r���h
@ECHO �P�D%SOLUTION_DIR%\bin\ �̒����폜���Ă�������
@ECHO �@�@��Lib69A_Web.sln�̏ꍇ�́A%SOLUTION_DIR%\Web\bin �t�H���_���폜���Ă�������
@ECHO �Q�D%SOLUTION_DIR%\obj ���t�H���_���폜���Ă�������
@ECHO �R�D%SOLUTION_DIR%\bin_Refer\ �� %SOLUTION_DIR%\bin\ �ɃR�s�[���Ă�������
@ECHO �S�D%1 ���J���A�r���h���s���Ă�������
@ECHO �T�D%SOLUTION_DIR%\bin\ �� %SOLUTION_DIR%\bin_Refer\ �ɃR�s�[���Ă�������
PAUSE
) ELSE (
@ECHO %1 �r���h_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �r���h_OK
)
GOTO :EOF

REM //WEB�v���R���p�C������
:PROC_PRECOMPILE
@ECHO %1 �t�H���_�v���R���p�C�� >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �t�H���_�v���R���p�C��
CALL %~dp0\Sub_Module\BuildWeb.bat %1 %LOG_DIR%
IF %BAT_ERRFLG% == 1 (
SET TOTAL_ERRFLG=1
@ECHO %1 �t�H���_�v���R���p�C��_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �t�H���_�v���R���p�C��_NG
@ECHO ---- �r�b�q�h�o�s �d�q�q�n�q �I�I�I�I ----
@ECHO ���L�̍�Ƃ��s���A�����㉽���L�[�������Ď��̏����ɐi��ł�������
@ECHO �y��Ɠ��e�z
@ECHO �P�DSDK�R�}���h�v�����v�g����蓮�Ńv���R���p�C�����s���Ă�������
@ECHO     �v���R���p�C���R�}���h�Faspnet_compiler -p %1 -v /Web_Temp %SOLUTION_DIR%\Web_Temp
@ECHO �Q�D�v���R���p�C��������A%1���A%1_BACKUP�փ��l�[�����Ă�������
@ECHO �R�D%SOLUTION_DIR%\Web_Temp���A%1�փ��l�[�����Ă�������
PAUSE
) ELSE (
@ECHO %1 �t�H���_�v���R���p�C��_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �t�H���_�v���R���p�C��_OK
)
GOTO :EOF

REM //InstallImage�t�@�C���ꗗ�쐬����
:PROC_IstImgOUTPUT
@ECHO %1 �t�@�C���ꗗ�쐬 >> %LOG_DIR%\%LOGFILE%
@ECHO %1 �t�@�C���ꗗ�쐬
CALL %~dp0\Sub_Module\Install_ImageOUTPUT.vbs %1 >> %LOG_DIR%\%LOGFILE%
IF ERRORLEVEL 1 (
SET TOTAL_ERRFLG=1
@ECHO %1�t�@�C���ꗗ�쐬_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %1�t�@�C���ꗗ�쐬_NG
SET ERRFLG=1
)
GOTO :EOF

REM ///�t�@�C�����l�[���y�сA�f���[�g�������ɔ��������ǉ�/// -----2009/06/24 �ǉ�_Start-----
REM ///ReName����(x64)///
:PROC_ReName_x64
SET ERR_FLG=0

@ECHO ===================================
@ECHO ���l�[���������J�n���܂��B >> %LOG_DIR%\%LOGFILE%
@ECHO (x64)�ł̃��l�[���������J�n���܂�
@ECHO ===================================

RENAME %LOG_DIR% %APPVERSION%"(x64)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM // LOGFILE�̕ϐ��Z�b�g
SET LOG_DIR=%LOG_DIR%(x64)
RENAME %SOURCE_BACKUP% %APPVERSION%"(x64)"
IF ERRORLEVEL 1 SET ERR_FLG=1
RENAME %RTB_InstallImage% %APPVERSION%"_RTB(x64)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16�폜_START-----
REM RENAME %SOLUTION_DIR% SOLUTION"_"%APPVERSION%"(x64)"
REM IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16�폜_END-----
REM ///�G���[���������ꍇ�ARename_NG������///
IF %ERR_FLG%==1 GOTO :Rename_NG
@ECHO x64�� ���l�[��_OK >> %LOG_DIR%\%LOGFILE%
@ECHO x64�� ���l�[��_OK

REM -----2015/01/16�ǉ�_START-----
REM /// �s�v��SOLUTION�t�H���_�̍폜 ///
IF EXIST %SOLUTION_DIR% (
	RMDIR /s /q %SOLUTION_DIR%
	IF ERRORLEVEL 1 CALL :SOL_DEL_ERR
) ELSE (
	CALL :SOL_NOTEXIST
)
REM -----2015/01/16�ǉ�_END-----
GOTO :START_SAV


REM ///Rename����(AnyCPU)///
:PROC_ReName_AnyCPU
SET ERR_FLG=0

@ECHO ======================================
@ECHO ���l�[���������J�n���܂��B >> %LOG_DIR%\%LOGFILE%
@ECHO (AnyCPU)�ł̃��l�[���������J�n���܂��B
@ECHO ======================================

REM /// �s�v�t�@�C���̍폜 ///
IF EXIST %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll (
	DEL   %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll
	IF ERRORLEVEL 1 CALL :DEL_ERR
) ELSE (
	CALL :NOTEXIST
)

REM /// x86�Ńt�@�C���̒u�� ///
COPY /Y %SOURCE_BACKUP%\Source\Others\bin_Refer"(x86)"\jp.co.fit.vfreport.SvfrClient.dll %SOURCE_BACKUP%\Release\
IF ERRORLEVEL 1 CALL :COPY_ERR
REM //2015/10/19 A00855 ADD START
COPY /Y C:\CC01"(devx86)"\CC01.dll %SOURCE_BACKUP%\Release\
IF ERRORLEVEL 1 CALL :COPY_ERR2
REM //2015/10/19 A00855 ADD END

RENAME %LOG_DIR% %APPVERSION%"(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM /// LOGFILE�̕ϐ��Z�b�g ///
SET LOG_DIR=%LOG_DIR%(AnyCPU)
RENAME %SOURCE_BACKUP%\Release "Release(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
RENAME %SOURCE_BACKUP% %APPVERSION%"(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
RENAME %RTB_InstallImage% %APPVERSION%"_RTB(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16�폜_START-----
REM RENAME %SOLUTION_DIR% SOLUTION"_"%APPVERSION%"(AnyCPU)"
REM IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16�폜_END-----
REM ///�G���[���������ꍇ�ARename_NG������///
IF %ERR_FLG%==1 GOTO :Rename_NG
@ECHO ====================
@ECHO AnyCPU�� ���l�[��_OK >> %LOG_DIR%\%LOGFILE%
@ECHO AnyCPU�� ���l�[��_OK
@ECHO ====================

REM -----2015/01/16�ǉ�_START-----
REM /// �s�v��SOLUTION�t�H���_�̍폜 ///
IF EXIST %SOLUTION_DIR% (
	RMDIR /s /q %SOLUTION_DIR%
	IF ERRORLEVEL 1 CALL :SOL_DEL_ERR
) ELSE (
	CALL :SOL_NOTEXIST
)
REM -----2015/01/16�ǉ�_END-----
GOTO :START_SAV



:START_SAV
REM -----2015/01/16�폜_START-----
REM -----2009/11/09�ǉ�_START-----
REM //"Symantec AntiVirus �T�[�r�X"�J�n
REM @ECHO "Symantec AntiVirus �T�[�r�X"���J�n���܂��B
REM net start "Symantec AntiVirus" >> %LOG_DIR%\%LOGFILE%
REM IF ERRORLEVEL 1 (
REM 	@ECHO "Symantec AntiVirus �T�[�r�X"���J�n�o���܂���ł����B
REM 	@ECHO "Symantec AntiVirus �T�[�r�X"���蓮�ŊJ�n��A�����L�[�������Đ�ɐi��ł��������B
REM 	PAUSE
REM ) else (
REM 	@ECHO "Symantec AntiVirus �T�[�r�X"�͐���ɊJ�n����܂����B
REM )
REM -----2009/11/09�ǉ�_END-----
REM -----2015/01/16�폜_END-----

GOTO :EOF

REM ///Rename_NG����///
:Rename_NG
@ECHO ==================================
@ECHO ���l�[��_����NG >> %LOG_DIR%\%LOGFILE%
@ECHO ���l�[��_����NG
@ECHO �蓮�Ń��l�[�������{���Ă��������B
@ECHO ==================================
PAUSE
EXIT

REM ///FILE�����݂��Ȃ��ꍇ�̃G���[����///
:NOTEXIST
@ECHO ======================================================================
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll�����݂��܂��� >> %LOG_DIR%\%LOGFILE%
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll�����݂��܂���
@ECHO Microsoft.Web.UI.WebControls.dll�폜�������X���[���܂� >> %LOG_DIR%\%LOGFILE%
@ECHO Microsoft.Web.UI.WebControls.dll�폜�������X���[���܂�
@ECHO ======================================================================
PAUSE
GOTO :EOF

REM ///DEL_ERR����///
:DEL_ERR
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll�폜_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll�폜_NG
@ECHO �蓮��Microsoft.Web.UI.WebControls.dll�폜��Enter���������āA���̏��������s���Ă��������B
PAUSE
GOTO :EOF

REM ///COPY_ERR����///
:COPY_ERR
@ECHO jp.co.fit.vfreport.SvfrClient.dll�u��_NG >> %LOG_DIR%\%LOGFILE%
@ECHO jp.co.fit.vfreport.SvfrClient.dll�u��_NG
@ECHO �蓮��jp.co.fit.vfreport.SvfrClient.dll��"(AnyCPU)"�łɒu����Enter���������āA���̏��������s���Ă�������
PAUSE
GOTO :EOF

REM //2015/10/19 A00855 ADD START
REM ///COPY_ERR2����///
:COPY_ERR2
@ECHO CC01.dll�u��_NG >> %LOG_DIR%\%LOGFILE%
@ECHO CC01.dll�u��_NG
@ECHO �蓮��CC01.dll��"(AnyCPU)"�łɒu����Enter���������āA���̏��������s���Ă�������
PAUSE
GOTO :EOF
REM //2015/10/19 A00855 ADD END
REM ///�t�@�C�����l�[���y�сA�f���[�g�������ɔ��������ǉ�/// -----2009/06/24 �ǉ�_End-------

REM -----2015/01/16�ǉ�_START-----
REM ///SOLUTION�t�H���_�����݂��Ȃ��ꍇ�̃G���[����///
:SOL_NOTEXIST
@ECHO ======================================================================
@ECHO %SOLUTION_DIR%�t�H���_�����݂��܂��� >> %LOG_DIR%\%LOGFILE%
@ECHO %SOLUTION_DIR%�t�H���_�����݂��܂���
@ECHO %SOLUTION_DIR%�t�H���_�폜�������X�L�b�v���܂� >> %LOG_DIR%\%LOGFILE%
@ECHO %SOLUTION_DIR%�t�H���_�폜�������X�L�b�v���܂�
@ECHO ======================================================================
PAUSE
GOTO :EOF

REM ///SOL_DEL_ERR����///
:SOL_DEL_ERR
@ECHO %SOLUTION_DIR%�t�H���_�폜_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %SOLUTION_DIR%�t�H���_�폜_NG
@ECHO �蓮��%SOLUTION_DIR%�t�H���_�폜��Enter���������āA���̏��������s���Ă��������B
PAUSE
GOTO :EOF
REM -----2015/01/16�ǉ�_END-----

:END
