@echo off

set SevenZCMD=7za64.exe
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto Main
set SevenZCMD=7za32.exe


:Main

set tmpdir=__tmp__
set workdir=live_injection_7ed136ec_7a61_4b54_adc3_ae494d5106ea

if exist %tmpdir%\ rd /s /Q %tmpdir%
if exist live_injection.tar.gz del /s /Q live_injection.tar.gz >nul

md %tmpdir%\%workdir%\distro

echo packing sysroot ...
internal\%SevenZCMD% a -ttar -so sysroot.tar sysroot | internal\%SevenZCMD% a -si %tmpdir%\%workdir%\sysroot.tar.gz >nul



cd %tmpdir%
copy /y ..\internal\hook.sh  %workdir%\  >nul
xcopy /s /e /y ..\internal\distro  %workdir%\distro\  >nul

echo packing live_injection ...
..\internal\%SevenZCMD% a -ttar -so live_injection.tar %workdir% | ..\internal\%SevenZCMD% a -si ..\live_injection.tar.gz >nul
cd .. 

if exist %tmpdir%\ rd /s /Q %tmpdir%

echo.
echo.
if exist live_injection.tar.gz (
    echo ===============================
    echo ========== SUCCESS ============
    echo ===============================
) else (
    echo ===============================
    echo =========== FAILED ============
    echo ===============================
)
echo.
echo.

pause
