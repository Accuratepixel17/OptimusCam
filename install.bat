@echo off
echo ========================================================
echo Installing OptimusCam (Level_3 Computational Camera)
echo ========================================================
set ADB="%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe"

echo Checking connected devices...
%ADB% devices

echo.
echo Installing APK to device...
%ADB% install -r -d "%~dp0app\build\outputs\apk\debug\app-debug.apk"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Launching OptimusCam...
    %ADB% shell am start -n com.optimus.cam/.MainActivity
) else (
    echo.
    echo Installation failed or no device found.
    echo Please make sure USB Debugging is ON and phone is plugged in.
)

pause
