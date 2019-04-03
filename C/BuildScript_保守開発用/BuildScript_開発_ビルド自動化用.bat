rem @ECHO OFF
TITLE BuildScript_開発

REM //変更履歴
REM 2017/03/28 基盤更改(全体) ファイル名変更、
REM                           本番用ビルドスクリプトに合わせてConfig類のコピー処理を追加、
REM                           リリースフラグ処理を削除
rem 2019/02/22 A00921ビルド自動化対応
rem                           %1:ビルドVerNo(形式：YYMMDD_XXXXXX)
rem                           %2:ソリューション構成No(形式：)

REM //変数設定
SET LOGFILE=%~n0.log
SET SOLUTION_DIR=C:\SOLUTION
SET BUILD_NO=Nothing
SET BUILDMODE=Nothing
SET APPVERSION=Nothing
SET Temp_InstallImage=C:\InstallImage
SET SOURCE_BACKUP=C:\BuildSource
SET LOG_DIR=C:\BuildLog
SET TOTAL_ERRFLG=0
REM 2017/03/28 基盤更改(全体) CHG Start
REM SET Conf_Dir=\\h031s459\Release\開発用config
SET Conf_Dir=\\h031s3274\Release\開発用config
REM 2017/03/28 基盤更改(全体) CHG End

REM //ビルドVerNo.入力
@ECHO *********************************
@ECHO ビルドVerNo.を入力してください
@ECHO 形式：YYMMDD_XXXXXX 
@ECHO *********************************
:VerInput_Return
rem 2019/02/22 CHK Start
rem SET /P  APPVERSION=No:
set APPVERSION=%1
rem 2019/02/22 CHK End
echo %APPVERSION%
echo %~dp0
REM //ビルドVerNo.チェック
rem 2019/02/22 CHK Start
rem IF %APPVERSION%==Nothing (
rem @ECHO ビルドVerNo.が入力されていません
rem pause
rem GOTO VerInput_Return
rem )
IF "%APPVERSION%"=="" (
	@ECHO %date% %time% ビルドVerNo.が入力されていません >> %LOG_DIR%\%LOGFILE%
	EXIT /b 1
)
rem 2019/02/22 CHK End

CALL :PROC_APPVERSION_CHECK %Temp_InstallImage%\%APPVERSION%
CALL :PROC_APPVERSION_CHECK %RTB_InstallImage%\%APPVERSION%_RTB
CALL :PROC_APPVERSION_CHECK %SOURCE_BACKUP%\%APPVERSION%
CALL :PROC_APPVERSION_CHECK %LOG_DIR%\%APPVERSION%

REM //ビルドソリューション構成の選択
CLS
rem 2019/02/22 DEL Start
rem @ECHO **********************************************
rem @ECHO 対象のソリューション構成No.を入力してください
rem @ECHO **********************************************
rem TYPE %~dp0Sub_Module\Const_Sln.ini
rem @ECHO .
rem :ConstSln_Return
rem SET /P BUILD_NO=No：
rem 2019/02/22 DEL End
rem 2019/02/22 CHG Start
rem IF %BUILD_NO%==Nothing @ECHO Noが入力されていません & GOTO ConstSln_Return
set BUILD_NO=%2
if "%BUILD_NO%"=="" (
	@ECHO %date% %time%  ソリューション構成No.が入力されていません >> %LOG_DIR%\%LOGFILE%
	EXIT /b 1
)

rem 2019/02/22 CHG End
REM ///iniファイル変更に伴いskip行数の変更 -----2009/06/24 変更_Start-----
FOR /F "eol=; skip=4 tokens=1-2 delims=," %%i in (%~dp0Sub_Module\Const_Sln.ini) do IF %BUILD_NO%==%%i (
REM ///iniファイル変更に伴いskip行数の変更 -----2009/06/24 変更_End-----
        SET BUILDMODE=%%j
)
IF %BUILDMODE%==Nothing (
rem 2019/02/22 CHG Sart
rem @ECHO ---- ＩＮＰＵＴ ＥＲＲＯＲ ！！！！ ----
rem @ECHO ソリューション構成No.が正しくありません
rem @ECHO ----------------------------------------
rem 2019/02/22 CHG End
@ECHO ---- ＩＮＰＵＴ ＥＲＲＯＲ ！！！！ ---- >> %LOG_DIR%\%LOGFILE%
@ECHO ソリューション構成No.が正しくありません >> %LOG_DIR%\%LOGFILE%
@ECHO ---------------------------------------- >> %LOG_DIR%\%LOGFILE%
SET BUILD_NO=Nothing
rem 2019/02/22 CHG Start
rem GOTO ConstSln_Return
rem EXIT 1
EXIT /b 1
rem 2019/02/22 CHG End
)

REM //変数設定その２
SET RTB_InstallImage=%Temp_InstallImage%\%APPVERSION%_RTB
SET Temp_InstallImage=%Temp_InstallImage%\%APPVERSION%_TEMP
SET SOURCE_BACKUP=%SOURCE_BACKUP%\%APPVERSION%
SET LOG_DIR=%LOG_DIR%\%APPVERSION%

