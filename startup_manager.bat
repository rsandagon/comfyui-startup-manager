@echo off
setlocal enabledelayedexpansion
echo ******************************** 
echo * ComfyUI Startup Manager      *
echo *                              *
echo * Author: rsandagon            *
echo * Twitter: @rsandagon          *
echo *                              *
echo ******************************** 

set "folderPath=ComfyUI\custom_nodes" :: Replace with the actual folder path

cd /d "%folderPath%"

echo.
echo **************** 
echo 1/3 ** Available Custom Nodes **

for /d %%d in (*) do echo %%d

echo.
echo **************** 
echo 2/3 Would you like to start the manager? [Y/N]
set /p choice=
if /i "%choice%"=="n" goto managed

set "searchString=.disabled"
set pick="n"
for /d %%f in (*) do (
    if /i not "%%~nxf"=="%%~nf.disabled" (
        echo **** "%%~nf" is ENABLED
        echo Do you want to disable "%%~nf"? [Y/N]
        set /p pick=
        if /i "!pick!"=="y" (
            echo ** "%%~nxf" disabled
            ren "%%~nxf" "%%~nxf.disabled"
        ) 
    ) else (
        echo **** "%%~nf" is DISABLED
        echo Do you want to enable "%%~nf"? [Y/N]
        set /p pick=
        if /i "!pick!"=="y" (
            echo ** "%%~nxf" enabled
            ren "%%~nxf" "%%~nf"
        ) 
    ) 
)

echo.
echo **************** 
echo All custom node modules managed!
:managed

cd ..
cd ..

echo.
echo **************** 
echo 3/3 Would you like to run ComfyUI with gpu? [Y/N]
set /p choice=
if /i "%choice%"=="y" (
    call run_nvidia_gpu.bat
) else (
    call run_cpu.bat
)

pause