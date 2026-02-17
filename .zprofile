# credits github.com/sorin-ionescu/prezto

export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

if [[ -z "$LANG" ]]; then export LANG='en_US.UTF-8'; fi

# ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Homebrew - official recommendation for macOS + zsh
eval "$(/opt/homebrew/bin/brew shellenv)"

# set the less input preprocessor.
# try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"; fi

# temporary files
if [[ ! -d "$TMPDIR" ]]; then export TMPDIR="/tmp/$LOGNAME"; mkdir -p -m 700 "$TMPDIR"; fi
TMPPREFIX="${TMPDIR%/}/zsh"

# GPG TTY for signing
export GPG_TTY=$(tty)

# Non-interactive login shells (Claude Code, SSH commands, etc.) {{{
# .zshrc is only sourced for interactive shells, so PATH-affecting tools
# (nvm, pyenv) are set up here directly — no plugin manager needed.
if [[ ! -o interactive ]]; then
  export PATH="$HOME/.local/bin:$PATH"
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

  setopt NOCLOBBER NO_NOMATCH

  # nvm — resolve default version and add to PATH
  export NVM_DIR="$HOME/.nvm"
  if [[ -s "$NVM_DIR/alias/default" ]]; then
    local _nvm_ver="$(<"$NVM_DIR/alias/default")"
    while [[ "$_nvm_ver" != *'*'* && -s "$NVM_DIR/alias/$_nvm_ver" ]]; do
      _nvm_ver="$(<"$NVM_DIR/alias/$_nvm_ver")"
    done
    _nvm_ver="${_nvm_ver#v}"
    local _nvm_bin="$NVM_DIR/versions/node/v${_nvm_ver}/bin"
    if [[ ! -d "$_nvm_bin" ]]; then
      local -a _nvm_matches=("$NVM_DIR"/versions/node/v${_nvm_ver}*(NnOn/))
      (( ${#_nvm_matches} )) && _nvm_bin="${_nvm_matches[1]}/bin"
    fi
    [[ -d "$_nvm_bin" ]] && path=("$_nvm_bin" $path)
  fi

  # pyenv — add shims to PATH
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d "$PYENV_ROOT/shims" ]] && path=("$PYENV_ROOT/shims" "$PYENV_ROOT/bin" $path)

  [ -f ~/.zsh-secrets ] && source ~/.zsh-secrets
fi
# }}}
