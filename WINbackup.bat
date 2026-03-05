@echo off
setlocal EnableDelayedExpansion

:: Verificar se e Administrador
fltmc >nul 2>&1
if %errorlevel% neq 0 (
    echo ===============================================
    echo Este script precisa ser executado como ADMINISTRADOR.
    echo ===============================================
    echo Clique com o botao direito no arquivo e selecione:
    echo "Executar como administrador".
    echo.
    pause
    exit /b
)

:: Definir timestamp e variaveis
for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
    set "DD=%%a"
    set "MM=%%b"
    set "YYYY=%%c"
)
for /f "tokens=1-3 delims=:.," %%a in ("%time%") do (
    set "HH=%%a"
    set "Min=%%b"
    set "SS=%%c"
)

set "timestampFile=%YYYY%-%MM%-%DD%_%HH%%Min%%SS%"
set "scriptDir=%~dp0"
set "logFile=%scriptDir%drivers_backup_%timestampFile%.log"
set "backupDir=C:\DriversBackup"

echo [%date% %time%] [INFO] Inicio do script > "%logFile%"

:: ================= MENU PRINCIPAL =================
:menu
cls
echo.
echo  ===================================================
echo    BACKUP E RESTAURACAO - WINchester
echo  ===================================================
echo    Script disponibilizado por Canal WINchester
echo    www.youtube.com/WINchesterCanal
echo  ===================================================
echo.
echo   1 - Arquivos Pessoais (Backup)
echo   2 - DRIVERS (backup/restauracao)
echo   3 - Navegadores (backup/restauracao)
echo   4 - Acessar tutorial
echo   0 - Sair
echo.
set /p opcao=  Digite sua opcao: 

if "%opcao%"=="1" goto menuBackupArquivos
if "%opcao%"=="2" goto menuDrivers
if "%opcao%"=="3" goto menuNavegadores
if "%opcao%"=="4" goto abrirTutorial
if "%opcao%"=="0" goto sair

echo [%date% %time%] [ERRO] Opcao invalida: %opcao% >> "%logFile%"
echo Opcao invalida. Por favor, digite 1, 2, 3, 4 ou 0.
timeout /t 3 >nul
goto menu

:: ================= SUBMENU DRIVERS =================
:menuDrivers
cls
echo.
echo  ===================================================
echo    DRIVERS - backup/restauracao
echo  ===================================================
echo.
echo   1 - Fazer backup dos drivers
echo   2 - Restaurar drivers
echo   0 - Voltar ao menu principal
echo.
set /p opcaoDriver=  Digite sua opcao: 

if "!opcaoDriver!"=="1" goto selecionarPasta
if "!opcaoDriver!"=="2" goto restaurarDrivers
if "!opcaoDriver!"=="0" goto menu

echo Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menuDrivers

:: ================= BACKUP DOS DRIVERS =================
:selecionarPasta
echo.
echo -----------------------------------------------
echo Informe o destino do backup dos drivers.
echo Exemplo: L:\backup
echo -----------------------------------------------
set /p backupDestino=Destino: 

if "!backupDestino!"=="" (
    echo O destino nao pode ser vazio.
    goto selecionarPasta
)

if not exist "!backupDestino!" (
    echo O destino "!backupDestino!" nao foi encontrado.
    echo Verifique se o dispositivo esta conectado e tente novamente.
    echo [%date% %time%] [ERRO] Destino de backup de drivers nao encontrado: "!backupDestino!" >> "%logFile%"
    pause
    goto selecionarPasta
)

set "backupDir=!backupDestino!\DRIVERS"

if not exist "!backupDir!" (
    md "!backupDir!"
    echo [OK] Pasta DRIVERS criada em "!backupDestino!".
)

:iniciarBackup
echo.
echo Iniciando o backup dos drivers...
echo [%date% %time%] [INFO] Iniciando backup para: "!backupDir!" >> "%logFile%"

dism /online /export-driver /destination:"!backupDir!"
echo Backup concluido. Os drivers foram salvos em "!backupDir!".
echo [%date% %time%] [INFO] Backup concluido em: "!backupDir!" >> "%logFile%"
pause
goto menu

:: ================= RESTAURACAO DOS DRIVERS =================
:restaurarDrivers
echo.
set /p restoreDir=Digite o caminho onde estao os drivers para restauracao: 
echo [%date% %time%] [INFO] Pasta definida para restauracao: "%restoreDir%" >> "%logFile%"

if not exist "%restoreDir%" (
    echo Caminho da pasta de restauracao "%restoreDir%" invalido ou inexistente.
    echo [%date% %time%] [ERRO] Caminho de restauracao invalido: "%restoreDir%" >> "%logFile%"
    pause
    goto menu
)

