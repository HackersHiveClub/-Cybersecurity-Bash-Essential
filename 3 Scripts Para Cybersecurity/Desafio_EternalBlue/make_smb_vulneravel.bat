@echo off
:: Script para habilitar e desabilitar vulnerabilidades relacionadas ao SMBv1 e firewall
:: Use com cautela em ambientes controlados

:menu
echo ==============================================
echo Escolha uma das opções abaixo:
echo 1. Tornar o sistema vulnerável ao EternalBlue
echo 2. Restaurar a segurança do sistema
echo 3. Sair
echo ==============================================
set /p escolha="Digite sua escolha (1/2/3): "

if "%escolha%"=="1" goto vulneravel
if "%escolha%"=="2" goto seguro
if "%escolha%"=="3" exit
goto menu

:vulneravel
echo [!] Configurando o sistema para estado vulnerável...

:: Desativar o firewall
netsh advfirewall set allprofiles state off

:: Habilitar e configurar SMBv1
dism /online /norestart /enable-feature /featurename:SMB1Protocol

:: Configurar o serviço de compartilhamento de arquivos e impressoras (LanmanServer)
sc config LanmanServer start= auto
sc start LanmanServer

:: Reiniciar o serviço do servidor
net stop server
net start server

echo [!] O sistema está agora vulnerável ao EternalBlue.
echo [!] Reinicie o sistema para garantir que as alterações sejam aplicadas.
pause
goto menu

:seguro
echo [!] Restaurando a segurança do sistema...

:: Ativar o firewall
netsh advfirewall set allprofiles state on

:: Desabilitar SMBv1
dism /online /norestart /disable-feature /featurename:SMB1Protocol

:: Desativar e parar o serviço de compartilhamento de arquivos e impressoras
net stop server
sc config LanmanServer start= disabled

echo [!] O sistema foi protegido contra o EternalBlue.
echo [!] Reinicie o sistema para garantir que as alterações sejam aplicadas.
pause
goto menu

