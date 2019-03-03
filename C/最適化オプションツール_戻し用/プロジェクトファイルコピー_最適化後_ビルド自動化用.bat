@ECHO OFF
REM ----------------------------------------------------
REM モジュール名　：プロジェクトファイルコピー_最適化後.bat
REM 機能　　　　　：C:\最適化オプションツール\10_最適化
REM 　　　　　　　　フォルダのvbprojファイルを全て
REM 　　　　　　　　C:\SOLUTIONフォルダに上書きコピーする。　　　　　　　　
REM ----------------------------------------------------

REM ----------------------------------------------------
REM 変数セット
REM ----------------------------------------------------

SET SOLUTION_DIR=C:\SOLUTION
SET SAITEKI_AFTER_DIR=C:\最適化オプションツール_戻し用\10_最適化

REM ----------------------------------------------------
REM チェック
REM ----------------------------------------------------

:CHECK_PROC

REM コピー元フォルダ有無チェック(無ければエラー)

IF NOT EXIST %SAITEKI_AFTER_DIR% (
@ECHO  ERROR : **%SAITEKI_AFTER_DIR%が存在しません**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 1
REM 19/03/01 CHG End
)

REM コピー対象VBPROJファイル有無チェック(無ければエラー)

IF NOT EXIST %SAITEKI_AFTER_DIR%\*.vbproj (
@ECHO  ERROR : **プロジェクトファイルが存在しません**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 2
REM 19/03/01 CHG End
)

REM コピー先フォルダ有無チェック(無ければエラー)

IF NOT EXIST %SOLUTION_DIR% (
@ECHO  ERROR : **%SOLUTION_DIR%フォルダが存在しません**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 3
REM 19/03/01 CHG End
)

REM ----------------------------------------------------
REM メイン処理(コピー)
REM ----------------------------------------------------

:MEIN_PROC
REM 19/03/01 CHG Start
REM COPY /-Y %SAITEKI_AFTER_DIR%\*.vbproj %SOLUTION_DIR%
COPY /Y %SAITEKI_AFTER_DIR%\*.vbproj %SOLUTION_DIR%
REM 19/03/01 CHG End
@ECHO **コピー正常終了** エンターを押して完了してください
REM 19/03/01 DEL Start
REM pause
REM 19/03/01 DEL End

GOTO :EOF

:EOF