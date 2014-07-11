#!/bin/sh

if [ -f ~/.profile ]; then
  source ~/.profile
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PS1="\[\033[0;37m\][\A]\[\033[0m\] \[\033[0;36m\]\u\[\033[0m\] \W\[\033[0;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\]\$ "
