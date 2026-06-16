FROM archlinux:base-devel AS builder

RUN pacman -Sy --noconfirm git

RUN useradd -m -s /bin/bash builder && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builder
WORKDIR /home/builder

RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm && \
    cd .. && rm -rf yay

FROM archlinux:latest

ENV SHELL=/bin/fish \
  TERM=xterm-256color \
  HOME=/home/dev

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --from=builder /usr/bin/yay /usr/bin/yay

RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm git eza lazygit neovim fish curl unzip tar ripgrep fd \
  lua luarocks fzf tmux zoxide htop starship fakeroot \
  lsof strace iputils net-tools inetutils openssh jq tcpdump iproute2 iftop \
  iotop man-db bash-completion duf glances ncdu lshw && \
  rm -rf /var/cache/pacman/pkg/* && \
  useradd -m -s /bin/fish dev && \
  echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev
WORKDIR $HOME

RUN yay -S --noconfirm mise-bin

RUN git clone https://github.com/RenatoValentim/dotfiles && \
  mkdir -p $HOME/.config/fish/conf.d && \
  ln -sf $HOME/dotfiles/config/fish/config.fish $HOME/.config/fish/config.fish && \
  ln -sf $HOME/dotfiles/config/fish/fish_plugins $HOME/.config/fish/fish_plugins && \
  ln -sf $HOME/dotfiles/config/fish/fish_variables $HOME/.config/fish/fish_variables && \
  ln -sf $HOME/dotfiles/config/fish/starship.toml $HOME/.config/fish/starship.toml && \
  ln -sf $HOME/dotfiles/config/fish/completions $HOME/.config/fish/completions && \
  ln -sf $HOME/dotfiles/config/fish/functions $HOME/.config/fish/functions && \
  for f in $HOME/dotfiles/config/fish/conf.d/*; do ln -sf "$f" $HOME/.config/fish/conf.d/; done && \
  printf 'fish_add_path "$HOME/.devcontainers/bin"\n' > $HOME/.config/fish/conf.d/container.fish && \
  ln -sf $HOME/dotfiles/config/lazyvim $HOME/.config/nvim && \
  ln -sf $HOME/dotfiles/config/lazygit $HOME/.config/lazygit && \
  git config --global core.editor "nvim"

RUN mkdir -p $HOME/.config/mise && \
  printf '[tools]\ngo = "latest"\nnode = "lts"\npython = "latest"\n' > $HOME/.config/mise/config.toml && \
  mise install
