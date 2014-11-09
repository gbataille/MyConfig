#!/usr/local/bin/python3

# Used in the zsh prompt to give a not too long path
import os

MAX_LENGTH = 30
MAX_RIGHT_LENGTH = 18

path = os.getcwd()
userdir = os.environ['HOME']

if path.find(userdir) >= 0:
  path = path.replace(userdir, '~')

if len(path) > MAX_LENGTH:
  lpath = ""
  mpath = "…"
  rpath = ""

  while len(rpath) < MAX_RIGHT_LENGTH:
    lasti = path.rindex("/")
    lastdir = path[lasti:]
    path = path[:lasti]
    rpath = lastdir + rpath

  rpath = rpath[len(rpath) - MAX_RIGHT_LENGTH:]
  lpath = path[:MAX_LENGTH - len(rpath)]

  print(lpath + mpath + rpath)

else:
  print(path)
