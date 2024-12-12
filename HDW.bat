@echo off
title NatCode
goto menu

:banner
echo ========================================
echo  HERRAMIENTA PARA EL SISTEMA OPERATIVO    
echo ========================================
echo 	DESARROLLADO POR NATANAEL M.S        
echo ========================================
echo 			VERSION 1.0.9	     
echo ========================================
goto :eof

:menu
cls
call :banner
echo =   
echo =	SECCION DE VERIFICACION                                   
echo =  1. Verificar el Disco Duro          
echo =  2. Verificar el Sistema de Archivo
echo =  3. Verificar la imagen de Windows
echo =
echo =	SECCION DE CONTRASENAS 
echo =  4. Claves wifi guardadas 
echo =
echo =	SECCION DE ELIMINACION Y OPTIMIZACION
echo =  5. Eliminar datos temporales 
echo =  6. Liberar memoria
echo =  7. Optimizar Disco
echo = 
echo =	SECCION DE EXTRAS                
echo =  8. Apagar sistema                    
echo =  9. Salir                             
echo =                                      
echo ========================================
echo.
set /p opcion=Opcion=
if "%opcion%"=="1" goto disco
if "%opcion%"=="2" goto sistemaArchivo
if "%opcion%"=="3" goto imagenWindows
if "%opcion%"=="4" goto credenciales_wifi
if "%opcion%"=="5" goto datos_temporales
if "%opcion%"=="6" goto datos_innecesarios
if "%opcion%"=="7" goto optimizar_disco
if "%opcion%"=="8" goto apagar
if "%opcion%"=="9" goto salir
goto menu

:disco
cls
call :banner
echo =                                      
echo =  1. Corregir errores en el disco         
echo =  2. Muestra información detallada sobre el proceso. 
echo =  3. Regresar al menu                       
echo =                                      
echo ========================================
echo.
set /p unidad=Disco  =
set /p opcion=Accion =

if "%opcion%"=="1" goto disco_corregir
if "%opcion%"=="2" goto disco_informacion
if "%opcion%"=="3" goto regresar

pause
goto menu

:disco_corregir
cls
call :banner
chkdsk %unidad%: /f
goto menu
:disco_informacion
cls
call :banner
chkdsk %unidad% /v
goto menu

:regresar
goto menu

:sistemaArchivo
cls
call :banner
sfc /SCANNOW
goto menu

:imagenWindows
cls
call :banner
dism /Online /Cleanup-Image /CheckHealth
goto menu

:credenciales_wifi
cls
call :banner
netsh wlan show profiles
set /p perfil=Perfil=
netsh wlan show profiles name=%perfil% key=clear | findstr Key
pause
goto menu

:datos_temporales
cls
call :banner
del /F /Q %temp%\*
echo SE HA ELIMINADO LOS DATOS TEMPORALES
pause
cls
goto menu


:datos_innecesarios
cls
call :banner
echo SE INICIARA EL SISTEMA PROPIO DE WINDOWS PARA LA LIMPIEZA
cleanmgr
pause
cls
goto menu

:optimizar_disco
cls
call :banner
echo.
echo INGRESAR NOMBRE DEL DISCO A OPTIMIZAR 
echo (ESTA OPERACION PUEDE TOMAR TIEMPO)
set /p unidad=Disco  =

if "%unidad%"==nul goto menu

Defrag %unidad%:
pause
goto menu

:apagar
call :banner
echo EL SISTEMA SE APAGARÁ EN 10 SEGUNDOS
shutdown -s -t 10 -c "Esto se está apagando"
goto menu

:salir 
exit
