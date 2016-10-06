#!/bin/sh

date=${1:-"1 month ago"}

if [[ `git rev-parse --abbrev-ref HEAD` != "master" ]]; then
  echo "This should only be executed from master"
  exit 1
fi

for branch in $(git branch -a --merged | sed 's/^\s*//' | sed 's/^ *remotes\///' | grep -v 'master$' | grep -v 'staging$'); do
  if [[ "$(git log $branch --since "$date" | wc -l)" -eq 0 ]]; then
    if [[ "$branch" =~ "origin/" ]]; then
      local_branch_name=$(echo "$branch" | sed 's/^origin\///')
      if [[ "$DRY_RUN" -eq 1 ]]; then
        echo "git push origin :$local_branch_name"
      else
        git push origin :$local_branch_name
        echo "Deleted $local_branch_name"
      fi
    else
      if [[ "$DRY_RUN" -eq 1 ]]; then
        echo "git branch -D $branch"
      else
        git branch -D $branch
        echo "Deleted $branch"
      fi
    fi
  fi
done

git remote prune origin
