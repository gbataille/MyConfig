#!/bin/ksh
name=$1

if [ '$name' = '' ]
	then
	name='Greg'
fi

echo -n -e "\033]0;$name\007"
