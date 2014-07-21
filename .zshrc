# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="joshfinnie"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export EDITOR='vim'

# Virtualenv Wrapper
export WORKON_HOME=$HOME/.venvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
source /usr/local/bin/virtualenvwrapper.sh

has_virtualenv() {
    if [ -e .venv ]; then
        workon `cat .venv`
    fi
}

venv_cd() {
    cd "$@" && has_virtualenv
}

alias cd="venv_cd"

export PATH="/usr/local/bin:$PATH"

### Adding location for NPM with Homebrew Node
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/share/npm/bin:$PATH"

### Adding location for Postgres app
export PATH="$PATH:/Applications/Postgres.app/Contents/MacOS/bin"

### Adding path for Homebrewed Ruby gems
export PATH=$(brew --prefix ruby)/bin:$PATH

### Adding location for Latex (After downloading it from here: http://tug.org/mactex/)
export PATH="$PATH:/usr/texbin"

### Adding paths for Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Aliases
source $HOME/.aliases

# oh-my-zsh specific aliases
alias bower='noglob bower'

# Android SDK (from Homebrew) path
export ANDROID_HOME=/usr/local/opt/android-sdk

# Bumping up VM RAM to 4GB
export VM_MEMORY=4096

export TERM="screen-256color"
