# traycer-zh-cn

Simplified Chinese localization patch for [Traycer Desktop (`traycerai/traycer`)](https://github.com/traycerai/traycer).

针对 [Traycer 桌面端 (`traycerai/traycer`)](https://github.com/traycerai/traycer) 的简体中文界面本地化补丁。

---

## 简体中文

### 项目说明

`traycer-zh-cn` 是适用于 Traycer 桌面客户端的运行时简体中文界面补丁。由于 Traycer 客户端将前端渲染层资源存放在未封包的 `resources/renderer/` 目录（`extraResources`）中，本脚本通过在 `resources/renderer/index.html` 中加载 `i18n-zh-patch.js` 实现界面文本替换，无需重新编译源码或修改 `app.asar`。

### 测试条件与平台兼容性声明

- **已测试环境**：
  - 操作系统：**Windows 11 (x64)**
  - 客户端版本：**Traycer Desktop v1.5.x**（前端资源位于 `<安装目录>\resources\renderer\`）
  - 路径识别条件：如果安装在了非默认路径，建议在**保持 Traycer 窗口打开**的状态下运行安装脚本（脚本会通过运行中的 `Traycer.exe` 进程自动定位安装目录），或按脚本提示手动输入安装目录。
- **macOS 与 Linux 兼容性声明（不作保证）**：
  - 仓库中的 `install-unix.sh` 仅根据上游 `electron-builder` 配置推导路径编写，**尚未在 macOS 或 Linux 实机环境中测试，不保证可用**。
  - 在 macOS 上，直接修改 `.app/Contents/Resources/` 下的文件可能会破坏应用签名并触发 macOS Gatekeeper 拦截提示。macOS 与 Linux 用户请自行评估风险并做好备份。
- **版本更新说明**：
  - 当 Traycer 客户端版本升级并覆盖 `resources/renderer/index.html` 后，需要重新运行一次安装脚本。
  - 上游新增或改动的英文文案若尚未收录进词表，界面会自动保留显示英文原文，不会引发脚本报错。

### 下载与安装（Windows）

#### 方式一：下载 Release 压缩包双击运行

1. 前往 [**Releases 页面**](https://github.com/lky005/traycer-zh-cn/releases/latest) 下载 `traycer-zh-cn-windows.zip` 并解压。
2. 双击运行 **`install-windows.bat`**。
3. 切换到 Traycer 窗口，按下 **`Ctrl + Shift + R`** 重新加载界面即可显示中文（如需卸载并恢复英文原版，双击运行 **`uninstall-windows.bat`** 后按 **`Ctrl + Shift + R`** 刷新即可）。

#### 方式二：PowerShell 在线下载并安装

在 PowerShell 中执行以下命令（自动从最新 Release 下载补丁并写入本机 Traycer `renderer` 目录）：

```powershell
$tmp = Join-Path $env:TEMP "traycer-zh-cn"; New-Item -ItemType Directory -Force -Path $tmp | Out-Null; Invoke-WebRequest -Uri "https://github.com/lky005/traycer-zh-cn/releases/latest/download/traycer-zh-cn-windows.zip" -OutFile "$tmp\patch.zip"; Expand-Archive -Path "$tmp\patch.zip" -DestinationPath $tmp -Force; powershell -ExecutionPolicy Bypass -File "$tmp\install-windows.ps1"
```

#### 方式三：克隆仓库运行

```powershell
git clone https://github.com/lky005/traycer-zh-cn.git
cd traycer-zh-cn
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1
```

> **进程安全提示**：安装或卸载完成后，请直接在 Traycer 窗口内按 **`Ctrl + Shift + R`** 重载前端界面，或从软件内正常退出重开。**请勿使用 `Stop-Process -Force` 或 `taskkill /F` 强制终止进程**，否则会中断后台 `traycer-host.exe` 守护服务的正常退出流程。如遇重启电脑后提示 `No host is available`，可在终端运行 `~/.traycer/cli/bin/traycer.exe host start` 恢复。

### 实现机制与覆盖范围

1. **DOM 文本与属性映射**：通过 `MutationObserver` 监听文本节点与属性（`placeholder`、`data-placeholder`、`title`、`aria-label`），包含 **8,400+ 条** 静态词条与 **1,470+ 条** 动态正则规则，支持复合分隔符（`·` / `—`）与多句段落拆分匹配。
2. **代码与终端隔离**：跳过 `<pre>`、`<code>`、`.xterm`（终端）、`.cm-editor`（代码编辑器）、`.shiki` 及非空输入框，避免改动代码或终端输出。
3. **覆盖模块**：
   - 对话流、推理状态提示、工具调用与权限确认卡片（Approval Cards）
   - 顶部菜单栏、起始页、状态栏（上下文余量、CPU/内存/进程读数）、页内查找栏
   - 输入框（Composer）、模型与推理强度选择器、权限模式选择器、命令面板（`Ctrl + K`）
   - 设置中心（Settings）全部 5 个分组与 27 个子页面的标题、配置项说明与下拉选项

---

## English

### Overview

`traycer-zh-cn` is a runtime Simplified Chinese localization script (`i18n-zh-patch.js`) for Traycer Desktop. Because Traycer ships its frontend renderer in the unpacked `resources/renderer/` folder (`extraResources`), the script can be loaded via `resources/renderer/index.html` without rebuilding from source or modifying `app.asar`.

### Tested Environment & Platform Disclaimer

- **Tested Environment:**
  - OS: **Windows 11 (x64)**
  - App Version: **Traycer Desktop v1.5.x**
  - Condition: If Traycer is installed in a non-default directory, keep the Traycer window running while executing the installer so it can detect the path from the running `Traycer.exe` process, or enter the installation path when prompted.
- **macOS & Linux Disclaimer (No Guarantee):**
  - `install-unix.sh` is provided based on upstream packaging paths and **has NOT been tested on macOS or Linux**. Compatibility on macOS and Linux is not guaranteed.
  - On macOS, modifying files inside `.app/Contents/Resources/` may invalidate the bundle signature and trigger Gatekeeper warnings. Use at your own discretion.
- **App Updates:**
  - Updating Traycer Desktop overwrites `resources/renderer/index.html`. Re-run the installer after an application update. Unmatched new strings fall back to original English text automatically.

### Installation (Windows)

#### Option 1: Release Archive (Double-click `.bat`)

1. Download `traycer-zh-cn-windows.zip` from the [**Latest Release**](https://github.com/lky005/traycer-zh-cn/releases/latest) and extract it.
2. Double-click **`install-windows.bat`**.
3. Switch to the Traycer window and press **`Ctrl + Shift + R`** to reload the renderer. To restore the original English UI, double-click **`uninstall-windows.bat`** and press **`Ctrl + Shift + R`**.

#### Option 2: PowerShell One-Liner

```powershell
$tmp = Join-Path $env:TEMP "traycer-zh-cn"; New-Item -ItemType Directory -Force -Path $tmp | Out-Null; Invoke-WebRequest -Uri "https://github.com/lky005/traycer-zh-cn/releases/latest/download/traycer-zh-cn-windows.zip" -OutFile "$tmp\patch.zip"; Expand-Archive -Path "$tmp\patch.zip" -DestinationPath $tmp -Force; powershell -ExecutionPolicy Bypass -File "$tmp\install-windows.ps1"
```

> **Note:** Reload the UI using **`Ctrl + Shift + R`** inside the Traycer window or quit normally. Do not force-kill `Traycer.exe` (`Stop-Process -Force` / `taskkill /F`), as this interrupts the shutdown transaction of the background `traycer-host` service.

### Repository Structure

```text
traycer-zh-cn/
├── dist/
│   └── i18n-zh-patch.js          # Runtime localization script (8,400+ static entries & 1,470+ regex rules)
├── docs/
│   └── TRANSLATION_GUIDE.md      # Bilingual terminology & translation table
├── scripts/
│   └── extract-ui-strings.mjs    # Utility to scan upstream source for new strings
├── install-windows.bat           # Windows double-click installer
├── install-windows.ps1           # Windows PowerShell installer
├── uninstall-windows.bat         # Windows double-click uninstaller
├── uninstall-windows.ps1         # Windows PowerShell uninstaller
├── test-zh-ui.ps1                # Patch verification & host status check script
├── install-unix.sh               # Experimental macOS / Linux script (untested)
└── README.md
```

### License

MIT
