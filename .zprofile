# credits github.com/sorin-ionescu/prezto

export EDITOR='nvim'
export VISUAL=$EDITOR
export TERMINAL=alacritty
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

if [[ -z "$LANG" ]]; then export LANG='en_US.UTF-8'; fi

# ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# set the list of directories that zsh searches for programs.
path=(/usr/local/{bin,sbin} $path)

# set the default less options.
# mouse-wheel scrolling has been disabled by -x (disable screen clearing).
# remove -x and -f (exit if the content fits on one screen) to enable it.

# set the less input preprocessor.
# try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"; fi

# temporary files
if [[ ! -d "$TMPDIR" ]]; then export TMPDIR="/tmp/$LOGNAME"; mkdir -p -m 700 "$TMPDIR"; fi
TMPPREFIX="${TMPDIR%/}/zsh"
