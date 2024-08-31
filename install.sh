#!/bin/bash

GITHUB_USERNAME=junomars
DOTFILES_URI=${DOTFILES_URI:-https://github.com/$GITHUB_USERNAME/dotfiles}

sudo apt-get update

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

sudo apt-get install -y \
  curl gcc jq zip unzip htop tmux vim python3 python3-pip \
  zsh fonts-powerline \
  ripgrep fd-find \
  gh

# Fish
sudo chsh -s /usr/bin/fish $USER
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install oh-my-fish/theme-bobthefish"
curl -sL $DOTFILES_URI/raw/master/fish-aliases.sh -o /tmp/fish-aliases.sh
fish -c "fish /tmp/fish-aliases.sh"

# Nx
fish -c "set -Ux NX_REJECT_UNKNOWN_LOCAL_CACHE 0"

# Helix
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
