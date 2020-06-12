#!/bin/sh
ip=`ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2`
sudo sed -i '' "s/.*local.retinai.com/${ip} local.retinai.com/" /etc/hosts
