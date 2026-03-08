#!/usr/bin/env pwsh
# ArogyaMitra Startup Script
# This script starts both backend and frontend servers simultaneously

Write-Host "🚀 Starting ArogyaMitra..." -ForegroundColor Cyan
Write-Host ""

# Check if .env exists in backend
if (-not (Test-Path ".\backend\.env")) {
    Write-Host "⚠️  Warning: backend\.env file not found!" -ForegroundColor Yellow
    Write-Host "Please create a .env file in the backend folder with your GROQ_API_KEY" -ForegroundColor Yellow
    Write-Host ""
}

# Start Backend Server
Write-Host "📦 Starting Backend Server (Port 8000)..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\backend'; Write-Host '🔧 Backend Server Starting...' -ForegroundColor Magenta; uvicorn main:app --reload --host 0.0.0.0 --port 8000"

# Wait a moment for backend to initialize
Start-Sleep -Seconds 2

# Start Frontend Server
Write-Host "🎨 Starting Frontend Server (Port 5173)..." -ForegroundColor Blue
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PWD\frontend'; Write-Host '🎨 Frontend Server Starting...' -ForegroundColor Cyan; npm run dev"

Write-Host ""
Write-Host "✅ Both servers are starting in separate windows!" -ForegroundColor Green
Write-Host ""
Write-Host "📍 Backend:  http://localhost:8000" -ForegroundColor Yellow
Write-Host "📍 Frontend: http://localhost:5173" -ForegroundColor Yellow
Write-Host "📍 API Docs: http://localhost:8000/docs" -ForegroundColor Yellow
Write-Host ""
Write-Host "🔐 Default Login:" -ForegroundColor Cyan
Write-Host "   Username: admin" -ForegroundColor White
Write-Host "   Password: admin123" -ForegroundColor White
Write-Host ""
Write-Host "Press any key to exit this window (servers will continue running)..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
