#!/bin/ksh
# git co master
# git merge master $1
# git push
# git co $1
branch=$1

if [ -z "$branch" ]
then
  branch="wip"
fi
echo $branch
