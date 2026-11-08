$ErrorActionPreference = "Stop"
if ([Console]::IsOutputRedirected) { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 }
function Zh([string]$s) { return [regex]::Unescape($s) }

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host (Zh "  Traycer \u684c\u9762\u7aef\u7b80\u4f53\u4e2d\u6587\u6c49\u5316\u8865\u4e01 - \u5b89\u88c5\u7a0b\u5e8f v3.0") -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host (Zh "[1/4] \u6b63\u5728\u81ea\u52a8\u5b9a\u4f4d Traycer \u6e32\u67d3\u5c42\u76ee\u5f55 (resources\u005crenderer)...") -ForegroundColor Cyan

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
    Write-Host (Zh "\u672a\u80fd\u5728\u9ed8\u8ba4\u8def\u5f84\u4e2d\u81ea\u52a8\u627e\u5230 Traycer \u5b89\u88c5\u76ee\u5f55\u3002") -ForegroundColor Yellow
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
    Write-Error (Zh "\u672a\u627e\u5230 Traycer \u7684 resources\u005crenderer\u005cindex.html\uff0c\u8bf7\u786e\u8ba4\u5df2\u5b89\u88c5 Traycer \u684c\u9762\u5ba2\u6237\u7aef\u3002")
    exit 1
}

Write-Host ((Zh "[2/4] \u5df2\u5b9a\u4f4d\u5230\u6e32\u67d3\u5c42\u76ee\u5f55: ") + $rendererDir) -ForegroundColor Green

$patchSrc = Join-Path $PSScriptRoot "dist\i18n-zh-patch.js"
if (-not (Test-Path $patchSrc)) {
    $patchSrc = Join-Path $PSScriptRoot "i18n-zh-patch.js"
}
$patchDest = Join-Path $rendererDir "i18n-zh-patch.js"
$indexHtml = Join-Path $rendererDir "index.html"
$indexBackup = Join-Path $rendererDir "index.html.bak"

if (-not (Test-Path $indexBackup)) {
    Copy-Item -Path $indexHtml -Destination $indexBackup -Force
    Write-Host (Zh "[3/4] \u5df2\u5907\u4efd\u539f\u7248\u5165\u53e3\u6587\u4ef6: index.html -> index.html.bak") -ForegroundColor Gray
} else {
    Write-Host (Zh "[3/4] \u68c0\u6d4b\u5230\u539f\u7248\u5907\u4efd\u6587\u4ef6 index.html.bak \u5df2\u5b58\u5728\uff0c\u8df3\u8fc7\u5907\u4efd") -ForegroundColor Gray
}

Copy-Item -Path $patchSrc -Destination $patchDest -Force
Write-Host ((Zh "      \u5df2\u5199\u5165\u4e2d\u6587\u8bcd\u5e93\u8865\u4e01: ") + $patchDest) -ForegroundColor Green

$htmlContent = [System.IO.File]::ReadAllText($indexHtml, [System.Text.Encoding]::UTF8)
$scriptTag = '<script src="./i18n-zh-patch.js?v=3.0.0" charset="utf-8"></script>'

if ($htmlContent -notmatch "i18n-zh-patch\.js") {
    $htmlContent = $htmlContent -replace "</body>", "  $scriptTag`n</body>"
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($indexHtml, $htmlContent, $utf8NoBom)
    Write-Host (Zh "[4/4] \u5df2\u6210\u529f\u5c06\u6c49\u5316\u811a\u672c\u6ce8\u5165\u5230 index.html\uff01") -ForegroundColor Green
} else {
    $htmlContent = $htmlContent -replace "i18n-zh-patch\.js(\?v=[^""']*)?", "i18n-zh-patch.js?v=3.0.0"
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($indexHtml, $htmlContent, $utf8NoBom)
    Write-Host (Zh "[4/4] \u5df2\u66f4\u65b0\u6c49\u5316\u8bcd\u5e93\u4e0e\u7f13\u5b58\u7248\u672c\u53f7 (v3.0.0)\uff01") -ForegroundColor Green
}

Write-Host ""
Write-Host (Zh "\u5b89\u88c5\u5b8c\u6210\uff01\u8bf7\u5207\u6362\u5230 Traycer \u7a97\u53e3\u5e76\u6309 Ctrl + Shift + R \u91cd\u65b0\u52a0\u8f7d\u754c\u9762\u5373\u53ef\u751f\u6548\u3002") -ForegroundColor Cyan
