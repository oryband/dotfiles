export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR

# chrome/ium
[[ -f /etc/arch-release ]] && export CHROMIUM_USER_FLAGS="--audio-buffer-size=2048"
