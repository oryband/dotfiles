# credits go to:
# https://github.com/halfo/lambda-mod-zsh-theme/
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme

# show path relative to git root
# or home dir if not git
get_pwd() {
    git_root=$PWD

    while [[ $git_root != / && ! -e $git_root/.git ]]; do git_root=$git_root:h; done

    if [[ $git_root = / ]]; then unset git_root; prompt_short_dir=%~;
    else parent=${git_root%\/*}; prompt_short_dir=${PWD#$parent/}; fi

    echo $prompt_short_dir
}

# show virtualenv if activated
prompt_virtualenv() {
    [[ -n $VIRTUAL_ENV && -n $VIRTUAL_ENV_DISABLE_PROMPT ]] && echo "%{$fg_bold[white]%}($(basename $VIRTUAL_ENV)) "
}

# color prompt green if last exit code was zero, red otherwise
local STATUS_CODE="%(?,%{$fg_bold[green]%}●,%{$fg_bold[red]%}●)"

PROMPT="%{$fg_bold[magenta]%}\$(get_pwd)%{$reset_color%} \$(git-radar --zsh --fetch)\$(prompt_virtualenv)${STATUS_CODE} %{$fg_bold[magenta]%}λ%{$reset_color%} "
