#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

kill -9 $(pgrep awdd.py)
systemctl --user stop awdd
systemctl --user disable awdd
rm ~/.config/systemd/user/awdd.service
systemctl --user daemon-reload
systemctl --user reset-failed
rm -rf /usr/local/sbin/awdd.sh
rm -rf /opt/arpWatchDogDaemon
