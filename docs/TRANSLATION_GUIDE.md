# Terminology & Translation Reference / 术语规范与中英对照表

This document lists the terminology conventions and major UI string mappings used in `traycer-zh-cn`.

本文档记录 `traycer-zh-cn` 使用的术语翻译约定及主要界面模块的英文原文与中文对照。

---

## 1. Terminology Conventions / 核心术语约定

| English Term | Chinese Translation | Context / Notes |
| :--- | :--- | :--- |
| `Thought for {n}s` | `已深度思考（用时 {n} 秒）` | Chat reasoning disclosure header |
| `Thinking…` / `Mulling…` / `Pondering…` | `深度思考中…` | Active reasoning status |
| `Reasoning` (`Low` / `Medium` / `High` / `Max`) | `深度思考`（`轻量` / `标准` / `深度` / `极限`） | Model reasoning effort selector |
| `Supervised` | `人工确认` | Permission mode |
| `Auto-accept edits` | `自动接受修改` | Permission mode |
| `Auto` | `AI 托管` | Permission mode |
| `Full access` | `全自动执行` | Permission mode |
| `APPROVAL NEEDED` | `等待确认` | Tool execution / file edit approval card |
| `Approve` / `Deny` | `允许` / `拒绝` | Approval action buttons |
| `Host` | `主机 (Host)` | Local or remote Traycer runner service |
| `Sandbox` | `云端沙箱` | Cloud execution environment |
| `Worktree` | `Git 工作树` | Git worktree managed by Traycer |
| `Artifact` | `产物与文档 (Artifact)` | HTML, Canvas, or Markdown task outputs |

---

## 2. Chat, Composer & Status Bar / 对话流、输入框与状态栏

| Source String (English) | Target String (Chinese) |
| :--- | :--- |
| `Thought for {n}s, ran {m} commands` | `已深度思考（用时 {n} 秒），执行了 {m} 条命令` |
| `Used {n} tools` | `调用了 {n} 个工具` |
| `{n}% context left` | `上下文剩余 {n}%` |
| `cpu` / `mem` / `procs` / `ram` | `CPU` / `内存` / `进程` / `内存占比` |
| `Connect a supported provider to see usage here.` | `连接受支持的服务商以在此查看用量。` |
| `Enter to queue · Ctrl+Enter to steer this turn` | `回车加入队列 · Ctrl+Enter 插队引导当前回答` |
| `Ask anything, @ to mention, / for commands…` | `输入问题，输入 @ 引用文件或智能体，输入 / 调用命令…` |
| `Review all changes` / `Undo all changes` | `审查全部修改` / `撤销全部修改` |
| `Fork conversation` | `创建分支对话` |
| `Makes a second chat there. This one stays where it is.` | `将在目标位置创建新对话，当前对话保留在原处。` |

---

## 3. Settings Navigation / 设置中心导航栏 (27 Sections)

| Group | English Label | Chinese Translation | Description Translation |
| :--- | :--- | :--- | :--- |
| **Guide** | `Getting started` | `快速上手` | `首次使用的基础配置向导。` |
| **Application** | `General` | `通用设置` | `软件行为、智能体后台策略与本地数据管理。` |
| **Application** | `Appearance` | `外观与主题` | `深浅色主题、字体字号与界面显示偏好。` |
| **Application** | `Browser` | `内置浏览器` | `默认搜索引擎、标签页打开位置与网站登录会话管理。` |
| **Application** | `Opening behavior` | `打开方式` | `控制点击链接与新建面板时的默认打开位置。` |
| **Application** | `Sounds` | `音效与背景乐` | `为不同类型的提醒设置提示音与工作背景音乐。` |
| **Application** | `Alerts` | `系统通知` | `配置操作系统通知横幅与推送提醒。` |
| **Application** | `Keybindings` | `快捷键` | `查看应用支持的所有快捷键，或点击重新绑定。` |
| **Application** | `Layout` | `界面布局` | `调整标签栏、侧边栏、对话阅读宽度与状态栏的布局位置，修改立即生效。` |
| **Application** | `Diagnostics` | `诊断与日志` | `Traycer 桌面客户端窗口自身的日志级别与内存快照工具。` |
| **Account** | `Sessions` | `登录设备` | `查看当前账号已登录的所有设备与会话，并可随时移除不再使用的设备。` |
| **Account** | `Link mobile app` | `绑定手机端` | `使用 Traycer 手机端扫描此二维码登录当前账号。` |
| **Account** | `Usage` | `用量统计` | `查看你所有智能体的 Token 消耗与费用明细统计。` |
| **Account** | `Credits` | `额度与充值` | `额度可用于云端沙箱与模型调用。` |
| **Account** | `Notifications` | `通知策略与钩子` | `配置应用内提醒策略及自定义自动化通知钩子 (Hooks)。` |
| **Account** | `Delete account` | `注销账户` | `永久删除你的 Traycer 账户及所有关联数据。` |
| **Environment** | `Providers` | `模型与服务商` | `管理各编程智能体的账号登录、API 密钥、MCP 服务与扩展工具。` |
| **Environment** | `MCP servers` | `MCP 服务` | `管理各编程智能体可调用的 MCP (Model Context Protocol) 工具服务器。` |
| **Environment** | `Skills` | `技能扩展 (Skills)` | `管理各编程智能体可加载的专业技能包 (Skills)。` |
| **Environment** | `Permissions` | `权限与安全` | `配置智能体在无需询问你的情况下可自动执行的操作范围。` |
| **Environment** | `Agents` | `智能体配置` | `管理全局智能体选择指南（Selection Guide）与自定义子智能体定义。` |
| **Environment** | `Model routing` | `模型路由与容灾` | `当遇到速率限制或服务商故障中断对话时，Traycer 自动执行的备用切换策略。` |
| **Environment** | `Variables & shells` | `环境变量与终端` | `所有使用当前配置的主机共享的明文环境变量，以及智能体默认使用的命令行终端。` |
| **Environment** | `Secrets` | `密钥保管箱` | `供智能体调用的敏感凭证、密码与 API 密钥。` |
| **Environment** | `Sandboxes` | `云端沙箱` | `查看当前环境配置下运行的所有云端沙箱实例及其费用明细。` |
| **Environment** | `Storage` | `历史版本与存储` | `管理本地磁盘空间占用与自动清理策略。` |
| **Environment** | `Members` | `团队成员` | `管理团队成员及其权限。` |
| **Host** | `Overview` | `主机概览` | `查看当前选定主机的运行状态、版本更新、端口转发、模拟器与安装信息。` |
| **Host** | `Worktrees` | `Git 工作树` | `管理并清理 Traycer 在当前主机上创建的 Git Worktree 分支目录。` |
| **Host** | `Diagnostics` | `诊断与日志` | `上方所选主机的日志详细程度与近期日志输出。` |

