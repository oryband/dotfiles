# credits github.com/sorin-ionescu/prezto

# zplug
export ZPLUG_HOME=$HOME/.zplug
export PATH=$ZPLUG_HOME/bin:$PATH
source $ZPLUG_HOME/init.zsh
zplug "zplug/zplug", at:2.1.0, nice:1  # don't forget to zplug update --self && zplug update

zplug "sorin-ionescu/prezto", use:init.zsh, nice:2, hook-build:"ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto ~/.zprezto"
zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:load' pmodule 'environment' 'history' 'terminal' 'utility' 'tmux' 'completion'
zstyle ':prezto:module:terminal' auto-title 'yes'

zplug "Tarrasch/zsh-bd", use:bd.zsh
zplug "chriskempson/base16-shell", use:"scripts/base16-eighties.sh"
zplug "dennishafemann/tmux-cssh", use:"tmux-cssh", as:command
zplug "digitalocean/doctl", from:gh-r, use:"*linux*amd64*.tar.gz", as:command
zplug "djui/alias-tips"
zplug "github/hub", from:gh-r, use:"*linux*amd*", as:command
zplug "junegunn/fzf", use:"bin/fzf-tmux", as:command
zplug "junegunn/fzf-bin", from:gh-r, use:"*linux*amd64*", rename-to:"fzf", as:command
zplug "justone/dockviz", from:gh-r, use:"*linux*amd64*", as:command
zplug "michaeldfallen/git-radar", use:git-radar, as:command
zplug "scmbreeze/scm_breeze", hook-build:"$ZPLUG_HOME/repos/scmbreeze/scm_breeze/install.sh"
zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "supercrabtree/k"
zplug "tj/git-extras", use:"bin/*", as:command, hook-build:"make install PREFIX=$HOME/.git-extras"
zplug "tstack/lnav", from:gh-r, use:"*linux*64*", as:command
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh, nice:17  # after prezto
zplug "zsh-users/zsh-syntax-highlighting", nice:18  # >=10 means after compinit
zplug "zsh-users/zsh-history-substring-search", nice:19

zplug load

# options
stty start undef  # disable C-s stopping receiving keyboard signals.
stty stop undef
setopt COMPLETE_ALIASES  # don't expand aliases _before_ completion has finished, like: git comm-[tab]
unsetopt CORRECT  # no autocorrection suggestions
setopt MENU_COMPLETE  # select first menu option automatically
setopt NO_NOMATCH  # stop zsh from catching ^ chars.
setopt PROMPT_SUBST  # prompt substitution

# vi mode
bindkey -v
# export KEYTIMEOUT=1  # 100 ms vim mode change key timeout
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^b' backward-word
bindkey '^f' forward-word
bindkey '^p' up-history  # Use vim cli mode
bindkey '^n' down-history
bindkey '^?' backward-delete-char  # backspace and ^h working even after returning from command mode
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word  # ctrl-w removed word backwards
bindkey '^r' history-incremental-search-backward  # ctrl-r starts searching history backward

# theme
get_pwd() {
    git_root=$PWD
    while [[ $git_root != / && ! -e $git_root/.git ]]; do git_root=$git_root:h; done
    if [[ $git_root = $HOME || $git_root = / ]]; then unset git_root; prompt_short_dir=%~;
    else parent=${git_root%\/*}; prompt_short_dir=${PWD#$parent/}; fi
    echo $prompt_short_dir
}
prompt_virtualenv() { [[ -n $VIRTUAL_ENV && -n $VIRTUAL_ENV_DISABLE_PROMPT ]] && echo "%{$fg_bold[white]%}($(basename $VIRTUAL_ENV)) "; }
autoload -Uz get_pwd
autoload -Uz prompt_virtualenv
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit
PROMPT="%{$fg_bold[magenta]%}\$(get_pwd)%{$reset_color%} \$(git-radar --zsh --fetch)\$(prompt_virtualenv)%{$fg_bold[magenta]%}λ%{$reset_color%} "

# syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'

# history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# enhancd
if zplug check b4b4r07/enhancd; then
    export ENHANCD_FILTER=fzf-tmux
    export ENHANCD_DISABLE_DOT=1
    export ENHANCD_DISABLE_HYPHEN=1
fi

# python
export PATH=$HOME/.local/bin:$PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_PYTHON=$(which python2)
export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper.sh
source $VIRTUALENVWRAPPER_SCRIPT

# ruby
export PATH=$(ruby -e 'print Gem.user_dir')/bin:$PATH

# go
export GOROOT=$HOME/Documents/golang/go1.6.2
export GOPATH=$HOME/.golang/go1.6.2
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
alias go1.6.2=$GOROOT/bin/go
alias go=go1.6.2

# command not found package suggestion
source /usr/share/doc/pkgfile/command-not-found.zsh

# git-radar
export GIT_RADAR_FORMAT="[%{$reset_color%}%{remote: }%{branch}%{ :local}%{$reset_color%}%{ :changes}%{ :stash}] "
export GIT_RADAR_MASTER_SYMBOL="m"

# scm_breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# travis
[ -f /home/ory/.travis/travis.sh ] && source /home/ory/.travis/travis.sh

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# git-extras
export PATH=$HOME/.git-extras:$PATH

# source secret env keys, etc.
source $HOME/.zsh-secrets

# aliases

alias c="cd"
alias c-="c -"

alias l="k -h"
alias ll="l"  # override scm_breeze
alias la="l -A"  # override scm_breeze

alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"

alias js="node"
alias tree="tree -C"
alias vi="vim"
alias xclip="xclip -selection clipboard"
alias ssh="cat ~/.ssh/config.d/* > ~/.ssh/config && ssh"  # allow for multiple ssh config files

# tcpdump all requests made by given process
alias sysdig="sudo sysdig"
alias csysdig="sudo csysdig"
httpdump() { sysdig -s 2000 -A -c echo_fds proc.name=$1; }

alias ga="git add"
# alias gc="g c"
# alias gf="g f"
# alias gcp="g cp"
# alias gmv="g mv"
alias grs="git reset"
# alias grm="g rm"

# alias gpl="g pl"
# alias gps="g ps"
# alias gpsf="g ps --force"

# alias gco="g co"
# alias gcb="g cb"

# alias gl="g l"
# alias gll="g ll"
# alias glt="g lt"

# alias gd="g d"
alias gds="git ds"
# alias gdc="g dc"
# alias gdcs="g dcs"

# alias grb="g rebase"
# alias grbi="g rbi"

# alias gsh="g sh"
# alias gshc="g shc"

# alias gb="g b"
# alias gbr="g br"
# alias gbdr="g bdr"
# alias gbdm="g bdm"
# alias gprune="g prune"

# alias gst="g st"
# alias gsl="g sl"
# alias gsp="g sp"

# docker
alias dr="docker run --rm -it"
alias di="docker images"
alias dps="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"
alias drmd="dps | grep -e Exited -e Created | cut -d ' ' -f 1 | tr '\n' ' ' | xargs docker rm"
alias drmid="docker images -qf dangling=true | tr '\n' ' ' | xargs docker rmi -f && \
    docker images | grep \"^<none>\" | awk \"{print $3}\" | tr '\n' ' ' | tr '\n' ' ' | xargs docker rmi -f"
alias dc="docker-compose"
