#!/bin/bash

GITHUB_USERNAME=junomars
DOTFILES_URI=${DOTFILES_URI:-https://github.com/$GITHUB_USERNAME/dotfiles}

sudo apt-get update

# Chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"
sudo mv ./bin/* /usr/local/bin/
chmod +x /usr/local/bin/chezmoi
rm -rf ./bin
chezmoi init --apply https://github.com/$GITHUB_USERNAME/dotfiles.git

# Packages
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
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
cd /usr/local/
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term --locked

# Dev setup
sudo mkdir /usr/local/dev
sudo chown coder:coder /usr/local/dev
ln -s /usr/local/dev /home/coder/workspace
