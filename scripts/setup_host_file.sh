#!/bin/sh
echo "Setting up local.swissdecode.com with your local IP"

dns=local.swissdecode.com
ip=`ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2`
existing_ip=`grep $dns /etc/hosts | awk '{print $1}'`

echo "IP: ${ip}"
if [ -z "${ip}" ]; then
  echo "Could not determine local IP"
elif [ ! "${existing_ip}" == "${ip}" ]; then
  echo "Need to update /etc/hosts. You'll be asked for the computer's sudo password"
  sudo sed -i '' "s/.*${dns}/${ip} ${dns}/" /etc/hosts
else
  echo "Setup already correct"
fi
