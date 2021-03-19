ECHO off 
CLS 
setlocal

for %%a in ("%CALLING_PATH%\*.msi") do (
	echo %%a	
	echo %tmp%
	echo %CD% 
		
	if not exist %CD%\ENtmp  mkdir   	%CD%\ENtmp
			 		
	copy /Y %%a 						%CD%\ENtmp
	
	copy /Y %CALLING_PATH%\settings.bat %CD%\ENtmp
	copy /Y %CALLING_PATH%\license.dat 	%CD%\ENtmp
	
	copy /Y %CD%\Builder\install.bat 	%CD%\ENtmp
	copy /Y %CD%\Builder\transform.mst	%CD%\ENtmp

	if not exist %CD%\ENW.zip (
	
		cd %CD%\Builder\
		
		7z.exe a  -r "%CD%\ENtmp.zip" "%CD%\ENtmp\*"	
		
		ChilkatZipSE.exe -autotemp -run install.bat -u "EXTRCTSFX_App4hvhU1Aof" -autoExit -nowait -i %CD%\Builder\Endnote_Icon_128.ico -sm -sp -fn %CD%\ENtmp.zip
			
			
		echo 	"%CD%\ENtmp.EXE"
		
		if exist %CD%\ENtmp.EXE  (
			copy /Y "%CD%\ENtmp.EXE" "%%a.exe"	
		)
		
	)

 rem pause 
)