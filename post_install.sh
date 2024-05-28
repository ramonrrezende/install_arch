#! /bin/bash


su -

echo "uncoment line %wheel ALL=(ALL:ALL) ALL"

# graphic interface
sudo pacman -S xorg-server xorg-xinit xorg-apps mesa

# drivers
# sudo pacman -S xf86-video-intel
sudo pacman -S nvidia nvidia-settings
# sudo pacman -S xf86-video-amdgpu


# desktop environment
pacman -S firefox #browser
pacman -S dolphin #file manager
pacman -S wofi #application starter
pacman -S hyprpaper #application starter
pacman -S alacritty #terminal emulator

pacman -S gnome-extra gnome-terminal
pacman -S deepin deepin-extra
pacman -S bungie-desktop
pacman -S i3-wm i3status i3lock i3-gaps dmenu termite dunst
pacman -S hyprland hyprland-git


cp config_files/scripts/* ~