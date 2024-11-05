# Juno's Dotfiles
A collection of my personal configuration files (dotfiles) to set up a development environment efficiently.

## Features
- Shell Configuration: Custom Fish shell settings and aliases.
- Editor Setup: Configurations for Vim and Helix editor.
- Tool Installations: Scripts to install essential utilities like ripgrep, fd-find, gh, and more.
- Workspace Initialization: Sets up a dedicated workspace directory.

## Installation
### Prerequisites
- **Operating System:** Debian-based Linux distribution.
- **Permissions:** Ability to execute sudo commands.

### Steps
1. Clone the Repository


    git clone https://github.com/junomars/dotfiles.git
    cd dotfiles

2. Run the Installation Script


    chmod +x install.sh

3. Execute the script:


    ./install.sh

## What the Script Does
- Installs Essential Packages: Installs tools like curl, gcc, tmux, vim, fish, etc.
- Sets Up Chezmoi: Initializes and applies dotfiles using Chezmoi.
- Configures Fish Shell: Changes the default shell to Fish and installs plugins and themes.
- Installs Helix Editor: Sets up the Rust toolchain and installs Helix via Cargo.
- Creates Workspace Directory: Makes a workspace directory in the home folder.

## Customization
Feel free to adjust the configurations:

- Fish Shell: Modify config.fish and fish-aliases.sh.
- Editors: Update .vimrc and Helix configurations.

## License
This project is licensed under the MIT License.

## Acknowledgments
Thanks to the open-source community for the tools and inspiration.