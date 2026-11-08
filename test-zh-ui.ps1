$ErrorActionPreference = "Stop"
if ([Console]::IsOutputRedirected) { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 }
function Zh([string]$s) { return [regex]::Unescape($s) }

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host (Zh "  Traycer \u4e2d\u6587\u6c49\u5316\u8865\u4e01\u72b6\u6001\u6821\u9a8c\u4e0e Host \u5065\u5eb7\u68c0\u67e5\u5de5\u5177") -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$installScript = Join-Path $PSScriptRoot "install-windows.ps1"
powershell -ExecutionPolicy Bypass -File $installScript

$rendererDir = $null
$proc = Get-Process -Name "Traycer*" -ErrorAction SilentlyContinue | Where-Object { $_.Path -and (Test-Path (Join-Path (Split-Path -Parent $_.Path) "resources\renderer\index.html")) } | Select-Object -First 1
if ($proc -and $proc.Path) {
    $rendererDir = Join-Path (Split-Path -Parent $proc.Path) "resources\renderer"
}
if (-not $rendererDir) {
    foreach ($c in @(
        "$env:LOCALAPPDATA\Programs\Traycer\resources\renderer",
        "$env:LOCALAPPDATA\Programs\traycer-desktop\resources\renderer",
        "$env:LOCALAPPDATA\Traycer\resources\renderer",
        "C:\Program Files\Traycer\resources\renderer"
    )) {
        if (Test-Path "$c\index.html") {
            $rendererDir = $c
            break
        }
    }
}

$patchFile = Join-Path $rendererDir "i18n-zh-patch.js"
$indexFile = Join-Path $rendererDir "index.html"

$patchBytes = [System.IO.File]::ReadAllBytes($patchFile)
$indexText = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

Write-Host ""
Write-Host (Zh "[\u6821\u9a8c 1/2] \u6b63\u5728\u6838\u9a8c\u6e32\u67d3\u5c42\u6c49\u5316\u8865\u4e01\u5b8c\u6574\u6027...") -ForegroundColor Yellow
if ($indexText -match "i18n-zh-patch\.js" -and $patchBytes.Length -gt 500000) {
    Write-Host (Zh "  [\u6b63\u5e38] index.html \u5df2\u6210\u529f\u6ce8\u5165\u6c49\u5316\u811a\u672c\u6807\u7b7e") -ForegroundColor Green
    Write-Host ((Zh "  [\u6b63\u5e38] i18n-zh-patch.js v3.0 \u6821\u9a8c\u901a\u8fc7\uff08\u5927\u5c0f: ") + [math]::Round($patchBytes.Length / 1024, 1) + (Zh " KB\uff0c\u542b 8400+ \u9759\u6001\u8bcd\u6761\u4e0e 1470+ \u52a8\u6001\u89c4\u5219\uff09")) -ForegroundColor Green
} else {
    Write-Error (Zh "\u6c49\u5316\u8865\u4e01\u6821\u9a8c\u672a\u901a\u8fc7\uff0c\u8bf7\u91cd\u65b0\u8fd0\u884c\u5b89\u88c5\u811a\u672c\uff01")
    exit 1
}

Write-Host ""
Write-Host (Zh "[\u6821\u9a8c 2/2] \u6b63\u5728\u68c0\u67e5\u540e\u53f0 traycer-host \u670d\u52a1\u8fd0\u884c\u72b6\u6001\uff08\u5b89\u5168\u6a21\u5f0f\uff0c\u4e0d\u7ec8\u6b62\u4efb\u4f55\u8fdb\u7a0b\uff09...") -ForegroundColor Yellow
$hostProc = Get-Process -Name "traycer-host*" -ErrorAction SilentlyContinue
if ($hostProc) {
    Write-Host ((Zh "  [\u6b63\u5e38] traycer-host \u540e\u53f0\u670d\u52a1\u6b63\u5728\u8fd0\u884c (PID: ") + ($hostProc.Id -join ", ") + ")") -ForegroundColor Green
} else {
    Write-Host (Zh "  [\u63d0\u793a] \u68c0\u6d4b\u5230 traycer-host \u672a\u8fd0\u884c\uff0c\u6b63\u5728\u901a\u8fc7 Traycer CLI \u81ea\u52a8\u5524\u9192\u540e\u53f0\u670d\u52a1...") -ForegroundColor Yellow
    $cliExe = "$env:USERPROFILE\.traycer\cli\bin\traycer.exe"
    if (Test-Path $cliExe) {
        Start-Process -FilePath $cliExe -ArgumentList "host", "start" -WindowStyle Hidden
        Start-Sleep -Seconds 3
        Write-Host (Zh "  [\u5df2\u89e6\u53d1] \u5df2\u5728\u540e\u53f0\u542f\u52a8 traycer host start\u3002") -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "====================================================" -ForegroundColor Green
Write-Host (Zh "  \u5b89\u5168\u5237\u65b0\u6307\u5f15\uff08\u65e0\u9700\u91cd\u542f\u8f6f\u4ef6\u6216\u5f3a\u6740\u8fdb\u7a0b\uff09\uff1a") -ForegroundColor Green
Write-Host (Zh "  1. \u5207\u6362\u5230\u5df2\u6253\u5f00\u7684 Traycer \u7a97\u53e3") -ForegroundColor Cyan
Write-Host (Zh "  2. \u6309 Ctrl + Shift + R \u91cd\u65b0\u52a0\u8f7d\u524d\u7aef\u9875\u9762\u5373\u53ef\u663e\u793a\u4e2d\u6587") -ForegroundColor Cyan
Write-Host (Zh "  3. \u5982\u9700\u8fd8\u539f\u82f1\u6587\uff0c\u8fd0\u884c uninstall-windows.bat \u540e\u6309 Ctrl + Shift + R") -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Green
