function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function shorter_path {
    echo `variable_lenght_path.py` 2>/dev/null
}

PROMPT='
%{$fg[cyan]%}%n%{$reset_color%} %{$fg_bold[green]%}$(shorter_path)%{$reset_color%} $(~/.local/bin/gitHUD zsh)%(?,,%{${fg_bold[blue]}%}[%?]%{$reset_color%} )$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local return_status="%{$fg[red]%}%(?..⤬)%{$reset_color%}"
RPROMPT='%{$fg_bold[white]%}%T%{$reset_color%} ${return_status}'

bindkey '^U' backward-kill-line
bindkey '^Y' yank
