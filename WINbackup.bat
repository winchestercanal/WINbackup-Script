@echo off
setlocal EnableDelayedExpansion

fltmc >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo  Este script precisa ser executado como ADMINISTRADOR.
    echo  Clique com o botao direito e selecione "Executar como administrador".
    echo.
    pause
    exit /b
)

for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
    set "DD=%%a" & set "MM=%%b" & set "YYYY=%%c"
)
for /f "tokens=1-3 delims=:., " %%a in ("%time%") do (
    set "HH=%%a" & set "Min=%%b" & set "SS=%%c"
)
set "TS=%YYYY%-%MM%-%DD%_%HH%%Min%%SS%"
set "scriptDir=%~dp0"
set "logFile=%scriptDir%backup_%TS%.log"
echo [%date% %time%] Inicio do script > "%logFile%"

:menu
cls
echo.
echo  +==================================================+
echo  ^|       BACKUP E RESTAURACAO - WINchester         ^|
echo  +==================================================+
echo.
echo  +--------------------------------------------------+
echo  ^|   Script disponibilizado por Canal WINchester   ^|
echo  ^|   Acesse: www.youtube.com/WINchesterCanal       ^|
echo  +--------------------------------------------------+
echo.
echo   1  -  Backup de Arquivos Pessoais
echo   2  -  Backup de Drivers
echo   3  -  Backup de Navegadores
echo   4  -  Ver Tutorial no YouTube
echo   0  -  Sair
echo.
echo  --------------------------------------------------
set /p opcao=  Digite sua opcao: 

if "!opcao!"=="1" goto menuArquivos
if "!opcao!"=="2" goto backupDrivers
if "!opcao!"=="3" goto menuNavegadores
if "!opcao!"=="4" goto abrirTutorial
if "!opcao!"=="0" goto sair

echo  Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menu


:: ================================================================
::                  1 - BACKUP DE ARQUIVOS PESSOAIS
:: ================================================================
:menuArquivos
cls
echo.
echo  +==================================================+
echo  ^|          BACKUP DE ARQUIVOS PESSOAIS            ^|
echo  +==================================================+
echo.
echo   C  -  Backup Completo
echo          (Documentos, Imagens, Musicas, Videos,
echo           Downloads e Desktop)
echo.
echo   S  -  Backup Seletivo
echo          (Escolher quais pastas copiar)
echo.
echo   0  -  Voltar
echo.
set /p modoArq=  Digite sua opcao (C, S ou 0): 

if /i "!modoArq!"=="c" (
    set "bDoc=1" & set "bImg=1" & set "bMus=1"
    set "bVid=1" & set "bDwn=1" & set "bDsk=1"
    goto pedirDestinoArquivos
)
if /i "!modoArq!"=="s" goto selecionarPastas
if "!modoArq!"=="0" goto menu

echo  Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menuArquivos

:selecionarPastas
cls
echo.
echo  +==================================================+
echo  ^|           BACKUP SELETIVO - PASTAS              ^|
echo  +==================================================+
echo.
echo  Digite os numeros desejados separados por virgula.
echo  Exemplo: 1,3,5
echo.
echo   1  -  Documentos
echo   2  -  Imagens
echo   3  -  Musicas
echo   4  -  Videos
echo   5  -  Downloads
echo   6  -  Desktop
echo.
set /p sel=  Sua selecao: 

set "bDoc=0" & set "bImg=0" & set "bMus=0"
set "bVid=0" & set "bDwn=0" & set "bDsk=0"

echo !sel! | find "1" >nul 2>&1 && set "bDoc=1"
echo !sel! | find "2" >nul 2>&1 && set "bImg=1"
echo !sel! | find "3" >nul 2>&1 && set "bMus=1"
echo !sel! | find "4" >nul 2>&1 && set "bVid=1"
echo !sel! | find "5" >nul 2>&1 && set "bDwn=1"
echo !sel! | find "6" >nul 2>&1 && set "bDsk=1"

