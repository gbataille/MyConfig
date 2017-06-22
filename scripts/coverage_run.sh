#!/bin/sh
set -x
rm -rf htmlcov && coverage run --source "." manage.py test --keepdb $* && coverage html && open htmlcov/index.html
set +x
