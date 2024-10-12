FROM archlinux:base-devel

ENV SHELL=/bin/zsh \
  TERM=xterm-256color \
  GOLANG_VERSION=1.23.2 \
  GOROOT=/home/dev/go \
  GOPATH=/home/dev/go/works \
  HOME=/home/dev

ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm git exa lazygit neovim zsh curl unzip tar ripgrep fd \
  nodejs npm python python-pip poetry lua luarocks fzf tmux zoxide htop \
  lsof strace iputils net-tools inetutils openssh jq tcpdump iproute2 iftop \
  iotop man-db bash-completion duf glances ncdu lshw && \
  rm -rf /var/cache/pacman/pkg/* && \
  useradd -m -s /bin/zsh dev && \
  echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER dev
WORKDIR $HOME

RUN rm -rf $HOME/.local/share/zinit/zinit.git && \
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
  mkdir -p $HOME/.cache/fsh && \
  touch $HOME/.cache/fsh/secondary_theme.zsh && \
  curl -OL https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
  tar -C $HOME -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
  rm go${GOLANG_VERSION}.linux-amd64.tar.gz

RUN git clone https://github.com/RenatoValentim/dotfiles && \
  mkdir -p $HOME/.config && \
  ln -sf $HOME/dotfiles/config/lazyvim $HOME/.config/nvim && \
  ln -sf $HOME/dotfiles/config/lazygit $HOME/.config/lazygit && \
  ln -sf $HOME/dotfiles/config/tmux $HOME/.config/tmux && \
  ln -sf $HOME/dotfiles/config/zsh/.zshrc $HOME/.zshrc && \
  ln -sf $HOME/dotfiles/config/.p10k.zsh $HOME/.p10k.zsh && \
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && \
  git config --global core.editor "nvim"

RUN echo "export GOROOT=$GOROOT" >> $HOME/.zshrc && \
  echo "export GOPATH=$GOPATH" >> $HOME/.zshrc && \
  echo "export PATH=\$PATH:$GOROOT/bin:$GOPATH/bin" >> $HOME/.zshrc

RUN git clone https://aur.archlinux.org/yay.git && \
  cd yay && \
  makepkg -si --noconfirm && \
  cd .. && rm -rf yay
