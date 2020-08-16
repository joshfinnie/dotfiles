export ZSH=$HOME/.oh-my-zsh
export TERM="screen-256color"

ZSH_THEME="bullet-train"
ZSH_TMUX_AUTOSTART="true"
DEFAULT_USER="jjfinnie-admin"

plugins+=(
    nvm
    tmux
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export LANG=en_US.UTF-8
export EDITOR="vim"

### Adding location for NPM with Homebrew Node
export NODE_PATH="/usr/local/lib/node"
export NODE_PATH="$NODE_PATH:/usr/local/lib/node_modules"
export PATH="/usr/local/share/npm/bin:$PATH"

### Adding path for Homebrewed Ruby gems
export PATH=$(brew --prefix ruby)/bin:$PATH

### Adding paths for Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

### Adding path for NVM
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"  # This loads nvm

source ~/.aliases
source ~/.zprofile

# FZF using AG
export FZF_DEFAULT_COMMAND='ag -g ""'

# ASDF setup
source $(brew --prefix asdf)/asdf.sh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/jfinnie-admin/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/jjfinnie-admin/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/jjfinnie-admin/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/jjfinnie-admin/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
