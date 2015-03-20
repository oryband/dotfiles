ZSH=/usr/share/oh-my-zsh

# Tmux support
if [ "$TMUX" = "" ]; then
    TERM=xterm-256color
else
    TERM=screen-256color
fi

ZSH_THEME="simple"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
    python pip django
    history-substring-search colored-man colorize web-search
    docker aws tugboat
    osx brew brew-cask
    npm mvn
)

source $ZSH/oh-my-zsh.sh

alias vi="vim"
alias la="ls -A"
alias lla="la -l"
alias casks="brew cask list"
alias js="node"
alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"
alias tmux="tmux attach"
alias xclip="xclip -selection clipboard"

export EDITOR='vim'
export VISUAL=$EDITOR

# Disable C-s stopping receiving keyboard signals.
stty start undef
stty stop undef

# Detach instead of exit in tmux.
exit() {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        tmux detach
    fi
}

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

# Google Cloud SDK
# source '/home/ory/Documents/google-cloud-sdk/path.zsh.inc'
# source '/home/ory/Documents/google-cloud-sdk/completion.zsh.inc'
