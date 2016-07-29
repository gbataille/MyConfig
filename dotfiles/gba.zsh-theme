function virtualenv-prompt-display {
    [ $VIRTUAL_ENV ] && echo '[virtualenv: '`basename $VIRTUAL_ENV`'] '
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function shorter_path {
    echo `variable_lenght_path.py` 2>/dev/null
}

function docker-machine-prompt-display {
    [ $DOCKER_MACHINE_NAME ] && echo "[DOCKER-MACHINE: $DOCKER_MACHINE_NAME] "
}

function nvm-prompt-display {
  command -v nvm 2>/dev/null 1>&2 && echo '[nvm: '`nvm current`'] '
}

function rvm-prompt-display {
  command -v rvm 2>/dev/null 1>&2 && echo '[rvm: '`rvm current`'] '
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

PROMPT='
%{$fg[green]%}$(docker-machine-prompt-display)$(nvm-prompt-display)$(rvm-prompt-display)$(virtualenv-prompt-display)%{$reset_color%}
%{$reset_color%}$(/usr/local/bin/githud zsh)
%{$fg[cyan]%}%n%{$reset_color%} %{$fg_bold[green]%}$(shorter_path) %(?,,%{${fg_bold[blue]}%}[%?]%{$reset_color%} )$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local return_status="%{$fg[red]%}%(?..⤬)%{$reset_color%}"
RPROMPT='%{$fg_bold[white]%}%T%{$reset_color%} ${return_status}'

bindkey '^U' backward-kill-line
bindkey '^Y' yank

dm-set() {
  eval "$(docker-machine env $1)"
}

set -o vi
