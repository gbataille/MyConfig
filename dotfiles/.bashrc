#!/bin/sh

if [ -f ~/.profile ]; then
  source ~/.profile
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
