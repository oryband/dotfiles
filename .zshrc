ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
COMPLETION_WAITING_DOTS="true"

alias la="ls -A"
alias lla="la -l"
alias js="node"
alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"
alias xclip="xclip -selection clipboard"

# vim
alias vi="vim"
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

# Base16 colors
BASE16_SHELL="$HOME/.config/base16-shell/base16-solarized.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# tmux
# ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=true

# Ruby
PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH

# Go
[[ -s "/home/ory/.gvm/scripts/gvm" ]] && source "/home/ory/.gvm/scripts/gvm"

# must come at the bottom
plugins=(
    python pip django virtualenvwrapper
    npm
    aws tugboat
    tmux docker
    history-substring-search colored-man colorize web-search
)

source $ZSH/oh-my-zsh.sh
