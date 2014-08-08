# setting terminal to be 256 colors
set -g -x TERM screen-256color

# adding local/bin to PATH
set -g -x PATH /usr/local/bin $PATH

# setting editor
set -x EDITOR vim
setenv EDITOR vim

# eliminating welcome message
set -g -x fish_greeting

# adding path for ruby gem
set -g -x PATH $PATH /usr/local/opt/ruby/bin

# setting up virtual fish
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

# setting powerline as my prompt
function fish_prompt
    ~/powerline-shell.py $status --shell bare ^/dev/null
end

# aliases
alias tmux="tmux -2"
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
