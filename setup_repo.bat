@echo off
:: ══════════════════════════════════════════════════════════
::  setup_repo.bat — Bitcoin Educativo
::  Ejecutar UNA SOLA VEZ antes del hackathon (solo el Tech Lead)
::  Requisito: tener Git instalado y haber creado el repo en GitHub
:: ══════════════════════════════════════════════════════════

echo.
echo =============================================
echo   SETUP REPOSITORIO — Bitcoin Educativo
echo =============================================
echo.

:: ── PASO 1: Verificar que Git está instalado ──
git --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git no está instalado.
    echo Descárgalo en: https://git-scm.com/download/win
    pause
    exit /b
)
echo [OK] Git detectado.

:: ── PASO 2: Inicializar repo local ──
git init
echo [OK] Repositorio local inicializado.

:: ── PASO 3: Configurar rama principal como "main" ──
git checkout -b main
echo [OK] Rama principal: main

:: ── PASO 4: Primer commit con la estructura base ──
git add .
git commit -m "feat: estructura base del proyecto Bitcoin Educativo"
echo [OK] Primer commit realizado.

:: ── PASO 5: Conectar con GitHub ──
echo.
echo Ingresa la URL de tu repositorio GitHub:
echo Ejemplo: https://github.com/tuusuario/bitcoin-educativo.git
echo.
set /p REPO_URL="URL del repo: "

git remote add origin %REPO_URL%
echo [OK] Repositorio remoto conectado.

:: ── PASO 6: Subir al repo ──
git push -u origin main
echo [OK] Código subido a GitHub.

echo.
echo =============================================
echo   SETUP COMPLETO
echo =============================================
echo.
echo Próximos pasos:
echo 1. Ve a GitHub y agrega a tus compañeros como colaboradores
echo    Repo → Settings → Collaborators → Add people
echo.
echo 2. Comparte este comando con Dev 2 y el Artista:
echo    git clone %REPO_URL%
echo.
echo 3. Recuérdales sus 3 comandos:
echo    git pull          (antes de empezar)
echo    git add .         (guardar cambios)
echo    git commit -m ""  (describir qué hicieron)
echo    git push          (subir cambios)
echo.
pause