REM //ビルド処理開始表示
CLS
IF NOT EXIST %LOG_DIR% MKDIR %LOG_DIR%
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
@ECHO  //ビルドスクリプト処理開始 // >> %LOG_DIR%\%LOGFILE%
@ECHO  //ビルドスクリプト処理開始 //
REM //開始時刻表示
@ECHO %date% >> %LOG_DIR%\%LOGFILE%
@ECHO %time% >> %LOG_DIR%\%LOGFILE%
@ECHO %date% 
@ECHO %time%
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO ビルドVerNo.　　　：%APPVERSION% >> %LOG_DIR%\%LOGFILE%
@ECHO ビルドVerNo.　　　：%APPVERSION%
@ECHO ソリューション構成：%BUILDMODE% >> %LOG_DIR%\%LOGFILE%
@ECHO ソリューション構成：%BUILDMODE%
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************


REM -----2015/01/16削除_START-----
REM -----2009/11/09追加_START-----
REM //"Symantec AntiVirus サービス"停止
REM @ECHO "Symantec AntiVirus サービス"を停止します。
REM net stop "Symantec AntiVirus" >> %LOG_DIR%\%LOGFILE%
REM IF ERRORLEVEL 1 (
REM 	@ECHO "Symantec AntiVirus サービス"を停止出来ませんでした。
REM 	@ECHO "Symantec AntiVirus サービス"を手動で停止後、何かキーを押して先に進んでください。
REM 	PAUSE
REM ) else (
REM 	@ECHO "Symantec AntiVirus サービス"は正常に停止されました。
REM )
REM -----2009/11/09追加_END-----
REM -----2015/01/16削除_END-----

REM //VSWebCache削除
rem 2019/02/22 CHG Start
rem @ECHO VSWebCacheフォルダを削除 >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time% VSWebCacheフォルダを削除 >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO VSWebCacheフォルダを削除
%~dp0Sub_Module\DelWebCache.vbs >> %LOG_DIR%\%LOGFILE%
IF ERRORLEVEL 1 (
SET TOTAL_ERRFLG=1
rem 2019/02/22 CHG Start
rem @ECHO VSWebCacheフォルダ削除_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time% VSWebCacheフォルダ削除_NG >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO VSWebCacheフォルダ削除_NG
rem 2019/02/22 DEL Start
rem @ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
rem @ECHO VSWebCacheフォルダを削除後、何かキーを押して先に進んでください
rem @ECHO VSWebCacheフォルダパス：C:\Users\[アカウント名]\VSWebCache
rem PAUSE
rem 2019/02/22 DEL End
rem 2019/02/22 CHG Start
rem @ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ---- >> %LOG_DIR%\%LOGFILE%
rem @ECHO VSWebCacheフォルダパス：C:\Users\[アカウント名]\VSWebCache >> %LOG_DIR%\%LOGFILE%
rem ) ELSE (
rem @ECHO VSWebCacheフォルダ削除_OK >> %LOG_DIR%\%LOGFILE%
rem @ECHO VSWebCacheフォルダ削除_OK
rem )
@ECHO %date% %time%  ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ---- >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  VSWebCacheフォルダパス：C:\Users\[アカウント名]\VSWebCache >> %LOG_DIR%\%LOGFILE%
exit 1
) ELSE (
@ECHO %date% %time%  VSWebCacheフォルダ削除_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  VSWebCacheフォルダ削除_OK
)
rem 2019/02/22 CHG End
REM //ビルドソースバックアップ
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
rem 2019/02/22 CHG Start
rem @ECHO ビルドソースバックアップ >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  ビルドソースバックアップ >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO ビルドソースバックアップ
CALL :PROC_COPY %SOLUTION_DIR% %SOURCE_BACKUP%\Source\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
rem 2019/02/22 CHG Start
rem @ECHO ビルドソースバックアップ_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  ビルドソースバックアップ_NG >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO ビルドソースバックアップ_NG
rem 2019/02/22 CHG Start
rem @ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
rem @ECHO %SOLUTION_DIR%\ を %SOURCE_BACKUP%\Source\ にコピーしてください
rem @ECHO コピー完了後、何かキーを押して次の処理に進んでください
rem PAUSE
@ECHO %date% %time%  ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ---- >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  スクリプトエラーになったので、PowerShellで強制的にコピーする >> %LOG_DIR%\%LOGFILE%
rem スクリプトエラーになったので、PowerShellで強制的にコピーする
	powershell -ExecutionPolicy RemoteSigned -Command "try { copy-item %SOLUTION_DIR%\* %SOURCE_BACKUP%\Source\ -Force -Recurse  -ErrorAction:Stop }catch { exit 9 };exit $LASTEXITCODE"
	IF ERRORLEVEL 1 (
		@ECHO %date% %time%   PowerShellによる強制コピー_NG Powershellから受け取った戻り値→%ERRORLEVEL%
		@ECHO %date% %time%   処理中断
		@ECHO %SOLUTION_DIR%\ を %SOURCE_BACKUP%\Source\ にコピーしてください
		@ECHO コピー完了後、何かキーを押して次の処理に進んでください
		PAUSE
	) ELSE (
		@ECHO %date% %time%  PowerShellによる強制コピー完了 >> %LOG_DIR%\%LOGFILE%
	)