echo Iniciando a restauracao dos drivers de "%restoreDir%"...
echo [%date% %time%] [INFO] Iniciando restauracao dos drivers >> "%logFile%"

for /r "%restoreDir%" %%f in (*.inf) do (
    echo Instalando driver: %%f
    echo [%date% %time%] [INFO] Instalando driver: %%f >> "%logFile%"
    pnputil /add-driver "%%f" /install
)

echo Restauracao concluida.
echo [%date% %time%] [INFO] Restauracao concluida para "%restoreDir%" >> "%logFile%"
pause
goto menu

:: ================= MENU BACKUP DE ARQUIVOS PESSOAIS =================
:menuBackupArquivos
cls
echo.
echo  ===================================================
echo    ARQUIVOS PESSOAIS - Backup
echo  ===================================================
echo.
echo Pastas disponiveis para backup:
echo   1 - Documentos
echo   2 - Imagens
echo   3 - Musicas
echo   4 - Videos
echo   5 - Downloads
echo   6 - Desktop
echo.
echo Modos de backup:
echo   C - Backup Completo (todas as pastas acima)
echo   S - Backup Seletivo (escolher pastas)
echo   0 - Voltar ao menu principal
echo.
set /p modoBackup=Digite sua opcao (C, S ou 0): 

if /i "!modoBackup!"=="c" goto backupCompleto
if /i "!modoBackup!"=="s" goto backupSeletivo
if "!modoBackup!"=="0" goto menu

echo Opcao invalida. Tente novamente.
timeout /t 2 >nul
goto menuBackupArquivos

:: ================= BACKUP COMPLETO =================
:backupCompleto
echo [%date% %time%] [INFO] Modo de backup selecionado: Completo >> "%logFile%"
set "bDocumentos=1"
set "bImagens=1"
set "bMusicas=1"
set "bVideos=1"
set "bDownloads=1"
set "bDesktop=1"
goto solicitarDestinoArquivos

:: ================= BACKUP SELETIVO =================
:backupSeletivo
cls
echo.
echo  ===================================================
echo    BACKUP SELETIVO
echo  ===================================================
echo.
echo Digite os numeros das pastas separados por virgula.
echo Exemplo: 1,3,5
echo.
echo   1 - Documentos
echo   2 - Imagens
echo   3 - Musicas
echo   4 - Videos
echo   5 - Downloads
echo   6 - Desktop
echo.
set /p selecao=Sua selecao: 

set "bDocumentos=0"
set "bImagens=0"
set "bMusicas=0"
set "bVideos=0"
set "bDownloads=0"
set "bDesktop=0"

echo !selecao! | find "1" >nul && set "bDocumentos=1"
echo !selecao! | find "2" >nul && set "bImagens=1"
echo !selecao! | find "3" >nul && set "bMusicas=1"
echo !selecao! | find "4" >nul && set "bVideos=1"
echo !selecao! | find "5" >nul && set "bDownloads=1"
echo !selecao! | find "6" >nul && set "bDesktop=1"

set "algumaSelecionada=0"
if "!bDocumentos!"=="1" set "algumaSelecionada=1"
if "!bImagens!"=="1" set "algumaSelecionada=1"
if "!bMusicas!"=="1" set "algumaSelecionada=1"
if "!bVideos!"=="1" set "algumaSelecionada=1"
if "!bDownloads!"=="1" set "algumaSelecionada=1"
if "!bDesktop!"=="1" set "algumaSelecionada=1"

if "!algumaSelecionada!"=="0" (
    echo Nenhuma pasta valida selecionada. Tente novamente.
    echo [%date% %time%] [ERRO] Nenhuma pasta valida selecionada: "!selecao!" >> "%logFile%"
    timeout /t 3 >nul
    goto backupSeletivo
)

echo [%date% %time%] [INFO] Modo de backup selecionado: Seletivo - Selecao: "!selecao!" >> "%logFile%"

:solicitarDestinoArquivos
echo.
echo -----------------------------------------------
echo Informe o destino do backup.
echo Exemplo: L:\backup
echo -----------------------------------------------
set /p destinoArquivos=Destino: 

if "!destinoArquivos!"=="" (
    echo O destino nao pode ser vazio.
    goto solicitarDestinoArquivos
)

if not exist "!destinoArquivos!" (
    echo O destino "!destinoArquivos!" nao foi encontrado.
    echo Verifique se o dispositivo esta conectado e tente novamente.
    echo [%date% %time%] [ERRO] Destino de backup de arquivos nao encontrado: "!destinoArquivos!" >> "%logFile%"
    pause
    goto solicitarDestinoArquivos
)

