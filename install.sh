#!/bin/bash

# Install packages after installing base Debian with no GUI

#Tools
sudo apt install -y smartmontools lm-sensors htop p7zip p7zip-full zip unzip

# xorg minimal
sudo apt install -y xserver-xorg-core

# xorg drivers

sudo apt install -y xserver-xorg-video-nouveau xserver-xorg-video-fbdev xserver-xorg-video-vesa

#Xorg input drivers
sudo apt install -y xserver-xorg-input-evdev

#Xorg misc
sudo apt install -y x11-xserver-utils x11-xkb-utils x11-utils xinit

#Sound
sudo apt install -y alsa-utils

#Window manager
sudo apt install -y notion

#Other stuff
sudo apt install -y xterm termit dunst libnotify-bin 

# File Manager (eg. pcmanfm,krusader)
sudo apt install -y emacs w3m mc clex gvfs gvfs-backends gvfs-fuse thunar thunar-volman

# Printing
sudo apt install -y cups system-config-printer

# Neofetch/HTOP
sudo apt install -y neofetch imagemagick caca-utils cmatrix fbcat

# Various utilities
sudo apt install -y scrot feh gnome-icon-theme gnome-themes-extra arc-theme gtk2-engines-oxygen gtk2-engines gtk2-engines-pixbuf gtk2-engines-murrine lxappearance

# Browser and Mail client Installation (eg. chromium)
sudo apt install -y firefox-esr qutebrowser

# Aditional packages
sudo apt install -y xpdf ufw firejail

# Install fonts
sudo apt install -y fonts-noto xfonts-terminus fonts-roboto

#Music and video packages
sudo apt install -y sox libsox-fmt-all pipewire-audio cmus moc pavucontrol xfburn

#Torrents
sudo apt install -y qbittorrent

#Install drawnings packages
sudo apt install -y gimp

#Dev
sudo apt install -y autoconf build-essential curl texinfo

sudo apt autoremove

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"
