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

# base16
BASE16_SHELL="/usr/share/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# tmux
ZSH_TMUX_AUTOQUIT=true

# syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'

# python
export VIRTUALENVWRAPPER_PYTHON=$(which python2)
export VIRTUALENVWRAPPER_SCRIPT=$(which virtualenvwrapper_lazy.sh)
export WORKON_HOME=~/.virtualenvs

# ruby
export PATH=$(ruby -e 'print Gem.user_dir')/bin:$PATH

# go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# command not found package suggestion
source /usr/share/doc/pkgfile/command-not-found.zsh

ZSH_THEME="kolo"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
    archlinux systemd
    python pip django celery virtualenv virtualenvwrapper
    npm
    go
    aws tugboat
    tmux
    docker
    colored-man colorize web-search
    history-substring-search
    zsh-syntax-highlighting # syntax-highlighting plugin must be sourced last
)

# sourcing oh-my-zsh should be executed at the end
ZSH=$HOME/.oh-my-zsh
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then mkdir $ZSH_CACHE_DIR; fi
source $ZSH/oh-my-zsh.sh
