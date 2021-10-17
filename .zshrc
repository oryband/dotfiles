# credits https://pastebin.com/Tgji4PZv

# zinit {{{
source '/home/ory/.zinit/bin/zinit.zsh'
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# }}}

# prezto {{{
zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'
zinit ice svn; zinit snippet PZT::modules/helper
zinit ice svn; zinit snippet PZT::modules/environment
zinit ice svn; zinit snippet PZT::modules/terminal
zinit ice svn; zinit snippet PZT::modules/editor
zinit ice svn silent; zinit snippet PZT::modules/gpg
zinit ice svn silent pick"init.zsh" lucid; zinit snippet PZT::modules/utility
# }}}

# colors {{{
export BASE16_THEME='eighties'
zinit light 'chrissicool/zsh-256color'
zinit ice pick"scripts/base16-${BASE16_THEME}.sh"; zinit light fnune/base16-shell
zinit ice lucid wait'0' src"bash/base16-${BASE16_THEME}.config" pick"bash/base16-${BASE16_THEME}.config" nocompile'!'; zinit light fnune/base16-fzf
# }}}

# misc plugins {{{
zinit ice from"gh-r" as"program" bpick"*x86_64-unknown-linux-gnu*" pick"fd-*/fd"; zinit light sharkdp/fd
zinit ice pick"bd.zsh"; zinit light Tarrasch/zsh-bd
zinit light djui/alias-tips
zinit ice from"gh-r" as"program" bpick"*x86_64-unknown-linux-gnu*" pick"lsd-*/lsd"; zinit light Peltoche/lsd
zinit ice from"gh-r" as"program" pick"diff-so-fancy"; zinit light so-fancy/diff-so-fancy
# }}}

# prompt {{{
eval "$(starship init zsh)"
# }}}

# tmux {{
zstyle ':prezto:module:tmux:session' name '0'
# [[ -n $DISPLAY ]] && zstyle ':prezto:module:tmux:auto-start' local 'yes'
zinit ice svn; zinit snippet PZT::modules/tmux
# }}}

# fzf {{{
zinit ice as"program" pick="bin/(fzf|fzf-tmux)" atclone="\cp -f shell/completion.zsh _fzf_completion" atpull"%atclone" make="install"; zinit light junegunn/fzf
# }}}

# enhancd {{{
export ENHANCD_FILTER=fzf-tmux
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HYPHEN=1
export ENHANCD_DISABLE_HOME=1
zinit ice pick"init.sh"; zinit light b4b4r07/enhancd
# }}}

# completion {{{
zinit ice svn wait silent pick"init.zsh" blockf; zinit snippet PZT::modules/completion
unsetopt CORRECT
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt FLOW_CONTROL
setopt MENU_COMPLETE
setopt NO_NOMATCH
setopt PATH_DIRS
# }}}

# suggestions {{{
zinit ice wait atload"_zsh_autosuggest_start" lucid; zinit light zsh-users/zsh-autosuggestions
# }}}

# history {{{
zinit ice svn; zinit snippet PZT::modules/history
zinit ice wait"1" silent pick"zsh-history-substring-search.plugin.zsh" lucid; zinit light zsh-users/zsh-history-substring-search
zinit ice wait"1" silent pick"history-search-multi-word.plugin.zsh" lucid; zinit light zdharma/history-search-multi-word
zstyle ":plugin:history-search-multi-word" active "standout"
# }}}

# syntax highlighting {{{
# NOTE must be last plugin to load
zinit ice wait lucid atinit"zpcompinit; zpcdreplay"; zinit light zdharma/fast-syntax-highlighting
# }}}

# load everything {{{
autoload -Uz compinit
compinit
zinit cdreplay -q
# }}}

# disable C-s stopping receiving keyboard signals.
stty start undef
stty stop undef

# vi mode {{{
bindkey -v
# export KEYTIMEOUT=1  # 100 ms vim mode change key timeout
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^b' backward-word
bindkey '^f' forward-word
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^?' backward-delete-char  # backspace and ^h working even after returning from command mode
bindkey '^h' backward-delete-char
# }}}

# terminal {{{
setopt PROMPT_SUBST
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit
# }}}

# java {{{
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export PATH="$JAVA_HOME/bin:$PATH"
# }}}

# clojure {{{
zinit ice from"gh-r" as"program" pick"clojure-lsp"; zinit light clojure-lsp/clojure-lsp
zinit ice from"gh-r" as"program" pick"bb"; zinit light babashka/babashka
# }}}

# python {{{
export ZSH_PYENV_LAZY_VIRTUALENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
zinit light davidparsson/zsh-pyenv-lazy
# }}}

# jq {{{
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'
# }}}

# source secret env keys, etc.
source $HOME/.zsh-secrets

# aliases {{{
alias c="cd"
alias c-="c -"
alias cd..="cd .."

alias cat="batcat"

alias ls="lsd --group-dirs first"

alias tailf="tail -f"

alias grep="rg"
alias ag="rg"

alias js="node"
alias tree="lsd --tree"
alias vi="nvim"
alias viupdate="vi '+PlugUpgrade' '+PlugUpdate!' '+qall!'"

# tcpdump all requests made by given process
alias sysdig="sudo sysdig"
alias csysdig="sudo csysdig"
httpdump() { sysdig -s 2000 -A -c echo_fds proc.name=$1; }
# }}}

# git {{{
zinit light paulirish/git-open
zinit ice as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"; zinit light tj/git-extras

# scm_breeze {{{
zinit ice atpull"$ZINIT[PLUGINS_DIR]/scmbreeze---scm_breeze/install.sh" pick"$HOME/.scm_breeze/scm_breeze.sh"; zinit light scmbreeze/scm_breeze
# }}}

# aliases {{{
alias gc="g c"
alias ga="g add"
alias gmv="g mv"
alias grs="git reset"
alias gl="g l"
alias gll="g ll"
alias gd="git d"
alias gds="git ds"
alias gdc="git dc"
alias gsh="g sh"
alias grp="g rp"
alias gbr="g br"
alias gbdr="g bdr"
alias gbdm="g bdm"
alias gprune="g prune"
# }}}
# }}}

# docker {{{
zinit ice from"gh-r" as"program"; zinit light derailed/k9s
alias dr="docker run --rm -it"
alias di="docker images | head -n 1 && docker images | tail -n +2 | sort"
alias dps="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"
alias drmcd='drm $(dps -q -f status=exited -f status=created)'
alias drmvd='docker volume rm $(docker volume ls -q -f dangling=true)'
alias drmid='drmi $(docker images -q -f dangling=true)'
alias dpurge="drmcd ; drmvd ; drmid ; docker network prune -f"
alias dc="docker-compose"
# }}}

# vim:foldlevel=0
# vim:foldmethod=marker
