#!/usr/bin/env pwsh
# Push existing project to GitHub repository

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Push to GitHub Repository" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get repository URL from user
Write-Host "Enter your GitHub repository URL:" -ForegroundColor Yellow
Write-Host "Example: https://github.com/YOUR_USERNAME/arogyamitra.git" -ForegroundColor Gray
Write-Host ""
$repoUrl = Read-Host "Repository URL"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "❌ No URL provided. Exiting." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🔧 Setting up Git..." -ForegroundColor Blue

# Initialize git if not already done
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Gray
    git init
    git branch -M main
}

# Add remote
Write-Host "Adding remote origin..." -ForegroundColor Gray
try {
    git remote add origin $repoUrl 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Remote 'origin' already exists, updating..." -ForegroundColor Yellow
        git remote set-url origin $repoUrl
    }
} catch {
    git remote set-url origin $repoUrl
}

# Pull the README from GitHub first
Write-Host ""
Write-Host "📥 Pulling README from GitHub..." -ForegroundColor Blue
git pull origin main --allow-unrelated-histories

# Add all files
Write-Host ""
Write-Host "📦 Adding all project files..." -ForegroundColor Blue
git add .

# Show what will be committed
Write-Host ""
Write-Host "Files to be committed:" -ForegroundColor Yellow
git status --short

# Commit
Write-Host ""
Write-Host "📝 Creating commit..." -ForegroundColor Blue
git commit -m "Add ArogyaMitra project files - AI-powered fitness platform"

# Push to GitHub
Write-Host ""
Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Blue
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "   ✅ Successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your repository is now live! 🎉" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "View it at:" -ForegroundColor Yellow
    $webUrl = $repoUrl -replace '\.git$', ''
    Write-Host $webUrl -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "   ⚠️ Push failed!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Common issues:" -ForegroundColor Yellow
    Write-Host "1. Check your GitHub credentials" -ForegroundColor White
    Write-Host "2. Ensure you have push access to the repository" -ForegroundColor White
    Write-Host "3. Try: git push -u origin main --force (if needed)" -ForegroundColor White
    Write-Host ""
}
