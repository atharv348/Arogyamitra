#!/usr/bin/env pwsh
# GitHub Setup Helper Script

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   GitHub Setup for ArogyaMitra" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "✅ Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git is not installed!" -ForegroundColor Red
    Write-Host "   Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Check if already initialized
if (Test-Path ".git") {
    Write-Host "✅ Git repository already initialized" -ForegroundColor Green
    
    # Check current remote
    $remote = git remote get-url origin 2>$null
    if ($remote) {
        Write-Host "📍 Current remote: $remote" -ForegroundColor Yellow
    } else {
        Write-Host "⚠️  No remote repository configured" -ForegroundColor Yellow
    }
} else {
    Write-Host "🔧 Initializing Git repository..." -ForegroundColor Blue
    git init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Next Steps:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Create a new repository on GitHub:" -ForegroundColor Yellow
Write-Host "   👉 Go to: https://github.com/new" -ForegroundColor White
Write-Host "   Repository name: arogyamitra" -ForegroundColor White
Write-Host "   Description: AI-Powered Fitness & Wellness Platform" -ForegroundColor White
Write-Host "   ⚠️  DO NOT initialize with README, .gitignore, or license" -ForegroundColor Red
Write-Host ""

Write-Host "2. After creating the repository, run these commands:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   # Add all files (excluding .env and other ignored files)" -ForegroundColor Gray
Write-Host "   git add ." -ForegroundColor White
Write-Host ""
Write-Host "   # Make your first commit" -ForegroundColor Gray
Write-Host "   git commit -m ""Initial commit: ArogyaMitra platform""" -ForegroundColor White
Write-Host ""
Write-Host "   # Add GitHub as remote (replace YOUR_USERNAME)" -ForegroundColor Gray
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/arogyamitra.git" -ForegroundColor White
Write-Host ""
Write-Host "   # Push to GitHub" -ForegroundColor Gray
Write-Host "   git push -u origin main" -ForegroundColor White
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Or use this quick command:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$answer = Read-Host "Do you want to add and commit files now? (y/n)"

if ($answer -eq "y" -or $answer -eq "Y") {
    Write-Host ""
    Write-Host "📦 Adding files to git..." -ForegroundColor Blue
    git add .
    
    Write-Host "📝 Creating commit..." -ForegroundColor Blue
    git commit -m "Initial commit: ArogyaMitra AI-powered fitness platform"
    
    Write-Host ""
    Write-Host "✅ Files committed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Now run:" -ForegroundColor Yellow
    Write-Host "git remote add origin https://github.com/YOUR_USERNAME/arogyamitra.git" -ForegroundColor White
    Write-Host "git push -u origin main" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "Skipped. Run the commands above when ready." -ForegroundColor Gray
}

Write-Host ""
Write-Host "📚 Important Notes:" -ForegroundColor Cyan
Write-Host "   • Your .env file is excluded from git (keeps API keys safe)" -ForegroundColor White
Write-Host "   • Contributors should copy .env.example to .env" -ForegroundColor White
Write-Host "   • Check CONTRIBUTING.md for contribution guidelines" -ForegroundColor White
Write-Host ""