rem 2019/02/22 CHG End
) ELSE (
rem 2019/02/22 CHG Start
rem @ECHO ビルドソースバックアップ_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  ビルドソースバックアップ_OK >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO ビルドソースバックアップ_OK
)

REM //InstallImageテンポラリフォルダ作成
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
rem 2019/02/22 CHG Start
rem @ECHO InstallImageテンポラリフォルダ作成 >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  InstallImageテンポラリフォルダ作成 >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO InstallImageテンポラリフォルダ作成
CALL :PROC_COPY %SOLUTION_DIR%\XSD %Temp_InstallImage%\Data\XSD\
CALL :PROC_COPY %SOLUTION_DIR%\SVF %Temp_InstallImage%\Data\SVF\
CALL :PROC_COPY %SOLUTION_DIR%\EXCEL\届 %Temp_InstallImage%\Data\\EXCEL\
CALL :PROC_COPY %SOLUTION_DIR%\EXCEL\指図 %Temp_InstallImage%\Data\\EXCEL\
CALL :PROC_COPY %SOLUTION_DIR%\EXCEL\共通 %Temp_InstallImage%\Data\\EXCEL\
CALL :PROC_COPY %SOLUTION_DIR%\Others\IEWebControls\webctrl_client %Temp_InstallImage%\Data\\Web\webctrl_client\
CALL :PROC_COPY %SOLUTION_DIR%\Configs %Temp_InstallImage%\Configs\
CALL :PROC_COPY %SOLUTION_DIR%\ReleaseScripts %Temp_InstallImage%\ReleaseScripts\
CALL :PROC_COPY %SOLUTION_DIR%\Scripts %Temp_InstallImage%\Scripts\
REM 2017/03/28 基盤更改(全体) DEL Start
REM CALL :PROC_RLSTRG LibRls_E
REM CALL :PROC_RLSTRG LibRls
REM 2017/03/28 基盤更改(全体) DEL End
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
rem 2019/02/22 CHG Start
rem @ECHO InstallImageテンポラリフォルダ作成_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  InstallImageテンポラリフォルダ作成_NG >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO InstallImageテンポラリフォルダ作成_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO コピーに失敗しているフォルダを %Temp_InstallImage% にコピーしてください
@ECHO コピー完了後、何かキーを押して次の処理に進んでください
rem 2019/02/22 CHG Start
rem (コメントのみ)失敗したディレクトリが特定できないため、強制的なコピーは行わない（他でPowerShellでコピーしたのも同様に、pauseさせとくべき？）
rem 2019/02/22 CHG end
PAUSE
) ELSE (
rem 2019/02/22 CHG Start
rem @ECHO InstallImageテンポラリフォルダ作成_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  InstallImageテンポラリフォルダ作成_OK >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO InstallImageテンポラリフォルダ作成_OK
)

REM //binフォルダ作成
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
rem 2019/02/22 CHG Start
rem @ECHO binフォルダ作成 >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  binフォルダ作成 >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHG End
@ECHO binフォルダ作成
CALL :PROC_COPY %SOLUTION_DIR%\bin_Refer\* %SOLUTION_DIR%\bin\ 
REM //2015/10/19 A00855 ADD START
CALL :PROC_COPY C:\CC01"(dev)"\CC01.dll %SOLUTION_DIR%\bin\
REM //2015/10/19 A00855 ADD END
IF %ERRFLG%==1 (
rem 2019/02/22 CHK Start
rem SET TOTAL_ERRFLG=1
rem @ECHO binフォルダ作成_NG >> %LOG_DIR%\%LOGFILE%
rem @ECHO binフォルダ作成_NG
rem @ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
rem @ECHO %SOLUTION_DIR%\bin_Refer\ を %SOLUTION_DIR%\bin\ にコピーしてください
rem @ECHO コピー完了後、何かキーを押して次の処理に進んでください
rem PAUSE

rem スクリプトエラーになったので、PowerShellで強制的にコピーする
	powershell -ExecutionPolicy RemoteSigned -Command "try { copy-item %SOLUTION_DIR%\bin_Refer\* %SOLUTION_DIR%\bin\ -Force -Recurse  -ErrorAction:Stop }catch { exit 9 };exit $LASTEXITCODE"
	IF ERRORLEVEL 1 (
		@ECHO %date% %time%   PowerShellによる強制コピー_NG Powershellから受け取った戻り値→%ERRORLEVEL%
		@ECHO %date% %time%   処理中断
		@ECHO %SOLUTION_DIR%\bin_Refer\ を %SOLUTION_DIR%\bin\ にコピーしてください
		@ECHO コピー完了後、何かキーを押して次の処理に進んでください
		PAUSE
	) ELSE (
		@ECHO %date% %time%  PowerShellによる強制コピー完了 >> %LOG_DIR%\%LOGFILE%
	)
rem 2019/02/22 CHK End
) ELSE (
rem 2019/02/22 CHK Start
rem @ECHO binフォルダ作成_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time%  binフォルダ作成_OK >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHK End
@ECHO binフォルダ作成_OK
)

