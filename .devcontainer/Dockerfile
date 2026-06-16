FROM archlinux:base-devel

ENV SHELL=/bin/fish \
  TERM=xterm-256color \
  HOME=/home/dev

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm git eza lazygit neovim fish curl unzip tar ripgrep fd \
  lua luarocks fzf tmux zoxide htop starship \
  lsof strace iputils net-tools inetutils openssh jq tcpdump iproute2 iftop \
  iotop man-db bash-completion duf glances ncdu lshw && \
  rm -rf /var/cache/pacman/pkg/* && \
  useradd -m -s /bin/fish dev && \
  echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev
WORKDIR $HOME

RUN git clone https://aur.archlinux.org/yay.git && \
  cd yay && \
  makepkg -si --noconfirm && \
  cd .. && rm -rf yay

RUN yay -S --noconfirm mise-bin

RUN git clone https://github.com/RenatoValentim/dotfiles && \
  mkdir -p $HOME/.config && \
  ln -sf $HOME/dotfiles/config/fish $HOME/.config/fish && \
  ln -sf $HOME/dotfiles/config/lazyvim $HOME/.config/nvim && \
  ln -sf $HOME/dotfiles/config/lazygit $HOME/.config/lazygit && \
  git config --global core.editor "nvim"

RUN mkdir -p $HOME/.config/mise && \
  printf '[tools]\ngo = "latest"\nnode = "lts"\npython = "latest"\n' > $HOME/.config/mise/config.toml && \
  mise install
