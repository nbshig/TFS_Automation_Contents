@ECHO OFF
REM ----------------------------------------------------
REM モジュール名　：プロジェクトファイルコピー.bat
REM 機能　　　　　：C:\SOLUTIONフォルダのvbprojファイルを
REM 　　　　　　　　全てC:\最適化オプションツール\00_proj
REM 　　　　　　　　フォルダにコピーする。
REM ----------------------------------------------------

REM ----------------------------------------------------
REM 変数セット
REM ----------------------------------------------------

SET SOLUTION_DIR=C:\SOLUTION
SET SAITEKI_DIR=C:\最適化オプションツール_戻し用\00_proj

REM ----------------------------------------------------
REM チェック
REM ----------------------------------------------------

:CHECK_PROC

REM コピー元フォルダ有無チェック(無ければエラー)

IF NOT EXIST %SOLUTION_DIR% (
@ECHO  ERROR : **%SOLUTION_DIR%が存在しません**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 1
REM 19/03/01 CHG End
)

REM コピー対象VBPROJファイル有無チェック(無ければエラー)

IF NOT EXIST %SOLUTION_DIR%\*.vbproj (
@ECHO  ERROR : **プロジェクトファイルが存在しません**
REM 19/03/01 CHG Start
REM PAUSE
REM GOTO :EOF
Exit 2
REM 19/03/01 CHG End
)

REM コピー先フォルダ有無チェック(無ければエラー)

IF NOT EXIST %SAITEKI_DIR% (
@ECHO  ERROR : **%SAITEKI_DIR%フォルダが存在しません**
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

COPY /-Y %SOLUTION_DIR%\*.vbproj %SAITEKI_DIR%

REM 19/03/01 CHG Start
REM @ECHO **コピー正常終了** エンターを押して完了してください
REM PAUSE
@ECHO **コピー正常終了**
REM 19/03/01 CHG End
GOTO :EOF

:EOF