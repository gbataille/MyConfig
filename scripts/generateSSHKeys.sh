#!/bin/ksh
set -x
ssh-keygen -t rsa -C "gbataille.dev@gmail.com" -f ~/.ssh/id_rsa
ssh-keygen -t rsa -C "gbataille@octo.com" -f ~/.ssh/id_rsa_octo
