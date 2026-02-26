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

# nvm default node — available system-wide for non-interactive shells,
# IDE extensions, MCP servers, etc. nvm in .zshrc overrides per-project.
export NVM_DIR="$HOME/.nvm"
_nvm_v="$(cat "$NVM_DIR/alias/default" 2>/dev/null)"
while [[ -n "$_nvm_v" && -r "$NVM_DIR/alias/$_nvm_v" ]]; do _nvm_v="$(cat "$NVM_DIR/alias/$_nvm_v")"; done
[[ -n "$_nvm_v" ]] && export PATH="$NVM_DIR/versions/node/${_nvm_v}/bin:$PATH"
unset _nvm_v

# set the less input preprocessor.
# try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"; fi

# temporary files
if [[ ! -d "$TMPDIR" ]]; then export TMPDIR="/tmp/$LOGNAME"; mkdir -p -m 700 "$TMPDIR"; fi
TMPPREFIX="${TMPDIR%/}/zsh"

# GPG TTY for signing
export GPG_TTY=$(tty)
