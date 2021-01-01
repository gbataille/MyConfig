#!/bin/bash
export SHELL_USER=GuyInTheShell
tmux set pane-border-status off
tmux set -g status-left '#[fg=colour235,bg=colour252,bold] ❐ #S #[fg=colour252,bg=colour238,nobold] #[fg=colour245,bg=colour238,bold] GuyInTheShell #[fg=colour238,bg=black,nobold] '
tmux set -g status-right ''
PROMPT='
%{$fg[green]%}$(envstatus)
%{$fg[cyan]%}${SHELL_USER}%{$reset_color%} %(?,,%{${fg_bold[blue]}%}[%?]%{$reset_color%} )$ '
RPROMPT='${return_status}'
clear
