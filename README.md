# I2S Mic Driver for Raspberry Pi
Configuration to build a DKMS Debian package for I2S mic driver


## Source
Source code taken from the `i2s_mic_module` directory of the [Adafruit Raspberry Pi Installer Scripts](https://github.com/adafruit/Raspberry-Pi-Installer-Scripts/tree/main/i2s_mic_module) project. This repository does not include a license, so I guess this use of the code is fine.


## Build
On a raspberry pi, install dependencies:

	sudo apt-get -y install devscripts debhelper dkms

Then enter package directory and build package:

	cd snd-i2s-rpi-dkms-0.1.0
	debuild -uc -us
