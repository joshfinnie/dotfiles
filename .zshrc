export ZSH=/Users/joshfinnie/.oh-my-zsh
export TERM="screen-256color"

ZSH_THEME="bullet-train"
ZSH_TMUX_AUTOSTART="true"
DEFAULT_USER="joshfinnie"

plugins+=(zsh-nvm tmux)
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
export NVM_DIR="/Users/joshfinnie/.nvm"
source "$NVM_DIR/nvm.sh"  # This loads nvm


### Making sure Pyenv works
eval "$(pyenv init -)"

# YarnPkg
export PATH="$PATH:$HOME/.yarn/bin"

# oh-my-zsh specific aliases
alias bower='noglob bower'

# Android SDK (from Homebrew) path
export ANDROID_HOME=/usr/local/opt/android-sdk

source ~/.aliases
source ~/.zprofile

# FZF using AG
export FZF_DEFAULT_COMMAND='ag -g ""'

### Adding ZSH Autocomplete
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/joshfinnie/.nvm/versions/node/v6.9.2/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# Kubectl autocomplete.
if [ $commands[kubectl]  ]; then source <(kubectl completion zsh); fi
