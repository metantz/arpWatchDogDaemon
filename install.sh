#!/bin/sh
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
mkdir -p /opt/arpWatchDogDaemon
cp ./awdd.py ./uninstall.sh /opt/arpWatchDogDaemon/
chmod 744 /opt/arpWatchDogDaemon/awdd.py /opt/arpWatchDogDaemon/uninstall.sh
cp -R ./img /opt/arpWatchDogDaemon/
cp ./awdd.sh /usr/local/sbin/
chmod 744 /usr/local/sbin/awdd.sh
mkdir -p ~/.config/systemd/user/
cp ./awdd.service ~/.config/systemd/user/
chmod 664 ~/.config/systemd/user/awdd.service 
systemctl --user daemon-reload
systemctl --user enable awdd
loginctl enable-linger
systemctl --user start awdd
