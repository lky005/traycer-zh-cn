#!/usr/bin/env bash
set -e

echo "===================================================="
echo "  Traycer 桌面端简体中文汉化补丁 - 安装程序 v3.0"
echo "  (注意: macOS / Linux 脚本未经实机验证，请先做好备份)"
echo "===================================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCH_SRC="$SCRIPT_DIR/dist/i18n-zh-patch.js"
if [ ! -f "$PATCH_SRC" ]; then
  PATCH_SRC="$SCRIPT_DIR/i18n-zh-patch.js"
fi

CANDIDATES=(
  "/Applications/Traycer.app/Contents/Resources/renderer"
  "$HOME/Applications/Traycer.app/Contents/Resources/renderer"
  "/opt/Traycer/resources/renderer"
  "/usr/lib/traycer/resources/renderer"
)

RENDERER_DIR=""
for c in "${CANDIDATES[@]}"; do
  if [ -f "$c/index.html" ]; then
    RENDERER_DIR="$c"
    break
  fi
done

if [ -z "$RENDERER_DIR" ]; then
  echo "错误: 未能自动找到 Traycer 的 resources/renderer/index.html 目录。"
  exit 1
fi

echo "已找到渲染层目录: $RENDERER_DIR"

if [ "$1" = "--uninstall" ]; then
  if [ -f "$RENDERER_DIR/index.html.bak" ]; then
    cp -f "$RENDERER_DIR/index.html.bak" "$RENDERER_DIR/index.html"
    rm -f "$RENDERER_DIR/index.html.bak"
  fi
  rm -f "$RENDERER_DIR/i18n-zh-patch.js"
  echo "已恢复为英文原版界面！请在 Traycer 窗口中按 Cmd+Shift+R / Ctrl+Shift+R 重新加载。"
  exit 0
fi

if [ ! -f "$RENDERER_DIR/index.html.bak" ]; then
  cp "$RENDERER_DIR/index.html" "$RENDERER_DIR/index.html.bak"
  echo "已备份 index.html -> index.html.bak"
fi

cp -f "$PATCH_SRC" "$RENDERER_DIR/i18n-zh-patch.js"

if ! grep -q "i18n-zh-patch.js" "$RENDERER_DIR/index.html"; then
  sed -i.tmp 's|</body>|  <script src="./i18n-zh-patch.js?v=3.0.0" charset="utf-8"></script>\n</body>|' "$RENDERER_DIR/index.html"
  rm -f "$RENDERER_DIR/index.html.tmp"
fi

echo "安装完成！请在 Traycer 窗口中按 Cmd+Shift+R / Ctrl+Shift+R 重新加载界面。"
