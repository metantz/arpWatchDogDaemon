#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

kill -9 $(pgrep awdd.py)
rm -rf /opt/arpWatchDogDaemon
kill -9 $(pgrep awdd.sh)
rm /etc/profile.d/awdd.sh
