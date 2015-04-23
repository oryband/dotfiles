export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR

# chrome/ium
[[ -f /etc/arch-release ]] && export CHROMIUM_USER_FLAGS="--touch-devices=123 --audio-buffer-size=2048"
