contains multiple configuration file for easy recover

### Vim
Vim would crash when invokin the ruby command (that YouCompleteMe
typically uses).
The problem seems to be that it is precompiled with the MAC packaged ruby. To
install vim, you therefore need to do
`rvm system; brew install vim; rvm default`

