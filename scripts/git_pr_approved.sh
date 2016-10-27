#!/bin/bash
set -x
set -e
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
git fetch
git rebase origin/staging
git push -f
git checkout origin/staging
git merge $CURRENT_BRANCH -m "Merging $CURRENT_BRANCH into staging with git_pr_approved"
set +x

echo '################################'
echo 'You still need to "git prmerged"'
echo '################################'