REM //ウィルスバスターストップ
rem @ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
rem @ECHO --------------------------------------------------------------------------
rem @ECHO ウィルスバスターストップ >> %LOG_DIR%\%LOGFILE%
rem @ECHO ウィルスバスターストップ
rem NET stop "OfficeScanNT RealTime Scan"  >> %LOG_DIR%\%LOGFILE%

REM //事前ビルド
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A_事前ビルド.sln

REM //バッチ機能ビルド
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A.sln

REM //Web機能ビルド
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A_Web.sln

REM //プリコンパイル用RTBWebフォルダ作成
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO プリコンパイル用Webフォルダ作成 >> %LOG_DIR%\%LOGFILE%
@ECHO プリコンパイル用Webフォルダ作成
@ECHO 【RTB】 >> %LOG_DIR%\%LOGFILE%
@ECHO 【RTB】
CALL :PROC_COPY %SOLUTION_DIR%\Web %SOLUTION_DIR%\RTB_Web\
CALL :PROC_COPY %SOLUTION_DIR%\bin_Refer %SOLUTION_DIR%\RTB_Web\bin\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO プリコンパイル用Webフォルダ作成_NG >> %LOG_DIR%\%LOGFILE%
@ECHO プリコンパイル用Webフォルダ作成_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO コピーに失敗しているフォルダを %SOLUTION_DIR%\RTB_Web\ にコピーしてください
@ECHO コピー完了後、何かキーを押して次の処理に進んでください
PAUSE
) ELSE (
@ECHO プリコンパイル用Webフォルダ作成_OK >> %LOG_DIR%\%LOGFILE%
@ECHO プリコンパイル用Webフォルダ作成_OK
)

REM //RTBWebフォルダプリコンパイル
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_PRECOMPILE %SOLUTION_DIR%\RTB_Web

REM //サーバー生存監視(PING)機能ビルド
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
CALL :PROC_Build %SOLUTION_DIR%\Lib69A_02.sln

REM //ウィルスバスタースタート
rem @ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
rem @ECHO --------------------------------------------------------------------------
rem @ECHO ウィルスバスタースタート >> %LOG_DIR%\%LOGFILE%
rem @ECHO ウィルスバスタースタート
rem NET start "OfficeScanNT RealTime Scan"  >> %LOG_DIR%\%LOGFILE%

REM //binフォルダコピー
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO binフォルダコピー >> %LOG_DIR%\%LOGFILE%
@ECHO binフォルダコピー
CALL :PROC_COPY %SOLUTION_DIR%\bin\* %SOURCE_BACKUP%\Release\
CALL :PROC_COPY %SOLUTION_DIR%\bin\* %Temp_InstallImage%\Data\Exec\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO binフォルダコピー_NG >> %LOG_DIR%\%LOGFILE%
@ECHO binフォルダコピー_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO コピーが失敗しているフォルダに %SOLUTION_DIR%\bin\ をコピーしてください
@ECHO コピー完了後、何かキーを押して次の処理に進んでください
PAUSE
) ELSE (
@ECHO binフォルダコピー_OK >> %LOG_DIR%\%LOGFILE%
@ECHO binフォルダコピー_OK
)

REM //InstallImageテンポラリフォルダカスタマイズ
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO InstallImageテンポラリフォルダカスタマイズ >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImageテンポラリフォルダカスタマイズ
CALL :PROC_FILEDEL %Temp_InstallImage%\Data\Exec\Interop.COMAPQ6Lib.dll
CALL :PROC_COPY %SOLUTION_DIR%\Scripts\Program\CMD\J69AE0_CMD.bat %Temp_InstallImage%\Data\Exec\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO InstallImageテンポラリフォルダカスタマイズ_NG >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImageテンポラリフォルダカスタマイズ_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO 失敗しているカスタマイズ内容を行ってください
@ECHO 完了後、何かキーを押して次の処理に進んでください
PAUSE
) ELSE (
@ECHO InstallImageテンポラリフォルダカスタマイズ_OK >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImageテンポラリフォルダカスタマイズ_OK
)

