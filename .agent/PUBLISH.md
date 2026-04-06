# PUBLISH — 可选的网站部署阶段

> **你是一个 AI agent，正在为已经完成本地联调的 EDU-PUBLISH 项目执行可选的网站部署。**
> 本文件只在 NapCat + AstrBot + 插件 + agent 链路已通过验收后执行。

## 触发条件

只有在 `VERIFY.md` 已完成，且用户明确表示要把站点部署成真正可访问的网页时，才继续本文件。

在开始前先询问用户：

> NapCat、AstrBot、插件和 agent 的本地链路已经跑通。是否继续把站点部署为可访问网页？推荐使用 Cloudflare Pages + GitHub Actions。

如果用户不需要网页部署，到此结束。

## 推荐方案

本项目推荐：

- GitHub 仓库使用用户自己的 fork
- Cloudflare Pages 托管前端站点
- GitHub Actions 负责构建与部署

选择这条路径的原因：

- 本仓库已经内置 `.github/workflows/deploy.yml` 与 `.github/workflows/deploy-main.yml`
- 产物是静态站点，适合 Cloudflare Pages
- 便于把 `test` / `main` 分支映射到预览与生产

## 部署前确认

先确认用户已经完成以下准备：

1. GitHub 网页端 fork 了 `guiguisocute/EDU-PUBLISH`
2. 本地 clone 的是自己的 fork，而不是上游只读仓库
3. Cloudflare 账号可用
4. 用户愿意在 GitHub 仓库和 Cloudflare 中手动配置必要凭证

## 执行口径

agent 在本阶段应：

1. 说明推荐方案是 `Cloudflare Pages + GitHub Actions`
2. 引导用户在 Cloudflare 中创建 Pages 项目
3. 引导用户在 GitHub 仓库中补齐 workflow 所需 secrets
4. 检查 `.github/workflows/deploy.yml` 与 `.github/workflows/deploy-main.yml` 需要的变量名称是否与 README 一致
5. 在用户确认后，协助推送到对应分支触发部署

## 本阶段不自动代办的事项

以下操作通常需要用户在网页端完成，agent 不应假设自己已经具备权限：

- 在 GitHub 网页端 fork 仓库
- 在 Cloudflare Dashboard 中创建/确认 Pages 项目
- 在 GitHub 仓库 Settings 中补齐 Actions secrets
- 在 Cloudflare 中绑定自定义域名、D1、R2 等资源

## 参考资料

- 根目录 `README.md` 中的「GitHub Actions + Cloudflare Pages」
- `.github/workflows/deploy.yml`
- `.github/workflows/deploy-main.yml`
