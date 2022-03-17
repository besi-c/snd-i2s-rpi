#!/bin/bash
# Install snd-i2s-rpi as dkms modules on raspberry pi

# Check if root
if [ $(id -u) -ne 0 ]; then
	echo "Script must be run as root"
	exit 1
fi

# Check system is raspbian
source /etc/os-release
if [[ $ID != "raspbian" ]]; then
	echo "System not raspbain, continue anyway?"
	while true; do
		read -p "[y/n] " c
		case $c in
			y|Y) break;;
			n|N) exit 0;;
			*) echo " invalid input"
		esac
	done
fi

apt-get -y install dkms raspberrypi-kernel-headers

dir=$(dirname $BASH_SOURCE)
cp -R $dir/snd-i2s_rpi/src /usr/src/snd-i2s_rpi-0.1.0

dkms add -m snd-i2s_rpi -v 0.1.0
dkms build -m snd-i2s_rpi -v 0.1.0
dkms install -m snd-i2s_rpi -v 0.1.0