REM //個社別InstallImage作成
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO 個社別InstallImage作成 >> %LOG_DIR%\%LOGFILE%
@ECHO 個社別InstallImage作成
@ECHO 【RTB】 >> %LOG_DIR%\%LOGFILE%
@ECHO 【RTB】
CALL :PROC_COPY %Temp_InstallImage% %RTB_InstallImage%\
REM 2017/03/28 基盤更改(全体) CHG Start
REM CALL :PROC_COPY %RTB_InstallImage%\Configs\本番 %RTB_InstallImage%\Configs\災対\
CALL :PROC_COPY %RTB_InstallImage%\Configs\本番 %RTB_InstallImage%\Configs\数理決算\
CALL :PROC_COPY %Temp_InstallImage%\Configs\数理決算 %RTB_InstallImage%\Configs\数理決算\
REM 2017/03/28 基盤更改(全体) CHG End
REM //2013/03/27 T-031-12-253-02 ADD START
CALL :PROC_COPY %RTB_InstallImage%\Configs\本番 %RTB_InstallImage%\Configs\栃木災対\
CALL :PROC_COPY %Temp_InstallImage%\Configs\栃木災対 %RTB_InstallImage%\Configs\栃木災対\
REM //2013/03/27 T-031-12-253-02 ADD END
CALL :PROC_COPY %SOLUTION_DIR%\RTB_Web %RTB_InstallImage%\Data\Web\
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO 個社別InstallImage作成_NG >> %LOG_DIR%\%LOGFILE%
@ECHO 個社別InstallImage作成_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO 失敗しているコピー処理を行ってください
@ECHO 完了後、何かキーを押して次の処理に進んでください
PAUSE
) ELSE (
@ECHO 個社別InstallImage作成_OK >> %LOG_DIR%\%LOGFILE%
@ECHO 個社別InstallImage作成_OK
CALL :PROC_DEL %Temp_InstallImage%
)

REM //InstallImageファイル一覧作成
SET ERRFLG=0
@ECHO -------------------------------------------------------------------------- >> %LOG_DIR%\%LOGFILE%
@ECHO --------------------------------------------------------------------------
@ECHO InstallImageファイル一覧作成 >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImageファイル一覧作成
@ECHO 【RTB】 >> %LOG_DIR%\%LOGFILE%
@ECHO 【RTB】
CALL :PROC_IstImgOUTPUT %RTB_InstallImage%
IF %ERRFLG%==1 (
SET TOTAL_ERRFLG=1
@ECHO InstallImageファイル一覧作成_NG >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImageファイル一覧作成_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO 失敗している個社のInstallImageファイル一覧を作成してください
@ECHO 作成後、何かキーを押して次の処理に進んでください
PAUSE
) ELSE (
@ECHO InstallImageファイル一覧作成_OK >> %LOG_DIR%\%LOGFILE%
@ECHO InstallImageファイル一覧作成_OK
)

REM //ビルド処理終了表示
IF %TOTAL_ERRFLG%==1 (
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
@ECHO  //ビルドスクリプト処理エラー終了 // >> %LOG_DIR%\%LOGFILE%
@ECHO  //ビルドスクリプト処理エラー終了 //
@ECHO  警告：ビルド作業中にエラーが発生し手作業で対応した作業について、
@ECHO  再度確認を行ってください
@ECHO  本番ビルド時にはエラーが発生した場合は、全て最初からやり直してください
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
PAUSE
GOTO END
)


REM ///開発Configファイルコピー処理追加_Start/// -----2010/01/19-----
REM ///x64ビルドのみ以下の処理を実行する。///
REM ///遅延環境変数に対応_Start/// -----2010/04/12-----
SET ERRFLG=0
IF %BUILD_NO%==1 (
	CALL :PROC_COPY %Conf_Dir%\開発 %RTB_InstallImage%\Configs\開発\
)
IF %BUILD_NO%==1 (
	IF %ERRFLG%==1 (
		SET TOTAL_ERRFLG=1
		@ECHO 開発用Configコピー処理_NG >> %LOG_DIR%\%LOGFILE%
		@ECHO 開発用Configコピー処理_NG
		@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
		@ECHO 手動で %Conf_Dir%\開発 から %RTB_InstallImage%\Configs\ へ
		@ECHO 開発用Configのコピーを行って下さい。
		@ECHO 完了後、何かキーを押して次の処理に進んでください。
		PAUSE
	) ELSE (
		@ECHO 開発用Configコピー処理_OK >> %LOG_DIR%\%LOGFILE%
		@ECHO 開発用Configコピー処理_OK
	)
)
REM ///遅延環境変数に対応_End/// -----2010/04/12-----
REM ///開発Configファイルコピー処理追加_End/// -----2010/01/19-------

REM ///ファイルリネーム及び、デリート自動化に伴う処理追加/// -----2009/06/24 追加_Start-----
SET ERRFLG=0
IF %BUILD_NO%==1 CALL :PROC_ReName_x64
IF %BUILD_NO%==2 CALL :PROC_ReName_AnyCPU
REM ///ファイルリネーム及び、デリート自動化に伴う処理追加/// -----2009/06/24 追加_End-------

@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************
@ECHO  //ビルドスクリプト処理正常終了 // >> %LOG_DIR%\%LOGFILE%
@ECHO %date% >> %LOG_DIR%\%LOGFILE%
@ECHO %time% >> %LOG_DIR%\%LOGFILE%
@ECHO  //ビルドスクリプト処理正常終了 //
REM //終了時刻表示
@ECHO %date% 
@ECHO %time%
@ECHO ************************************************************************** >> %LOG_DIR%\%LOGFILE%
@ECHO **************************************************************************


