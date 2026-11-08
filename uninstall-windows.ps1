$ErrorActionPreference = "Stop"
if ([Console]::IsOutputRedirected) { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 }
function Zh([string]$s) { return [regex]::Unescape($s) }

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host (Zh "  Traycer \u684c\u9762\u7aef\u7b80\u4f53\u4e2d\u6587\u6c49\u5316\u8865\u4e01 - \u5378\u8f7d\u4e0e\u8fd8\u539f\u7a0b\u5e8f") -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$candidates = @(
    "$env:LOCALAPPDATA\Programs\Traycer\resources\renderer",
    "$env:LOCALAPPDATA\Programs\traycer-desktop\resources\renderer",
    "$env:LOCALAPPDATA\Traycer\resources\renderer",
    "$env:USERPROFILE\scoop\apps\traycer\current\resources\renderer",
    "C:\Program Files\Traycer\resources\renderer"
)

$proc = Get-Process -Name "Traycer*" -ErrorAction SilentlyContinue | Where-Object { $_.Path -and (Test-Path (Join-Path (Split-Path -Parent $_.Path) "resources\renderer\index.html")) } | Select-Object -First 1
if ($proc -and $proc.Path) {
    $procDir = Split-Path -Parent $proc.Path
    $candidates = @("$procDir\resources\renderer") + $candidates
}

$rendererDir = $null
foreach ($c in $candidates) {
    if ($c -and (Test-Path "$c\index.html")) {
        $rendererDir = $c
        break
    }
}

if (-not $rendererDir) {
    $customPath = Read-Host (Zh "\u8bf7\u624b\u52a8\u8f93\u5165\u4f60\u7684 Traycer \u5b89\u88c5\u76ee\u5f55\u8def\u5f84\uff08\u4f8b\u5982 D:\u005cTraycer\uff09")
    if ($customPath) {
        $customPath = $customPath.Trim('"').Trim("'")
        if (Test-Path "$customPath\resources\renderer\index.html") {
            $rendererDir = "$customPath\resources\renderer"
        } elseif (Test-Path "$customPath\index.html") {
            $rendererDir = $customPath
        }
    }
}

if (-not $rendererDir) {
    Write-Error (Zh "\u672a\u627e\u5230 Traycer \u7684 resources\u005crenderer \u76ee\u5f55\u3002")
    exit 1
}

$patchDest = Join-Path $rendererDir "i18n-zh-patch.js"
$indexHtml = Join-Path $rendererDir "index.html"
$indexBackup = Join-Path $rendererDir "index.html.bak"

if (Test-Path $indexBackup) {
    Copy-Item -Path $indexBackup -Destination $indexHtml -Force
    Remove-Item -Path $indexBackup -Force
    Write-Host (Zh "[1/2] \u5df2\u4ece index.html.bak \u6062\u590d\u539f\u7248 index.html") -ForegroundColor Green
} else {
    $htmlContent = [System.IO.File]::ReadAllText($indexHtml, [System.Text.Encoding]::UTF8)
    $htmlContent = $htmlContent -replace "\s*<script[^>]*i18n-zh-patch\.js[^>]*></script>", ""
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($indexHtml, $htmlContent, $utf8NoBom)
    Write-Host (Zh "[1/2] \u5df2\u4ece index.html \u79fb\u9664\u6c49\u5316\u811a\u672c\u5f15\u7528") -ForegroundColor Green
}

if (Test-Path $patchDest) {
    Remove-Item -Path $patchDest -Force
    Write-Host (Zh "[2/2] \u5df2\u79fb\u9664\u6c49\u5316\u8865\u4e01\u6587\u4ef6 i18n-zh-patch.js") -ForegroundColor Green
}

Write-Host ""
Write-Host (Zh "\u5df2\u6210\u529f\u8fd8\u539f\u4e3a\u82f1\u6587\u539f\u7248\u754c\u9762\uff01\u8bf7\u5207\u6362\u5230 Traycer \u7a97\u53e3\u5e76\u6309 Ctrl + Shift + R \u91cd\u65b0\u52a0\u8f7d\u3002") -ForegroundColor Cyan
