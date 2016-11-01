#!/bin/bash
set -x
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
git push origin HEAD:staging
git co staging
git pull
set +x
