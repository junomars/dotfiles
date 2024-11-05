#!/bin/bash

set -e

GITHUB_USERNAME=junomars
DOTFILES_URI=${DOTFILES_URI:-https://github.com/$GITHUB_USERNAME/dotfiles}
BIN_DIR="/usr/local/bin"
WORKSPACE_DIR="/home/coder/workspace"

# Function to install apt packages
install_packages() {
  sudo apt-get update
  sudo apt-get install -y \
    curl gcc jq zip unzip htop tmux vim python3 python3-pip \
    zsh fonts-powerline \
    ripgrep fd-find \
    gh \
    fish
}

# Function to install chezmoi
install_chezmoi() {
  # Use the --no-tty flag to prevent TTY access
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --no-tty $GITHUB_USERNAME
}

# Function to configure Fish shell
configure_fish() {
  sudo chsh -s /usr/bin/fish $USER
  fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
  fish -c "fisher install oh-my-fish/theme-bobthefish"
  curl -sL $DOTFILES_URI/raw/master/fish-aliases.sh -o /tmp/fish-aliases.sh
  fish /tmp/fish-aliases.sh
}

# Function to configure NX
configure_nx() {
  fish -c "set -Ux NX_REJECT_UNKNOWN_LOCAL_CACHE 0"
}

# Function to install Helix
install_helix() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
  cargo install helix-term --locked
}

# Function to setup development workspace
setup_workspace() {
  mkdir -p $WORKSPACE_DIR
}

# Main function to run all tasks
main() {
  install_packages
  install_chezmoi
  configure_fish
  configure_nx
  install_helix
  setup_workspace
}

# Run main function
main
