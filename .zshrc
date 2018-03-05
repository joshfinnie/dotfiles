export ZSH=/Users/joshfinnie/.oh-my-zsh

ZSH_THEME="kennethreitz"

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

plugins+=(zsh-nvm)

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

### Adding path for Homebrewed Ruby gems
export PATH=$(brew --prefix ruby)/bin:$PATH

### Adding paths for Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# oh-my-zsh specific aliases
alias bower='noglob bower'

# Android SDK (from Homebrew) path
export ANDROID_HOME=/usr/local/opt/android-sdk

export TERM="screen-256color"

source ~/.aliases
source ~/.zprofile

export NVM_DIR="/Users/joshfinnie/.nvm"
source "$NVM_DIR/nvm.sh"  # This loads nvm

# FZF using AG
export FZF_DEFAULT_COMMAND='ag -g ""'

# YarnPkg
export PATH="$PATH:$HOME/.yarn/bin"

### Adding ZSH Autocomplete
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
