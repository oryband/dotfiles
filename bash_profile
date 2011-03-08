alias vi=/Applications/MacVim.app/Contents/MacOS/Vim  # Override pre-installed Vim and use MacVim instead (Newer version).
alias vim=/Applications/MacVim.app/Contents/MacOS/Vim

alias todo=/usr/local/bin/todo.sh  # todo.txt app

alias ll='ls -l'
alias la='ls -Al'  # show hidden files, -l-style.


# Setting PATH for MacPython 2.6
# The orginal version is saved in .bash_profile.pysave
PATH="/usr/local/bin:/usr/local/sbin:/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
export PATH


# Personal custom Python module directory
#PYTHONPATH="/Users/ory/Documents/Python:${PYTHONPATH}"
PYTHONPATH="/Library/Python/2.6/site-packages:${PYTHONPATH}"
export PYTHONPATH


# MacPorts Installer addition on 2011-01-12_at_01:56:09: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

