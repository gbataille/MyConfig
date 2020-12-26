# https://stackoverflow.com/questions/20357441/zsh-on-10-9-widgets-can-only-be-called-when-zle-is-active
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

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
plugins=(autojump nix-shell zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

set -o vi

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-solarized-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export EDITOR="vi"
export CC=clang
export TZ=Europe/Paris
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export WORKON_HOME=$HOME/.virtualenvs
export PATH=/Users/gbataille/Documents/Prog/MyConfig/scripts:/usr/local/opt/postgresql@10/bin:$PATH:/Users/gbataille/.cabal/bin:/Users/gbataille/Documents/Prog/RetinAI/scripts
export AWS_ASSUME_ROLE_TTL=4h
export AWS_CHAINED_SESSION_TOKEN_TTL=1h
export AWS_FEDERATION_TOKEN_TTL=4h
export AWS_SESSION_TOKEN_TTL=4h
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export CPPFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
export ZSH_HIGHLIGHT_MAXLENGTH=60     # For perf on text paste
export GITHUD_DEBUG=TRUE
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export SHELL_USER=gbataille

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
alias sshadd='ssh-add ~/.ssh/id_rsa'
alias pms='ave pix4d -- python manage.py shell_plus'
alias pmr='ave pix4d -- python manage.py runserver 0.0.0.0:8000'
alias pcspms='ave pcs_staging_admin -- python manage.py shell_plus'
alias pcspmr='ave pcs_staging_admin -- python manage.py runserver 0.0.0.0:8888'
alias rgall='rg --hidden --no-ignore'
cat()
{
  bat $@
}
unalias ll
ll()
{
  exa -la --git -F $@
}
alias l='ll'
tree()
{
  exa -la --git -F -T $@
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

generate_random_alpha()
{
  if [ -z "$1" ]; then; echo "Please pass a length as parameter"; return; fi
  LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c $1 | pbcopy
}

generate_random()
{
  if [ -z "$1" ]; then; echo "Please pass a length as parameter"; return; fi
  LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $1 | pbcopy
}

## Node
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


## Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## Python
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Init SSH keys
init_ssh_keys.sh
# Setup local DNS
setup_host_file.sh

# Retinai VPN
alias vpn_up='sudo wg-quick up utun0'
alias vpn_down='sudo wg-quick down utun0'

# Retinai projects
alias yz='yarn --cwd server workspace "@sphere/zenith"'
alias yc='yarn --cwd server workspace "@sphere/core"'
alias yt='yarn --cwd server workspace "@sphere/test-utils"'
alias yd='yarn --cwd discovery'
ave()
{
  aws-vault exec -t `ykman oath code | grep "gregory.bataille@retinai" | awk '{print $NF}'` $@
}
avl()
{
  aws-vault login -d 1h -t `ykman oath code | grep "gregory.bataille@retinai" | awk '{print $NF}'` $@
}
avez()
{
  ave $1 -- yarn --cwd server workspace @sphere/zenith "${@:2}"
}
avec()
{
  ave $1 -- yarn --cwd server workspace @sphere/core "${@:2}"
}

get_db_password()
{
  ave $1 -- aws secretsmanager get-secret-value --secret-id backend_appserver/db_retinai_admin | jq -r '.SecretString' | pbcopy
}

get_rabbit_password()
{
  ave $1 -- aws secretsmanager get-secret-value --secret-id backend_appserver/rabbitmq | jq -r '.SecretString' | pbcopy
}

. /Users/gbataille/.nix-profile/etc/profile.d/nix.sh

int_dump()
{
  pg_dump -h main-db.cluster-ci9m4d8dhtnf.eu-central-1.rds.amazonaws.com -U retinai_admin -d sphere --format=c -f /var/local/retinai/dumps/`date +"%Y%m%d"`_int_db.dump
}

int_run()
{
  docker run --rm -p 35432:5432 -e POSTGRES_USER=retinai_admin -e POSTGRES_PASSWORD=test -e POSTGRES_DB=sphere -v /private/var/local/retinai/int_run:/var/lib/postgresql/data postgres:11-alpine
}

int_load()
{
  pg_restore -h localhost -p 35432 -U retinai_admin -d sphere /var/local/retinai/dumps/`ls -l /var/local/retinai/dumps/ | tail -1 | awk '{print $9}'`
}

eval "$(direnv hook zsh)"
