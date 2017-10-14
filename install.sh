#!/bin/sh
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

mkdir /opt/arpWatchDogDaemon
cp ./awdd.py /opt/arpWatchDogDaemon/
cp -R ./img /opt/arpWatchDogDaemon/
cp ./awdd.service /etc/systemd/system/
chmod 664 /etc/systemd/system/awdd.service
cp ./awdd.sh /usr/local/sbin/
chmod 744 /usr/local/sbin/awdd.sh
systemctl daemon-reload
systemctl enable awdd.service
systemctl start awdd.service
