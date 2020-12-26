#!/bin/zsh
existing_key=`ssh-add -l | grep "gregory.bataille"`
if [ -z "$existing_key" ]; then
  echo -e "Main SSH key not loaded - doing it now\n"
  ssh-add ~/.ssh/id_rsa
fi
gits_key=`ssh-add -l | grep "guyintheshell"`
if [ -z "$gits_key" ]; then
  echo -e "GITS SSH key not loaded - doing it now\n"
  ssh-add ~/.ssh/id_gits
fi
