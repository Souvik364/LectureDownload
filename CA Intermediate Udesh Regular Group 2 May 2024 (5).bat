@echo off
:: Enable ANSI escape sequences
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

setlocal enabledelayedexpansion

:: Environment Variables
set "REQUIRED_EXES=curl.exe N_m3u8DL-RE.exe ffmpeg.exe"
set "MISSING_EXES="
set "DOWNLOAD_DIR=C:\PWJarvis"
set "CURRENT_DIR=%CD%"

:: Check Required Executables
echo !ESC![33m[STATUS]!ESC![0m Checking system requirements...
echo -----------------------------------------------------------
for %%E in (%REQUIRED_EXES%) do (
    where %%E >nul 2>&1
    if !errorlevel! neq 0 (
        echo !ESC![31m[MISSING]!ESC![0m %%E
        set "MISSING_EXES=!MISSING_EXES! %%E"
    ) else (
        echo !ESC![32m[FOUND]!ESC![0m %%E
    )
)

:: Setup Environment if Needed
if not "!MISSING_EXES!"=="" (
    echo.
    echo !ESC![33m[ACTION]!ESC![0m Setting up missing components...
    if not exist "%DOWNLOAD_DIR%" (
        mkdir "%DOWNLOAD_DIR%"
        echo !ESC![32m[CREATED]!ESC![0m %DOWNLOAD_DIR%
    )
    pushd "%CURRENT_DIR%"
    cd /d "%DOWNLOAD_DIR%"
    for %%E in (%MISSING_EXES%) do (
        echo !ESC![33m[DOWNLOADING]!ESC![0m %%E
        set "exe=%%E"
        set "base_url=https://github.com/mrotaku12/files/raw/refs/heads/main/"
        set "url=!base_url!%%E"
        
        if "!exe!"=="curl.exe" (
            :: Download curl using PowerShell
            powershell -Command "Invoke-WebRequest -Uri '!url!' -OutFile '!exe!'"
        ) else (
            :: Check if curl is available
            where curl.exe >nul 2>&1
            if !errorlevel! equ 0 (
                :: Use curl to download the executable
                curl -L "!url!" -o "!exe!"
            ) else (
                :: Fallback to PowerShell
                powershell -Command "Invoke-WebRequest -Uri '!url!' -OutFile '!exe!'"
            )
        )
        if !errorlevel! equ 0 (
            echo !ESC![32m[SUCCESS]!ESC![0m %%E
        ) else (
            echo !ESC![31m[ERROR]!ESC![0m Failed to download %%E
        )
    )
    echo.
    echo !ESC![33m[STATUS]!ESC![0m Updating system path...
    for /f "tokens=2*" %%A in ('reg query HKCU\Environment /v PATH 2^>nul') do set "CURRENT_USER_PATH=%%B"
    echo !CURRENT_USER_PATH! | find /i "%DOWNLOAD_DIR%" >nul
    if !errorlevel! neq 0 (
        if defined CURRENT_USER_PATH (
            reg add HKCU\Environment /v PATH /t REG_EXPAND_SZ /d "%DOWNLOAD_DIR%;!CURRENT_USER_PATH!" /f
        ) else (
            reg add HKCU\Environment /v PATH /t REG_EXPAND_SZ /d "%DOWNLOAD_DIR%" /f
        )
        powershell -Command "[Environment]::SetEnvironmentVariable('PATH', [Environment]::GetEnvironmentVariable('PATH', 'User'), 'User')"
        echo !ESC![32m[SUCCESS]!ESC![0m Path updated - restart may be required
    )
    set "PATH=%DOWNLOAD_DIR%;%PATH%"
    popd
    echo.
    echo !ESC![32m[READY]!ESC![0m Environment setup complete
)

:: Check and Enable Long Path Support
echo !ESC![33m[STATUS]!ESC![0m Checking long path support...
reg query "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled | find "0x1" >nul
if !errorlevel! equ 0 (
    echo !ESC![32m[ENABLED]!ESC![0m Long path support is already active
) else (
    echo !ESC![33m[ACTION]!ESC![0m Enabling long path support...
    powershell -Command "Start-Process reg -ArgumentList 'add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f' -Verb runAs"
    echo !ESC![33m[NOTE]!ESC![0m System restart required for long path support to take effect
    echo.
    echo !ESC![33m[ACTION]!ESC![0m Press any key to restart your PC...
    pause >nul
    shutdown /r /t 0
    exit
)

cls
set "batch=CA Intermediate Udesh Regular Group 2 May 2024"
mkdir "%batch%" 2>nul
cd /d "%batch%"
set "BATCH_ROOT=%CD%"
echo.
echo !ESC![33m[PROGRESS]!ESC![0m Working in: %batch%
echo -----------------------------------------------------------

echo.
echo -----------------------------------------------------------
echo !ESC![34m[SUBJECT]!ESC![0m Cost and Management Accounting
echo -----------------------------------------------------------
mkdir "Cost and Management Accounting" 2>nul
cd /d "Cost and Management Accounting"

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Cost Sheet
echo -----------------------------------------------------------
mkdir "Cost Sheet" 2>nul
cd /d "Cost Sheet"
mkdir "Lectures" 2>nul
set "lecture_0=Cost Sheet 10 - Concept and Questions -Part 09"

echo.
if not exist "Lectures\!lecture_0!.mp4" (
    title Downloading: !lecture_0!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_0!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYjc1OGU2Y2QtOGZjOS00ZWM2LWEyODYtMTY5MmVkZTY1NDFkIiwiZXhwIjoxNzUzNjE0ODc1fQ.mpgkOk69B5Cf2Na8CgC5KV1eqDGHanXJN5EabDP5-lE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_0!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_0!.ts" (
        ren "Lectures\!lecture_0!.ts" "!lecture_0!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_0!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_0!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_0!.mp4
    title File Exists: !lecture_0!
)
set "lecture_1=Cost Sheet 09 - Concept and Questions -Part 08"

echo.
if not exist "Lectures\!lecture_1!.mp4" (
    title Downloading: !lecture_1!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_1!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiN2E4YTQxZGYtMjZiZS00Nzc1LWJiZjEtZTBhNzdhZjdlZGIzIiwiZXhwIjoxNzUzNjE0ODc1fQ.V5t923v5HD5bXtfk3sUjL3TdyflINpsR820vTVKisz8/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_1!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_1!.ts" (
        ren "Lectures\!lecture_1!.ts" "!lecture_1!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_1!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_1!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_1!.mp4
    title File Exists: !lecture_1!
)
set "lecture_2=Cost Sheet 08 - Concept and Questions -Part 07"

echo.
if not exist "Lectures\!lecture_2!.mp4" (
    title Downloading: !lecture_2!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_2!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMmZkZDdjNjMtODk0Yi00NmJhLTlmZTEtMmNiOWExYTkxMjBhIiwiZXhwIjoxNzUzNjE0ODc1fQ.Dz4t03le9pJeUniXV-ES6fvY3NpLirWseoBQq2aaqGE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_2!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_2!.ts" (
        ren "Lectures\!lecture_2!.ts" "!lecture_2!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_2!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_2!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_2!.mp4
    title File Exists: !lecture_2!
)
set "lecture_3=Cost Sheet 07 - Concept and Questions -Part 06"

echo.
if not exist "Lectures\!lecture_3!.mp4" (
    title Downloading: !lecture_3!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_3!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiN2IyNTgxMzAtOTlmZS00NjU1LTgwMjktOGVhYjE1M2Y4MGY5IiwiZXhwIjoxNzUzNjE0ODc1fQ.X6PEq14ow4PFUTBvyH2cQfq-n_kJb_OWLVP9-cXcgt8/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_3!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_3!.ts" (
        ren "Lectures\!lecture_3!.ts" "!lecture_3!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_3!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_3!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_3!.mp4
    title File Exists: !lecture_3!
)
set "lecture_4=Cost Sheet 06 - Concept and Questions -Part 05"

echo.
if not exist "Lectures\!lecture_4!.mp4" (
    title Downloading: !lecture_4!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_4!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGFiNjM4N2MtZmQ5My00NjVmLWI0MDEtYmI3NWY0YjVlMGMzIiwiZXhwIjoxNzUzNjE0ODc1fQ.1pDt-Z0IuaDA3reopWvK1Dmj6uDFsPPz8AW3HfP4MUQ/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_4!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_4!.ts" (
        ren "Lectures\!lecture_4!.ts" "!lecture_4!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_4!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_4!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_4!.mp4
    title File Exists: !lecture_4!
)
set "lecture_5=Cost Sheet 05 - Concept and Questions -Part 04"

echo.
if not exist "Lectures\!lecture_5!.mp4" (
    title Downloading: !lecture_5!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_5!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNmJlMGNhOTItNTc0My00Y2JiLThmZDYtN2Q5NjA5ODIwZGE0IiwiZXhwIjoxNzUzNjE0ODc1fQ.ltzRSJ-WK-CWHQ1PpyxOjQg_RRdY93-BmCAeiJC1zXQ/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_5!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_5!.ts" (
        ren "Lectures\!lecture_5!.ts" "!lecture_5!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_5!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_5!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_5!.mp4
    title File Exists: !lecture_5!
)
set "lecture_6=Cost Sheet 04 - Concept and Questions -Part 03"

echo.
if not exist "Lectures\!lecture_6!.mp4" (
    title Downloading: !lecture_6!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_6!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiN2M2YzZiMGUtNDAxMi00MTBjLWFmNjctNWM4YmRhZGNjN2M2IiwiZXhwIjoxNzUzNjE0ODc1fQ.KXxFDmfdd5aLeIRyV4W06_M3rFiqBsYxbjqFG0cUafY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_6!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_6!.ts" (
        ren "Lectures\!lecture_6!.ts" "!lecture_6!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_6!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_6!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_6!.mp4
    title File Exists: !lecture_6!
)
set "lecture_7=Cost Sheet 03 - Concept and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_7!.mp4" (
    title Downloading: !lecture_7!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_7!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYmQ2ODdkZDYtNzMyOC00YWNkLWFjOGUtYjQ2ZWVlMGEwNWY0IiwiZXhwIjoxNzUzNjE0ODc1fQ.pM7TpmVlgc87h0ifajQwr8bSpClmjKuEbCNCK5J4rCc/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_7!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_7!.ts" (
        ren "Lectures\!lecture_7!.ts" "!lecture_7!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_7!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_7!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_7!.mp4
    title File Exists: !lecture_7!
)
set "lecture_8=Cost Sheet 02 - Concept and Questions"

echo.
if not exist "Lectures\!lecture_8!.mp4" (
    title Downloading: !lecture_8!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_8!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYjRhYmRjOTItNTI5Yy00ZWMwLWFkYWUtM2JkY2U1OWExYTVmIiwiZXhwIjoxNzUzNjE0ODc1fQ.Pxhw4BYiTTJGhhzxdQYv9xsBSuMLm_rphnT7driGuKI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_8!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_8!.ts" (
        ren "Lectures\!lecture_8!.ts" "!lecture_8!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_8!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_8!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_8!.mp4
    title File Exists: !lecture_8!
)
set "lecture_9=Cost Sheet 01 - Basics and Concept"

echo.
if not exist "Lectures\!lecture_9!.mp4" (
    title Downloading: !lecture_9!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_9!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZTRmZmQ4M2QtZmM1OC00YmM1LWJhM2UtZDY3YWM3YmU2ZDdmIiwiZXhwIjoxNzUzNjE0ODc1fQ.dg_1wEa0apTzwMKYnFzWnTyFDBf3TuorzOF-EzpJBsU/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_9!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_9!.ts" (
        ren "Lectures\!lecture_9!.ts" "!lecture_9!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_9!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_9!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_9!.mp4
    title File Exists: !lecture_9!
)
mkdir "Notes" 2>nul
set "note_0=Cost Sheet 10  Class Notes"

echo.
if not exist "Notes\!note_0!.pdf" (
    title Downloading: !note_0!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_0!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_0!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d8b6d4b8-2369-49fe-a907-dd3466a3adf2.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_0!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_0!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_0!.pdf
    title File Exists: !note_0!
)
set "note_1=Cost Sheet 09  Class Notes"

echo.
if not exist "Notes\!note_1!.pdf" (
    title Downloading: !note_1!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_1!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_1!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/b38676a0-a7a6-493a-a796-d3587e77d846.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_1!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_1!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_1!.pdf
    title File Exists: !note_1!
)
set "note_2=Cost Sheet 08  Class Notes"

echo.
if not exist "Notes\!note_2!.pdf" (
    title Downloading: !note_2!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_2!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_2!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/33edd063-4d3a-4b91-9632-634f29c1c382.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_2!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_2!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_2!.pdf
    title File Exists: !note_2!
)
set "note_3=Cost Sheet 07  Class Notes"

echo.
if not exist "Notes\!note_3!.pdf" (
    title Downloading: !note_3!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_3!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_3!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/114c5272-037b-4802-a489-0754a68baec3.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_3!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_3!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_3!.pdf
    title File Exists: !note_3!
)
set "note_4=Cost Sheet 06  Class Notes"

echo.
if not exist "Notes\!note_4!.pdf" (
    title Downloading: !note_4!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_4!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_4!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/40e6f827-0220-44f6-941b-cb2ffaca2ebd.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_4!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_4!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_4!.pdf
    title File Exists: !note_4!
)
set "note_5=Cost Sheet 05  Class Notes"

echo.
if not exist "Notes\!note_5!.pdf" (
    title Downloading: !note_5!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_5!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_5!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ebbfac2b-e793-41fd-ab4a-33f822ec0354.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_5!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_5!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_5!.pdf
    title File Exists: !note_5!
)
set "note_6=E-Notes _ Cost Sheet "

echo.
if not exist "Notes\!note_6!.pdf" (
    title Downloading: !note_6!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_6!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_6!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/c214dbb2-3b88-44bc-be19-25429d854732.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_6!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_6!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_6!.pdf
    title File Exists: !note_6!
)
set "note_7=Cost Sheet 04  Class Notes"

echo.
if not exist "Notes\!note_7!.pdf" (
    title Downloading: !note_7!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_7!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_7!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d8fad4c0-cb35-4ecd-a5aa-f43155fc58aa.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_7!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_7!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_7!.pdf
    title File Exists: !note_7!
)
set "note_8=Cost Sheet 03 Class Notes "

echo.
if not exist "Notes\!note_8!.pdf" (
    title Downloading: !note_8!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_8!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_8!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/19673e45-989d-4995-a830-0841b1b7da35.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_8!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_8!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_8!.pdf
    title File Exists: !note_8!
)
set "note_9=Cost Sheet 02  Class Notes"

echo.
if not exist "Notes\!note_9!.pdf" (
    title Downloading: !note_9!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_9!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_9!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/cb570012-d31c-4a43-b51a-ea4b4a8768d8.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_9!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_9!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_9!.pdf
    title File Exists: !note_9!
)
set "note_10=Cost Sheet 01 Class Notes"

echo.
if not exist "Notes\!note_10!.pdf" (
    title Downloading: !note_10!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_10!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Sheet\Notes\!note_10!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/f089ca48-c556-4895-8b60-7e76724cb2b4.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_10!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_10!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_10!.pdf
    title File Exists: !note_10!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Employee Cost and Direct Expenses
echo -----------------------------------------------------------
mkdir "Employee Cost and Direct Expenses" 2>nul
cd /d "Employee Cost and Direct Expenses"
mkdir "Lectures" 2>nul
set "lecture_10=Employee Cost and Direct Expenses 07 - Incentive Plans Questions"

echo.
if not exist "Lectures\!lecture_10!.mp4" (
    title Downloading: !lecture_10!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_10!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiY2Y5NDUwODUtYjcwMS00YmVmLTgxYjEtMzU0MDkzNjE5MzlmIiwiZXhwIjoxNzUzNjE0ODc1fQ.Si7E5LGZoPaNk1xqWUpHKlbV6cl2omJHcYbfGU_GR9U/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_10!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_10!.ts" (
        ren "Lectures\!lecture_10!.ts" "!lecture_10!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_10!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_10!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_10!.mp4
    title File Exists: !lecture_10!
)
set "lecture_11=Employee Cost and Direct Expenses 06 - Overtime Premium - Overtime Treatment - Type of Wage Payment System - Incentive Plan Concept"

echo.
if not exist "Lectures\!lecture_11!.mp4" (
    title Downloading: !lecture_11!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_11!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOWE5ODE4MWItMTA3Ny00NDE2LTllZmYtNWM3ZWQ2Mzk5ZmQ4IiwiZXhwIjoxNzUzNjE0ODc1fQ.R3T-jlEwh-gXS1tZaqpwB3O7zz7BIkZvSbFjPfhRsWk/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_11!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_11!.ts" (
        ren "Lectures\!lecture_11!.ts" "!lecture_11!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_11!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_11!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_11!.mp4
    title File Exists: !lecture_11!
)
set "lecture_12=Employee Cost and Direct Expenses 05 - Concept and Questions -Part 05"

echo.
if not exist "Lectures\!lecture_12!.mp4" (
    title Downloading: !lecture_12!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_12!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYWI1YzJkMGUtYWVhOS00ZjkwLTgyOGMtOGJkZmU3ZWI0NmFkIiwiZXhwIjoxNzUzNjE0ODc1fQ.lAE6GVJOk8lnjs6VFLovNWjVz5WeiGXQ6j8_w0RZFRA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_12!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_12!.ts" (
        ren "Lectures\!lecture_12!.ts" "!lecture_12!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_12!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_12!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_12!.mp4
    title File Exists: !lecture_12!
)
set "lecture_13=Employee Cost and Direct Expenses 04 - Concept and Questions -Part 04"

echo.
if not exist "Lectures\!lecture_13!.mp4" (
    title Downloading: !lecture_13!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_13!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYjA4Mzk4MWYtYjg3Ni00ZjhhLWI0NTgtZTZkNDgzOTYyNThkIiwiZXhwIjoxNzUzNjE0ODc1fQ.VoRN60rOEweXOkt-P0BS35u_JEUCxbuUvYBEExGJQSY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_13!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_13!.ts" (
        ren "Lectures\!lecture_13!.ts" "!lecture_13!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_13!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_13!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_13!.mp4
    title File Exists: !lecture_13!
)
set "lecture_14=Employee Cost and Direct Expenses 03 - Concept and Questions -Part 03"

echo.
if not exist "Lectures\!lecture_14!.mp4" (
    title Downloading: !lecture_14!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_14!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYjU1M2VjZDYtN2ZjNi00MjY3LWE5NDYtZmIxZDBmZWMwYjYxIiwiZXhwIjoxNzUzNjE0ODc1fQ.7Fv3_0xJCTZu4HLmmmw3WGT92md2xpdO9TT1cDnaSJY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_14!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_14!.ts" (
        ren "Lectures\!lecture_14!.ts" "!lecture_14!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_14!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_14!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_14!.mp4
    title File Exists: !lecture_14!
)
set "lecture_15=Employee Cost and Direct Expenses 02 - Concept and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_15!.mp4" (
    title Downloading: !lecture_15!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_15!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOTMzYjdkMjYtN2I4Mi00NzkwLWIwYmItMWVhNjJlN2IxYjg5IiwiZXhwIjoxNzUzNjE0ODc1fQ.AkXPmbfjWBPLUAxNyIYsIKFXdjIFYIIZjy1gd86XCBU/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_15!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_15!.ts" (
        ren "Lectures\!lecture_15!.ts" "!lecture_15!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_15!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_15!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_15!.mp4
    title File Exists: !lecture_15!
)
set "lecture_16=Employee Cost and Direct Expenses 01 -  Concept and Questions"

echo.
if not exist "Lectures\!lecture_16!.mp4" (
    title Downloading: !lecture_16!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_16!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYTk0ZjQ1MWMtYTM2NC00ZDdiLWE0NGMtNTQ2MDFjOGE1ZjE2IiwiZXhwIjoxNzUzNjE0ODc1fQ.AcElwtq9U0dTueM9-lPq-k0lYINI9hgrUmKx6EvOTZ0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_16!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_16!.ts" (
        ren "Lectures\!lecture_16!.ts" "!lecture_16!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_16!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_16!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_16!.mp4
    title File Exists: !lecture_16!
)
mkdir "Notes" 2>nul
set "note_11=Employee Cost and Direct Expenses 07  Class Notes"

echo.
if not exist "Notes\!note_11!.pdf" (
    title Downloading: !note_11!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_11!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_11!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/53571b01-41c8-4607-8d3b-69d914c7a94f.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_11!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_11!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_11!.pdf
    title File Exists: !note_11!
)
set "note_12=Employee Cost and Direct Expenses 06  Class Notes"

echo.
if not exist "Notes\!note_12!.pdf" (
    title Downloading: !note_12!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_12!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_12!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/36f62ca2-656c-474f-acfc-f4356a62b0a9.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_12!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_12!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_12!.pdf
    title File Exists: !note_12!
)
set "note_13=Employee Cost and Direct Expenses 05  Class Notes"

echo.
if not exist "Notes\!note_13!.pdf" (
    title Downloading: !note_13!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_13!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_13!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/c48fcb89-3c80-40af-b564-87cadf7b032b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_13!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_13!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_13!.pdf
    title File Exists: !note_13!
)
set "note_14=Employee Cost and Direct Expenses 04  Class Notes"

echo.
if not exist "Notes\!note_14!.pdf" (
    title Downloading: !note_14!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_14!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_14!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5f3bf564-6192-4cc1-aa68-f6588bc43e08.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_14!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_14!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_14!.pdf
    title File Exists: !note_14!
)
set "note_15=Employee Cost and Direct Expenses 03  Class Notes"

echo.
if not exist "Notes\!note_15!.pdf" (
    title Downloading: !note_15!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_15!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_15!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6d6dadd2-b755-46d1-a514-83241aee0949.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_15!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_15!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_15!.pdf
    title File Exists: !note_15!
)
set "note_16=Employee Cost and Direct Expenses 02  Class Notes"

echo.
if not exist "Notes\!note_16!.pdf" (
    title Downloading: !note_16!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_16!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_16!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/15334b5c-d79b-4b1d-a2ed-66f11eef9d2a.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_16!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_16!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_16!.pdf
    title File Exists: !note_16!
)
set "note_17=Employee Cost and Direct Expenses 01  Class Notes "

echo.
if not exist "Notes\!note_17!.pdf" (
    title Downloading: !note_17!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_17!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_17!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/15305cf6-8a40-44eb-acbc-756a7d53726e.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_17!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_17!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_17!.pdf
    title File Exists: !note_17!
)
set "note_18=E-Notes  Employee Cost and Direct Expenses"

echo.
if not exist "Notes\!note_18!.pdf" (
    title Downloading: !note_18!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_18!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Employee Cost and Direct Expenses\Notes\!note_18!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/174c9f13-9794-4a6a-a0fd-c27ad02058d1.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_18!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_18!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_18!.pdf
    title File Exists: !note_18!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Introduction to cost and management accounting
echo -----------------------------------------------------------
mkdir "Introduction to cost and management accounting" 2>nul
cd /d "Introduction to cost and management accounting"
mkdir "Lectures" 2>nul
set "lecture_17=Introduction to Cost and Management Accounting 04 -  Basics and Concept"

echo.
if not exist "Lectures\!lecture_17!.mp4" (
    title Downloading: !lecture_17!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_17!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNDAxZDdmYTgtYzc5ZC00NDU4LThlYTgtNWU0NzUzMzc5ZDM1IiwiZXhwIjoxNzUzNjE0ODc1fQ.er0pbKRpkQdGTkbZurT_JMtvLR14v3OjLhrZRkZgXh0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_17!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_17!.ts" (
        ren "Lectures\!lecture_17!.ts" "!lecture_17!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_17!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_17!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_17!.mp4
    title File Exists: !lecture_17!
)
set "lecture_18=Introduction to Cost and Management Accounting 03 - Introduction - Part 03 "

echo.
if not exist "Lectures\!lecture_18!.mp4" (
    title Downloading: !lecture_18!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_18!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOGZkMjI0MDItNGQ1Yi00MDdhLWE3OGEtNmMyMTVhZDRjN2IxIiwiZXhwIjoxNzUzNjE0ODc1fQ.LVD6TO63kUujMLfjMAfxzVKPmfqlPRHUH187Pfj67Nk/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_18!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_18!.ts" (
        ren "Lectures\!lecture_18!.ts" "!lecture_18!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_18!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_18!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_18!.mp4
    title File Exists: !lecture_18!
)
set "lecture_19=Introduction to Cost and Management Accounting 02 - Introduction - Part 02 "

echo.
if not exist "Lectures\!lecture_19!.mp4" (
    title Downloading: !lecture_19!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_19!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZjg1NjQxMGMtZWZiZC00NGRiLTkwZDUtYmNhMmJjM2JkZWEzIiwiZXhwIjoxNzUzNjE0ODc1fQ._ukLCu8rnQ_Oxj79grarAQWmu2t-VBvRKIuls2hJxaA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_19!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_19!.ts" (
        ren "Lectures\!lecture_19!.ts" "!lecture_19!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_19!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_19!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_19!.mp4
    title File Exists: !lecture_19!
)
set "lecture_20=Introduction to Cost and Management Accounting 01 - Introduction"

echo.
if not exist "Lectures\!lecture_20!.mp4" (
    title Downloading: !lecture_20!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_20!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZGViODhjMTYtZDQyZi00NzA5LWFhNGUtYzZmZjBhYzBkOGQ1IiwiZXhwIjoxNzUzNjE0ODc1fQ.D5sMhuomdBBfcqXtZIXj4KNYGCViIhWhFxF0363hBnU/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_20!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_20!.ts" (
        ren "Lectures\!lecture_20!.ts" "!lecture_20!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_20!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_20!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_20!.mp4
    title File Exists: !lecture_20!
)
mkdir "Notes" 2>nul
set "note_19=Introduction to cost and management accounting 04 Class Notes "

echo.
if not exist "Notes\!note_19!.pdf" (
    title Downloading: !note_19!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_19!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Introduction to cost and management accounting\Notes\!note_19!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/b286d40d-e31e-466f-90fb-1a30f3285e1f.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_19!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_19!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_19!.pdf
    title File Exists: !note_19!
)
set "note_20=Introduction to cost and management accounting 03  Class Notes"

echo.
if not exist "Notes\!note_20!.pdf" (
    title Downloading: !note_20!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_20!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Introduction to cost and management accounting\Notes\!note_20!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ac410490-711a-4bd7-a911-9ecf15438ed0.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_20!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_20!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_20!.pdf
    title File Exists: !note_20!
)
set "note_21=Introduction to cost and management accounting 02 _ Class Notes"

echo.
if not exist "Notes\!note_21!.pdf" (
    title Downloading: !note_21!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_21!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Introduction to cost and management accounting\Notes\!note_21!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/5b96a77c-e750-460c-8652-f45cb28ce555.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_21!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_21!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_21!.pdf
    title File Exists: !note_21!
)
set "note_22=Introduction to cost and management accounting 01  Class Notes"

echo.
if not exist "Notes\!note_22!.pdf" (
    title Downloading: !note_22!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_22!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Introduction to cost and management accounting\Notes\!note_22!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/c7bfb2ee-a790-462d-af8b-6bcf160d9329.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_22!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_22!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_22!.pdf
    title File Exists: !note_22!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Material Cost
echo -----------------------------------------------------------
mkdir "Material Cost" 2>nul
cd /d "Material Cost"
mkdir "Lectures" 2>nul
set "lecture_21=Material Cost 12 - Stores Ledger -Part 02"

echo.
if not exist "Lectures\!lecture_21!.mp4" (
    title Downloading: !lecture_21!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_21!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNzdhYzViMDMtMTdiMS00MGQyLTk0ZDUtM2I2NWI4MzkwODY5IiwiZXhwIjoxNzUzNjE0ODc1fQ.rYDrML4LFGgoZIYD3uJ1Di3CmMnL4a5NzEvr4e2un0g/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_21!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_21!.ts" (
        ren "Lectures\!lecture_21!.ts" "!lecture_21!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_21!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_21!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_21!.mp4
    title File Exists: !lecture_21!
)
set "lecture_22=Material Cost 11 - Stores Ledger"

echo.
if not exist "Lectures\!lecture_22!.mp4" (
    title Downloading: !lecture_22!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_22!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMmFjZGU1YTUtZDg3OS00MDlkLWIzNDYtNjUyZTk2YTY1NzZjIiwiZXhwIjoxNzUzNjE0ODc1fQ.7TZMh2LcF7lmJD0vY6wIHWkbAc55CpeWXaVZ262YYi0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_22!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_22!.ts" (
        ren "Lectures\!lecture_22!.ts" "!lecture_22!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_22!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_22!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_22!.mp4
    title File Exists: !lecture_22!
)
set "lecture_23=Material Cost 10 - Valuation of Material -Part 02- - Determination of Safety Stock"

echo.
if not exist "Lectures\!lecture_23!.mp4" (
    title Downloading: !lecture_23!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_23!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYmJkNDQzMTYtYzMxYS00N2U3LTkxMGEtZmUxM2JhNTFjZjEwIiwiZXhwIjoxNzUzNjE0ODc1fQ.apKgzU2kEPpXCRJGmjbOC-u5-8cz-GIZplmRTSx8f7Q/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_23!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_23!.ts" (
        ren "Lectures\!lecture_23!.ts" "!lecture_23!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_23!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_23!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_23!.mp4
    title File Exists: !lecture_23!
)
set "lecture_24=Material Cost 09 - Doubt Solving of HW Questions - Valuation of Material"

echo.
if not exist "Lectures\!lecture_24!.mp4" (
    title Downloading: !lecture_24!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_24!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMjJhOWE1MzItYmZkMS00NDcxLWE2ZWUtMjE0NmJkYzlhY2ViIiwiZXhwIjoxNzUzNjE0ODc1fQ.WIoYyJ3GmlwyuhsYxIiVDifr-jUSAXW4tFLkS1BueEs/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_24!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_24!.ts" (
        ren "Lectures\!lecture_24!.ts" "!lecture_24!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_24!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_24!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_24!.mp4
    title File Exists: !lecture_24!
)
set "lecture_25=Material Cost 08 - Choice of supplier - Inventory turnover Ratio - Substitute Material"

echo.
if not exist "Lectures\!lecture_25!.mp4" (
    title Downloading: !lecture_25!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_25!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNjlhNDg4ZWMtMGFlOC00OWNhLWIxMDgtOGZiZjc0NDU3NDllIiwiZXhwIjoxNzUzNjE0ODc1fQ.k6Yc2qY9p6phcZCIAQrT6LWDjWq8PoknbNQKCFZAgXE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_25!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_25!.ts" (
        ren "Lectures\!lecture_25!.ts" "!lecture_25!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_25!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_25!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_25!.mp4
    title File Exists: !lecture_25!
)
set "lecture_26=Material Cost 07 - Concept and Questions of EOQ and Levels of Inventory"

echo.
if not exist "Lectures\!lecture_26!.mp4" (
    title Downloading: !lecture_26!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_26!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMTY1MTQyMzQtNGYwYy00OGI4LTk3YWMtYTUwNDFkNDk3YTIwIiwiZXhwIjoxNzUzNjE0ODc1fQ.1ItQaXaVjf7G9IPLscp3cdkUdtS4sIIz3uidQblKOqs/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_26!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_26!.ts" (
        ren "Lectures\!lecture_26!.ts" "!lecture_26!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_26!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_26!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_26!.mp4
    title File Exists: !lecture_26!
)
set "lecture_27=Material Cost 06 - Levels of Inventory - Concept and Questions"

echo.
if not exist "Lectures\!lecture_27!.mp4" (
    title Downloading: !lecture_27!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_27!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMzI1NmQzM2QtYWJkZS00ZDlhLTk5YmMtZmY0M2EwMTk3ZWIzIiwiZXhwIjoxNzUzNjE0ODc1fQ.gmDfPkVc_gvpOD3PNlRezVrW7sD0SKo6kYM_bIlVQzY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_27!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_27!.ts" (
        ren "Lectures\!lecture_27!.ts" "!lecture_27!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_27!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_27!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_27!.mp4
    title File Exists: !lecture_27!
)
set "lecture_28=Material Cost 05 - EOQ Questions -Part 02- - Concept of Levels of Inventory"

echo.
if not exist "Lectures\!lecture_28!.mp4" (
    title Downloading: !lecture_28!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_28!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZGM1NDgyZTktYjc2OC00MTE4LWI3YWMtYzRhOGNjMWZmNzc3IiwiZXhwIjoxNzUzNjE0ODc1fQ.S5q6J0em3OaEGQgti5GNAvPheUPsTLJQvPCigtMDaZ8/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_28!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_28!.ts" (
        ren "Lectures\!lecture_28!.ts" "!lecture_28!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_28!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_28!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_28!.mp4
    title File Exists: !lecture_28!
)
set "lecture_29=Material Cost 04 - EOQ Questions"

echo.
if not exist "Lectures\!lecture_29!.mp4" (
    title Downloading: !lecture_29!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_29!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZWU2ZDlhODMtZTVkNy00N2E0LWI2NGItNjY5MGY4ZDFiNTkwIiwiZXhwIjoxNzUzNjE0ODc1fQ.QV2JSLQ6NIArO2fYyFswtiFZD876L3sWz-FWk1BbLjI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_29!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_29!.ts" (
        ren "Lectures\!lecture_29!.ts" "!lecture_29!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_29!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_29!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_29!.mp4
    title File Exists: !lecture_29!
)
set "lecture_30=Material Cost 03 - EOQ with Discount"

echo.
if not exist "Lectures\!lecture_30!.mp4" (
    title Downloading: !lecture_30!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_30!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGIwNWQ2OTYtYzQ0MS00Mjg1LWE3ZTgtMDQxYmFiMWRiODkzIiwiZXhwIjoxNzUzNjE0ODc1fQ.17Mf5aiMk30zB-BYZPnKPHVpnd7vnv8hkyl-dvTjC1M/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_30!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_30!.ts" (
        ren "Lectures\!lecture_30!.ts" "!lecture_30!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_30!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_30!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_30!.mp4
    title File Exists: !lecture_30!
)
set "lecture_31=Material Cost 02 - Concept and Questions of EOQ"

echo.
if not exist "Lectures\!lecture_31!.mp4" (
    title Downloading: !lecture_31!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_31!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMzJjMTA1NTQtZWQxNy00ZjM4LWJlNTItNTUwMzBhNDA1NTE5IiwiZXhwIjoxNzUzNjE0ODc1fQ.Buul6wrxPevA7HQNFLGnljXzLDntnsigrwZXOF1Y7Ic/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_31!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_31!.ts" (
        ren "Lectures\!lecture_31!.ts" "!lecture_31!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_31!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_31!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_31!.mp4
    title File Exists: !lecture_31!
)
set "lecture_32=Material Cost 01 - Concept of Material Cost"

echo.
if not exist "Lectures\!lecture_32!.mp4" (
    title Downloading: !lecture_32!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_32!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTU0YmE5MmQtZDEwYS00NjU4LTk4MjQtYzYzN2YzYWFlNmE3IiwiZXhwIjoxNzUzNjE0ODc1fQ.QYOJFRwnLhVrSiGKk2Pj7lmpUURKLgWn1I9y25APy3s/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_32!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_32!.ts" (
        ren "Lectures\!lecture_32!.ts" "!lecture_32!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_32!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_32!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_32!.mp4
    title File Exists: !lecture_32!
)
mkdir "Notes" 2>nul
set "note_23=Material Cost 12  Class Notes"

echo.
if not exist "Notes\!note_23!.pdf" (
    title Downloading: !note_23!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_23!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_23!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/e4a8ebe8-1ac4-4e0d-ad64-52dd7677eb31.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_23!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_23!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_23!.pdf
    title File Exists: !note_23!
)
set "note_24=Material Cost 11  Class Notes"

echo.
if not exist "Notes\!note_24!.pdf" (
    title Downloading: !note_24!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_24!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_24!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6e133447-3b87-40ae-9a82-8b9b5eecb98d.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_24!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_24!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_24!.pdf
    title File Exists: !note_24!
)
set "note_25=Material Cost 10  Class Notes"

echo.
if not exist "Notes\!note_25!.pdf" (
    title Downloading: !note_25!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_25!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_25!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/0e57db55-dcbe-487e-8337-46b52f22a699.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_25!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_25!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_25!.pdf
    title File Exists: !note_25!
)
set "note_26=Material Cost 09  Class Notes"

echo.
if not exist "Notes\!note_26!.pdf" (
    title Downloading: !note_26!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_26!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_26!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/72321836-24d0-4af8-9709-1de1fe962ae1.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_26!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_26!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_26!.pdf
    title File Exists: !note_26!
)
set "note_27=Material Cost 08  Class Notes"

echo.
if not exist "Notes\!note_27!.pdf" (
    title Downloading: !note_27!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_27!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_27!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d892647d-01a2-4226-8ae2-06b8a6b800ab.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_27!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_27!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_27!.pdf
    title File Exists: !note_27!
)
set "note_28=Material Cost 07  Class Notes"

echo.
if not exist "Notes\!note_28!.pdf" (
    title Downloading: !note_28!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_28!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_28!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/9b931b9e-b9ed-4714-aba4-a419f16f69f1.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_28!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_28!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_28!.pdf
    title File Exists: !note_28!
)
set "note_29=Material Cost 06 Class Notes"

echo.
if not exist "Notes\!note_29!.pdf" (
    title Downloading: !note_29!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_29!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_29!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/8d268099-5d50-4ef6-9573-d8a37a76271d.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_29!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_29!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_29!.pdf
    title File Exists: !note_29!
)
set "note_30=Material Cost 05  Class Notes"

echo.
if not exist "Notes\!note_30!.pdf" (
    title Downloading: !note_30!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_30!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_30!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/42315ebd-3424-43b6-bef2-8d19bc6c8127.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_30!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_30!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_30!.pdf
    title File Exists: !note_30!
)
set "note_31=Material Cost 04  Class Notes"

echo.
if not exist "Notes\!note_31!.pdf" (
    title Downloading: !note_31!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_31!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_31!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/57eb609a-a27f-41bb-a4c1-d2993a6a8a2f.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_31!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_31!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_31!.pdf
    title File Exists: !note_31!
)
set "note_32=Material Cost 03  Class Notes"

echo.
if not exist "Notes\!note_32!.pdf" (
    title Downloading: !note_32!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_32!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_32!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/ede7c622-f2b0-42d0-b463-9bb609bea4ec.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_32!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_32!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_32!.pdf
    title File Exists: !note_32!
)
set "note_33=E-Notes  Material Cost"

echo.
if not exist "Notes\!note_33!.pdf" (
    title Downloading: !note_33!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_33!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_33!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/c6d54b96-71ab-4e51-95a9-748e342a5ddd.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_33!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_33!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_33!.pdf
    title File Exists: !note_33!
)
set "note_34=Material Cost 02  Class Notes"

echo.
if not exist "Notes\!note_34!.pdf" (
    title Downloading: !note_34!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_34!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_34!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d8387682-89e6-480f-9ca0-122c5631198f.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_34!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_34!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_34!.pdf
    title File Exists: !note_34!
)
set "note_35=Material Cost 01  Class Notes"

echo.
if not exist "Notes\!note_35!.pdf" (
    title Downloading: !note_35!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_35!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Material Cost\Notes\!note_35!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/8299758c-1597-4af1-b6b4-f5f10a9a5583.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_35!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_35!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_35!.pdf
    title File Exists: !note_35!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Overheads
echo -----------------------------------------------------------
mkdir "Overheads" 2>nul
cd /d "Overheads"
mkdir "Lectures" 2>nul
set "lecture_33=Overheads 11 - Under and Over Recovery of Overheads -Part 03"

echo.
if not exist "Lectures\!lecture_33!.mp4" (
    title Downloading: !lecture_33!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_33!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGU3NjVkODctYjQ4NS00MWNhLWFhYzUtM2Q1YWFiODFkZTRhIiwiZXhwIjoxNzUzNjE0ODc1fQ.9oSPnKcfNtSxTRle9SUpeo92L7bGBmqEYCiH70XapIo/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_33!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_33!.ts" (
        ren "Lectures\!lecture_33!.ts" "!lecture_33!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_33!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_33!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_33!.mp4
    title File Exists: !lecture_33!
)
set "lecture_34=Overheads 10 - Doubts Solving of HW Questions - Under and Over Recovery of Overheads -Part 02"

echo.
if not exist "Lectures\!lecture_34!.mp4" (
    title Downloading: !lecture_34!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_34!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZjNmOTQ4MmQtODQ3Yi00NjIzLThlYzEtN2M4NWZkYjExZDY4IiwiZXhwIjoxNzUzNjE0ODc1fQ.Fc7m5CeWdRa3AiAPry_qYt_T3Q7CAGayvICn8l_9FIA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_34!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_34!.ts" (
        ren "Lectures\!lecture_34!.ts" "!lecture_34!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_34!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_34!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_34!.mp4
    title File Exists: !lecture_34!
)
set "lecture_35=Overheads 09 - Machine Hour Rate -Part 04- - Under and Over Recovery of Overheads"

echo.
if not exist "Lectures\!lecture_35!.mp4" (
    title Downloading: !lecture_35!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_35!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMTVlNWNmMWMtYjFiZC00YjBjLWE4ODYtZWQxNTI5ODJiNzZhIiwiZXhwIjoxNzUzNjE0ODc1fQ.Ta-x_TjDTOMS9QCfHpUNCIaTK83modtFW21r0eOmxyo/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_35!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_35!.ts" (
        ren "Lectures\!lecture_35!.ts" "!lecture_35!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_35!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_35!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_35!.mp4
    title File Exists: !lecture_35!
)
set "lecture_36=Overheads 08 - Machine Hour Rate -Part 03"

echo.
if not exist "Lectures\!lecture_36!.mp4" (
    title Downloading: !lecture_36!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_36!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYWRkZDJkOWItYjliYi00MTQ1LWE1M2EtYWY1NjU0MmVmN2M3IiwiZXhwIjoxNzUzNjE0ODc1fQ.qW7DHM_kRriM3B5WdJA6QDwQoeCrxiaDXRv48b72UJg/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_36!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_36!.ts" (
        ren "Lectures\!lecture_36!.ts" "!lecture_36!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_36!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_36!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_36!.mp4
    title File Exists: !lecture_36!
)
set "lecture_37=Overheads 07 - Machine Hour Rate -Part 02"

echo.
if not exist "Lectures\!lecture_37!.mp4" (
    title Downloading: !lecture_37!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_37!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMTViNTZhMDgtOGNlYy00NGUxLTgyY2MtZjgyODBlMjZiZWFjIiwiZXhwIjoxNzUzNjE0ODc1fQ.2vHmxa6fHvr8ey-rRwUdHLEq7WNbvx27xwZTlgNM9GY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_37!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_37!.ts" (
        ren "Lectures\!lecture_37!.ts" "!lecture_37!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_37!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_37!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_37!.mp4
    title File Exists: !lecture_37!
)
set "lecture_38=Overheads 06 - Machine Hour Rate"

echo.
if not exist "Lectures\!lecture_38!.mp4" (
    title Downloading: !lecture_38!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_38!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMWMwZDkyOTgtN2U3NS00YzVmLTgwYWUtNWQ4MGM4MTdkYTczIiwiZXhwIjoxNzUzNjE0ODc1fQ.hfNcAKembEVUY3GmHNMzvIdXzO5t1ZYdbAkOOn41dOI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_38!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_38!.ts" (
        ren "Lectures\!lecture_38!.ts" "!lecture_38!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_38!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_38!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_38!.mp4
    title File Exists: !lecture_38!
)
set "lecture_39=Overheads 05 - Recovery Rate Calculation"

echo.
if not exist "Lectures\!lecture_39!.mp4" (
    title Downloading: !lecture_39!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_39!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiM2NjOTY5NDUtNjIyMi00NGEyLTlmYTgtZjBiMGI3MmE5MzcwIiwiZXhwIjoxNzUzNjE0ODc1fQ.oM__J5Dy0yp-XOn4Ye4Q7dddnPy8ogOZ11XQTA_PyAA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_39!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_39!.ts" (
        ren "Lectures\!lecture_39!.ts" "!lecture_39!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_39!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_39!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_39!.mp4
    title File Exists: !lecture_39!
)
set "lecture_40=Overheads 04 - Overheads Distribution -Part 03"

echo.
if not exist "Lectures\!lecture_40!.mp4" (
    title Downloading: !lecture_40!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_40!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYTEyNDZmMTUtMjdkNC00ZmFkLWFkMTctNTA2ZDc3NjFlMzcyIiwiZXhwIjoxNzUzNjE0ODc1fQ.DK-kkcFHcq9-H6LhNSFdhQVvF_9NA3pMHDhNeGWD-GI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_40!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_40!.ts" (
        ren "Lectures\!lecture_40!.ts" "!lecture_40!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_40!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_40!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_40!.mp4
    title File Exists: !lecture_40!
)
set "lecture_41=Overheads 03 - Overheads Distribution -Part 02"

echo.
if not exist "Lectures\!lecture_41!.mp4" (
    title Downloading: !lecture_41!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_41!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiODMyOTcwZWItZjNiNy00NDhhLTg1YjktMDdlZjdjZGNjNGFiIiwiZXhwIjoxNzUzNjE0ODc1fQ.5YzOoK67z_9JDEQZotmiBgdajSIMNyhwJNT5fs1AI3k/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_41!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_41!.ts" (
        ren "Lectures\!lecture_41!.ts" "!lecture_41!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_41!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_41!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_41!.mp4
    title File Exists: !lecture_41!
)
set "lecture_42=Overheads 02 - Overheads Distribution"

echo.
if not exist "Lectures\!lecture_42!.mp4" (
    title Downloading: !lecture_42!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_42!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNzIxODI5NTEtOGI3MS00N2YzLWFhMmMtN2RkYTcwMWQ1OWUzIiwiZXhwIjoxNzUzNjE0ODc1fQ.4FMVy4Am9pX5YXcEVOgCf1kndTBhzIB50FLQe2gP5lw/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_42!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_42!.ts" (
        ren "Lectures\!lecture_42!.ts" "!lecture_42!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_42!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_42!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_42!.mp4
    title File Exists: !lecture_42!
)
set "lecture_43=Overheads 01 - Basic Concepts of Overheads"

echo.
if not exist "Lectures\!lecture_43!.mp4" (
    title Downloading: !lecture_43!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_43!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZDZmMGEzMTUtNDRlOC00Yzk4LWIwNGYtZDA2OTNiN2ZhZDVkIiwiZXhwIjoxNzUzNjE0ODc1fQ.vOGJKS5d2EhssclQWvzPNgHIvdjTs2DKhkkeJXiNrNA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_43!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_43!.ts" (
        ren "Lectures\!lecture_43!.ts" "!lecture_43!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_43!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_43!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_43!.mp4
    title File Exists: !lecture_43!
)
mkdir "Notes" 2>nul
set "note_36=Overheads 11  Class Notes"

echo.
if not exist "Notes\!note_36!.pdf" (
    title Downloading: !note_36!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_36!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_36!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/a0a69314-8210-4262-a922-fd2999efdb33.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_36!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_36!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_36!.pdf
    title File Exists: !note_36!
)
set "note_37=Overheads 10  Class Notes"

echo.
if not exist "Notes\!note_37!.pdf" (
    title Downloading: !note_37!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_37!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_37!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/0395f797-c6bb-4344-aef0-dca01e75cad1.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_37!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_37!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_37!.pdf
    title File Exists: !note_37!
)
set "note_38=Overheads 09  Class Notes"

echo.
if not exist "Notes\!note_38!.pdf" (
    title Downloading: !note_38!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_38!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_38!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/4cdd77e2-84bd-4207-bd0e-39d4a4a1e857.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_38!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_38!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_38!.pdf
    title File Exists: !note_38!
)
set "note_39=Overheads 08  Class Notes"

echo.
if not exist "Notes\!note_39!.pdf" (
    title Downloading: !note_39!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_39!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_39!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/83cf41ec-e4d9-4d22-8d0f-07f0f1fed3f6.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_39!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_39!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_39!.pdf
    title File Exists: !note_39!
)
set "note_40=Overheads 07  Class Notes"

echo.
if not exist "Notes\!note_40!.pdf" (
    title Downloading: !note_40!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_40!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_40!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/41ced507-70bf-4d2f-a02f-cf39547ab3b1.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_40!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_40!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_40!.pdf
    title File Exists: !note_40!
)
set "note_41=Overheads 06  Class Notes"

echo.
if not exist "Notes\!note_41!.pdf" (
    title Downloading: !note_41!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_41!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_41!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/4e060524-8b60-498e-be54-d34be1804133.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_41!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_41!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_41!.pdf
    title File Exists: !note_41!
)
set "note_42=Overheads 05  Class Notes"

echo.
if not exist "Notes\!note_42!.pdf" (
    title Downloading: !note_42!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_42!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_42!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/61e8f5df-fe63-48de-b61e-7385f96f40d9.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_42!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_42!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_42!.pdf
    title File Exists: !note_42!
)
set "note_43=Overheads 04  Class Notes"

echo.
if not exist "Notes\!note_43!.pdf" (
    title Downloading: !note_43!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_43!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_43!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/483ae802-c332-4c17-bd77-a7edd74e6909.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_43!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_43!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_43!.pdf
    title File Exists: !note_43!
)
set "note_44=Overheads 03  Class Notes"

echo.
if not exist "Notes\!note_44!.pdf" (
    title Downloading: !note_44!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_44!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_44!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6f3557cc-a09d-41e5-9cdd-b9083c31f0ae.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_44!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_44!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_44!.pdf
    title File Exists: !note_44!
)
set "note_45=Overheads 02  Class Notes"

echo.
if not exist "Notes\!note_45!.pdf" (
    title Downloading: !note_45!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_45!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_45!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6ae72e1f-1898-4642-ae2b-754cd482e212.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_45!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_45!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_45!.pdf
    title File Exists: !note_45!
)
set "note_46=Overheads 01  Class Notes"

echo.
if not exist "Notes\!note_46!.pdf" (
    title Downloading: !note_46!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_46!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_46!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/177dd1b5-ba9e-47b9-a19f-6fda4475e346.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_46!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_46!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_46!.pdf
    title File Exists: !note_46!
)
set "note_47=E- Notes  Overheads "

echo.
if not exist "Notes\!note_47!.pdf" (
    title Downloading: !note_47!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_47!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Overheads\Notes\!note_47!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/549197da-5c25-4e92-92f9-60e4bd98b4ad.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_47!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_47!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_47!.pdf
    title File Exists: !note_47!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Activity Based Costing
echo -----------------------------------------------------------
mkdir "Activity Based Costing" 2>nul
cd /d "Activity Based Costing"
mkdir "Lectures" 2>nul
set "lecture_44=Activity Based Costing 02 - Concepts and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_44!.mp4" (
    title Downloading: !lecture_44!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_44!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNzhkZGUzYWQtY2I1Zi00Yzg2LTkxNTAtNmZkZjBiOGY2MDJiIiwiZXhwIjoxNzUzNjE0ODc1fQ.YPkMcFh4ga48vk8fudelETO7_jJFdXQJSxiSVWyYUyI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_44!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_44!.ts" (
        ren "Lectures\!lecture_44!.ts" "!lecture_44!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_44!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_44!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_44!.mp4
    title File Exists: !lecture_44!
)
set "lecture_45=Activity Based Costing 01 - Concepts and Questions"

echo.
if not exist "Lectures\!lecture_45!.mp4" (
    title Downloading: !lecture_45!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_45!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiN2QzMmViZDgtYTJkZC00NmU3LThkNzAtNzIyZjZlNWYwMDE0IiwiZXhwIjoxNzUzNjE0ODc1fQ.agTjFuGKPCApqBpCc3qhLWzLMOxEkMMMmi2_DrKovTI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_45!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_45!.ts" (
        ren "Lectures\!lecture_45!.ts" "!lecture_45!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_45!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_45!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_45!.mp4
    title File Exists: !lecture_45!
)
mkdir "Notes" 2>nul
set "note_48=Activity Based Costing 02  Class Notes"

echo.
if not exist "Notes\!note_48!.pdf" (
    title Downloading: !note_48!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_48!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Activity Based Costing\Notes\!note_48!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6f841e4e-39de-4ab0-b7af-a06ab12ab368.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_48!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_48!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_48!.pdf
    title File Exists: !note_48!
)
set "note_49=Activity Based Costing 01  Class Notes "

echo.
if not exist "Notes\!note_49!.pdf" (
    title Downloading: !note_49!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_49!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Activity Based Costing\Notes\!note_49!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d21022db-b2df-4d63-a9b9-61f99e474deb.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_49!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_49!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_49!.pdf
    title File Exists: !note_49!
)
set "note_50=E-Notes  Activity Based Costing"

echo.
if not exist "Notes\!note_50!.pdf" (
    title Downloading: !note_50!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_50!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Activity Based Costing\Notes\!note_50!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/64b99bbe-6c39-4ec3-aea7-b3ee0a53f505.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_50!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_50!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_50!.pdf
    title File Exists: !note_50!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Cost Accounting System
echo -----------------------------------------------------------
mkdir "Cost Accounting System" 2>nul
cd /d "Cost Accounting System"
mkdir "Lectures" 2>nul
set "lecture_46=Cost Accounting System 08 - Basic Concepts and Questions -Part 03"

echo.
if not exist "Lectures\!lecture_46!.mp4" (
    title Downloading: !lecture_46!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_46!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMGVmZjEwZTYtODY0OC00NjEwLTljZjYtNmEyYjg1ODQ0YWVjIiwiZXhwIjoxNzUzNjE0ODc1fQ.Pm4hBJ2cdYyR_Xo7w0GtaRc9th-GY8ItzEJxYr_X65c/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_46!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_46!.ts" (
        ren "Lectures\!lecture_46!.ts" "!lecture_46!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_46!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_46!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_46!.mp4
    title File Exists: !lecture_46!
)
set "lecture_47=Cost Accounting System 07 - Basic Concepts and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_47!.mp4" (
    title Downloading: !lecture_47!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_47!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiM2YyNDZkNjUtNWVlYy00NjIxLWE2Y2UtMjVlMWY3YjJmZGI1IiwiZXhwIjoxNzUzNjE0ODc1fQ.Oxxd-G1llE7Th-OV72cGFHyoHA9O_a_o7lfUtRI3ozM/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_47!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_47!.ts" (
        ren "Lectures\!lecture_47!.ts" "!lecture_47!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_47!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_47!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_47!.mp4
    title File Exists: !lecture_47!
)
set "lecture_48=Cost Accounting System 06 - Basic Concepts and Questions - Extra Class"

echo.
if not exist "Lectures\!lecture_48!.mp4" (
    title Downloading: !lecture_48!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_48!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNDBkMTMwYmUtZjkxZS00N2FkLWEyNjAtNmRjMmQ3Y2M4NjRkIiwiZXhwIjoxNzUzNjE0ODc1fQ.jKTet6NtK3-fyyK27nseJ33sFwps3xur5SsYcqk3jfY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_48!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_48!.ts" (
        ren "Lectures\!lecture_48!.ts" "!lecture_48!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_48!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_48!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_48!.mp4
    title File Exists: !lecture_48!
)
set "lecture_49=Cost Accounting System 05 - Basic Concepts of Cost Accounting System -Part 02"

echo.
if not exist "Lectures\!lecture_49!.mp4" (
    title Downloading: !lecture_49!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_49!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiODczMGJmNjMtNDFmYy00ZjcxLWI1OTYtZTk1ZDFmYzY2MjY1IiwiZXhwIjoxNzUzNjE0ODc1fQ.Xw4Oy6mlbtZf60WWVceVOdPTVTrD0CsamPryScxDB40/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_49!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_49!.ts" (
        ren "Lectures\!lecture_49!.ts" "!lecture_49!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_49!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_49!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_49!.mp4
    title File Exists: !lecture_49!
)
set "lecture_50=Cost Accounting System 04 - Basic Concepts of Cost Accounting System"

echo.
if not exist "Lectures\!lecture_50!.mp4" (
    title Downloading: !lecture_50!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_50!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYjJiMjY0ZmEtNGUwMS00MDc0LThmZGEtNjRjZDI5YjYzMGEwIiwiZXhwIjoxNzUzNjE0ODc1fQ.19ffP6lkqYOmcXq99NkuIjwaLglAzGvJ4s_Ox4N3iBI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_50!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_50!.ts" (
        ren "Lectures\!lecture_50!.ts" "!lecture_50!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_50!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_50!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_50!.mp4
    title File Exists: !lecture_50!
)
set "lecture_51=Cost Accounting System 03 - Concept of Reconciliation and Questions"

echo.
if not exist "Lectures\!lecture_51!.mp4" (
    title Downloading: !lecture_51!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_51!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOGJlZDNjZTgtNDlmOS00MzU4LWI0YmUtY2Y2NGM4OGYwODNhIiwiZXhwIjoxNzUzNjE0ODc1fQ.LkTW7p1B1a9Lwr-_JYPxkZT4ZhTKGUjG4WkXKs8nF0s/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_51!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_51!.ts" (
        ren "Lectures\!lecture_51!.ts" "!lecture_51!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_51!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_51!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_51!.mp4
    title File Exists: !lecture_51!
)
set "lecture_52=Cost Accounting System 02 - Reconciliation Statement Concepts and Questions"

echo.
if not exist "Lectures\!lecture_52!.mp4" (
    title Downloading: !lecture_52!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_52!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMzA4ODBhMTMtN2YxMC00OTNjLWIzMzktNWU1MDNhMDAzYTdiIiwiZXhwIjoxNzUzNjE0ODc1fQ.j8hcahqMF2pXd22lAjnTfs_13hzp1rcFTDK9-CBoAg0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_52!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_52!.ts" (
        ren "Lectures\!lecture_52!.ts" "!lecture_52!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_52!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_52!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_52!.mp4
    title File Exists: !lecture_52!
)
set "lecture_53=Cost Accounting System 01 - Basic Concepts of Reconciliation"

echo.
if not exist "Lectures\!lecture_53!.mp4" (
    title Downloading: !lecture_53!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_53!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTM3ZDUyMzUtOGRlYy00MGIxLWI2NTgtMjZlMTkwMjRmNGNiIiwiZXhwIjoxNzUzNjE0ODc1fQ.tdBPSqjOJuN4YHCJpj-f9sxXwlQugHlwf9p75pXRXdQ/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_53!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_53!.ts" (
        ren "Lectures\!lecture_53!.ts" "!lecture_53!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_53!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_53!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_53!.mp4
    title File Exists: !lecture_53!
)
mkdir "Notes" 2>nul
set "note_51=Cost Accounting System 08  Class Notes"

echo.
if not exist "Notes\!note_51!.pdf" (
    title Downloading: !note_51!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_51!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_51!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/91d32228-3f11-4e90-924e-d924c8b5f9d9.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_51!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_51!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_51!.pdf
    title File Exists: !note_51!
)
set "note_52=Cost Accounting System 07  Class Notes"

echo.
if not exist "Notes\!note_52!.pdf" (
    title Downloading: !note_52!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_52!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_52!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/a31c60a8-622c-4f8e-949e-7c67557db77c.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_52!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_52!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_52!.pdf
    title File Exists: !note_52!
)
set "note_53=Cost Accounting System 06  Class Notes"

echo.
if not exist "Notes\!note_53!.pdf" (
    title Downloading: !note_53!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_53!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_53!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/daea68c8-ff32-4699-bf32-380831998dbf.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_53!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_53!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_53!.pdf
    title File Exists: !note_53!
)
set "note_54=Cost Accounting System 05  Class Notes"

echo.
if not exist "Notes\!note_54!.pdf" (
    title Downloading: !note_54!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_54!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_54!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/9821ec2a-e1d2-4179-b207-38d918643adc.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_54!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_54!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_54!.pdf
    title File Exists: !note_54!
)
set "note_55=Cost Accounting System 04  Class Notes"

echo.
if not exist "Notes\!note_55!.pdf" (
    title Downloading: !note_55!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_55!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_55!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/645b8d4a-9d31-45fa-89ea-5d1f6b16ba4c.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_55!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_55!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_55!.pdf
    title File Exists: !note_55!
)
set "note_56=Cost Accounting System 03  Class Notes"

echo.
if not exist "Notes\!note_56!.pdf" (
    title Downloading: !note_56!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_56!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_56!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/07201e5a-7afb-4761-acf8-43a676e3937d.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_56!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_56!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_56!.pdf
    title File Exists: !note_56!
)
set "note_57=Cost Accounting System 02  Class Notes"

echo.
if not exist "Notes\!note_57!.pdf" (
    title Downloading: !note_57!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_57!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_57!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/a07db32e-7e7b-4a65-b761-2ecd1b87442b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_57!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_57!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_57!.pdf
    title File Exists: !note_57!
)
set "note_58=E-Notes  Cost Accounting System"

echo.
if not exist "Notes\!note_58!.pdf" (
    title Downloading: !note_58!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_58!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_58!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/64dfa1ef-af59-451b-803a-89346c673c99.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_58!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_58!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_58!.pdf
    title File Exists: !note_58!
)
set "note_59=Cost Accounting System 01 _Class Notes"

echo.
if not exist "Notes\!note_59!.pdf" (
    title Downloading: !note_59!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_59!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Cost Accounting System\Notes\!note_59!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/9368d17d-6aaf-4666-92ab-0ed4edb5280c.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_59!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_59!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_59!.pdf
    title File Exists: !note_59!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Service Costing
echo -----------------------------------------------------------
mkdir "Service Costing" 2>nul
cd /d "Service Costing"
mkdir "Lectures" 2>nul
set "lecture_54=Service Costing 08 - Concepts and Questions -Part 07- and MCQs"

echo.
if not exist "Lectures\!lecture_54!.mp4" (
    title Downloading: !lecture_54!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_54!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMmVhODhhODktMmY1OS00YzgxLThhMGUtYmIzMTI3MDRkOTVlIiwiZXhwIjoxNzUzNjE0ODc1fQ.RCmJmDQSVR10CO2M_eEkUu5th5qDu2nP9H591w8YHd8/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_54!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_54!.ts" (
        ren "Lectures\!lecture_54!.ts" "!lecture_54!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_54!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_54!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_54!.mp4
    title File Exists: !lecture_54!
)
set "lecture_55=Service Costing 07 - Concepts and Questions -Part 06"

echo.
if not exist "Lectures\!lecture_55!.mp4" (
    title Downloading: !lecture_55!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_55!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMjBhZWZiMzYtZjJmNC00NDUyLTllNzAtNWU2MGUwZWUyODI4IiwiZXhwIjoxNzUzNjE0ODc1fQ.QkTnr6LifNTgDspAUjR9tPcSXHKzL047HL_4hkDJB3I/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_55!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_55!.ts" (
        ren "Lectures\!lecture_55!.ts" "!lecture_55!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_55!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_55!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_55!.mp4
    title File Exists: !lecture_55!
)
set "lecture_56=Service Costing 06 - Concepts and Questions -Part 05"

echo.
if not exist "Lectures\!lecture_56!.mp4" (
    title Downloading: !lecture_56!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_56!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMDhjMmJkNjQtOGRjZi00ZGM5LTg4YzEtYWI1MGFmMTdkM2RkIiwiZXhwIjoxNzUzNjE0ODc1fQ.raJFli2qKe4SlGiN_dqlxsZe-2DAjTtQY1SyN2CSnto/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_56!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_56!.ts" (
        ren "Lectures\!lecture_56!.ts" "!lecture_56!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_56!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_56!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_56!.mp4
    title File Exists: !lecture_56!
)
set "lecture_57=Service Costing 05 - Concepts and Questions -Part 04"

echo.
if not exist "Lectures\!lecture_57!.mp4" (
    title Downloading: !lecture_57!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_57!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNWZlOGFjNDgtZDIyMi00ZjgxLWJiN2ItNWY0Y2JhZDA3NjZjIiwiZXhwIjoxNzUzNjE0ODc1fQ.lBswKvrknm6kNH5UkT5sfXk53ai_x_A6MPROmzfxr8o/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_57!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_57!.ts" (
        ren "Lectures\!lecture_57!.ts" "!lecture_57!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_57!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_57!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_57!.mp4
    title File Exists: !lecture_57!
)
set "lecture_58=Service Costing 04 - Concepts and Questions -Part 03"

echo.
if not exist "Lectures\!lecture_58!.mp4" (
    title Downloading: !lecture_58!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_58!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMzA2ODdkZmUtNjJjYy00MzU3LTg3NTUtMDA1NjNlZTEwYzY2IiwiZXhwIjoxNzUzNjE0ODc1fQ.YL9Pb-bpiOUCDNI2f4hB996PTDt6M_1vK9Ehu3jXLJg/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_58!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_58!.ts" (
        ren "Lectures\!lecture_58!.ts" "!lecture_58!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_58!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_58!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_58!.mp4
    title File Exists: !lecture_58!
)
set "lecture_59=Service Costing 03 - Concepts and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_59!.mp4" (
    title Downloading: !lecture_59!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_59!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYjY4NGU2YjUtMjdjNS00YzVjLTk3Y2MtMGM4MjEwNTQwMzhiIiwiZXhwIjoxNzUzNjE0ODc1fQ.CE4mVsZlelQ0NvSu9m29WRpdTnk0i0DlnFfbCxKtLdA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_59!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_59!.ts" (
        ren "Lectures\!lecture_59!.ts" "!lecture_59!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_59!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_59!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_59!.mp4
    title File Exists: !lecture_59!
)
set "lecture_60=Service Costing 02 - Concepts and Questions"

echo.
if not exist "Lectures\!lecture_60!.mp4" (
    title Downloading: !lecture_60!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_60!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNjRlZGIyNGEtODU2ZS00ZjMzLTk0NmYtNTBjZGM1YmMzMzJmIiwiZXhwIjoxNzUzNjE0ODc1fQ.6T9HzVV5I7sdEJBTIO6Pz9pqKMvZQWaz9rnZLTdPWQY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_60!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_60!.ts" (
        ren "Lectures\!lecture_60!.ts" "!lecture_60!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_60!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_60!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_60!.mp4
    title File Exists: !lecture_60!
)
set "lecture_61=Service Costing 01 - Basic Concepts"

echo.
if not exist "Lectures\!lecture_61!.mp4" (
    title Downloading: !lecture_61!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_61!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMzc0MTdmMzYtMTUzOS00NWM2LWE4ZDktMGNmMzI4M2NjZjM5IiwiZXhwIjoxNzUzNjE0ODc1fQ.NNM2--svRAyPSNFnRlKUayPl5zMRbbpobDrsv7_LhII/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_61!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_61!.ts" (
        ren "Lectures\!lecture_61!.ts" "!lecture_61!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_61!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_61!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_61!.mp4
    title File Exists: !lecture_61!
)
mkdir "Notes" 2>nul
set "note_60=Service Costing 08 Class Notes"

echo.
if not exist "Notes\!note_60!.pdf" (
    title Downloading: !note_60!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_60!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_60!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5f2d4226-c690-42df-9ca0-277da8259cbb.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_60!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_60!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_60!.pdf
    title File Exists: !note_60!
)
set "note_61=Service Costing 07  Class Notes"

echo.
if not exist "Notes\!note_61!.pdf" (
    title Downloading: !note_61!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_61!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_61!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/324af8ba-17aa-4874-b86f-07e3798e73fe.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_61!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_61!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_61!.pdf
    title File Exists: !note_61!
)
set "note_62=Service Costing 06  Class Notes"

echo.
if not exist "Notes\!note_62!.pdf" (
    title Downloading: !note_62!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_62!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_62!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/34135e07-fb5f-4856-923e-cd846b9536a4.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_62!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_62!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_62!.pdf
    title File Exists: !note_62!
)
set "note_63=Service Costing 05  Class Notes"

echo.
if not exist "Notes\!note_63!.pdf" (
    title Downloading: !note_63!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_63!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_63!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/121dcf7a-aad4-4326-8c8b-691e1c618860.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_63!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_63!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_63!.pdf
    title File Exists: !note_63!
)
set "note_64=Service Costing 04  Class Notes"

echo.
if not exist "Notes\!note_64!.pdf" (
    title Downloading: !note_64!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_64!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_64!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/1376458f-54fd-4c61-af3e-70fdd5beeccb.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_64!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_64!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_64!.pdf
    title File Exists: !note_64!
)
set "note_65=Service Costing 03  Class Notes"

echo.
if not exist "Notes\!note_65!.pdf" (
    title Downloading: !note_65!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_65!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_65!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/b85fcbec-f315-439e-a1d9-9d24f66df965.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_65!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_65!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_65!.pdf
    title File Exists: !note_65!
)
set "note_66=Service Costing 02  Class Notes"

echo.
if not exist "Notes\!note_66!.pdf" (
    title Downloading: !note_66!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_66!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_66!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/c8aa748e-39b1-42c4-8d23-93f55df6d6ef.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_66!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_66!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_66!.pdf
    title File Exists: !note_66!
)
set "note_67=E-Books  Service Costing"

echo.
if not exist "Notes\!note_67!.pdf" (
    title Downloading: !note_67!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_67!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_67!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ff8e0612-2f70-4006-a802-a7a725714548.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_67!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_67!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_67!.pdf
    title File Exists: !note_67!
)
set "note_68=Service Costing 01  Class Notes"

echo.
if not exist "Notes\!note_68!.pdf" (
    title Downloading: !note_68!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_68!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Service Costing\Notes\!note_68!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/df971437-becd-4d91-8d11-2fb96b67102d.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_68!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_68!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_68!.pdf
    title File Exists: !note_68!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Process Costing
echo -----------------------------------------------------------
mkdir "Process Costing" 2>nul
cd /d "Process Costing"
mkdir "Lectures" 2>nul
set "lecture_62=Process Costing 08 - Inter - Process  Profit - Recorded - Extra Class"

echo.
if not exist "Lectures\!lecture_62!.mp4" (
    title Downloading: !lecture_62!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_62!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMjUxMmY4ZGUtZDUyYi00OTQ2LWFjYzktZjNkOWIyOTI4YzAzIiwiZXhwIjoxNzUzNjE0ODc1fQ.Qqz7xB11lYxtMa7V7ulr3doY19dHxQ6hKVokffzPVnA/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_62!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_62!.ts" (
        ren "Lectures\!lecture_62!.ts" "!lecture_62!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_62!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_62!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_62!.mp4
    title File Exists: !lecture_62!
)
set "lecture_63=Process Costing 07 - Concept and Questions -Part 06"

echo.
if not exist "Lectures\!lecture_63!.mp4" (
    title Downloading: !lecture_63!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_63!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYmEwOTk5MzQtYWQyZS00MzMxLWJmYmYtZGUyNzJiNzY3YjE5IiwiZXhwIjoxNzUzNjE0ODc1fQ._Fpp619K8NNmGJpJz1AxHO0fCdqjr4wNpC6f9ZAJV8U/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_63!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_63!.ts" (
        ren "Lectures\!lecture_63!.ts" "!lecture_63!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_63!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_63!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_63!.mp4
    title File Exists: !lecture_63!
)
set "lecture_64=Process Costing 06 - Concept and Questions -Part 05"

echo.
if not exist "Lectures\!lecture_64!.mp4" (
    title Downloading: !lecture_64!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_64!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNzk5ZTFlOGYtNTU2OS00NDI1LWExNDAtYTkyNjBlMmY5MDkxIiwiZXhwIjoxNzUzNjE0ODc1fQ.5QCri2IHtneMXcUOi-BJu1DkfSKUhL35q1-5ZvVllI0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_64!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_64!.ts" (
        ren "Lectures\!lecture_64!.ts" "!lecture_64!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_64!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_64!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_64!.mp4
    title File Exists: !lecture_64!
)
set "lecture_65=Process Costing 05 - Concept and Questions -Part 04"

echo.
if not exist "Lectures\!lecture_65!.mp4" (
    title Downloading: !lecture_65!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_65!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTRiZWIzMzMtMDMxNS00NTgxLWFkNzUtMzJkMGRiOTljOWNiIiwiZXhwIjoxNzUzNjE0ODc1fQ.ioNwfMH__HtpX5xWWEfprYtB42ENrNOC9q1DJEjgudY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_65!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_65!.ts" (
        ren "Lectures\!lecture_65!.ts" "!lecture_65!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_65!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_65!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_65!.mp4
    title File Exists: !lecture_65!
)
set "lecture_66=Process Costing 04 - Concept and Questions -Part 03"

echo.
if not exist "Lectures\!lecture_66!.mp4" (
    title Downloading: !lecture_66!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_66!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTI2ODNhODItYjMxZC00MjNiLThkY2ItYWIyM2JmZDU4ZjI3IiwiZXhwIjoxNzUzNjE0ODc1fQ.262k2-Oi_QRbcBHa_3Sw0PjGwjLyIcqoVdjcjDO5IQw/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_66!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_66!.ts" (
        ren "Lectures\!lecture_66!.ts" "!lecture_66!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_66!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_66!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_66!.mp4
    title File Exists: !lecture_66!
)
set "lecture_67=Process Costing 03 - Concept and Questions -Part 02- - Rescheduled @10-30AM"

echo.
if not exist "Lectures\!lecture_67!.mp4" (
    title Downloading: !lecture_67!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_67!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNDliYjJkZGEtNjg5OC00YTZjLWIwZGItOTI3MjhmYmNjMjYxIiwiZXhwIjoxNzUzNjE0ODc1fQ.ImTzTB8lvo6rIxZlDTcN7YwLbj8zj6LCqsGXYyOr3HE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_67!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_67!.ts" (
        ren "Lectures\!lecture_67!.ts" "!lecture_67!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_67!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_67!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_67!.mp4
    title File Exists: !lecture_67!
)
set "lecture_68=Process Costing 02 - Concept and Questions"

echo.
if not exist "Lectures\!lecture_68!.mp4" (
    title Downloading: !lecture_68!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_68!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYTRlOTU3ZDEtNTU5ZS00YmViLTgwMDgtM2U1NTc3YjMyZjY0IiwiZXhwIjoxNzUzNjE0ODc1fQ.MzJjxKWYU8xS0-NZJ_908CH0zGd0m4vj8gvNEMeRK5I/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_68!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_68!.ts" (
        ren "Lectures\!lecture_68!.ts" "!lecture_68!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_68!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_68!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_68!.mp4
    title File Exists: !lecture_68!
)
set "lecture_69=Process Costing 01 - Basic Concepts"

echo.
if not exist "Lectures\!lecture_69!.mp4" (
    title Downloading: !lecture_69!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_69!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNWM4ZGY5NTItZDM5Yy00NmFjLWJhZWQtMjBiMGE3ZDQ2OTJjIiwiZXhwIjoxNzUzNjE0ODc1fQ.8aJPA0vJT4b0BB1Rone3e7lSdq41DeLYU0lf6Lez2lk/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_69!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_69!.ts" (
        ren "Lectures\!lecture_69!.ts" "!lecture_69!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_69!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_69!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_69!.mp4
    title File Exists: !lecture_69!
)
mkdir "Notes" 2>nul
set "note_69=Process Costing 08  Class Notes"

echo.
if not exist "Notes\!note_69!.pdf" (
    title Downloading: !note_69!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_69!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_69!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/04e015b3-3ce9-481e-9042-996d7e4ba82c.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_69!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_69!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_69!.pdf
    title File Exists: !note_69!
)
set "note_70=Process Costing 07  Class Notes"

echo.
if not exist "Notes\!note_70!.pdf" (
    title Downloading: !note_70!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_70!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_70!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5415f4fd-efda-4490-8dbf-ecfdf1f67929.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_70!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_70!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_70!.pdf
    title File Exists: !note_70!
)
set "note_71=Process Costing 06  Class Notes"

echo.
if not exist "Notes\!note_71!.pdf" (
    title Downloading: !note_71!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_71!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_71!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6a24aa7c-6163-44fc-8a39-ffbbc0378534.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_71!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_71!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_71!.pdf
    title File Exists: !note_71!
)
set "note_72=Process Costing 05  Class Notes"

echo.
if not exist "Notes\!note_72!.pdf" (
    title Downloading: !note_72!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_72!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_72!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/cf230688-c1d4-4a2c-a10b-740fb4635651.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_72!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_72!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_72!.pdf
    title File Exists: !note_72!
)
set "note_73=Process Costing 04  Class Notes"

echo.
if not exist "Notes\!note_73!.pdf" (
    title Downloading: !note_73!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_73!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_73!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/41efc0fc-fbfe-43e4-aca6-58169f24562c.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_73!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_73!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_73!.pdf
    title File Exists: !note_73!
)
set "note_74=Process Costing 03  Class Notes"

echo.
if not exist "Notes\!note_74!.pdf" (
    title Downloading: !note_74!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_74!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_74!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/33c64fca-1a8b-496e-ad96-8a8406f5407d.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_74!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_74!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_74!.pdf
    title File Exists: !note_74!
)
set "note_75=Process Costing 02  Class Notes"

echo.
if not exist "Notes\!note_75!.pdf" (
    title Downloading: !note_75!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_75!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_75!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/e7559021-58b2-47cc-a06c-3cf7ba2ff48f.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_75!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_75!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_75!.pdf
    title File Exists: !note_75!
)
set "note_76=E-Books  Process Costing"

echo.
if not exist "Notes\!note_76!.pdf" (
    title Downloading: !note_76!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_76!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_76!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/808247d7-1247-49e5-8c84-05ea538ef8d7.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_76!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_76!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_76!.pdf
    title File Exists: !note_76!
)
set "note_77=Process Costing 01  Class Notes"

echo.
if not exist "Notes\!note_77!.pdf" (
    title Downloading: !note_77!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_77!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Process Costing\Notes\!note_77!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/0c789b35-548a-4d10-90e7-bda58058f3ed.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_77!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_77!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_77!.pdf
    title File Exists: !note_77!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Joint and By-Product
echo -----------------------------------------------------------
mkdir "Joint and By-Product" 2>nul
cd /d "Joint and By-Product"
mkdir "Lectures" 2>nul
set "lecture_70=Joint and By-Product 03 - Concepts and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_70!.mp4" (
    title Downloading: !lecture_70!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_70!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMDVhNWU3YTUtNGVjOC00OWVkLWFmNzYtOGU2ZmM3NGJhZWNhIiwiZXhwIjoxNzUzNjE0ODc1fQ.CCJTQynoKnqxdBgXd1HPY8LqL4hnVwxHxXdH18iSe6Q/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_70!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_70!.ts" (
        ren "Lectures\!lecture_70!.ts" "!lecture_70!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_70!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_70!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_70!.mp4
    title File Exists: !lecture_70!
)
set "lecture_71=Joint and By-Product 02 - Concepts and Questions"

echo.
if not exist "Lectures\!lecture_71!.mp4" (
    title Downloading: !lecture_71!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_71!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiN2NmNmE2NjQtYmUxZi00ZWNmLTlhZTUtYzliMzVjNDY0M2MwIiwiZXhwIjoxNzUzNjE0ODc1fQ.r54vPfSDWWhIZXJp6WkAd_-p4FeG3Dc0B3wUCnX1x2c/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_71!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_71!.ts" (
        ren "Lectures\!lecture_71!.ts" "!lecture_71!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_71!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_71!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_71!.mp4
    title File Exists: !lecture_71!
)
set "lecture_72=Joint and By-Product 01 - Basic Concepts and Questions"

echo.
if not exist "Lectures\!lecture_72!.mp4" (
    title Downloading: !lecture_72!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_72!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMDIzODdjOGItNzAzMi00ZjUzLWFlN2EtNTllYTBiNTQ0ZmM4IiwiZXhwIjoxNzUzNjE0ODc1fQ.DagdJtPITZWjDjawKxl5mefpxZStrQkyg4EHJfsuZGY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_72!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_72!.ts" (
        ren "Lectures\!lecture_72!.ts" "!lecture_72!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_72!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_72!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_72!.mp4
    title File Exists: !lecture_72!
)
mkdir "Notes" 2>nul
set "note_78=Joint and By-Product 03  Class Notes"

echo.
if not exist "Notes\!note_78!.pdf" (
    title Downloading: !note_78!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_78!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Joint and By-Product\Notes\!note_78!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5b15bea0-dfc6-4618-a472-1006c372dcf4.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_78!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_78!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_78!.pdf
    title File Exists: !note_78!
)
set "note_79=Joint and By-Product 02  Class Notes"

echo.
if not exist "Notes\!note_79!.pdf" (
    title Downloading: !note_79!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_79!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Joint and By-Product\Notes\!note_79!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/3abdbc39-c202-4d57-ab95-091b24017854.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_79!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_79!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_79!.pdf
    title File Exists: !note_79!
)
set "note_80=Joint and By-Product 01  Class Notes"

echo.
if not exist "Notes\!note_80!.pdf" (
    title Downloading: !note_80!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_80!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Joint and By-Product\Notes\!note_80!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/de6878e2-b0e0-4894-9a46-68b8fccd44ba.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_80!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_80!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_80!.pdf
    title File Exists: !note_80!
)
set "note_81=E- Books Joint and By-Product"

echo.
if not exist "Notes\!note_81!.pdf" (
    title Downloading: !note_81!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_81!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Joint and By-Product\Notes\!note_81!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/9ac9a7a5-337c-48c0-b95e-5ef65cba86c7.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_81!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_81!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_81!.pdf
    title File Exists: !note_81!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Marginal Costing
echo -----------------------------------------------------------
mkdir "Marginal Costing" 2>nul
cd /d "Marginal Costing"
mkdir "Lectures" 2>nul
set "lecture_73=Marginal Costing 10 - Basic Concepts -Part 09- and Question -Part 07"

echo.
if not exist "Lectures\!lecture_73!.mp4" (
    title Downloading: !lecture_73!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_73!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGQ2ZTk1MzctNTQzMC00NDkzLTliMWYtZGUwNTNjMDBjZDE4IiwiZXhwIjoxNzUzNjE0ODc1fQ.-t3as6Cn5FSrmFvOQ5BNveOPW9RSzmXx5LPm8De3Pn0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_73!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_73!.ts" (
        ren "Lectures\!lecture_73!.ts" "!lecture_73!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_73!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_73!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_73!.mp4
    title File Exists: !lecture_73!
)
set "lecture_74=Marginal Costing 09 - Basic Concepts -Part 08- and Question -Part 06"

echo.
if not exist "Lectures\!lecture_74!.mp4" (
    title Downloading: !lecture_74!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_74!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiODVjZWM1MTAtYmM3MC00ODNlLTk0MDItMGM3ZWNlZTMxNjBhIiwiZXhwIjoxNzUzNjE0ODc1fQ.iH5POdt6SDVb4v_t_QHw9qy4Eyt7UM68U3BxJJpPtk0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_74!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_74!.ts" (
        ren "Lectures\!lecture_74!.ts" "!lecture_74!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_74!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_74!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_74!.mp4
    title File Exists: !lecture_74!
)
set "lecture_75=Marginal Costing 08 - Basic Concepts -Part 07- and Question -Part 05"

echo.
if not exist "Lectures\!lecture_75!.mp4" (
    title Downloading: !lecture_75!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_75!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZGJkNDM3YjctOTE3Zi00OThmLTlhMGEtNjg2NTM1NTkxNDg2IiwiZXhwIjoxNzUzNjE0ODc1fQ.CJacjsyXTCUBuUn-gw5kYKQIQdrnSSbucJo-l7XtBb0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_75!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_75!.ts" (
        ren "Lectures\!lecture_75!.ts" "!lecture_75!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_75!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_75!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_75!.mp4
    title File Exists: !lecture_75!
)
set "lecture_76=Marginal Costing 07 -  Concept of Decision Making"

echo.
if not exist "Lectures\!lecture_76!.mp4" (
    title Downloading: !lecture_76!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_76!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZWNhOGM5MzgtM2U2NC00ODcwLWIyODQtZTM5ODQ3MjdjZjk5IiwiZXhwIjoxNzUzNjE0ODc1fQ.UJ2fC55h3JIcijPEFXulKLGelhJHZgT8FnykhGURdo0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_76!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_76!.ts" (
        ren "Lectures\!lecture_76!.ts" "!lecture_76!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_76!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_76!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_76!.mp4
    title File Exists: !lecture_76!
)
set "lecture_77=Marginal Costing 06 - Basic Concepts -Part 06- and Question -Part 04- - Extra class"

echo.
if not exist "Lectures\!lecture_77!.mp4" (
    title Downloading: !lecture_77!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_77!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNDcwMzgzN2YtMWMwZi00NjU3LTllMDItZTgzY2UyZWZmZmQ0IiwiZXhwIjoxNzUzNjE0ODc1fQ.C7fXjx-vMEREEt8d3IPD-Gh2QDdOUFvLCQ24M3CiVV0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_77!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_77!.ts" (
        ren "Lectures\!lecture_77!.ts" "!lecture_77!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_77!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_77!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_77!.mp4
    title File Exists: !lecture_77!
)
set "lecture_78=Marginal Costing 05 - Basic Concepts -Part 05- and Question -Part 03"

echo.
if not exist "Lectures\!lecture_78!.mp4" (
    title Downloading: !lecture_78!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_78!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZGZhNDA1ZDEtMDFmNy00ZDUyLTljMGYtOTAwZTQ0OTk3NjhlIiwiZXhwIjoxNzUzNjE0ODc1fQ.RSmyONLw2pUJApkczW9o04gSnJu6BVzVXniNH30Wc7s/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_78!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_78!.ts" (
        ren "Lectures\!lecture_78!.ts" "!lecture_78!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_78!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_78!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_78!.mp4
    title File Exists: !lecture_78!
)
set "lecture_79=Marginal Costing 04 - Basic Concepts -Part 04- and Question -Part 02"

echo.
if not exist "Lectures\!lecture_79!.mp4" (
    title Downloading: !lecture_79!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_79!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMjBlMWNiMWMtMmM4Yi00ZTdjLTljNjMtYmQ0OTI2OTMxMjJlIiwiZXhwIjoxNzUzNjE0ODc1fQ.EoE12G8fx1mMM9gNpWOIHWKk3FpColvtSBXHbeairto/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_79!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_79!.ts" (
        ren "Lectures\!lecture_79!.ts" "!lecture_79!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_79!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_79!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_79!.mp4
    title File Exists: !lecture_79!
)
set "lecture_80=Marginal Costing 03 - Basic Concepts -Part 03- and Question"

echo.
if not exist "Lectures\!lecture_80!.mp4" (
    title Downloading: !lecture_80!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_80!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZDJiOTk1NjMtMDc4Mi00M2NjLWEyNzQtNjEwODM2YmYzMTM1IiwiZXhwIjoxNzUzNjE0ODc1fQ.wA0RFcvq8PZ46bkWZXtn25ZyeGDWTLpblKaQTL3KxDw/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_80!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_80!.ts" (
        ren "Lectures\!lecture_80!.ts" "!lecture_80!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_80!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_80!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_80!.mp4
    title File Exists: !lecture_80!
)
set "lecture_81=Marginal Costing 02 - Basic Concepts -Part 02"

echo.
if not exist "Lectures\!lecture_81!.mp4" (
    title Downloading: !lecture_81!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_81!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZjdiNzlmNWYtNjZhZS00MTZkLWEzZWItYjhkZTE1OWM2ODNiIiwiZXhwIjoxNzUzNjE0ODc1fQ.DjfILoOa4vGCo5JQGH-WMkhtjeiNj7-4VlrYLMMCCrE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_81!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_81!.ts" (
        ren "Lectures\!lecture_81!.ts" "!lecture_81!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_81!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_81!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_81!.mp4
    title File Exists: !lecture_81!
)
set "lecture_82=Marginal Costing 01 - Basic Concept and PV Ratio Concept - Extra Class"

echo.
if not exist "Lectures\!lecture_82!.mp4" (
    title Downloading: !lecture_82!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_82!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNjJjNjA1OGEtMWE5NS00ZGEwLTg1ZGItMzE5ZjI3YmQ2NmFjIiwiZXhwIjoxNzUzNjE0ODc1fQ.F8PrTt-TQ0L9VThX3PTKgjXWrhvP9dyLEfCZVPQhkTc/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_82!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_82!.ts" (
        ren "Lectures\!lecture_82!.ts" "!lecture_82!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_82!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_82!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_82!.mp4
    title File Exists: !lecture_82!
)
mkdir "Notes" 2>nul
set "note_82=Marginal Costing 10 Class Notes"

echo.
if not exist "Notes\!note_82!.pdf" (
    title Downloading: !note_82!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_82!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_82!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/28c462f5-4cb0-4662-9afb-6c463ad02a93.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_82!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_82!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_82!.pdf
    title File Exists: !note_82!
)
set "note_83=Marginal Costing 09  Class Notes "

echo.
if not exist "Notes\!note_83!.pdf" (
    title Downloading: !note_83!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_83!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_83!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/cc9475d7-0f89-4656-9cbf-41ffed0f8767.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_83!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_83!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_83!.pdf
    title File Exists: !note_83!
)
set "note_84=Marginal Costing 08  Class Notes"

echo.
if not exist "Notes\!note_84!.pdf" (
    title Downloading: !note_84!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_84!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_84!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/8aa055a9-aa8b-48a5-9f70-94a52933e0cb.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_84!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_84!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_84!.pdf
    title File Exists: !note_84!
)
set "note_85=Marginal Costing 07 Class Notes "

echo.
if not exist "Notes\!note_85!.pdf" (
    title Downloading: !note_85!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_85!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_85!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ff6d7e81-0198-451f-a748-32e3ab24c5fb.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_85!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_85!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_85!.pdf
    title File Exists: !note_85!
)
set "note_86=Marginal Costing 06 Class Notes "

echo.
if not exist "Notes\!note_86!.pdf" (
    title Downloading: !note_86!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_86!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_86!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/45f7567f-4437-4cb7-bd4c-71f1fb3e0084.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_86!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_86!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_86!.pdf
    title File Exists: !note_86!
)
set "note_87=Marginal Costing 05 Class Notes"

echo.
if not exist "Notes\!note_87!.pdf" (
    title Downloading: !note_87!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_87!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_87!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/1617b1e5-bea4-4cdb-bcef-f3304e94dd70.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_87!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_87!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_87!.pdf
    title File Exists: !note_87!
)
set "note_88=Marginal Costing 04  Class Notes "

echo.
if not exist "Notes\!note_88!.pdf" (
    title Downloading: !note_88!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_88!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_88!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/cd3bc17d-d9f4-4e56-8ff1-b8ddde46d36e.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_88!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_88!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_88!.pdf
    title File Exists: !note_88!
)
set "note_89=Marginal Costing 03 Class Notes"

echo.
if not exist "Notes\!note_89!.pdf" (
    title Downloading: !note_89!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_89!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_89!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/68444525-deac-47bc-901d-4dbf3c67915b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_89!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_89!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_89!.pdf
    title File Exists: !note_89!
)
set "note_90=Marginal Costing 02  Class Notes"

echo.
if not exist "Notes\!note_90!.pdf" (
    title Downloading: !note_90!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_90!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_90!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ee302733-43ba-4cef-81c0-e471b4501142.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_90!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_90!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_90!.pdf
    title File Exists: !note_90!
)
set "note_91=E-Notes Marginal Costing"

echo.
if not exist "Notes\!note_91!.pdf" (
    title Downloading: !note_91!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_91!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_91!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/3c39ea5e-e3b6-4cc6-8951-38471a39c869.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_91!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_91!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_91!.pdf
    title File Exists: !note_91!
)
set "note_92=Marginal Costing 01 Class Notes"

echo.
if not exist "Notes\!note_92!.pdf" (
    title Downloading: !note_92!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_92!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Marginal Costing\Notes\!note_92!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/2eb537e7-69e7-4eca-b6c3-e18049640381.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_92!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_92!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_92!.pdf
    title File Exists: !note_92!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Budget and Budgetary Control
echo -----------------------------------------------------------
mkdir "Budget and Budgetary Control" 2>nul
cd /d "Budget and Budgetary Control"
mkdir "Lectures" 2>nul
set "lecture_83=Budget and Budgetary Control 05 - Concept and Questions -Part 03"

echo.
if not exist "Lectures\!lecture_83!.mp4" (
    title Downloading: !lecture_83!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_83!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZDFkOGQzMDUtMWUxNC00ZmNkLThlNGUtNGUyMjlkYmE2Y2I0IiwiZXhwIjoxNzUzNjE0ODc1fQ.44XHY5Zgl41WAl66dEfqOEs_GxgzBBaazN2s0Iq3dlw/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_83!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_83!.ts" (
        ren "Lectures\!lecture_83!.ts" "!lecture_83!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_83!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_83!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_83!.mp4
    title File Exists: !lecture_83!
)
set "lecture_84=Budget and Budgetary Control 04 - Concept and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_84!.mp4" (
    title Downloading: !lecture_84!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_84!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNDc2MDIyMDEtMDI1YS00YzQ5LTkxZDUtYjAzZDBiZDVhNzQwIiwiZXhwIjoxNzUzNjE0ODc1fQ.vdi22r_qsa8xNHApmBnMHex9NNqJQy1dpc39H4c8XhU/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_84!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_84!.ts" (
        ren "Lectures\!lecture_84!.ts" "!lecture_84!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_84!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_84!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_84!.mp4
    title File Exists: !lecture_84!
)
set "lecture_85=Budget and Budgetary Control 03 - Concept and Questions - Reschedule @ 6-30 PM"

echo.
if not exist "Lectures\!lecture_85!.mp4" (
    title Downloading: !lecture_85!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_85!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOTc0M2MxMGMtNjUwYS00ZGRjLTlhYTItNzEzY2M2YTQ5MTM5IiwiZXhwIjoxNzUzNjE0ODc1fQ.k7O4226BPAAw0k8zW9Pyj2YnvoC3I9kY5NNNM_iul0Y/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_85!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_85!.ts" (
        ren "Lectures\!lecture_85!.ts" "!lecture_85!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_85!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_85!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_85!.mp4
    title File Exists: !lecture_85!
)
set "lecture_86=Budget and Budgetary Control 02 - Questions of Fixed and Flexible Budget"

echo.
if not exist "Lectures\!lecture_86!.mp4" (
    title Downloading: !lecture_86!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_86!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMjExOWY1OGQtNzYzMC00MzM0LWJmNTQtNzFmYjU1ZmIxMTRmIiwiZXhwIjoxNzUzNjE0ODc1fQ.ggv5zBsK6GLBdVSAcDpkoKTTOfKRydr4Osee3jTjVBE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_86!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_86!.ts" (
        ren "Lectures\!lecture_86!.ts" "!lecture_86!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_86!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_86!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_86!.mp4
    title File Exists: !lecture_86!
)
set "lecture_87=Budget and Budgetary Control 01 - Basic Concepts"

echo.
if not exist "Lectures\!lecture_87!.mp4" (
    title Downloading: !lecture_87!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_87!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNWQ1MWMzZTAtNjZmOC00MDgwLTk4ZDItYWExOTZkYTVhMDBhIiwiZXhwIjoxNzUzNjE0ODc1fQ.z7V7MFF4HtugVlMGM_GCxvJ2m_HYD-6T-2jVNtcVki4/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_87!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_87!.ts" (
        ren "Lectures\!lecture_87!.ts" "!lecture_87!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_87!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_87!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_87!.mp4
    title File Exists: !lecture_87!
)
mkdir "Notes" 2>nul
set "note_93=Budget and Budgetary Control 05  Class Notes"

echo.
if not exist "Notes\!note_93!.pdf" (
    title Downloading: !note_93!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_93!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Budget and Budgetary Control\Notes\!note_93!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5ba63a9c-f495-4acf-8b8b-0f954f9bce37.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_93!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_93!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_93!.pdf
    title File Exists: !note_93!
)
set "note_94=Budget and Budgetary Control 04  Class Notes"

echo.
if not exist "Notes\!note_94!.pdf" (
    title Downloading: !note_94!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_94!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Budget and Budgetary Control\Notes\!note_94!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5457b917-b165-408d-aa89-edf19d7ae7e8.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_94!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_94!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_94!.pdf
    title File Exists: !note_94!
)
set "note_95=Budget and Budgetary Control 03  Class Notes"

echo.
if not exist "Notes\!note_95!.pdf" (
    title Downloading: !note_95!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_95!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Budget and Budgetary Control\Notes\!note_95!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/1de56a83-1498-422a-8261-37d723416a4e.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_95!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_95!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_95!.pdf
    title File Exists: !note_95!
)
set "note_96=Budget and Budgetary Control 02  Class Notes"

echo.
if not exist "Notes\!note_96!.pdf" (
    title Downloading: !note_96!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_96!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Budget and Budgetary Control\Notes\!note_96!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/74661214-2114-462e-81cd-1bcd6b50d84c.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_96!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_96!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_96!.pdf
    title File Exists: !note_96!
)
set "note_97=E-Books  Budget and Budgetary Control"

echo.
if not exist "Notes\!note_97!.pdf" (
    title Downloading: !note_97!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_97!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Budget and Budgetary Control\Notes\!note_97!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/b14c634f-9ae6-4354-8fd1-960f69674ef5.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_97!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_97!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_97!.pdf
    title File Exists: !note_97!
)
set "note_98=Budget and Budgetary Control 01  Class Notes"

echo.
if not exist "Notes\!note_98!.pdf" (
    title Downloading: !note_98!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_98!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Budget and Budgetary Control\Notes\!note_98!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/7b019035-d2f0-4161-aea6-d436c4a4f34b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_98!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_98!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_98!.pdf
    title File Exists: !note_98!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Standard Costing
echo -----------------------------------------------------------
mkdir "Standard Costing" 2>nul
cd /d "Standard Costing"
mkdir "Lectures" 2>nul
set "lecture_88=Standard Costing 08 - Concept and Questions -Part 07- - Extra Class"

echo.
if not exist "Lectures\!lecture_88!.mp4" (
    title Downloading: !lecture_88!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_88!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMWNmZWE0MmYtZDM4MS00ZWYxLTg5ZmYtYjMzZjY1NGY5NTVlIiwiZXhwIjoxNzUzNjE0ODc1fQ.ynBjGoQvkEwzGq-tFb9VoRi2RAg02iI2SVCEoOUIixI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_88!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_88!.ts" (
        ren "Lectures\!lecture_88!.ts" "!lecture_88!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_88!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_88!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_88!.mp4
    title File Exists: !lecture_88!
)
set "lecture_89=Standard Costing 07 - Concept and Questions -Part 06- - Extra Class"

echo.
if not exist "Lectures\!lecture_89!.mp4" (
    title Downloading: !lecture_89!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_89!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTc4NmVkNDItNjFjNC00MjlmLTk5Y2ItODAxZjg3NTRlNWQ5IiwiZXhwIjoxNzUzNjE0ODc1fQ.9vyW9zd66hX6Ry3U-F9SFJHNJO4d3928n8ZUyE0UKG0/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_89!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_89!.ts" (
        ren "Lectures\!lecture_89!.ts" "!lecture_89!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_89!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_89!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_89!.mp4
    title File Exists: !lecture_89!
)
set "lecture_90=Standard Costing 06 - Concept and Questions -Part 05- - Extra Class"

echo.
if not exist "Lectures\!lecture_90!.mp4" (
    title Downloading: !lecture_90!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_90!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYmM3ZTEyZDgtMzk4NC00YjA0LWE1NDktYjYyZDdmNTUzMGU2IiwiZXhwIjoxNzUzNjE0ODc1fQ.lJRo1GNWwDKiC_Nf8oVywAaN58qZz5qan_NzT6uTAgQ/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_90!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_90!.ts" (
        ren "Lectures\!lecture_90!.ts" "!lecture_90!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_90!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_90!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_90!.mp4
    title File Exists: !lecture_90!
)
set "lecture_91=Standard Costing 05 - Concept and Questions -Part 04- - Extra Class"

echo.
if not exist "Lectures\!lecture_91!.mp4" (
    title Downloading: !lecture_91!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_91!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGY4YzQxYTAtMDFjZi00OTE3LWEwMDEtNWFhMTZmMThjNWYwIiwiZXhwIjoxNzUzNjE0ODc1fQ.TfjKTJHSzwUgJc-JWfNzJLLsBeedsSKwGLG8xhy7U7U/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_91!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_91!.ts" (
        ren "Lectures\!lecture_91!.ts" "!lecture_91!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_91!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_91!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_91!.mp4
    title File Exists: !lecture_91!
)
set "lecture_92=Standard Costing 04 - Concept and Questions -Part 03- - Extra Class"

echo.
if not exist "Lectures\!lecture_92!.mp4" (
    title Downloading: !lecture_92!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_92!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOWQ5NTNjYjctMTY2Yi00Y2RlLTgwZGEtM2U0YjU1NDA4YTYzIiwiZXhwIjoxNzUzNjE0ODc1fQ.YaKmTABtdNJNE1ZwLxVhbf-mv2FqVKhEp0GPc7ZS-fc/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_92!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_92!.ts" (
        ren "Lectures\!lecture_92!.ts" "!lecture_92!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_92!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_92!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_92!.mp4
    title File Exists: !lecture_92!
)
set "lecture_93=Standard Costing 03 - Concept and Questions -Part 02"

echo.
if not exist "Lectures\!lecture_93!.mp4" (
    title Downloading: !lecture_93!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_93!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYzFjY2JjNGEtMWQzYy00ODQyLThjNmMtMDRjNTNhMWViZGQ4IiwiZXhwIjoxNzUzNjE0ODc1fQ.m2RcwIj32M_M1-3k1oYQ2BXC2CBcD3zIPCMVyfi29E4/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_93!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_93!.ts" (
        ren "Lectures\!lecture_93!.ts" "!lecture_93!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_93!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_93!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_93!.mp4
    title File Exists: !lecture_93!
)
set "lecture_94=Standard Costing 02 - Concept and Questions - Reschedule @ 4-00 PM"

echo.
if not exist "Lectures\!lecture_94!.mp4" (
    title Downloading: !lecture_94!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_94!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYzcyMjY1OTctZDk2Ny00ODAzLWFhZWItNzk4OTQ1ZDlmZTMxIiwiZXhwIjoxNzUzNjE0ODc1fQ.TIQbM6_eePcDWrwvsQzybCFYyb8FqoHwx85yjs1jzFU/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_94!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_94!.ts" (
        ren "Lectures\!lecture_94!.ts" "!lecture_94!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_94!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_94!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_94!.mp4
    title File Exists: !lecture_94!
)
set "lecture_95=Standard Costing 01 - Basic Concepts"

echo.
if not exist "Lectures\!lecture_95!.mp4" (
    title Downloading: !lecture_95!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_95!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTg3MWM1YzUtMDVmZC00YjYzLWE4NTItOWM0OTEyZDIwNzQ2IiwiZXhwIjoxNzUzNjE0ODc1fQ.YcYZHaVaDBRoViMB9qY2X1nxBbSmW9HBbOVpVAKuEIY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_95!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_95!.ts" (
        ren "Lectures\!lecture_95!.ts" "!lecture_95!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_95!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_95!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_95!.mp4
    title File Exists: !lecture_95!
)
mkdir "Notes" 2>nul
set "note_99=Standard Costing 08  Class Notes"

echo.
if not exist "Notes\!note_99!.pdf" (
    title Downloading: !note_99!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_99!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_99!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/eece1c45-112c-47a5-9c96-ff9b9e37132b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_99!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_99!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_99!.pdf
    title File Exists: !note_99!
)
set "note_100=Standard Costing 07  Class Notes"

echo.
if not exist "Notes\!note_100!.pdf" (
    title Downloading: !note_100!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_100!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_100!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/184de1a1-7239-4782-8fc1-ccd0b1e9ece0.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_100!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_100!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_100!.pdf
    title File Exists: !note_100!
)
set "note_101=Standard Costing 06  Class Notes"

echo.
if not exist "Notes\!note_101!.pdf" (
    title Downloading: !note_101!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_101!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_101!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ad3afce3-85f5-434e-bd97-14f1f6bcbb3b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_101!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_101!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_101!.pdf
    title File Exists: !note_101!
)
set "note_102=Standard Costing 05  Class Notes"

echo.
if not exist "Notes\!note_102!.pdf" (
    title Downloading: !note_102!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_102!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_102!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/6e008ab6-d5a6-4cf5-8ae9-bc0f8d004260.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_102!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_102!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_102!.pdf
    title File Exists: !note_102!
)
set "note_103=Standard Costing 04  Class Notes"

echo.
if not exist "Notes\!note_103!.pdf" (
    title Downloading: !note_103!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_103!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_103!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/82c536ae-8227-4d7c-a735-8c2b4e527643.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_103!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_103!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_103!.pdf
    title File Exists: !note_103!
)
set "note_104=Standard Costing 03  Class Notes"

echo.
if not exist "Notes\!note_104!.pdf" (
    title Downloading: !note_104!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_104!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_104!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/8d4e3f0f-1d4d-4505-a08c-bb761e8aca92.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_104!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_104!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_104!.pdf
    title File Exists: !note_104!
)
set "note_105=Standard Costing 02  Class Notes"

echo.
if not exist "Notes\!note_105!.pdf" (
    title Downloading: !note_105!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_105!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_105!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ca2be121-ba18-4589-9ccc-8d451efda1ec.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_105!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_105!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_105!.pdf
    title File Exists: !note_105!
)
set "note_106=E-Books  Standard Costing"

echo.
if not exist "Notes\!note_106!.pdf" (
    title Downloading: !note_106!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_106!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_106!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d189760a-0001-44c5-9289-5ebc6af3422a.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_106!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_106!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_106!.pdf
    title File Exists: !note_106!
)
set "note_107=Standard Costing 01  Class Notes"

echo.
if not exist "Notes\!note_107!.pdf" (
    title Downloading: !note_107!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_107!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Standard Costing\Notes\!note_107!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5dce388d-9ba6-46c0-bdf0-3bc4d5c47039.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_107!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_107!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_107!.pdf
    title File Exists: !note_107!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Job Costing and Batch Costing
echo -----------------------------------------------------------
mkdir "Job Costing and Batch Costing" 2>nul
cd /d "Job Costing and Batch Costing"
mkdir "Lectures" 2>nul
set "lecture_96=Job Costing and Batch Costing 01 - Concept and Questions - Extra Class"

echo.
if not exist "Lectures\!lecture_96!.mp4" (
    title Downloading: !lecture_96!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_96!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNjNlNWE5MGMtMTJkMy00Yjc3LTgxNmMtYzlmNzMwNDJkODc4IiwiZXhwIjoxNzUzNjE0ODc1fQ.yhlDKVSPr3OYMwV8iCkpeuj1PnPu2KZZMMpQmqi8VQo/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_96!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_96!.ts" (
        ren "Lectures\!lecture_96!.ts" "!lecture_96!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_96!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_96!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_96!.mp4
    title File Exists: !lecture_96!
)
mkdir "Notes" 2>nul
set "note_108=E-Books  Job Costing and Batch Costing"

echo.
if not exist "Notes\!note_108!.pdf" (
    title Downloading: !note_108!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_108!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Job Costing and Batch Costing\Notes\!note_108!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d8528463-07d5-45f1-b05e-9bbd25c810aa.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_108!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_108!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_108!.pdf
    title File Exists: !note_108!
)
set "note_109=Job Costing and Batch Costing 01  Class Notes"

echo.
if not exist "Notes\!note_109!.pdf" (
    title Downloading: !note_109!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_109!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Job Costing and Batch Costing\Notes\!note_109!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/e5192f5c-24cc-4926-a0c5-fcb3246b1c79.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_109!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_109!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_109!.pdf
    title File Exists: !note_109!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Doubt Session
echo -----------------------------------------------------------
mkdir "Doubt Session" 2>nul
cd /d "Doubt Session"
mkdir "Lectures" 2>nul
set "lecture_97=Doubt Session 01 - Doubts - Extra Class - Video Only"

echo.
if not exist "Lectures\!lecture_97!.mp4" (
    title Downloading: !lecture_97!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_97!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNTZhZDI2MDUtM2Q3MS00YWIxLThkYzUtMzJiZDZjN2RmOGI2IiwiZXhwIjoxNzUzNjE0ODc1fQ.6oQ4qPVnTh2QndYjr05l2mNcr7RFpRCugwoX7Dp3U24/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_97!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_97!.ts" (
        ren "Lectures\!lecture_97!.ts" "!lecture_97!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_97!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_97!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_97!.mp4
    title File Exists: !lecture_97!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Important Notes
echo -----------------------------------------------------------
mkdir "Important Notes" 2>nul
cd /d "Important Notes"
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m ICAI Summary Notes - PDF Only
echo -----------------------------------------------------------
mkdir "ICAI Summary Notes - PDF Only" 2>nul
cd /d "ICAI Summary Notes - PDF Only"
mkdir "Notes" 2>nul
set "note_110=Summary - Costing"

echo.
if not exist "Notes\!note_110!.pdf" (
    title Downloading: !note_110!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_110!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\ICAI Summary Notes - PDF Only\Notes\!note_110!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/982a1970-35f1-48c1-95dd-adc858824918.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_110!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_110!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_110!.pdf
    title File Exists: !note_110!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Revision - One Shot
echo -----------------------------------------------------------
mkdir "Revision - One Shot" 2>nul
cd /d "Revision - One Shot"
mkdir "Lectures" 2>nul
set "lecture_98=Budget and Budgetary Control - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_98!.mp4" (
    title Downloading: !lecture_98!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_98!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNjYxN2Y3ZjItNThiNC00NTY3LWI0ZTAtY2VhOTc5YjQ1OWEwIiwiZXhwIjoxNzUzNjE0ODc1fQ.qb_GvFdV_DW44LnFOFmKDS2-9gwbvkwKQEnHwRd-FWI/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_98!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_98!.ts" (
        ren "Lectures\!lecture_98!.ts" "!lecture_98!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_98!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_98!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_98!.mp4
    title File Exists: !lecture_98!
)
set "lecture_99=Marginal Costing - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_99!.mp4" (
    title Downloading: !lecture_99!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_99!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMmI0ZTMzNTItOTczYy00MzllLTg0ODYtMjJhYWE5ZTBjMDIxIiwiZXhwIjoxNzUzNjE0ODc1fQ.muviqZwnXmVhuJDUKtkvDQjoJFPrTTYTdLhur6RoxG8/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_99!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_99!.ts" (
        ren "Lectures\!lecture_99!.ts" "!lecture_99!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_99!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_99!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_99!.mp4
    title File Exists: !lecture_99!
)
set "lecture_100=Standard Costing - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_100!.mp4" (
    title Downloading: !lecture_100!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_100!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYmMyZWI1ZTQtMGM2Ny00MzA3LWE4ZjMtZDA2ODU0NWYyOTg5IiwiZXhwIjoxNzUzNjE0ODc1fQ.z-QABey9KJoxUQIbi5rBpc6Zz0ZIuLEAWB9TRygvomo/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_100!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_100!.ts" (
        ren "Lectures\!lecture_100!.ts" "!lecture_100!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_100!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_100!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_100!.mp4
    title File Exists: !lecture_100!
)
set "lecture_101=Joint and by Product - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_101!.mp4" (
    title Downloading: !lecture_101!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_101!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMmQ2NGQ3NjMtMWY4OC00NTZhLTkxNTItMmY3Zjc5ODg2NjkyIiwiZXhwIjoxNzUzNjE0ODc1fQ.P1yw9QUlA99a1pnH5MgVVbHMoQlEezM5HLMSPJEUle8/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_101!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_101!.ts" (
        ren "Lectures\!lecture_101!.ts" "!lecture_101!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_101!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_101!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_101!.mp4
    title File Exists: !lecture_101!
)
set "lecture_102=Process Costing - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_102!.mp4" (
    title Downloading: !lecture_102!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_102!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNjdjNTM4NDQtZGY3ZS00ZDUzLWI4ZTUtZGU0ZmVmNzAwMzc4IiwiZXhwIjoxNzUzNjE0ODc1fQ.U_bULUnhTI9mbhMsY9HnzrzYuqP18lzg2Sz1mklp_uo/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_102!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_102!.ts" (
        ren "Lectures\!lecture_102!.ts" "!lecture_102!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_102!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_102!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_102!.mp4
    title File Exists: !lecture_102!
)
set "lecture_103=Service Costing - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_103!.mp4" (
    title Downloading: !lecture_103!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_103!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOWQ1YzI5NTktZWM5Zi00NzNkLTk1MGQtNWNhZTQxNzU2ODcxIiwiZXhwIjoxNzUzNjE0ODc1fQ.ARa2weeJ_ojPNFntCsZwCfEo8NpKJAppuF1S2JIvW9I/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_103!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_103!.ts" (
        ren "Lectures\!lecture_103!.ts" "!lecture_103!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_103!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_103!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_103!.mp4
    title File Exists: !lecture_103!
)
set "lecture_104=Job Batch Costing - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_104!.mp4" (
    title Downloading: !lecture_104!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_104!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiZmE5MWE3MGMtMzU1OC00NmZmLWJmYWItMTc1OGMyOTIwNmRhIiwiZXhwIjoxNzUzNjE0ODc1fQ.cqhiEcuCjRz3YCEEFGfxnIr0XeOItCTRIuTbGAG8yUY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_104!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_104!.ts" (
        ren "Lectures\!lecture_104!.ts" "!lecture_104!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_104!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_104!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_104!.mp4
    title File Exists: !lecture_104!
)
set "lecture_105=Cost Accounting System - One Shot  - Recorded"

echo.
if not exist "Lectures\!lecture_105!.mp4" (
    title Downloading: !lecture_105!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_105!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNWVmMzc2MjItZjM1NS00MTJmLTk1NzEtNDhlZWM5NjQ1ZDAyIiwiZXhwIjoxNzUzNjE0ODc1fQ.w16Vvphszq0_mnPO9DKLKLvarkBz3iTcFaFtAzTubyY/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_105!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_105!.ts" (
        ren "Lectures\!lecture_105!.ts" "!lecture_105!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_105!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_105!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_105!.mp4
    title File Exists: !lecture_105!
)
set "lecture_106=Overheads - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_106!.mp4" (
    title Downloading: !lecture_106!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_106!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGM0MGUwNzctNWY4Yy00M2IxLTlhYmQtYjA3Y2UzZjcwYTViIiwiZXhwIjoxNzUzNjE0ODc1fQ.qrJ_-K55YfPCX2TjZoK2P-ulrQW0xT-yRNuF2XztHuw/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_106!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_106!.ts" (
        ren "Lectures\!lecture_106!.ts" "!lecture_106!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_106!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_106!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_106!.mp4
    title File Exists: !lecture_106!
)
set "lecture_107=Employee Cost and Direct Expenses - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_107!.mp4" (
    title Downloading: !lecture_107!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_107!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMDQ0ZTViYTItYjQ3Yy00NzQ3LWIxODItNWY2MGUzMGVlMjc2IiwiZXhwIjoxNzUzNjE0ODc1fQ.wAJUrzDouRaR9ZvwTfUmeYhKufhhE7ObWH0o9eNet4E/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_107!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_107!.ts" (
        ren "Lectures\!lecture_107!.ts" "!lecture_107!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_107!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_107!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_107!.mp4
    title File Exists: !lecture_107!
)
set "lecture_108=Activity Based Costing - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_108!.mp4" (
    title Downloading: !lecture_108!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_108!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYmY0MTZhNWMtNjNiMS00YTNiLThlNjctYWVkZGExNjczMzAwIiwiZXhwIjoxNzUzNjE0ODc1fQ.NkINAhGTjmcxqF1O7-vFHdWbqSFMc53QVTSHGNu-BF4/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_108!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_108!.ts" (
        ren "Lectures\!lecture_108!.ts" "!lecture_108!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_108!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_108!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_108!.mp4
    title File Exists: !lecture_108!
)
set "lecture_109=Material Cost - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_109!.mp4" (
    title Downloading: !lecture_109!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_109!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNmNlYWFhNGMtMDRmYS00YWU2LTk5NjQtNDNhNjdmNzRjMTVhIiwiZXhwIjoxNzUzNjE0ODc1fQ.5E63bVTqjCxBPL7K-lsdmObzjQMsrj6GfC0OFDtHvRc/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_109!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_109!.ts" (
        ren "Lectures\!lecture_109!.ts" "!lecture_109!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_109!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_109!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_109!.mp4
    title File Exists: !lecture_109!
)
set "lecture_110=Cost Sheet - One Shot - Recorded"

echo.
if not exist "Lectures\!lecture_110!.mp4" (
    title Downloading: !lecture_110!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_110!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiNGYwMzMzMDQtYjY2OS00MGU3LTgwZmUtMzIxYWRjMDBiYTMzIiwiZXhwIjoxNzUzNjE0ODc1fQ.cBlIsr8HkEuNbsZpYoT2dnaaxO3RFDRg2H3rVmsSiBE/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_110!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_110!.ts" (
        ren "Lectures\!lecture_110!.ts" "!lecture_110!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_110!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_110!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_110!.mp4
    title File Exists: !lecture_110!
)
mkdir "Notes" 2>nul
set "note_111=Budget"

echo.
if not exist "Notes\!note_111!.pdf" (
    title Downloading: !note_111!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_111!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_111!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/d617b44b-e71f-4097-a634-ebf8c50bab06.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_111!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_111!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_111!.pdf
    title File Exists: !note_111!
)
set "note_112=Marginal Costing"

echo.
if not exist "Notes\!note_112!.pdf" (
    title Downloading: !note_112!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_112!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_112!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ad5b4a15-3af7-445e-b694-4107a2aae21b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_112!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_112!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_112!.pdf
    title File Exists: !note_112!
)
set "note_113=Standard Costing"

echo.
if not exist "Notes\!note_113!.pdf" (
    title Downloading: !note_113!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_113!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_113!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/2ec4ca72-7abf-47ba-8f3c-20ced3a54024.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_113!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_113!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_113!.pdf
    title File Exists: !note_113!
)
set "note_114=Joint by Product  Class Notes "

echo.
if not exist "Notes\!note_114!.pdf" (
    title Downloading: !note_114!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_114!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_114!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/d1d1be26-1bbb-484b-acdd-a992fcc1da07.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_114!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_114!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_114!.pdf
    title File Exists: !note_114!
)
set "note_115=Process Costing Class Notes"

echo.
if not exist "Notes\!note_115!.pdf" (
    title Downloading: !note_115!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_115!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_115!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/c976467d-f0fb-4585-a354-6cfd4e078cba.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_115!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_115!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_115!.pdf
    title File Exists: !note_115!
)
set "note_116=Service Costing  Class Notes"

echo.
if not exist "Notes\!note_116!.pdf" (
    title Downloading: !note_116!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_116!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_116!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/12563980-df02-4e69-b2fd-8b65f3433d8d.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_116!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_116!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_116!.pdf
    title File Exists: !note_116!
)
set "note_117=Job Batch Costing Class Notes"

echo.
if not exist "Notes\!note_117!.pdf" (
    title Downloading: !note_117!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_117!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_117!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/75ecc0c2-8a12-4e77-bb34-9bff5fb3500b.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_117!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_117!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_117!.pdf
    title File Exists: !note_117!
)
set "note_118=Cost Accounting System  Class Notes"

echo.
if not exist "Notes\!note_118!.pdf" (
    title Downloading: !note_118!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_118!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_118!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/c060531e-99cc-460e-9ec8-9796dff3cae3.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_118!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_118!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_118!.pdf
    title File Exists: !note_118!
)
set "note_119=Overheads  Class Notes"

echo.
if not exist "Notes\!note_119!.pdf" (
    title Downloading: !note_119!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_119!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_119!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/ab6c45d2-2c2e-416f-82c9-ae3d17083085.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_119!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_119!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_119!.pdf
    title File Exists: !note_119!
)
set "note_120=Employee Cost and Direct Expenses _ Class Notes _ Udesh Regular Group 2 May 2024"

echo.
if not exist "Notes\!note_120!.pdf" (
    title Downloading: !note_120!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_120!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_120!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/2a7e3d0c-6b98-402a-b4dd-6be16218be77.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_120!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_120!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_120!.pdf
    title File Exists: !note_120!
)
set "note_121=5. Activity Based Costing.pdf"

echo.
if not exist "Notes\!note_121!.pdf" (
    title Downloading: !note_121!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_121!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_121!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/669b631a-902a-4f27-a8ce-59c65971cd2a.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_121!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_121!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_121!.pdf
    title File Exists: !note_121!
)
set "note_122=2. Material .pdf"

echo.
if not exist "Notes\!note_122!.pdf" (
    title Downloading: !note_122!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_122!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_122!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/e5d57e5e-a4a9-4f46-aa12-43a5422e1a78.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_122!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_122!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_122!.pdf
    title File Exists: !note_122!
)
set "note_123=Cost Sheet  Class Notes"

echo.
if not exist "Notes\!note_123!.pdf" (
    title Downloading: !note_123!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_123!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\Revision - One Shot\Notes\!note_123!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/5897f60d-7e19-43bc-aec4-519b76107723.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_123!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_123!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_123!.pdf
    title File Exists: !note_123!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m MCQ - PDF Only
echo -----------------------------------------------------------
mkdir "MCQ - PDF Only" 2>nul
cd /d "MCQ - PDF Only"
mkdir "Notes" 2>nul
set "note_124=Chap-12 Service Costing"

echo.
if not exist "Notes\!note_124!.pdf" (
    title Downloading: !note_124!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_124!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\MCQ - PDF Only\Notes\!note_124!.pdf"
    curl -L -o "\\?\!full_path!" "https://d2bps9p1kiy4ka.cloudfront.net/5eb393ee95fab7468a79d189/9e921d9f-39a1-4a42-896e-ab89cef5a7fb.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_124!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_124!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_124!.pdf
    title File Exists: !note_124!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m PYQ's - PDF Only
echo -----------------------------------------------------------
mkdir "PYQ's - PDF Only" 2>nul
cd /d "PYQ's - PDF Only"
mkdir "Notes" 2>nul
set "note_125=PYQ's  Cost and Management Accounting - PDF Only"

echo.
if not exist "Notes\!note_125!.pdf" (
    title Downloading: !note_125!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Notes: !note_125!
    pushd "%BATCH_ROOT%"
    set "full_path=%~dp0%batch%\Cost and Management Accounting\PYQ's - PDF Only\Notes\!note_125!.pdf"
    curl -L -o "\\?\!full_path!" "https://static.pw.live/5eb393ee95fab7468a79d189/8f3ee183-11ed-4fed-aec3-fe7b1f3d69db.pdf"
    popd
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !note_125!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !note_125!
    )
    
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !note_125!.pdf
    title File Exists: !note_125!
)
cd ..

echo.
echo !ESC![35m[CHAPTER]!ESC![0m Mentorship Session
echo -----------------------------------------------------------
mkdir "Mentorship Session" 2>nul
cd /d "Mentorship Session"
mkdir "Lectures" 2>nul
set "lecture_111=Mentorship Session 03 - Mentorship Session -Part 03- - Extra Class - Only Video"

echo.
if not exist "Lectures\!lecture_111!.mp4" (
    title Downloading: !lecture_111!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_111!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiYTdjOTcyZWMtMGRiMC00NjQzLWIwNzItZTY5OTAyMWJkNzlhIiwiZXhwIjoxNzUzNjE0ODc1fQ.juc1tu_OXuC7vzvPzS0TA9tY024TnZLLDnQlZ4JkW88/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_111!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_111!.ts" (
        ren "Lectures\!lecture_111!.ts" "!lecture_111!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_111!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_111!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_111!.mp4
    title File Exists: !lecture_111!
)
set "lecture_112=Mentorship Session 02 - Mentorship Session -Part 02- - Extra Class -Only Video"

echo.
if not exist "Lectures\!lecture_112!.mp4" (
    title Downloading: !lecture_112!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_112!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiOTQ1YjFmNmItN2MwYy00NTMyLWE2YmMtZGNiNzk0ZDcxMTc3IiwiZXhwIjoxNzUzNjE0ODc1fQ.tr4hfFzkS5K6tHeDYcGAyQpsJRgLqRH710fvJDEOI0Q/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_112!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_112!.ts" (
        ren "Lectures\!lecture_112!.ts" "!lecture_112!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_112!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_112!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_112!.mp4
    title File Exists: !lecture_112!
)
set "lecture_113=Mentorship Session 01 - Mentorship Session - Extra Class -Only video"

echo.
if not exist "Lectures\!lecture_113!.mp4" (
    title Downloading: !lecture_113!
    echo !ESC![33m[DOWNLOAD]!ESC![0m Lectures: !lecture_113!
    N_m3u8DL-RE "https://stream.pwjarvis.app/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlb0lkIjoiMGY4ZjNjYWEtZDEyMS00ODJjLTkxZDctYzg1OWJhOTI0N2Y2IiwiZXhwIjoxNzUzNjE0ODc1fQ.-rxZ5lwiRdYzs1nkAErKLtELbvA-1VBvFgr-SDhZDFo/hls/360/main.m3u8" --save-dir "Lectures" --save-name "!lecture_113!" -mt --live-pipe-mux --thread-count 16
    if exist "Lectures\!lecture_113!.ts" (
        ren "Lectures\!lecture_113!.ts" "!lecture_113!.mp4"
    )
    if !errorlevel! equ 0 (
        echo !ESC![32m[SUCCESS]!ESC![0m !lecture_113!
    ) else (
        echo !ESC![31m[FAILED]!ESC![0m !lecture_113!
    )
    cls
) else (
    echo !ESC![36m[EXISTS]!ESC![0m !lecture_113!.mp4
    title File Exists: !lecture_113!
)
cd ..
cd ..

echo.
echo -----------------------------------------------------------
echo !ESC![32m[COMPLETED]!ESC![0m All download tasks finished
echo -----------------------------------------------------------
title Download Complete
timeout /t 5