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

# Install required packages
apt-get -y install dkms raspberrypi-kernel-headers

# Copy source code to system source location
dir=$(dirname $BASH_SOURCE)
cp -R $dir/snd-i2s_rpi/src /usr/src/snd-i2s_rpi-0.1.0

# Install DKMS module
dkms add -m snd-i2s_rpi -v 0.1.0
dkms build -m snd-i2s_rpi -v 0.1.0
dkms install -m snd-i2s_rpi -v 0.1.0

# Query enabling kernel module
echo "Enable automatic loading of kernel module?"
while true; do
	read -p "[y/n] " c
	case $c in
		y|Y) break;;
		n|N) exit 0;;
		*) echo " invalid input"
	esac
done

# Enable loading of kernel module
echo "snd-i2smic-rpi" > /etc/modules-load.d/snd-i2smic-rpi.conf

# Configure module on RasPi Zero only
if [[ $(lscpu) =~ 'ARM1176' ]]; then
	echo "options snd-i2smic-rpi rpi_platform_generation=0" >> /etc/modprobe.d/snd-i2smic-rpi.conf
fi
