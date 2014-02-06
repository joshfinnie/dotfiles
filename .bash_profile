source /usr/local/bin/virtualenvwrapper.sh

PS1='\n\d @ \@\n\u > \w$(__git_ps1 " (Git Branch - %s)")\n\$ '

### A function to find the registrant of a domain name
function whoreg () {
	whois $1 | grep Registrant;
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Adding location for NPM with Homebrew Node
export PATH="/usr/local/share/npm/bin:$PATH"

### Adding location for Postgres app
export PATH="$PATH:/Applications/Postgres.app/Contents/MacOS/bin"

### Using Homebrew locations for pyenv
eval "$(pyenv init -)"
export PYENV_ROOT=/usr/local/opt/pyenv

### Virtualenv Wrapper
export WORKON_HOME=/usr/local/env/
source /usr/local/bin/virtualenvwrapper.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
source ~/.profile
source ~/.aliases
