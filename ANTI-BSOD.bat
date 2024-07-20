@echo off
:: Deteksi apakah berjalan di Administrator atau tidak
>nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system" && (
    goto :continue
) || (
    echo Whopp bentar bang, ini harus Run As administrator dulu lah ...
    pause
    exit /b
)

:continue
set fileToDelete=C:\Windows\System32\drivers\CrowdStrike\C-00000291-00000000-00000039.sys

if exist "%fileToDelete%" (
    del "%fileToDelete%"
    echo FILE DELETED AND READY TO RESTART.
    echo DID YOU WANT TO RESTART NOW? (Y/N)

    choice /C YN /T 10 /D N

    if errorlevel 2 (
        echo Restart canceled. The scene will be closed.
    ) else (
        echo Restarting in 10 seconds...
        
        for /l %%i in (1, 1, 10) do (
            echo Count: %%i
            timeout /T 1 /nobreak >nul
        )
        
        shutdown /r /t 0
    )
) else (
    echo File not found.
)

pause
