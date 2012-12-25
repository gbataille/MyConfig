#!/bin/ksh
git co master
git merge master $1
git push
git co $1
