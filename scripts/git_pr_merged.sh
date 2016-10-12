#!/bin/bash
set -x
git push origin HEAD:staging
git co staging
git pull
set +x
