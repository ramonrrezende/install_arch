#! /bin/bash
set -e

DISK_DEVICE="/dev/sda"

handle_error() {
    echo "Error: $1"
    cleanup
    exit 1
}

execute_command() {
    local confirm=$1
    shift
    echo "Running command: $*"
    if [ "$confirm" == "y" ]; then
        read -p "Do you want to execute this command? (y/n): " user_input
        if [ "$user_input" != "y" ]; then
            echo "Command skipped by user."
            return
        fi
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


# disk
execute_command fdisk -l

#bios boot 1G bios boot
#SWAP memory size linux swap
#/ 30G linux filesystem
#home linux filesystem


execute_command cfdisk $DISK_DEVICE



execute_command mkfs.fat -F32 "${DISK_DEVICE}1"

execute_command mkswap "${DISK_DEVICE}2"

execute_command mkfs.ext4 "${DISK_DEVICE}3"

execute_command mkfs.ext4 "${DISK_DEVICE}4"

#mount points
execute_command mount "${DISK_DEVICE}3" /mnt

#/home
execute_command mkdir /mnt/home

#/boot
execute_command mkdir /mnt/boot

#efi
execute_command mkdir /mnt/boot/efi

# mount home
execute_command mount "${DISK_DEVICE}4" /mnt/home

# mount boot
# mount "${DISK_DEVICE}1" /mnt/boot

# efi
execute_command mount "${DISK_DEVICE}1" /mnt/boot/efi

execute_command swapon "${DISK_DEVICE}2"

execute_command lsblk

wait_user