# credits github.com/sorin-ionescu/prezto

# video decoding driver
[[ -f /etc/arch-release && `hostname` == 'optimus' ]] && export VDPAU_DRIVER=va_gl

# chrome/ium
[[ -f /etc/arch-release && `hostname` == 'fender' ]] && export CHROMIUM_USER_FLAGS="--audio-buffer-size=2048"

# ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then source "${ZDOTDIR:-$HOME}/.zprofile"; fi