if "!bDoc!!bImg!!bMus!!bVid!!bDwn!!bDsk!"=="000000" (
    echo  Nenhuma pasta valida selecionada. Tente novamente.
    timeout /t 3 >nul
    goto selecionarPastas
)

:pedirDestinoArquivos
echo.
echo  --------------------------------------------------
echo  Informe o destino do backup. Exemplo: L:\backup
echo  --------------------------------------------------
set /p dest=  Destino: 

if "!dest!"=="" (
    echo  O destino nao pode ser vazio.
    goto pedirDestinoArquivos
)
if not exist "!dest!" (
    echo  Destino nao encontrado. Verifique se o dispositivo
    echo  esta conectado e tente novamente.
    pause
    goto pedirDestinoArquivos
)

cls
echo.
echo  Iniciando backup de arquivos pessoais...
echo  Destino: !dest!
echo.
echo [%date% %time%] Backup de arquivos para "!dest!" >> "%logFile%"

if "!bDoc!"=="1" (
    echo  [>] Copiando Documentos...
    robocopy "%USERPROFILE%\Documents" "!dest!\Documentos" /E /NP /NFL /NDL /R:2 /W:3
    echo  [OK] Documentos concluido.
    echo [%date% %time%] Documentos copiados >> "%logFile%"
)
if "!bImg!"=="1" (
    echo  [>] Copiando Imagens...
    robocopy "%USERPROFILE%\Pictures" "!dest!\Imagens" /E /NP /NFL /NDL /R:2 /W:3
    echo  [OK] Imagens concluido.
    echo [%date% %time%] Imagens copiadas >> "%logFile%"
)
if "!bMus!"=="1" (
    echo  [>] Copiando Musicas...
    robocopy "%USERPROFILE%\Music" "!dest!\Musicas" /E /NP /NFL /NDL /R:2 /W:3
    echo  [OK] Musicas concluido.
    echo [%date% %time%] Musicas copiadas >> "%logFile%"
)
if "!bVid!"=="1" (
    echo  [>] Copiando Videos...
    robocopy "%USERPROFILE%\Videos" "!dest!\Videos" /E /NP /NFL /NDL /R:2 /W:3
    echo  [OK] Videos concluido.
    echo [%date% %time%] Videos copiados >> "%logFile%"
)
if "!bDwn!"=="1" (
    echo  [>] Copiando Downloads...
    robocopy "%USERPROFILE%\Downloads" "!dest!\Downloads" /E /NP /NFL /NDL /R:2 /W:3
    echo  [OK] Downloads concluido.
    echo [%date% %time%] Downloads copiados >> "%logFile%"
)
if "!bDsk!"=="1" (
    echo  [>] Copiando Desktop...
    robocopy "%USERPROFILE%\Desktop" "!dest!\Desktop" /E /NP /NFL /NDL /R:2 /W:3
    echo  [OK] Desktop concluido.
    echo [%date% %time%] Desktop copiado >> "%logFile%"
)

echo.
echo  --------------------------------------------------
echo  Backup de arquivos pessoais concluido!
echo  Destino: !dest!
echo  --------------------------------------------------
echo [%date% %time%] Backup de arquivos concluido >> "%logFile%"
pause
goto menu


:: ================================================================
::                  2 - BACKUP DE DRIVERS
:: ================================================================
:backupDrivers
cls
echo.
echo  +==================================================+
echo  ^|              BACKUP DE DRIVERS                  ^|
echo  +==================================================+
echo.
echo  --------------------------------------------------
echo  Informe o destino do backup. Exemplo: L:\backup
echo  --------------------------------------------------
set /p destDrv=  Destino: 

if "!destDrv!"=="" (
    echo  O destino nao pode ser vazio.
    goto backupDrivers
)
if not exist "!destDrv!" (
    echo  Destino nao encontrado. Verifique se o dispositivo
    echo  esta conectado e tente novamente.
    pause
    goto backupDrivers
)

