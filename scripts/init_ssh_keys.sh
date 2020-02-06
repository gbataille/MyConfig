#!/bin/zsh
existing_key=`ssh-add -l | grep "gregory.bataille"`
if [ -z "$existing_key" ]; then
  echo -e "SSH key not loaded - doing it now\n"
  ssh-add ~/.ssh/id_rsa
fi
