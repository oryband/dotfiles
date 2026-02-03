# credits https://pastebin.com/Tgji4PZv

# path {{{
export PATH="$HOME/.local/bin:$PATH"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# }}}

# zinit {{{
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Note: ZINIT[NEW_AUTOLOAD] modes and their issues:
#   =2: Tries to autoload from plugin dir, breaks system functions (compaudit error)
#   =1: Uses autoload -X wrapper, breaks comptags (fixed in completion init below)
#   =0: Uses reload-and-run wrapper, also breaks comptags
# We use default (=1) and fix comptags issue in "completion initialization" section.

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# }}}

# prezto modules {{{
# Clone prezto repo once, then load individual modules from it
# Note: GitHub discontinued SVN support (Jan 2024), so `zinit ice svn`
# no longer works. We clone the full repo and source modules directly.

# Ensure zsh system functions (url-quote-magic, compaudit, etc.) are in fpath
[[ -d /usr/share/zsh/${ZSH_VERSION}/functions ]] && fpath=(/usr/share/zsh/${ZSH_VERSION}/functions $fpath)

zinit ice lucid nocompile
zinit light sorin-ionescu/prezto

# Set ZPREZTODIR for modules that need it
ZPREZTODIR="${ZINIT[PLUGINS_DIR]}/sorin-ionescu---prezto"

# Prezto configuration
zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':prezto:*:*' color 'yes'

# Helper function to load prezto modules with proper fpath handling
_load_pmodule() {
  local pmodule="$1"
  local pmodule_dir="${ZPREZTODIR}/modules/${pmodule}"
  [[ -d "${pmodule_dir}/functions" ]] && fpath=("${pmodule_dir}/functions" $fpath)
  [[ -s "${pmodule_dir}/init.zsh" ]] && source "${pmodule_dir}/init.zsh"
}

# Load modules (order matters)
_load_pmodule helper      # Helper functions used by other modules
_load_pmodule environment # General shell options, Smart URLs (url-quote-magic)

# Only load interactive modules outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  _load_pmodule terminal    # Terminal window/tab titles

  # Editor - sets key bindings
  zstyle ':prezto:module:editor' key-bindings 'vi'
  zstyle ':prezto:module:editor' dot-expansion 'yes'
  _load_pmodule editor

  _load_pmodule history     # History options and aliases
  _load_pmodule directory   # Directory navigation options and aliases (autopushd, cd stack)
  _load_pmodule spectrum    # 256 colors support
  _load_pmodule utility     # PROBLEMATIC: adds -i flags to cp/mv/rm that block on confirmation
  _load_pmodule git         # Git aliases (g, gc, gco, etc.)
  _load_pmodule completion  # Completion styles and menu-select widget

  # Tmux
  zstyle ':prezto:module:tmux:session' name '0'
  _load_pmodule tmux
fi

unfunction _load_pmodule
# }}}

# basic zsh options {{{
setopt NOCLOBBER  # Prevent accidental file overwrites with > (use >| to override)
# }}}

# colors {{{
# Only load visual themes outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  export DRACULA_DISPLAY_GIT=0
  zinit ice pick"lib/async.zsh" src"dracula.zsh-theme"; zinit light dracula/zsh
fi

# FZF color settings (keep for potential FZF usage)
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
# Enable fzf-tmux integration (opens in tmux split pane when inside tmux)
export FZF_TMUX=1
# }}}

# misc plugins {{{
zinit ice pick"bd.zsh"; zinit light Tarrasch/zsh-bd

# Only load alias-tips outside of Claude Code (interactive feature)
if [[ -z "$CLAUDECODE" ]]; then
  zinit light djui/alias-tips
fi
# }}}

# prompt {{{
# Only load starship prompt outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  eval "$(starship init zsh)"
fi
# }}}

# tmux {{{
# TPM (Tmux Plugin Manager) - only load outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  zinit ice lucid wait'!0a' as'null' id-as'tpm' atclone'mkdir -p $HOME/.tmux/plugins; ln -sf $ZINIT[PLUGINS_DIR]/tpm $HOME/.tmux/plugins/tpm' ; zinit light tmux-plugins/tpm
fi
# }}}

