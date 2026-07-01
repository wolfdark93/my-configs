# My Configs (Dotfiles)

These are my personal configuration files (dotfiles) for Neovim, Fish shell, Kitty, and more. Optimized for a productive and aesthetically pleasing Linux environment.

## 🚀 Tools Included

- **Neovim (`nvim`)**: A modular configuration powered by `lazy.nvim` and the `NeoSolarized` colorscheme.
- **Fish Shell**: Feature-rich shell configuration including:
    - A custom multi-line prompt with Git status, battery, and background job indicators.
    - Comprehensive Git aliases (`ga`, `gp`, `gst`, `gco`, etc.).
- **Kitty**: Performance-focused terminal emulator configuration.
- **Cava**: Audio visualizer configuration for a cohesive desktop look.
- **Music Ecosystem (MPD)**: A fully automated, lightweight terminal music setup.
    - **rmpc**: Beautiful TUI client with a custom Tokyo Night theme.
    - **ashuffle**: Auto-DJ that intelligently keeps the music playing.
    - **mpd-mpris**: Integration with KDE/desktop media controls.
    - **mpdscribble**: Automatic Last.fm scrobbling in the background.
    - *(Includes an automated install script: `install_music_player.fish`)*
- **Cmus**: Legacy terminal music player. 

## 🛠️ Installation

> [!WARNING]
> Back up your existing configuration files before proceeding.

To apply these configurations, clone the repository. You can copy the entire `.config` directory or just the specific configurations you need to your home folder:

```bash
# Clone the repository
git clone https://github.com/wolfdark93/my-configs.git

# Copy all configurations to ~/.config/
cp -r .config ~/

# Or copy only what you need, for example, just Neovim:
cp -r .config/nvim ~/.config/
```

### Alternative: Using Symbolic Links
If you want to keep your local settings synced with this repository, use symbolic links:

```bash
ln -s $(pwd)/.config/nvim ~/.config/nvim
ln -s $(pwd)/.config/fish ~/.config/fish
ln -s $(pwd)/.config/kitty ~/.config/kitty
ln -s $(pwd)/.config/cava ~/.config/cava
```

## ⌨️ Shell Aliases (Fish)

The configuration includes several time-saving aliases for Git:
- `ga`: `git add`
- `gp`: `git push`
- `gpl`: `git pull`
- `gst`: `git status`
- `gco`: `git checkout`
- ... and many others found in `.config/fish/functions/`.

---
