# aliases
alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"
# tcpdump all requests made by given process
alias sysdig="sudo sysdig"
alias csysdig="sudo csysdig"
httpdump() { sysdig -s 2000 -A -c echo_fds proc.name=$1; }
alias js="node"
alias lla="la -l"
alias tree="tree -C"
alias vi="vim"
alias xclip="xclip -selection clipboard"
# allow for multiple ssh config files
alias ssh="cat ~/.ssh/config.d/* > ~/.ssh/config && ssh"
# docker
alias dr="docker run --rm -it"
alias di="docker images"
alias dps="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"
alias drmd="dps | ag Exited | cut -d ' ' -f 1 | xargs -I{} docker rm {}"
alias drmid="docker images -qf dangling=true | xargs -I {} docker rmi -f {} && \
    docker images | grep \"^<none>\" | awk \"{print $3}\" | xargs -I {} docker rmi -f {}"
alias dc="docker-compose"

# expand aliases for auto-completion
setopt no_complete_aliases

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
BASE16_SHELL="/usr/share/base16-shell/base16-eighties.dark.sh"
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
export VIRTUAL_ENV_DISABLE_PROMPT=0 # zsh plugin

# ruby
export PATH=$(ruby -e 'print Gem.user_dir')/bin:$PATH

# go
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# command not found package suggestion
source /usr/share/doc/pkgfile/command-not-found.zsh

# git-radar
export PATH=$PATH:$HOME/.git-radar
export GIT_RADAR_FORMAT="[%{$reset_color%}%{remote: }%{branch}%{ :local}%{$reset_color%}%{ :changes}%{ :stash}] "
export GIT_RADAR_MASTER_SYMBOL="m"

# source secret env keys, etc.
source $HOME/.zsh-secrets

ZSH_THEME="ory"
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
ZSH=/usr/share/oh-my-zsh
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then mkdir $ZSH_CACHE_DIR; fi
source $ZSH/oh-my-zsh.sh

# scm_breeze
# has to come at the bottom for some unknown reason
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source $HOME/.scm_breeze/scm_breeze.sh
