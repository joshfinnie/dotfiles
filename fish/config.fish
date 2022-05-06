if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR emacs

set -x FZF_DEFAULT_COMMAND 'ag -g "" --hidden --ignore .git'

source $HOME/.config/fish/conf.d/abbr.fish
source $(brew --prefix asdf)/asdf.fish

starship init fish | source
