# SKILLS — 项目级 skill 安装约定

> **你是一个 AI agent，正在为 EDU-PUBLISH 项目准备运行时所需的本地 skills。**
> 在执行 `.agent/DEPLOY.md` 或任何 archive -> content 自动处理前，先完成本文件中的准备动作。

## 目标

将 `https://github.com/guiguisocute/JXNU-PUBLISH-skills` 中当前项目依赖的 skills 安装到项目根目录下的 `./skills/`。

- `./skills/` 是项目本地依赖目录，已被 `.gitignore` 忽略
- 安装完成后，后续 agent 应按任务需要读取 `./skills/<skill-name>/SKILL.md`
- 如果某个 skill 已存在，不要覆盖；只安装缺失项

## 必装 skill 列表

- `skills/daily-reconcile`
- `skills/incremental-process`
- `skills/map-source`
- `skills/merge-supplement`
- `skills/parse-and-create-cards`
- `skills/validate-and-push`
- `skills/write-conclusion`
- `skills/write-worklog`

## 安装方式

优先使用项目内脚本：

```bash
bash .agent/install-skills.sh
```

脚本行为：

- 从 `guiguisocute/JXNU-PUBLISH-skills` 拉取 `main` 分支
- 只检出 `skills/` 目录
- 将缺失的 skills 复制到项目根目录 `./skills/`
- 已存在的目录输出 `skip`，不会覆盖本地内容

如果需要切换 skill 仓库分支，可在执行前设置：

```bash
JXNU_PUBLISH_SKILLS_REF=main bash .agent/install-skills.sh
```

## 安装后校验

执行以下检查，确认 8 个 skill 都已就绪：

```bash
ls \
  skills/daily-reconcile/SKILL.md \
  skills/incremental-process/SKILL.md \
  skills/map-source/SKILL.md \
  skills/merge-supplement/SKILL.md \
  skills/parse-and-create-cards/SKILL.md \
  skills/validate-and-push/SKILL.md \
  skills/write-conclusion/SKILL.md \
  skills/write-worklog/SKILL.md
```

## 使用约定

- 增量入口与批处理节奏：优先参考 `incremental-process`
- QQ/archive 到卡片生成：优先参考 `parse-and-create-cards`、`merge-supplement`、`map-source`
- 每日对账与收尾：优先参考 `daily-reconcile`、`write-conclusion`、`write-worklog`
- 推送前校验与分支动作：优先参考 `validate-and-push`

如果缺少任何一个 required skill，不要继续执行后续自动化链路。