---

## 4. General Settings Detailed Rows / 通用设置详细配置项对照

| Source String (English) | Target String (Chinese) |
| :--- | :--- |
| `Voice input` | `语音输入 (听写)` |
| `Dictate prompts with the mic button or its shortcut. The microphone opens only while you are dictating, and turning this off closes it. Audio never leaves your computer.` | `使用麦克风按钮或快捷键语音输入提示词。麦克风仅在听写期间开启，关闭此项将立即停用麦克风。音频在本地处理，绝不会上传。` |
| `Quote reply on text selection` | `选中文本时显示「引用回复」按钮` |
| `Selecting assistant text shows a quote button that inserts the selection into the composer.` | `用鼠标选中助手回复的文本时弹出「引用」按钮，点击即可将所选内容插入输入框。` |
| `Steer with Ctrl+Enter` | `使用 Ctrl+Enter 插队引导当前回答` |
| `While a turn is running on a supported harness, Ctrl+Enter sends the composer text as a same-turn steering message that jumps the queue. Plain Enter keeps queueing.` | `当智能体正在受支持的运行框架上回答时，按 Ctrl+Enter 可将输入框内容作为当前回合的引导消息立即插队发送；直接按回车键则继续加入等待队列。` |
| `Prevent sleep while running` | `智能体运行期间防止电脑休眠` |
| `Keep the computer awake while an agent is running, so work continues when you step away.` | `当有智能体正在执行任务时保持电脑唤醒状态，确保你离开时任务不会中断。` |
| `When you quit Traycer` | `退出 Traycer 时的后台行为` |
| `Background` / `Ask` / `Stop if idle` / `Linked` / `No local host` | `后台运行` / `每次询问` / `空闲时停止` / `随应用停止` / `不运行本地服务` |
| `Agents keep working after you quit Traycer. You can still connect to this PC from your other devices. The host starts when you log in.` | `退出 Traycer 窗口后智能体继续在后台工作，你仍可从其他设备连接到这台电脑。开机登录系统时后台服务会自动启动。` |
| `Worktree branch prefix` | `Git 工作树分支命名前缀` |
| `New branches start like {branch} unless a repository sets its own prefix in Repository settings` | `新建分支默认格式如 {branch}，除非仓库在「仓库设置」中单独指定了前缀` |
| `Agent roles` | `智能体角色分工` |
| `Let agents claim durable responsibilities and coordinate through role-aware tools and prompts.` | `允许智能体认领持久化的角色职责，并通过角色感知工具与提示词进行多智能体协同。` |
| `Let agents draft feedback for you to review` | `允许智能体起草软件反馈供你审阅` |
| `Agents can draft problems and suggestions about Traycer for its maintainers. Nothing is sent until you review a draft and press Send.` | `智能体可以针对 Traycer 的问题或改进建议为你起草反馈草稿。在你亲自审阅并点击发送前，不会提交任何内容。` |
| `Archive idle agents automatically` | `自动归档闲置的智能体对话` |
| `Tidy up chats agents started once they go quiet. Applies on all your hosts.` | `当智能体发起的对话进入闲置状态后自动归档整理，对所有主机生效。` |
| `Show Tracy` | `在导航栏显示 Tracy` |
| `Keep Tracy next to Home. When off, open Tracy from Home.` | `将 Tracy 固定在首页图标旁；关闭后仍可从首页打开 Tracy。` |
| `Local app state` / `Clear local app state` | `本地前端缓存状态` / `清除本地前端状态` |
| `Reset this device's app state - open tabs, layout, drafts, settings, and view preferences - then reload. You stay signed in. File edit snapshots are cleared from the host's own Overview page.` | `重置当前设备上的前端状态（包括打开的标签页、自定义布局、草稿、前端设置与视图偏好）并重新加载页面。你的登录状态会保留；文件修改快照需在主机概览页单独清理。` |
