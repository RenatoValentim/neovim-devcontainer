# Neovim Devcontainer

![Devcontainer Environment](./assets/devcontainer.png)

https://github.com/user-attachments/assets/267ddc04-8607-4eb7-a4d3-57ccb6a8d792

https://github.com/user-attachments/assets/2dab7abd-dc7d-41b6-a70b-0943c9b15fb2

https://github.com/user-attachments/assets/a4760da1-9477-42ba-83dd-b1a0ba9eec26


<!--toc:start-->

- [Table of Contents](#neovim-devcontainer)
  - [Tools Included](#tools-included)
  - [Requirements](#requirements)
  - [Usage](#usage)
  <!--toc:end-->

This repository provides my **Devcontainer** setup for Neovim, pre-configured
with essential development tools inside a Docker environment.

## Tools Included

- **Neovim**
- **Oh My Zsh** with Powerlevel10k theme.
- **Golang**
- **NodeJS**
- **Python** with Poetry
- **Lua**
- Utilities like `ripgrep`, `fd`, `tmux`, `fzf`, `htop`,
  `lazygit`, `exa`, `jq`...

## Requirements

- [Docker](https://www.docker.com/)
- [Devcontainer CLI](https://github.com/devcontainers/cli)

## Usage

1. Add the `.devcontainer` folder to the root of your project.

2. Build the devcontainer image:

```bash
devcontainer up --workspace-folder . --build-no-cache
```

3. Access the container:

```bash
devcontainer exec --workspace-folder . zsh
```

## TODOs

- [ ] Fix failure during the first-time startup of `neovim` when installing `cmp-tabnine` (after the initial failure, the plugin works correctly)
- [ ] Fix failure during the first-time startup of `neovim` when installing `markdown-preview.nvim` (after the initial failure, the plugin works correctly)