cls
echo.
echo  Iniciando backup dos drivers...
echo  Destino: !destDrv!\Drivers
echo.
echo [%date% %time%] Backup de drivers para "!destDrv!\Drivers" >> "%logFile%"

if not exist "!destDrv!\Drivers" mkdir "!destDrv!\Drivers"
dism /online /export-driver /destination:"!destDrv!\Drivers"

echo.
echo  --------------------------------------------------
echo  Backup de drivers concluido!
echo  Destino: !destDrv!\Drivers
echo  --------------------------------------------------
echo [%date% %time%] Backup de drivers concluido >> "%logFile%"
pause
goto menu


:: ================================================================
::                  3 - BACKUP DE NAVEGADORES
:: ================================================================
:menuNavegadores
cls
echo.
echo  ===================================================
echo    NAVEGADORES - backup/restauracao
echo  ===================================================
echo.
echo   1 - Backup de favoritos
echo   2 - Restaurar favoritos
echo   0 - Voltar ao menu principal
echo.
set /p opcaoNavMenu=  Digite sua opcao: 

if "!opcaoNavMenu!"=="1" goto menuBackupNavegadores
if "!opcaoNavMenu!"=="2" goto menuRestaurarNavegadores
if "!opcaoNavMenu!"=="0" goto menu

echo Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menuNavegadores

:: ================= MENU BACKUP DE NAVEGADORES =================
:menuBackupNavegadores
cls
echo.
echo  ===================================================
echo    BACKUP DE FAVORITOS
echo  ===================================================
echo.
echo Navegadores disponiveis:
echo   1 - Microsoft Edge
echo   2 - Google Chrome
echo   3 - Edge e Chrome (ambos)
echo   0 - Voltar ao menu principal
echo.
set /p opcaoNav=Digite sua opcao: 

if "!opcaoNav!"=="1" goto backupEdge
if "!opcaoNav!"=="2" goto backupChrome
if "!opcaoNav!"=="3" goto backupAmbos
if "!opcaoNav!"=="0" goto menu

echo Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menuBackupNavegadores

:backupEdge
set "fazerEdge=1"
set "fazerChrome=0"
goto solicitarDestinoNavegadores

:backupChrome
set "fazerEdge=0"
set "fazerChrome=1"
goto solicitarDestinoNavegadores

:backupAmbos
set "fazerEdge=1"
set "fazerChrome=1"
goto solicitarDestinoNavegadores

:solicitarDestinoNavegadores
echo.
echo -----------------------------------------------
echo Informe o destino do backup dos navegadores.
echo Exemplo: L:\backup
echo -----------------------------------------------
set /p destinoNav=Destino: 

if "!destinoNav!"=="" (
    echo O destino nao pode ser vazio.
    goto solicitarDestinoNavegadores
)

if not exist "!destinoNav!" (
    echo O destino "!destinoNav!" nao foi encontrado.
    echo Verifique se o dispositivo esta conectado e tente novamente.
    echo [%date% %time%] [ERRO] Destino de navegadores nao encontrado: "!destinoNav!" >> "%logFile%"
    pause
    goto solicitarDestinoNavegadores
)

echo [%date% %time%] [INFO] Destino para backup de navegadores: "!destinoNav!" >> "%logFile%"

:executarBackupNavegadores
cls
echo.
echo  ===================================================
echo    EXECUTANDO BACKUP DE NAVEGADORES...
echo  ===================================================
echo.
set "errosNav=0"
set "copiadasNav=0"

