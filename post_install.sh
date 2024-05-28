#! /bin/bash

handle_error() {
    echo "Error: $1"
    cleanup
    exit 1
}

execute_command() {
    echo "Running command: $*"
    echo ""
    read -p -s "Do you want to execute this command? (y/n): " user_input
    echo $user_input
    if [ "$user_input" != "y" ]; then
        echo "Command skipped by user."
        return
    fi
    "$@"
    if [ $? -ne 0 ]; then
        handle_error "Command '$*' failed"
    fi
}

wait_user() {
    echo -e 'press any key to continue...\n'
    read -n 1 -s -r
}


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