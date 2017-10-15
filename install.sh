#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
mkdir -p /opt/arpWatchDogDaemon
cp ./awdd.py ./uninstall.sh ./awdd.sh /opt/arpWatchDogDaemon/
chmod 744 /opt/arpWatchDogDaemon/awdd.py /opt/arpWatchDogDaemon/uninstall.sh /opt/arpWatchDogDaemon/awdd.sh
cp -R ./img /opt/arpWatchDogDaemon/
