PS1="\w$ "  # Custom prompt text (full pwd).


export CLICOLOR=1  # Enable terminal colors
export LSCOLORS=Gxfxbxdxcxegedabagacad  # File-type color definition (e.g. files=grey, directories=bold cyan, etc.) -- Dark background.
#export LSCOLORS=ExFxCxDxBxegedabagacad  # Light background.


# STDERR Red.
# NOTE: Installing on OS X will break the `open` command line utility. So
# things like `mvim` and `open` itself will not work unless the application being
# opened is already opened. It's because of flat namespace forced by
# `DYLD_FORCE_FLAT_NAMESPACE` which is required by `DYLD_INSERT_LIBRARIES`.

# Alternative to enabling it globally via shell config is to create alias and
# use it to selectively colorize stderr for the commands you run:

# $ alias stderred='LD_PRELOAD=/absolute/path/to/lib/stderred.so'
# $ stderred java lol
#export DYLD_INSERT_LIBRARIES=$HOME/Documents/dotfiles/stderred/lib/stderred.dylib DYLD_FORCE_FLAT_NAMESPACE=1
#export DYLD_INSERT_LIBRARIES=""$HOME/Documents/dotfiles/stderred/lib/stderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"

alias cls="clear"  # Windows command. :)
alias vi=/Applications/MacVim.app/Contents/MacOS/Vim  # Override pre-installed Vim and use Homebrew"s newer version MacVim instead.
alias vim="vi"
alias ll="ls -l"
alias la="ls -Al"  # show hidden files, with -l.
alias grep="grep --color=auto -I"  # Colorful, skipping binary files.
alias less="less -R"  # Colorful less.
alias ghci="ghci-color"


export LESS="FRSXQ"  # Colorful diffing in Mercurial.

export LESS_TERMCAP_mb=$'\E[01;31m'  # Colorful man pages.
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


PATH="/usr/local/bin:/usr/local/sbin:${PATH}"   # Give priority to Homebrew's bin & sbin dirs on top of the system's dirs.
PATH="/usr/local/share/python:${PATH}"          # Add Homebrew's Python to $PATH, before the system's Python.
PATH="/usr/local/Cellar/ruby/1.9.3-p194/bin:$PATH"  # Ruby
PATH="$HOME/.cabal/bin:$PATH"  # Haskell Packages.
#PATH="$HOME/.bin:$PATH"  # /bin overrides.
export PATH

#NODE_PATH="/usr/local/lib/jsctags:${NODE_PATH}"       # Add doctorjs to Node's library path.
NODE_PATH="/usr/local/lib/node_modules:${NODE_PATH}"  # Add Homebrew's node.js package dir to path.
export NODE_PATH

