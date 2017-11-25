@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
if   "%1"=="/?" GOTO :DO_HELP
if /I "%1"=="-h" GOTO :DO_HELP
if /I "%1"=="-v" GOTO :DO_REG_INFO
GOTO :DO_RELEASE_VER

:DO_HELP
echo Usage: %0 [ -v ^| -h ^| ^/? ]
echo           Default: Returns the installed DotNet 4 version.
echo -v         Verbose: Returns the all the DotNet 4 registry settings.
echo -h or /?   This help screen.
echo see: https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed
echo.
echo Release Number Ver.   Installations
echo -------------- -----  -------------------------------------------------
echo 460805 0x70805 4.7    All other Windows OS versions
echo 460798 0x707fe 4.7    On Windows 10 Creaters Update
echo 394806 0x60636 4.6.2  All other Windows OS versions
echo 394802 0x60632 4.6.2  On Windows 10 Anniversary Update
echo 394271 0x6041F 4.6.1  On all other Windows OS versions
echo 394254 0x6040E 4.6.1  On Windows 10
echo 393297 0x60051 4.6    On all other Windows OS versions
echo 393295 0x6004F 4.6    With Windows 10
echo 379893 0x5CBF5 4.5.2
echo 378758 0x5C786 4.5.1  On Windows 8, Windows 7 SP1, or Windows Vista SP2
echo 378675 0x5C733 4.5.1  With Windows 8.1
echo 378389 0x5C615 4.5
GOTO :END

:DO_REG_INFO
FOR /F "skip=2 tokens=1-3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" ') do @echo %%i = %%k
GOTO :END

:DO_RELEASE_VER
FOR /F "skip=2 tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release 2^>^&1') do @set RELEASE=%%i

if "%RELEASE%" ==  "system"  @echo 4.0&    GOTO :END

if "%RELEASE%" GTR "0x70805" @echo 4.7+&   GOTO :END
if "%RELEASE%" GEQ "0x707fe" @echo 4.7&    GOTO :END
if "%RELEASE%" GEQ "0x60632" @echo 4.6.2&  GOTO :END
if "%RELEASE%" GEQ "0x6040e" @echo 4.6.1&  GOTO :END
if "%RELEASE%" GEQ "0x6004f" @echo 4.6&    GOTO :END
if "%RELEASE%" GEQ "0x5cbf5" @echo 4.5.2&  GOTO :END
if "%RELEASE%" GEQ "0x5c733" @echo 4.5.1&  GOTO :END
if "%RELEASE%" GEQ "0x5c615" @echo 4.5&    GOTO :END
@echo 4.0
:END

