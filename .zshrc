# credits https://pastebin.com/Tgji4PZv

# zinit {{{
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
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
zinit ice pick"zsh/dracula.zsh-theme"; zinit light dracula/zsh
zinit ice lucid as"null" id-as"dracula-alacritty" ; zinit light dracula/alacritty
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
# }}}

# misc plugins {{{
zinit ice from"gh-r" as"program" bpick"*x86_64-unknown-linux-gnu*" pick"fd-*/fd"; zinit light sharkdp/fd
zinit ice pick"bd.zsh"; zinit light Tarrasch/zsh-bd
zinit light djui/alias-tips
zinit ice from"gh-r" as"program" bpick"*x86_64-unknown-linux-gnu*" pick"lsd-*/lsd"; zinit light Peltoche/lsd
zinit ice from"gh-r" as"program" pick"diff-so-fancy"; zinit light so-fancy/diff-so-fancy
zinit ice from"gh-r" as"program" bpick"*Linux_64bit_Portable*" mv"GalaxyBudsClient* -> GalaxyBudsClient"; zinit light ThePBone/GalaxyBudsClient
# }}}

# prompt {{{
zinit ice from"gh-r" as"program" bpick"*x86_64-unknown-linux-gnu*" pick"starship"; zinit light starship/starship
eval "$(starship init zsh)"
# }}}

# tmux {{{
zstyle ':prezto:module:tmux:session' name '0'
# [[ -n $DISPLAY ]] && zstyle ':prezto:module:tmux:auto-start' local 'yes'
zinit ice svn; zinit snippet PZT::modules/tmux
zinit ice lucid wait'!0a' as'null' id-as'tpm' atclone'mkdir -p $HOME/.tmux/plugins; ln -sf $ZINIT[PLUGINS_DIR]/tpm $HOME/.tmux/plugins/tpm' ; zinit light tmux-plugins/tpm
# }}}

# fzf / zoxide {{{
zinit ice as"program" pick="bin/(fzf|fzf-tmux)" atclone="\cp -f shell/completion.zsh _fzf_completion" atpull"%atclone" make="install"; zinit light junegunn/fzf
zinit ice from"gh-r" as"program" bpick"*x86_64-unknown-linux*.tar.gz"; zinit light ajeetdsouza/zoxide
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
zinit ice wait"1" silent pick"history-search-multi-word.plugin.zsh" lucid; zinit light zdharma-continuum/history-search-multi-word
zstyle ":plugin:history-search-multi-word" active "standout"
# }}}

# load everything {{{
autoload -Uz compinit
compinit
zinit cdreplay -q
# }}}

# must be called after compinit
eval "$(zoxide init zsh)"

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

# shell dev env {{{
zinit from"gh-r" as"program" mv"direnv* -> direnv" atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv" src="zhook.zsh" for direnv/direnv
# }}}

# java {{{
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export PATH="$JAVA_HOME/bin:$PATH"
# }}}

# clojure {{{
zinit ice from"gh-r" as"program" pick"bb"; zinit light babashka/babashka
zinit ice from"gh-r" as"program" bpick"zprintl-*" mv"zprintl-* -> zprint"; zinit light kkinnear/zprint
# }}}

# python {{{
export PATH="$HOME/.local/bin:$PATH"
export ZSH_PYENV_LAZY_VIRTUALENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
zinit light davidparsson/zsh-pyenv-lazy
# }}}

# javascript {{{
export PATH="$(yarn global bin):$PATH"
# }}}

# jq {{{
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'
zinit ice from"gh-r" as"program" mv"yq_* -> yq" ; zinit light mikefarah/yq
# }}}

# source secret env keys, etc.
source $HOME/.zsh-secrets

# aliases {{{
alias c="zi"
alias c-="zi -"
alias cd..="zi .."

alias cat="batcat"

alias ls="lsd --group-dirs first"

alias tailf="tail -f"

alias grep="rg"
alias ag="rg"

alias js="node"
alias tree="lsd --tree"
alias vi="nvim"
alias viupdate="vi '+PackerSync' '+qall!'"

# tcpdump all requests made by given process
alias sysdig="sudo sysdig"
alias csysdig="sudo csysdig"
httpdump() { sysdig -s 2000 -A -c echo_fds proc.name=$1; }
# }}}

# git {{{
zinit ice from"gh-r" as"program" pick"gh_*/bin/gh" bpick"*linux_amd64*" ; zinit light cli/cli
zinit light paulirish/git-open
zinit ice as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"; zinit light tj/git-extras
zinit ice from"gh-r" as"program"; zinit light jesseduffield/lazygit

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

# vim {{{
zinit ice from"gh-r" as"program" mv"tree-sitter* -> tree-sitter" ; zinit light tree-sitter/tree-sitter
# }}}

# docker {{{
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
zinit ice from"gh-r" as"program" bpick"*Linux_x86_64*"; zinit light derailed/k9s
zinit ice id-as"k9s-theme" cloneonly depth"1" atclone'mkdir -p $HOME/.config/k9s; ln -sf $ZINIT[PLUGINS_DIR]/k9s-theme/skins/dracula.yml $HOME/.config/k9s/skin.yml' atpull"%atclone"; zinit load derailed/k9s
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

# syntax highlighting {{{
# NOTE must be last plugin to load
zinit ice pick"zsh-syntax-highlighting.sh" lucid ; zinit light dracula/zsh-syntax-highlighting
# https://github.com/dracula/zsh-syntax-highlighting/issues/7
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
zinit ice wait lucid atinit"zpcompinit; zpcdreplay"; zinit light zsh-users/zsh-syntax-highlighting
# }}}

# vim:foldlevel=0
# vim:foldmethod=marker
