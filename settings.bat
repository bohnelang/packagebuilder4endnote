@echo off 

REM 
REM -- Set your properties here --
REM

SET XSFX=" " 
SET XFFTOPENURLRESOLVER="" 
SET XFFTAUTHENTICATEURL="" 

REM ------------------------------------------------------------------------------------


SET CALLING_PATH=%CD%

IF EXIST Builder.exe Builder.exe

exit
