#!/bin/bash
#
# This script must run in the root of the project to protect

if [ x"$1" == x ]; then

        echo "please specify the name of the user: example lcozzuto"

        exit 1

fi

root="/var/www/html/public-docs/biocore/projects"
cwd=`pwd | awk -F'/' '{print $NF}'`

echo "AuthType Basic
AuthName \"Restricted Access\"
AuthUserFile $root/$cwd/.htpasswd
Require user $1
" > .htaccess 

passwd=`echo $RANDOM | base64`
htpasswd -cb .htpasswd $1 $passwd

echo "The password is "$passwd
