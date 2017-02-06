#!/bin/bash
mkdir -p /home/Videos/TV_Shows
mkdir -p /home/Videos/Movies

/usr/bin/deluged
sleep 2
PASSWORD=$(cat /root/.config/deluge/auth | awk -F: '{print $2}')
USERNAME=$(cat /root/.config/deluge/auth | awk -F: '{print $1}')

/usr/sbin/minidlnad && sleep 3

sed "s@username_goes_here@$USERNAME@g" -i /root/.flexget/config.yml
sed "s@password_goes_here@$PASSWORD@g" -i /root/.flexget/config.yml

# Unexpected shutdowns causes .config-lock file to hang there and flexget daemon is unable to start
rm -rfv /root/.flexget/.config-lock

flexget daemon start &

/usr/bin/deluge-web 

