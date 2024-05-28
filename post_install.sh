#! /bin/bash

KEYBOARD="br-abnt2"
HOST_NAME="san"
USER_NAME="ison"


handle_error() {
    echo "Error: $1"
    cleanup
    exit 1
}

execute_command() {
    echo "Running command: $*"
    echo ""
    read -p "Do you want to execute this command? (y/n): " user_input
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


# hostname
execute_command hostnamectl set-hostname $HOST_NAME
execute_command passwd

echo "uncoment line %wheel ALL=(ALL:ALL) ALL"
# su -
# EDITOR=nano visudo

# sudo dhcpcd

# graphic interface
execute_command sudo pacman -S xorg-server xorg-xinit xorg-apps mesa

# drivers
# sudo pacman -S xf86-video-intel
execute_command sudo pacman -S nvidia nvidia-settings
# sudo pacman -S xf86-video-amdgpu


# desktop environment
execute_command pacman -S firefox #browser
execute_command pacman -S dolphin #file manager
execute_command pacman -S wofi #application starter
execute_command pacman -S hyprpaper #application starter
execute_command pacman -S alacritty #terminal emulator

execute_command pacman -S gnome-extra gnome-terminal
execute_command pacman -S deepin deepin-extra
execute_command pacman -S bungie-desktop
execute_command pacman -S i3-wm i3status i3lock i3-gaps dmenu termite dunst
execute_command pacman -S hyprland hyprland-git


execute_command cp config_files/scripts/* ~