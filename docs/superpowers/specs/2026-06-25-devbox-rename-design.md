# Design: Rename neovim-devcontainer → devbox

## Contexto

Projeto cresceu além do Neovim. Inclui Fish, Starship, Claude Code, Rust, Go, Node, Python,
mise, lazygit, tmux e tooling de rede/debug. Nome "neovim-devcontainer" não reflete mais o
escopo. README também está desatualizado (menciona zsh/Oh My Zsh/Powerlevel10k, removidos).

## Objetivo

Renomear projeto para "devbox" e atualizar documentação para refletir o estado atual.

## Escopo

### Arquivos alterados

**`README.md`** — reescrito:
- Título: "devbox"
- Descrição: ambiente de desenvolvimento completo em container (Arch Linux)
- Ferramentas reais: Fish+Starship, Neovim+LazyVim, Go/Node/Python/Rust, Claude Code, lazygit, tmux, fzf, zoxide, ripgrep, fd, eza, jq, uv, xclip + tooling de rede
- Sem assets (imagens/vídeos removidos)
- Sem TODOs stale
- Comandos de uso atualizados (`fish` em vez de `zsh`)

**`devcontainer.json`** — dois ajustes:
- `name`: `"dev"` → `"devbox"`
- Mount `.secrets`: adicionar `readonly` (container só lê — copia cert para `/etc/ca-certificates`)

**`CLAUDE_SETUP_PLAN.md`** — deletado:
- Plano já foi implementado (commits confirmam: `postCreateCommand` existe, `.claude` mount removido, rtk/caveman em runtime)

### Fora do escopo

- Dockerfile: sem alterações
- GitHub repo rename: manual em Settings → Repository name → "devbox"
- `.claude/`, worktrees, git history: sem alterações

## Security

| Item | Status |
|------|--------|
| `.secrets` readonly | Seguro — uso é só leitura (cp cert) |
| `.ssh` readonly | Já estava correto |
| `remoteUser: "dev"` | Não root — OK |

## README — estrutura final

```
# devbox

Ambiente de desenvolvimento completo em container (Arch Linux).

## Tools Included
## Requirements
## Usage
```