GOTO END

REM ------------------------------------- 
REM サブモジュール
REM ------------------------------------- 
REM //ビルドVerNo.フォルダチェック
:PROC_APPVERSION_CHECK
IF EXIST %1 (
rem 2019/02/22 CHK Start
rem @ECHO  ビルドVerNo.が重複しています >> %LOG_DIR%\%LOGFILE%
@ECHO %date% %time% ビルドVerNo.が重複しています >> %LOG_DIR%\%LOGFILE%
rem 2019/02/22 CHK End
SET APPVERSION=Nothing
rem 2019/02/22 DEL Start
rem GOTO VerInput_Return
rem 2019/02/22 DEL End
EXIT 1
)
GOTO :EOF

REM //フォルダコピー処理
:PROC_COPY
@ECHO %1 を %2 へコピー >> %LOG_DIR%\%LOGFILE%
@ECHO %1 を %2 へコピー
XCOPY /S /E /V /H /Q /Y /G /R %1 %2 >> %LOG_DIR%\%LOGFILE%
IF ERRORLEVEL 1 (
SET TOTAL_ERRFLG=1
@ECHO コピー_NG >> %LOG_DIR%\%LOGFILE%
@ECHO コピー_NG
SET ERRFLG=1
)
GOTO :EOF

REM //ファイル削除処理
:PROC_FILEDEL
@ECHO %1 を削除 >> %LOG_DIR%\%LOGFILE%
@ECHO %1 を削除
DEL /F %1  >> %LOG_DIR%\%LOGFILE%
IF EXIST %1 (
SET TOTAL_ERRFLG=1
@ECHO ファイル削除_NG >> %LOG_DIR%\%LOGFILE%
@ECHO ファイル削除_NG
SET ERRFLG=1
)
GOTO :EOF

REM //フォルダ削除処理
:PROC_DEL
@ECHO %1 を削除 >> %LOG_DIR%\%LOGFILE%
@ECHO %1 を削除
RMDIR /S /Q %1  >> %LOG_DIR%\%LOGFILE%
IF EXIST %1 (
SET TOTAL_ERRFLG=1
@ECHO フォルダ削除_NG >> %LOG_DIR%\%LOGFILE%
@ECHO フォルダ削除_NG
SET ERRFLG=1
)
GOTO :EOF

REM 2017/03/28 基盤更改(全体) DEL Start
REM //リリーストリガファイル作成処理
REM :PROC_RLSTRG
REM @ECHO %Temp_InstallImage%\%1 へ作成 >> %LOG_DIR%\%LOGFILE%
REM @ECHO %Temp_InstallImage%\%1 へ作成
REM @ECHO %DATE% > %Temp_InstallImage%\%1
REM IF NOT EXIST %Temp_InstallImage%\%1 (
REM @ECHO 作成_NG >> %LOG_DIR%\%LOGFILE%
REM @ECHO 作成_NG
REM SET ERRFLG=1
REM )
REM GOTO :EOF
REM 2017/03/28 基盤更改(全体) DEL End

REM //ソリューションビルド処理
:PROC_Build
SET BAT_ERRFLG=0
@ECHO %1 ビルド >> %LOG_DIR%\%LOGFILE%
@ECHO %1 ビルド
CALL %~dp0\Sub_Module\Build.bat %1 %LOG_DIR% %BUILDMODE%
IF %BAT_ERRFLG% == 1 (
SET TOTAL_ERRFLG=1
@ECHO %1 ビルド_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %1 ビルド_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO 下記の作業を行い、完了後何かキーを押して次の処理に進んでください
@ECHO 【作業内容】
@ECHO ■ソリューション単位での手動ビルド
@ECHO １．%SOLUTION_DIR%\bin\ の中を削除してください
@ECHO 　　※Lib69A_Web.slnの場合は、%SOLUTION_DIR%\Web\bin フォルダも削除してください
@ECHO ２．%SOLUTION_DIR%\obj をフォルダ毎削除してください
@ECHO ３．%SOLUTION_DIR%\bin_Refer\ を %SOLUTION_DIR%\bin\ にコピーしてください
@ECHO ４．%1 を開き、ビルドを行ってください
@ECHO ５．%SOLUTION_DIR%\bin\ を %SOLUTION_DIR%\bin_Refer\ にコピーしてください
PAUSE
) ELSE (
@ECHO %1 ビルド_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %1 ビルド_OK
)
GOTO :EOF

