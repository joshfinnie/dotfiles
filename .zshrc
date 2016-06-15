export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="kennethreitz"

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/MacGPG2/bin:/usr/texbin"

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

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

### Adding location for NPM with Homebrew Node
export NODE_PATH="/usr/local/lib/node"
export NODE_PATH="$NODE_PATH:/usr/local/lib/node_modules"
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

# oh-my-zsh specific aliases
alias bower='noglob bower'

# Android SDK (from Homebrew) path
export ANDROID_HOME=/usr/local/opt/android-sdk

export TERM="screen-256color"

source ~/.aliases

export NVM_DIR="/Users/joshfinnie/.nvm"
source "$NVM_DIR/nvm.sh"  # This loads nvm
