#!/bin/bash

GITHUB_USERNAME=junomars
DOTFILES_URI=${DOTFILES_URI:-https://github.com/$GITHUB_USERNAME/dotfiles}
BIN_DIR="/usr/local/bin"
WORKSPACE_DIR="/home/coder/workspace"
HELIX_DIR="/usr/local/helix"

# Function to install chezmoi
install_chezmoi() {
  sh -c "$(curl -fsLS get.chezmoi.io)"
  if [ -d ./bin ]; then
    sudo mv ./bin/* $BIN_DIR/
    chmod +x $BIN_DIR/chezmoi
    rm -rf ./bin
  fi
  chezmoi init --apply $DOTFILES_URI.git
}

# Function to install apt packages
install_packages() {
  sudo apt-get update
  sudo apt-get install -y \
    curl gcc jq zip unzip htop tmux vim python3 python3-pip \
    zsh fonts-powerline \
    ripgrep fd-find \
    gh
}

# Function to configure Fish shell
configure_fish() {
  sudo chsh -s /usr/bin/fish $USER
  fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
  fish -c "fisher install oh-my-fish/theme-bobthefish"
  curl -sL $DOTFILES_URI/raw/master/fish-aliases.sh -o /tmp/fish-aliases.sh
  fish -c "fish /tmp/fish-aliases.sh"
}

# Function to configure NX
configure_nx() {
  fish -c "set -Ux NX_REJECT_UNKNOWN_LOCAL_CACHE 0"
}

# Function to install Helix
install_helix() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  sudo git clone https://github.com/helix-editor/helix $HELIX_DIR
  sudo chown -R coder:coder $HELIX_DIR
  cargo install --path $HELIX_DIR/helix-term --locked --target-dir /home/coder/helix-target
}

# Function to setup development workspace
setup_workspace() {
  mkdir -p $WORKSPACE_DIR
}

# Main function to run all tasks
main() {
  install_chezmoi
  install_packages
  configure_fish
  configure_nx
  install_helix
  setup_workspace
}

# Run main function
main