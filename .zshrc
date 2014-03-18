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

export PATH="/usr/local/bin:$PATH"

### Adding location for NPM with Homebrew Node
export PATH="/usr/local/share/npm/bin:$PATH"

### Adding location for Postgres app
export PATH="$PATH:/Applications/Postgres.app/Contents/MacOS/bin"

# Aliases
source $HOME/.aliases

export TERM="screen-256color"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