if "!fazerEdge!"=="1" (
    echo [>] Verificando Microsoft Edge...
    set "edgePerfilBase=%LOCALAPPDATA%\Microsoft\Edge\User Data"
    if not exist "!edgePerfilBase!" (
        echo [AVISO] Microsoft Edge nao encontrado nesta maquina. Pulando.
        echo [%date% %time%] [AVISO] Edge nao encontrado >> "%logFile%"
    ) else (
        set "edgeFav=!edgePerfilBase!\Default\Bookmarks"
        set "edgeDestinoFav=!destinoNav!\Navegadores\Edge\Favoritos"
        if not exist "!edgeFav!" (
            echo [AVISO] Arquivo de favoritos do Edge nao encontrado. Pulando.
            echo [%date% %time%] [AVISO] Favoritos do Edge nao encontrados >> "%logFile%"
        ) else (
            if not exist "!edgeDestinoFav!" mkdir "!edgeDestinoFav!"
            copy /Y "!edgeFav!" "!edgeDestinoFav!\Bookmarks" >nul
            if !errorlevel! equ 0 (
                echo [OK] Favoritos do Edge copiados.
                echo [%date% %time%] [INFO] Favoritos do Edge copiados >> "%logFile%"
            ) else (
                echo [ERRO] Falha ao copiar favoritos do Edge.
                echo [%date% %time%] [ERRO] Falha ao copiar favoritos do Edge >> "%logFile%"
                set /a errosNav+=1
            )
        )
        for /d %%P in ("!edgePerfilBase!\Profile *") do (
            set "nomePerfil=%%~nxP"
            set "favPerfil=%%P\Bookmarks"
            if exist "!favPerfil!" (
                set "destPerfil=!destinoNav!\Navegadores\Edge\!nomePerfil!"
                if not exist "!destPerfil!" mkdir "!destPerfil!"
                copy /Y "!favPerfil!" "!destPerfil!\Bookmarks" >nul
                if !errorlevel! equ 0 (
                    echo [OK] Favoritos do Edge [!nomePerfil!] copiados.
                    echo [%date% %time%] [INFO] Favoritos do Edge [!nomePerfil!] copiados >> "%logFile%"
                )
            )
        )
        set /a copiadasNav+=1
        echo.
    )
)

if "!fazerChrome!"=="1" (
    echo [>] Verificando Google Chrome...
    set "chromePerfilBase=%LOCALAPPDATA%\Google\Chrome\User Data"
    if not exist "!chromePerfilBase!" (
        echo [AVISO] Google Chrome nao encontrado nesta maquina. Pulando.
        echo [%date% %time%] [AVISO] Chrome nao encontrado >> "%logFile%"
    ) else (
        set "chromeFav=!chromePerfilBase!\Default\Bookmarks"
        set "chromeDestinoFav=!destinoNav!\Navegadores\Chrome\Favoritos"
        if not exist "!chromeFav!" (
            echo [AVISO] Arquivo de favoritos do Chrome nao encontrado. Pulando.
            echo [%date% %time%] [AVISO] Favoritos do Chrome nao encontrados >> "%logFile%"
        ) else (
            if not exist "!chromeDestinoFav!" mkdir "!chromeDestinoFav!"
            copy /Y "!chromeFav!" "!chromeDestinoFav!\Bookmarks" >nul
            if !errorlevel! equ 0 (
                echo [OK] Favoritos do Chrome copiados.
                echo [%date% %time%] [INFO] Favoritos do Chrome copiados >> "%logFile%"
            ) else (
                echo [ERRO] Falha ao copiar favoritos do Chrome.
                echo [%date% %time%] [ERRO] Falha ao copiar favoritos do Chrome >> "%logFile%"
                set /a errosNav+=1
            )
        )
        for /d %%P in ("!chromePerfilBase!\Profile *") do (
            set "nomePerfil=%%~nxP"
            set "favPerfil=%%P\Bookmarks"
            if exist "!favPerfil!" (
                set "destPerfil=!destinoNav!\Navegadores\Chrome\!nomePerfil!"
                if not exist "!destPerfil!" mkdir "!destPerfil!"
                copy /Y "!favPerfil!" "!destPerfil!\Bookmarks" >nul
                if !errorlevel! equ 0 (
                    echo [OK] Favoritos do Chrome [!nomePerfil!] copiados.
                    echo [%date% %time%] [INFO] Favoritos do Chrome [!nomePerfil!] copiados >> "%logFile%"
                )
            )
        )
        set /a copiadasNav+=1
        echo.
    )
)

