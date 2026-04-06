# Agent Deploy Docs

这一组文档构成 EDU-PUBLISH 的 agent 部署与运行规范。

任意支持终端执行的 AI agent 只需读取入口文件即可完成整条部署链路。

## 文件说明

| 文件 | 说明 |
|------|------|
| `SKILLS.md` | 项目级 skill 安装约定。规定从 `JXNU-PUBLISH-skills` 安装哪些 skills 到 `./skills/` |
| `install-skills.sh` | 项目内 skill 安装脚本。缺失则安装，已存在则跳过 |
| `DEPLOY.md` | **主入口**。确认本地 fork 工作副本 → 安装项目 skills → 环境探测 → Docker Compose 编排 → 容器启动 → QQ 扫码登录 → WebSocket 验证 |
| `CONFIGURE.md` | 插件安装与配置。astrbot-QQtoLocal 插件参数、归档目录验证、可选跨平台转发 |
| `VERIFY.md` | 端到端联调验收。容器状态 → 登录 → 通信 → 插件 → 归档 → 消息测试 → 结论输出 |
| `PUBLISH.md` | 可选的网站部署阶段。仅在本地链路跑通且用户确认后，继续 Cloudflare Pages + GitHub Actions 部署 |

## 使用方式

推荐使用方式：

```text
阅读 .agent/DEPLOY.md 并按步骤执行。
```

在进入这一步之前，用户应先：

```text
1. 在 GitHub 网页端 fork guiguisocute/EDU-PUBLISH
2. 把自己的 fork clone 到本地
3. 让 agent 在本地仓库根目录读取 .agent/DEPLOY.md
```

## 链路概览

```
DEPLOY.md (Step 0-6)
  → 确认本地 fork、项目 skill 安装、环境检查、Docker 安装、compose 启动、QQ 登录、WebSocket 对接
  → CONFIGURE.md (Step 7)
    → 插件安装、参数配置、归档挂载验证
    → VERIFY.md (Step 8)
      → 端到端消息测试、故障定位、验收结论
      → PUBLISH.md (Step 9, optional)
        → 询问是否继续网页部署，推荐 Cloudflare Pages + GitHub Actions
```

## 目录结构依赖

部署过程会创建/使用以下目录：

```
EDU-PUBLISH/
├── skills/           # 项目级 skills（本地依赖，gitignore）
├── archive/          # AstrBot 归档落盘（已 gitignore 内容）
├── data/             # AstrBot 运行数据（已 gitignore）
├── napcat/config/    # NapCat 配置（已 gitignore）
├── ntqq/             # QQ 数据目录（已 gitignore）
└── docker-compose.yml  # 由 DEPLOY.md Step 3 创建
```
