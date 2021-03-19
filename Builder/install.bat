@ECHO off 
CLS 

call settings.bat 

SETLOCAL
PUSHD "%~dp0"
ECHO. 
ECHO. 



REM ADD THE MSI FILES IN ORDER OF OLDEST TO NEWEST
FOR %%a IN ("EN*.msi") DO (IF EXIST "%%a" SET MSI=%%a)


REM MSI WILL == "" IF THERE ARE NONE OF THOSE MSI FILES IN THE FOLDER
IF "%MSI%" NEQ "" GOTO EXECINSTALL
ECHO.
ECHO  Fehler: Es wurde kein MSI Installer in diesem Verzeichnis gefunden. 
ECHO.
PAUSE
GOTO END

:EXECINSTALL
ECHO.
ECHO  Installation von "%MSI%" wird gestartet.
SET SFX=%XFSX%
msiexec /i %MSI% TRANSFORMS="transform.mst" INSTALLALLCONTENTFILES="yes" FFTUSEISILINKS="T" FFTUSEPUBMED="T" FFTUSEDOI="T" FFTUSEOPENURL="T" FFTOPENURLRESOLVER=%XFFTOPENURLRESOLVER% FFTAUTHENTICATEURL=%XFFTAUTHENTICATEURL%
ECHO  Fertig. 
ECHO. 
ECHO. 
﻿
REM ------------------------------------------------------------------------------------
REM Online Handbuch
REM Wenn Sie diese Batchdatei fuer eine unbeaufsichtigte Installationen nutzen moechten, 
REM koennen sie den Aufruf der URL mit einem beliebigen Parameter unterdruecken. 
REM Der Aufruf lautet dann bspw.: "\_____INSTALL_ENDNOTE_CLICK_HERE_____.bat quiet"
REM ------------------------------------------------------------------------------------

REM Any parameter => AskForFB => No
IF [%1]==[] (
SET AskForFB=1
) ELSE (
SET AskForFB=0
)

REM Show Flipbook 

IF %AskForFB% EQU 1 START /b /separate "Endnote online" "https://www.endnote.de/" 
REM ------------------------------------------------------------------------------------
ECHO. 

:END 
POPD 
