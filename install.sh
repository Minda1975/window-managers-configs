#!/bin/bash

# Install packages after installing base Debian with no GUI

#Tools
sudo apt install -y smartmontools lm-sensors htop p7zip p7zip-full zip unzip

# xorg display server installation and wm
sudo apt install -y xorg 

#Sound
sudo apt install -y alsa-utils

#Fluxbox
sudo apt install -y fluxbox

#Other stuff
sudo apt install -y termit xautolock dunst libnotify-bin i3lock-fancy

# File Manager (eg. pcmanfm,krusader)
sudo apt install -y emacs w3m mc clex gvfs gvfs-backends gvfs-fuse thunar thunar-volman

# Printing
sudo apt install -y cups system-config-printer

# Neofetch/HTOP
sudo apt install -y neofetch imagemagick caca-utils cmatrix

# Various utilities
sudo apt install -y scrot feh gnome-icon-theme gnome-themes-extra arc-theme gtk2-engines-oxygen gtk2-engines gtk2-engines-pixbuf gtk2-engines-murrine lxappearance

# Browser and Mail client Installation (eg. chromium)
sudo apt install -y firefox-esr qutebrowser

# Aditional packages
sudo apt install -y xpdf picom ufw firejail

# Install fonts
sudo apt install -y fonts-noto xfonts-terminus fonts-roboto

#Music and video packages
sudo apt install -y mpv sox libsox-fmt-all alsa-utils cmus moc qasmixer

#Torrents
sudo apt install -y aria2 

#Install drawnings packages
sudo apt install -y gimp

#Dev
sudo apt install -y autoconf build-essential curl texinfo

#Nvidia
sudo apt install -y linux-headers-amd64 

sudo apt install -y nvidia-tesla-470-driver

sudo apt autoremove

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"
