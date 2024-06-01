#! /bin/bash

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

execute_command sudo pacman -Sy pkgfile less firefox code
execute_command sudo pacman -Sy nvidia-dkms nvidia-open-dkms nvidia-utils lib32-nvidia-utils

# hyprland
execute_command sudo pacman -Sy arcolinux-hyprland-profile-git
execute_command sudo cp config_files/wrappedh1 /usr/local/bin

execute_command sudo cp config_files/hyprland.desktop /usr/share/wayland-sessions
execute_command sudo cp config_files/wrappedh1.desktop /usr/share/wayland-sessions

execute_command sudo cp config_files/nvidia.conf /etc/modprobe.d
execute_command sudo cp config_files/mkinitcpio.conf /etc
execute_command sudo mkinitcpio -P
execute_command sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img

execute_command cp config_files/* ~