echo.
echo  ################################################
echo  #        BACKUP DE FAVORITOS CONCLUIDO!        #
echo  ################################################
echo  Destino: !destinoNav!\Navegadores
echo.
echo  ************************************************
echo  *                                              *
echo  *   ATENCAO: SENHAS NAO SAO SALVAS             *
echo  *   AUTOMATICAMENTE!                           *
echo  *                                              *
echo  *   Por questoes de seguranca, as senhas       *
echo  *   precisam ser exportadas MANUALMENTE        *
echo  *   em cada navegador.                         *
echo  *                                              *
echo  ************************************************
echo.
if "!fazerEdge!"=="1" (
    echo  [ MICROSOFT EDGE ]
    echo  Acesse no Edge e clique em "Exportar senhas":
    echo.
    echo     edge://settings/autofill/passwords
    echo.
)
if "!fazerChrome!"=="1" (
    echo  [ GOOGLE CHROME ]
    echo  Acesse no Chrome e clique em "Exportar senhas":
    echo.
    echo     chrome://password-manager/settings
    echo.
)
echo  ------------------------------------------------
echo  Salve o arquivo exportado no destino do backup:
echo  !destinoNav!
echo  ------------------------------------------------
echo.
echo [%date% %time%] [INFO] Backup de navegadores finalizado. Sucesso: !copiadasNav! / Erros: !errosNav! >> "%logFile%"
echo [%date% %time%] [AVISO] Usuario orientado a exportar senhas manualmente >> "%logFile%"
pause
goto menu

:: ================= MENU RESTAURAR NAVEGADORES =================
:menuRestaurarNavegadores
cls
echo.
echo  ===================================================
echo    RESTAURAR FAVORITOS DE NAVEGADORES
echo  ===================================================
echo.
echo Qual navegador deseja restaurar?
echo.
echo   1 - Microsoft Edge
echo   2 - Google Chrome
echo   0 - Voltar ao menu principal
echo.
set /p opcaoRestNav=  Digite sua opcao: 

if "!opcaoRestNav!"=="1" (
    set "restNavegador=Edge"
    set "restNavProcesso=msedge.exe"
    set "restNavPerfil=%LOCALAPPDATA%\Microsoft\Edge\User Data\Default"
    goto solicitarOrigemBookmark
)
if "!opcaoRestNav!"=="2" (
    set "restNavegador=Chrome"
    set "restNavProcesso=chrome.exe"
    set "restNavPerfil=%LOCALAPPDATA%\Google\Chrome\User Data\Default"
    goto solicitarOrigemBookmark
)
if "!opcaoRestNav!"=="0" goto menu

echo Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menuRestaurarNavegadores

:: ================= SOLICITAR ORIGEM DO BOOKMARK =================
:solicitarOrigemBookmark
echo.
echo -----------------------------------------------
echo Informe o caminho da pasta de backup dos favoritos.
echo Pode ser uma pasta ou o arquivo diretamente.
echo Exemplo: L:\backup\Navegadores
echo -----------------------------------------------
set /p origemBookmark=Origem: 

if "!origemBookmark!"=="" (
    echo O caminho nao pode ser vazio.
    goto solicitarOrigemBookmark
)

if not exist "!origemBookmark!" (
    echo O caminho "!origemBookmark!" nao foi encontrado.
    echo Verifique se o dispositivo esta conectado e tente novamente.
    echo [%date% %time%] [ERRO] Origem de bookmark nao encontrada: "!origemBookmark!" >> "%logFile%"
    pause
    goto solicitarOrigemBookmark
)

echo [%date% %time%] [INFO] Buscando Bookmarks em: "!origemBookmark!" >> "%logFile%"
echo.
echo [>] Procurando arquivo de favoritos em "!origemBookmark!" e subpastas...

