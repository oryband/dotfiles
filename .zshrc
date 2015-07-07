alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"
alias js="node"
alias lla="la -l"
alias tree="tree -C"
alias vi="vim"
alias xclip="xclip -selection clipboard"

# disable C-s stopping receiving keyboard signals.
stty start undef
stty stop undef

# stop zsh from catching ^ chars.
setopt NO_NOMATCH

# hide annoying '%' sign.
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# base16 colors
BASE16_SHELL="/usr/share/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# tmux
ZSH_TMUX_AUTOQUIT=true

# syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)

# python
if [[ -f /etc/arch-release ]]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
    export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper_lazy.sh
    export WORKON_HOME=~/.virtualenvs
fi

# ruby
PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH

# go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

ZSH_THEME="simple"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

plugins=(
    archlinux systemd
    python pip django celery virtualenv virtualenvwrapper
    npm
    go
    aws tugboat
    tmux
    docker
    zsh-syntax-highlighting colored-man colorize web-search
    history-substring-search
)

# sourcing oh-my-zsh should be executed at the end
ZSH=$HOME/.oh-my-zsh
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then mkdir $ZSH_CACHE_DIR; fi
source $ZSH/oh-my-zsh.sh
