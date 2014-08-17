ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
osx brew brew-cask
npm
python pip django
mvn
history-substring-search
colored-man colorize
web-search
docker
)

source $ZSH/oh-my-zsh.sh

alias la="ls -A"
alias brews="brew list"
alias casks="brew cask list"
alias js="node"
alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"
alias ack="ag"

# Tmux support
if [ "$TMUX" = "" ]; then
    TERM=xterm-256color
else
    TERM=screen-256color
fi

export EDITOR='vim'
export VISUAL=$EDITOR

# Disable C-s stopping receiving keyboard signals.
stty start undef
stty stop undef

# Stop zsh from catching ^ chars.
setopt NO_NOMATCH

# Hide annoying '%' sign.
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# Homebrew
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Ruby
PATH="/usr/local/opt/ruby/bin:$PATH"
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Latex / BasicTex
PATH="/usr/texbin:$PATH"

# Java
[[ -f /usr/libexec/java_home ]] && export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"
export ECLIPSE_HOME="/opt/homebrew-cask/Caskroom/eclipse-ide/4.3.2/eclipse"
PATH="$ECLIPSE_HOME:$PATH"

# Go
export GOPATH="$HOME/.go"
PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"

export PATH
