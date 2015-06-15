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
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# tmux
ZSH_TMUX_AUTOQUIT=true

# syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)

# python
if [[ -f /etc/arch-release ]]; then
    PATH="$HOME/.local/bin:$PATH"
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
    export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper_lazy.sh
    export WORKON_HOME=~/.virtualenvs
fi

# ruby
PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"

export PATH

# go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# export GIMME_GO_VERSION=1.4.1
# export GIMME_SILENT_ENV=
# export GIMME_NO_ENV_ALIAS=
# GIMME_ENV=$HOME/.gimme/envs/go$GIMME_GO_VERSION.env
# source $GIMME_ENV
# if [[ -d $GIMME_ENV ]]; then echo "hi"; ; fi

# GCE
source '/home/ory/google-cloud-sdk/path.zsh.inc'
source '/home/ory/google-cloud-sdk/completion.zsh.inc'

# oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then mkdir $ZSH_CACHE_DIR; fi

DISABLE_AUTO_UPDATE="true"
ZSH_THEME="simple"
COMPLETION_WAITING_DOTS="true"

plugins=(
    python pip django celery virtualenv virtualenvwrapper
    npm
    go
    aws tugboat
    tmux docker
    zsh-syntax-highlighting history-substring-search colored-man colorize web-search
)

if [[ -f /etc/arch-release ]]; then
    plugins+=(archlinux systemd)
else  # ubuntu
    plugins+=(debian)
fi

# sourcing oh-my-zsh should be executed at the end
source $ZSH/oh-my-zsh.sh
