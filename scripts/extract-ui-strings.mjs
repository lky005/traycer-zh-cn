#!/usr/bin/env node
/**
 * 从 GitHub traycerai/traycer 主干自动扫描 UI 英文词条并对比未翻译增量的脚本
 * 用法: node ./scripts/extract-ui-strings.mjs
 */
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const PATCH_FILE = path.resolve(__dirname, "../dist/i18n-zh-patch.js");

async function main() {
  const patchCode = fs.readFileSync(PATCH_FILE, "utf8");
  const headers = { "User-Agent": "Traycer-ZH-Extractor" };

  console.log("正在获取 traycerai/traycer 主干文件树...");
  const treeRes = await fetch(
    "https://api.github.com/repos/traycerai/traycer/git/trees/main?recursive=1",
    { headers }
  ).then((r) => r.json());

  const uiFiles = treeRes.tree
    .map((f) => f.path)
    .filter(
      (p) =>
        p.startsWith("clients/gui-app/src/components/settings/") &&
        !p.includes("__tests__") &&
        (p.endsWith(".tsx") || p.endsWith(".ts"))
    )
    .slice(0, 30);

  console.log(`正在抽样扫描 ${uiFiles.length} 个核心 UI 文件...`);
  const missing = new Set();

  for (const file of uiFiles) {
    const content = await fetch(
      `https://raw.githubusercontent.com/traycerai/traycer/main/${file}`,
      { headers }
    ).then((r) => r.text());

    const reJsx = />(\s*[A-Z][A-Za-z0-9 ,.&:;?!'’“”\-()/…▸→]{2,70}\s*)</g;
    let m;
    while ((m = reJsx.exec(content)) !== null) {
      const s = m[1].trim().replace(/\s+/g, " ");
      if (!patchCode.includes(`"${s}"`)) {
        missing.add(s);
      }
    }
  }

  console.log(`扫描完成！发现 ${missing.size} 条可补充的新词条：`);
  for (const item of Array.from(missing).slice(0, 50)) {
    console.log(`  "${item}": "",`);
  }
}

main().catch(console.error);
