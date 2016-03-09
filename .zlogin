# credits github.com/sorin-ionescu/prezto

# execute code that does not affect the current session in the background.
{
    # compile the completion dump to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then zcompile "$zcompdump"; fi
} &!

# have screen will start x
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
