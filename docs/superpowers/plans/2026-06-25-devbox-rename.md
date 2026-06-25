# devbox Rename Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rename project from "neovim-devcontainer" to "devbox" and update all affected files to reflect the current state of the environment.

**Architecture:** Three isolated file changes (README, devcontainer.json, CLAUDE_SETUP_PLAN.md deletion) plus assets folder removal. No code — pure documentation and config. Each task is independent and commits on its own.

**Tech Stack:** Markdown, JSON (devcontainer spec)

## Global Constraints

- No new assets or media files
- No TODOs in README
- Usage commands must use `fish` (not `zsh`)
- `devcontainer exec` command must match current `remoteUser: "dev"`
- GitHub repo rename is manual (out of scope)

---

### Task 1: Update devcontainer.json

**Files:**
- Modify: `.devcontainer/devcontainer.json`

**Interfaces:**
- Produces: `name: "devbox"`, `.secrets` mount with `readonly`

- [ ] **Step 1: Open file and locate the two change sites**

File: `.devcontainer/devcontainer.json`

Change 1 — `name` field (top of file):
```json
"name": "devbox",
```

Change 2 — `.secrets` mount (inside `"mounts"` array):
```json
"source=${localEnv:HOME}/.secrets,target=/home/dev/.secrets,type=bind,consistency=cached,readonly",
```

- [ ] **Step 2: Verify the file looks correct**

Run:
```bash
cat .devcontainer/devcontainer.json
```

Expected: `name` is `"devbox"`, `.secrets` mount has `readonly` at the end.

- [ ] **Step 3: Commit**

```bash
git add .devcontainer/devcontainer.json
git commit -m "fix(devcontainer): rename to devbox and make .secrets mount readonly"
```

---

### Task 2: Delete CLAUDE_SETUP_PLAN.md

**Files:**
- Delete: `CLAUDE_SETUP_PLAN.md`

**Interfaces:**
- Consumes: nothing
- Produces: file gone from repo

- [ ] **Step 1: Delete the file**

```bash
git rm CLAUDE_SETUP_PLAN.md
```

- [ ] **Step 2: Commit**

```bash
git commit -m "chore: remove implemented setup plan"
```

---

### Task 3: Remove assets folder

**Files:**
- Delete: `assets/devcontainer.png`
- Delete: `assets/` directory

**Interfaces:**
- Must run AFTER Task 4 (README no longer references assets)
- Produces: `assets/` gone from repo

- [ ] **Step 1: Remove assets folder**

```bash
git rm -r assets/
```

- [ ] **Step 2: Commit**

```bash
git commit -m "chore: remove old assets"
```

---

### Task 4: Rewrite README.md

**Files:**
- Modify: `README.md`

**Interfaces:**
- Must run BEFORE Task 3 (so no broken asset references remain)
- Produces: accurate README reflecting current environment

- [ ] **Step 1: Replace README.md content entirely**

Replace the full content of `README.md` with:

```markdown
# devbox

Ambiente de desenvolvimento completo em container (Arch Linux).

<!--toc:start-->
- [Tools Included](#tools-included)
- [Requirements](#requirements)
- [Usage](#usage)
<!--toc:end-->

## Tools Included

- **Shell:** Fish + Starship
- **Editor:** Neovim + LazyVim
- **Languages:** Go (latest), Node.js (LTS), Python (latest) via [mise](https://mise.jdx.dev/); Rust via rustup
- **Dev tools:** Claude Code, lazygit, tmux, fzf, zoxide, ripgrep, fd, eza, jq, uv, xclip
- **Debug / network:** lsof, strace, tcpdump, iftop, iotop, glances, ncdu, duf, net-tools

## Requirements

- [Docker](https://www.docker.com/)
- [Devcontainer CLI](https://github.com/devcontainers/cli)

## Usage

1. Add the `.devcontainer` folder to the root of your project.

2. Build the devcontainer:

```bash
devcontainer up --workspace-folder . --build-no-cache
```

3. Access the container:

```bash
devcontainer exec --workspace-folder . fish
```

4. After first startup, authenticate Claude:

```bash
claude login
```
```

- [ ] **Step 2: Verify no old references remain**

```bash
grep -n "neovim\|zsh\|Oh My\|Powerlevel\|assets/\|TODO\|tabnine\|markdown-preview" README.md
```

Expected: no output.

- [ ] **Step 3: Commit**

```bash
git add README.md
git commit -m "docs: rewrite README for devbox"
```

---

## Execution Order

Task 1, 2, 4, 3 — Task 3 (assets removal) must come after Task 4 (README rewrite).
Tasks 1 and 2 are fully independent and can run in any order.
