# Huge credits go to https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile

PS1="\w$ "  # Custom prompt text (full pwd).

export CLICOLOR=1  # Enable terminal colors
#export LSCOLORS=Gxfxbxdxcxegedabagacad  # File-type color definition (e.g. files=grey, directories=bold cyan, etc.) -- Dark background.
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
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
alias vim="vi"

# Always use color output for `ls`
if ls --color > /dev/null 2>&1; then  # GNU `ls`
    colorflag="--color"
else  # OS X `ls`
    colorflag="-G"
fi
alias ls="command ls ${colorflag}"
alias ll="ls -l"
alias la="ls -a"  # show hidden files.
alias lla="ls -al"  # show hidden files, with -l.

alias grep="grep --color=auto -I"  # Colorful, skipping binary files.
alias less="less -R"  # Colorful less.
alias ghci="ghci-color"

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update'

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Prefer US English and use UTF-8
export lc_all="en_us.utf-8"
export lang="en_us"

export LESS="FRSXQ"  # Colorful diffing in Mercurial.

export LESS_TERMCAP_mb=$'\E[01;31m'  # Colorful man pages.
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export EDITOR="vim"
export VISUAL=$EDITOR


if [ `hostname -s` == "Ory" ]; then
    PATH="/usr/local/bin:/usr/local/sbin:$PATH"   # Give priority to Homebrew's bin & sbin dirs on top of the system's dirs.
    PATH="/usr/local/share/python:$PATH"          # Add Homebrew's Python to $PATH, before the system's Python.
    PATH="/usr/local/Cellar/ruby/1.9.3-p194/bin:$PATH"  # Ruby
    PATH="$HOME/.cabal/bin:$PATH"  # Haskell
    PATH="/usr/local/share/npm/bin:$PATH"  # Node/npm
    export PATH
fi
