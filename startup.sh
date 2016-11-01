#!/bin/bash
/usr/bin/deluged
sleep 2
PASSWORD=$(cat /root/.config/deluge/auth | awk -F: '{print $2}')
USERNAME=$(cat /root/.config/deluge/auth | awk -F: '{print $1}')

/usr/sbin/minidlnad && sleep 3

sed "s@username_goes_here@$USERNAME@g" -i /root/.flexget/config.yml
sed "s@password_goes_here@$PASSWORD@g" -i /root/.flexget/config.yml

flexget daemon start &

/usr/bin/deluge-web 