# completion {{{
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
# Only load autosuggestions outside of Claude Code (interactive feature)
if [[ -z "$CLAUDECODE" ]]; then
  zinit ice wait atload"_zsh_autosuggest_start" lucid; zinit light zsh-users/zsh-autosuggestions
fi
# }}}

# history plugins {{{
# Only load interactive history plugins outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  zinit ice wait"1" silent pick"zsh-history-substring-search.plugin.zsh" lucid; zinit light zsh-users/zsh-history-substring-search
  zinit ice wait"1" silent pick"history-search-multi-word.plugin.zsh" lucid; zinit light zdharma-continuum/history-search-multi-word
  zstyle ":plugin:history-search-multi-word" active "standout"
fi
# }}}

# completion style {{{
# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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

# shell dev env {{{
# direnv and lnav installed via Homebrew
eval "$(direnv hook zsh)"
# }}}

# macOS Homebrew {{{
# Homebrew shellenv loaded in .zprofile (removed duplicate)

# Homebrew completions - ISSUE: zinit creinstall is broken (bad set of key/value pairs error)
# Workaround to update after brew upgrades packages:
#   cd ~/.local/share/zinit/completions
#   for comp in /opt/homebrew/share/zsh/site-functions/_*; do [[ -f "$comp" ]] && ln -sf "$comp" .; done
# }}}

# clojure {{{
zinit ice from"gh-r" as"program" pick"bb"; zinit light babashka/babashka
zinit ice from"gh-r" as"program" bpick"zprintl-*" mv"zprintl-* -> zprint"; zinit light kkinnear/zprint
# }}}

# python {{{
# zinit ice as'command' atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh && git clone https://github.com/pyenv/pyenv-virtualenv ./plugins/pyenv-virtualenv' atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" pick'bin/pyenv' src"zpyenv.zsh" nocompile'!' ; zinit light pyenv/pyenv
# export PATH="$HOME/.local/bin:$PATH"
# export ZSH_PYENV_LAZY_VIRTUALENV="true"
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# zinit ice pick="pyenv-lazy.plugin.zsh" ; zinit light davidparsson/zsh-pyenv-lazy
# 
# pyenv + pyenv-virtualenv - lazy loaded via zsh-pyenv-lazy {{{
# Installed via Homebrew, lazy loaded via zinit plugin
export PYENV_ROOT="$HOME/.pyenv"
export ZSH_PYENV_LAZY_VIRTUALENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
zinit ice pick="pyenv-lazy.plugin.zsh" ; zinit light davidparsson/zsh-pyenv-lazy
# Use .python-version files in project directories for version management
# }}}
# }}}

# jq {{{
export JQ_COLORS='0;31:0;39:0;39:0;39:0;32:1;39:1;39'
# yq installed via Homebrew
# }}}

# aliases {{{
# Only load interactive-focused aliases outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  alias c="z"
  alias c-="c -"
  alias cd..="c .."
  alias cc="__zoxide_zi"

  alias cat="bat"
  alias ls="lsd --group-dirs first"
  alias grep="rg"
  alias ag="rg"
  alias tree="lsd --tree"
  alias vi="nvim"
fi

alias tailf="tail -f"

# tcpdump all requests made by given process
alias sysdig="sudo sysdig"
alias csysdig="sudo csysdig"
httpdump() { sysdig -s 2000 -A -c echo_fds proc.name=$1; }
# }}}

# git {{{
# gh and lazygit installed via Homebrew
zinit light paulirish/git-open

# scm_breeze {{{
# Detect if running in Claude Code context
# Only load SCM Breeze in interactive shells
if [[ -z "$CLAUDECODE" ]]; then
  SCM_BREEZE_DISABLE_ASSETS_MANAGEMENT="true"
  zinit ice atclone"$ZINIT[PLUGINS_DIR]/scmbreeze---scm_breeze/install.sh" atpull"%atclone" pick"scm_breeze.sh"; zinit light scmbreeze/scm_breeze
fi
# }}}

# aliases {{{
# These git aliases depend on scm_breeze, only load outside Claude Code
if [[ -z "$CLAUDECODE" ]]; then
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
fi
# }}}
# }}}

# vim {{{
# tree-sitter installed via Homebrew
# }}}

