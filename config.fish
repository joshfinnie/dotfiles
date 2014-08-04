# adding local/bin to path.
set -g -x PATH /usr/local/bin $PATH

# eliminating welcom message.
set -g -x fish_greeting

# Loading Virtualfish Plugin
if not set -q VIRTUALFISH_HOME
    set -g VIRTUALFISH_HOME $HOME/.venvs
end
set -g VIRTUALFISH_COMPAT_ALIASES
. /Users/joshfinnie/.config/fish/virtualfish/virtual.fish

function _venvactivate --on-event virtualenv_did_activate
    echo "The virtualenv \""(basename $VIRTUAL_ENV)"\" was activated"
end

function _venvdeactivate --on-event virtualenv_did_deactivate
    echo "The virtualenv \""(basename $VIRTUAL_ENV)"\" was deactivated"
end

function fish_prompt
    ~/powerline-shell.py $status --shell bare ^/dev/null
end

set -g -x TERM screen-256color

alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'

alias h 'history'
alias which 'type -a'
alias ls 'ls -AGl'
alias serve 'python -m SimpleHTTPServer'
alias spotify '/usr/local/src/personal/SpotifyControl/SpotifyControl.scpt'
alias personal 'cd ~/src/personal/'
alias tm 'cd ~/src/trackmaven/'
alias killpyc 'find . -name \*.pyc -delete'

alias tmux="tmux -2"
