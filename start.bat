@echo off
REM ArogyaMitra Startup Script (Batch version)
REM This script starts both backend and frontend servers simultaneously

echo.
echo Starting ArogyaMitra...
echo.

REM Start Backend Server in new window
echo Starting Backend Server (Port 8000)...
start "ArogyaMitra Backend" cmd /k "cd /d %~dp0backend && echo Backend Server Starting... && uvicorn main:app --reload --host 0.0.0.0 --port 8000"

REM Wait a moment
timeout /t 2 /nobreak >nul

REM Start Frontend Server in new window
echo Starting Frontend Server (Port 5173)...
start "ArogyaMitra Frontend" cmd /k "cd /d %~dp0frontend && echo Frontend Server Starting... && npm run dev"

echo.
echo ========================================
echo Both servers are starting!
echo.
echo Backend:  http://localhost:8000
echo Frontend: http://localhost:5173
echo API Docs: http://localhost:8000/docs
echo.
echo Default Login:
echo   Username: admin
echo   Password: admin123
echo ========================================
echo.
pause
