#!/bin/bash

#
# Init
#
rmdir --ignore-fail-on-non-empty   ~/Public/ Templates/
mkdir -p ~/Music ~/Documents ~/Videos ~/SC ~/Desktop ~/src ~/bin
cp blue/* ~

######################
### System
######################
sudo aptitude install -R sudo aptitude psmisc python3-pip python3-setuptools rfkill apt-file apt-show-versions htop strace 
pip3 install --upgrade setuptools wheel

######################
### Utils
######################
sudo aptitude install -R mc rsync byobu ranger wicd vim git gitk gitg
ranger --copy-config=all
# Optionals (but advised !)
# aptitude install -R apt-listbugs zip xclip acpi bmon nmap curl wget wireshark elinks w3m

######################
### Python Dev
######################
sudo aptitude install -R gfortran libopenblas-dev python3-tk
#sudo aptitude install -R build-essential autoconf libtool pkg-config  python3-dev cython
pip3 install --user ipython jupyter matplotlib numpy scipy

######################
### Apps
######################
#sudo aptitude install -R thunderbird gimp libreoffice # firefox midori
#sudo aptitude install pandoc parallel
#pip3 install --user pypandoc

######################
### Music (xmms2 plugin)
######################
sudo aptitude -R install vlc audacity xmms2 gxmms2 \
    xmms2-plugin-alsa xmms2-plugin-asf xmms2-plugin-avcodec xmms2-plugin-faad xmms2-plugin-flac xmms2-plugin-id3v2 xmms2-plugin-mad xmms2-plugin-mp4 xmms2-plugin-vorbis


######################
### Latex
######################
sudo aptitude install -R texlive texlive-latex-extra texlive-science texlive-fonts-extra texlive-latex-base texlive-extra-utils texlive-bibtex-extra texlive-plain-generic



######################
### Bluetooth
######################
sudo aptitude -R install pulseaudio-module-bluetooth blueman
pactl load-module module-bluetooth-discover


######################
### Web Server
######################
# @debug make webmain links...
echo "Installing nginx..."
# Kill apache ?
sudo aptitude install nginx 
sudo aptitude install php-fpm php php-cgi uwsgi
echo "need to set up con files for sites..."
P="/home/dtrckd/Desktop/workInProgress/conf/etc/nginx/sites-available/"
sudo cp $P/* /etc/nginx/sites-enabled/
sudo service nginx restart

# push apt-source and etc file.. ?
# Intall Mongo # gpg key, install, enable.
# Install Virtualbox qemu

#./install_from_scratch
