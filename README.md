# macOS Configuration

A reproducible macOS development environment setup script for quickly bootstrapping a new Mac or recovering from a clean install with minimal manual intervention.

## Purpose

This repository automates complete setup of a macOS development environment, including:
- System configuration (hostname)
- Shell environment (Oh My Zsh + PowerLevel10k)
- Terminal multiplexer (Oh My Tmux)
- Package management (Homebrew)
- CLI tools and GUI applications
- Dotfiles management with XDG Base Directory compliance

## Intended Use

Run the `install.sh` script on a fresh macOS installation to automatically configure your development environment.

```bash
git clone https://github.com/bright-e6r/macos-config.git
cd macos-config
./install.sh
```

The script will guide you through the setup process, prompting for hostname and installing all necessary components.

## Structure

```
macos-config/
 ├── install.sh                          # Main installation script
 ├── setup-*.sh                          # Modular setup scripts
 ├── dotfiles/
 │   ├── .zshrc                         # Zsh configuration template
 │   ├── alias/                         # Shell aliases
 │   ├── tmux/                          # Tmux configuration
 │   │   └── tmux.conf.local           # Oh My Tmux custom settings
 │   └── packages/                      # Package definitions
 │       ├── Brewfile                   # Homebrew packages
 │       └── Masfile                    # Mac App Store apps
 └── AGENTS.md                          # Guidance for AI agents
```

## Key Features

### Modular Setup Scripts

Each `setup-*.sh` script handles a specific configuration area:

- **setup-brewfile.sh** - Installs Homebrew packages and casks
- **setup-masfile.sh** - Installs Mac App Store applications
- **setup-ohmyzsh-powerlevel10k.sh** - Sets up Oh My Zsh, PowerLevel10k theme, and zsh plugins
- **setup-tmux.sh** - Sets up Oh My Tmux with XDG configuration
- **setup-pyenv.sh** - Sets up Pyenv for Python version management
- **setup-git-config.sh** - Configures git with XDG compliance
- **setup-alias.sh** - Sets up shell aliases

### Dotfiles Management

Dotfiles are organized under `dotfiles/` for version control:
- Shell configuration (`.zshrc`)
- Alias definitions (`alias/`)
- Tmux configuration (`tmux/`)
- Package manifests (`packages/`)

### XDG Base Directory Compliance

Configuration files respect the XDG Base Directory specification:
- `XDG_CONFIG_HOME=$HOME/.config`
- Git config stored in `$XDG_CONFIG_HOME/git/config`
- Aliases loaded from `$XDG_CONFIG_HOME/alias/`
- Tmux config stored in `$XDG_CONFIG_HOME/tmux/`

## Post-Installation

After completing a setup script:

1. Configure PowerLevel10k theme:
   ```bash
   p10k configure
   ```

2. Start tmux to use Oh My Tmux:
   ```bash
   tmux
   ```

3. Install Python with Pyenv:
   ```bash
   pyenv install 3.12.1
   pyenv global 3.12.1
   ```

4. Restart your terminal to apply all changes

5. Run `alias` to view available shell aliases

## Maintenance

To update your environment after modifying dotfiles:
- Run individual `setup-*.sh` scripts as needed
- Commit and push changes to this repository
- Pull and re-run `install.sh` on new machines