REM //WEBプリコンパイル処理
:PROC_PRECOMPILE
@ECHO %1 フォルダプリコンパイル >> %LOG_DIR%\%LOGFILE%
@ECHO %1 フォルダプリコンパイル
CALL %~dp0\Sub_Module\BuildWeb.bat %1 %LOG_DIR%
IF %BAT_ERRFLG% == 1 (
SET TOTAL_ERRFLG=1
@ECHO %1 フォルダプリコンパイル_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %1 フォルダプリコンパイル_NG
@ECHO ---- ＳＣＲＩＰＴ ＥＲＲＯＲ ！！！！ ----
@ECHO 下記の作業を行い、完了後何かキーを押して次の処理に進んでください
@ECHO 【作業内容】
@ECHO １．SDKコマンドプロンプトから手動でプリコンパイルを行ってください
@ECHO     プリコンパイルコマンド：aspnet_compiler -p %1 -v /Web_Temp %SOLUTION_DIR%\Web_Temp
@ECHO ２．プリコンパイル完了後、%1を、%1_BACKUPへリネームしてください
@ECHO ３．%SOLUTION_DIR%\Web_Tempを、%1へリネームしてください
PAUSE
) ELSE (
@ECHO %1 フォルダプリコンパイル_OK >> %LOG_DIR%\%LOGFILE%
@ECHO %1 フォルダプリコンパイル_OK
)
GOTO :EOF

REM //InstallImageファイル一覧作成処理
:PROC_IstImgOUTPUT
@ECHO %1 ファイル一覧作成 >> %LOG_DIR%\%LOGFILE%
@ECHO %1 ファイル一覧作成
CALL %~dp0\Sub_Module\Install_ImageOUTPUT.vbs %1 >> %LOG_DIR%\%LOGFILE%
IF ERRORLEVEL 1 (
SET TOTAL_ERRFLG=1
@ECHO %1ファイル一覧作成_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %1ファイル一覧作成_NG
SET ERRFLG=1
)
GOTO :EOF

REM ///ファイルリネーム及び、デリート自動化に伴う処理追加/// -----2009/06/24 追加_Start-----
REM ///ReName処理(x64)///
:PROC_ReName_x64
SET ERR_FLG=0

@ECHO ===================================
@ECHO リネーム処理を開始します。 >> %LOG_DIR%\%LOGFILE%
@ECHO (x64)版のリネーム処理を開始します
@ECHO ===================================

RENAME %LOG_DIR% %APPVERSION%"(x64)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM // LOGFILEの変数セット
SET LOG_DIR=%LOG_DIR%(x64)
RENAME %SOURCE_BACKUP% %APPVERSION%"(x64)"
IF ERRORLEVEL 1 SET ERR_FLG=1
RENAME %RTB_InstallImage% %APPVERSION%"_RTB(x64)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16削除_START-----
REM RENAME %SOLUTION_DIR% SOLUTION"_"%APPVERSION%"(x64)"
REM IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16削除_END-----
REM ///エラーがあった場合、Rename_NG処理へ///
IF %ERR_FLG%==1 GOTO :Rename_NG
@ECHO x64版 リネーム_OK >> %LOG_DIR%\%LOGFILE%
@ECHO x64版 リネーム_OK

REM -----2015/01/16追加_START-----
REM /// 不要なSOLUTIONフォルダの削除 ///
IF EXIST %SOLUTION_DIR% (
	RMDIR /s /q %SOLUTION_DIR%
	IF ERRORLEVEL 1 CALL :SOL_DEL_ERR
) ELSE (
	CALL :SOL_NOTEXIST
)
REM -----2015/01/16追加_END-----
GOTO :START_SAV


REM ///Rename処理(AnyCPU)///
:PROC_ReName_AnyCPU
SET ERR_FLG=0

@ECHO ======================================
@ECHO リネーム処理を開始します。 >> %LOG_DIR%\%LOGFILE%
@ECHO (AnyCPU)版のリネーム処理を開始します。
@ECHO ======================================

REM /// 不要ファイルの削除 ///
IF EXIST %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll (
	DEL   %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll
	IF ERRORLEVEL 1 CALL :DEL_ERR
) ELSE (
	CALL :NOTEXIST
)

REM /// x86版ファイルの置換 ///
COPY /Y %SOURCE_BACKUP%\Source\Others\bin_Refer"(x86)"\jp.co.fit.vfreport.SvfrClient.dll %SOURCE_BACKUP%\Release\
IF ERRORLEVEL 1 CALL :COPY_ERR
REM //2015/10/19 A00855 ADD START
COPY /Y C:\CC01"(devx86)"\CC01.dll %SOURCE_BACKUP%\Release\
IF ERRORLEVEL 1 CALL :COPY_ERR2
REM //2015/10/19 A00855 ADD END

RENAME %LOG_DIR% %APPVERSION%"(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM /// LOGFILEの変数セット ///
SET LOG_DIR=%LOG_DIR%(AnyCPU)
RENAME %SOURCE_BACKUP%\Release "Release(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
RENAME %SOURCE_BACKUP% %APPVERSION%"(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
RENAME %RTB_InstallImage% %APPVERSION%"_RTB(AnyCPU)"
IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16削除_START-----
REM RENAME %SOLUTION_DIR% SOLUTION"_"%APPVERSION%"(AnyCPU)"
REM IF ERRORLEVEL 1 SET ERR_FLG=1
REM -----2015/01/16削除_END-----
REM ///エラーがあった場合、Rename_NG処理へ///
IF %ERR_FLG%==1 GOTO :Rename_NG
@ECHO ====================
@ECHO AnyCPU版 リネーム_OK >> %LOG_DIR%\%LOGFILE%
@ECHO AnyCPU版 リネーム_OK
@ECHO ====================