set "bookmarkEncontrado="
call :buscarBookmark "!origemBookmark!"

if not defined bookmarkEncontrado (
    echo.
    echo [ERRO] Arquivo Bookmarks nao encontrado em "!origemBookmark!" nem em suas subpastas.
    echo [%date% %time%] [ERRO] Bookmarks nao encontrado em "!origemBookmark!" >> "%logFile%"
    pause
    goto solicitarOrigemBookmark
)

echo [OK] Arquivo encontrado: !bookmarkEncontrado!
echo.

echo [>] Verificando se o !restNavegador! esta aberto...
tasklist /fi "imagename eq !restNavProcesso!" 2>nul | find /i "!restNavProcesso!" >nul
if !errorlevel! equ 0 (
    echo [AVISO] O !restNavegador! esta aberto. Encerrando para evitar conflitos...
    echo [%date% %time%] [INFO] Encerrando !restNavProcesso! antes da restauracao >> "%logFile%"
    taskkill /f /im "!restNavProcesso!" >nul 2>&1
    timeout /t 2 >nul
    echo [OK] !restNavegador! encerrado.
) else (
    echo [OK] !restNavegador! nao esta em execucao.
)

echo.
echo [>] Restaurando favoritos para o !restNavegador!...

if not exist "!restNavPerfil!" mkdir "!restNavPerfil!"

set "destBookmark=!restNavPerfil!\Bookmarks"
copy /Y "!bookmarkEncontrado!" "!destBookmark!" >nul 2>&1
if exist "!destBookmark!" (
    echo [OK] Favoritos restaurados com sucesso!
    echo [%date% %time%] [INFO] Favoritos do !restNavegador! restaurados com sucesso >> "%logFile%"
) else (
    echo [ERRO] Falha ao restaurar os favoritos.
    echo [%date% %time%] [ERRO] Falha ao restaurar favoritos do !restNavegador! >> "%logFile%"
    pause
    goto menu
)

echo.
echo  ################################################
echo  #      RESTAURACAO DE FAVORITOS CONCLUIDA!     #
echo  ################################################
echo.
echo  ************************************************
echo  *                                              *
echo  *   ATENCAO: SENHAS NAO SAO RESTAURADAS        *
echo  *   AUTOMATICAMENTE!                           *
echo  *                                              *
echo  *   Por questoes de seguranca, as senhas       *
echo  *   precisam ser importadas MANUALMENTE        *
echo  *   em cada navegador.                         *
echo  *                                              *
echo  ************************************************
echo.
if "!restNavegador!"=="Edge" (
    echo  [ MICROSOFT EDGE ]
    echo  Acesse no Edge e clique em "Importar senhas":
    echo.
    echo     edge://settings/autofill/passwords
    echo.
)
if "!restNavegador!"=="Chrome" (
    echo  [ GOOGLE CHROME ]
    echo  Acesse no Chrome e clique em "Importar senhas":
    echo.
    echo     chrome://password-manager/settings
    echo.
)
echo  ------------------------------------------------
echo  Importe o arquivo de senhas exportado no backup.
echo  ------------------------------------------------
echo.
echo [%date% %time%] [AVISO] Usuario orientado a importar senhas manualmente apos restauracao >> "%logFile%"
pause
goto menu

:: ================= SUBROTINA: BUSCAR BOOKMARK =================
:buscarBookmark
for /r "%~1" %%F in (Bookmarks) do (
    if not defined bookmarkEncontrado (
        set "bookmarkEncontrado=%%F"
    )
)
exit /b


:: ================================================================
::                  4 - TUTORIAL
:: ================================================================
:abrirTutorial
echo.
echo  Abrindo Canal WINchester no YouTube...
start https://youtu.be/ymOwOXdzHGQ
timeout /t 3 >nul
goto menu


:: ================================================================
::                  SAIR
:: ================================================================
:sair
echo.
echo  Saindo...
echo [%date% %time%] Script encerrado pelo usuario >> "%logFile%"
exit /b
