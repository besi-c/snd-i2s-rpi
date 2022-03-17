# I2S Mic Driver for Raspberry Pi
Configuration to build a DKMS Debian package for I2S mic driver


## Source
Source code taken from the `i2s_mic_module` directory of the [Adafruit Raspberry Pi Installer Scripts](https://github.com/adafruit/Raspberry-Pi-Installer-Scripts/tree/main/i2s_mic_module) project. This repository does not include a license, so I guess this use of the code is fine.


## Install
To install from source

	sudo ./install.sh


## Build Package
On a raspberry pi, install build dependencies

	sudo apt-get -y install devscripts debhelper dkms

Then enter package directory and build package

	cd snd-i2s-rpi
	debuild -uc -us


## Test
Check audio devices with

	arecord -l

Record audio with

	arecord -D plughw:0 -c1 -r 48000 -f S32_LE -t wav -V mono -v file.wav
