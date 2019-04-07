# credits https://pastebin.com/Tgji4PZv

# zplugin
source '/home/ory/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# prezto
zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:load' pmodule \
zplugin snippet PZT::modules/helper/init.zsh

# prompt
zplugin ice pick"scripts/base16-eighties.sh"; zplugin light chriskempson/base16-shell
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
PURE_PROMPT_SYMBOL='#'
PURE_PROMPT_VICMD_SYMBOL=''
PURE_GIT_DOWN_ARROW='↓'
PURE_GIT_UP_ARROW='↑'

# git scm_breeze
zplugin ice atpull"$ZPLGM[PLUGINS_DIR]/scmbreeze---scm_breeze/install.sh" pick"/home/ory/.scm_breeze/scm_breeze.sh"; zplugin light scmbreeze/scm_breeze 

# misc plugins
zplugin ice svn; zplugin snippet PZT::modules/environment
zplugin ice svn; zplugin snippet PZT::modules/terminal
zplugin ice svn; zplugin snippet PZT::modules/editor
zplugin ice svn silent; zplugin snippet PZT::modules/gpg
# zplugin ice svn load"[[ -z "$TMUX" ]]" silent pick"init.zsh" lucid;
zplugin ice svn snippet PZT::modules/tmux
zplugin ice svn silent pick"init.zsh" lucid; zplugin snippet PZT::modules/utility
zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull"%atclone" pick"c.zsh"; zplugin light trapd00r/LS_COLORS
zplugin ice pick"bd.zsh"; zplugin light Tarrasch/zsh-bd
zplugin light djui/alias-tips
zplugin light paulirish/git-open

# enhancd / fzy
export ENHANCD_FILTER=fzy
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HYPHEN=1
export ENHANCD_DISABLE_HOME=1
zplugin ice pick"init.sh"; zplugin light b4b4r07/enhancd

# completion
zplugin ice svn wait"0" silent pick"init.zsh" blockf; zplugin snippet PZT::modules/completion
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

# suggestions
zplugin ice wait"0" atload"_zsh_autosuggest_start" lucid; zplugin light zsh-users/zsh-autosuggestions

# history
zplugin ice svn; zplugin snippet PZT::modules/history
zplugin ice wait"1" silent pick"zsh-history-substring-search.plugin.zsh" lucid; zplugin light zsh-users/zsh-history-substring-search
zplugin ice wait"1" silent pick"history-search-multi-word.plugin.zsh" lucid; zplugin light zdharma/history-search-multi-word
zstyle ":plugin:history-search-multi-word" active "standout"

# syntax highlighting, NOTE must be last plugin to load
zplugin ice wait"0" atinit"zpcompinit; zpcdreplay"; zplugin light zdharma/fast-syntax-highlighting

# load everything
autoload -Uz compinit
compinit
zplugin cdreplay -q

# disable C-s stopping receiving keyboard signals.
stty start undef
stty stop undef

# vi mode
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

# terminal
setopt PROMPT_SUBST
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# python
export PATH=$HOME/.local/bin:$PATH

# js
export PATH=$HOME/.node_modules/bin:$PATH

# ruby
export PATH=$(ruby -e 'print Gem.user_dir')/bin:$PATH

# golang
GO_VERSION=go1.12
export GOROOT=$HOME/Documents/golang/$GO_VERSION
export GOPATH=$HOME/.golang/$GO_VERSION
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
alias $GO_VERSION=$GOROOT/bin/go
alias go=$GO_VERSION

# source secret env keys, etc.
source $HOME/.zsh-secrets

# aliases
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

# git aliases
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

# docker
alias docker='jq -s "reduce .[] as \$x ({}; . * \$x)" $HOME/.docker/config.d/*.json > ~/.docker/config.json && docker'
alias dr="sudo docker run --rm -it"
alias di="sudo docker images | head -n 1 && sudo docker images | tail -n +2 | sort"
alias dps="sudo docker ps -a"
alias drm="sudo docker rm"
alias drmi="sudo docker rmi"
alias drmcd='drm $(dps -q -f status=exited -f status=created)'
alias drmvd='sudo docker volume rm $(sudo docker volume ls -q -f dangling=true)'
alias drmid='drmi $(sudo docker images -q -f dangling=true)'
# alias drmid="docker images -q -f dangling=true | tr '\n' ' ' | xargs docker rmi -f && \
#     docker images | grep \"^<none>\" | awk \"{print $3}\" | tr '\n' ' ' | tr '\n' ' ' | xargs docker rmi -f"
alias dpurge="drmcd ; drmvd ; drmid ;sudo docker network prune -f"
alias dc="sudo docker-compose"

alias vg=vagrant
alias graph="graph-easy --from dot --as boxart --stats"
# alias tmux="tmux attach -t ory"

# stow
alias stowusr="sudo stow -vR -t /usr usr"
alias stowetc="sudo stow -vR -t /etc etc"
alias stowopt="sudo stow -vR -t /opt opt"

# yaml2json
yaml2json() { python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' }
json2yaml() { python -c 'import sys, yaml, json; yaml.dump(json.load(sys.stdin), sys.stdout, indent=4)' }
