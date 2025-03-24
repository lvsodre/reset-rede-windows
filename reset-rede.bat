@echo off
echo ========================================
echo  Reset de Configuracoes de Rede Windows
echo ========================================
echo.

:: Verificar privilégios de administrador
NET SESSION >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Este script precisa ser executado como Administrador!
    echo Clique com o botao direito no arquivo e selecione "Executar como administrador"
    echo.
    pause
    exit
)

echo Iniciando processo de reset da rede...
echo.

echo 1. Liberando configuracoes de IP...
ipconfig /release
echo.

echo 2. Limpando cache DNS...
ipconfig /flushdns
echo.

echo 3. Renovando configuracoes de IP...
ipconfig /renew
echo.

echo 4. Redefinindo a pilha Winsock...
netsh winsock reset
echo.

echo 5. Redefinindo a pilha TCP/IP...
netsh int ip reset
echo.

echo 6. Redefinindo firewall para as configuracoes padrao...
netsh advfirewall reset
echo.

echo 7. Liberando e renovando configuracoes de DHCP...
ipconfig /release
ipconfig /renew
echo.

echo 8. Limpando o cache do resolvedor DNS...
ipconfig /flushdns
echo.

echo 9. Redefinindo todas as interfaces de rede...
netsh int reset all
echo.

echo 10. Limpando rotas persistentes...
netsh interface ip delete destinationcache
echo.

echo =================================================
echo Processo de reset da rede concluido com sucesso!
echo O computador precisa ser reiniciado para aplicar
echo todas as alteracoes.
echo =================================================
echo.

set /p reiniciar="Deseja reiniciar o computador agora? (S/N): "
if /i "%reiniciar%"=="S" (
    echo Reiniciando o computador em 5 segundos...
    shutdown /r /t 5 /c "Reiniciando para aplicar configuracoes de rede"
) else (
    echo Lembre-se de reiniciar o computador manualmente para aplicar todas as alteracoes.
    pause
)