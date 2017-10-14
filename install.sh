#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
mkdir /opt/arpWatchDogDaemon
cp ./awdd.py /opt/arpWatchDogDaemon/
chmod 744 /opt/arpWatchDogDaemon/awdd.py
cp ./uninstall.sh /opt/arpWatchDogDaemon/
chmod 744 /opt/arpWatchDogDaemon/uninstall.sh
cp -R ./img /opt/arpWatchDogDaemon/
cp ./awdd.sh /etc/profile.d
chmod 744 /etc/profile.d/awdd.sh
/etc/profile.d/awdd.sh &
