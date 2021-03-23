# Package builder for EndNote to deliver an EndNote MS-Window's msi package with predefined 'FindFullText'  URLs

**Keywords**: EndNote, Library, openURL, link resolver, Windows, Installation, FindFullText

## For whom is this of interest?
**For libraries** that want to distribute EndNote to their users with predefined 'FindFullText' settings. 

![FindFullText](https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/doc/builder0.jpg)


## What does this builder.exe program do?
This builder.exe creates a new self-extracting archive that contains a script that sets your library 'FindFullText' settings (link resolver and EZProxy) during EndNote installation.

After installation at user's computer the "FindFullText" of EndNote will work out-of-the-box. No more instructions by PDF documents or web site are necessary. 



## How to use?

### Easy solution:

1. Create a new folder
2. **Copy the following files** into this new folder: 
	* **Your Endnote msi** file (The name of this file has to start with EN and ends with .msi like EN20Inst.msi. This is very important!)
	* **Your License.dat** file (the attached file of this repository is invalid and is ment to illutrate the syntax of the file only.)
	* This **Builder.exe** program (https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/Builder.exe)
	* This **settings.bat** script by  (https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/settings.bat) and save this page as settings.bat in the same directory (maybe by right-click of your mouse).  Have a look a the settings section below. If you are in doubt about the correct URL values, do not hesitate to ask your library IT support.
	
3. **Edit the file settings.bat** and change the values of the link resolver setting to those of your environment
4. **Double-click 'settings.bat'**
5. (If any AntiVirus program blocks the writing to disc, please allow builder.exe to write the new file.) 
6. Wait until the programs are finished. (See second image below)
7. A **new file should appear** in the same folder (like EN20Inst.msi.exe). This is your new EndNote installation package.
8. Test this installation file before you distribute it to the library users.

![Create1](https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/doc/builder1.jpg)

![Create2](https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/doc/builder2.jpg)

![Create3](https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/doc/builder3.jpg)

### Comprehensive solution: 
These single steps are nearly the same as in the run_builder.bat script. 
1. Create a new directory XYZ
2. Downlaod the programs 7z.exe and ChilkatZipSE.exe 
3. Edit settings.bat and change the values of the link resolver setting to those of your environment
4. Copy the files  install.bat, settings.bat, transform.mst, licence.dat, Endnote_Icon_128.ico into this XYZ folder
5. Create a ZIP-file named XYZ.zip of this new directory (e.g. by the 7z.exe archiver program)
6. Create a self-extracting archive by execution ChilkatZipSE.exe -autotemp -run install.bat -u "EXTRCTSFX_App4hvhU1Aof" -autoExit -nowait -i Endnote_Icon_128.ico -sm -sp -fn XYZ.zip on commandline (OR use the GUI of ChilkatZipSE)
7. Test it.

#### How does this working?
The new self-extracting archive contains the following files:
* install.bat
* settings.bat
* transform.mst
* license.dat
* Original Endnote.msi file 

After double-clicking, these files are extracted into a temporary folder and the install.bat script is started. This script calls the settings.bat script and calls the msiexec command which executes the settings during installation of EndNote.

```
msiexec /i %MSI% TRANSFORMS="transform.mst" INSTALLALLCONTENTFILES="yes" FFTUSEISILINKS="T" FFTUSEPUBMED="T" FFTUSEDOI="T" FFTUSEOPENURL="T" FFTOPENURLRESOLVER=%XFFTOPENURLRESOLVER% FFTAUTHENTICATEURL=%XFFTAUTHENTICATEURL%	
```



### setting.bat
The codelines below show your library settings. We use the ReDI link resolver of UB Freiburg and EZProxy for eJournal remote access. 

Our settings:
```
SET XSFX="https://www.redi-bw.de/links/unihd" 

SET XFFTOPENURLRESOLVER="https://www.umm.uni-heidelberg.de/apps/edv/redi.php" 

SET XFFTAUTHENTICATEURL="https://www.umm.uni-heidelberg.de/ezproxy/login.php?url=login" 
```


SFX example:
```
SET XSFX="https://sfx.foo.com/sfx_foo" 

SET XFFTOPENURLRESOLVER="https://sfx.foo.com/sfx_foo?" 

SET XFFTAUTHENTICATEURL="https://login.ezproxy.foo.com/login" 
```


SFX and EZPropxy chained (The EZProxy expects this syntax):
```
SET XSFX="http://sfx.foo.com/sfx_foo" 

SET XFFTOPENURLRESOLVER="https://login.ezproxy.foo.com/login?url=http://sfx.foo.com/sfx_foo?" 

SET XFFTAUTHENTICATEURL="https://login.ezproxy.foo.com/login" 
```

### Automatisation of provider selection by redi.php script
For our environment I develop a redi-php script: This redi.php (https://raw.githubusercontent.com/bohnelang/packagebuilder4endnote/master/doc/redi_ma.php)script fetches the ReDI result page, at which the user can select the fulltext provider. Endnote cannot click or select by itself and thus this script does a dump selection: always select first or always select last. Maybe if your library is ReDI linkresolver subscriber you can modify it for your use. 

## Links and Licenses

* 7z.exe: Sebastian Riehm, Sören Finster. Licence: GNU LGPL (https://www.gnu.org/licenses/lgpl-3.0.de.html), Homepage and source page: https://www.7-zip.org
*  ChilkatZipSE.exe, Chilkat Software,  Licence: CC3.0 (https://creativecommons.org/licenses/by/3.0/), Homepage: https://www.chilkatsoft.com/ChilkatSfx.asp
*  EndNote: https://endnote.com/ 
*  ReDI (Regionale Datenbank-Information) von der UB-Freiburg: http://www-s.redi-bw.de/links/?rl_site=unifr&rl_action=services

## Acknowledgment
*  Mathias Krummheuer, Frankfurt, 2013, for providing the transform.mst  and install.bat file. 