echo [%date% %time%] [INFO] Destino para backup de arquivos: "!destinoArquivos!" >> "%logFile%"

:executarBackupArquivos
cls
echo.
echo  ===================================================
echo    EXECUTANDO BACKUP DE ARQUIVOS...
echo  ===================================================
echo.
echo Destino: !destinoArquivos!
echo.
set "erros=0"
set "copiadas=0"

if "!bDocumentos!"=="1" (
    set "origem=%USERPROFILE%\Documents"
    set "destino=!destinoArquivos!\Documentos"
    echo [>] Copiando Documentos...
    echo [%date% %time%] [INFO] Copiando Documentos >> "%logFile%"
    if not exist "!destino!" mkdir "!destino!"
    robocopy "!origem!" "!destino!" /E /NP /NFL /NDL /R:2 /W:3
    if !errorlevel! leq 7 (
        echo [OK] Documentos copiados com sucesso.
        echo [%date% %time%] [INFO] Documentos copiados com sucesso >> "%logFile%"
        set /a copiadas+=1
    ) else (
        echo [ERRO] Falha ao copiar Documentos.
        echo [%date% %time%] [ERRO] Falha ao copiar Documentos >> "%logFile%"
        set /a erros+=1
    )
    echo.
)

if "!bImagens!"=="1" (
    set "origem=%USERPROFILE%\Pictures"
    set "destino=!destinoArquivos!\Imagens"
    echo [>] Copiando Imagens...
    echo [%date% %time%] [INFO] Copiando Imagens >> "%logFile%"
    if not exist "!destino!" mkdir "!destino!"
    robocopy "!origem!" "!destino!" /E /NP /NFL /NDL /R:2 /W:3
    if !errorlevel! leq 7 (
        echo [OK] Imagens copiadas com sucesso.
        echo [%date% %time%] [INFO] Imagens copiadas com sucesso >> "%logFile%"
        set /a copiadas+=1
    ) else (
        echo [ERRO] Falha ao copiar Imagens.
        echo [%date% %time%] [ERRO] Falha ao copiar Imagens >> "%logFile%"
        set /a erros+=1
    )
    echo.
)

if "!bMusicas!"=="1" (
    set "origem=%USERPROFILE%\Music"
    set "destino=!destinoArquivos!\Musicas"
    echo [>] Copiando Musicas...
    echo [%date% %time%] [INFO] Copiando Musicas >> "%logFile%"
    if not exist "!destino!" mkdir "!destino!"
    robocopy "!origem!" "!destino!" /E /NP /NFL /NDL /R:2 /W:3
    if !errorlevel! leq 7 (
        echo [OK] Musicas copiadas com sucesso.
        echo [%date% %time%] [INFO] Musicas copiadas com sucesso >> "%logFile%"
        set /a copiadas+=1
    ) else (
        echo [ERRO] Falha ao copiar Musicas.
        echo [%date% %time%] [ERRO] Falha ao copiar Musicas >> "%logFile%"
        set /a erros+=1
    )
    echo.
)

if "!bVideos!"=="1" (
    set "origem=%USERPROFILE%\Videos"
    set "destino=!destinoArquivos!\Videos"
    echo [>] Copiando Videos...
    echo [%date% %time%] [INFO] Copiando Videos >> "%logFile%"
    if not exist "!destino!" mkdir "!destino!"
    robocopy "!origem!" "!destino!" /E /NP /NFL /NDL /R:2 /W:3
    if !errorlevel! leq 7 (
        echo [OK] Videos copiados com sucesso.
        echo [%date% %time%] [INFO] Videos copiados com sucesso >> "%logFile%"
        set /a copiadas+=1
    ) else (
        echo [ERRO] Falha ao copiar Videos.
        echo [%date% %time%] [ERRO] Falha ao copiar Videos >> "%logFile%"
        set /a erros+=1
    )
    echo.
)

if "!bDownloads!"=="1" (
    set "origem=%USERPROFILE%\Downloads"
    set "destino=!destinoArquivos!\Downloads"
    echo [>] Copiando Downloads...
    echo [%date% %time%] [INFO] Copiando Downloads >> "%logFile%"
    if not exist "!destino!" mkdir "!destino!"
    robocopy "!origem!" "!destino!" /E /NP /NFL /NDL /R:2 /W:3
    if !errorlevel! leq 7 (
        echo [OK] Downloads copiados com sucesso.
        echo [%date% %time%] [INFO] Downloads copiados com sucesso >> "%logFile%"
        set /a copiadas+=1
    ) else (
        echo [ERRO] Falha ao copiar Downloads.
        echo [%date% %time%] [ERRO] Falha ao copiar Downloads >> "%logFile%"
        set /a erros+=1
    )
    echo.
)

