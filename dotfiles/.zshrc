# https://stackoverflow.com/questions/20357441/zsh-on-10-9-widgets-can-only-be-called-when-zle-is-active
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

export EDITOR="vim"
bindkey -v 

# vi style incremental search
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward 
bindkey '^R' fzf-history-widget

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gba"
# ZSH_THEME="agnoster"
# DEFAULT_USER="gbataille"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump gitfast tmuxinator zsh-syntax-highlighting nix-shell)
source $ZSH/oh-my-zsh.sh

set -o vi

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home"

if [ -e /Users/gbataille/.nix-profile/etc/profile.d/nix.sh ]; then
  . /Users/gbataille/.nix-profile/etc/profile.d/nix.sh;
fi

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-solarized-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export EDITOR=vim
export CC=clang
export TZ=Europe/Paris
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export WORKON_HOME=$HOME/.virtualenvs
export PATH=/Users/gbataille/Documents/Prog/MyConfig/scripts:/usr/local/opt/postgresql@10/bin:$PATH:/Users/gbataille/.cabal/bin
export AWS_ASSUME_ROLE_TTL=1h
export AWS_SESSION_TTL=8h
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export CPPFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

alias ls='ls -Gh'
alias cdm='cd ~/Documents/Prog/MyConfig'
alias cdp='cd ~/Documents/Prog/'
alias cdg='cd ~/Documents/Prog/GregsSandbox/'
alias c='clear'
alias ..='cd ..'
alias gitk='gitk --all'
alias ctest='cabal test --show-details=streaming'
alias npmr='npm run'
alias npmrs='npm run -s'
alias pm='python manage.py'
alias pmt='python manage.py test'
alias pmtk='LOG_LEVEL=WARNING python manage.py test -v 2 --no-buffer --keepdb'
alias droptestdb='dropdb test_pix4ddb'
alias pcsdroptestdb='dropdb test_pcs'
alias mux='tmuxinator'
alias pyclean='rm $(find . -name "*.pyc"); rm -r $(find . -name "__pycache__")'
alias origclean='rm $(find . -name "*.orig")'
alias mergeclean='rm $(find . -name "*BACKUP*");rm $(find . -name "*REMOTE*");rm $(find . -name "*LOCAL*");rm $(find . -name "*BASE*")'
alias branchclean='git branch --merged | grep -v "\*" | grep -v master | grep -v staging | xargs -n 1 git branch -d'
alias mergedremotebranch='git branch -r --merged | grep origin | grep -v ">" | grep -v master | grep -v staging | grep -v "rc-" | xargs -L1'
alias tf='terraform'
ave()
{
  aws-vault exec -m `ykman oath code | grep "gregory.bataille@pix4d.com@pix4d-users" | awk '{print $NF}'` $@
}
ave_admin()
{
  aws-vault exec -m `ykman oath code | grep "greg@pix4d" | awk '{print $NF}'` aws_account_management $@
}
avl()
{
  aws-vault login --no-session --assume-role-ttl=8h -t `ykman oath code | grep "gregory.bataille@pix4d.com@pix4d-users" | awk '{print $NF}'` $@
}
alias pms='ave pix4d --no-session --assume-role-ttl=12h -- python manage.py shell_plus'
alias pmr='ave pix4d --no-session --assume-role-ttl=12h -- python manage.py runserver 0.0.0.0:8000'
alias pcspms='ave pcs_staging_admin --no-session --assume-role-ttl=12h -- python manage.py shell_plus'
alias pcspmr='ave pcs_staging_admin --no-session --assume-role-ttl=12h -- python manage.py runserver 0.0.0.0:8888'
cat()
{
  bat $@ || (/bin/cat $@; echo -e "\x1b[31m\n-----\nWARN: bat not found, used cat\n-----\n\x1b[0m")
}
unalias ll
ll()
{
  exa -la --git -F $@ || (/bin/ls -la $@; echo -e "\x1b[31m\n-----\nWARN: exa not found, used ls\n-----\n\x1b[0m")
}
alias l='ll'
tree()
{
  exa -la --git -F -T $@ || (/usr/local/bin/tree $@; echo -e "\x1b[31m\n-----\nWARN: exa not found, used tree\n-----\n\x1b[0m")
}

if [ -f /usr/local/bin/nvim ]; then
  alias vi='/usr/local/bin/nvim'
elif [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
if [ -f /usr/local/bin/find ]; then
  alias find='/usr/local/bin/find'
fi
aws_get_account_id()
{
  ave $1 -- aws sts get-caller-identity --output text --query 'Account'
}
aws_get_canonical_account_id()
{
  ave $1 -- aws s3api list-buckets --query Owner.ID
}

# TOOLS
[[ -f `brew --prefix`/etc/bash_completion ]] && . `brew --prefix`/etc/bash_completion
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

## Node
export NVM_DIR="/Users/gbataille/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

## Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## Python
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
