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
    read -p -n 1 -s "Do you want to execute this command? (y/n): " user_input
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


# mirrors
execute_command nano /etc/pacman.d/mirrorlist

# archo packages
execute_command pacstrap /mnt base base-devel linux linux-firmware nano vim dhcpcd

# fstab
execute_command genfstab -U -p /mnt >> /mnt/etc/fstab

cat /mnt/etc/fstab
wait_user

# system

execute_command arch-chroot /mnt
