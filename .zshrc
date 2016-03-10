# credits github.com/sorin-ionescu/prezto

# zplug
source $HOME/.zplug/zplug
zplug "b4b4r07/zplug"  # don't forget to zplug update --self && zplug update
zplug "sorin-ionescu/prezto", of:init.zsh, do:"ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto ~/.zprezto"
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:load' pmodule 'environment' 'history' 'terminal' 'utility' 'tmux'
zstyle ':prezto:module:terminal' auto-title 'yes'
zplug "michaeldfallen/git-radar", as:command, of:git-radar
zplug "ndbroadbent/scm_breeze", do:"$ZPLUG_HOME/repos/ndbroadbent/scm_breeze/install.sh"
zplug "djui/alias-tips"
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions", of:src, nice:-20
zplug "zsh-users/zsh-syntax-highlighting", nice:18  # >=10 means after compinit
zplug "zsh-users/zsh-history-substring-search", nice:19
zplug load

# options
setopt no_complete_aliases  # expand aliases for auto-completion
stty start undef  # disable C-s stopping receiving keyboard signals.
stty stop undef
setopt NO_NOMATCH  # stop zsh from catching ^ chars.
setopt PROMPT_CR  # hide annoying '%' sign.
setopt PROMPT_SP
export PROMPT_EOL_MARK=""
unsetopt CORRECT  # no autocorrection
setopt PROMPT_SUBST  # prompt substitution
setopt COMPLETE_ALIASES  # don't expand aliases _before_ completion has finished, like: git comm-[tab]

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

# base16
BASE16_SHELL="/usr/share/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# command not found package suggestion
source /usr/share/doc/pkgfile/command-not-found.zsh

# git-radar
export GIT_RADAR_FORMAT="[%{$reset_color%}%{remote: }%{branch}%{ :local}%{$reset_color%}%{ :changes}%{ :stash}] "
export GIT_RADAR_MASTER_SYMBOL="m"

# scm_breeze
[ -s "/home/ory/.scm_breeze/scm_breeze.sh" ] && source "/home/ory/.scm_breeze/scm_breeze.sh"

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# source secret env keys, etc.
source $HOME/.zsh-secrets

# aliases
alias ll="k"  # overriding scm_breeze
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
alias drmd="dps | grep -e Exited -e Created | cut -d ' ' -f 1 | xargs -I{} docker rm {}"
alias drmid="docker images -qf dangling=true | xargs -I {} docker rmi -f {} && \
    docker images | grep \"^<none>\" | awk \"{print $3}\" | xargs -I {} docker rmi -f {}"
alias dc="docker-compose"
