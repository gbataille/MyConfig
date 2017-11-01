function parse_git_branch_and_add_brackets {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

export EDITOR=vim
export CC=clang
export TZ=Europe/Paris
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

set -o vi

export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

export NVM_DIR="/Users/gbataille/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

source $HOME/.rvm/scripts/rvm
rvm use default

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-solarized-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

alias ls='ls -Gh'
alias ll='ls -Glah'
alias l='ls -Glah'
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
alias pms='python manage.py shell_plus'
alias pmr='python manage.py runserver 0.0.0.0:8000'
alias pmt='python manage.py test'
alias pmtk='python manage.py test --keepdb'
alias droptestdb='dropdb test_pix4ddb'
alias mux='tmuxinator'
alias getproddb='scp ubuntu@django1:/opt/db-backup/pix4ddb_data.back ~/Downloads/pix4ddb_data.back;scp ubuntu@django1:/opt/db-backup/pix4ddb_struct.back ~/Downloads/pix4ddb_struct.back'
alias resettempdb='export PGPASSWORD="fly"; dropdb -U pix4d -h localhost --if-exists temppix4ddb; createdb -U pix4d -h localhost -T template0 -E "UTF-8" temppix4ddb; restoretempdb'
alias restoretempdb='pg_restore -U pix4d -h 127.0.0.1 -d temppix4ddb ~/Downloads/pix4ddb_struct.back;pg_restore -U pix4d -h 127.0.0.1 -d temppix4ddb ~/Downloads/pix4ddb_data.back'
alias switchdb='export PGPASSWORD="fly"; dropdb -U pix4d -h localhost --if-exists pix4ddb; psql -U gbataille -h localhost -c "CREATE DATABASE pix4ddb WITH TEMPLATE temppix4ddb OWNER pix4d;"'
alias pyclean='rm $(find . -name "*.pyc")'
alias origclean='rm $(find . -name "*.orig")'
alias mergeclean='rm $(find . -name "*BACKUP*");rm $(find . -name "*REMOTE*");rm $(find . -name "*LOCAL*");rm $(find . -name "*BASE*")'
alias branchclean='git branch --merged | grep -v "\*" | grep -v master | grep -v staging | xargs -n 1 git branch -d'
alias mergedremotebranch='git branch -r --merged | grep origin | grep -v ">" | grep -v master | grep -v staging | grep -v "rc-" | xargs -L1'
alias ansibledev='export EC2_INI_PATH=inventory_generator/ec2.ini'
alias ansiblestaging='export EC2_INI_PATH=inventory_generator/staging/ec2_staging.ini'
alias ansibleprod='export EC2_INI_PATH=inventory_generator/prod/ec2_prod.ini'
alias ansiblenone='export EC2_INI_PATH='

if [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
if [ -f /usr/local/bin/find ]; then
  alias find='/usr/local/bin/find'
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