if "!bDesktop!"=="1" (
    set "origem=%USERPROFILE%\Desktop"
    set "destino=!destinoArquivos!\Desktop"
    echo [>] Copiando Desktop...
    echo [%date% %time%] [INFO] Copiando Desktop >> "%logFile%"
    if not exist "!destino!" mkdir "!destino!"
    robocopy "!origem!" "!destino!" /E /NP /NFL /NDL /R:2 /W:3
    if !errorlevel! leq 7 (
        echo [OK] Desktop copiado com sucesso.
        echo [%date% %time%] [INFO] Desktop copiado com sucesso >> "%logFile%"
        set /a copiadas+=1
    ) else (
        echo [ERRO] Falha ao copiar Desktop.
        echo [%date% %time%] [ERRO] Falha ao copiar Desktop >> "%logFile%"
        set /a erros+=1
    )
    echo.
)

echo -----------------------------------------------
echo  Backup de arquivos concluido!
echo  Pastas copiadas com sucesso : !copiadas!
echo  Pastas com erro             : !erros!
echo  Destino                     : !destinoArquivos!
echo -----------------------------------------------
echo [%date% %time%] [INFO] Backup de arquivos finalizado. Sucesso: !copiadas! / Erros: !erros! >> "%logFile%"
pause
goto menu

:: ================= MENU NAVEGADORES =================
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
    goto setPerfilEdge
)
if "!opcaoRestNav!"=="2" (
    set "restNavegador=Chrome"
    set "restNavProcesso=chrome.exe"
    goto setPerfilChrome
)

:setPerfilEdge
set "restNavPerfil=%LOCALAPPDATA%\Microsoft\Edge\User Data\Default"
goto solicitarOrigemBookmark

:setPerfilChrome
set "restNavPerfil=%LOCALAPPDATA%\Google\Chrome\User Data\Default"
goto solicitarOrigemBookmark
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

set "bookmarkEncontrado="

:: Verifica se o usuario forneceu o arquivo diretamente
for %%I in ("!origemBookmark!") do set "bmNome=%%~nxI"
if /i "!bmNome!"=="Bookmarks" (
    set "bookmarkEncontrado=!origemBookmark!"
    echo [OK] Arquivo fornecido diretamente: !bookmarkEncontrado!
) else (
    echo [>] Procurando arquivo Bookmarks em "!origemBookmark!" e subpastas...
    call :buscarBookmark "!origemBookmark!"
)

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
echo     Origem : !bookmarkEncontrado!
echo     Destino: !restNavPerfil!

if not exist "!restNavPerfil!" md "!restNavPerfil!"

:: Faz backup do Bookmarks atual antes de sobrescrever
if exist "!restNavPerfil!\Bookmarks" (
    copy /Y "!restNavPerfil!\Bookmarks" "!restNavPerfil!\Bookmarks.bak" >nul 2>&1
)

:: Usa PowerShell para copiar, evitando problemas de permissao e caminho com espacos
powershell -NoProfile -Command "Copy-Item -Path \"!bookmarkEncontrado!\" -Destination \"!restNavPerfil!\Bookmarks\" -Force"
set "copyResult=!errorlevel!"
if !copyResult! equ 0 (
    echo [OK] Favoritos restaurados com sucesso!
    echo [%date% %time%] [INFO] Favoritos do !restNavegador! restaurados com sucesso >> "%logFile%"
    goto posRestauracao
)
echo [ERRO] Falha ao restaurar os favoritos. Codigo: !copyResult!
echo [%date% %time%] [ERRO] Falha ao restaurar favoritos do !restNavegador! - codigo !copyResult! >> "%logFile%"
pause
goto menu

:posRestauracao

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
for /f "usebackq delims=" %%F in (`dir /s /b "%~1\Bookmarks" 2^>nul`) do (
    if not defined bookmarkEncontrado (
        set "bookmarkEncontrado=%%F"
    )
)
exit /b

:: ================= ABRIR TUTORIAL =================
:abrirTutorial
echo Abrindo Winchester Canal no YouTube...
start https://youtu.be/ymOwOXdzHGQ
timeout /t 3 >nul
goto menu

:: ================= SAIR =================
:sair
echo Saindo...
echo [%date% %time%] [INFO] Script encerrado pelo usuario >> "%logFile%"
exit /b
