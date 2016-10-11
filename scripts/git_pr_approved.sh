#!/bin/bash
set -x
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
git fetch
git checkout $CURRENT_BRANCH
git rebase origin/staging
git push -f
git checkout origin/staging
git merge $CURRENT_BRANCH --no-edit
set +x

echo '################################################'
echo 'You still need to "git push origin HEAD:staging"'
echo '################################################'