REM -----2015/01/16追加_START-----
REM /// 不要なSOLUTIONフォルダの削除 ///
IF EXIST %SOLUTION_DIR% (
	RMDIR /s /q %SOLUTION_DIR%
	IF ERRORLEVEL 1 CALL :SOL_DEL_ERR
) ELSE (
	CALL :SOL_NOTEXIST
)
REM -----2015/01/16追加_END-----
GOTO :START_SAV



:START_SAV
REM -----2015/01/16削除_START-----
REM -----2009/11/09追加_START-----
REM //"Symantec AntiVirus サービス"開始
REM @ECHO "Symantec AntiVirus サービス"を開始します。
REM net start "Symantec AntiVirus" >> %LOG_DIR%\%LOGFILE%
REM IF ERRORLEVEL 1 (
REM 	@ECHO "Symantec AntiVirus サービス"を開始出来ませんでした。
REM 	@ECHO "Symantec AntiVirus サービス"を手動で開始後、何かキーを押して先に進んでください。
REM 	PAUSE
REM ) else (
REM 	@ECHO "Symantec AntiVirus サービス"は正常に開始されました。
REM )
REM -----2009/11/09追加_END-----
REM -----2015/01/16削除_END-----

GOTO :EOF

REM ///Rename_NG処理///
:Rename_NG
@ECHO ==================================
@ECHO リネーム_処理NG >> %LOG_DIR%\%LOGFILE%
@ECHO リネーム_処理NG
@ECHO 手動でリネームを実施してください。
@ECHO ==================================
PAUSE
EXIT

REM ///FILEが存在しない場合のエラー処理///
:NOTEXIST
@ECHO ======================================================================
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dllが存在しません >> %LOG_DIR%\%LOGFILE%
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dllが存在しません
@ECHO Microsoft.Web.UI.WebControls.dll削除処理をスルーします >> %LOG_DIR%\%LOGFILE%
@ECHO Microsoft.Web.UI.WebControls.dll削除処理をスルーします
@ECHO ======================================================================
PAUSE
GOTO :EOF

REM ///DEL_ERR処理///
:DEL_ERR
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll削除_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %SOURCE_BACKUP%\Release\Microsoft.Web.UI.WebControls.dll削除_NG
@ECHO 手動でMicrosoft.Web.UI.WebControls.dll削除後Enterを押下して、次の処理を実行してください。
PAUSE
GOTO :EOF

REM ///COPY_ERR処理///
:COPY_ERR
@ECHO jp.co.fit.vfreport.SvfrClient.dll置換_NG >> %LOG_DIR%\%LOGFILE%
@ECHO jp.co.fit.vfreport.SvfrClient.dll置換_NG
@ECHO 手動でjp.co.fit.vfreport.SvfrClient.dllを"(AnyCPU)"版に置換後Enterを押下して、次の処理を実行してください
PAUSE
GOTO :EOF

REM //2015/10/19 A00855 ADD START
REM ///COPY_ERR2処理///
:COPY_ERR2
@ECHO CC01.dll置換_NG >> %LOG_DIR%\%LOGFILE%
@ECHO CC01.dll置換_NG
@ECHO 手動でCC01.dllを"(AnyCPU)"版に置換後Enterを押下して、次の処理を実行してください
PAUSE
GOTO :EOF
REM //2015/10/19 A00855 ADD END
REM ///ファイルリネーム及び、デリート自動化に伴う処理追加/// -----2009/06/24 追加_End-------

REM -----2015/01/16追加_START-----
REM ///SOLUTIONフォルダが存在しない場合のエラー処理///
:SOL_NOTEXIST
@ECHO ======================================================================
@ECHO %SOLUTION_DIR%フォルダが存在しません >> %LOG_DIR%\%LOGFILE%
@ECHO %SOLUTION_DIR%フォルダが存在しません
@ECHO %SOLUTION_DIR%フォルダ削除処理をスキップします >> %LOG_DIR%\%LOGFILE%
@ECHO %SOLUTION_DIR%フォルダ削除処理をスキップします
@ECHO ======================================================================
PAUSE
GOTO :EOF

REM ///SOL_DEL_ERR処理///
:SOL_DEL_ERR
@ECHO %SOLUTION_DIR%フォルダ削除_NG >> %LOG_DIR%\%LOGFILE%
@ECHO %SOLUTION_DIR%フォルダ削除_NG
@ECHO 手動で%SOLUTION_DIR%フォルダ削除後Enterを押下して、次の処理を実行してください。
PAUSE
GOTO :EOF
REM -----2015/01/16追加_END-----

:END
