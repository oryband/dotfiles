# credits https://pastebin.com/Tgji4PZv

# zinit {{{
source '/home/ory/.zinit/bin/zinit.zsh'
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# }}}

# prezto {{{
zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:load' pmodule \
zinit snippet PZT::modules/helper/init.zsh
zinit ice svn; zinit snippet PZT::modules/environment
zinit ice svn; zinit snippet PZT::modules/terminal
zinit ice svn; zinit snippet PZT::modules/editor
zinit ice svn silent; zinit snippet PZT::modules/gpg
zinit ice svn silent pick"init.zsh" lucid; zinit snippet PZT::modules/utility
# }}}

# colors {{{
export BASE16_THEME='eighties'
zinit light 'chrissicool/zsh-256color'
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull"%atclone" pick"c.zsh"; zinit light trapd00r/LS_COLORS
zinit ice pick"scripts/base16-${BASE16_THEME}.sh"; zinit light chriskempson/base16-shell
zinit ice lucid wait'0' src"bash/base16-${BASE16_THEME}.config" pick"bash/base16-${BASE16_THEME}.config" nocompile'!'; zinit light nicodebo/base16-fzf
# }}}

# misc plugins {{{
zinit ice pick"bd.zsh"; zinit light Tarrasch/zsh-bd
zinit light djui/alias-tips
zinit ice as"program" pick"tmux-cssh"; zinit light peikk0/tmux-cssh
# }}}

# prompt
eval "$(starship init zsh)"

# tmux {{
zstyle ':prezto:module:tmux:session' name '0'
zstyle ':prezto:module:tmux:auto-start' local 'yes'
zinit ice svn; zinit snippet PZT::modules/tmux
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

# python {{{
export ZSH_PYENV_LAZY_VIRTUALENV=true
zinit light davidparsson/zsh-pyenv-lazy
# }}}

# source secret env keys, etc.
source $HOME/.zsh-secrets

# aliases {{{
alias c="cd"
alias c-="c -"
alias cd..="cd .."

alias tailf="tail -f"
alias lnav="lnav -q"

alias ag="ag --smart-case --follow --group"
alias agl="ag --pager less"

alias js="node"
alias tree="tree -C"
alias vi="vim"
alias viupdate="vi '+PlugUpgrade' '+PlugUpdate!' '+qall!'"

# tcpdump all requests made by given process
alias sysdig="sudo sysdig"
alias csysdig="sudo csysdig"
httpdump() { sysdig -s 2000 -A -c echo_fds proc.name=$1; }
# }}}

# git {{{
zinit light paulirish/git-open

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
alias docker='jq -s "reduce .[] as \$x ({}; . * \$x)" $HOME/.docker/config.d/*.json > ~/.docker/config.json && docker'
alias dr="docker run --rm -it"
alias di="docker images | head -n 1 && docker images | tail -n +2 | sort"
alias dps="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"
alias drmcd='drm $(dps -q -f status=exited -f status=created)'
alias drmvd='docker volume rm $(docker volume ls -q -f dangling=true)'
alias drmid='drmi $(docker images -q -f dangling=true)'
# alias drmid="docker images -q -f dangling=true | tr '\n' ' ' | xargs docker rmi -f && \
#     docker images | grep \"^<none>\" | awk \"{print $3}\" | tr '\n' ' ' | tr '\n' ' ' | xargs docker rmi -f"
alias dpurge="drmcd ; drmvd ; drmid ;docker network prune -f"
alias dc="docker-compose"
# }}}

# stow {{{
alias stowusr="sudo stow -vR -t /usr usr"
alias stowetc="sudo stow -vR -t /etc etc"
alias stowopt="sudo stow -vR -t /opt opt"
# }}}}

# JSON, YAML {{{
yaml2json() { python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' }
json2yaml() { python -c 'import sys, yaml, json; yaml.dump(json.load(sys.stdin), sys.stdout, indent=4)' }
# }}}


# vim:foldlevel=0
# vim:foldmethod=marker
