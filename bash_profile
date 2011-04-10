export CLICOLOR=1  # Enable terminal colors
export LSCOLORS=Gxfxbxdxcxegedabagacad  # File-type color definition (e.g. files=grey, directories=bold cyan, etc.) -- Dark background.
#export LSCOLORS=ExFxCxDxBxegedabagacad  # Light background.


alias vi=~/Applications/MacVim.app/Contents/MacOS/Vim  # Override pre-installed Vim and use MacVim instead (Newer version).
alias vim='vi'

#alias todo=/usr/local/bin/todo.sh  # todo.txt app.

alias ll='ls -l'
alias la='ls -Al'  # show hidden files, with -l.

alias grep='grep --color=auto -Ii'  # Colorful, case-INsensitive, skipping binary files.

alias less='less -R'  # Colorful less.

export LESS='FRSXQ'  # For colorful diffing in Mercurial.

export LESS_TERMCAP_mb=$'\E[01;31m'  # Colorful man pages.
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# Add homebrew Python to $PATH.
PATH="/usr/local/share/python:${PATH}"
export PATH

