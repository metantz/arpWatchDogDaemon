#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

kill -9 $(pgrep awdd.py)
systemctl stop awdd
systemctl disable awdd
rm /etc/systemd/system/awdd.system
systemctl daemon-reload
systemctl reset-failed
rm -rf /opt/arpWatchDogDaemon
