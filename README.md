# dotfiles

Personal configuration files, version controlled.

## Structure

| Directory | Config for | Symlink target |
|-----------|-----------|----------------|
| `bash/` | Bash | `~/.aliases`, `~/.bash_profile`, `~/.bashrc`, `~/.profile` |
| `zsh/` | Zsh + oh-my-zsh theme | `~/.zshrc`, `~/.oh-my-zsh/custom/themes/` |
| `fish/` | Fish shell | `~/.config/fish/` |
| `tmux/` | tmux | `~/.tmux.conf` |
| `vim/` | Vim | `~/.vimrc` |
| `nvim/` | Neovim | `~/.config/nvim` |
| `wezterm/` | WezTerm | `~/.config/wezterm` |
| `js/` | JSHint | `~/.jshintrc` |
| `doom/` | Doom Emacs | — |
| `colors/` | Vim color schemes | — |
| `iterm/` | iTerm2 color schemes | — |
| `fonts/` | Fonts | — |

## Usage

Link everything:

```sh
make
```

Or link a specific config:

```sh
make nvim
make fish
make wezterm
```