# docker {{{
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# k9s installed via Homebrew
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
alias dc="docker compose"
# }}}

# kubectl {{{
# Load kubectl completions via OMZ plugin
if command -v kubectl &>/dev/null; then
  zinit snippet OMZP::kubectl
fi
# }}}

# gcloud {{{
# PATH - load immediately (needed for gcloud command)
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/.local/google-cloud-sdk/path.zsh.inc"
fi

# Completions - lazy load with turbo mode
zinit ice lucid wait'0b' blockf
zinit snippet "$HOME/.local/google-cloud-sdk/completion.zsh.inc"
# }}}

# nvm - lazy loaded via zsh-nvm {{{
# Uses zsh-nvm plugin with NVM_LAZY_LOAD for ~70x faster shell startup
# NVM will auto-load on first use of: nvm, node, npm, npx, yarn, or global npm packages
export NVM_DIR="$HOME/.nvm"
export NVM_AUTO_USE=true  # Auto-switch node versions based on .nvmrc
export NVM_COMPLETION=true

# Lazy load only in interactive shells, not in Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  export NVM_LAZY_LOAD=true
  export NVM_LAZY_LOAD_EXTRA_COMMANDS=('yarn')
else
  export NVM_LAZY_LOAD=false
fi

zinit light lukechilds/zsh-nvm

# Add yarn global bin after NVM is available (runs on first node/npm/yarn use)
if command -v yarn &>/dev/null; then
  export PATH="$(yarn global bin):$PATH"
fi
# }}}

# syntax highlighting {{{
# NOTE must be last plugin to load - only load outside of Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  zinit ice lucid
  zinit light zsh-users/zsh-syntax-highlighting
fi
# }}}

# completion initialization {{{
# PROBLEM: Zinit wraps autoload calls during plugin loading, creating functions like:
#   _tags() { local -a fpath; fpath=(...); builtin autoload -X }
# This extra fpath wrapper changes the function call stack depth, breaking comptags
# which uses stack depth to track completion tags. Results in errors like:
#   _tags:comptags:67: no tags registered
#
# SOLUTION: Before compinit, remove any completion functions that have zinit's
# wrapper pattern. Then compinit properly defines them as standard autoload stubs.
#
# PERFORMANCE: The loop is fast (just pattern matching). Compinit uses -C flag
# to skip full fpath scan when zcompdump cache is fresh (< 20h old).
#
# See: https://www.zsh.org/mla/users/2016/msg00833.html
() {
  # Remove zinit's autoload wrapper if present
  (( ${+functions[autoload]} )) && unfunction autoload 2>/dev/null

  # Only remove functions with zinit's specific wrapper pattern (has fpath manipulation)
  # This is more targeted than matching all 'autoload -X' which would also match
  # zsh's standard stubs
  local func
  for func in ${(k)functions[(I)_*]}; do
    [[ "${functions[$func]}" == *"local -a fpath"*"autoload -X"* ]] && unfunction "$func" 2>/dev/null
  done

  builtin autoload -Uz compinit
  # Use -C (skip audit) only if zcompdump was recently modified
  local -a compinit_opts=()
  [[ -f ~/.zcompdump && ~/.zcompdump(#qNmh-20) ]] && compinit_opts=(-C)
  compinit "${compinit_opts[@]}" -d "${ZINIT[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}"
}
zinit cdreplay -q
# }}}

# fzf {{{
# fzf must be loaded AFTER compinit for completion to work
# Only load interactive key-bindings outside Claude Code
if [[ -z "$CLAUDECODE" ]]; then
  if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
  elif type brew &>/dev/null; then
    # Load Homebrew fzf integration
    [[ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
    [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]] && source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  fi

  # Ensure Tab is bound to fzf-completion (in case something overrode it)
  if typeset -f fzf-completion &>/dev/null; then
    bindkey '^I' fzf-completion
  fi
fi
# }}}

# claude {{{
export ANTHROPIC_MODEL='claude-opus-4-5'
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1
# }}}


# must be called after compinit
eval "$(zoxide init zsh)"

[ -f ~/.zsh-secrets ] && source ~/.zsh-secrets

# vim:foldlevel=0
# vim:foldmethod=marker
