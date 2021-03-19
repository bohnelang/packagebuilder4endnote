@echo off 

REM 
REM -- Set your properties here --
REM

SET XSFX="http://www.redi-bw.de/links/unihd" 
SET XFFTOPENURLRESOLVER="http://www.umm.uni-heidelberg.de/apps/edv/redi.php" 
SET XFFTAUTHENTICATEURL="http://www.umm.uni-heidelberg.de/ezproxy/login.php?url=login" 

REM ------------------------------------------------------------------------------------


SET CALLING_PATH=%CD%

IF EXIST Builder.exe Builder.exe

