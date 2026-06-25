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
